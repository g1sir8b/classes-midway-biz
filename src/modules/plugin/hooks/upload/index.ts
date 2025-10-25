import { BaseUpload, MODETYPE } from './interface';
import { BasePluginHook } from '../base';
import * as fs from 'fs';
import * as path from 'path';
import * as moment from 'moment';
import { v1 as uuid } from 'uuid';
import { CoolCommException } from '@cool-midway/core';
import * as _ from 'lodash';
import { pUploadPath } from '../../../../comm/path';
import axios from 'axios';

/**
 * 文件上传
 */
export class CoolPlugin extends BasePluginHook implements BaseUpload {
  /**
   * 获得上传模式
   * @returns
   */
  async getMode() {
    return {
      mode: MODETYPE.LOCAL,
      type: MODETYPE.LOCAL,
    };
  }

  /**
   * 获得原始操作对象
   * @returns
   */
  async getMetaFileObj() {
    return;
  }

  /**
   * 下载并上传
   * @param url
   * @param fileName
   */
  async downAndUpload(url: string, fileName?: string) {
    const { domain } = this.pluginInfo.config;
    // 从url获取扩展名
    const extend = path.extname(url);
    const download = require('download');
    // 数据
    const data = url.includes('http')
      ? await download(url)
      : fs.readFileSync(url);
    // 创建文件夹
    const dirPath = path.join(pUploadPath(), `${moment().format('YYYYMMDD')}`);
    if (!fs.existsSync(dirPath)) {
      fs.mkdirSync(dirPath, { recursive: true });
    }
    const uuidStr = uuid();
    const name = `${moment().format('YYYYMMDD')}/${
      fileName ? fileName : uuidStr + extend
    }`;
    fs.writeFileSync(
      `${dirPath}/${fileName ? fileName : uuid() + extend}`,
      data
    );
    return `${domain}/upload/${name}`;
  }

  /**
   * 指定Key(路径)上传，本地文件上传到存储服务
   * @param filePath 文件路径
   * @param key 路径一致会覆盖源文件
   */
  async uploadWithKey(filePath: any, key: any) {
    const { domain } = this.pluginInfo.config;
    const data = fs.readFileSync(filePath);
    fs.writeFileSync(path.join(this.app.getBaseDir(), '..', key), data);
    return domain + key;
  }

  async updateAlist(path: string) {
    const { alist } = this.pluginInfo.config;
    const { url, token } = alist;
    const header = {
      Authorization: token,
      'Content-Type': 'application/json',
    };
    const response = await axios.put(
      `${url}/api/fs/list`,
      {
        path: path,
        password: '',
        page: 1,
        per_page: 0,
        refresh: true,
      },
      {
        headers: header,
      }
    );
  }

  async uploadToAlist(filePath: any, ctx: any) {
    const { alist } = this.pluginInfo.config;
    const { url, token } = alist;

    try {
      // 从ctx中获取文件
      const file = ctx.files[0];
      if (!file) {
        throw new CoolCommException('上传文件为空');
      }

      // 读取文件数据
      const fileData = fs.readFileSync(file.data);

      // 准备请求头
      const headers = {
        Authorization: token,
        'Content-Type': 'multipart/form-data',
        'Content-Length': fileData.length.toString(),
        'File-Path': encodeURIComponent(filePath),
        'As-Task': 'false',
      };

      // 创建FormData
      const formData = new FormData();
      const filename = filePath.split('/').pop();
      //filePath去除 filename
      const path = filePath.split(filename)[0];
      const blob = new Blob([fileData], { type: file.mimeType });
      formData.append('file', blob, filename);

      // 发送PUT请求
      const response = await axios.put(`${url}/api/fs/form`, formData, {
        headers: headers,
        maxContentLength: Infinity,
        maxBodyLength: Infinity,
      });

      await this.updateAlist(path);
      return filePath;
    } catch (error) {
      console.error('Upload to Alist failed:', error);
      throw new CoolCommException('上传到Alist失败: ' + error.message);
    }
  }

  /**
   * 上传文件
   * @param ctx
   * @param key 文件路径
   */
  async upload(ctx: any) {
    const { domain } = this.pluginInfo.config;
    try {
      const { key } = ctx.fields;
      if (
        key &&
        (key.includes('..') ||
          key.includes('./') ||
          key.includes('\\') ||
          key.includes('//'))
      ) {
        throw new CoolCommException('非法的key值');
      }
      if (_.isEmpty(ctx.files)) {
        throw new CoolCommException('上传文件为空');
      }
      const basePath = pUploadPath();

      const file = ctx.files[0];
      const extension = file.filename.split('.').pop();
      const name =
        moment().format('YYYYMMDD') + '/' + (key || `${uuid()}.${extension}`);
      const target = path.join(basePath, name);
      const dirPath = path.join(basePath, moment().format('YYYYMMDD'));
      if (!fs.existsSync(dirPath)) {
        fs.mkdirSync(dirPath);
      }
      const data = fs.readFileSync(file.data);
      fs.writeFileSync(target, data);
      const alistPath = '/oss/upload/' + name;

      return await this.uploadToAlist(alistPath, ctx);
    } catch (err) {
      console.error(err);
      throw new CoolCommException('上传失败' + err.message);
    }
  }
}

// 导出插件实例， Plugin名称不可修改
export const Plugin = CoolPlugin;

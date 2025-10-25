import {
  BaseController as CoolBaseController,
  CoolCommException,
} from '@cool-midway/core';
import { Config } from '@midwayjs/core';
import { sm4 } from 'sm-crypto-v2';

export class BaseController extends CoolBaseController {
  @Config('encrypt')
  encrypt: {
    enable: boolean;
    key: string;
    ignoreUrls: string[];
  };

  constructor() {
    super();
  }

  /**
   * 成功返回
   * @param data 返回数据
   */
  ok(data?: any) {
    const result = super.ok(data);
    const currentUrl = this.baseCtx.request.url;

    // 检查是否在忽略列表中
    const shouldIgnore = this.encrypt.ignoreUrls.some(ignoreUrl => {
      // 精确匹配
      if (currentUrl.split('?')[0] === ignoreUrl) return true;
      // 通配符匹配
      if (ignoreUrl.includes('*')) {
        const pattern = ignoreUrl.replace(/\*/g, '.*');
        return new RegExp(pattern).test(currentUrl);
      }
    });

    if (
      this.encrypt.enable &&
      Object.keys(result).includes('data') &&
      !shouldIgnore
    ) {
      // 从baseCtx中获取动态加密key
      const sm4Key = this.baseCtx.sm4Key;

      // 强制要求前端提供动态加密key
      if (!sm4Key) {
        throw new CoolCommException('请求数据异常', 400);
      }

      try {
        result['data'] = this.encryptData(result['data'], sm4Key as string);
      } catch (error) {
        // 如果加密失败，记录错误并抛出异常
        console.error('Encryption failed:', error);
        throw new CoolCommException(`Encryption failed: ${error.message}`, 400);
      }
    }
    return result;
  }

  // 解密函数（模拟前端）
  decryptData(encryptedData, key: string) {
    try {
      // 使用SM4解密（ECB模式，不使用IV）
      const decrypted = sm4.decrypt(encryptedData, key, {
        mode: 'ecb',
        output: 'string',
      });

      // 检查解密后的字符串是否为空或无效
      if (!decrypted || decrypted.trim() === '') {
        throw new Error('Decrypted data is empty or invalid');
      }

      try {
        return JSON.parse(decrypted);
      } catch {
        return decrypted;
      }
    } catch (error) {
      console.error('SM4解密失败:', error);
      throw error;
    }
  }

  /**
   * 加密数据
   * @param data 要加密的数据
   * @param key 动态加密key
   * @returns 加密后的字符串
   */
  encryptData(data: any, key: string) {
    // 验证key格式
    if (!key || key.trim() === '') {
      throw new CoolCommException('Invalid key format', 400);
    }

    // 处理不同类型的数据
    let dataToEncrypt: string;

    if (data === null || data === undefined) {
      dataToEncrypt = JSON.stringify(null);
    } else if (typeof data === 'string') {
      // 字符串直接加密
      dataToEncrypt = data;
    } else if (typeof data === 'number') {
      // 数字转换为字符串
      dataToEncrypt = data.toString();
    } else if (typeof data === 'boolean') {
      // 布尔值转换为字符串
      dataToEncrypt = data.toString();
    } else if (Array.isArray(data)) {
      // 数组使用JSON序列化
      dataToEncrypt = JSON.stringify(data);
    } else if (typeof data === 'object') {
      // 对象使用JSON序列化
      dataToEncrypt = JSON.stringify(data);
    } else {
      // 其他类型转换为字符串
      dataToEncrypt = String(data);
    }

    try {
      // 使用SM4加密（ECB模式，不使用IV）
      const encrypted = sm4.encrypt(dataToEncrypt, key, {
        mode: 'ecb',
        output: 'string',
      });

      return encrypted;
    } catch (error) {
      console.error('SM4加密失败:', error);
      throw new CoolCommException(`SM4加密失败: ${error.message}`, 400);
    }
  }
}

import { Provide, Inject, Get, Post, Query, Config } from '@midwayjs/core';
import {
  CoolController,
  CoolEps,
  TagTypes,
  CoolUrlTag,
  CoolTag,
} from '@cool-midway/core';
import { Context } from '@midwayjs/koa';
import { BaseSysParamService } from '../../service/sys/param';
import { PluginService } from '../../../plugin/service/info';
import { BaseController } from '../base';

/**
 * 不需要登录的后台接口
 */
@CoolUrlTag()
@Provide()
@CoolController()
export class SiteBaseAppCommController extends BaseController {
  @Inject()
  pluginService: PluginService;

  @Inject()
  ctx: Context;

  @Config('module.base.allowKeys')
  allowKeys: string[];

  @Inject()
  eps: CoolEps;

  @Inject()
  baseSysParamService: BaseSysParamService;

  /**
   * 文件上传
   */
  @Post('/upload', { summary: '文件上传' })
  async upload() {
    const file = await this.pluginService.getInstance('upload');
    return this.ok(await file.upload(this.ctx));
  }
}

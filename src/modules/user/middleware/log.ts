import { ALL, Config, Middleware } from '@midwayjs/core';
import { NextFunction, Context } from '@midwayjs/koa';
import { IMiddleware, Init, Inject } from '@midwayjs/core';
import { CoolCommException, CoolUrlTagData, TagTypes } from '@cool-midway/core';
import { UserRequestLogService } from '../service/log';
import { UserComputerService } from '../service/computer';
import * as _ from 'lodash';
import * as jwt from 'jsonwebtoken';

@Middleware()
export class UserLogMiddleware implements IMiddleware<Context, NextFunction> {
  @Config('module.user.version')
  version: string;

  @Inject()
  userRequestLogService: UserRequestLogService;

  @Inject()
  userComputerService: UserComputerService;

  @Inject()
  coolUrlTagData: CoolUrlTagData;

  ignoreUrls: string[] = [];

  @Config('module.user.jwt')
  jwtConfig;

  @Init()
  async init() {
    this.ignoreUrls = this.coolUrlTagData.byKey(TagTypes.IGNORE_TOKEN, 'app');
  }

  resolve() {
    return async (ctx: Context, next: NextFunction) => {
      let { url } = ctx;
      if (_.startsWith(url, '/app/')) {
        if (
          this.ignoreUrls.includes(url) ||
          _.startsWith(url, '/app/user/login/activate')
        ) {
          await next();
          return;
        }

        const version = ctx.get('X-Version');
        const computerId = ctx.get('X-Computer-Id');
        const ip = ctx.get('X-Client-Ip');
        const tenantId = Number(ctx.get('X-Tenant-Id'));
        const token = ctx.get('Authorization');
        let user: any;
        try {
          user = jwt.verify(token, this.jwtConfig.secret);
        } catch (error) {}
        if (!user) {
          throw new CoolCommException('登录失效~', 401);
        }

        if (version !== this.version) {
          return (ctx.body = {
            code: 1001,
            message: '版本更新，请重新下载新版客户端~',
          });
        }

        if (!computerId || !ip || !tenantId || !version) {
          throw new CoolCommException('数据或行为异常~', 400);
        }

        const isEndLogin = await this.userComputerService.isEndLogin(
          user.id,
          tenantId,
          computerId
        );

        if (!isEndLogin) {
          return (ctx.body = {
            code: 401,
            message: '登录失效~',
          });
        }

        await this.userRequestLogService.createLog({
          userId: user.id,
          computerId,
          url,
          suspiciousOperation: '请求接口',
          suspiciousOperationIp: ip,
          type: 0,
          tenantId,
          ip,
        });
      }
      await next();
    };
  }
}

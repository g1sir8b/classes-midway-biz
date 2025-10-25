import {
  CoolController,
  CoolUrlTag,
  TagTypes,
  CoolTag,
} from '@cool-midway/core';
import { Body, Get, Inject, Param, Post, Query } from '@midwayjs/core';
import { UserLoginService } from '../../service/login';
import { BaseSysLoginService } from '../../../base/service/sys/login';
import { BaseController } from '../../../base/controller/base';

/**
 * 登录
 */
@CoolUrlTag()
@CoolController()
export class SiteUserLoginController extends BaseController {
  @Inject()
  userLoginService: UserLoginService;

  @Inject()
  baseSysLoginService: BaseSysLoginService;

  @CoolTag(TagTypes.IGNORE_TOKEN)
  @Post('/refreshToken', { summary: '刷新token' })
  public async refreshToken(@Body('refreshToken') refreshToken) {
    return this.ok(await this.userLoginService.refreshToken(refreshToken));
  }

  @CoolTag(TagTypes.IGNORE_TOKEN)
  @Post('/register', { summary: '注册' })
  async register(
    @Body('email') email: string,
    @Body('code') code: string,
    @Body('password') password: string,
    @Body('confirmPassword') confirmPassword: string,
    @Body('nickName') nickName: string
  ) {
    return this.ok(
      await this.userLoginService.register(
        email,
        code,
        password,
        confirmPassword,
        nickName
      )
    );
  }

  @CoolTag(TagTypes.IGNORE_TOKEN)
  @Post('/sendEmailRegisterCode', { summary: '发送邮箱注册验证码' })
  async sendEmailRegisterCode(@Body('email') email: string) {
    return this.ok(await this.userLoginService.sendEmailRegisterCode(email));
  }

  @CoolTag(TagTypes.IGNORE_TOKEN)
  @Post('/emailLogin', { summary: '邮箱登录' })
  async emailLogin(
    @Body('email') email: string,
    @Body('password') password: string
  ) {
    return this.ok(await this.userLoginService.siteEmailLogin(email, password));
  }

  @CoolTag(TagTypes.IGNORE_TOKEN)
  @Post('/findPasswordCode', { summary: '找回密码验证码发送' })
  async findPasswordCode(@Body('email') email: string) {
    return this.ok(await this.userLoginService.findPasswordCode(email));
  }

  @CoolTag(TagTypes.IGNORE_TOKEN)
  @Post('/findPassword', { summary: '找回密码' })
  async findPassword(@Body('email') email: string, @Body('code') code: string, @Body('password') password: string, @Body('confirmPassword') confirmPassword: string) {
    return this.ok(await this.userLoginService.findPassword(email, code, password, confirmPassword));
  }
}

import { CoolController } from '@cool-midway/core';
import { Body, Get, Inject, Post } from '@midwayjs/core';
import { UserInfoService } from '../../service/info';
import { UserInfoEntity } from '../../entity/info';
import { UserComputerService } from '../../service/computer';
import { BaseController } from '../../../base/controller/base';

/**
 * 用户信息
 */
@CoolController({
  api: [],
  entity: UserInfoEntity,
})
export class SiteUserInfoController extends BaseController {
  @Inject()
  ctx;

  @Inject()
  userInfoService: UserInfoService;

  @Inject()
  userComputerService: UserComputerService;

  @Get('/person', { summary: '获取用户信息' })
  async person() {
    return this.ok(await this.userInfoService.person(this.ctx.user.id));
  }

  @Post('/updatePerson', { summary: '更新用户信息' })
  async updatePerson(@Body() body) {
    return this.ok(
      await this.userInfoService.updatePerson(this.ctx.user.id, body)
    );
  }

  @Post('/updatePassword', { summary: '更新用户密码' })
  async updatePassword(
    @Body('password') password: string,
    @Body('code') code: string
  ) {
    await this.userInfoService.updatePassword(this.ctx.user.id, password, code);
    return this.ok();
  }

  @Post('/logoff', { summary: '注销' })
  async logoff() {
    await this.userInfoService.logoff(this.ctx.user.id);
    return this.ok();
  }

  // 修改密码
  @Post('/changePassword', { summary: '修改密码' })
  async changePassword(@Body('oldPassword') oldPassword: string, @Body('newPassword') newPassword: string, @Body('confirmPassword') confirmPassword: string ) {
    return this.ok(await this.userInfoService.changePassword(this.ctx.user.id, oldPassword, newPassword, confirmPassword));
  }

  @Post('/sendUpdateEmailCode', { summary: '发送修改邮箱地址时的验证码' })
  async sendUpdateEmailCode(@Body('email') email: string) {
    return this.ok(await this.userInfoService.sendUpdateEmailCode(this.ctx.user.id, email));
  }

  @Post('/updateEmail', { summary: '修改邮箱地址' })
  async updateEmail(@Body('code') code: string, @Body('email') email: string) {
    return this.ok(await this.userInfoService.updateEmail(this.ctx.user.id, code, email));
  }
}

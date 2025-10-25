import { Provide, Body, Inject, Post, Get, Query } from '@midwayjs/core';
import {
  CoolController,
  CoolEps,
  CoolUrlTag,
  CoolTag,
  TagTypes,
  RESCODE,
} from '@cool-midway/core';
import { LoginDTO } from '../../dto/login';
import { BaseSysLoginService } from '../../service/sys/login';
import { BaseSysParamService } from '../../service/sys/param';
import { Context } from '@midwayjs/koa';
import { Validate } from '@midwayjs/validate';
import { BaseSysTenantService } from '../../service/sys/tenant';
import { RegisterTenantDTO } from '../../dto/register_tenant';
import { BaseSysTenantRegisterService } from '../../service/sys/tenant_register';
import { SetupTenantAdminDTO } from '../../dto/setup_tenant_admin';
import { BaseSysUserService } from '../../service/sys/user';
import { BaseController } from '../base';
/**
 * 不需要登录的后台接口
 */
@Provide()
@CoolController({ description: '开放接口' })
@CoolUrlTag()
export class BaseOpenController extends BaseController {
  @Inject()
  baseSysLoginService: BaseSysLoginService;

  @Inject()
  baseSysParamService: BaseSysParamService;

  @Inject()
  baseSysTenantService: BaseSysTenantService;

  @Inject()
  baseSysTenantRegisterService: BaseSysTenantRegisterService;

  @Inject()
  baseSysUserService: BaseSysUserService;

  @Inject()
  ctx: Context;

  @Inject()
  eps: CoolEps;

  /**
   * 实体信息与路径
   * @returns
   */
  @CoolTag(TagTypes.IGNORE_TOKEN)
  @Get('/eps', { summary: '实体信息与路径' })
  public async getEps() {
    return this.ok(this.eps.admin);
  }

  /**
   * 根据配置参数key获得网页内容(富文本)
   */
  @CoolTag(TagTypes.IGNORE_TOKEN)
  @Get('/html', { summary: '获得网页内容的参数值' })
  async htmlByKey(@Query('key') key: string) {
    this.ctx.body = await this.baseSysParamService.htmlByKey(key);
  }

  /**
   * 登录
   * @param login
   */
  @CoolTag(TagTypes.IGNORE_TOKEN)
  @Post('/login', { summary: '登录' })
  @Validate()
  async login(@Body() login: LoginDTO) {
    return this.ok(await this.baseSysLoginService.login(login));
  }

  /**
   * 获得验证码
   */
  @CoolTag(TagTypes.IGNORE_TOKEN)
  @Get('/captcha', { summary: '验证码' })
  async captcha(
    @Query('width') width: number,
    @Query('height') height: number,
    @Query('color') color: string
  ) {
    return this.ok(
      await this.baseSysLoginService.captcha(width, height, color)
    );
  }

  /**
   * 刷新token
   */
  @CoolTag(TagTypes.IGNORE_TOKEN)
  @Get('/refreshToken', { summary: '刷新token' })
  async refreshToken(@Query('refreshToken') refreshToken: string) {
    try {
      const token = await this.baseSysLoginService.refreshToken(refreshToken);
      return this.ok(token);
    } catch (e) {
      this.ctx.status = 401;
      this.ctx.body = {
        code: RESCODE.COMMFAIL,
        message: '登录失效~',
      };
    }
  }

  /**
   * 申请注册租户
   */
  @CoolTag(TagTypes.IGNORE_TOKEN)
  @Post('/registerTenant', { summary: '申请注册租户' })
  async registerTenant(@Body() registerTenant: RegisterTenantDTO) {
    return this.ok(
      await this.baseSysTenantRegisterService.registerTenant(registerTenant)
    );
  }

  /**
   * 初始化租户，添加管理员账号密码等
   */
  @CoolTag(TagTypes.IGNORE_TOKEN)
  @Post('/initTenant', { summary: '初始化租户' })
  async initTenant(@Body() initTenant: SetupTenantAdminDTO) {
    await this.baseSysTenantService.initTenant(initTenant);
    return this.ok();
  }
}

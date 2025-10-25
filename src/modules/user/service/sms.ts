import { Provide, Config, Inject, Init, InjectClient } from '@midwayjs/core';
import { BaseService, CoolCommException } from '@cool-midway/core';
import * as _ from 'lodash';
import { CachingFactory, MidwayCache } from '@midwayjs/cache-manager';
import { PluginService } from '../../plugin/service/info';
import { EmailService } from '../../base/service/sys/email';
/**
 * 描述
 */
@Provide()
export class UserSmsService extends BaseService {
  // 获得模块的配置信息
  @Config('module.user.sms')
  config;

  @Inject()
  ctx;

  @InjectClient(CachingFactory, 'default')
  midwayCache: MidwayCache;

  @Inject()
  pluginService: PluginService;

  @Inject()
  emailService: EmailService;

  plugin;

  @Init()
  async init() {
    for (const key of ['sms-tx', 'sms-ali']) {
      try {
        this.plugin = await this.pluginService.getInstance(key);
        if (this.plugin) {
          this.config.pluginKey = key;
          break;
        }
      } catch (e) {
        continue;
      }
    }
  }

  /**
   * 发送验证码
   * @param phone
   */
  async sendSms(phone) {
    // 随机四位验证码
    const code = _.random(1000, 9999);
    const pluginKey = this.config.pluginKey;
    if (!this.plugin)
      throw new CoolCommException(
        '未配置短信插件，请到插件市场下载安装配置：https://cool-js.com/plugin?keyWord=短信'
      );
    try {
      if (pluginKey == 'sms-tx') {
        await this.plugin.send([phone], [code]);
      }
      if (pluginKey == 'sms-ali') {
        await this.plugin.send([phone], {
          code,
        });
      }
      this.midwayCache.set(`sms:${phone}`, code, this.config.timeout * 1000);
    } catch (error) {
      throw new CoolCommException('发送过于频繁，请稍后再试');
    }
  }

  /**
   * 发送找回密码验证码
   * @param email
   * @param tenantId
   */
  async sendFindPasswordCode(email, tenantId) {
    const cacheCode = await this.midwayCache.get(
      `tenant:${tenantId}:findPassword:email:${email}`
    );
    if (cacheCode) {
      const emailContent = `
      您好！
      
      您正在找回密码，请使用以下验证码：

      ${cacheCode}
      
      致敬`;
      await this.emailService.sendEmail(email, '找回密码验证码', emailContent);
      return;
    }

    // 随机四位验证码
    const code = _.random(1000, 9999);
    this.midwayCache.set(
      `tenant:${tenantId}:findPassword:email:${email}`,
      code,
      this.config.timeout * 1000
    );

    const emailContent = `
      您好！
      
      您正在找回密码，请使用以下验证码：

      ${code}
      
      致敬`;

    await this.emailService.sendEmail(email, '找回密码验证码', emailContent);
  }

  /**
   * 验证找回密码验证码
   * @param email
   * @param code
   * @returns
   */
  async checkFindPasswordCode(email, code, tenantId) {
    const cacheCode = await this.midwayCache.get(
      `tenant:${tenantId}:findPassword:email:${email}`
    );
    if (code && cacheCode == code) {
      await this.midwayCache.del(`tenant:${tenantId}:findPassword:email:${email}`);
      return true;
    }
    return false;
  }

  /**
   * 发送注册验证码
   * @param email
   */
  async sendEmailCode(email, tenantId) {
    // 检查是否已经有该邮箱的验证码缓存
    const existingCode = await this.midwayCache.get(
      `tenant:${tenantId}:email:${email}`
    );
    
    if (existingCode) {
      // 如果已有缓存，直接使用现有的code重新发送邮件
      const code = existingCode;
      const emailContent = `
        您好！
        <br/>
        以下是您注册的验证码：
        <br/>
        ${code}
        <br/>
        如果您未注册账号，请忽略此邮件。<br/>
        请不要将此验证码分享给他人。<br/>
        60秒内有效<br/>
        
        致敬`;

      await this.emailService.sendEmail(email, 'E-mail验证', emailContent);
      return code;
    }

    // 如果没有缓存，生成新的验证码
    const code = String(_.random(1000, 9999));
    
    // 设置验证码缓存
    this.midwayCache.set(
      `tenant:${tenantId}:email:${email}`,
      code,
      this.config.timeout * 1000
    );

    const emailContent = `
      您好！
      
      以下是您注册的验证码：
      <br/>
      ${code}
      <br/>
      如果您未注册账号，请忽略此邮件。<br/>
      请不要将此验证码分享给他人。<br/>
      60秒内有效<br/>
      
      致敬`;

    await this.emailService.sendEmail(email, 'E-mail注册验证码', emailContent);
    return code;
  }

  /**
   * 验证注册验证码
   * @param email
   * @param code
   * @returns
   */
  async checkEmailCode(email, tenantId) {
    const code = await this.midwayCache.get(
      `tenant:${tenantId}:email:${email}`
    );
    if (code) {
      await this.midwayCache.del(`tenant:${tenantId}:email:${email}`);
      return code;
    }
    return false;
  }

  /**
   * 验证验证码
   * @param phone
   * @param code
   * @returns
   */
  async checkCode(phone, code) {
    const cacheCode = await this.midwayCache.get(`sms:${phone}`);
    if (code && cacheCode == code) {
      return true;
    }
    return false;
  }

  /**
   * 发送修改用户邮箱地址时的验证码
   * @param email
   * @returns
   */
  async sendUpdateEmailCode(userId, newEmail, tenantId) {
    const existingCode = await this.midwayCache.get(
      `tenant:${tenantId}:updateEmail:${newEmail}:userId:${userId}`
    );
    if (existingCode) {
      const code = existingCode;
      const emailContent = `
        您好！
        <br/>
        以下是您修改邮箱地址的验证码：
        <br/>
        ${code}
        <br/>
        如果您未修改邮箱地址，请注意账户安全。<br/>
        请不要将此验证码分享给他人。<br/>
        60秒内有效<br/>
        
        致敬`;
      await this.emailService.sendEmail(newEmail, '修改邮箱地址验证码', emailContent);
      return code;
    }
    const code = String(_.random(1000, 9999));
    this.midwayCache.set(`tenant:${tenantId}:updateEmail:${newEmail}:userId:${userId}`, code, this.config.timeout * 1000);
    const emailContent = `
        您好！
        <br/>
        以下是您修改邮箱地址的验证码：
        <br/>
        ${code}
        <br/>
        如果您未修改邮箱地址，请注意账户安全。<br/>
        请不要将此验证码分享给他人。<br/>
        60秒内有效<br/>
        
        致敬`;
    await this.emailService.sendEmail(newEmail, '修改邮箱地址验证码', emailContent);
    return code;
  }

  /**
   * 验证修改用户邮箱地址时的验证码
   * @param email
   * @param code
   * @returns
   */
  async checkUpdateEmailCode(userId, newEmail, code, tenantId) {
    const cacheCode = await this.midwayCache.get(`tenant:${tenantId}:updateEmail:${newEmail}:userId:${userId}`);
    if (code && cacheCode == code) {
      await this.midwayCache.del(`tenant:${tenantId}:updateEmail:${newEmail}:userId:${userId}`);
      return true;
    }
    return false;
  }
}

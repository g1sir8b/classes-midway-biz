import { Config, Inject, Provide } from '@midwayjs/core';
import { BaseService, CoolCommException } from '@cool-midway/core';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { Equal, Repository } from 'typeorm';
import { UserInfoEntity } from '../entity/info';
import { UserWxService } from './wx';
import * as jwt from 'jsonwebtoken';
import { UserWxEntity } from '../entity/wx';
import { BaseSysLoginService } from '../../base/service/sys/login';
import { UserSmsService } from './sms';
import { v1 as uuid } from 'uuid';
import * as md5 from 'md5';
import { PluginService } from '../../plugin/service/info';
import { UserComputerEntity } from '../entity/computer';

/**
 * 登录
 */
@Provide()
export class UserLoginService extends BaseService {
  @InjectEntityModel(UserInfoEntity)
  userInfoEntity: Repository<UserInfoEntity>;

  @InjectEntityModel(UserWxEntity)
  userWxEntity: Repository<UserWxEntity>;

  @InjectEntityModel(UserComputerEntity)
  userComputerEntity: Repository<UserComputerEntity>;

  @Inject()
  userWxService: UserWxService;

  @Config('module.user.jwt')
  jwtConfig;

  @Inject()
  baseSysLoginService: BaseSysLoginService;

  @Inject()
  pluginService: PluginService;

  @Inject()
  userSmsService: UserSmsService;

  /**
   * 发送手机验证码
   * @param phone
   * @param captchaId
   * @param code
   */
  async smsCode(phone, captchaId, code) {
    // 1、检查图片验证码  2、发送短信验证码
    const check = await this.baseSysLoginService.captchaCheck(captchaId, code);
    if (!check) {
      throw new CoolCommException('图片验证码错误');
    }
    await this.userSmsService.sendSms(phone);
  }

  /**
   *  手机验证码登录
   * @param phone
   * @param smsCode
   */
  async phoneVerifyCode(phone, smsCode) {
    // 1、检查短信验证码  2、登录
    const check = await this.userSmsService.checkCode(phone, smsCode);
    if (check) {
      return await this.phone(phone);
    } else {
      throw new CoolCommException('验证码错误');
    }
  }

  /**
   * 小程序手机号登录
   * @param code
   * @param encryptedData
   * @param iv
   */
  async miniPhone(code, encryptedData, iv) {
    const phone = await this.userWxService.miniPhone(code, encryptedData, iv);
    if (phone) {
      return await this.phone(phone);
    } else {
      throw new CoolCommException('获得手机号失败，请检查配置');
    }
  }

  /**
   * 手机号一键登录
   * @param access_token
   * @param openid
   */
  async uniPhone(access_token, openid, appId) {
    const instance: any = await this.pluginService.getInstance('uniphone');
    const phone = await instance.getPhone(access_token, openid, appId);
    if (phone) {
      return await this.phone(phone);
    } else {
      throw new CoolCommException('获得手机号失败，请检查配置');
    }
  }

  /**
   * 手机登录
   * @param phone
   * @returns
   */
  async phone(phone: string) {
    let user: any = await this.userInfoEntity.findOneBy({
      phone: Equal(phone),
    });
    if (!user) {
      user = {
        phone,
        unionid: phone,
        loginType: 2,
        nickName: phone.replace(/^(\d{3})\d{4}(\d{4})$/, '$1****$2'),
      };
      await this.userInfoEntity.insert(user);
    }
    return this.token({ id: user.id });
  }

  /**
   * 公众号登录
   * @param code
   */
  async mp(code: string) {
    let wxUserInfo = await this.userWxService.mpUserInfo(code);
    if (wxUserInfo) {
      delete wxUserInfo.privilege;
      wxUserInfo = await this.saveWxInfo(
        {
          openid: wxUserInfo.openid,
          unionid: wxUserInfo.unionid,
          avatarUrl: wxUserInfo.headimgurl,
          nickName: wxUserInfo.nickname,
          gender: wxUserInfo.sex,
          city: wxUserInfo.city,
          province: wxUserInfo.province,
          country: wxUserInfo.country,
        },
        1
      );
      return this.wxLoginToken(wxUserInfo);
    } else {
      throw new Error('微信登录失败');
    }
  }

  /**
   * 微信APP授权登录
   * @param code
   */
  async wxApp(code: string) {
    let wxUserInfo = await this.userWxService.appUserInfo(code);
    if (wxUserInfo) {
      delete wxUserInfo.privilege;
      wxUserInfo = await this.saveWxInfo(
        {
          openid: wxUserInfo.openid,
          unionid: wxUserInfo.unionid,
          avatarUrl: wxUserInfo.headimgurl,
          nickName: wxUserInfo.nickname,
          gender: wxUserInfo.sex,
          city: wxUserInfo.city,
          province: wxUserInfo.province,
          country: wxUserInfo.country,
        },
        1
      );
      return this.wxLoginToken(wxUserInfo);
    } else {
      throw new Error('微信登录失败');
    }
  }

  /**
   * 保存微信信息
   * @param wxUserInfo
   * @param type
   * @returns
   */
  async saveWxInfo(wxUserInfo, type) {
    const find: any = { openid: wxUserInfo.openid };
    let wxInfo: any = await this.userWxEntity.findOneBy(find);
    if (wxInfo) {
      wxUserInfo.id = wxInfo.id;
    }
    return this.userWxEntity.save({
      ...wxUserInfo,
      type,
    });
  }

  /**
   * 小程序登录
   * @param code
   * @param encryptedData
   * @param iv
   */
  async mini(code, encryptedData, iv) {
    let wxUserInfo = await this.userWxService.miniUserInfo(
      code,
      encryptedData,
      iv
    );
    if (wxUserInfo) {
      // 保存
      wxUserInfo = await this.saveWxInfo(wxUserInfo, 0);
      return await this.wxLoginToken(wxUserInfo);
    }
  }

  /**
   * 微信登录 获得token
   * @param wxUserInfo 微信用户信息
   * @returns
   */
  async wxLoginToken(wxUserInfo) {
    const unionid = wxUserInfo.unionid ? wxUserInfo.unionid : wxUserInfo.openid;
    let userInfo: any = await this.userInfoEntity.findOneBy({ unionid });
    if (!userInfo) {
      const file = await this.pluginService.getInstance('upload');
      const avatarUrl = await file.downAndUpload(
        wxUserInfo.avatarUrl,
        uuid() + '.png'
      );
      userInfo = {
        unionid,
        nickName: wxUserInfo.nickName,
        avatarUrl,
        gender: wxUserInfo.gender,
        tenantId: userInfo['tenantId'],
        loginType: wxUserInfo.type,
      };
      await this.userInfoEntity.insert(userInfo);
    }
    return this.token({ id: userInfo.id });
  }

  /**
   * 刷新token
   * @param refreshToken
   */
  async refreshToken(refreshToken) {
    try {
      const info = jwt.verify(refreshToken, this.jwtConfig.secret);
      if (!info['isRefresh']) {
        throw new CoolCommException('token类型非refreshToken');
      }
      const userInfo = await this.userInfoEntity.findOneBy({
        id: info['id'],
      });
      return this.token({ id: userInfo.id });
    } catch (e) {
      throw new CoolCommException(
        '刷新token失败，请检查refreshToken是否正确或过期'
      );
    }
  }

  /**
   * 密码登录
   * @param phone
   * @param password
   */
  async password(phone, password) {
    const tenantId = this.baseCtx.headers['x-tenant-id'];
    const user = await this.userInfoEntity.findOneBy({ phone, tenantId: Number(tenantId) });

    if (user && user.password == md5(password)) {
      return this.token({
        id: user.id,
        tenantId: Number(tenantId),
      });
    } else {
      throw new CoolCommException('账号或密码错误');
    }
  }

  /**
   * 获得token
   * @param info
   * @returns
   */
  async token(info) {
    const { expire, refreshExpire } = this.jwtConfig;
    return {
      expire,
      token: await this.generateToken(info),
      refreshExpire,
      refreshToken: await this.generateToken(info, true),
    };
  }

  /**
   * 生成token
   * @param tokenInfo 信息
   * @param roleIds 角色集合
   */
  async generateToken(info, isRefresh = false) {
    const { expire, refreshExpire, secret } = this.jwtConfig;
    const tokenInfo = {
      isRefresh,
      ...info,
    };
    return jwt.sign(tokenInfo, secret, {
      expiresIn: isRefresh ? refreshExpire : expire,
    });
  }

  /**
   * 注册
   * @param phone
   * @param password
   */
  async register(email, code, password, confirmPassword, nickName) {
    if (!email || !code || !password || !confirmPassword || !nickName) {
      throw new CoolCommException('参数不能为空');
    }

    if (!password) {
      throw new CoolCommException('请输入密码');
    } else if (password.length < 8) {
      throw new CoolCommException('密码至少需要8个字符');
    } else if (!/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/.test(password)) {
      throw new CoolCommException('密码必须包含大小写字母和数字');
    }

    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      throw new CoolCommException('请输入有效的邮箱地址');      
    }
    const tenantId = this.baseCtx.headers['x-tenant-id'];
    if (password !== confirmPassword) {
      throw new CoolCommException('两次密码不一致');
    }
    const cacheCode = await this.userSmsService.checkEmailCode(email, tenantId);
    if (!cacheCode || cacheCode !== code) {
      throw new CoolCommException('验证码错误');
    }

    // Check both email and tenantId combination
    const existingUser = await this.userInfoEntity.findOneBy({
      email,
      tenantId: Number(tenantId),
    });

    if (existingUser) {
      throw new CoolCommException('该邮箱已被注册');
    }

    const user = await this.userInfoEntity.save({
      email,
      password: md5(password),
      tenantId: Number(tenantId),
      nickName,
      loginType: 2,
      isActivate: true,
    });
    return this.token({ id: user.id, tenantId: Number(tenantId) });
  }

  /**
   * 发送邮箱注册验证码
   */
  async sendEmailRegisterCode(email) {
    if (!email) {
      throw new CoolCommException('邮箱不能为空');
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      throw new CoolCommException('请输入有效的邮箱地址');      
    }
    const tenantId = this.baseCtx.headers['x-tenant-id'];
    const existingUser = await this.userInfoEntity.findOneBy({
      email,
      tenantId: Number(tenantId),
    });

    if (existingUser) {
      throw new CoolCommException('该邮箱已被注册');
    }

    await this.userSmsService.sendEmailCode(email, tenantId);
  }

  /**
   * 邮箱登录
   * @param email
   */
  async emailLogin(email, password) {
    if (!email || !password) {
      throw new CoolCommException('邮箱或密码不能为空');
    }
    const tenantId = this.baseCtx.headers['x-tenant-id'];
    const computerId = this.baseCtx.headers['x-computer-id'] as string;
    const computerName = this.baseCtx.headers['x-device-name'] as string;

    if (!computerId || !computerName) {
      throw new CoolCommException('设备信息不能为空，请及时更新客户端版本');
    }

    const user = await this.userInfoEntity.findOneBy({
      email,
      tenantId: Number(tenantId),
    });
    if (!user) {
      throw new CoolCommException('未注册');
    }
    if (user.password !== md5(password)) {
      throw new CoolCommException('密码错误');
    }

    const userComputer = await this.userComputerEntity.findOneBy({
      computerId,
      userId: user.id,
    });

    if (userComputer) {
      // 更新最近登录时间
      await this.userComputerEntity.update(
        { id: userComputer.id },
        { lastLoginTime: new Date() }
      );
      return this.token({ id: user.id, tenantId: Number(tenantId) });
    }

    // 查找用户设备数。大于等于三台抛出，绑定设备数量超限
    const userComputerCount = await this.userComputerEntity.countBy({
      userId: user.id,
    });
    if (userComputerCount >= 3) {
      throw new CoolCommException('绑定设备数量超限，请联系管理员解绑');
    }

    await this.userComputerEntity.insert({
      computerId,
      computerName,
      userId: user.id,
      lastLoginTime: new Date(),
      tenantId: Number(tenantId),
    });

    return this.token({ id: user.id, tenantId: Number(tenantId) });
  }

  async siteEmailLogin(email, password) {
    if (!email || !password) {
      throw new CoolCommException('邮箱或密码不能为空');
    }
    const tenantId = this.baseCtx.headers['x-tenant-id'];
    
    const user = await this.userInfoEntity.findOneBy({
      email,
      tenantId: Number(tenantId),
    });
    if (!user) {
      throw new CoolCommException('未注册');
    }
    if (user.password !== md5(password)) {
      throw new CoolCommException('密码错误');
    }
    return this.token({ id: user.id, tenantId: Number(tenantId) });
  }

  /**
   * 找回密码验证码发送
   * @param email
   */
  async findPasswordCode(email) {
    const tenantId = this.baseCtx.headers['x-tenant-id'];
    const user = await this.userInfoEntity.findOneBy({ email, tenantId: Number(tenantId) });
    if (!user) {
      throw new CoolCommException('未注册');
    }
    await this.userSmsService.sendFindPasswordCode(email, tenantId);
    return true;
  }

  /**
   * 找回密码
   * @param email
   * @param code
   * @param password
   * @param confirmPassword
   */
  async findPassword(email, code, password, confirmPassword) {
    const tenantId = this.baseCtx.headers['x-tenant-id'];
    if (!email || !code || !password || !confirmPassword) {
      throw new CoolCommException('参数不能为空');
    }

    if (!password) {
      throw new CoolCommException('请输入密码');
    } else if (password.length < 8) {
      throw new CoolCommException('密码至少需要8个字符');
    } else if (!/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/.test(password)) {
      throw new CoolCommException('密码必须包含大小写字母和数字');
    }
    if (password !== confirmPassword) {
      throw new CoolCommException('两次密码不一致');
    }

    const user = await this.userInfoEntity.findOneBy({ email, tenantId: Number(tenantId) });
    if (!user) {
      throw new CoolCommException('未注册');
    }
    if (user.password === md5(password)) {
      throw new CoolCommException('新密码与旧密码相同');
    }
    const checkBool = await this.userSmsService.checkFindPasswordCode(
      email,
      code,
      tenantId
    );
    if (!checkBool) {
      throw new CoolCommException('验证码错误');
    }
    await this.userInfoEntity.update(user.id, { password: md5(password) });
    return true;
  }
}

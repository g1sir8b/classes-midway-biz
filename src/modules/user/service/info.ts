import { CoolCommException, BaseService } from '@cool-midway/core';
import { Inject, Provide } from '@midwayjs/core';
import { InjectEntityModel } from '@midwayjs/typeorm';
import * as md5 from 'md5';
import { Equal, Repository } from 'typeorm';
import { v1 as uuid } from 'uuid';
import { PluginService } from '../../plugin/service/info';
import { UserInfoEntity } from '../entity/info';
import { UserSmsService } from './sms';
import { UserWxService } from './wx';
import { UserComputerService } from './computer';
import { UserCourseEntity } from '../../content/entity/user_course';
/**
 * 用户信息
 */
@Provide()
export class UserInfoService extends BaseService {
  @InjectEntityModel(UserInfoEntity)
  userInfoEntity: Repository<UserInfoEntity>;

  @InjectEntityModel(UserCourseEntity)
  userCourseEntity: Repository<UserCourseEntity>;

  @Inject()
  pluginService: PluginService;

  @Inject()
  userComputerService: UserComputerService;

  @Inject()
  userSmsService: UserSmsService;

  @Inject()
  userWxService: UserWxService;

  /**
   * 绑定小程序手机号
   * @param userId
   * @param code
   * @param encryptedData
   * @param iv
   */
  async miniPhone(userId: number, code: any, encryptedData: any, iv: any) {
    const phone = await this.userWxService.miniPhone(code, encryptedData, iv);
    await this.userInfoEntity.update({ id: Equal(userId) }, { phone });
    return phone;
  }

  /**
   * 获取用户信息
   * @param id
   * @returns
   */
  async person(id) {
    const info = await this.userInfoEntity.findOneBy({ id: Equal(id) });

    // 按照userInfoEntity的scores插入排名如果有相同数量的排名相同
    // 查询比当前用户积分高的用户数量
    const higherScoreCount = await this.userInfoEntity
      .createQueryBuilder('user')
      .where('user.scores > :scores', { scores: info.scores })
      .andWhere('user.status = 1') // 只统计正常状态的用户
      .andWhere('user.tenantId = :tenantId', { tenantId: info.tenantId })
      .getCount();

    const userCourse = (await this.userCourseEntity.createQueryBuilder('userCourse')
      .where('userCourse.userId = :userId', { userId: id })
      .select('userCourse.courseId')
      .getMany())
    let userCourseIds = [];
    if (userCourse.length > 0) {
      userCourseIds = userCourse.map(item => item.courseId);
    }

    delete info['password'];

    // 排名 = 比自己积分高的人数 + 1
    const rank = higherScoreCount + 1;
    return { ...info, rank, userCourseIds };
  }

  /**
   * 注销
   * @param userId
   */
  async logoff(userId: number) {
    await this.userInfoEntity.update(
      { id: userId },
      {
        status: 2,
        phone: null,
        unionid: null,
        nickName: `已注销-00${userId}`,
        avatarUrl: null,
      }
    );
  }

  /**
   * 更新用户信息
   * @param id
   * @param param
   * @returns
   */
  async updatePerson(id, param) {
    const info = await this.person(id);
    if (!info) throw new CoolCommException('用户不存在');
    if (param.email && param.email !== info.email) {
      return new CoolCommException('邮箱不能直接修改!不要自作聪明偷偷调试!');
    }
    try {
      // 修改了头像要重新处理
      if (param.avatarUrl && info.avatarUrl != param.avatarUrl) {
        const file = await this.pluginService.getInstance('upload');
        param.avatarUrl = await file.downAndUpload(
          param.avatarUrl,
          uuid() + '.png'
        );
      }
    } catch (err) { }
    try {
      return await this.userInfoEntity.update({ id }, param);
    } catch (err) {
      console.log(err);
      throw new CoolCommException('更新失败，参数错误或者手机号已存在');
    }
  }

  /**
   * 更新密码
   * @param userId
   * @param password
   * @param 验证码
   */
  async updatePassword(userId, password, code) {
    const user = await this.userInfoEntity.findOneBy({ id: userId });
    const check = await this.userSmsService.checkCode(user.phone, code);
    if (!check) {
      throw new CoolCommException('验证码错误');
    }
    await this.userInfoEntity.update(user.id, { password: md5(password) });
  }

  /**
   * 绑定手机号
   * @param userId
   * @param phone
   * @param code
   */
  async bindPhone(userId, phone, code) {
    const check = await this.userSmsService.checkCode(phone, code);
    if (!check) {
      throw new CoolCommException('验证码错误');
    }
    await this.userInfoEntity.update({ id: userId }, { phone });
  }

  /**
   * 修改密码
   * @param id
   * @param oldPassword
   * @param newPassword
   * @param confirmPassword
   * @returns
   */
  async changePassword(id, oldPassword, newPassword, confirmPassword) {
    const user = await this.userInfoEntity.findOneBy({ id });
    if (user.password !== md5(oldPassword)) {
      throw new CoolCommException('旧密码错误');
    }
    if (newPassword !== confirmPassword) {
      throw new CoolCommException('两次密码不一致');
    }
    await this.userInfoEntity.update(id, { password: md5(newPassword) });
  }

  /**
   * 修改邮箱地址时的验证码发送
   */
  async sendUpdateEmailCode(id, newEmail) {
    const user = await this.userInfoEntity.findOneBy({ id });
    if (!user) {
      throw new CoolCommException('未注册');
    }
    if (!newEmail) {
      throw new CoolCommException('邮箱不能为空');
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(newEmail)) {
      throw new CoolCommException('请输入有效的邮箱地址');
    }
    if (newEmail === user.email) {
      throw new CoolCommException('新邮箱地址不能与旧邮箱地址相同');
    }
    await this.userSmsService.sendUpdateEmailCode(id, newEmail, user.tenantId);
  }

  /**
   * 修改邮箱地址
   * @param id
   * @param code
   * @param email
   */
  async updateEmail(id, code, email) {
    if (!email) {
      throw new CoolCommException('邮箱不能为空');
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      throw new CoolCommException('请输入有效的邮箱地址');
    }
    const user = await this.userInfoEntity.findOneBy({ id });
    if (!user) {
      throw new CoolCommException('未注册');
    }
    if (email === user.email) {
      throw new CoolCommException('新邮箱地址不能与旧邮箱地址相同');
    }
    const checkBool = await this.userSmsService.checkUpdateEmailCode(
      user.id,
      email,
      code,
      user.tenantId
    );
    if (!checkBool) {
      throw new CoolCommException('验证码错误');
    }
    await this.userInfoEntity.update(id, { email });
  }
}

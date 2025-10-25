import { Provide, Inject, InjectClient } from '@midwayjs/core';
import { BaseService } from '@cool-midway/core';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { Repository } from 'typeorm';
import { Context } from '@midwayjs/koa';
import { BaseSysTenantRegisterEntity } from '../../entity/sys/tenant_register';
import { BaseSysTenantEntity } from '../../entity/sys/tenant';
import { CoolCommException } from '@cool-midway/core';
import { RegisterTenantDTO } from '../../dto/register_tenant';
import { SetupTenantAdminDTO } from '../../dto/setup_tenant_admin';
import { BaseSysTenantModuleEntity } from '../../entity/sys/tenant_module';
import { BaseSysUserEntity } from '../../entity/sys/user';
import { EmailService } from './email';
import { CachingFactory, MidwayCache } from '@midwayjs/cache-manager';
/**
 * 租户注册服务
 */
@Provide()
export class BaseSysTenantRegisterService extends BaseService {
  @InjectEntityModel(BaseSysTenantRegisterEntity)
  baseSysTenantRegisterEntity: Repository<BaseSysTenantRegisterEntity>;

  @InjectEntityModel(BaseSysTenantEntity)
  baseSysTenantEntity: Repository<BaseSysTenantEntity>;

  @InjectEntityModel(BaseSysTenantModuleEntity)
  baseSysTenantModuleEntity: Repository<BaseSysTenantModuleEntity>;

  @InjectEntityModel(BaseSysUserEntity)
  baseSysUserEntity: Repository<BaseSysUserEntity>;

  @Inject()
  emailService: EmailService;

  @Inject()
  ctx: Context;

  @InjectClient(CachingFactory, 'default')
  midwayCache: MidwayCache;

  /**
   * 根据ID获取注册信息
   * @param id
   */
  async getById(id: number) {
    return await this.baseSysTenantRegisterEntity.findOneBy({ id });
  }

  /**
   * 审核
   * @param id 注册ID
   * @param status 审核状态
   * @param remark 审核意见
   * @param moduleIds 模块ID数组
   */
  async audit(
    id: number,
    status: number,
    remark?: string,
    moduleIds?: number[]
  ) {
    // 随机生成用于补充租户信息校验码，包含大小写字母和数字
    let verifyCode: string;

    // 如果审核通过，则生成校验码
    if (status === 1) {
      verifyCode = Math.random().toString(36).substring(2, 15).toUpperCase();
    }

    const auditorId = this.ctx.admin.userId;
    // 更新租户注册信息
    const register = await this.baseSysTenantRegisterEntity.findOneBy({ id });

    if (!register) {
      throw new CoolCommException('租户注册信息不存在');
    }

    // 如果提供了模块ID，则保存租户模块关系
    if (moduleIds?.length) {
      // 先删除原有的模块关系
      await this.baseSysTenantModuleEntity.delete({ tenantPrimaryId: id });

      // 创建新的模块关系记录
      const moduleRelations = moduleIds.map(moduleId => ({
        tenantPrimaryId: id,
        moduleId,
      }));

      await this.baseSysTenantModuleEntity.save(moduleRelations);

      // 生成租户编码 6位随机数字字符串确保数据库唯一
      let tenantCode: string;
      do {
        tenantCode = Math.random().toString(36).substring(2, 8).toUpperCase();
      } while (await this.baseSysTenantEntity.findOneBy({ tenantCode }));

      // 插入租户信息
      const tenant = await this.baseSysTenantEntity.save({
        tenantName: register.tenantName,
        tenantCode,
        tenantContactEmail: register.contactEmail,
        tenantDesc: register.websiteUsage,
        tenantBlockStatus: 0,
        // 租户有效期为30天
        tenantExpireTime: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000),
        // 租户状态 0-正常 1-封禁
        tenantStatus: 0,
      });

      // 将校验码缓存1天
      this.midwayCache.set(
        `tenant_register_verify_code_${verifyCode}`,
        {
          ...register,
          tenantId: tenant.id,
        },
        60 * 60 * 24 * 1000
      );

      // 注册成功邮件，发送给租户，包含链接用于补充租户信息
      const registerMsg = `
        租户注册审核通过
        请点击以下链接补充租户信息：
        ${this.ctx.request.origin}/tenant/setup/${verifyCode}
      `;
      await this.emailService.sendEmail(
        register.contactEmail,
        '租户注册审核通过',
        registerMsg
      );

      await this.baseSysTenantRegisterEntity.save({
        id,
        auditStatus: status,
        auditRemark: remark,
        auditTime: new Date(),
        auditorId,
      });
    }
  }

  /**
   * 根据ID获取注册信息
   * @param id 注册ID
   */
  async info(id: number) {
    const auditUser = await this.baseSysUserEntity.findOneBy({
      id: this.ctx.admin.userId,
    });
    const register = await this.baseSysTenantRegisterEntity.findOneBy({ id });
    return {
      ...register,
      auditorName: auditUser?.name,
    };
  }

  /**
   * 根据邮箱获取注册信息
   * @param email 邮箱
   */
  async getByEmail(email: string) {
    return await this.baseSysTenantRegisterEntity.findOneBy({
      contactEmail: email,
    });
  }

  /**
   * 获取待审核的注册列表
   */
  async getPendingList() {
    return await this.baseSysTenantRegisterEntity.find({
      where: { auditStatus: 0 },
      order: { createTime: 'DESC' },
    });
  }

  async registerTenant(registerTenant: RegisterTenantDTO) {
    const haveTenant = await this.baseSysTenantEntity.findOneBy({
      tenantName: registerTenant.tenantName,
    });
    const haveRegister = await this.baseSysTenantRegisterEntity.findOneBy({
      contactEmail: registerTenant.tenantName,
    });
    if (haveTenant || haveRegister) {
      throw new CoolCommException('租户已存在, 请更换租户名称');
    }
    const tenant = await this.baseSysTenantRegisterEntity.save({
      tenantName: registerTenant.tenantName,
      contactName: registerTenant.contactName,
      contactEmail: registerTenant.contactEmail,
      websiteName: registerTenant.websiteName,
      websiteUsage: registerTenant.websiteUsage,
      auditStatus: 0,
    });
    return tenant;
  }

  /**
   * 补充租户信息
   */
  async supplementTenantInfo(info: SetupTenantAdminDTO) {}
}

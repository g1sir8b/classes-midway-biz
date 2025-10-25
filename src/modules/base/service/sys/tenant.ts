import { Provide, InjectClient, Inject } from '@midwayjs/core';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { BaseService } from '@cool-midway/core';
import { BaseSysTenantModuleEntity } from '../../entity/sys/tenant_module';
import { Repository } from 'typeorm';
import { BaseSysTenantEntity } from '../../entity/sys/tenant';
import { CoolCommException } from '@cool-midway/core';
import { CachingFactory, MidwayCache } from '@midwayjs/cache-manager';
import { SetupTenantAdminDTO } from '../../dto/setup_tenant_admin';
import { BaseSysTenantRegisterEntity } from '../../entity/sys/tenant_register';
import { BaseSysUserEntity } from '../../entity/sys/user';
import { BaseSysUserService } from './user';
import * as md5 from 'md5';
import { BaseSysUserRoleEntity } from '../../entity/sys/user_role';

@Provide()
export class BaseSysTenantService extends BaseService {
  @InjectEntityModel(BaseSysTenantModuleEntity)
  baseSysTenantModuleEntity: Repository<BaseSysTenantModuleEntity>;

  @InjectEntityModel(BaseSysTenantEntity)
  baseSysTenantEntity: Repository<BaseSysTenantEntity>;

  @InjectEntityModel(BaseSysUserEntity)
  baseSysUserEntity: Repository<BaseSysUserEntity>;

  @InjectEntityModel(BaseSysUserRoleEntity)
  baseSysUserRoleEntity: Repository<BaseSysUserRoleEntity>;

  @InjectClient(CachingFactory, 'default')
  midwayCache: MidwayCache;

  @Inject()
  baseSysUserService: BaseSysUserService;

  /**
   * 根据ID获取租户信息
   * @param id 租户ID
   */
  async info(id: number) {
    const tenant = await this.baseSysTenantEntity.findOneBy({ id });
    const moduleIds = await this.baseSysTenantModuleEntity.findBy({ tenantPrimaryId: id });
    return {
      ...tenant,
      moduleIds: moduleIds.map(item => item.moduleId),
    };
  }

  /**
   * 新增租户
   * @param param 租户信息
   */
  async add(param: any | any[]) {
    const {moduleIds} = param;
    const tenant = await this.baseSysTenantEntity.save(param);
    if (!moduleIds?.length) {
        throw new CoolCommException('请至少选择一个模块');
    }
    moduleIds.forEach(async (moduleId) => {
      await this.baseSysTenantModuleEntity.save({
        tenantPrimaryId: tenant.id,
        moduleId,
      });
    });
    return tenant;
  }

  /**
   * 更新租户
   * @param param 租户信息
   */
  async update(param: any | any[]) {
    const {moduleIds} = param;
    const tenant = await this.baseSysTenantEntity.save(param);
    if (!moduleIds?.length) {
        throw new CoolCommException('请至少选择一个模块');
    }
    await this.baseSysTenantModuleEntity.delete({ tenantPrimaryId: tenant.id });
    moduleIds.forEach(async (moduleId) => {
      await this.baseSysTenantModuleEntity.save({
        tenantPrimaryId: tenant.id,
        moduleId,
      });
    });
    return tenant;
  }

  /**
   * 初始化租户
   * @param param 租户信息
   */
  async initTenant(param: SetupTenantAdminDTO) {
    const {username, password, name, email, verifyCode} = param;

    // 检查校验码是否存在
    const register:BaseSysTenantRegisterEntity = await this.midwayCache.get(`tenant_register_verify_code_${verifyCode}`);
    if (!register) {
      throw new CoolCommException('校验码不存在');
    }
    
    // 检查用户是否存在
    const user = await this.baseSysUserEntity.findOneBy({username});
    if (user) {
      throw new CoolCommException('用户已存在');
    }

    const registerUser = await this.baseSysUserEntity.save({
      username,
      password:md5(password),
      name,
      nickName: name,
      email,
      tenantId: register.tenantId,
      isSuperAdmin: true,
      status: 1,
    });
    await this.baseSysTenantEntity.save({
      id: register.tenantId,
      tenantName: register.tenantName,
      contactName: register.contactName,
      contactEmail: register.contactEmail,
      websiteName: register.websiteName,
      status: 1,
      isInit: true,
    });
    

    await this.baseSysUserRoleEntity.save({
      userId: registerUser.id,
      roleId: 1,
    });
    await this.midwayCache.del(`tenant_register_verify_code_${verifyCode}`);
  }
  
}


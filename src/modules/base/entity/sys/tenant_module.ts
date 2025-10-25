import { BaseEntity } from '../base';
import { Column, Entity } from 'typeorm';

/**
 * 租户和模块关联表
 */
@Entity('base_sys_tenant_module')
export class BaseSysTenantModuleEntity extends BaseEntity {
  @Column({ comment: '租户ID' })
  tenantPrimaryId: number;

  @Column({ comment: '模块ID' })
  moduleId: number;
} 
import { Column, Index, Entity } from 'typeorm';
import { BaseEntity } from '../base';

/**
 * 租户
 */
@Entity('base_sys_tenant')
export class BaseSysTenantEntity extends BaseEntity {
    @Index({ unique: true })
    @Column({ comment: '租户名称' })
    tenantName: string;

    @Index({ unique: true })
    @Column({ comment: '租户编码' })
    tenantCode: string;

    @Column({ comment: '联系邮箱' })
    tenantContactEmail: string;

    @Column({ comment: '是否初始化', default: false })
    isInit: boolean;

    @Column({ comment: '租户描述', nullable: true })
    tenantDesc: string;

    @Column({ comment: '封禁状态 0: 正常 1: 封禁', default: 0 })
    tenantBlockStatus: number;

    @Column({ comment: '封禁原因', nullable: true })
    tenantBlockReason: string;

    @Column({ comment: '到期时间', nullable: true })
    tenantExpireTime: Date;

    @Column({ comment: 'Microsoft 365 租户ID', nullable: true })
    entraTenantId: string;

    @Column({ comment: 'Microsoft 365 客户端ID', nullable: true })
    entraClientId: string;

    @Column({ comment: 'Microsoft 365 客户端密钥', nullable: true })
    entraClientSecret: string;

    @Column({ comment: 'Microsoft 365 邮箱', nullable: true })
    entraEmail: string;

}
import { Column, Index, Entity } from 'typeorm';
import { BaseEntity } from '../base';

/**
 * 租户注册表
 */
@Entity('base_sys_tenant_register')
export class BaseSysTenantRegisterEntity extends BaseEntity {
    @Index()
    @Column({ comment: '租户名称' })
    tenantName: string;

    @Column({ comment: '联系人' })
    contactName: string;

    @Index()
    @Column({ comment: '联系人邮箱' })
    contactEmail: string;

    @Column({ comment: '网站名称' })
    websiteName: string;

    @Column({ comment: '网站用途', type: 'text', nullable: true })
    websiteUsage: string;

    @Column({ 
        comment: '审核状态 0-待审核 1-审核通过 2-审核拒绝', 
        default: 0 
    })
    auditStatus: number;

    @Column({ comment: '审核意见', nullable: true })
    auditRemark: string;

    @Column({ comment: '审核时间', nullable: true })
    auditTime: Date;

    @Column({ comment: '审核人ID', nullable: true })
    auditorId: number;
}
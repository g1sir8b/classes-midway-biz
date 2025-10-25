import { BaseEntity } from '../../base/entity/base';
import { Column, Entity, Index } from 'typeorm';

@Entity('balance_recharge_code')
export class RechargeCodeEntity extends BaseEntity {
    @Index({ unique: true })
    @Column({ comment: '充值码', length: 36 })
    code: string;

    @Column({ comment: '状态 0-未使用 1-已使用 2-已过期', type: 'tinyint', default: 0 })
    status: number;

    @Column({ comment: '过期时间', nullable: true })
    expireTime: Date;

    @Column({ comment: '使用时间', nullable: true })
    useTime: Date;

    @Column({ comment: '使用用户ID', nullable: true })
    userId: number;

    @Column({ comment: '金额', type: 'decimal', precision: 10, scale: 2 })
    amount: number;
}
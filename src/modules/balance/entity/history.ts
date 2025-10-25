import { BaseEntity } from '../../base/entity/base';
import { Column, Entity } from 'typeorm';

@Entity('balance_history')
export class BalanceHistoryEntity extends BaseEntity {
    @Column({ comment: '用户ID', nullable: true })
    userId: number;

    @Column({ comment: '金额', type: 'decimal', precision: 10, scale: 2 })
    amount: number;

    @Column({ comment: '类型 0-充值 1-消费 2-退款', type: 'tinyint', default: 0 })
    type: number;

    @Column({ comment: '订单号', nullable: true })
    orderNo: string;

    @Column({ comment: '充值码', nullable: true })
    rechargeCode: string;
}
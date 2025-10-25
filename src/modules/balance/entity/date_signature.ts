import { BaseEntity } from '../../base/entity/base';
import { Column, Entity } from 'typeorm';

@Entity('balance_date_signature')
export class BalanceDateSignatureEntity extends BaseEntity {
    @Column({ comment: '用户ID', nullable: true })
    userId: number;

    @Column({ comment: '日期', nullable: true })
    date: string;
}
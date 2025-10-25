import { BaseEntity } from '../../base/entity/base';
import { Column, Entity } from 'typeorm';

@Entity('user_computer')
export class UserComputerEntity extends BaseEntity {
    @Column({ comment: '用户ID', nullable: true })
    userId: number;

    @Column({ comment: '计算机ID', nullable: true })
    computerId: string;

    @Column({ comment: '计算机名称', nullable: true })
    computerName: string;

    // 最近登录时间
    @Column({ comment: '最近登录时间', nullable: true })
    lastLoginTime: Date;
}
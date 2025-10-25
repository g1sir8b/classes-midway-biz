import { BaseEntity } from '../../base/entity/base';
import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity('user_request_log')
export class UserRequestLogEntity extends BaseEntity {
  @Column({ comment: '用户ID', nullable: false })
  userId: number;

  @Column({ comment: '计算机ID', nullable: false })
  computerId: string;

  @Column({ comment: '接口地址', nullable: true })
  url: string;

  @Column({ comment: '可疑操作', nullable: true })
  suspiciousOperation: string;

  @Column({ comment: 'IP地址', nullable: false })
  ip: string;

  @Column({ comment: '日志类型 0-请求记录 1-可疑操作', nullable: false })
  type: number;
}

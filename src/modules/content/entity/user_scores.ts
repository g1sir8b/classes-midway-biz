import { BaseEntity } from '../../base/entity/base';
import { Column, Entity } from 'typeorm';

@Entity('content_user_scores')
export class UserScoresEntity extends BaseEntity {
  //
  //   `userId` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  //   `score` int(11) NOT NULL DEFAULT '0' COMMENT '积分数',
  //   `dataSrc` int(11) NOT NULL DEFAULT '0' COMMENT '来源（1:订单 2:评价 3:订单取消返还 4:拒收返还）',
  //   `dataRemarks` text COMMENT '描述（N/A）',
  //   `score Type` int(11) NOT NULL DEFAULT '0' COMMENT '积分类型（1:收入 2:支出）',
  //   `create Time` datetime NOT NULL COMMENT '创建时间',

  @Column({ comment: '用户ID', type: 'int' })
  userId: number;

  @Column({ comment: '积分数', type: 'int' })
  score: number;

  @Column({ comment: '来源', type: 'int', default: 0 })
  dataSrc: number;

  @Column({ comment: '描述', type: 'text', nullable: true })
  dataRemarks: string;

  @Column({ comment: '积分类型', type: 'int' })
  scoreType: number;

  @Column({ comment: '创建时间', type: 'datetime' })
  createTime: Date;
}

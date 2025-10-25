import { BaseEntity } from '../../base/entity/base';
import { Column, Entity } from 'typeorm';

/**
 * 订单详情
 */
@Entity('course_key')
export class CourseKeyEntity extends BaseEntity {
  @Column({ comment: '激活码', length: 80 })
  code: string;

  @Column({ comment: '课程ID' })
  courseId: number;

  @Column({
    comment: '使用状态 1-未使用 2-已使用',
    type: 'tinyint',
    default: 1,
  })
  useStatus: number;

  @Column({ comment: '用户ID(用于激活时存储用户)', nullable: true })
  userId: number;
}

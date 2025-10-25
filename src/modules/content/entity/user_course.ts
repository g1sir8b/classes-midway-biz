import { BaseEntity } from '../../base/entity/base';
import { Column, Entity, ManyToOne, JoinColumn } from 'typeorm';
import { CourseEntity } from './course';

@Entity('content_user_course')
export class UserCourseEntity extends BaseEntity {
    @Column({ comment: '用户ID', type: 'int' })
    userId: number;

    @Column({ comment: '课程ID', type: 'int' })
    courseId: number;

    // 激活码编码
    @Column({ comment: '激活码编码', type: 'varchar', length: 255, nullable: true })
    activationCode: string;

    @ManyToOne(() => CourseEntity)
    @JoinColumn({ name: 'courseId' })
    course: CourseEntity;

    // 订单号
    @Column({ comment: '订单号', type: 'varchar', length: 255, nullable: true })
    orderNo: string;
}
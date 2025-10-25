import { BaseEntity } from '../../base/entity/base';
import { Column, Entity } from 'typeorm';

/**
 * 课程详情
 */
@Entity('content_course')
export class CourseEntity extends BaseEntity {
    @Column({ comment: '课程名称', length: 100 })
    name: string;

    @Column({ comment: 'SSE关键字', type: 'text', nullable: true })
    sseKeywords: string;

    @Column({ comment: '课程描述', type: 'text', nullable: true })
    description: string;

    @Column({ comment: '原价', type: 'decimal', precision: 10, scale: 2 })
    originalPrice: number;

    @Column({ comment: '实际售价', type: 'decimal', precision: 10, scale: 2 })
    price: number;

    @Column({ comment: '销售次数', default: 0 })
    salesCount: number;

    @Column({ comment: '访问量', default: 0 })
    viewCount: number;

    @Column({ comment: '课程状态', default: 1, type: 'tinyint' })
    isPublished: number;

    @Column({ comment: '课程封面图', nullable: true })
    coverImage: string;
    
    @Column({ comment: '背景图', nullable: true })
    backgroundImage: string;

    @Column({ comment: '课程时长(分钟)', type: 'int', default: 0 })
    duration: number;

    @Column({ comment: '所属分类ID', type: 'json' })
    categoryIds: number[];

    @Column({ comment: '课程简介', type: 'text', nullable: true })
    introduction: string;

    @Column({ comment: '涉及教学软件', type: 'json', nullable: true })
    teachingSoftware: string[];

    @Column({ comment: '技能', type: 'json', nullable: true })
    skills: string[];

    @Column({ comment: '级别  1入门课程 2初级课程 3中级课程 4高级课程 5专家课程', type: 'tinyint', default: 0 })
    level: number;
    
    @Column({ comment: '是否推荐课程', type: 'tinyint', default: false })
    isRecommend: boolean;
} 
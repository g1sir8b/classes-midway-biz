import { BaseEntity } from '../../base/entity/base';
import { Column, Entity, Index } from 'typeorm';

/**
 * 课程内容
 */
@Entity('content_course_content')
export class CourseContentEntity extends BaseEntity {
    @Column({ comment: '课程ID', type: 'bigint' })
    courseId: number;

    @Column({ comment: '父级ID', type: 'bigint', nullable: true })
    parentId: number;

    @Column({ comment: '内容名称', length: 100 })
    name: string;

    @Column({ 
        comment: '内容类型: 0-分组 1-视频 2-文本说明', 
        type: 'tinyint',
        default: 0 
    })
    type: number;

    @Column({ 
        comment: '视频处理状态: 0-待处理 1-处理中 2-已处理 3-处理失败 4-无需处理',
        type: 'tinyint',
        default: 0,
        nullable: true 
    })
    videoStatus: number;

    @Column({ comment: '文本内容', type: 'text', nullable: true })
    text: string;

    @Column({ comment: 'M3U8视频地址', nullable: true })
    m3u8Url: string;

    @Column({ comment: '文本说明', type: 'text', nullable: true })
    description: string;

    @Column({ comment: '排序号', default: 0 })
    sort: number;

    @Column({ comment: '是否显示', default: 1, type: 'tinyint' })
    isShow: number;
} 
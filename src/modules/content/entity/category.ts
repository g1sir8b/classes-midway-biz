import { BaseEntity } from '../../base/entity/base';
import { Column, Entity, Index } from 'typeorm';

/**
 * 内容分类
 */
@Entity('content_category')
export class ContentCategoryEntity extends BaseEntity {
  @Column({ comment: '父分类ID', type: 'bigint', nullable: true })
  parentId: number;

  @Column({ comment: '分类名称', length: 20 })
  name: string;

  @Column({ comment: '分类描述', nullable: true })
  description: string;

  @Column({ comment: '分类图标', nullable: true })
  icon: string;

  // @Column({ comment: '行业类型', nullable: true })
  // industryType: string;
  
  @Column({ comment: '技能类型', nullable: true })
  skillType: string;

  @Column({ comment: '排序号', default: 0 })
  orderNum: number;

  @Column({ comment: '是否显示', default: true })
  isShow: boolean;
}

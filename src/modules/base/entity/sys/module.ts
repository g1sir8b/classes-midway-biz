import { BaseEntity } from '../base';
import { Column, Entity } from 'typeorm';

/**
 * 模块表
 */
@Entity('base_sys_module')
export class BaseSysModuleEntity extends BaseEntity {
  @Column({ comment: '模块名称' })
  name: string;

  @Column({ comment: '模块图标', nullable: true })
  icon: string;

  @Column({ comment: '模块描述', nullable: true })
  description: string;

  @Column({ comment: '模块标识', unique: true })
  key: string;

  @Column({ comment: '排序', default: 0 })
  orderNum: number;
} 
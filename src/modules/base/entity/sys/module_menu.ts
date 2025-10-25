import { BaseEntity } from '../base';
import { Column, Entity } from 'typeorm';

/**
 * 模块和菜单关联表
 */
@Entity('base_sys_module_menu')
export class BaseSysModuleMenuEntity extends BaseEntity {
  @Column({ comment: '模块ID' })
  moduleId: number;

  @Column({ comment: '菜单ID' })
  menuId: number;
} 
import { Provide } from '@midwayjs/core';
import { BaseService } from '@cool-midway/core';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { Repository } from 'typeorm';
import { BaseSysModuleEntity } from '../../entity/sys/module';
import { BaseSysModuleMenuEntity } from '../../entity/sys/module_menu';

/**
 * 模块服务
 */
@Provide()
export class BaseSysModuleService extends BaseService {
  @InjectEntityModel(BaseSysModuleEntity)
  baseSysModuleEntity: Repository<BaseSysModuleEntity>;

  @InjectEntityModel(BaseSysModuleMenuEntity)
  baseSysModuleMenuEntity: Repository<BaseSysModuleMenuEntity>;

  async modifyAfter(param){
    if (param.id) {
      this.updateModulePerms(param.id, param.menuIdList);
    }
  }

  /**
   * 更新模块和菜单的关联关系
   * @param moduleId 模块ID
   * @param menuIds 菜单ID列表
   */
  async updateModulePerms(moduleId: number, menuIds: number[]) {
    // 更新模块和菜单的关联关系
    await this.baseSysModuleMenuEntity.delete({ moduleId });
    for (const menuId of menuIds) {
      await this.baseSysModuleMenuEntity.save({ moduleId, menuId });
    }
  }

  async info(id) {
    const info = await this.baseSysModuleEntity.findOneBy({ id });
    if (info) {
      const menus = await this.baseSysModuleMenuEntity.findBy({ moduleId: id });
      const menuIdList = menus.map(e => {
        return parseInt(e.menuId + '');
      });
      return {
        ...info,
        menuIdList,
      };
    }
    return {};
  }
}


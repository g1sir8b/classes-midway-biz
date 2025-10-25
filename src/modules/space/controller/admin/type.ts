import { Provide } from '@midwayjs/core';
import { CoolController } from '@cool-midway/core';
import { SpaceTypeEntity } from '../../entity/type';
import { SpaceTypeService } from '../../service/type';
import { Context } from 'vm';
import { BaseController } from '../../../base/controller/base';
/**
 * 空间分类
 */
@Provide()
@CoolController({
  api: ['add', 'delete', 'update', 'info', 'list', 'page'],
  entity: SpaceTypeEntity,
  service: SpaceTypeService,
  insertParam: async (ctx: Context) => {
    return {
      tenantId: ctx.admin.tenantId,
    };
  },
  pageQueryOp: {
    fieldEq: ['type', 'classifyId'],
  },
})
export class BaseAppSpaceTypeController extends BaseController {}

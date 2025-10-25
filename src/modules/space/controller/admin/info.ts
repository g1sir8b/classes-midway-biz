import { Provide } from '@midwayjs/core';
import { CoolController } from '@cool-midway/core';
import { SpaceInfoEntity } from '../../entity/info';
import { SpaceInfoService } from '../../service/info';
import { Context } from 'vm';
import { BaseController } from '../../../base/controller/base';
/**
 * 图片空间信息
 */
@Provide()
@CoolController({
  api: ['add', 'delete', 'update', 'info', 'list', 'page'],
  entity: SpaceInfoEntity,
  service: SpaceInfoService,
  insertParam: async (ctx: Context) => {
    return {
      tenantId: ctx.admin.tenantId,
    };
  },
  pageQueryOp: {
    fieldEq: ['type', 'classifyId'],
  },
})
export class BaseAppSpaceInfoController extends BaseController {}

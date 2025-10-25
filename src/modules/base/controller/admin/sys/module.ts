import { Provide } from '@midwayjs/core';
import { CoolController } from '@cool-midway/core';
import { BaseSysModuleEntity } from '../../../entity/sys/module';
import { BaseSysModuleService } from '../../../service/sys/module';
import { BaseController } from '../../base';

/**
 * 模块
 */
@Provide()
@CoolController({
  api: ['add', 'delete', 'update', 'info', 'list', 'page'],
  entity: BaseSysModuleEntity,
  service: BaseSysModuleService,
  pageQueryOp: {
    keyWordLikeFields: ['name', 'key'],
  },
})
export class BaseSysModuleController extends BaseController {}

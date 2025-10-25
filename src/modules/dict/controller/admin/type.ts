import { DictTypeEntity } from './../../entity/type';
import { Provide } from '@midwayjs/core';
import { CoolController } from '@cool-midway/core';
import { DictTypeService } from '../../service/type';
import { Context } from 'vm';
import { BaseController } from '../../../base/controller/base';
/**
 * 字典类型
 */
@Provide()
@CoolController({
  api: ['add', 'delete', 'update', 'info', 'list', 'page'],
  entity: DictTypeEntity,
  service: DictTypeService,
  listQueryOp: {
    keyWordLikeFields: ['name'],
  },
})
export class AdminDictTypeController extends BaseController {}

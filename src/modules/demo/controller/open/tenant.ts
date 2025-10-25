import { CoolController } from '@cool-midway/core';
import { DemoGoodsEntity } from '../../entity/goods';
import { DemoTenantService } from '../../service/tenant';
import { BaseController } from '../../../base/controller/base';

/**
 * 多租户
 */
@CoolController({
  api: [],
  entity: DemoGoodsEntity,
  service: DemoTenantService,
})
export class OpenDemoTenantController extends BaseController {}

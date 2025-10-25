import { Body, Inject, Post, Provide } from '@midwayjs/core';
import { CoolController } from '@cool-midway/core';
import { BaseSysTenantEntity } from '../../../entity/sys/tenant';
import { BaseSysTenantService } from '../../../service/sys/tenant';
import { BaseController } from '../../base';

@Provide()
@CoolController({
  api: ['add', 'delete', 'update', 'info', 'list', 'page'],
  entity: BaseSysTenantEntity,
  service: BaseSysTenantService,
})
export class BaseSysTenantController extends BaseController {}

import { ContentCategoryEntity } from '../../entity/category';
import { CoolController } from '@cool-midway/core';
import { BaseController } from '../../../base/controller/base';
import { ContentCategoryService } from '../../service/category';

@CoolController({
  api: ['add', 'delete', 'update', 'info', 'list', 'page'],
  entity: ContentCategoryEntity,
  service: ContentCategoryService,
})
export class AdminCategoryController extends BaseController {}

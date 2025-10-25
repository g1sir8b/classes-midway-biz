import { ContentCategoryEntity } from '../../entity/category';
import { CoolController, CoolUrlTag, TagTypes } from '@cool-midway/core';
import { ContentCategoryService } from '../../service/category';
import { BaseController } from '../../../base/controller/base';

@CoolController({
  api: ['info', 'list'],
  entity: ContentCategoryEntity,
  service: ContentCategoryService,
  listQueryOp: {
    addOrderBy: {
      orderNum: 'ASC',
    },
  },
})
@CoolUrlTag({
  key: TagTypes.IGNORE_TOKEN,
  value: ["info", "list"],
})
export class SiteCategoryController extends BaseController {}

import { CoolController } from '@cool-midway/core';
import { CourseEntity } from '../../entity/course';
import { CourseService } from '../../service/course';
import { BaseController } from '../../../base/controller/base';
@CoolController({
  api: ['add', 'delete', 'update', 'info', 'list', 'page'],
  entity: CourseEntity,
  service: CourseService,
  pageQueryOp: {
    fieldEq: ['categoryIds', 'skills', 'level'],
    keyWordLikeFields: ['name'],
  },
})
export class AdminCourseController extends BaseController {}

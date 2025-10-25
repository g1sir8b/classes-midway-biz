import { CoolController } from '@cool-midway/core';
import { CourseContentEntity } from '../../entity/course_content';
import { CourseContentService } from '../../service/course_content';
import { BaseController } from '../../../base/controller/base';
@CoolController({
  api: ['add', 'delete', 'update', 'info', 'list', 'page'],
  entity: CourseContentEntity,
  service: CourseContentService,
  listQueryOp: {
    fieldEq: ['courseId'],
    addOrderBy: {
      sort: 'ASC',
    },
  }
})
export class CourseContentController extends BaseController {}

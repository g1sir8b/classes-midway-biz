import { CoolController } from '@cool-midway/core';
import { CourseKeyEntity } from '../../entity/key';
import { Body, Inject, Post } from '@midwayjs/core';
import { CourseKeyService } from '../../service/key';
import { BaseController } from '../../../base/controller/base';
@CoolController({
  api: ['list', 'page'],
  entity: CourseKeyEntity,
  pageQueryOp: {
    fieldEq: ['courseId'],
  },
})
export class CourseKeyController extends BaseController {
  @Inject()
  courseKeyService: CourseKeyService;

  @Post('/generate', { summary: '快速生成' })
  async generate(
    @Body('count') count: number,
    @Body('courseId') courseId: number
  ) {
    return this.ok(await this.courseKeyService.generate(count, courseId));
  }
}

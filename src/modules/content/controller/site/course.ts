import { CourseEntity } from '../../entity/course';
import { CoolController, CoolUrlTag, TagTypes } from '@cool-midway/core';
import { CourseService } from '../../service/course';
import { BaseController } from '../../../base/controller/base';
import { Post, Inject, Body } from '@midwayjs/core';

@CoolController({
  api: ['info'],
  entity: CourseEntity,
  service: CourseService,
  pageQueryOp: {
    fieldEq: ['categoryIds', 'skills', 'level', 'teachingSoftware', 'isRecommend'],
    keyWordLikeFields: ['name'],
  },
})
@CoolUrlTag({
  key: TagTypes.IGNORE_TOKEN,
  value: ["info", "page"],
})
export class SiteCourseController extends BaseController {
  @Inject()
  courseService: CourseService;

  @Post('/page', { summary: '课程列表' })
  async pagePublished(@Body() body: { sort?: 'newest' | 'hot' }): Promise<{ code: number; message: string; }> {
    return this.ok(await this.courseService.pagePublished(body));
  }
}

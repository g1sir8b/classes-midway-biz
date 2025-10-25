import { Provide, Inject } from '@midwayjs/core';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { Repository } from 'typeorm';
import { BaseService } from '@cool-midway/core';
import { CourseContentEntity } from '../entity/course_content';
@Provide()
export class CourseContentService extends BaseService {
  @InjectEntityModel(CourseContentEntity)
  courseContentRepo: Repository<CourseContentEntity>;
}

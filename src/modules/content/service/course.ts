import { Provide } from '@midwayjs/core';
import { BaseService, CoolCommException } from '@cool-midway/core';
import { CourseEntity } from '../entity/course';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { Repository } from 'typeorm';

@Provide()
export class CourseService extends BaseService {
  @InjectEntityModel(CourseEntity)
  courseEntity: Repository<CourseEntity>;

  async list(params: any) {
    const { categoryIds, skills, level } = params;
    const queryBuilder = this.courseEntity.createQueryBuilder('course');

    if (categoryIds && categoryIds.length > 0) {
      // 如果传入的是数组，使用JSON_OVERLAPS
      if (Array.isArray(categoryIds)) {
        queryBuilder.where('JSON_OVERLAPS(course.categoryIds, :categoryIds)', {
          categoryIds: JSON.stringify(categoryIds),
        });
      } else {
        // 如果传入的是单个值
        queryBuilder.where('JSON_CONTAINS(course.categoryIds, :categoryId)', {
          categoryId: JSON.stringify(categoryIds),
        });
      }
    }

    if (skills && skills.length > 0) {
      if (Array.isArray(skills)) {
        queryBuilder.andWhere('JSON_OVERLAPS(course.skills, :skills)', {
          skills: JSON.stringify(skills),
        });
      } else {
        queryBuilder.andWhere('JSON_CONTAINS(course.skills, :skill)', {
          skill: JSON.stringify(skills),
        });
      }
    }

    if (level) {
      queryBuilder.andWhere('course.level = :level', { level });
    }

    return await queryBuilder.getMany();
  }

  async page(query: any, option: any = {}) {
    const { categoryIds, skills, level } = query;
    const page = Number(option.page) || 1;
    const size = Number(option.size) || 10;
    const queryBuilder = this.courseEntity.createQueryBuilder('course');

    if (categoryIds && categoryIds.length > 0) {
      // 如果传入的是数组，使用JSON_OVERLAPS
      if (Array.isArray(categoryIds)) {
        queryBuilder.andWhere(
          'JSON_OVERLAPS(course.categoryIds, :categoryIds)',
          {
            categoryIds: JSON.stringify(categoryIds),
          }
        );
      } else {
        // 如果传入的是单个值
        queryBuilder.andWhere(
          'JSON_CONTAINS(course.categoryIds, :categoryId)',
          {
            categoryId: JSON.stringify(categoryIds),
          }
        );
      }
    }

    if (skills && skills.length > 0) {
      if (Array.isArray(skills)) {
        queryBuilder.andWhere('JSON_OVERLAPS(course.skills, :skills)', {
          skills: JSON.stringify(skills),
        });
      } else {
        queryBuilder.andWhere('JSON_CONTAINS(course.skills, :skill)', {
          skill: JSON.stringify(skills),
        });
      }
    }

    if (level) {
      queryBuilder.andWhere('course.level = :level', { level });
    }

    const [list, total] = await queryBuilder
      .skip((page - 1) * size)
      .take(size)
      .getManyAndCount();

    return {
      list,
      pagination: {
        page: Number(page),
        size: Number(size),
        total,
      },
    };
  }

  async pagePublished(query: any) {
    const { categoryIds, skills, level, teachingSoftware, sort = 'newest',keyword } = query;
    const page = Number(query.page) || 1;
    const size = Number(query.size) || 10;
    const queryBuilder = this.courseEntity.createQueryBuilder('course');

    if (keyword) {
      queryBuilder.andWhere('course.name LIKE :keyword', { keyword: `%${keyword}%` });
    }

    if (categoryIds && categoryIds.length > 0) {
      // 如果传入的是数组，使用JSON_OVERLAPS
      if (Array.isArray(categoryIds)) {
        queryBuilder.andWhere(
          'JSON_OVERLAPS(course.categoryIds, :categoryIds)',
          {
            categoryIds: JSON.stringify(categoryIds),
          }
        );
      } else {
        // 如果传入的是单个值
        queryBuilder.andWhere(
          'JSON_CONTAINS(course.categoryIds, :categoryId)',
          {
            categoryId: JSON.stringify(categoryIds),
          }
        );
      }
    }

    if (skills && skills.length > 0) {
      if (Array.isArray(skills)) {
        queryBuilder.andWhere('JSON_OVERLAPS(course.skills, :skills)', {
          skills: JSON.stringify(skills),
        });
      } else {
        queryBuilder.andWhere('JSON_CONTAINS(course.skills, :skill)', {
          skill: JSON.stringify(skills),
        });
      }
    }
    if (teachingSoftware && teachingSoftware.length > 0) {
      if (Array.isArray(teachingSoftware)) {
        queryBuilder.andWhere('JSON_OVERLAPS(course.teachingSoftware, :teachingSoftware)', {
          teachingSoftware: JSON.stringify(teachingSoftware),
        });
      } else {
        queryBuilder.andWhere('JSON_CONTAINS(course.teachingSoftware, :teachingSoftware)', {
          teachingSoftware: JSON.stringify(teachingSoftware),
        });
      }
    }

    if (level) {
      queryBuilder.andWhere('course.level = :level', { level });
    }

    queryBuilder.andWhere('course.isPublished = :isPublished', { isPublished: 1 });

    if (sort === 'newest') {
      queryBuilder.orderBy('course.createTime', 'DESC');
    } else if (sort === 'hot') {
      queryBuilder.orderBy('course.viewCount', 'DESC');
    }

    const [list, total] = await queryBuilder
      .skip((page - 1) * size)
      .take(size)
      .getManyAndCount();

    return {
      list,
      pagination: {
        page: Number(page),
        size: Number(size),
        total,
      },
    };
  }

  async info(id: any, infoIgnoreProperty?: string[]): Promise<any> {
    const course = await this.courseEntity.findOneBy({ id });
    // viewCount+=1
    await this.courseEntity.update(id, { viewCount: () => `viewCount + 1` });
    if (!course) {
      throw new CoolCommException('课程不存在~');
    }
    return {
      ...course,
      viewCount: course.viewCount + 1,
    };
  }
}

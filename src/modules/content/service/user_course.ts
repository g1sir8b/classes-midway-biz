import { Provide, Inject } from '@midwayjs/core';
import { BaseService, CoolCommException } from '@cool-midway/core';
import { UserCourseEntity } from '../entity/user_course';
import { CourseKeyEntity } from '../entity/key';
import { CourseEntity } from '../entity/course';
import { CourseContentEntity } from '../entity/course_content';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { Repository, Not, IsNull } from 'typeorm';

@Provide()
export class UserCourseService extends BaseService {
    @InjectEntityModel(UserCourseEntity)
    userCourseEntity: Repository<UserCourseEntity>;

    @InjectEntityModel(CourseKeyEntity)
    courseKeyEntity: Repository<CourseKeyEntity>;

    @InjectEntityModel(CourseEntity)
    courseEntity: Repository<CourseEntity>;

    @InjectEntityModel(CourseContentEntity)
    courseContentEntity: Repository<CourseContentEntity>;

    /**
     * 激活课程
     * @param userId 用户ID
     * @param activationCode 激活码
     */
    async create(userId: number, activationCode: string) {
        const tenantId = this.baseCtx.headers['x-tenant-id'];
        // 查找激活码是否存在
        const courseKey = await this.courseKeyEntity.findOneBy({
            code: activationCode,
        });
        if (!courseKey) {
            throw new CoolCommException('激活码不存在');
        }
        if (courseKey.useStatus === 2) {
            throw new CoolCommException('激活码已使用');
        }
        // 查找用户是否已购买该课程
        const userCourse = await this.userCourseEntity.findOneBy({
            userId,
            courseId: courseKey.courseId,
        });
        if (userCourse) {
            throw new CoolCommException('用户已购买该课程');
        }
        // 保存用户课程
        await this.userCourseEntity.save({
            userId,
            courseId: courseKey.courseId,
            activationCode,
            tenantId: Number(tenantId),
        });
        // 更新激活码使用状态
        await this.courseKeyEntity.update(courseKey.id, {
            useStatus: 2,
            userId,
        });
    }

    /**
     * 激活记录不分页
     * @param userId 用户ID
     */
    async history(userId: number) {
        const list = await this.userCourseEntity
            .createQueryBuilder('userCourse')
            .leftJoinAndSelect('userCourse.course', 'course')
            .where('userCourse.userId = :userId', { userId })
            .andWhere('userCourse.activationCode IS NOT NULL')
            .andWhere('userCourse.activationCode != ""')
            .andWhere('TRIM(userCourse.activationCode) != ""')
            .select([
                'userCourse.id',
                'userCourse.userId',
                'userCourse.courseId',
                'userCourse.activationCode',
                'userCourse.createTime',
                'course.id',
                'course.name',
                'course.description',
                'course.price',
                'course.coverImage'
            ])
            .getMany();
        return list;
    }

    /**
     * 我的课程列表
     * @param userId 用户ID
     */
    async list(userId: number) {
        const list = await this.userCourseEntity
            .createQueryBuilder('userCourse')
            .leftJoinAndSelect('userCourse.course', 'course')
            .where('userCourse.userId = :userId', { userId })
            .select([
                'userCourse.id',
                'userCourse.userId',
                'userCourse.courseId',
                'userCourse.createTime',
                'course.id',
                'course.name',
                'course.coverImage',
                'course.description',
                'course.sseKeywords',
            ])
            .getMany();
        return list;
    }

    /**
     * 我的课程列表分页
     */
    async page(userId: number, page: number, size: number, sort: 'buyTime' | 'createTime' = 'buyTime', keyWord: string = '') {
        const skip = (Number(page) - 1) * Number(size);
        const take = Number(size);
        
        // 如果是buyTime查询userCourse的createTime，如果是createTime查询course的createTime
        const queryBuilder = this.userCourseEntity.createQueryBuilder('userCourse')
            .leftJoin('userCourse.course', 'course')
            .where('userCourse.userId = :userId', { userId })
            .andWhere('course.name LIKE :keyWord', { keyWord: `%${keyWord}%` })
            .select([
                'userCourse',
                'course.id',
                'course.name',
                'course.coverImage',
                'course.description',
                'course.sseKeywords',
                'course.createTime',
                'course.viewCount',
                'course.skills',
                'course.categoryIds',
                'course.level',
            ]);
        
        // 根据不同的排序字段进行排序（降序，最新的在前）
        if (sort === 'buyTime') {
            queryBuilder.orderBy('userCourse.createTime', 'DESC');
        } else {
            queryBuilder.orderBy('course.createTime', 'DESC');
        }
        
        const [list, total] = await queryBuilder
            .skip(skip)
            .take(take)
            .getManyAndCount();
        return { list, pagination: { page: Number(page), size: Number(size), total } };
    }

    /**
     * 我的课程详情
     * @param userId 用户ID
     * @param courseId 课程ID
     */
    async detail(userId: number, courseId: number) {
        const userCourse = await this.userCourseEntity.findOneBy({
            userId,
            courseId,
        });
        if (!userCourse) {
            throw new CoolCommException('用户未购买该课程');
        }
        const course = await this.courseEntity.findOneBy({
            id: userCourse.courseId,
        });
        if (!course) {
            throw new CoolCommException('课程不存在');
        }
        return course;
    }

    /**
     * 我的课程内容
     * @param userId 用户ID
     * @param courseId 课程ID
     */
    async tree(userId: number, courseId: number) {
        const userCourse = await this.userCourseEntity.findOneBy({
            userId,
            courseId,
        });
        if (!userCourse) {
            throw new CoolCommException('用户未购买该课程');
        }
        const courseContent = await this.courseContentEntity.find({
            where: {
                courseId,
            },
            order: {
                sort: 'ASC',
            },
        });
        if (!courseContent) {
            throw new CoolCommException('课程内容不存在');
        }
        return courseContent;
    }

    /**
     * 我的课程内容
     * @param userId 用户ID
     * @param courseId 课程内容ID
     */
    async content(userId: number, courseContentId: number) {
        const courseContent = await this.courseContentEntity.findOneBy({
            id: courseContentId,
        });
        if (!courseContent) {
            throw new CoolCommException('课程内容不存在');
        }
        const userCourse = await this.userCourseEntity.findOneBy({
            userId,
            courseId: courseContent.courseId,
        });
        if (!userCourse) {
            throw new CoolCommException('用户未购买该课程');
        }

        return courseContent;
    }
}
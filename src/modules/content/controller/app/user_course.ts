import { CoolController } from '@cool-midway/core';
import { UserCourseEntity } from '../../entity/user_course';
import { UserCourseService } from '../../service/user_course';
import { Get, Inject, Post, Query } from '@midwayjs/core';
import { Body } from '@midwayjs/core';
import { BaseController } from '../../../base/controller/base';

@CoolController({
    entity: UserCourseEntity,
    service: UserCourseService,
})
export class UserCourseController extends BaseController {
    @Inject()
    userCourseService: UserCourseService;   

    @Inject()
    ctx;

    @Post('/create', { summary: '激活课程' })
    async create(@Body('activationCode') activationCode: string) {
        const userId = this.ctx.user.id;
        return this.ok(await this.userCourseService.create(userId, activationCode));
    }

    @Get('/history', { summary: '激活记录' })
    async history() {
        const userId = this.ctx.user.id;
        return this.ok(await this.userCourseService.history(userId));
    }

    @Get('/list', { summary: '课程列表' })
    async list() {
        const userId = this.ctx.user.id;
        return this.ok(await this.userCourseService.list(userId));
    }

    @Get('/detail', { summary: '课程详情' })
    async detail(@Query('courseId') courseId: number) {
        const userId = this.ctx.user.id;
        return this.ok(await this.userCourseService.detail(userId, courseId));
    }

    @Get('/tree', { summary: '课程内容' })
    async tree(@Query('courseId') courseId: number) {
        const userId = this.ctx.user.id;
        return this.ok(await this.userCourseService.tree(userId, courseId));
    }

    @Get('/content', { summary: '课程内容' })
    async content(@Query('courseContentId') courseContentId: number) {
        const userId = this.ctx.user.id;
        return this.ok(await this.userCourseService.content(userId, courseContentId));
    }
}
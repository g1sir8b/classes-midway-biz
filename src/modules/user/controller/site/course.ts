import { CoolController } from '@cool-midway/core';
import { Body, Context, Get, Inject, Post } from '@midwayjs/core';
import { BaseController } from '../../../base/controller/base';
import { UserCourseService } from '../../../content/service/user_course';

@CoolController()
export class SiteUserCourseController extends BaseController {
    @Inject()
    ctx;

    @Inject()
    userCourseService: UserCourseService;

    @Post('/page', { summary: '我的课程列表' })
    async page(@Body('page') page: number = 1, @Body('size') size: number = 10, @Body('sort') sort: 'buyTime' | 'createTime' = 'buyTime', @Body('keyword') keyWord: string = '') {
        const userId = this.ctx.user.id;
        return this.ok(await this.userCourseService.page(userId, page, size, sort, keyWord));
    }
}
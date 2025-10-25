import { CoolController } from '@cool-midway/core';
import { Body, Get, Inject, Post, Query } from '@midwayjs/core';
import { BaseController } from '../../../base/controller/base';
import { RechargeCodeService } from '../../service/recharge_code';

@CoolController({
    service: RechargeCodeService,
})
export class SiteRechargeCodeController extends BaseController {
    @Inject()
    rechargeCodeService: RechargeCodeService;

    @Inject()
    ctx;

    @Post('/use', { summary: '使用充值码' })
    async use(@Body('code') code: string) {
        const userId = this.ctx.user.id;
        return this.ok(await this.rechargeCodeService.use(code, userId));
    }

    @Post('/history', { summary: '充值记录' })
    async history(@Body('page') page: number = 1, @Body('size') size: number = 10) {
        const userId = this.ctx.user.id;
        return this.ok(await this.rechargeCodeService.history(userId, page, size));
    }
}
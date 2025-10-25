import { RechargeCodeEntity } from '../../entity/recharge_code';
import { CoolController } from '@cool-midway/core';
import { BaseController } from '../../../base/controller/base';
import { RechargeCodeService } from '../../service/recharge_code';
import { Inject } from '@midwayjs/core';
import { Post } from '@midwayjs/core';
import { Body } from '@midwayjs/core';

@CoolController({
    api: ['add', 'delete', 'update', 'info', 'list', 'page'],
    entity: RechargeCodeEntity,
    service: RechargeCodeService,
    pageQueryOp: {
        fieldEq: ['userId', 'amount', 'status'],
        fieldLike: ['code'],
    },
})
export class RechargeCodeController extends BaseController {
    @Inject()
    rechargeCodeService: RechargeCodeService;

    @Post('/generate', { summary: '生成充值码' })
    async generate(@Body('count') count: number, @Body('amount') amount: number, @Body('expireTime') expireTime: Date) {
        return this.ok(await this.rechargeCodeService.generate(count, amount, expireTime));
    }
}

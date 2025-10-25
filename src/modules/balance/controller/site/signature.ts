import { CoolController } from '@cool-midway/core';
import { BaseController } from '../../../base/controller/base';
import { BalanceDateSignatureService } from '../../service/date_signature';
import { BalanceDateSignatureEntity } from '../../entity/date_signature';
import { Inject, Post } from '@midwayjs/core';

@CoolController({
    api: ['info', 'list', 'page'],
    entity: BalanceDateSignatureEntity,
    service: BalanceDateSignatureService,
})
export class SiteBalanceDateSignatureController extends BaseController {
    @Inject()
    balanceDateSignatureService: BalanceDateSignatureService;

    @Inject()
    ctx;

    @Post('/check', { summary: '检查日期签名' })
    async check() {
        const userId = this.ctx.user.id;
        return this.ok(await this.balanceDateSignatureService.checkDateSignature(userId));
    }

    @Post('/generate', { summary: '生成日期签名' })
    async generate() {
        const userId = this.ctx.user.id;
        return this.ok(await this.balanceDateSignatureService.generateDateSignature(userId));
    }
}

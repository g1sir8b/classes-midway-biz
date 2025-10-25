import { CoolController } from '@cool-midway/core';
import { OrderEntity } from '../../entity/order';
import { OrderService } from '../../service/order';
import { Body, Inject, Post } from '@midwayjs/core';
import { BaseController } from '../../../base/controller/base';

@CoolController({
  entity: OrderEntity,
  service: OrderService,
})
export class SiteContentOrderController extends BaseController {
  @Inject()
  orderService: OrderService;

  @Inject()
  ctx;

  @Post('/create', { summary: '创建订单' })
  async create(@Body('courseId') courseId: number) {
    return this.ok(await this.orderService.create(courseId, this.ctx.user.id));
  }

  @Post('/history', { summary: '订单记录' })
  async history(@Body('page') page: number = 1, @Body('size') size: number = 10) {
    const userId = this.ctx.user.id;
    return this.ok(await this.orderService.history(userId, page, size));
  }
}

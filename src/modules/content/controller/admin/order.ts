import { CoolController } from '@cool-midway/core';
import { OrderEntity } from '../../entity/order';
import { OrderService } from '../../service/order';
import { BaseController } from '../../../base/controller/base';
import { Inject, Post } from '@midwayjs/core';
import { Body } from '@midwayjs/core';
@CoolController({
  api: ['info', 'list', 'page', 'delete'],
  entity: OrderEntity,
  service: OrderService,
  pageQueryOp: {
    fieldEq: ['userId', 'goodsId', 'type', 'isPay'],
    fieldLike: ['orderNo', 'goodsName'],
  },
})
export class OrderController extends BaseController {
  @Inject()
  orderService: OrderService;

  /**
   * 手动退单
   */
  @Post('/refund', { summary: '手动退单' })
  async refund(@Body('id') id: number) {
    return this.ok(await this.orderService.refund(id));
  }
}

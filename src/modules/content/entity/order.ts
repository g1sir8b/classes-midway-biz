import { BaseEntity } from '../../base/entity/base';
import { Column, Entity } from 'typeorm';

/**
 * 订单详情
 */
@Entity('content_order')
export class OrderEntity extends BaseEntity {
  @Column({ comment: '订单号', nullable: true })
  orderNo: string;

  @Column({ comment: '用户ID', type: 'int' })
  userId: number;

  @Column({ comment: '商品ID', type: 'int' })
  goodsId: number;

  @Column({ comment: '商品名称', type: 'varchar', length: 255 })
  goodsName: string;

  @Column({ comment: '商品封面', nullable: true })
  cover: string;

  @Column({ comment: '商品类型 1-课程', type: 'tinyint' })
  type: number;
  
  @Column({ comment: '商品价格', type: 'decimal', precision: 11, scale: 2 })
  goodsPrice: number;

  @Column({ comment: '实付金额', type: 'decimal', precision: 11, scale: 2 })
  realAmount: number;

  @Column({ comment: '是否支付', type: 'tinyint' })
  isPay: number;
}

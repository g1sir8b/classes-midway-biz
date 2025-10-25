import { Provide, Inject } from '@midwayjs/core';
import { BaseService, CoolCommException } from '@cool-midway/core';
import { OrderEntity } from '../entity/order';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { Repository } from 'typeorm';
import * as moment from 'moment';
import { UserInfoEntity } from '../../user/entity/info';
import { CourseEntity } from '../entity/course';
import { BalanceHistoryEntity } from '../../balance/entity/history';
import { UserCourseEntity } from '../entity/user_course';

@Provide()
export class OrderService extends BaseService {
  @InjectEntityModel(OrderEntity)
  orderRepo: Repository<OrderEntity>;

  @InjectEntityModel(UserInfoEntity)
  userInfoRepo: Repository<UserInfoEntity>;

  @InjectEntityModel(CourseEntity)
  courseRepo: Repository<CourseEntity>;

  @InjectEntityModel(BalanceHistoryEntity)
  balanceHistoryRepo: Repository<BalanceHistoryEntity>;

  @InjectEntityModel(UserCourseEntity)
  userCourseRepo: Repository<UserCourseEntity>;

  /**
   * 生成订单号
   * @param orderId
   */
  async generateOrderNum(label = 'W') {
    const orderNum =
      moment().format('YYYYMMDDHHmmss') +
      Math.floor(Math.random() * 1000000).toString().padStart(6, '0');
    return label + orderNum;
  }

  /**
   * 创建订单
   * @param courseId 课程ID
   * @param userId 用户ID
   */
  async create(courseId: number, userId: number) {
    const tenantId = this.baseCtx.headers['x-tenant-id'];

    const user = await this.userInfoRepo.findOneBy({ id: userId, tenantId: Number(tenantId) });
    if (!user) {
      throw new CoolCommException('用户不存在');
    }

    const course = await this.courseRepo.findOneBy({ id: courseId, tenantId: Number(tenantId) });
    if (!course) {
      throw new CoolCommException('课程不存在');
    }

    if (user.balance < course.price) {
      throw new CoolCommException('余额不足');
    }

    // 生成订单号
    const orderNo = await this.generateOrderNum();
    await this.orderRepo.insert({
      userId,
      type: 1,
      goodsId: courseId,
      isPay: 1, // Not paid yet
      tenantId: Number(tenantId),
      realAmount: course.price,
      goodsPrice: course.price,
      orderNo,
      cover: course.coverImage,
      goodsName: course.name,
    });
    
    // 扣减余额
    await this.userInfoRepo.update(userId, { balance: () => `balance - ${course.price}` });
    // 保存余额历史
    await this.balanceHistoryRepo.insert({
      userId,
      amount: course.price,
      type: 1,
      orderNo,
      tenantId: Number(tenantId),
      rechargeCode: null,
    });
    // 更新课程销售次数
    await this.courseRepo.update(courseId, { salesCount: () => `salesCount + 1` });

    // 保存用户课程
    await this.userCourseRepo.insert({
      userId,
      courseId,
      orderNo,
      tenantId: Number(tenantId),
    });
  }

  /**
   * 手动退单
   * @param id 订单ID
   */
  async refund(id: number) {
    const order = await this.orderRepo.findOneBy({ id });
    if (!order) {
      throw new CoolCommException('订单不存在');
    }
    await this.orderRepo.update(id, { isPay: 0 });
    await this.userInfoRepo.update(order.userId, { balance: () => `balance + ${order.realAmount}` });
    await this.balanceHistoryRepo.insert({
      userId: order.userId,
      amount: order.realAmount,
      type: 2,
      orderNo: order.orderNo,
    });
    await this.userCourseRepo.delete({ orderNo: order.orderNo });
  }


  /**
   * 订单记录
   * @param userId 用户ID
   * @param page 页码
   * @param size 每页条数
   */
  async history(userId: number, page: number = 1, size: number = 10) {
    const tenantId = this.baseCtx.headers['x-tenant-id'];
    const skip = (Number(page) - 1) * Number(size);
    const take = Number(size);
    const [list, total] = await this.orderRepo.findAndCount({
      where: { userId, tenantId: Number(tenantId) },
      order: { createTime: 'DESC' },
      skip,
      take,
    });
    return { list, pagination: { page: Number(page), size: Number(size), total } };
  }
}

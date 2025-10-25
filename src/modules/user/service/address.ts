import { Init, Inject, Provide } from '@midwayjs/core';
import { Equal, Repository } from 'typeorm';
import { UserAddressEntity } from '../entity/address';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { BaseNewService } from '../../base/service/base';
/**
 * 地址
 */
@Provide()
export class UserAddressService extends BaseNewService {
  @InjectEntityModel(UserAddressEntity)
  userAddressEntity: Repository<UserAddressEntity>;

  @Inject()
  ctx;

  @Init()
  async init() {
    await super.init();
    this.setEntity(this.userAddressEntity);
  }

  /**
   * 列表信息
   */
  async list() {
    return this.userAddressEntity
      .createQueryBuilder()
      .where('userId = :userId ', { userId: this.ctx.user.id })
      .andWhere('tenantId = :tenantId', { tenantId: this.ctx.user.tenantId })
      .addOrderBy('isDefault', 'DESC')
      .getMany();
  }

  /**
   * 修改之后
   * @param data
   * @param type
   */
  async modifyAfter(data: any, type: 'add' | 'update' | 'delete') {
    if (type == 'add' || type == 'update') {
      if (data.isDefault) {
        await this.userAddressEntity
          .createQueryBuilder()
          .update()
          .set({ isDefault: false })
          .where('userId = :userId and id != :id', {
            userId: this.ctx.user.id,
            id: data.id,
          })
          .andWhere('id != :id', { id: data.id })
          .execute();
      }
    }
  }

  /**
   * 默认地址
   */
  async default(userId) {
    return await this.userAddressEntity.findOneBy({
      userId: Equal(userId),
      isDefault: true,
    });
  }
}

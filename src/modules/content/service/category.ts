import { Provide, Inject } from '@midwayjs/core';
import { BaseService } from '@cool-midway/core';
import { ContentCategoryEntity } from '../entity/category';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { Repository } from 'typeorm';

@Provide()
export class ContentCategoryService extends BaseService {
  @InjectEntityModel(ContentCategoryEntity)
  contentCategoryRepo: Repository<ContentCategoryEntity>;

  @Inject()
  ctx: any;

  async list(params: any) {
    // 处理tenantId没传时的
    const tenantId = this.ctx?.admin?.tenantId||this.ctx?.headers['x-tenant-id'];
    if (!tenantId) {
      // 获取tenantId为空的
      const queryBuilder =
        this.contentCategoryRepo.createQueryBuilder('contentCategory');
      queryBuilder.where('contentCategory.tenantId is null');
      queryBuilder.orderBy('contentCategory.orderNum', 'ASC');
      return await queryBuilder.getMany();
    }
    const queryBuilder =
      this.contentCategoryRepo.createQueryBuilder('contentCategory');
    queryBuilder.where('contentCategory.tenantId = :tenantId', { tenantId });
    queryBuilder.orderBy('contentCategory.orderNum', 'ASC');
    return await queryBuilder.getMany();
  }

  async modifyBefore(
    data: any,
    type: 'delete' | 'update' | 'add'
  ): Promise<void> {
    if (type === 'add') {
      data.tenantId = this.ctx?.admin?.tenantId || this.ctx?.headers['x-tenant-id'];
    }
  }
}

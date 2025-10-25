import { Body, Inject, Post, Provide } from '@midwayjs/core';
import { CoolController } from '@cool-midway/core';
import { BaseSysTenantRegisterEntity } from '../../../entity/sys/tenant_register';
import { BaseSysTenantRegisterService } from '../../../service/sys/tenant_register';
import { BaseController } from '../../base';

/**
 * 租户注册
 */
@Provide()
@CoolController({
  api: ['update', 'info', 'list', 'page'],
  entity: BaseSysTenantRegisterEntity,
  service: BaseSysTenantRegisterService,
  pageQueryOp: {
    keyWordLikeFields: ['tenantName', 'contactName', 'contactEmail'],
    fieldEq: ['auditStatus'],
  },
})
export class BaseSysTenantRegisterController extends BaseController {
  @Inject()
  baseSysTenantRegisterService: BaseSysTenantRegisterService;

  /**
   * 审核
   */
  @Post('/audit', { summary: '审核' })
  async audit(
    @Body('id') id: number,
    @Body('status') status: number,
    @Body('remark') remark?: string,
    @Body('moduleIds') moduleIds?: number[]
  ) {
    await this.baseSysTenantRegisterService.audit(
      id,
      status,
      remark,
      moduleIds
    );
    return this.ok();
  }

  /**
   * 获取待审核列表
   */
  @Post('/pendingList', { summary: '获取待审核列表' })
  async pendingList() {
    return this.ok(await this.baseSysTenantRegisterService.getPendingList());
  }
} 
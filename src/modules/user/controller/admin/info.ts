import { CoolController } from '@cool-midway/core';
import { UserInfoEntity } from '../../entity/info';
import { UserInfoService } from '../../service/info';
import { BaseController } from '../../../base/controller/base';
/**
 * 用户信息
 */
@CoolController({
  api: ['add', 'delete', 'update', 'info', 'list', 'page'],
  entity: UserInfoEntity,
  service: UserInfoService,
  pageQueryOp: {
    fieldEq: ['a.status', 'a.gender', 'a.loginType'],
    keyWordLikeFields: ['a.nickName', 'a.phone'],
  },
})
export class AdminUserInfoController extends BaseController {}

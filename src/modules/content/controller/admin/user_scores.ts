import { CoolController } from '@cool-midway/core';
import { UserScoresEntity } from '../../entity/user_scores';
import { UserScoresService } from '../../service/user_scores';
import { BaseController } from '../../../base/controller/base';
@CoolController({
  api: ['info', 'list', 'page'],
  entity: UserScoresEntity,
  service: UserScoresService,
})
export class UserScoresController extends BaseController {}

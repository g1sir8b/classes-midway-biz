import { Provide } from '@midwayjs/core';
import { BaseService } from '@cool-midway/core';
import { UserScoresEntity } from '../entity/user_scores';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { Repository } from 'typeorm';

@Provide()
export class UserScoresService extends BaseService {
  @InjectEntityModel(UserScoresEntity)
  userScoresRepo: Repository<UserScoresEntity>;
}

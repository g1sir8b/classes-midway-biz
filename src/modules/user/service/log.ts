import { CoolCommException, BaseService } from '@cool-midway/core';
import { Provide } from '@midwayjs/core';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { Repository } from 'typeorm';
import { UserRequestLogEntity } from '../entity/log';

@Provide()
export class UserRequestLogService extends BaseService {
  @InjectEntityModel(UserRequestLogEntity)
  userRequestLogEntity: Repository<UserRequestLogEntity>;

  async createLog(log: {
    userId: number;
    computerId: string;
    url: string | undefined;
    suspiciousOperation: string | undefined;
    suspiciousOperationIp: string | undefined;
    type: number;
    tenantId: number;
    ip: string;
  }) {
    await this.userRequestLogEntity.save(log);
  }
}

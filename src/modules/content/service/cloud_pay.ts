import { BaseService } from '@cool-midway/core';
import { Config, Provide } from '@midwayjs/core';

@Provide()
export class CloudPayService extends BaseService {
  @Config('cloudPay')
  cloudPay: any;
}

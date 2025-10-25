import { Provide } from '@midwayjs/core';
import { BaseService } from '@cool-midway/core';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { Repository } from 'typeorm';
import { BalanceDateSignatureEntity } from '../entity/date_signature';
import * as dayjs from 'dayjs';
import { UserInfoEntity } from '../../user/entity/info';

@Provide()
export class BalanceDateSignatureService extends BaseService {
    @InjectEntityModel(BalanceDateSignatureEntity)
    balanceDateSignatureEntity: Repository<BalanceDateSignatureEntity>;

    @InjectEntityModel(UserInfoEntity)
    userInfoEntity: Repository<UserInfoEntity>;

    /**
     * 生成日期签名
     * @param userId 用户ID
     * @param date 日期
     */
    async generateDateSignature(userId: number) {
        const tenantId = this.baseCtx.headers['x-tenant-id'];
        const date = dayjs().format('YYYY-MM-DD');
        if (await this.checkDateSignature(userId)) {
            return;
        }
        await this.userInfoEntity.update(userId, { scores: () => `scores + 1` });
        await this.balanceDateSignatureEntity.save({ userId, date, tenantId: Number(tenantId) });
    }

    /**
     * 检查日期签名
     * @param userId 用户ID
     * @param date 日期
     */
    async checkDateSignature(userId: number) {
        const tenantId = this.baseCtx.headers['x-tenant-id'];
        const date = dayjs().format('YYYY-MM-DD');
        const signature = await this.balanceDateSignatureEntity.findOneBy({ userId, date, tenantId: Number(tenantId) });
        if (signature) {
            return true;
        }
        return false;
    }
}

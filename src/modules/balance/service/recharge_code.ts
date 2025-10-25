import { RechargeCodeEntity } from '../entity/recharge_code';
import { Provide } from '@midwayjs/core';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { Repository } from 'typeorm';
import { BaseService } from '@cool-midway/core';
import { v4 as uuidv4 } from 'uuid';
import { UserInfoEntity } from '../../user/entity/info';
import { BalanceHistoryEntity } from '../entity/history';
import { CoolCommException } from '@cool-midway/core';

@Provide()
export class RechargeCodeService extends BaseService {
    @InjectEntityModel(RechargeCodeEntity)
    rechargeCodeEntity: Repository<RechargeCodeEntity>;

    @InjectEntityModel(UserInfoEntity)
    userInfoEntity: Repository<UserInfoEntity>;

    @InjectEntityModel(BalanceHistoryEntity)
    balanceHistoryEntity: Repository<BalanceHistoryEntity>;

    async generate(count: number, amount: number, expireTime: Date) {
        const codes = [];
        for (let i = 0; i < count; i++) {
            // 生成36位随机字符串，使用uuidv4
            const code = uuidv4();
            codes.push({ code, amount, expireTime });
        }
        await this.rechargeCodeEntity.insert(codes);
        return codes.map(code => code.code);
    }

    async use(code: string, userId: number) {
        const tenantId = this.baseCtx.headers['x-tenant-id'];
        // 查询充值码
        const rechargeCode = await this.rechargeCodeEntity.findOne({ where: { code, status: 0, tenantId: Number(tenantId) } });
        if (!rechargeCode) {
            throw new CoolCommException('充值码不存在');
        }
        // 更新充值码状态
        await this.rechargeCodeEntity.update(rechargeCode.id, { status: 1, userId, useTime: new Date(), tenantId: Number(tenantId) });
        // 更新用户余额
        await this.userInfoEntity.update(userId, { balance: () => `balance + ${rechargeCode.amount}` });
        // 保存余额历史
        await this.balanceHistoryEntity.save({ userId, amount: rechargeCode.amount, type: 0, rechargeCode: rechargeCode.code, tenantId: Number(tenantId) });
    }

    async history(userId: number, page: number = 1, size: number = 10) {
        const tenantId = this.baseCtx.headers['x-tenant-id'];
        const skip = (Number(page) - 1) * Number(size);
        const take = Number(size);
        
        const [list, total] = await this.balanceHistoryEntity.findAndCount({ 
            where: { userId, tenantId: Number(tenantId) }, 
            order: { createTime: 'DESC' },
            skip,
            take
        });
        
        return {
            list,
            pagination: {
                page: Number(page),
                size: Number(size),
                total
            }
        };
    }
}

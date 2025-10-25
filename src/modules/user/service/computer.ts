import { BaseService } from "@cool-midway/core";
import { Provide } from "@midwayjs/core";
import { InjectEntityModel } from "@midwayjs/typeorm";
import { Repository } from "typeorm";
import { UserComputerEntity } from "../entity/computer";

@Provide()
export class UserComputerService extends BaseService {
    @InjectEntityModel(UserComputerEntity)
    userComputerEntity: Repository<UserComputerEntity>;

    async getUserComputers(userId: number) {
        return await this.userComputerEntity.find({
            where: {
                userId: userId
            }
        });
    }

    // 获取最新登录的计算机
    async isEndLogin(userId: number, tenantId: number, computerId: string) {
        const computer = await this.userComputerEntity.findOne({
            where: {
                userId: userId,
                tenantId: tenantId
            },
            order: {
                lastLoginTime: 'DESC'
            }
        });
        const isEndLogin = computer?.computerId === computerId;
        return isEndLogin;
    }

}
import { BaseService } from '@cool-midway/core';
import { In, Not } from 'typeorm';

export class BaseNewService extends BaseService {
    constructor() {
        super();
    }

    private validateOrder(order: string): 'ASC' | 'DESC' {
        const upperOrder = order?.toUpperCase();
        return (upperOrder === 'ASC' || upperOrder === 'DESC') ? upperOrder : 'DESC';
    }

    private validateSort(sort: string): string {
        // List of valid sort fields - add more as needed
        const validSortFields = ['createTime', 'updateTime', 'orderNum', 'id'];
        return validSortFields.includes(sort) ? sort : 'createTime';
    }

    async modifyBefore(data: any, type: 'delete' | 'update' | 'add') {
        if (type === 'add') {
            data.tenantId = this.baseCtx?.admin?.tenantId;
        } else if (type === 'update') {
            const info = await this.service.info(data.id);
            if (info.tenantId !== this.baseCtx.admin.tenantId) {
                throw new Error('没有权限');
            }
        } else if (type === 'delete') {
            // 查询 ids 对应的数据是否有tenantId对不上的
            const list = await this.service.entity.find({
                where: {
                    id: In(data),
                    tenantId: Not(this.baseCtx.admin.tenantId),
                },
            });
            if (list.length > 0) {
                throw new Error('没有权限');
            }
        }
    }
    
    async page(query: any, option: any = {}, connectionName?: any): Promise<{ list: any; pagination: { page: number; size: number; total: number; }; }> {
        this.service.setEntity(this.entity);
        const { page = 1, size = 10, order = 'DESC', sort = 'createTime' } = query;
        delete query.page;
        delete query.size;
        delete query.order;
        delete query.sort;
        const skip = (Number(page) - 1) * Number(size);
        const take = Number(size);

        const queryBuilder = this.service.entity.createQueryBuilder('entity');
        queryBuilder.where('entity.tenantId = :tenantId', { tenantId: this.baseCtx.admin.tenantId });
        Object.keys(query).forEach(key => {
            queryBuilder.andWhere(`entity.${key} = :${key}`, { [key]: query[key] });
        });
        queryBuilder.skip(skip);
        queryBuilder.take(take);
        queryBuilder.orderBy(`entity.${this.validateSort(sort)}`, this.validateOrder(order));

        const [list, total] = await queryBuilder.getManyAndCount();
        
        return {
            list,
            pagination: {
                page: Number(page),
                size: Number(size),
                total
            }
        };
    }

    async list(query: any, option: any = {}, connectionName?: any): Promise<any> {
        const { order = 'DESC', sort = 'createTime' } = query;
        delete query.order;
        delete query.sort;
        this.service.setEntity(this.entity);
        const queryBuilder = this.service.entity.createQueryBuilder('entity');
        queryBuilder.where('entity.tenantId = :tenantId', { tenantId: this.baseCtx.admin.tenantId });
        Object.keys(query).forEach(key => {
            queryBuilder.andWhere(`entity.${key} = :${key}`, { [key]: query[key] });
        });
        queryBuilder.orderBy(`entity.${this.validateSort(sort)}`, this.validateOrder(order));
        return await queryBuilder.getMany();
    }
}

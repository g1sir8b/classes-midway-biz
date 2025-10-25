import { CoolController } from '@cool-midway/core';
import { UserComputerService } from '../../service/computer';
import { UserComputerEntity } from '../../entity/computer';
import { BaseController } from '../../../base/controller/base';

@CoolController({
    api: ['add', 'delete', 'update', 'info', 'list', 'page'],
    entity: UserComputerEntity,
    service: UserComputerService,
    pageQueryOp: {
        fieldEq: ['a.userId'],
    },
    listQueryOp: {
        fieldEq: ['a.userId'],
    },
})
export class AdminUserComputerController extends BaseController {
}
import { Rule, RuleType } from '@midwayjs/validate';

/**
 * 设置租户管理员账号DTO
 */
export class SetupTenantAdminDTO {
  @Rule(RuleType.string().required().max(50))
  username: string;

  @Rule(RuleType.string().required().min(6).max(20))
  password: string;

  @Rule(RuleType.string().required().max(50))
  name: string;

  @Rule(RuleType.string().email().required())
  email: string;
  
  // 租户信息加密数据
  @Rule(RuleType.string().required())
  verifyCode: string;
} 
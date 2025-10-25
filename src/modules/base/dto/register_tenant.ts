import { Rule, RuleType } from '@midwayjs/validate';

/**
 * 租户注册DTO
 */
export class RegisterTenantDTO {
  @Rule(RuleType.string().required().max(50))
  tenantName: string;

  @Rule(RuleType.string().required().max(50))
  contactName: string;

  @Rule(RuleType.string().email().required())
  contactEmail: string;

  @Rule(RuleType.string().max(50).optional())
  websiteName?: string;

  @Rule(RuleType.string().optional())
  websiteUsage?: string;
}

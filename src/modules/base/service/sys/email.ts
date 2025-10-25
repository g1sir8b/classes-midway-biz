import { Provide, Config, InjectClient } from '@midwayjs/core';
import { BaseService, CoolCommException } from '@cool-midway/core';
import * as _ from 'lodash';
import { CachingFactory, MidwayCache } from '@midwayjs/cache-manager';
import { ConfidentialClientApplication } from '@azure/msal-node';
import { ClientSecretCredential } from '@azure/identity';
import { Client } from '@microsoft/microsoft-graph-client';
import 'isomorphic-fetch';

@Provide()
export class EmailService extends BaseService {
  @Config('azure')
  azureConfig: any;

  @InjectClient(CachingFactory, 'default')
  midwayCache: MidwayCache;

  /**
   * 更新Azure Access Token
   */
  async updateAzureAccessToken() {
    // MSAL 配置
    const msalConfig = {
      auth: {
        clientId: this.azureConfig.clientId,
        clientSecret: this.azureConfig.clientSecret,
        authority: `https://login.microsoftonline.com/${this.azureConfig.tenantId}`,
      },
    };

    const msalClient = new ConfidentialClientApplication(msalConfig);

    const token = await msalClient.acquireTokenByClientCredential({
      scopes: ['https://outlook.office365.com/.default'],
    });

    this.midwayCache.set('azure-access-token', token.accessToken, 60 * 1000);

    return token.accessToken;
  }

  /**
   * 获取 Microsoft Graph Client
   */
  private async getGraphClient() {
    const credentials = new ClientSecretCredential(
      this.azureConfig.tenantId,
      this.azureConfig.clientId,
      this.azureConfig.clientSecret
    );

    return Client.initWithMiddleware({
      baseUrl: 'https://graph.microsoft.com',
      authProvider: {
        getAccessToken: async () => {
          const token = await credentials.getToken([
            'https://graph.microsoft.com/.default',
          ]);
          return token.token;
        },
      },
    });
  }

  /**
   * 发送邮件
   * @param to 收件人
   * @param subject 主题
   * @param text 内容
   */
  async sendEmail(to: string, subject: string, text: string) {
    try {
      const client = await this.getGraphClient();

      const message = {
        subject: subject,
        body: {
          contentType: 'HTML',
          content: text,
        },
        from: {
          emailAddress: {
            address: this.azureConfig.user,
          },
        },
        toRecipients: [
          {
            emailAddress: {
              address: to,
            },
          },
        ],
      };

      // Changed from /me/sendMail to /users/{user}/sendMail
      await client.api(`/users/${this.azureConfig.user}/sendMail`).post({
        message: message,
        saveToSentItems: true,
      });
    } catch (error) {
      if (error.code === 'ErrorAccessDenied') {
        throw new CoolCommException(
          '权限被拒绝，请确保已正确配置应用权限并获得管理员同意。' +
            '错误信息：' +
            (error.message || '未知错误')
        );
      }

      if (error.statusCode === 401) {
        throw new CoolCommException(
          '认证失败，请检查凭据配置是否正确。' +
            '错误信息：' +
            (error.message || '未知错误')
        );
      }

      throw new CoolCommException(
        '发送邮件失败：' + (error.message || '未知错误')
      );
    }
  }
}

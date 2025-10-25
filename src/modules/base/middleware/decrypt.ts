import { Config, IMiddleware, Middleware } from '@midwayjs/core';
import { NextFunction, Context } from '@midwayjs/koa';
import { sm2, sm4 } from 'sm-crypto-v2';

/**
 * 日志中间件
 */
@Middleware()
export class BaseDecryptMiddleware
  implements IMiddleware<Context, NextFunction>
{
  @Config('encrypt')
  encrypt: {
    enable: boolean;
    privateKey: string;
    ignoreUrls: string[];
  };
  resolve() {
    return async (ctx: Context, next: NextFunction) => {
      if (this.encrypt.enable) {
        const secret = ctx.get('Connection-Secret');
        if (secret) {
          const sm4Key = sm2.doDecrypt(secret, this.encrypt.privateKey);
          ctx.sm4Key = sm4Key;

          // 检查是否为FormData上传，如果是则跳过解密处理
          const contentType = ctx.get('Content-Type') || '';
          if (contentType.includes('multipart/form-data')) {
            console.log('检测到FormData上传，跳过解密处理');
            await next();
            return;
          }
          const body = ctx.request.rawBody;
          if (body) {
            const decryptedBody = sm4.decrypt(body as string, sm4Key, {
              mode: 'ecb',
              output: 'string',
            });
            // 尝试解析为JSON对象
            try {
              ctx.request.body = JSON.parse(decryptedBody);
            } catch (error) {
              // 如果解析失败，保持为字符串
              ctx.request.body = decryptedBody;
            }
          }
        }
      }
      await next();
    };
  }
}

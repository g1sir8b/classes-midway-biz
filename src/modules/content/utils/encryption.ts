import * as crypto from 'crypto';
import { hmacMD5String } from './hash';

/**
 * 生成加密信息
 * @param randomUuid UUID作为基础种子
 * @param hex 十六进制字符串作为额外熵源
 * @returns 包含key和iv的加密信息对象
 */
export function generateEncryptionInfo(randomUuid: string, hex: string) {
  // 生成 key 和 iv 的十六进制字符串
  const keyHex = hmacMD5String(randomUuid, hex);
  const ivHex = hmacMD5String(hex, randomUuid);

  return {
    // 将十六进制字符串转换为 Buffer
    key: Buffer.from(keyHex, 'hex'), // 16字节
    iv: Buffer.from(ivHex, 'hex'), // 16字节
  };
}

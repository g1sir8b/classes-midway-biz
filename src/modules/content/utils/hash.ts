import * as crypto from 'crypto';

/**
 * 使用HMAC-MD5生成哈希字符串
 * @param text 要哈希的文本
 * @param key 密钥
 * @returns 十六进制格式的哈希字符串
 */
export function hmacMD5String(text: string, key: string): string {
  return crypto.createHmac('md5', key).update(text).digest('hex');
}

/**
 * 使用SHA256生成哈希字符串
 * @param text 要哈希的文本
 * @returns 十六进制格式的哈希字符串
 */
export function sha256String(text: string): string {
  return crypto.createHash('sha256').update(text).digest('hex');
}

/**
 * 生成指定长度的随机字节
 * @param length 字节长度
 * @returns Buffer containing random bytes
 */
export function generateRandomBytes(length: number): Buffer {
  return crypto.randomBytes(length);
}

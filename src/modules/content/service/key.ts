import { Provide, Inject } from '@midwayjs/core';
import { BaseService, CoolCommException } from '@cool-midway/core';
import { InjectEntityModel } from '@midwayjs/typeorm';
import { Repository } from 'typeorm';
import { CourseKeyEntity } from '../entity/key';
import { v4 as uuid } from 'uuid';
import { generateRandomBytes } from '../utils/hash';
import { generateEncryptionInfo } from '../utils/encryption';
import { hmacMD5String } from '../utils/hash';

@Provide()
export class CourseKeyService extends BaseService {
  @InjectEntityModel(CourseKeyEntity)
  courseKeyEntity: Repository<CourseKeyEntity>;

  @Inject()
  ctx;

  async generate(count: number, courseId: number) {
    const keys = [];
    for (let i = 0; i < count; i++) {
      // Generate base random bytes
      const randomBytes = generateRandomBytes(32);
      // Create a unique UUID for this iteration
      const randomUuid = uuid();
      // Generate encryption info using the UUID
      const encryptionInfo = generateEncryptionInfo(
        randomUuid,
        randomBytes.toString('hex')
      );
      // Combine and hash all components to create the final 80-character code
      const code = hmacMD5String(
        `${randomUuid}${encryptionInfo.key.toString(
          'hex'
        )}${encryptionInfo.iv.toString('hex')}`,
        randomBytes.toString('hex')
      ).repeat(2); // Double the length to get 80 characters

      keys.push({
        code,
        courseId,
        useStatus: 1,
        // tenantId: this.ctx?.admin?.tenantId,
      });
    }

    // Batch save all generated keys
    await this.courseKeyEntity.insert(keys);
    return keys;
  }
}

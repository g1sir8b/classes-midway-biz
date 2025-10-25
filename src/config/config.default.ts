import { CoolConfig } from '@cool-midway/core';
import { MidwayConfig } from '@midwayjs/core';
// import { CoolCacheStore } from '@cool-midway/core';
import * as path from 'path';
import { pCachePath, pUploadPath, pM3u8Path } from '../comm/path';
import { availablePort } from '../comm/port';

// redis缓存
import { redisStore } from 'cache-manager-ioredis-yet';

export default {
  // 确保每个项目唯一，项目首次启动会自动生成
  keys: '7f46715c-701d-4f8a-91f9-d521e06feadb',
  koa: {
    port: availablePort(9001),
  },
  // 开启异步上下文管理
  asyncContextManager: {
    enable: true,
  },
  // 静态文件配置
  staticFile: {
    buffer: true,
    dirs: {
      default: {
        prefix: '/',
        dir: path.join(__dirname, '..', '..', 'public'),
      },
      static: {
        prefix: '/upload',
        dir: pUploadPath(),
      },
      m3u8: {
        prefix: '/m3u8',
        dir: pM3u8Path(),
      },
    },
  },
  // 文件上传
  upload: {
    fileSize: '200mb',
    whitelist: null,
  },
  // 缓存 可切换成其他缓存如：redis http://www.midwayjs.org/docs/extensions/caching
  // cacheManager: {
  //   clients: {
  //     default: {
  //       store: CoolCacheStore,
  //       options: {
  //         path: pCachePath(),
  //         ttl: 0,
  //       },
  //     },
  //   },
  // },
  cacheManager: {
    clients: {
      default: {
        store: redisStore,
        options: {
          port: 6379,
          host: '1Panel-redis-SekC',
          password: 'redis_yzakZY',
          ttl: 0,
          db: 0,
        },
      },
    },
  },
  cool: {
    // 已经插件化，本地文件上传查看 plugin/config.ts，其他云存储查看对应插件的使用
    file: {},
    // 是否开启多租户
    tenant: {
      // 是否开启多租户
      enable: true,
      // 需要过滤多租户的url, 支持通配符， 如/admin/**/* 表示admin模块下的所有接口都进行多租户过滤
      urls: ['/admin/**/*'],
    },
    // 国际化配置
    i18n: {
      // 是否开启
      enable: true,
      // 语言
      languages: ['zh-cn', 'zh-tw', 'en'],
    },
    redis: {
      host: '1Panel-redis-SekC',
      port: 6379,
      password: 'redis_yzakZY',
      db: 0,
    },
    // crud配置
    crud: {
      // 插入模式，save不会校验字段(允许传入不存在的字段)，insert会校验字段
      upsert: 'save',
      // 软删除
      softDelete: true,
    },
  } as CoolConfig,
  // 邮件相关配置
  azure: {
    user: '',
    clientId: '',
    clientSecret: '',
    tenantId: '',
  },
  cloudPay: {
    url: 'http://192.168.1.44:18080',
    key: '5306cf72d4f27793429b3bb5dcbdb944',
  },
  encrypt: {
    enable: true,
    privateKey:
      '3df1731290d4af51d03dd812a24835da2290bb9b010f459cc557149edc1ff784',
    publicKey:
      '04ce30361a0ac41644812fbba53214feaeb1ab5c8034948ca7cb77749b4aaf06e60fd3c291dc31d68b4187db11318fbc0a6bf6f79f5bd81d6b40722f0ce54c7ebc',
    ignoreUrls: ['/admin/base/open/eps', '/admin/dict/info/types','/admin/base/comm/program','/site/base/comm/upload'],
  },
} as MidwayConfig;

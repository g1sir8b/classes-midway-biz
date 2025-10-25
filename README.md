# Coloso Midway 业务系统

基于 Midway.js 和 COOL-Admin 构建的课程加密系统，提供课程内容管理、用户权限控制和内容加密功能。

## 项目简介

Coloso Midway 业务系统是一个基于 Node.js 的后端服务，使用 Midway.js 框架和 COOL-Admin 快速开发框架构建。系统主要功能包括课程内容管理、用户权限控制、内容加密保护等，适用于在线教育平台的后端服务。

### 主要特性

- **课程内容管理**：支持课程创建、编辑、分类和内容管理
- **用户权限控制**：基于角色的权限管理系统，支持多级权限控制
- **内容加密保护**：使用 SM2/SM4 加密算法保护课程内容
- **课程密钥管理**：生成和管理课程访问密钥
- **多语言支持**：支持中文、英文和繁体中文
- **Swagger API 文档**：自动生成 API 文档

## 技术栈

- **框架**：Midway.js、COOL-Admin
- **数据库**：MySQL (TypeORM)
- **加密**：SM2/SM4 加密算法
- **认证**：JWT、Azure AD 集成
- **任务调度**：内置定时任务系统

## 安装与使用

### 环境要求

- Node.js >= 18.0.0
- MySQL >= 5.7
- Redis (可选，用于缓存)

### 安装步骤

1. 克隆代码库

```bash
git clone <repository-url>
cd coloso-midway-biz
```

2. 安装依赖

```bash
npm install
```

3. 配置环境变量

创建 `.env` 文件并配置必要的环境变量：

```
# 数据库配置
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=password
MYSQL_DATABASE=coloso

# JWT 配置
JWT_SECRET=your-jwt-secret

# Azure 配置
AZURE_CLIENT_SECRET=your-azure-client-secret
```

4. 初始化数据库

```bash
# 导入初始数据
mysql -u root -p coloso < data.sql
```

5. 启动开发服务器

```bash
npm run dev
```

6. 构建生产环境

```bash
npm run build
```

7. 启动生产服务器

```bash
npm start
```

或使用 PM2 管理进程：

```bash
npm run pm2:start
```

## 项目结构

```
coloso-midway-biz/
├── src/                    # 源代码目录
│   ├── comm/               # 通用工具
│   ├── config/             # 配置文件
│   ├── modules/            # 功能模块
│   │   ├── base/           # 基础模块（权限、用户等）
│   │   ├── content/        # 课程内容模块
│   │   ├── user/           # 用户模块
│   │   └── swagger/        # API文档模块
│   ├── locales/            # 多语言文件
│   └── index.ts            # 入口文件
├── public/                 # 静态资源
├── test/                   # 测试文件
├── typings/                # 类型定义
└── bootstrap.js            # 启动文件
```

## 主要功能模块

### 基础模块 (base)

- 用户认证与授权
- 角色与权限管理
- 部门管理
- 系统参数配置

### 内容模块 (content)

- 课程管理
- 课程内容加密
- 课程密钥生成与管理

### 用户模块 (user)

- 用户信息管理
- 用户课程关联

## 开发指南

### 添加新模块

1. 在 `src/modules` 目录下创建新模块目录
2. 添加 controller、service、entity 等文件
3. 在 `configuration.ts` 中注册模块

### API 文档

启动服务后，访问 `/swagger` 路径查看 API 文档。

## 贡献指南

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

## 许可证

本项目采用 MIT 许可证 - 详情请参阅 [LICENSE](LICENSE) 文件
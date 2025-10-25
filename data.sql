-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- 主机： mysql-prod
-- 生成日期： 2025-10-25 05:29:26
-- 服务器版本： 8.4.6
-- PHP 版本： 8.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `ucard`
--

-- --------------------------------------------------------

--
-- 表的结构 `balance_date_signature`
--

CREATE TABLE `balance_date_signature` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `userId` int DEFAULT NULL COMMENT '用户ID',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `balance_date_signature`
--

INSERT INTO `balance_date_signature` (`id`, `createTime`, `updateTime`, `tenantId`, `userId`, `date`) VALUES
(12, '2025-10-17 10:42:17', '2025-10-17 10:42:17', 20, 52, '2025-10-17'),
(13, '2025-10-18 09:36:23', '2025-10-18 09:36:23', 20, 52, '2025-10-18'),
(14, '2025-10-19 11:51:45', '2025-10-19 11:51:45', 20, 52, '2025-10-19'),
(15, '2025-10-21 03:14:19', '2025-10-21 03:14:19', 20, 52, '2025-10-21');

-- --------------------------------------------------------

--
-- 表的结构 `balance_history`
--

CREATE TABLE `balance_history` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `userId` int DEFAULT NULL COMMENT '用户ID',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  `type` tinyint NOT NULL DEFAULT '0' COMMENT '类型 0-充值 1-消费 2-退款',
  `orderNo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单号',
  `rechargeCode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '充值码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `balance_recharge_code`
--

CREATE TABLE `balance_recharge_code` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态 0-未使用 1-已使用 2-已过期',
  `useTime` datetime DEFAULT NULL COMMENT '使用时间',
  `userId` int DEFAULT NULL COMMENT '使用用户ID',
  `expireTime` datetime DEFAULT NULL COMMENT '过期时间',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  `code` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '充值码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_conf`
--

CREATE TABLE `base_sys_conf` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `cKey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置键',
  `cValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_conf`
--

INSERT INTO `base_sys_conf` (`id`, `createTime`, `updateTime`, `tenantId`, `cKey`, `cValue`) VALUES
(1, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 'logKeep', '31'),
(2, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 'recycleKeep', '31'),
(3, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 'init_db_base', 'time consuming：172ms'),
(4, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 'init_db_dict', 'time consuming：83ms'),
(5, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 'init_db_task', 'time consuming：22ms'),
(6, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 'init_menu_base', 'success');

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_department`
--

CREATE TABLE `base_sys_department` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '部门名称',
  `parentId` int DEFAULT NULL COMMENT '上级部门ID',
  `orderNum` int NOT NULL DEFAULT '0' COMMENT '排序'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_department`
--

INSERT INTO `base_sys_department` (`id`, `createTime`, `updateTime`, `tenantId`, `name`, `parentId`, `orderNum`) VALUES
(1, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 'COOL', NULL, 0),
(11, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, '开发', 12, 3),
(12, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, '测试', 1, 1),
(13, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, '游客', 12, 2),
(14, '2025-02-22 15:08:56', '2025-02-22 15:08:56', 20, '测试部门', NULL, 0),
(16, '2025-02-22 16:20:29', '2025-02-22 16:20:29', 20, '开发', 14, 2),
(17, '2025-02-22 16:27:01', '2025-02-22 16:27:01', 20, '游客', 14, 3),
(18, '2025-02-22 16:32:04', '2025-02-22 16:32:04', 20, '组长', 14, 1);

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_log`
--

CREATE TABLE `base_sys_log` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `userId` int DEFAULT NULL COMMENT '用户ID',
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '行为',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ip',
  `params` json DEFAULT NULL COMMENT '参数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_menu`
--

CREATE TABLE `base_sys_menu` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `parentId` int DEFAULT NULL COMMENT '父菜单ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
  `router` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单地址',
  `perms` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '权限标识',
  `type` int NOT NULL DEFAULT '0' COMMENT '类型 0-目录 1-菜单 2-按钮',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  `orderNum` int NOT NULL DEFAULT '0' COMMENT '排序',
  `viewPath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '视图地址',
  `keepAlive` tinyint NOT NULL DEFAULT '1' COMMENT '路由缓存',
  `isShow` tinyint NOT NULL DEFAULT '1' COMMENT '是否显示'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_menu`
--

INSERT INTO `base_sys_menu` (`id`, `createTime`, `updateTime`, `tenantId`, `parentId`, `name`, `router`, `perms`, `type`, `icon`, `orderNum`, `viewPath`, `keepAlive`, `isShow`) VALUES
(1, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, NULL, '系统管理', '/sys', NULL, 0, 'icon-set', 2, NULL, 1, 1),
(2, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 1, '权限管理', NULL, NULL, 0, 'icon-auth', 1, NULL, 0, 1),
(3, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 2, '菜单列表', '/sys/menu', NULL, 1, 'icon-menu', 2, 'modules/base/views/menu/index.vue', 1, 1),
(4, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 3, '新增', NULL, 'base:sys:menu:add', 2, NULL, 1, NULL, 0, 1),
(5, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 3, '删除', NULL, 'base:sys:menu:delete', 2, NULL, 2, NULL, 0, 1),
(6, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 3, '查询', NULL, 'base:sys:menu:page,base:sys:menu:list,base:sys:menu:info', 2, NULL, 4, NULL, 0, 1),
(7, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 3, '参数', '/test/aa', NULL, 1, 'icon-goods', 0, 'modules/base/views/info.vue', 1, 1),
(8, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 3, '编辑', NULL, 'base:sys:menu:info,base:sys:menu:update', 2, NULL, 0, NULL, 1, 1),
(9, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 2, '角色列表', '/sys/role', NULL, 1, 'icon-dept', 3, 'cool/modules/base/views/role.vue', 1, 1),
(10, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 9, '新增', NULL, 'base:sys:role:add', 2, NULL, 1, NULL, 0, 1),
(11, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 9, '删除', NULL, 'base:sys:role:delete', 2, NULL, 2, NULL, 0, 1),
(12, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 9, '修改', NULL, 'base:sys:role:update', 2, NULL, 3, NULL, 0, 1),
(13, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 9, '查询', NULL, 'base:sys:role:page,base:sys:role:list,base:sys:role:info', 2, NULL, 4, NULL, 0, 1),
(14, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 2, '用户列表', '/sys/user', NULL, 1, 'icon-user', 0, 'modules/base/views/user/index.vue', 1, 1),
(15, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 14, '部门列表', NULL, 'base:sys:department:list', 2, NULL, 0, NULL, 1, 1),
(16, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 14, '新增部门', NULL, 'base:sys:department:add', 2, NULL, 0, NULL, 1, 1),
(17, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 14, '更新部门', NULL, 'base:sys:department:update', 2, NULL, 0, NULL, 1, 1),
(18, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 14, '删除部门', NULL, 'base:sys:department:delete', 2, NULL, 0, NULL, 1, 1),
(19, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 14, '部门排序', NULL, 'base:sys:department:order', 2, NULL, 0, NULL, 1, 1),
(20, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 14, '用户转移', NULL, 'base:sys:user:move', 2, NULL, 0, NULL, 1, 1),
(21, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 14, '新增', NULL, 'base:sys:user:add', 2, NULL, 0, NULL, 1, 1),
(22, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 14, '删除', NULL, 'base:sys:user:delete', 2, NULL, 0, NULL, 1, 1),
(23, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 14, '修改', NULL, 'base:sys:user:delete,base:sys:user:update', 2, NULL, 0, NULL, 1, 1),
(24, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 14, '查询', NULL, 'base:sys:user:page,base:sys:user:list,base:sys:user:info', 2, NULL, 0, NULL, 1, 1),
(25, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 1, '参数配置', NULL, NULL, 0, 'icon-params', 3, NULL, 1, 1),
(26, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 25, '参数列表', '/sys/param', NULL, 1, 'icon-menu', 0, 'cool/modules/base/views/param.vue', 1, 1),
(27, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 26, '新增', NULL, 'base:sys:param:add', 2, NULL, 0, NULL, 1, 1),
(28, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 26, '修改', NULL, 'base:sys:param:info,base:sys:param:update', 2, NULL, 0, NULL, 1, 1),
(29, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 26, '删除', NULL, 'base:sys:param:delete', 2, NULL, 0, NULL, 1, 1),
(30, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 26, '查看', NULL, 'base:sys:param:page,base:sys:param:list,base:sys:param:info', 2, NULL, 0, NULL, 1, 1),
(31, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 1, '监控管理', NULL, NULL, 0, 'icon-monitor', 9, NULL, 1, 1),
(32, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 31, '请求日志', '/sys/log', NULL, 1, 'icon-log', 1, 'cool/modules/base/views/log.vue', 1, 1),
(33, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 32, '权限', NULL, 'base:sys:log:page,base:sys:log:clear,base:sys:log:getKeep,base:sys:log:setKeep', 2, NULL, 1, NULL, 0, 1),
(34, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 1, '任务管理', NULL, NULL, 0, 'icon-activity', 9, NULL, 1, 1),
(35, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 34, '任务列表', '/task/list', NULL, 1, 'icon-menu', 0, 'modules/task/views/list.vue', 1, 1),
(36, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 35, '权限', NULL, 'task:info:page,task:info:list,task:info:info,task:info:add,task:info:delete,task:info:update,task:info:stop,task:info:start,task:info:once,task:info:log', 2, NULL, 0, NULL, 1, 1),
(37, '2025-02-19 20:43:34', '2025-02-19 20:50:45', NULL, NULL, '框架教程', '/tutorial', NULL, 0, 'icon-task', 98, NULL, 1, 0),
(38, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 37, '文档官网', '/tutorial/doc', NULL, 1, 'icon-log', 0, 'https://admin.cool-js.com', 1, 1),
(39, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 37, 'crud 示例', '/demo/crud', NULL, 1, 'icon-favor', 1, 'modules/demo/views/crud/index.vue', 1, 1),
(40, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, NULL, '通用', NULL, NULL, 0, 'icon-radioboxfill', 99, NULL, 1, 0),
(41, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 40, '图片上传', NULL, 'space:info:page,space:info:list,space:info:info,space:info:add,space:info:delete,space:info:update,space:type:page,space:type:list,space:type:info,space:type:add,space:type:delete,space:type:update', 2, NULL, 1, NULL, 1, 1),
(42, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, NULL, '首页', '/', NULL, 1, NULL, 0, 'modules/demo/views/home/index.vue', 1, 0),
(43, '2025-02-19 20:43:34', '2025-02-19 20:51:27', NULL, 1, '数据管理', NULL, NULL, 0, 'icon-data', 7, NULL, 1, 1),
(44, '2025-02-19 20:43:34', '2025-04-17 15:42:02', NULL, 43, '系统字典', '/dict/list', NULL, 1, 'icon-dict', 3, 'modules/dict/views/list.vue', 1, 1),
(45, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 44, '删除', NULL, 'dict:info:delete', 2, NULL, 0, NULL, 1, 1),
(46, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 44, '修改', NULL, 'dict:info:update,dict:info:info', 2, NULL, 0, NULL, 1, 1),
(47, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 44, '获得字典数据', NULL, 'dict:info:data', 2, NULL, 0, NULL, 1, 1),
(48, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 44, '单个信息', NULL, 'dict:info:info', 2, NULL, 0, NULL, 1, 1),
(49, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 44, '列表查询', NULL, 'dict:info:list', 2, NULL, 0, NULL, 1, 1),
(50, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 44, '分页查询', NULL, 'dict:info:page', 2, NULL, 0, NULL, 1, 1),
(51, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 44, '新增', NULL, 'dict:info:add', 2, NULL, 0, NULL, 1, 1),
(52, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 44, '组权限', NULL, 'dict:type:list,dict:type:update,dict:type:delete,dict:type:add', 2, NULL, 0, NULL, 1, 1),
(53, '2025-02-19 20:43:34', '2025-04-19 12:49:32', NULL, 44, '字典类型', NULL, 'dict:type:info,dict:type:list,dict:type:page', 2, NULL, 0, NULL, 1, 1),
(54, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 43, '数据回收站', '/recycle/data', NULL, 1, 'icon-delete', 6, 'modules/recycle/views/data.vue', 1, 1),
(55, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 54, '恢复数据', NULL, 'recycle:data:restore', 2, NULL, 0, NULL, 1, 1),
(56, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 54, '单个信息', NULL, 'recycle:data:info', 2, NULL, 0, NULL, 1, 1),
(57, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 54, '分页查询', NULL, 'recycle:data:page', 2, NULL, 0, NULL, 1, 1),
(58, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 43, '文件管理', '/upload/list', NULL, 1, 'icon-log', 5, 'modules/space/views/list.vue', 1, 1),
(59, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 58, '权限', NULL, 'space:type:delete,space:type:update,space:type:info,space:type:list,space:type:page,space:type:add,space:info:getConfig,space:info:delete,space:info:update,space:info:info,space:info:list,space:info:page,space:info:add', 2, NULL, 0, NULL, 1, 1),
(60, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, NULL, '用户管理', NULL, NULL, 0, 'icon-user', 11, NULL, 1, 1),
(61, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 60, '用户列表', '/user/list', NULL, 1, 'icon-menu', 1, 'modules/user/views/list.vue', 1, 1),
(62, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 61, '删除', NULL, 'user:info:delete', 2, NULL, 0, NULL, 1, 1),
(63, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 61, '修改', NULL, 'user:info:update,user:info:info', 2, NULL, 0, NULL, 1, 1),
(64, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 61, '单个信息', NULL, 'user:info:info', 2, NULL, 0, NULL, 1, 1),
(65, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 61, '列表查询', NULL, 'user:info:list', 2, NULL, 0, NULL, 1, 1),
(66, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 61, '分页查询', NULL, 'user:info:page', 2, NULL, 0, NULL, 1, 1),
(67, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 61, '新增', NULL, 'user:info:add', 2, NULL, 0, NULL, 1, 1),
(68, '2025-02-19 20:43:34', '2025-02-19 20:50:57', NULL, 1, '扩展管理', NULL, NULL, 0, 'icon-favor', 8, NULL, 1, 1),
(69, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 68, '插件列表', '/helper/plugins', NULL, 1, 'icon-list', 1, 'modules/helper/views/plugins.vue', 1, 1),
(70, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 69, '删除', NULL, 'plugin:info:delete', 2, NULL, 0, NULL, 1, 1),
(71, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 69, '分页查询', NULL, 'plugin:info:page', 2, NULL, 0, NULL, 1, 1),
(72, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 69, '单个信息', NULL, 'plugin:info:info', 2, NULL, 0, NULL, 1, 1),
(73, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 69, '安装插件', NULL, 'plugin:info:install', 2, NULL, 0, NULL, 1, 1),
(74, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 69, '修改', NULL, 'plugin:info:update', 2, NULL, 0, NULL, 1, 1),
(75, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 69, '列表查询', NULL, 'plugin:info:list', 2, NULL, 0, NULL, 1, 1),
(76, '2025-02-19 20:43:34', '2025-02-19 20:43:34', NULL, 69, '新增', NULL, 'plugin:info:add', 2, NULL, 0, NULL, 1, 1),
(77, '2025-02-19 20:51:59', '2025-02-19 20:52:10', NULL, NULL, '平台管理', NULL, NULL, 0, 'icon-menu', 10, NULL, 1, 1),
(78, '2025-02-19 21:22:30', '2025-02-20 22:29:36', NULL, 77, '租户管理', '/base/sys/tenant', NULL, 1, 'icon-workbench', 1, 'modules/base/views/sys/tenant.vue', 0, 1),
(79, '2025-02-19 21:22:30', '2025-02-19 21:22:30', NULL, 78, '删除', NULL, 'base:sys:tenant:delete', 2, NULL, 0, NULL, 1, 1),
(80, '2025-02-19 21:22:30', '2025-02-19 21:22:30', NULL, 78, '修改', NULL, 'base:sys:tenant:update,base:sys:tenant:info', 2, NULL, 0, NULL, 1, 1),
(81, '2025-02-19 21:22:30', '2025-02-19 21:22:30', NULL, 78, '单个信息', NULL, 'base:sys:tenant:info', 2, NULL, 0, NULL, 1, 1),
(82, '2025-02-19 21:22:30', '2025-02-19 21:22:30', NULL, 78, '列表查询', NULL, 'base:sys:tenant:list', 2, NULL, 0, NULL, 1, 1),
(83, '2025-02-19 21:22:30', '2025-02-19 21:22:30', NULL, 78, '分页查询', NULL, 'base:sys:tenant:page', 2, NULL, 0, NULL, 1, 1),
(84, '2025-02-19 21:22:30', '2025-02-19 21:22:30', NULL, 78, '新增', NULL, 'base:sys:tenant:add', 2, NULL, 0, NULL, 1, 1),
(85, '2025-02-20 09:20:25', '2025-02-20 22:29:36', NULL, 77, '租户申请', '/base/sys/tenant_register', NULL, 1, 'icon-list', 0, 'modules/base/views/sys/tenant_register.vue', 0, 1),
(86, '2025-02-20 09:20:25', '2025-02-20 14:31:10', NULL, 85, '审核通过', NULL, 'base:sys:tenant_register:audit', 2, NULL, 0, NULL, 1, 1),
(87, '2025-02-20 09:20:25', '2025-02-20 09:20:25', NULL, 85, '获取待审核列表', NULL, 'base:sys:tenant_register:pendingList', 2, NULL, 0, NULL, 1, 1),
(90, '2025-02-20 09:20:25', '2025-02-20 09:20:25', NULL, 85, '单个信息', NULL, 'base:sys:tenant_register:info', 2, NULL, 0, NULL, 1, 1),
(91, '2025-02-20 09:20:25', '2025-02-20 09:20:25', NULL, 85, '列表查询', NULL, 'base:sys:tenant_register:list', 2, NULL, 0, NULL, 1, 1),
(92, '2025-02-20 09:20:25', '2025-02-20 09:20:25', NULL, 85, '分页查询', NULL, 'base:sys:tenant_register:page', 2, NULL, 0, NULL, 1, 1),
(94, '2025-02-20 11:19:53', '2025-02-20 22:29:34', NULL, 77, '模块管理', '/base/sys/module', NULL, 1, 'icon-app', 0, 'modules/base/views/sys/module.vue', 0, 1),
(95, '2025-02-20 11:19:53', '2025-02-20 11:19:53', NULL, 94, '删除', NULL, 'base:sys:module:delete', 2, NULL, 0, NULL, 1, 1),
(96, '2025-02-20 11:19:53', '2025-02-20 11:19:53', NULL, 94, '修改', NULL, 'base:sys:module:update,base:sys:module:info', 2, NULL, 0, NULL, 1, 1),
(97, '2025-02-20 11:19:53', '2025-02-20 11:19:53', NULL, 94, '单个信息', NULL, 'base:sys:module:info', 2, NULL, 0, NULL, 1, 1),
(98, '2025-02-20 11:19:53', '2025-02-20 11:19:53', NULL, 94, '列表查询', NULL, 'base:sys:module:list', 2, NULL, 0, NULL, 1, 1),
(99, '2025-02-20 11:19:53', '2025-02-20 11:19:53', NULL, 94, '分页查询', NULL, 'base:sys:module:page', 2, NULL, 0, NULL, 1, 1),
(100, '2025-02-20 11:19:53', '2025-02-20 11:19:53', NULL, 94, '新增', NULL, 'base:sys:module:add', 2, NULL, 0, NULL, 1, 1),
(101, '2025-02-24 19:51:33', '2025-02-24 21:26:52', NULL, NULL, '授课系统', NULL, NULL, 0, 'icon-device', 20, NULL, 1, 1),
(116, '2025-04-14 23:16:56', '2025-04-14 23:16:56', NULL, 101, '课程管理', '/content/course', NULL, 1, 'icon-menu', 2, 'modules/content/views/course.vue', 0, 1),
(117, '2025-04-14 23:16:56', '2025-04-14 23:16:56', NULL, 116, '删除', NULL, 'content:course:delete', 2, NULL, 0, NULL, 1, 1),
(118, '2025-04-14 23:16:56', '2025-04-14 23:16:56', NULL, 116, '修改', NULL, 'content:course:update,content:course:info', 2, NULL, 0, NULL, 1, 1),
(119, '2025-04-14 23:16:56', '2025-04-14 23:16:56', NULL, 116, '单个信息', NULL, 'content:course:info', 2, NULL, 0, NULL, 1, 1),
(120, '2025-04-14 23:16:56', '2025-04-14 23:16:56', NULL, 116, '列表查询', NULL, 'content:course:list', 2, NULL, 0, NULL, 1, 1),
(121, '2025-04-14 23:16:56', '2025-04-14 23:16:56', NULL, 116, '分页查询', NULL, 'content:course:page', 2, NULL, 0, NULL, 1, 1),
(122, '2025-04-14 23:16:56', '2025-04-14 23:16:56', NULL, 116, '新增', NULL, 'content:course:add', 2, NULL, 0, NULL, 1, 1),
(123, '2025-04-16 23:01:52', '2025-04-17 21:06:59', NULL, 101, '课程视频管理', '/content/course_content', NULL, 1, 'icon-video', 3, 'modules/content/views/video.vue', 0, 0),
(124, '2025-04-16 23:01:52', '2025-04-16 23:01:52', NULL, 123, '删除', NULL, 'content:course_content:delete', 2, NULL, 0, NULL, 1, 1),
(125, '2025-04-16 23:01:52', '2025-04-16 23:01:52', NULL, 123, '修改', NULL, 'content:course_content:update,content:course_content:info', 2, NULL, 0, NULL, 1, 1),
(126, '2025-04-16 23:01:52', '2025-04-16 23:01:52', NULL, 123, '单个信息', NULL, 'content:course_content:info', 2, NULL, 0, NULL, 1, 1),
(127, '2025-04-16 23:01:52', '2025-04-16 23:01:52', NULL, 123, '列表查询', NULL, 'content:course_content:list', 2, NULL, 0, NULL, 1, 1),
(128, '2025-04-16 23:01:52', '2025-04-16 23:01:52', NULL, 123, '分页查询', NULL, 'content:course_content:page', 2, NULL, 0, NULL, 1, 1),
(129, '2025-04-16 23:01:52', '2025-04-16 23:01:52', NULL, 123, '新增', NULL, 'content:course_content:add', 2, NULL, 0, NULL, 1, 1),
(158, '2025-04-17 20:30:01', '2025-04-17 20:43:23', NULL, 172, '订单列表', '/content/order', NULL, 1, 'icon-list', 1, 'modules/content/views/order.vue', 0, 1),
(159, '2025-04-17 20:30:02', '2025-10-14 16:08:05', NULL, 158, '删除', NULL, 'content:order:refund,content:order:delete', 2, NULL, 0, NULL, 1, 1),
(160, '2025-04-17 20:30:02', '2025-04-17 20:30:02', NULL, 158, '修改', NULL, 'content:order:update,content:order:info', 2, NULL, 0, NULL, 1, 1),
(161, '2025-04-17 20:30:02', '2025-04-17 20:30:02', NULL, 158, '单个信息', NULL, 'content:order:info', 2, NULL, 0, NULL, 1, 1),
(162, '2025-04-17 20:30:02', '2025-04-17 20:30:02', NULL, 158, '列表查询', NULL, 'content:order:list', 2, NULL, 0, NULL, 1, 1),
(163, '2025-04-17 20:30:02', '2025-04-17 20:30:02', NULL, 158, '分页查询', NULL, 'content:order:page', 2, NULL, 0, NULL, 1, 1),
(164, '2025-04-17 20:30:02', '2025-04-17 20:30:02', NULL, 158, '新增', NULL, 'content:order:add', 2, NULL, 0, NULL, 1, 1),
(165, '2025-04-17 20:33:21', '2025-04-17 21:04:29', NULL, 60, '用户积分', '/content/user_scores', NULL, 1, 'icon-db', 1, 'modules/content/views/user_scores.vue', 0, 0),
(166, '2025-04-17 20:33:21', '2025-04-17 20:33:21', NULL, 165, '删除', NULL, 'content:user_scores:delete', 2, NULL, 0, NULL, 1, 1),
(167, '2025-04-17 20:33:21', '2025-04-17 20:33:21', NULL, 165, '修改', NULL, 'content:user_scores:update,content:user_scores:info', 2, NULL, 0, NULL, 1, 1),
(168, '2025-04-17 20:33:21', '2025-04-17 20:33:21', NULL, 165, '单个信息', NULL, 'content:user_scores:info', 2, NULL, 0, NULL, 1, 1),
(169, '2025-04-17 20:33:21', '2025-04-17 20:33:21', NULL, 165, '列表查询', NULL, 'content:user_scores:list', 2, NULL, 0, NULL, 1, 1),
(170, '2025-04-17 20:33:21', '2025-04-17 20:33:21', NULL, 165, '分页查询', NULL, 'content:user_scores:page', 2, NULL, 0, NULL, 1, 1),
(171, '2025-04-17 20:33:21', '2025-04-17 20:33:21', NULL, 165, '新增', NULL, 'content:user_scores:add', 2, NULL, 0, NULL, 1, 1),
(172, '2025-04-17 20:41:19', '2025-04-17 20:41:19', NULL, NULL, '订单管理', NULL, NULL, 0, 'icon-cart', 19, NULL, 1, 1),
(173, '2025-04-19 12:50:20', '2025-04-19 12:50:20', NULL, 44, '字典类型修改', NULL, 'dict:type:add,dict:type:update,dict:type:delete', 2, NULL, 1, NULL, 1, 1),
(174, '2025-04-29 12:19:36', '2025-04-29 21:34:00', NULL, 101, '激活码', '/content/key', NULL, 1, 'icon-unlock', 1, 'modules/content/views/key.vue', 0, 0),
(176, '2025-04-29 12:19:36', '2025-04-29 12:19:36', NULL, 174, '列表查询', NULL, 'content:key:list', 2, NULL, 0, NULL, 1, 1),
(177, '2025-04-29 12:19:36', '2025-04-29 12:19:36', NULL, 174, '分页查询', NULL, 'content:key:page', 2, NULL, 0, NULL, 1, 1),
(178, '2025-04-29 12:19:36', '2025-04-29 21:37:26', NULL, 174, '新增', NULL, 'content:key:add,content:key:generate', 2, NULL, 0, NULL, 1, 1),
(179, '2025-07-01 17:20:03', '2025-07-01 17:20:03', NULL, 116, '分类权限', NULL, 'content:category:search,content:category:delete,content:category:update,content:category:info,content:category:list,content:category:page,content:category:add', 2, NULL, 0, NULL, 1, 1),
(180, '2025-07-15 13:33:06', '2025-07-15 13:40:33', NULL, 101, '视频播放', '/video/play', NULL, 1, 'icon-video', 99, 'modules/content/views/play.vue', 0, 0),
(181, '2025-08-05 22:57:59', '2025-08-05 23:04:02', NULL, 60, '用户设备', '/user/computer', NULL, 1, 'icon-component', 1, 'modules/user/views/computer.vue', 0, 0),
(182, '2025-08-05 22:58:00', '2025-08-05 22:58:00', NULL, 181, '删除', NULL, 'user:computer:delete', 2, NULL, 0, NULL, 1, 1),
(183, '2025-08-05 22:58:00', '2025-08-05 22:58:00', NULL, 181, '修改', NULL, 'user:computer:update,user:computer:info', 2, NULL, 0, NULL, 1, 1),
(184, '2025-08-05 22:58:00', '2025-08-05 22:58:00', NULL, 181, '单个信息', NULL, 'user:computer:info', 2, NULL, 0, NULL, 1, 1),
(185, '2025-08-05 22:58:00', '2025-08-05 22:58:00', NULL, 181, '列表查询', NULL, 'user:computer:list', 2, NULL, 0, NULL, 1, 1),
(186, '2025-08-05 22:58:00', '2025-08-05 22:58:00', NULL, 181, '分页查询', NULL, 'user:computer:page', 2, NULL, 0, NULL, 1, 1),
(187, '2025-08-05 22:58:00', '2025-08-05 22:58:00', NULL, 181, '新增', NULL, 'user:computer:add', 2, NULL, 0, NULL, 1, 1),
(188, '2025-10-14 12:07:18', '2025-10-14 12:07:18', NULL, 172, '充值码管理', '/balance/code', NULL, 1, 'icon-amount', 1, 'modules/balance/views/code.vue', 0, 1),
(189, '2025-10-14 12:07:18', '2025-10-14 12:07:18', NULL, 188, '生成充值码', NULL, 'balance:code:generate', 2, NULL, 0, NULL, 1, 1),
(190, '2025-10-14 12:07:18', '2025-10-14 12:07:18', NULL, 188, '删除', NULL, 'balance:code:delete', 2, NULL, 0, NULL, 1, 1),
(191, '2025-10-14 12:07:18', '2025-10-14 12:07:18', NULL, 188, '修改', NULL, 'balance:code:update,balance:code:info', 2, NULL, 0, NULL, 1, 1),
(192, '2025-10-14 12:07:18', '2025-10-14 12:07:18', NULL, 188, '单个信息', NULL, 'balance:code:info', 2, NULL, 0, NULL, 1, 1),
(193, '2025-10-14 12:07:18', '2025-10-14 12:07:18', NULL, 188, '列表查询', NULL, 'balance:code:list', 2, NULL, 0, NULL, 1, 1),
(194, '2025-10-14 12:07:18', '2025-10-14 12:07:18', NULL, 188, '分页查询', NULL, 'balance:code:page', 2, NULL, 0, NULL, 1, 1),
(195, '2025-10-14 12:07:18', '2025-10-14 12:07:18', NULL, 188, '新增', NULL, 'balance:code:add', 2, NULL, 0, NULL, 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_module`
--

CREATE TABLE `base_sys_module` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模块名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模块描述',
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模块标识',
  `orderNum` int NOT NULL DEFAULT '0' COMMENT '排序',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模块图标'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_module`
--

INSERT INTO `base_sys_module` (`id`, `createTime`, `updateTime`, `tenantId`, `name`, `description`, `key`, `orderNum`, `icon`) VALUES
(1, '2025-02-20 11:29:15', '2025-08-05 23:05:07', NULL, '用户模块', NULL, 'User', 1, '/upload/20250224/7c852d2aeaa440aa89310e11432a9b55_微信图片_20250117205051.jpg'),
(2, '2025-02-22 14:59:00', '2025-04-19 12:55:52', NULL, '系统管理', '系统管理：包含权限管理、首页、资源管理', 'System', 0, '/upload/20250224/26d23c8c575d469d82e9b629919aac93_e3a673e8f8f946fe8fd1b785f11d1034ed27e383.jpg'),
(3, '2025-02-24 22:27:39', '2025-07-15 13:35:50', NULL, '授课系统', NULL, 'course', 2, '/upload/20250224/5dec006e6ba34d809bd4a4683cacfe06_微信图片_20250117205052.jpg'),
(4, '2025-04-17 20:54:50', '2025-10-14 15:58:48', NULL, '订单模块', '订单管理', 'order', 3, '/upload/20250417/aa0938a773be4148879164e58f1fdefd_0常态.png');

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_module_menu`
--

CREATE TABLE `base_sys_module_menu` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `moduleId` int NOT NULL COMMENT '模块ID',
  `menuId` int NOT NULL COMMENT '菜单ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_module_menu`
--

INSERT INTO `base_sys_module_menu` (`id`, `createTime`, `updateTime`, `tenantId`, `moduleId`, `menuId`) VALUES
(484, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 42),
(485, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 14),
(486, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 15),
(487, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 16),
(488, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 17),
(489, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 18),
(490, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 19),
(491, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 20),
(492, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 21),
(493, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 22),
(494, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 23),
(495, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 24),
(496, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 6),
(497, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 9),
(498, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 10),
(499, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 11),
(500, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 12),
(501, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 13),
(502, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 47),
(503, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 48),
(504, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 49),
(505, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 50),
(506, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 53),
(507, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 58),
(508, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 59),
(509, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 1),
(510, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 2),
(511, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 3),
(512, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 43),
(513, '2025-04-19 12:55:52', '2025-04-19 12:55:52', NULL, 2, 44),
(612, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 101),
(613, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 174),
(614, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 176),
(615, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 177),
(616, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 178),
(617, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 116),
(618, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 117),
(619, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 118),
(620, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 119),
(621, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 120),
(622, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 121),
(623, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 122),
(624, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 179),
(625, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 123),
(626, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 124),
(627, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 125),
(628, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 126),
(629, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 127),
(630, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 128),
(631, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 129),
(632, '2025-07-15 13:35:50', '2025-07-15 13:35:50', NULL, 3, 180),
(633, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 60),
(634, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 61),
(635, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 62),
(636, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 63),
(637, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 64),
(638, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 65),
(639, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 66),
(640, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 67),
(641, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 165),
(642, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 166),
(643, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 167),
(644, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 168),
(645, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 169),
(646, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 170),
(647, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 171),
(648, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 181),
(649, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 182),
(650, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 183),
(651, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 184),
(652, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 185),
(653, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 186),
(654, '2025-08-05 23:05:07', '2025-08-05 23:05:07', NULL, 1, 187),
(671, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 172),
(672, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 158),
(673, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 159),
(674, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 160),
(675, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 161),
(676, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 162),
(677, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 163),
(678, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 164),
(679, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 188),
(680, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 189),
(681, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 190),
(682, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 191),
(683, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 192),
(684, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 193),
(685, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 194),
(686, '2025-10-14 15:58:48', '2025-10-14 15:58:48', NULL, 4, 195);

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_param`
--

CREATE TABLE `base_sys_param` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `keyName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据',
  `dataType` int NOT NULL DEFAULT '0' COMMENT '数据类型 0-字符串 1-富文本 2-文件 ',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_param`
--

INSERT INTO `base_sys_param` (`id`, `createTime`, `updateTime`, `tenantId`, `keyName`, `name`, `data`, `dataType`, `remark`) VALUES
(1, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 'rich', '富文本参数', '<h3><strong>这是一个富文本</strong></h3><p>xxx</p><p>xxxxxxxxxx</p><p><br></p>', 1, NULL),
(2, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 'json', 'JSON参数', '{\n  \"code\": 111233\n}', 0, NULL),
(3, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 'file', '文件', '', 2, NULL),
(4, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 'text', '测试', '这是一段字符串', 0, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_role`
--

CREATE TABLE `base_sys_role` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `userId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色标签',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `relevance` tinyint NOT NULL DEFAULT '0' COMMENT '数据权限是否关联上下级',
  `menuIdList` json NOT NULL COMMENT '菜单权限',
  `departmentIdList` json NOT NULL COMMENT '部门权限'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_role`
--

INSERT INTO `base_sys_role` (`id`, `createTime`, `updateTime`, `tenantId`, `userId`, `name`, `label`, `remark`, `relevance`, `menuIdList`, `departmentIdList`) VALUES
(1, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, '1', '超管', 'admin', '最高权限的角色', 0, '\"null\"', '\"null\"'),
(2, '2025-02-19 20:48:57', '2025-02-20 11:07:55', NULL, '1', '开发者', 'dev', '开发人员', 0, '[42, 1, 2, 14, 21, 22, 23, 15, 16, 17, 18, 3, 7, 24, 4, 8, 6, 9, 10, 5, 11, 12, 25, 13, 26, 27, 29, 30, 28, 31, 33, 32, 34, 36, 35, 53, 43, 44, 45, 52, 46, 20, 19, 48, 47, 50, 49, 51, 58, 54, 59, 56, 57, 55, 68, 69, 75, 74, 73, 76, 72, 71, 70, 60, 61, 64, 63, 62, 65, 67, 66, 39, 37, 38, 40, 41]', '[1, 12, 11, 13]'),
(4, '2025-02-22 16:10:28', '2025-04-17 16:55:08', 20, '5', '测试角色', 'DevTest', NULL, 0, '[42, 1, 2, 14, 17, 15, 16, 18, 19, 20, 21, 22, 23, 24, 3, 6, 9, 10, 11, 12, 13, 43, 44, 50, 49, 48, 47, 53, 52, 58, 59, 101, 123, 129, 128, 124, 125, 126, 127, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122]', '[14, 17]');

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_role_department`
--

CREATE TABLE `base_sys_role_department` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `roleId` int NOT NULL COMMENT '角色ID',
  `departmentId` int NOT NULL COMMENT '部门ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_role_department`
--

INSERT INTO `base_sys_role_department` (`id`, `createTime`, `updateTime`, `tenantId`, `roleId`, `departmentId`) VALUES
(9, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 12),
(10, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 1),
(11, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 13),
(12, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 11),
(14, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 14),
(24, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 14),
(25, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 17),
(26, '2025-04-19 12:39:50', '2025-04-19 12:39:50', NULL, 5, 12),
(27, '2025-05-01 01:26:44', '2025-05-01 01:26:44', NULL, 6, 14),
(28, '2025-05-01 01:26:44', '2025-05-01 01:26:44', NULL, 6, 18),
(29, '2025-05-01 01:26:44', '2025-05-01 01:26:44', NULL, 6, 16),
(30, '2025-05-01 01:26:44', '2025-05-01 01:26:44', NULL, 6, 17);

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_role_menu`
--

CREATE TABLE `base_sys_role_menu` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `roleId` int NOT NULL COMMENT '角色ID',
  `menuId` int NOT NULL COMMENT '菜单ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_role_menu`
--

INSERT INTO `base_sys_role_menu` (`id`, `createTime`, `updateTime`, `tenantId`, `roleId`, `menuId`) VALUES
(153, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 42),
(154, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 1),
(155, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 2),
(156, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 14),
(157, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 18),
(158, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 3),
(159, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 21),
(160, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 22),
(161, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 23),
(162, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 15),
(163, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 16),
(164, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 17),
(165, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 7),
(166, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 24),
(167, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 4),
(168, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 8),
(169, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 6),
(170, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 9),
(171, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 10),
(172, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 5),
(173, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 11),
(174, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 13),
(175, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 12),
(176, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 25),
(177, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 26),
(178, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 27),
(179, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 29),
(180, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 30),
(181, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 28),
(182, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 31),
(183, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 33),
(184, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 32),
(185, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 34),
(186, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 36),
(187, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 35),
(188, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 53),
(189, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 44),
(190, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 43),
(191, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 45),
(192, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 52),
(193, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 46),
(194, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 20),
(195, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 19),
(196, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 48),
(197, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 49),
(198, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 51),
(199, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 47),
(200, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 50),
(201, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 58),
(202, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 59),
(203, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 56),
(204, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 54),
(205, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 57),
(206, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 55),
(207, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 69),
(208, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 68),
(209, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 75),
(210, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 74),
(211, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 73),
(212, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 76),
(213, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 72),
(214, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 71),
(215, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 70),
(216, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 61),
(217, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 60),
(218, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 63),
(219, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 64),
(220, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 62),
(221, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 65),
(222, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 66),
(223, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 39),
(224, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 67),
(225, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 37),
(226, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 41),
(227, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 38),
(228, '2025-02-20 11:07:55', '2025-02-20 11:07:55', NULL, 2, 40),
(262, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 1),
(263, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 2),
(264, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 14),
(265, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 16),
(266, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 21),
(267, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 17),
(268, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 24),
(269, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 23),
(270, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 22),
(271, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 20),
(272, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 15),
(273, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 18),
(274, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 19),
(275, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 6),
(276, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 9),
(277, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 10),
(278, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 11),
(279, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 12),
(280, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 13),
(281, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 43),
(282, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 44),
(283, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 3),
(284, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 47),
(285, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 48),
(286, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 50),
(287, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 51),
(288, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 49),
(289, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 52),
(290, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 46),
(291, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 53),
(292, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 45),
(293, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 58),
(294, '2025-02-22 16:07:03', '2025-02-22 16:07:03', NULL, 3, 59),
(526, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 42),
(527, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 1),
(528, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 2),
(529, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 14),
(530, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 17),
(531, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 16),
(532, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 15),
(533, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 19),
(534, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 18),
(535, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 20),
(536, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 21),
(537, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 22),
(538, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 23),
(539, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 24),
(540, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 3),
(541, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 6),
(542, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 9),
(543, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 10),
(544, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 11),
(545, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 12),
(546, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 13),
(547, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 43),
(548, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 44),
(549, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 50),
(550, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 49),
(551, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 48),
(552, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 47),
(553, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 53),
(554, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 52),
(555, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 58),
(556, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 59),
(557, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 101),
(558, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 123),
(559, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 129),
(560, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 128),
(561, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 124),
(562, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 125),
(563, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 127),
(564, '2025-04-17 16:55:08', '2025-04-17 16:55:08', NULL, 4, 126),
(565, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 109),
(566, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 110),
(567, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 111),
(568, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 112),
(569, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 113),
(570, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 114),
(571, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 115),
(572, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 116),
(573, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 117),
(574, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 118),
(575, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 119),
(576, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 120),
(577, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 121),
(578, '2025-04-17 16:55:09', '2025-04-17 16:55:09', NULL, 4, 122),
(579, '2025-04-19 12:39:49', '2025-04-19 12:39:49', NULL, 5, 42),
(580, '2025-05-01 01:26:44', '2025-05-01 01:26:44', NULL, 6, 42);

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_tenant`
--

CREATE TABLE `base_sys_tenant` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `tenantName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '租户名称',
  `tenantCode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '租户编码',
  `tenantDesc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '租户描述',
  `tenantExpireTime` datetime DEFAULT NULL COMMENT '到期时间',
  `entraTenantId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Microsoft 365 租户ID',
  `entraClientId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Microsoft 365 客户端ID',
  `entraClientSecret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Microsoft 365 客户端密钥',
  `entraEmail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Microsoft 365 邮箱',
  `tenantBlockStatus` int NOT NULL DEFAULT '0' COMMENT '封禁状态 0: 正常 1: 封禁',
  `tenantBlockReason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封禁原因',
  `tenantContactEmail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系邮箱',
  `isInit` tinyint NOT NULL DEFAULT '0' COMMENT '是否初始化'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_tenant`
--

INSERT INTO `base_sys_tenant` (`id`, `createTime`, `updateTime`, `tenantId`, `tenantName`, `tenantCode`, `tenantDesc`, `tenantExpireTime`, `entraTenantId`, `entraClientId`, `entraClientSecret`, `entraEmail`, `tenantBlockStatus`, `tenantBlockReason`, `tenantContactEmail`, `isInit`) VALUES
(20, '2025-02-22 10:42:30', '2025-02-22 10:42:30', NULL, '测试', 'Q6AFMT', '', '2026-03-24 00:00:00', '', '', '', '', 0, NULL, 'xxxxxx@qq.com', 1);

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_tenant_menu`
--

CREATE TABLE `base_sys_tenant_menu` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `menuId` int NOT NULL COMMENT '菜单ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_tenant_module`
--

CREATE TABLE `base_sys_tenant_module` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `moduleId` int NOT NULL COMMENT '模块ID',
  `tenantPrimaryId` int NOT NULL COMMENT '租户ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_tenant_module`
--

INSERT INTO `base_sys_tenant_module` (`id`, `createTime`, `updateTime`, `tenantId`, `moduleId`, `tenantPrimaryId`) VALUES
(65, '2025-10-14 12:17:59', '2025-10-14 12:17:59', NULL, 2, 20),
(66, '2025-10-14 12:17:59', '2025-10-14 12:17:59', NULL, 3, 20),
(67, '2025-10-14 12:17:59', '2025-10-14 12:17:59', NULL, 1, 20),
(68, '2025-10-14 12:17:59', '2025-10-14 12:17:59', NULL, 4, 20);

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_tenant_register`
--

CREATE TABLE `base_sys_tenant_register` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `tenantName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '租户名称',
  `contactName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系人',
  `contactEmail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系人邮箱',
  `auditStatus` int NOT NULL DEFAULT '0' COMMENT '审核状态 0-待审核 1-审核通过 2-审核拒绝',
  `auditRemark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '审核意见',
  `auditTime` datetime DEFAULT NULL COMMENT '审核时间',
  `auditorId` int DEFAULT NULL COMMENT '审核人ID',
  `websiteName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '网站名称',
  `websiteUsage` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '网站用途'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_tenant_register`
--

INSERT INTO `base_sys_tenant_register` (`id`, `createTime`, `updateTime`, `tenantId`, `tenantName`, `contactName`, `contactEmail`, `auditStatus`, `auditRemark`, `auditTime`, `auditorId`, `websiteName`, `websiteUsage`) VALUES
(6, '2025-02-22 10:42:19', '2025-02-22 10:42:19', NULL, '测试', 'xxxxxx', 'xxxxxx@qq.com', 1, NULL, '2025-02-22 10:42:39', 1, 'BlenderCG.', 'CG资源分享');

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_user`
--

CREATE TABLE `base_sys_user` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `departmentId` int DEFAULT NULL COMMENT '部门ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `passwordV` int NOT NULL DEFAULT '1' COMMENT '密码版本, 作用是改完密码，让原来的token失效',
  `nickName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `headImg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态 0-禁用 1-启用',
  `socketId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'socketId',
  `isSuperAdmin` tinyint NOT NULL DEFAULT '0' COMMENT '是否超级管理员'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_user`
--

INSERT INTO `base_sys_user` (`id`, `createTime`, `updateTime`, `tenantId`, `departmentId`, `name`, `username`, `password`, `passwordV`, `nickName`, `headImg`, `phone`, `email`, `remark`, `status`, `socketId`, `isSuperAdmin`) VALUES
(1, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 1, '超级管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 7, '管理员', NULL, '18000000000', '', '拥有最高权限的用户', 1, NULL, 0),
(2, '2025-02-19 20:49:51', '2025-02-19 20:49:51', NULL, 11, '内容管理员', 'bs_stock', 'e10adc3949ba59abbe56e057f20f883e', 2, '内容管理员', 'http://10.8.0.2:9001/upload/20250220/ef85afc23c3b497ab657af0fa300ebcb_e3a673e8f8f946fe8fd1b785f11d1034ed27e383.jpg', NULL, NULL, NULL, 1, NULL, 0),
(5, '2025-02-22 10:42:54', '2025-02-22 10:42:54', 20, NULL, '课程管理员', 'cg_admin', 'e10adc3949ba59abbe56e057f20f883e', 1, '课程管理员', '', NULL, 'xxx@qq.com', NULL, 1, NULL, 1);

-- --------------------------------------------------------

--
-- 表的结构 `base_sys_user_role`
--

CREATE TABLE `base_sys_user_role` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `userId` int NOT NULL COMMENT '用户ID',
  `roleId` int NOT NULL COMMENT '角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `base_sys_user_role`
--

INSERT INTO `base_sys_user_role` (`id`, `createTime`, `updateTime`, `tenantId`, `userId`, `roleId`) VALUES
(1, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 1, 1),
(5, '2025-02-22 10:43:10', '2025-02-22 10:43:10', NULL, 5, 1),
(8, '2025-02-22 16:15:09', '2025-02-22 16:15:09', NULL, 7, 4),
(9, '2025-02-22 16:15:15', '2025-02-22 16:15:15', NULL, 6, 4),
(18, '2025-04-19 13:06:27', '2025-04-19 13:06:27', NULL, 8, 4),
(19, '2025-08-29 16:14:58', '2025-08-29 16:14:58', 20, 8, 4),
(21, '2025-08-29 19:47:10', '2025-08-29 19:47:10', NULL, 2, 2);

-- --------------------------------------------------------

--
-- 表的结构 `content_category`
--

CREATE TABLE `content_category` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类描述',
  `orderNum` int NOT NULL DEFAULT '0' COMMENT '排序号',
  `isShow` tinyint NOT NULL DEFAULT '1' COMMENT '是否显示',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类图标',
  `skillType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '技能类型',
  `parentId` bigint DEFAULT NULL COMMENT '父分类ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `content_category`
--

INSERT INTO `content_category` (`id`, `createTime`, `updateTime`, `tenantId`, `name`, `description`, `orderNum`, `isShow`, `icon`, `skillType`, `parentId`) VALUES
(31, '2025-07-01 16:14:46', '2025-09-18 14:50:41', 20, '电影动画', NULL, 2, 1, NULL, NULL, NULL),
(32, '2025-07-01 16:15:15', '2025-09-19 17:00:44', 20, '建模雕刻', NULL, 0, 1, NULL, 'modeling-sculpting', 31),
(33, '2025-07-01 16:36:16', '2025-09-19 16:55:28', 20, '材质纹理', NULL, 0, 1, NULL, 'materials', 31),
(35, '2025-07-01 19:42:14', '2025-09-19 17:00:19', 20, '渲染合成', NULL, 0, 1, NULL, 'rendering-compositing', 31),
(41, '2025-09-17 16:32:29', '2025-09-18 14:42:56', 20, '游戏美术', '学习数字插画、传统绘画技巧，从基础到进阶，掌握各种风格的插画创作方法。', 1, 1, NULL, NULL, NULL),
(42, '2025-09-17 16:41:42', '2025-09-19 16:49:21', 20, '建模雕刻', NULL, 1, 1, NULL, 'modeling-sculpting', 41),
(43, '2025-09-17 16:48:56', '2025-09-19 16:50:00', 20, '贴图绘制', NULL, 2, 1, NULL, 'texture-painting', 41),
(44, '2025-09-17 16:50:50', '2025-09-19 16:49:44', 20, '材质纹理', NULL, 3, 1, NULL, 'materials', 41),
(45, '2025-09-17 16:51:34', '2025-09-19 16:49:00', 20, '游戏特效', NULL, 4, 1, NULL, 'vfx', 41),
(46, '2025-09-17 16:54:51', '2025-09-19 16:50:19', 20, '游戏场景', NULL, 5, 1, NULL, 'scene-design', 41),
(47, '2025-09-17 16:58:08', '2025-09-19 16:56:40', 20, '视觉特效', NULL, 4, 1, NULL, 'vfx', 31),
(48, '2025-09-17 16:58:47', '2025-09-19 16:56:08', 20, '动画绑定', NULL, 5, 1, NULL, 'rigging', 31),
(49, '2025-09-17 17:05:31', '2025-09-17 17:05:31', 20, '游戏引擎', NULL, 3, 1, NULL, NULL, NULL),
(50, '2025-09-17 17:06:21', '2025-09-19 16:54:58', 20, '特效开发', NULL, 1, 1, NULL, 'game-effects', 49),
(51, '2025-09-17 17:08:21', '2025-09-19 16:52:21', 20, '系统开发', NULL, 2, 1, NULL, 'system-development', 49),
(52, '2025-09-17 17:09:45', '2025-09-19 16:52:52', 20, '脚本编程', NULL, 3, 1, NULL, 'scripting', 49),
(53, '2025-09-17 17:10:50', '2025-09-19 16:53:06', 20, 'VR虚拟现实', NULL, 4, 1, NULL, NULL, 49),
(55, '2025-09-18 14:49:31', '2025-09-19 16:50:34', 20, '游戏角色', NULL, 6, 1, NULL, 'production', 41),
(56, '2025-09-18 14:54:32', '2025-09-19 16:57:10', 20, '场景制作', NULL, 6, 1, NULL, 'scene-design', 31),
(57, '2025-09-18 14:54:48', '2025-09-19 16:57:24', 20, '角色制作', NULL, 7, 1, NULL, 'production', 31),
(58, '2025-09-18 14:57:52', '2025-09-18 14:57:52', 20, '概念设计', NULL, 4, 1, NULL, NULL, NULL),
(59, '2025-09-18 15:01:41', '2025-09-19 16:58:19', 20, '设计理论', NULL, 1, 1, NULL, 'design-theory', 58),
(60, '2025-09-18 15:02:41', '2025-09-19 16:58:37', 20, '游戏原画', NULL, 2, 1, NULL, 'game-concept', 58),
(61, '2025-09-18 15:03:55', '2025-09-19 16:58:43', 20, '手办制作', NULL, 3, 1, NULL, 'figurine-making', 58),
(62, '2025-09-18 15:23:32', '2025-09-18 15:23:32', 20, '影视后期', NULL, 5, 1, NULL, NULL, NULL),
(63, '2025-09-18 15:26:22', '2025-09-19 16:59:33', 20, '后期特效', NULL, 1, 1, NULL, 'post-production', 62),
(64, '2025-09-18 15:27:57', '2025-09-19 16:56:23', 20, '渲染合成', NULL, 2, 1, NULL, 'rendering-compositing', 31),
(65, '2025-09-18 15:30:06', '2025-09-19 16:53:50', 20, '影像后期', NULL, 3, 1, NULL, 'video-post', 62),
(66, '2025-09-18 15:31:44', '2025-09-19 16:53:32', 20, '视频剪辑', NULL, 4, 1, NULL, 'video-editing', 62),
(67, '2025-09-18 15:35:10', '2025-09-18 15:35:10', 20, '建筑设计', NULL, 6, 1, NULL, NULL, NULL),
(68, '2025-09-18 15:35:36', '2025-09-19 16:59:54', 20, '场景建模', NULL, 1, 1, NULL, 'modeling-sculpting', 67),
(69, '2025-09-18 15:35:53', '2025-09-19 16:58:51', 20, '虚拟现实', NULL, 2, 1, NULL, 'vr', 67),
(70, '2025-09-18 15:36:55', '2025-09-18 15:36:55', 20, '平面设计', NULL, 7, 1, NULL, NULL, NULL),
(71, '2025-09-18 15:37:13', '2025-09-19 16:52:03', 20, 'UI 设计', NULL, 1, 1, NULL, 'ui', 70);

-- --------------------------------------------------------

--
-- 表的结构 `content_course`
--

CREATE TABLE `content_course` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '课程描述',
  `originalPrice` decimal(10,2) NOT NULL COMMENT '原价',
  `price` decimal(10,2) NOT NULL COMMENT '实际售价',
  `salesCount` int NOT NULL DEFAULT '0' COMMENT '销售次数',
  `viewCount` int NOT NULL DEFAULT '0' COMMENT '访问量',
  `coverImage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '课程封面图',
  `backgroundImage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '背景图',
  `duration` int NOT NULL DEFAULT '0' COMMENT '课程时长(分钟)',
  `isPublished` tinyint NOT NULL DEFAULT '1' COMMENT '课程状态',
  `sseKeywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'SSE关键字',
  `categoryIds` json NOT NULL COMMENT '所属分类ID',
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '课程简介',
  `teachingSoftware` json DEFAULT NULL COMMENT '涉及教学软件',
  `isRecommend` tinyint NOT NULL DEFAULT '0' COMMENT '是否推荐课程',
  `skills` json DEFAULT NULL COMMENT '技能',
  `level` tinyint NOT NULL DEFAULT '0' COMMENT '级别  1入门课程 2初级课程 3中级课程 4高级课程 5专家课程'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `content_course`
--

INSERT INTO `content_course` (`id`, `createTime`, `updateTime`, `tenantId`, `name`, `description`, `originalPrice`, `price`, `salesCount`, `viewCount`, `coverImage`, `backgroundImage`, `duration`, `isPublished`, `sseKeywords`, `categoryIds`, `introduction`, `teachingSoftware`, `isRecommend`, `skills`, `level`) VALUES
(48, '2025-10-17 14:25:00', '2025-10-17 14:27:36', 20, '仅展示-虚拟角色动画制作特训营', '教程包含角色模型制作，多表情手工雕刻，角色皮肤纹理制作，角色表情动画制作，角色表情绑定，及新版Xgen毛发制作等。同时也会对学员进行个人审美弹性训练，殿堂级构图灯光技巧，艺术照渲染技巧，更加涵盖讲解表情捕捉，渲染合成，以及音频制作等模块化的影音全方位系统知识', 6499.00, 65.00, 0, 329, '/oss/upload/20251017/62658d0904a043b6b724b5aae77f86cc_16499915268781.jpg', '/oss/upload/20251017/a2bda019eb244a278b8b6f4e5b4e430b_1649989194.jpg', 0, 1, '猫大人', '[41, 31]', '<p><img src=\"/oss/upload/20251017/c25c977b50c849a9838a486df1ea6cf9_d52c046f-e39f-40f0-aad0-d518624555c0.png\" alt=\"\" data-href=\"\" style=\"\"/><img src=\"/oss/upload/20251017/21eb7fbe5cd44f7483e721697c2c4b68_1ccf00d2-11a9-4c3c-96f4-7600310a56ac.png\" alt=\"\" data-href=\"\" style=\"\"/><img src=\"/oss/upload/20251017/37c733f2305d42be916374940b0fc2d7_b9f1debf-3086-4ad0-993e-caf155279762.png\" alt=\"\" data-href=\"\" style=\"\"/><img src=\"/oss/upload/20251017/8386211ca2ec4386a769caedfb4dbbcc_b964ec08-0b50-43e1-a234-3de30acd3225.png\" alt=\"\" data-href=\"\" style=\"\"/><img src=\"/oss/upload/20251017/4dac076b292c4ea6bdbe66c742c49e35_d8f87a49-a624-4638-a427-7174fca2b68c.png\" alt=\"\" data-href=\"\" style=\"\"/><img src=\"/oss/upload/20251017/dc587c30bfa54dbc8fafa76f5bf0e95a_5ce535fb-d7cc-4451-88d6-b12226bc0d36.png\" alt=\"\" data-href=\"\" style=\"\"/></p>', '[206, 127, 223, 211, 216]', 0, '[\"modeling-sculpting\", \"rigging\", \"rendering-compositing\", \"texture-painting\"]', 4);

-- --------------------------------------------------------

--
-- 表的结构 `content_course_content`
--

CREATE TABLE `content_course_content` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `courseId` bigint NOT NULL COMMENT '课程ID',
  `parentId` bigint DEFAULT NULL COMMENT '父级ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容名称',
  `type` tinyint NOT NULL DEFAULT '0' COMMENT '内容类型: 0-分组 1-视频 2-文本说明',
  `videoStatus` tinyint DEFAULT '0' COMMENT '视频处理状态: 0-待处理 1-处理中 2-已处理 3-处理失败 4-无需处理',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '文本说明',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序号',
  `isShow` tinyint NOT NULL DEFAULT '1' COMMENT '是否显示',
  `m3u8Url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'M3U8视频地址',
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '文本内容'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `content_order`
--

CREATE TABLE `content_order` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `userId` int NOT NULL COMMENT '用户ID',
  `goodsId` int NOT NULL COMMENT '商品ID',
  `realAmount` decimal(11,2) NOT NULL COMMENT '实付金额',
  `type` tinyint NOT NULL COMMENT '商品类型 1-课程',
  `orderNo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单号',
  `isPay` tinyint NOT NULL COMMENT '是否支付',
  `goodsName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品名称',
  `goodsPrice` decimal(11,2) NOT NULL COMMENT '商品价格',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品封面'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `content_user_course`
--

CREATE TABLE `content_user_course` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `userId` int NOT NULL COMMENT '用户ID',
  `courseId` int NOT NULL COMMENT '课程ID',
  `activationCode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '激活码编码',
  `orderNo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `content_user_scores`
--

CREATE TABLE `content_user_scores` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `userId` int NOT NULL COMMENT '用户ID',
  `score` int NOT NULL COMMENT '积分数',
  `dataSrc` int NOT NULL DEFAULT '0' COMMENT '来源',
  `dataRemarks` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '描述',
  `scoreType` int NOT NULL COMMENT '积分类型'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `course_key`
--

CREATE TABLE `course_key` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `code` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '激活码',
  `courseId` int NOT NULL COMMENT '课程ID',
  `useStatus` tinyint NOT NULL DEFAULT '1' COMMENT '使用状态 1-未使用 2-已使用',
  `userId` int DEFAULT NULL COMMENT '用户ID(用于激活时存储用户)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------

--
-- 表的结构 `demo_goods`
--

CREATE TABLE `demo_goods` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `price` decimal(5,2) NOT NULL COMMENT '价格',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `mainImage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '主图',
  `type` int NOT NULL COMMENT '分类',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态',
  `exampleImages` json DEFAULT NULL COMMENT '示例图',
  `stock` int NOT NULL DEFAULT '0' COMMENT '库存'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `dict_info`
--

CREATE TABLE `dict_info` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `typeId` int NOT NULL COMMENT '类型ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '值',
  `orderNum` int NOT NULL DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `parentId` int DEFAULT NULL COMMENT '父ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `dict_info`
--

INSERT INTO `dict_info` (`id`, `createTime`, `updateTime`, `tenantId`, `typeId`, `name`, `value`, `orderNum`, `remark`, `parentId`) VALUES
(21, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 19, 'COOL', 'cool', 1, NULL, NULL),
(22, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 19, '闪酷', 'https://show.cool-admin.com/api/public/uploads/20230308/c731b0cba84046268b10edbbcf36f948_315c243a448e1369fa145c5ea3f020da.gif', 2, NULL, NULL),
(23, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 20, '法师', '4', 1, NULL, NULL),
(24, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 20, '战士', '3', 2, NULL, NULL),
(25, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 20, '坦克', '2', 3, NULL, NULL),
(26, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 20, '刺客', '1', 4, NULL, NULL),
(27, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 20, '射手', '0', 5, NULL, NULL),
(30, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, 20, '幻影刺客', '5', 1, NULL, 26),
(39, '2025-09-18 14:24:02', '2025-09-18 14:24:02', NULL, 23, '建模雕刻', 'modeling-sculpting', 1, NULL, NULL),
(40, '2025-09-18 14:26:43', '2025-09-18 14:26:43', NULL, 23, '动画绑定', 'rigging', 2, NULL, NULL),
(41, '2025-09-18 14:27:20', '2025-09-18 14:27:20', NULL, 23, '渲染合成', 'rendering-compositing', 3, NULL, NULL),
(42, '2025-09-18 14:27:42', '2025-09-18 14:27:42', NULL, 23, '贴图绘制', 'texture-painting', 4, NULL, NULL),
(43, '2025-09-18 14:27:59', '2025-09-18 14:27:59', NULL, 23, '视觉特效', 'vfx', 5, NULL, NULL),
(44, '2025-09-18 14:28:16', '2025-09-18 14:28:16', NULL, 23, '材质纹理', 'materials', 6, NULL, NULL),
(45, '2025-09-18 14:28:39', '2025-09-18 14:28:39', NULL, 23, '游戏原画', 'game-concept', 7, NULL, NULL),
(46, '2025-09-18 14:28:55', '2025-09-18 14:28:55', NULL, 23, '脚本编程', 'scripting', 8, NULL, NULL),
(47, '2025-09-18 14:29:16', '2025-09-18 14:29:24', NULL, 23, '虚拟现实', 'vr', 9, NULL, NULL),
(48, '2025-09-18 14:29:47', '2025-09-18 14:29:47', NULL, 23, '游戏特效', 'game-effects', 10, NULL, NULL),
(49, '2025-09-18 14:30:04', '2025-09-18 14:30:04', NULL, 23, '毛发制作', 'grooming', 11, NULL, NULL),
(50, '2025-09-18 14:30:31', '2025-09-18 14:30:31', NULL, 23, 'UI设计', 'ui', 12, NULL, NULL),
(51, '2025-09-18 14:31:03', '2025-09-18 14:31:03', NULL, 23, '后期特效', 'post-production', 13, NULL, NULL),
(52, '2025-09-18 14:31:22', '2025-09-18 14:31:22', NULL, 23, '系统开发', 'system-development', 14, NULL, NULL),
(53, '2025-09-18 14:31:44', '2025-09-18 14:31:44', NULL, 23, '角色制作', 'production', 15, NULL, NULL),
(54, '2025-09-18 14:32:12', '2025-09-18 14:32:12', NULL, 23, '场景设计', 'scene-design', 16, NULL, NULL),
(55, '2025-09-18 14:59:44', '2025-09-18 14:59:44', NULL, 23, '设计理论', 'design-theory', 17, NULL, NULL),
(56, '2025-09-18 15:00:28', '2025-09-18 15:00:28', NULL, 23, '手办制作', 'figurine-making', 18, NULL, NULL),
(57, '2025-09-18 15:29:19', '2025-09-18 15:29:26', NULL, 23, ' 影像后期', 'video-post', 19, NULL, NULL),
(58, '2025-09-18 15:31:17', '2025-09-18 15:31:17', NULL, 23, '视频剪辑', 'video-editing', 20, NULL, NULL),
(59, '2025-09-18 18:20:43', '2025-09-23 11:20:21', NULL, 24, 'Arnold', '/oss/upload/20250918/2931ee42fb2148bb8fca4e8889d4f51c_5d2482744f924d1bbbc0488af90b40d9.png', 1, '推荐', NULL),
(60, '2025-09-19 11:16:50', '2025-09-23 11:20:30', NULL, 24, 'AfterEffects', '/oss/upload/20250919/6578e040111849df8dd7e9880efd6367_f1bf2994823f40da8b9108cfeca30a49.png', 2, '推荐', NULL),
(61, '2025-09-19 11:17:19', '2025-09-19 11:17:29', NULL, 24, 'Advanced Skeleton', '/oss/upload/20250919/77e5accb4200465e9280c91dd9508734_93e7287f80d143ffaac39a14fb5fc4f8.png', 3, NULL, NULL),
(62, '2025-09-19 11:18:03', '2025-09-19 11:18:13', NULL, 24, 'AEscripts', '/oss/upload/20250919/ca5058d0951f4f5b8897a1119ff712f1_469f982d9f024da2840ebe62854adcae.png', 4, NULL, NULL),
(63, '2025-09-19 11:20:30', '2025-09-19 11:20:47', NULL, 24, 'Assimilate Scratch', '/oss/upload/20250919/0de32b35e0464e478527c98edb436e87_7c3330b52fee45c9abfa8a1652047db1.png', 5, NULL, NULL),
(64, '2025-09-19 11:21:15', '2025-09-19 11:21:22', NULL, 24, 'ArtRage', '/oss/upload/20250919/69a7273aa2964cf98e37f562b791a977_0dda3bd4b8a44261a5749bea66c34493.png', 6, NULL, NULL),
(65, '2025-09-19 11:22:03', '2025-09-19 11:22:03', NULL, 24, 'Agisoft PhotoScan', '/oss/upload/20250919/1c140ed138014d63879aed997b4391c8_e463920bb0054d8c845d1622c65c2bb6.png', 7, NULL, NULL),
(66, '2025-09-19 11:22:29', '2025-09-19 11:22:29', NULL, 24, 'Autodesk Composite', '/oss/upload/20250919/fbb0387f654c4d0c8562a8c1552981af_7f6fa847aca243558c6f3bdd560117c1.png', 8, NULL, NULL),
(67, '2025-09-19 11:22:57', '2025-09-19 11:22:57', NULL, 24, 'artbreeder', '/oss/upload/20250919/2c1ee3ca184841128b3af106b526aab6_d6cf48d9010a4646a93b1ceb989740c1.png', 9, NULL, NULL),
(68, '2025-09-19 11:23:24', '2025-09-19 11:23:24', NULL, 24, 'Animcraft', '/oss/upload/20250919/6f3eebb3bcd94bb680ca9b9e9eaf635a_2e75352ff87e44c6b0773d97efd2ce74.png', 10, NULL, NULL),
(69, '2025-09-19 11:23:47', '2025-09-19 11:29:57', NULL, 24, 'Aximmetry', '/oss/upload/20250919/6f3eebb3bcd94bb680ca9b9e9eaf635a_2e75352ff87e44c6b0773d97efd2ce74.png', 1, NULL, NULL),
(70, '2025-09-19 11:24:39', '2025-09-23 11:19:05', NULL, 24, 'Blender', '/oss/upload/20250919/7f4edef36c3640279673a4008e218574_daf6b40a878a42399ae8478911693c70.png', 11, '推荐', NULL),
(71, '2025-09-19 11:25:27', '2025-09-19 11:25:27', NULL, 24, 'Bodypaint', '/oss/upload/20250919/b00be1b596174f568e699c42a0907e91_d6c818873cca4d7a8f7fedb3f4bdd747.png', 12, NULL, NULL),
(72, '2025-09-19 11:25:55', '2025-09-19 11:25:55', NULL, 24, 'Boujou', '/oss/upload/20250919/e6425be8b4e54791ba9a77efb11cf848_1fc066b684d04bf79300f37959672225.png', 13, NULL, NULL),
(73, '2025-09-19 11:26:42', '2025-09-19 11:26:42', NULL, 24, 'Bitmap2Material', '/oss/upload/20250919/f11b87a6476b4ade82a07fa2634f6bcc_cbb6e1e8df7f4acd9d9be2af8a249ce9.png', 14, NULL, NULL),
(74, '2025-09-19 11:27:49', '2025-09-19 11:27:49', NULL, 24, 'Baselight', '/oss/upload/20250919/ba62fe41010844958c56bd3eed71ac46_29723d1127bd45f793ec425e969b2a4d.png', 15, NULL, NULL),
(75, '2025-09-19 11:28:26', '2025-09-19 11:28:26', NULL, 24, 'Blender Addon', '/oss/upload/20250919/a655316d1a2c45ee85198ccb8d03e359_7e18c1a32c254510adca07b101aaf784.png', 16, NULL, NULL),
(76, '2025-09-19 11:29:35', '2025-09-23 11:19:55', NULL, 24, 'Cinema4D', '/oss/upload/20250919/2a36975cba4542fe80b57b8641d2bd80_41b2ea1f233341b18a48fbc6ff121a83.png', 17, '推荐', NULL),
(77, '2025-09-19 11:31:08', '2025-09-19 11:31:08', NULL, 24, 'Corona Render', '/oss/upload/20250919/8d03fa91739a41528fd5ce766b3e816e_1c535f867ae245bb81fb9a685baa0da5.png', 18, NULL, NULL),
(78, '2025-09-19 11:31:40', '2025-09-19 11:31:40', NULL, 24, 'CAD', '/oss/upload/20250919/98d37832849d4d7ca0aeb45d3a3e8377_ef868e230d464a688f6b77207154e93d.png', 19, NULL, NULL),
(79, '2025-09-19 11:32:09', '2025-09-19 11:32:09', NULL, 24, 'City Engine', '/oss/upload/20250919/0e766553402f49d1ba5ecd2b029eb1ef_d8e8ca5a2c744ccfb43d4d10b69b2cc6.png', 20, NULL, NULL),
(80, '2025-09-19 11:34:40', '2025-09-19 11:34:40', NULL, 24, 'Character Creator', '/oss/upload/20250919/0aa8fed7978f473e9b234ecbefc6e09c_99d3e6845b944692ad61db7f1dbcd42a.png', 21, NULL, NULL),
(81, '2025-09-19 11:35:14', '2025-09-19 11:35:14', NULL, 24, 'Carbon Scatte', '/oss/upload/20250919/9960ac2c0ccf439294614901b8fe4765_805da63590a44b069b4efbf1dee02979.png', 22, NULL, NULL),
(82, '2025-09-19 11:43:47', '2025-09-19 11:43:47', NULL, 24, 'Clarisse', '/oss/upload/20250919/8203e09177ea47ea8ac7c09eda51c70a_d08f1fcc8734495e919582d48be2bfbb.png', 23, NULL, NULL),
(83, '2025-09-19 11:44:34', '2025-09-19 11:44:34', NULL, 24, 'Cascadeur', '/oss/upload/20250919/a9300ec1444a403480c7491c070eda06_8e655d72685846ee843e7136f9d05524.png', 24, NULL, NULL),
(84, '2025-09-19 11:45:05', '2025-09-19 11:45:05', NULL, 24, 'Creo', '/oss/upload/20250919/3ad881e61ef2448e8dbba16977ff18d9_24917413e7d04cf1820664e8c06de71f.png', 25, NULL, NULL),
(85, '2025-09-19 11:47:26', '2025-09-19 11:47:26', NULL, 24, 'Chitubox', '/oss/upload/20250919/be70fd829d8f4f718485b247dcb12d23_8c2215d4680f494ab63674619e7ac10f.png', 26, NULL, NULL),
(86, '2025-09-19 11:47:53', '2025-09-19 11:47:53', NULL, 24, 'CoreLDRAW', '/oss/upload/20250919/828112903c0245bd8f10fee2934b34bb_79b8637ce51544bb850908d2ea352766.png', 27, NULL, NULL),
(87, '2025-09-19 11:48:22', '2025-09-19 11:48:22', NULL, 24, 'CapCut', '/oss/upload/20250919/d258ce6af3db414e8b6f69497bd94269_c37c9b4692f14ee1893171337beea97e.png', 28, NULL, NULL),
(88, '2025-09-19 11:49:09', '2025-09-19 11:49:09', NULL, 24, 'Chaos Vantage', '/oss/upload/20250919/9d38f2a1cb754f99b7d5ad97277be1cc_68d36c412f8e4620bb9ea365b154cba7.png', 29, NULL, NULL),
(89, '2025-09-19 11:49:44', '2025-09-23 11:21:36', NULL, 24, 'ComfyUI', '/oss/upload/20250919/8f02b304cad7421c89dbc474d572b968_712dfb6c21aa41979b7f808a4d075170.png', 30, '推荐', NULL),
(90, '2025-09-19 11:53:04', '2025-09-23 11:18:43', NULL, 24, '3dsmax', '/oss/upload/20250919/9b12414c3b514e1c8d24c6edae5d7393_1f7eaa1c76974a5ba56dbbc450406b79.png', 31, '推荐', NULL),
(91, '2025-09-19 11:53:49', '2025-09-23 11:21:04', NULL, 24, 'Daz Studio', '/oss/upload/20250919/399b016da33b4a4f9414512b6b8b7bc7_48183237503d46ea9476a0f9dfc49450.png', 32, '推荐', NULL),
(92, '2025-09-19 11:54:40', '2025-09-19 11:54:40', NULL, 24, '3dcoat', '/oss/upload/20250919/3d4a747b11a546538924a0dbcb279328_d6e05a8847964085b06019e9b68cb631.png', 33, NULL, NULL),
(93, '2025-09-19 11:55:11', '2025-09-19 11:55:11', NULL, 24, 'DaVinci Resolve', '/oss/upload/20250919/fe59494e5c77462a8fdd6aa99e91ddb5_8a41b196b8d942e09aba50ba2a235510.png', 34, NULL, NULL),
(94, '2025-09-19 11:55:44', '2025-09-19 11:55:44', NULL, 24, '123D', '/oss/upload/20250919/53a80383ed5a4423984eb63319efaf2b_5ee772c018a444ae9a7405e872e70d5a.png', 35, NULL, NULL),
(95, '2025-09-19 11:56:12', '2025-09-19 11:56:12', NULL, 24, 'Dragon Bones', '/oss/upload/20250919/46863b1ad0994feeb71297df429c731f_52938e1b862e469f840aca44cc409fd4.png', 36, NULL, NULL),
(96, '2025-09-19 11:56:38', '2025-09-19 11:56:38', NULL, 24, 'd5render', '/oss/upload/20250919/661d3c8639d5463881e1f80d55c34fd6_03d056c74700486e987e4b10cd167a0d.png', 37, NULL, NULL),
(97, '2025-09-19 11:57:13', '2025-09-19 11:57:13', NULL, 24, 'Disco Diffusion', '/oss/upload/20250919/0744e265d4d4484d8a5ebbb29acc7670_33bb12a69cfd4720add5f775087b4cc2.png', 38, NULL, NULL),
(98, '2025-09-19 11:57:40', '2025-09-19 11:57:40', NULL, 24, 'davinci', '/oss/upload/20250919/7d091e838dc345d386e99b95632643d7_54c8b42893f64d20b76d43d1f13efca6.png', 39, NULL, NULL),
(99, '2025-09-19 11:58:17', '2025-09-19 11:58:17', NULL, 24, 'Deepseek', '/oss/upload/20250919/f4d451b0963d47fd8e7cb33f31749c7f_44349b97c5bf4994bc12f2fb1e9db4fa.png', 40, NULL, NULL),
(100, '2025-09-19 11:58:52', '2025-09-19 11:58:52', NULL, 24, 'Enscape', '/oss/upload/20250919/981b7be2d04448f181e0d704eabb5a4c_0846ca17277946ec98594636c4b066dc.png', 41, NULL, NULL),
(101, '2025-09-19 11:59:22', '2025-09-19 11:59:22', NULL, 24, 'EmberGen', '/oss/upload/20250919/9218f8172f354f088935a7b29f50de4a_c608bd2e312f4ac69a0481f3dee33334.png', 42, NULL, NULL),
(102, '2025-09-19 11:59:46', '2025-09-19 11:59:46', NULL, 24, 'EmberGen', '/oss/upload/20250919/03e22a37068f4f148e9cdba8d211d840_26a3ec2843364b538e27968a69d85789.png', 43, NULL, NULL),
(103, '2025-09-19 12:00:26', '2025-09-19 12:00:26', NULL, 24, 'Fusion 360', '/oss/upload/20250919/6847b39ca73d43d5a19f79f1caf3994b_a54e537dd95540b29d78bebedc00bb30.png', 44, NULL, NULL),
(104, '2025-09-19 12:01:00', '2025-09-19 12:01:00', NULL, 24, 'Flash', '/oss/upload/20250919/0bd4f66797924512800a6bbc502c2439_6fe5d9169a1f46c286eec7bd63e0cb07.png', 45, NULL, NULL),
(105, '2025-09-19 12:01:47', '2025-09-19 12:01:47', NULL, 24, 'Flow box', '/oss/upload/20250919/60d4eaf63f1942a99ca9c5741e92f101_71bf3c59691a4171a4f6ffed67fa409c.png', 46, NULL, NULL),
(106, '2025-09-19 12:02:23', '2025-09-19 12:02:23', NULL, 24, 'Fstorm', '/oss/upload/20250919/5fa3709091c0402791dc9322fdce35d2_e1a3da38f2334a5da2dfab4b3781d529.png', 47, NULL, NULL),
(107, '2025-09-19 12:02:54', '2025-09-19 12:02:54', NULL, 24, 'Forest', '/oss/upload/20250919/d376b4db6d2b4d8185a2f2cdf5406b91_cec7ca8184984c46b559c5ac53bc7503.png', 48, NULL, NULL),
(108, '2025-09-19 12:03:29', '2025-09-19 12:03:29', NULL, 24, 'FFmpeg', '/oss/upload/20250919/217e97ed53f84cb4b8f2cb2701bc7b28_9e8fb582dfcf4a19b115a038dc1f2bab.png', 49, NULL, NULL),
(109, '2025-09-19 12:03:59', '2025-09-19 12:03:59', NULL, 24, 'Forger', '/oss/upload/20250919/a7e23c63e51a45d08c88b27b4485e14c_f5fe566fae1d459a9d595a0bfcdc7262.png', 50, NULL, NULL),
(110, '2025-09-19 12:05:10', '2025-09-19 12:05:10', NULL, 24, 'GMH2.6', '/oss/upload/20250919/fce9cba880e04c928eb1bf7df30fc013_f577a2652b0b45349a5a2a4a789f728a.png', 51, NULL, NULL),
(111, '2025-09-19 12:06:10', '2025-09-19 12:06:10', NULL, 24, 'Git', '/oss/upload/20250919/c55fb1cd9845402299ba0f2a056563d1_6f74f8bb7ddf41008fe46c350c8cc54f.png', 52, NULL, NULL),
(112, '2025-09-19 12:06:49', '2025-09-19 12:06:49', NULL, 24, 'Gif Cam', '/oss/upload/20250919/bb031bd950384b3ebe4719dc61e9bf95_3e3993863709445e9788e7223e071a1d.png', 53, NULL, NULL),
(113, '2025-09-19 12:08:03', '2025-09-19 12:08:03', NULL, 24, 'GravitySketch', '/oss/upload/20250919/ae6013480563438a86ecdc7193d7858b_a6705d70079747e797ed5a04d3756277.png', 54, NULL, NULL),
(114, '2025-09-19 12:09:14', '2025-09-19 12:09:14', NULL, 24, 'Gaea', '/oss/upload/20250919/6668d12869bc4b0884c3f1ffef232acf_80c071d400504cf8b945328565562c09.png', 55, NULL, NULL),
(115, '2025-09-19 12:09:47', '2025-09-19 12:09:47', NULL, 24, 'Godot', '/oss/upload/20250919/da3210b9932e4c61a775742f1ce2f54e_a1cf01e65a31406fa668f0e79567b784.png', 56, NULL, NULL),
(116, '2025-09-19 12:10:44', '2025-09-23 11:19:16', NULL, 24, 'Houdini', '/oss/upload/20250919/6646a5ab8b1b4d5496e47d2119c4b0a8_9f615a15425745969e7de2596cf996eb.png', 57, '推荐', NULL),
(117, '2025-09-19 12:11:10', '2025-09-19 12:11:10', NULL, 24, 'Hardmesh', '/oss/upload/20250919/eac3c7fbfd204212923631b4efce7e86_4be2295d82b2483aa557caf4cd74c575.png', 58, NULL, NULL),
(118, '2025-09-19 12:11:51', '2025-09-19 12:11:51', NULL, 24, 'Illustrator', '/oss/upload/20250919/1661256e9d024b6988a8eaa08065a10d_1f0b76b0a5f34a3caf49027b14ebf3c1.png', 59, NULL, NULL),
(119, '2025-09-19 12:12:25', '2025-09-19 12:12:25', NULL, 24, 'iMovie', '/oss/upload/20250919/f689c5c03e2e49b0816d6e60c137ecd1_a8c64b82073e495582ffee0823f1f983.png', 60, NULL, NULL),
(120, '2025-09-19 12:13:12', '2025-09-19 12:13:12', NULL, 24, 'Insydiun Fuse', '/oss/upload/20250919/622c9af924cc436f8eb857c2295ca47e_c38b1fea400941c1929633ca2b534c45.png', 61, NULL, NULL),
(121, '2025-09-19 12:13:42', '2025-09-19 12:13:42', NULL, 24, 'Keyshot', '/oss/upload/20250919/5246eab4aae1456ba882837a1cb314b6_e61f98aca7774a7fa2425c71ac3cf83f.png', 62, NULL, NULL),
(122, '2025-09-19 12:14:07', '2025-09-19 12:14:07', NULL, 24, 'krita', '/oss/upload/20250919/93da4eabe04f47a58d9630a2003f3914_f7945cba24514b91bacb027770d61e67.png', 63, NULL, NULL),
(123, '2025-09-19 12:14:37', '2025-09-19 12:14:37', NULL, 24, 'Lumion8', '/oss/upload/20250919/1608bcadcdc6421e8f85d2d757e9d2c5_7310cfdc329b4e5884a7e466c812cdd9.png', 64, NULL, NULL),
(124, '2025-09-19 12:15:04', '2025-09-19 12:15:04', NULL, 24, 'Lightroom', '/oss/upload/20250919/7c210da4778d4687a7921b16373a7002_55af4d6b5c95403a8c62ba2b60becda1.png', 65, NULL, NULL),
(125, '2025-09-19 12:15:28', '2025-09-19 12:15:28', NULL, 24, 'Lattice', '/oss/upload/20250919/b211a73f70ad4ede873d68d2ad9f4e5a_b5a55afcbdd145cead5dbb87a069a584.png', 66, NULL, NULL),
(126, '2025-09-19 12:15:53', '2025-09-19 12:15:53', NULL, 24, 'Live2D Cubism', '/oss/upload/20250919/6206ee8234e64e5381e1b1117f19e2ae_db51e500bbdf4750b4bee3b9e0f77fa3.png', 67, NULL, NULL),
(127, '2025-09-19 12:18:22', '2025-09-23 11:18:33', NULL, 24, 'Maya', '/oss/upload/20250919/778a1a212e7e46d2857f330e3e1042fd_b3796de5e88e466f82e65e31d0a9d9de.png', 68, '推荐', NULL),
(128, '2025-09-19 12:18:49', '2025-09-23 11:20:12', NULL, 24, 'Marvelous Designer', '/oss/upload/20250919/52287ca903cc47cebcda58bddd7bd1cd_87b66f8a449f472cb4949f2bbb9985c0.png', 69, '推荐', NULL),
(129, '2025-09-19 12:19:16', '2025-09-23 11:20:39', NULL, 24, 'Marmoset', '/oss/upload/20250919/0420e58b302d41a585734a5fed3e13a9_453d1d79fc7448fd81c11622db19ec27.png', 70, '推荐', NULL),
(130, '2025-09-19 12:19:45', '2025-09-19 12:19:45', NULL, 24, 'Mari', '/oss/upload/20250919/5dd8d16210a346fb8ac9abe856b153e3_be8ed052543b4a1f9ef7bed30184c8f2.png', 71, NULL, NULL),
(131, '2025-09-19 12:20:10', '2025-09-19 12:20:10', NULL, 24, 'Mixer', '/oss/upload/20250919/ebf0ae613e0e4e209f22702e5812f9bc_53c57efbb0f744b79a73f7a136dc70bb.png', 72, NULL, NULL),
(132, '2025-09-19 12:20:33', '2025-09-19 12:20:33', NULL, 24, 'Mikumiku Dance', '/oss/upload/20250919/71c3e8cb6c794d678e6a65aea7280b03_d15aaf5dd2e64f63ac84baa3e36517b8.png', 73, NULL, NULL),
(133, '2025-09-19 12:20:58', '2025-09-19 12:20:58', NULL, 24, 'Megascan', '/oss/upload/20250919/76c94030d51744f293956826e1c395fe_a6e41c83c1074bea9c9fb98e71257ad6.png', 74, NULL, NULL),
(134, '2025-09-19 12:21:28', '2025-09-19 12:21:28', NULL, 24, 'Mudbox', '/oss/upload/20250919/74b165ac35ab40598caf99049ef68a56_235c17d245274991b3ae357151893200.png', 75, NULL, NULL),
(135, '2025-09-19 12:21:57', '2025-09-19 12:21:57', NULL, 24, 'Modo', '/oss/upload/20250919/98548d1b293242b78f65c41f732e9598_918bde37c35e4898bb077905dde6b3ef.png', 76, NULL, NULL),
(136, '2025-09-19 12:22:26', '2025-09-19 12:22:26', NULL, 24, 'Maxwell Render', '/oss/upload/20250919/c279e5a289954a0f883910067208d41b_19f32976ca614019a6761643e55afe97.png', 77, NULL, NULL),
(137, '2025-09-19 12:22:51', '2025-09-19 12:22:51', NULL, 24, 'Mistika Boutique', '/oss/upload/20250919/c504fb298c7046d195ac74c237699df5_edec6973f18e4eaaa28edf20f7aabf25.png', 78, NULL, NULL),
(138, '2025-09-19 12:23:18', '2025-09-19 12:23:18', NULL, 24, 'Mental Ray', '/oss/upload/20250919/3c3093c781f243d08a94e789b91d33f3_044e38ad3fe44180a86c9abfe63e0bb5.png', 79, NULL, NULL),
(139, '2025-09-19 12:23:43', '2025-09-19 12:23:43', NULL, 24, 'Mocha', '/oss/upload/20250919/c944190c8b394bc8937df13e7b726c89_6ed06a335fdb4a6789ad4e4f91ed0871.png', 80, NULL, NULL),
(140, '2025-09-19 12:24:09', '2025-09-19 12:24:09', NULL, 24, 'MGTools', '/oss/upload/20250919/9e8ceceb2a1d440895472fdb26b81502_717f9e71cbde4d54b27d28d4986f0d41.png', 81, NULL, NULL),
(141, '2025-09-19 12:24:39', '2025-09-19 12:24:39', NULL, 24, 'Memento', '/oss/upload/20250919/b5b28e89eda242149b268924c170cccf_ccb4863d4a6d498e9b7faa527240c2b6.png', 82, NULL, NULL),
(142, '2025-09-19 12:25:08', '2025-09-19 12:25:08', NULL, 24, 'Massive', '/oss/upload/20250919/fe5cf7e9cc414cc6912f843fafb4c050_af9a8850ce7b49ee94113d47cf1cff91.png', 83, NULL, NULL),
(143, '2025-09-19 12:25:35', '2025-09-19 12:25:35', NULL, 24, 'midjourney', '/oss/upload/20250919/2af69ae87f4c4bbaa2f2bdc0e1784773_ed0be9238e124d56bd886697874c21d7.png', 84, NULL, NULL),
(144, '2025-09-19 12:26:04', '2025-09-19 12:26:04', NULL, 24, 'Mistika VR', '/oss/upload/20250919/3ce28619f8e647e1864bed7846110e6f_991375a773a540a98d9fe1954872e820.png', 85, NULL, NULL),
(145, '2025-09-19 12:27:29', '2025-09-23 11:20:48', NULL, 24, 'Nuke', '/oss/upload/20250919/b2777a3052f848ee8aa4926c99e9ccc4_e19c2c9648c04824a2f5961c67e0e20b.png', 86, '推荐', NULL),
(146, '2025-09-19 12:27:55', '2025-09-19 12:27:55', NULL, 24, 'Nvil', '/oss/upload/20250919/fb6f914751304c28899c3c09f3a7a31a_2f134c0ab7db49f0a4e120e6b8fe4cca.png', 87, NULL, NULL),
(147, '2025-09-19 12:28:19', '2025-09-19 12:28:19', NULL, 24, 'ngSkinTools', '/oss/upload/20250919/f97b1b2a9b804b62b622283c51a12ab6_a8731fe63b9c48b28fc9908e95fbec34.png', 88, NULL, NULL),
(148, '2025-09-19 12:28:45', '2025-09-19 12:28:45', NULL, 24, 'Nomad Sculpt', '/oss/upload/20250919/b98b5d5999ee4ba28cb64e656501fa1b_c12e064a560b40fea690039c6fcfabe1.png', 89, NULL, NULL),
(149, '2025-09-19 12:29:23', '2025-09-19 12:29:23', NULL, 24, 'novelAI', '/oss/upload/20250919/7764f0983f6b49d3b45016057b246438_a0d629edb9044ad6881c851a076f55c4.png', 90, NULL, NULL),
(150, '2025-09-19 12:29:53', '2025-09-19 12:29:53', NULL, 24, 'Octane', '/oss/upload/20250919/c703fc1fe64e47eebdf1afac53e15d8b_0f1a569385e747a5b854939f945e6a96.png', 91, NULL, NULL),
(151, '2025-09-19 12:30:25', '2025-09-19 12:30:25', NULL, 24, 'Ornatrix', '/oss/upload/20250919/d6e98024ffa7428484ddcb9b357d8bd5_969b198cdd7e46ed9a9a3e04cf41435b.png', 82, NULL, NULL),
(152, '2025-09-19 12:34:17', '2025-09-19 12:34:17', NULL, 24, 'Ornatrix', '/oss/upload/20250919/d6e98024ffa7428484ddcb9b357d8bd5_969b198cdd7e46ed9a9a3e04cf41435b.png', 92, NULL, NULL),
(153, '2025-09-19 12:36:05', '2025-09-23 11:20:04', NULL, 24, 'Photoshop', '/oss/upload/20250919/a39cb9458c8347d583cfdbfc4051fe08_e6008648e9f54ec4a153db05c65d451f.png', 93, '推荐', NULL),
(154, '2025-09-19 12:36:39', '2025-09-19 12:36:39', NULL, 24, 'Python', '/oss/upload/20250919/83901ba490e3464f942faedb42f74d27_08c4149c5e254a93bd5111bf5e481c51.png', 94, NULL, NULL),
(155, '2025-09-19 12:37:10', '2025-09-19 12:37:10', NULL, 24, 'Premiere', '/oss/upload/20250919/22db176020934ba5a8331690870c2417_f15aa058641e41899c5f0f7e4180779a.png', 95, NULL, NULL),
(156, '2025-09-19 12:37:37', '2025-09-19 12:37:37', NULL, 24, 'PhoenixFD', '/oss/upload/20250919/2183d5eb075f4f778ad533bef03d830e_9087e48fbe6a44e498876b5fee2e25fa.png', 96, NULL, NULL),
(157, '2025-09-19 12:40:25', '2025-09-19 12:40:25', NULL, 24, 'PFTrack', '/oss/upload/20250919/f81d7e2348d34163a4896fda833fb7d1_90434c420d244e0bb44f2c6d65780bc2.png', 97, NULL, NULL),
(158, '2025-09-19 12:41:06', '2025-09-19 12:41:06', NULL, 24, 'Principle', '/oss/upload/20250919/d60060c992ba499781beecd69910c113_7d7b547527a84b8482d42f7f4a006d1b.png', 98, NULL, NULL),
(159, '2025-09-19 12:41:43', '2025-09-19 12:41:43', NULL, 24, 'PmxEditor', '/oss/upload/20250919/d70c08b3f02943698e5026373b2bc059_e4d35f53f6804981af5d33dd0afc0b58.png', 99, NULL, NULL),
(160, '2025-09-19 12:45:19', '2025-09-19 12:45:19', NULL, 24, 'Pano2VR5', '/oss/upload/20250919/4068670aa7c143e4a2433cef39c3930c_532be2c2f4654cf08583f40888ed3213.png', 100, NULL, NULL),
(161, '2025-09-19 12:45:47', '2025-09-19 12:46:53', NULL, 24, 'PolyUnwrapper', '/oss/upload/20250919/93f6a839bb3e497cbcb3a57d54d4dd25_7ecbb521dd6e441d8e28a7e3ab952709.png', 101, NULL, NULL),
(162, '2025-09-19 12:47:56', '2025-09-19 12:47:56', NULL, 24, 'Particle Flow', '/oss/upload/20250919/430fc720774245e08c7f29a48a63b379_e7d3d1c053fd413da2acaf2cd27ab223.png', 102, NULL, NULL),
(163, '2025-09-19 12:48:53', '2025-09-19 12:48:53', NULL, 24, 'PyCharm', '/oss/upload/20250919/a3b32175abbe406d954ddd428cc83a3e_309176572c4e4071b2abcf02fcb2b820.png', 103, NULL, NULL),
(164, '2025-09-19 12:49:25', '2025-09-19 12:49:25', NULL, 24, 'Plasticity', '/oss/upload/20250919/342da2d6b9cd45e48cba2aeaad6f2127_adfbb143f0fb444280f0082463214aa8.png', 104, NULL, NULL),
(165, '2025-09-19 12:50:06', '2025-09-19 12:50:06', NULL, 24, 'Quixel', '/oss/upload/20250919/bc7d72cdc94240678a76b3749956257f_3281d47fe43d40cd8bc805dba03731fb.png', 105, NULL, NULL),
(166, '2025-09-19 12:51:17', '2025-09-19 12:51:17', NULL, 24, 'Redshift', '/oss/upload/20250919/9849da9c50eb4f91946cb7f206d0019e_fd28213e2a5a40108d741e9d456aaacd.png', 106, NULL, NULL),
(167, '2025-09-19 12:51:54', '2025-09-19 12:51:54', NULL, 24, 'RizomUV', '/oss/upload/20250919/3fd579527bb44f8789894660e6748180_21b7f2e15d5f4730830b76da990b0ec2.png', 107, NULL, NULL),
(168, '2025-09-19 12:53:01', '2025-09-19 12:53:01', NULL, 24, 'Realflow', '/oss/upload/20250919/90f501d9aa11443f9ccd578f07a7111c_81a806dd2afc4828b653099ae823eba7.png', 108, NULL, NULL),
(169, '2025-09-19 13:00:23', '2025-09-19 13:00:38', NULL, 24, 'Rhinoceros', '/oss/upload/20250919/c7ffb3e814314f218665df7c516b2fee_1835d2463cbd4c41ba775a2058edc7de.png', 109, NULL, NULL),
(170, '2025-09-19 13:01:09', '2025-09-19 13:01:09', NULL, 24, 'Revit', '/oss/upload/20250919/1092a67f81c14bbd9d5a9e1599b6ce96_d2b32a3431f543369f4dcd6d34552008.png', 110, NULL, NULL),
(171, '2025-09-19 13:01:46', '2025-09-19 13:01:46', NULL, 24, 'Ray mmd', '/oss/upload/20250919/b002825bfe654ee1b0099b484149179d_f0ccd2aa39a94404b9251b2a52ca0dfd.png', 111, NULL, NULL),
(172, '2025-09-19 13:02:31', '2025-09-19 13:02:31', NULL, 24, 'RenderMan', '/oss/upload/20250919/21b9307c828e4bdea820e61ec1e47950_b9ac772e80cd4976879d7b838504b47f.png', 112, NULL, NULL),
(173, '2025-09-19 13:03:10', '2025-09-19 13:03:10', NULL, 24, 'Railclone', '/oss/upload/20250919/9e29148f1d5b42b78a2fbf7e0467e0c6_9a1c247baab14fff8792e1022150d8b4.png', 113, NULL, NULL),
(174, '2025-09-19 13:10:43', '2025-09-19 13:10:43', NULL, 24, 'RealityCapture', '/oss/upload/20250919/35912d49fad6400285e256d7a8436efd_0a41412346a5473fa37051aeb9027b44.png', 114, NULL, NULL),
(175, '2025-09-19 13:11:25', '2025-09-23 11:18:54', NULL, 24, 'Substance Painter', '/oss/upload/20250919/d5b0c8d3edba43b8928053895d2ed2c3_482018b34cc644fe996e167a6402f948.png', 115, '推荐', NULL),
(176, '2025-09-19 13:11:57', '2025-09-23 11:19:45', NULL, 24, 'Substance Designer', '/oss/upload/20250919/cbc13f799c0643039080373a4e178b80_fa18f86d7ae647aa96af2f2c67858257.png', 116, '推荐', NULL),
(177, '2025-09-19 13:12:22', '2025-09-19 13:12:22', NULL, 24, 'Speedtree', '/oss/upload/20250919/efc569098cab482c98cdc9755bf3fda1_86216c3de9d34045bb60cbc7340ffb96.png', 117, NULL, NULL),
(178, '2025-09-19 13:13:13', '2025-09-19 13:13:13', NULL, 24, 'Substance Source', '/oss/upload/20250919/b3c6966174a34dc785ea6d8d5adeaadc_34edba75a6ea49da996dad7575c18d35.png', 118, NULL, NULL),
(179, '2025-09-19 13:13:49', '2025-09-19 13:13:49', NULL, 24, 'Substance Alchemist', '/oss/upload/20250919/b3c6966174a34dc785ea6d8d5adeaadc_34edba75a6ea49da996dad7575c18d35.png', 119, NULL, NULL),
(180, '2025-09-19 13:14:38', '2025-09-19 13:14:38', NULL, 24, 'Sai', '/oss/upload/20250919/1f61189760fa452b855dafc51092adf1_ae8e49bbf36b4b15b1d064915699fbdc.png', 120, NULL, NULL),
(181, '2025-09-19 13:15:07', '2025-09-19 13:15:07', NULL, 24, 'Sketchup', '/oss/upload/20250919/e513a319dec9480d91d61345cf6bc7da_ea1b239f089748c680e58bdadec7c318.png', 121, NULL, NULL),
(182, '2025-09-19 13:15:35', '2025-09-19 13:15:35', NULL, 24, 'Solid Works', '/oss/upload/20250919/6894ae6042c144b68abc7a08d823cdb8_7c564c6fa1b146bc90a35b359be8e815.png', 122, NULL, NULL),
(183, '2025-09-19 13:16:02', '2025-09-19 13:16:02', NULL, 24, 'Spine', '/oss/upload/20250919/afdad3592c054c30b221440cc8f0c047_7759d5bb41c04368ae81e49badd782a9.png', 123, NULL, NULL),
(184, '2025-09-19 13:16:40', '2025-09-19 13:16:40', NULL, 24, 'Speed Grade', '/oss/upload/20250919/eddebf85224f498184daa768a79d727c_3fb0ee443389467e9ef2e6b845fe144d0.png', 124, NULL, NULL),
(185, '2025-09-19 13:17:16', '2025-09-19 13:17:16', NULL, 24, 'Sketch', '/oss/upload/20250919/2c555444e4df4fa0aee08378b3d062a8_db30b7b982dc478fbec61b6f88b63c8b.png', 125, NULL, NULL),
(186, '2025-09-19 13:18:14', '2025-09-19 13:18:14', NULL, 24, 'Silverstack LAB', '/oss/upload/20250919/2c555444e4df4fa0aee08378b3d062a8_db30b7b982dc478fbec61b6f88b63c8b.png', 126, NULL, NULL),
(187, '2025-09-19 13:18:47', '2025-09-19 13:18:47', NULL, 24, 'Silo', '/oss/upload/20250919/3d4c55808460425a9bd364918fbda2f4_75ba2cd027d14e339d3d57bf482fec96.png', 127, NULL, NULL),
(188, '2025-09-19 13:36:45', '2025-09-19 13:36:45', NULL, 24, 'Spaceclaim', '/oss/upload/20250919/abcfd297e5bc42f68b5efae6ba9aefc1_77b12ecdff9c463c997e900aa1f86e99.png', 128, NULL, NULL),
(189, '2025-09-19 13:38:13', '2025-09-19 13:38:13', NULL, 24, 'Soup for Maya', '/oss/upload/20250919/c6bf7d4b694044ba893d7b38b24b8c12_cc8b60db35d5487cb0f77f59a1e980d5.png', 129, NULL, NULL),
(190, '2025-09-19 13:39:15', '2025-09-19 13:39:15', NULL, 24, 'Syntheyes', '/oss/upload/20250919/b05baa0a4d664557809a12488f6557c6_31765d6e4a1249a4ac5829c445989451.png', 130, NULL, NULL),
(191, '2025-09-19 13:40:02', '2025-09-19 13:40:02', NULL, 24, 'Scratch', '/oss/upload/20250919/6e97ce70b0bb4e87b0ff154b2bead726_0b962ed567c34b6f9b95e41d883e220a.png', 131, NULL, NULL),
(192, '2025-09-19 13:49:39', '2025-09-19 13:49:39', NULL, 24, 'Softimage', '/oss/upload/20250919/c5741d334dd74d94af9e1806339fc4b1_cc7c1511a12046da91af6ca4be8caec7.png', 132, NULL, NULL),
(193, '2025-09-19 13:50:34', '2025-09-19 13:50:34', NULL, 24, 'Silverstack', '/oss/upload/20250919/b776f0ee159442cab209dff84068d065_6fd0b67a5bed489aaa273b605157e302.png', 133, NULL, NULL),
(194, '2025-09-19 13:51:12', '2025-09-19 13:51:12', NULL, 24, 'StarDust', '/oss/upload/20250919/443d82c56ffc4d40b58694e911adfed3_6f1fc3b846bf416a8bf23f25f592028d.png', 134, NULL, NULL),
(195, '2025-09-19 13:51:43', '2025-09-19 13:51:43', NULL, 24, 'sketch', '/oss/upload/20250919/f20e116686d5435389501806b2ece8a4_968c3f3e32014ff58a25a6a60d3bc9d1.png', 135, NULL, NULL),
(196, '2025-09-19 13:52:15', '2025-09-19 13:52:15', NULL, 24, 'stable diffusion', '/oss/upload/20250919/706f60e256db400c8bbd93ef11b9f820_b9b5c9827cd24538ac74ec564bc50464.png', 136, NULL, NULL),
(197, '2025-09-19 13:52:41', '2025-09-19 13:52:41', NULL, 24, 'Substance 3D Sampler', '/oss/upload/20250919/01d3d245dd514e37852da14dc01a41b5_82daa1ec40374b21804e36b32b6ae93c.png', 137, NULL, NULL),
(198, '2025-09-19 13:53:32', '2025-09-19 13:53:32', NULL, 24, 'SurfMill', '/oss/upload/20250919/3721288bcdf54dbb810630fc0c156670_8e121af8ccca4744b7101fa330cd240b.png', 138, NULL, NULL),
(199, '2025-09-19 13:53:58', '2025-09-23 11:21:19', NULL, 24, 'Style3D', '/oss/upload/20250919/f84c22dd24484d8796d5309ac830bded_a4eb202b75ed450da6ce72ca4d7fee90.png', 139, '推荐', NULL),
(200, '2025-09-19 13:54:44', '2025-09-19 13:54:44', NULL, 24, 'Topogun', '/oss/upload/20250919/adbaed4fb4db4982948b4b5c628fa137_43d3c0e99ae04f568c97deb9c62ace68.png', 140, NULL, NULL),
(201, '2025-09-19 13:55:10', '2025-09-19 13:55:10', NULL, 24, 'Twinmotion', '/oss/upload/20250919/4b97973dc0924ea381c65ef6c6c8000d_f306dd802c404e20ad7dd0041786c04b.png', 141, NULL, NULL),
(202, '2025-09-19 13:55:52', '2025-09-19 13:55:52', NULL, 24, 'Turbulence FD', '/oss/upload/20250919/a383de0e4ff648b4b4bcb0bdd3d54a65_858151dfe3d34e45bd57c17c08fce70f.png', 142, NULL, NULL),
(203, '2025-09-19 13:56:17', '2025-09-19 13:56:17', NULL, 24, 'Thinking Particle', '/oss/upload/20250919/df274341ce7b4dda8097e6c5d06d7029_167f3cac4c964a38ab369af8729d9774.png', 143, NULL, NULL),
(204, '2025-09-19 13:57:30', '2025-09-19 13:57:30', NULL, 24, 'The Plant Factory', '/oss/upload/20250919/1367dbd502734993894847723330895d_8827cc61269a4c6ca6f1a1745c785fa7.png', 144, NULL, NULL),
(205, '2025-09-19 13:57:55', '2025-09-19 13:57:55', NULL, 24, 'TortoiseSVN', '/oss/upload/20250919/bb5265c4a6e947668791bb6a45763af4_217ff8c7a2e64e59ac6efc8a7a80c3aa.png', 145, NULL, NULL),
(206, '2025-09-19 13:59:02', '2025-09-23 11:18:10', NULL, 24, 'Unreal Engine', '/oss/upload/20250919/d834eb465c0341779627f3b354e71288_3ed7114daaae4865bd5cd46852a7ec58.png', 146, '推荐', NULL),
(207, '2025-09-19 13:59:37', '2025-09-23 11:19:36', NULL, 24, 'Unity3d', '/oss/upload/20250919/a88a3a7901d54e178b14c23ca4f23067_54d910bff7ed4376b47bf9e63e96bf4a.png', 147, '推荐', NULL),
(208, '2025-09-19 14:00:11', '2025-09-19 14:00:11', NULL, 24, 'Unfold3D', '/oss/upload/20250919/21e2cd7978a14e4784aa3e11604fc77d_03fe95153cbd45758ad338a9e76bef33.png', 148, NULL, NULL),
(209, '2025-09-19 14:00:36', '2025-09-19 14:00:36', NULL, 24, 'UVLayout', '/oss/upload/20250919/4d032eaaec0945578bda16fe80be8d1e_7ab6ab89713c413fbe4e7d2a6279124c.png', 149, NULL, NULL),
(210, '2025-09-19 14:00:58', '2025-09-19 14:00:58', NULL, 24, 'UDK', '/oss/upload/20250919/5f17b636dbd44ec88768806a5181e139_8459a80cbe904346a8b55a73dd46add2.png', 150, NULL, NULL),
(211, '2025-09-19 14:01:45', '2025-09-19 14:01:45', NULL, 24, 'Vray', '/oss/upload/20250919/75e9238ecade48218de9fd572c47a1ee_6181e75848c24f0c95d35128f4323dfe.png', 151, NULL, NULL),
(212, '2025-09-19 14:02:09', '2025-09-19 14:02:09', NULL, 24, 'Visual Studio', '/oss/upload/20250919/face02a17fe54611b92f8e6e00b304df_0e68fa149180439683625039449a4d82.png', 152, NULL, NULL),
(213, '2025-09-19 14:07:55', '2025-09-19 14:07:55', NULL, 24, 'VUE', '/oss/upload/20250919/184cbf81873d41e288df7bccbbb1423f_vue.png', 153, NULL, NULL),
(214, '2025-09-19 14:08:32', '2025-09-19 14:08:32', NULL, 24, 'World Creator', '/oss/upload/20250919/ec5d99161b3e4bf48b74671f8ae77715_4264f6b6159848f8a8df046ec2ad440c.png', 154, NULL, NULL),
(215, '2025-09-19 14:09:00', '2025-09-19 14:09:00', NULL, 24, 'WorldMachine', '/oss/upload/20250919/7050a85601704ce586e0b7943db9e004_5f76b7a1657545bca2cc62ef74ba675c.png', 155, NULL, NULL),
(216, '2025-09-19 14:09:29', '2025-09-19 14:09:48', NULL, 24, 'Wrap4D', '/oss/upload/20250919/015fd315adf543c680ba29c4b019476a_8718c64bc09548e7b49eb00e8ba5bc0d.png', 156, NULL, NULL),
(217, '2025-09-19 14:10:07', '2025-09-19 14:10:07', NULL, 24, 'Wrapit', '/oss/upload/20250919/b5ea93be30b146058b5a591da56c2a6e_a44c8a6f4332467fa470188ba3dbe9f0.png', 157, NULL, NULL),
(218, '2025-09-19 14:12:31', '2025-09-19 14:12:31', NULL, 24, 'WechatMini', '/oss/upload/20250919/c46fff1f478c42e687b62ce10aeb6690_e556578b08724ee69804b5aef6442fe4.png', 158, NULL, NULL),
(219, '2025-09-19 14:13:10', '2025-09-19 14:13:10', NULL, 24, 'X-Particle', '/oss/upload/20250919/df9aab37d1f441319b753b28490d7b8e_3ca8e79c89e24b91a5cb0ec0df4e7780.png', 159, NULL, NULL),
(220, '2025-09-19 14:14:00', '2025-09-19 14:14:00', NULL, 24, 'AdobeXD', '/oss/upload/20250919/4973f53079a74ad9883662511a5cbb7c_2d1a1fe53ec6482d8ced6e62cade44de.png', 160, NULL, NULL),
(221, '2025-09-19 14:14:31', '2025-09-19 14:14:31', NULL, 24, 'Yeti', '/oss/upload/20250919/b5614b0b808e4e6181525dab2cf4a996_851589dba0c7442fbe0c319dd43114b2.png', 161, NULL, NULL),
(222, '2025-09-19 14:14:57', '2025-09-19 14:14:57', NULL, 24, 'Yun720', '/oss/upload/20250919/d636a1b98d2e4533a7c39ba039df5328_ce7d413723124c9eb2cded79e846e1ff.png', 162, NULL, NULL),
(223, '2025-09-19 14:15:31', '2025-09-23 11:18:20', NULL, 24, 'Zbrush', '/oss/upload/20250919/d06a21d0073b4ba7859ed3a5f22d0675_a5b0934f4d054f28b10a966247376f75.png', 163, '推荐', NULL),
(224, '2025-09-23 14:14:53', '2025-09-23 14:14:53', NULL, 25, '入门课程', '1', 1, NULL, NULL),
(225, '2025-09-23 14:15:02', '2025-09-23 14:15:02', NULL, 25, '初级课程', '2', 2, NULL, NULL),
(226, '2025-09-23 14:15:48', '2025-09-23 14:15:48', NULL, 25, '中级课程', '3', 3, NULL, NULL),
(227, '2025-09-23 14:16:00', '2025-09-23 14:16:08', NULL, 25, '高级课程', '4', 4, NULL, NULL),
(228, '2025-09-23 14:16:17', '2025-09-23 14:16:17', NULL, 25, '专家课程', '5', 5, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `dict_type`
--

CREATE TABLE `dict_type` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标识'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `dict_type`
--

INSERT INTO `dict_type` (`id`, `createTime`, `updateTime`, `tenantId`, `name`, `key`) VALUES
(19, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, '品牌', 'brand'),
(20, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, '职业', 'occupation'),
(23, '2025-09-18 14:15:01', '2025-09-18 14:15:01', NULL, '技能', 'skill'),
(24, '2025-09-18 18:19:32', '2025-09-18 18:19:32', NULL, '软件', 'software'),
(25, '2025-09-23 14:14:29', '2025-09-23 14:14:38', NULL, '课程难度等级', 'courseLevel');

-- --------------------------------------------------------

--
-- 表的结构 `log`
--

CREATE TABLE `log` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `userId` int DEFAULT NULL COMMENT '用户ID',
  `computerId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '计算机ID',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接口地址',
  `suspiciousOperation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '可疑操作',
  `suspiciousOperationIp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'IP地址',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '日志类型 0-请求记录 1-可疑操作'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `plugin_info`
--

CREATE TABLE `plugin_info` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '简介',
  `keyName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Key名',
  `hook` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Hook',
  `readme` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '描述',
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '版本',
  `logo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Logo(base64)',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '作者',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态 0-禁用 1-启用',
  `content` json NOT NULL COMMENT '内容',
  `tsContent` json NOT NULL COMMENT 'ts内容',
  `pluginJson` json DEFAULT NULL COMMENT '插件的plugin.json',
  `config` json DEFAULT NULL COMMENT '配置'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `query-result-cache`
--

CREATE TABLE `query-result-cache` (
  `id` int NOT NULL,
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` bigint NOT NULL,
  `duration` int NOT NULL,
  `query` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `recycle_data`
--

CREATE TABLE `recycle_data` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `entityInfo` json NOT NULL COMMENT '表',
  `userId` int DEFAULT NULL COMMENT '操作人',
  `data` json NOT NULL COMMENT '被删除的数据',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求的接口',
  `params` json DEFAULT NULL COMMENT '请求参数',
  `count` int NOT NULL DEFAULT '1' COMMENT '删除数据条数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------

--
-- 表的结构 `space_info`
--

CREATE TABLE `space_info` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地址',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '类型',
  `classifyId` int DEFAULT NULL COMMENT '分类ID',
  `fileId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件名',
  `size` int NOT NULL COMMENT '文件大小',
  `version` int NOT NULL DEFAULT '1' COMMENT '文档版本',
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件位置'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `space_type`
--

CREATE TABLE `space_type` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '类别名称',
  `parentId` int DEFAULT NULL COMMENT '父分类ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `space_type`
--

INSERT INTO `space_type` (`id`, `createTime`, `updateTime`, `tenantId`, `name`, `parentId`) VALUES
(1, '2025-02-22 16:25:43', '2025-02-22 16:25:43', NULL, '视频', NULL),
(2, '2025-02-22 20:06:49', '2025-02-22 20:06:49', 20, '图片仓库', NULL),
(3, '2025-02-24 15:06:03', '2025-02-24 15:06:03', NULL, '图片', NULL),
(4, '2025-09-18 18:20:54', '2025-09-18 18:20:54', NULL, '软件图标', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `task_info`
--

CREATE TABLE `task_info` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `jobId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务ID',
  `repeatConf` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务配置',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `cron` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'cron',
  `limit` int DEFAULT NULL COMMENT '最大执行次数 不传为无限次',
  `every` int DEFAULT NULL COMMENT '每间隔多少毫秒执行一次 如果cron设置了 这项设置就无效',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态 0-停止 1-运行',
  `startDate` datetime DEFAULT NULL COMMENT '开始时间',
  `endDate` datetime DEFAULT NULL COMMENT '结束时间',
  `data` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据',
  `service` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '执行的service实例ID',
  `type` int NOT NULL DEFAULT '0' COMMENT '状态 0-系统 1-用户',
  `nextRunTime` datetime DEFAULT NULL COMMENT '下一次执行时间',
  `taskType` int NOT NULL DEFAULT '0' COMMENT '状态 0-cron 1-时间间隔',
  `lastExecuteTime` datetime DEFAULT NULL,
  `lockExpireTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `task_info`
--

INSERT INTO `task_info` (`id`, `createTime`, `updateTime`, `tenantId`, `jobId`, `repeatConf`, `name`, `cron`, `limit`, `every`, `remark`, `status`, `startDate`, `endDate`, `data`, `service`, `type`, `nextRunTime`, `taskType`, `lastExecuteTime`, `lockExpireTime`) VALUES
(1, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, '089f554c-fdd4-4093-9f84-4cfb6af2f514', '{\"count\":1,\"type\":1,\"limit\":5,\"name\":\"每秒执行,总共5次\",\"taskType\":1,\"every\":1000,\"service\":\"taskDemoService.test()\",\"status\":1,\"id\":1,\"createTime\":\"2021-03-10 14:25:13\",\"updateTime\":\"2021-03-10 14:25:13\",\"jobId\":1}', '每秒执行一次', NULL, NULL, 1000, NULL, 0, NULL, NULL, NULL, 'taskDemoService.test(1,2)', 1, '2021-03-10 14:25:18', 1, NULL, NULL),
(2, '2025-02-19 20:43:33', '2025-02-19 20:43:33', NULL, '9e1f42c8-b127-449b-b0a4-d53c60b79e75', '{\"count\":1,\"id\":2,\"createTime\":\"2021-03-10 14:25:53\",\"updateTime\":\"2021-03-10 14:25:55\",\"name\":\"cron任务，5秒执行一次\",\"cron\":\"0/5 * * * * ? \",\"status\":1,\"service\":\"taskDemoService.test()\",\"type\":1,\"nextRunTime\":\"2021-03-10 14:26:00\",\"taskType\":0,\"jobId\":2}', 'cron任务，5秒执行一次', '0/5 * * * * * ', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'taskDemoService.test()', 1, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `task_log`
--

CREATE TABLE `task_log` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `taskId` int DEFAULT NULL COMMENT '任务ID',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态 0-失败 1-成功',
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '详情描述'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `user_address`
--

CREATE TABLE `user_address` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `userId` int NOT NULL COMMENT '用户ID',
  `contact` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '市',
  `district` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '区',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地址',
  `isDefault` tinyint NOT NULL DEFAULT '0' COMMENT '是否默认'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `user_computer`
--

CREATE TABLE `user_computer` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `userId` int DEFAULT NULL COMMENT '用户ID',
  `computerId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '计算机ID',
  `computerName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '计算机名称',
  `lastLoginTime` datetime DEFAULT NULL COMMENT '最近登录时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------

--
-- 表的结构 `user_info`
--

CREATE TABLE `user_info` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `unionid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录唯一ID',
  `avatarUrl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `nickName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `gender` int NOT NULL DEFAULT '0' COMMENT '性别',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态',
  `loginType` int NOT NULL DEFAULT '0' COMMENT '登录方式',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '介绍',
  `scores` int NOT NULL DEFAULT '0' COMMENT '积分',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `isActivate` tinyint NOT NULL DEFAULT '0' COMMENT '是否激活',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '个人网站',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `user_info`
--

INSERT INTO `user_info` (`id`, `createTime`, `updateTime`, `tenantId`, `unionid`, `avatarUrl`, `nickName`, `phone`, `gender`, `status`, `loginType`, `password`, `description`, `scores`, `email`, `isActivate`, `website`, `balance`) VALUES
(1, '2025-10-24 14:02:05', '2025-10-24 14:02:05', 20, NULL, NULL, 'kkkkkkkk', NULL, 0, 1, 2, '18a0f3751c59520bf6a66237fb3f46d3', NULL, 0, '2201910350@qq.com', 1, NULL, 0.00);

-- --------------------------------------------------------

--
-- 表的结构 `user_request_log`
--

CREATE TABLE `user_request_log` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `userId` int NOT NULL COMMENT '用户ID',
  `computerId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '计算机ID',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接口地址',
  `suspiciousOperation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '可疑操作',
  `type` int NOT NULL COMMENT '日志类型 0-请求记录 1-可疑操作',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'IP地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `user_wx`
--

CREATE TABLE `user_wx` (
  `id` int NOT NULL COMMENT 'ID',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  `tenantId` int DEFAULT NULL COMMENT '租户ID',
  `unionid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信unionid',
  `openid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '微信openid',
  `avatarUrl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `nickName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `gender` int NOT NULL DEFAULT '0' COMMENT '性别 0-未知 1-男 2-女',
  `language` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '语言',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '城市',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '省份',
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '国家',
  `type` int NOT NULL DEFAULT '0' COMMENT '类型 0-小程序 1-公众号 2-H5 3-APP'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转储表的索引
--

--
-- 表的索引 `balance_date_signature`
--
ALTER TABLE `balance_date_signature`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_9a8bcb0fa56b6191a627d8d8c0` (`createTime`),
  ADD KEY `IDX_334eab082e77e87257dc12a031` (`updateTime`),
  ADD KEY `IDX_19e8fe8c78890af19e1d2f3203` (`tenantId`);

--
-- 表的索引 `balance_history`
--
ALTER TABLE `balance_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_21fb5e0d86ac8edd4baa43aa07` (`createTime`),
  ADD KEY `IDX_b7f5d622dbc1bb76231dff01e3` (`updateTime`),
  ADD KEY `IDX_fd4cc2acaa99fbd5e84d7d6f95` (`tenantId`);

--
-- 表的索引 `balance_recharge_code`
--
ALTER TABLE `balance_recharge_code`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_a4c350e3d831c85bdf89883fb4` (`code`),
  ADD KEY `IDX_c763a12a94047cfb4659d39a09` (`createTime`),
  ADD KEY `IDX_6ba807ae42bba284d224026e02` (`updateTime`),
  ADD KEY `IDX_665445577d5070d800a0edcc69` (`tenantId`);

--
-- 表的索引 `base_sys_conf`
--
ALTER TABLE `base_sys_conf`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_9be195d27767b4485417869c3a` (`cKey`),
  ADD KEY `IDX_905208f206a3ff9fd513421971` (`createTime`),
  ADD KEY `IDX_4c6f27f6ecefe51a5a196a047a` (`updateTime`),
  ADD KEY `IDX_03fc424a2f8093a538730a7ff2` (`tenantId`);

--
-- 表的索引 `base_sys_department`
--
ALTER TABLE `base_sys_department`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_be4c53cd671384fa588ca9470a` (`createTime`),
  ADD KEY `IDX_ca1473a793961ec55bc0c8d268` (`updateTime`),
  ADD KEY `IDX_f19e8ffd9c62ddb17e76c8b9d7` (`tenantId`);

--
-- 表的索引 `base_sys_log`
--
ALTER TABLE `base_sys_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_c9382b76219a1011f7b8e7bcd1` (`createTime`),
  ADD KEY `IDX_bfd44e885b470da43bcc39aaa7` (`updateTime`),
  ADD KEY `IDX_384bde153859845bf0dcdc00f6` (`tenantId`),
  ADD KEY `IDX_51a2caeb5713efdfcb343a8772` (`userId`),
  ADD KEY `IDX_938f886fb40e163db174b7f6c3` (`action`),
  ADD KEY `IDX_24e18767659f8c7142580893f2` (`ip`);

--
-- 表的索引 `base_sys_menu`
--
ALTER TABLE `base_sys_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_05e3d6a56604771a6da47ebf8e` (`createTime`),
  ADD KEY `IDX_d5203f18daaf7c3fe0ab34497f` (`updateTime`),
  ADD KEY `IDX_2087f9610c1fc5a184bedaacef` (`tenantId`);

--
-- 表的索引 `base_sys_module`
--
ALTER TABLE `base_sys_module`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_6b766e63975f4dc060d130b505` (`key`),
  ADD KEY `IDX_eb1153a253a6c6c1d979a0670c` (`createTime`),
  ADD KEY `IDX_81798fd33cd983a49e430cfcff` (`updateTime`),
  ADD KEY `IDX_941cc5ff63481efb3b6d4fcbfe` (`tenantId`);

--
-- 表的索引 `base_sys_module_menu`
--
ALTER TABLE `base_sys_module_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_bbce05c5d37431e74f4cf6beaf` (`createTime`),
  ADD KEY `IDX_e2e75b5db65bb2b3c3541e8b09` (`updateTime`),
  ADD KEY `IDX_1eadb18dd1246e6369c74b3c91` (`tenantId`);

--
-- 表的索引 `base_sys_param`
--
ALTER TABLE `base_sys_param`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_cf19b5e52d8c71caa9c4534454` (`keyName`),
  ADD KEY `IDX_7bcb57371b481d8e2d66ddeaea` (`createTime`),
  ADD KEY `IDX_479122e3bf464112f7a7253dac` (`updateTime`),
  ADD KEY `IDX_8a0ab598ca7d63475356ca1157` (`tenantId`);

--
-- 表的索引 `base_sys_role`
--
ALTER TABLE `base_sys_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_469d49a5998170e9550cf113da` (`name`),
  ADD UNIQUE KEY `IDX_f3f24fbbccf00192b076e549a7` (`label`),
  ADD KEY `IDX_6f01184441dec49207b41bfd92` (`createTime`),
  ADD KEY `IDX_d64ca209f3fc52128d9b20e97b` (`updateTime`),
  ADD KEY `IDX_953dc26a4e8bd5d9c989295796` (`tenantId`);

--
-- 表的索引 `base_sys_role_department`
--
ALTER TABLE `base_sys_role_department`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_e881a66f7cce83ba431cf20194` (`createTime`),
  ADD KEY `IDX_cbf48031efee5d0de262965e53` (`updateTime`),
  ADD KEY `IDX_055658b2de49d547635e06f160` (`tenantId`);

--
-- 表的索引 `base_sys_role_menu`
--
ALTER TABLE `base_sys_role_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_3641f81d4201c524a57ce2aa54` (`createTime`),
  ADD KEY `IDX_f860298298b26e7a697be36e5b` (`updateTime`),
  ADD KEY `IDX_fd2d8bbe13949cfa56b1ed0a5d` (`tenantId`);

--
-- 表的索引 `base_sys_tenant`
--
ALTER TABLE `base_sys_tenant`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_4e9a2203927892aec2735b99af` (`tenantName`),
  ADD UNIQUE KEY `IDX_6786cc90e3f0ba01049c7fa3cd` (`tenantCode`),
  ADD KEY `IDX_c1f6561d894733c29b368ac6da` (`createTime`),
  ADD KEY `IDX_a8c9cd268b0bc4e94044aa07cc` (`updateTime`),
  ADD KEY `IDX_c75b2f2367cd2d32be0871668b` (`tenantId`);

--
-- 表的索引 `base_sys_tenant_menu`
--
ALTER TABLE `base_sys_tenant_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_f34c24af72ded87f72a5e4b9f6` (`createTime`),
  ADD KEY `IDX_8407e5c3ded1481eb6009e7908` (`updateTime`),
  ADD KEY `IDX_721a09801396bd62b597dcd7a2` (`tenantId`);

--
-- 表的索引 `base_sys_tenant_module`
--
ALTER TABLE `base_sys_tenant_module`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_0274eafa00374bf74dcd010662` (`createTime`),
  ADD KEY `IDX_f7dc98bbf95bfe482d991b5955` (`updateTime`),
  ADD KEY `IDX_28c7ed6fc46c83df09505e03df` (`tenantId`);

--
-- 表的索引 `base_sys_tenant_register`
--
ALTER TABLE `base_sys_tenant_register`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_b6f84f8a2282755ef2962d6d3a` (`createTime`),
  ADD KEY `IDX_21c3501ad7ed391b6906d5d27f` (`updateTime`),
  ADD KEY `IDX_96eb67b506545889e82737db65` (`tenantId`),
  ADD KEY `IDX_80ed2d5c44fc19ae32fd3c4cb7` (`tenantName`),
  ADD KEY `IDX_3a2e58923a32dcadab0fc60cd2` (`contactEmail`);

--
-- 表的索引 `base_sys_user`
--
ALTER TABLE `base_sys_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_469ad55973f5b98930f6ad627b` (`username`),
  ADD KEY `IDX_ca8611d15a63d52aa4e292e46a` (`createTime`),
  ADD KEY `IDX_a0f2f19cee18445998ece93ddd` (`updateTime`),
  ADD KEY `IDX_94cb6e88070603ac6729d514fd` (`tenantId`),
  ADD KEY `IDX_0cf944da378d70a94f5fefd803` (`departmentId`),
  ADD KEY `IDX_9ec6d7ac6337eafb070e4881a8` (`phone`);

--
-- 表的索引 `base_sys_user_role`
--
ALTER TABLE `base_sys_user_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_fa9555e03e42fce748c9046b1c` (`createTime`),
  ADD KEY `IDX_3e36c0d2b1a4c659c6b4fc64b3` (`updateTime`),
  ADD KEY `IDX_2f1dc0b6aad5604a2ddf37fba6` (`tenantId`);

--
-- 表的索引 `content_category`
--
ALTER TABLE `content_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_0b8a816221d12756cc02c366de` (`createTime`),
  ADD KEY `IDX_eaf0dd94c19ead6aac66012609` (`updateTime`),
  ADD KEY `IDX_e3a9a91a865ffeeb089c34c481` (`tenantId`);

--
-- 表的索引 `content_course`
--
ALTER TABLE `content_course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_34f5efc6448e7c1d6f17bc04fb` (`createTime`),
  ADD KEY `IDX_018444286e676eebb27c4b4d9d` (`updateTime`),
  ADD KEY `IDX_22eca596f3782439f07c50140a` (`tenantId`);

--
-- 表的索引 `content_course_content`
--
ALTER TABLE `content_course_content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_9ddf6056181f8d05a624f6e233` (`createTime`),
  ADD KEY `IDX_f5cc778c57791a74271cb2ca2a` (`updateTime`),
  ADD KEY `IDX_f45633995b66840136e7b96986` (`tenantId`);

--
-- 表的索引 `content_order`
--
ALTER TABLE `content_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_19ca1b5afd2b55131dc3a21581` (`createTime`),
  ADD KEY `IDX_d05c2b2ffda819c2891fa35971` (`updateTime`),
  ADD KEY `IDX_95e89c54d629434f6128bc8dff` (`tenantId`);

--
-- 表的索引 `content_user_course`
--
ALTER TABLE `content_user_course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_cccf147dabe9a3cda107b4eaf5` (`createTime`),
  ADD KEY `IDX_f50fb6fff695a5cdf463cbeb4c` (`updateTime`),
  ADD KEY `IDX_21bca5e81a1989400cf1135ee4` (`tenantId`),
  ADD KEY `FK_b6b76579edf349442ffb7faabd4` (`courseId`);

--
-- 表的索引 `content_user_scores`
--
ALTER TABLE `content_user_scores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_2c6277a677b8c5c12e6dfa38b6` (`createTime`),
  ADD KEY `IDX_bb3dcc8e622c0edb319cb5adf2` (`updateTime`),
  ADD KEY `IDX_4b6cc31f01fbcdebb3bcf34dee` (`tenantId`);

--
-- 表的索引 `course_key`
--
ALTER TABLE `course_key`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_8ebd882d18a4b70420159e77db` (`createTime`),
  ADD KEY `IDX_75d564ae7887dc8a9ef5025480` (`updateTime`),
  ADD KEY `IDX_04a4d21a2641d5f44c687f590c` (`tenantId`);

--
-- 表的索引 `demo_goods`
--
ALTER TABLE `demo_goods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_5075bf301ed9c39b5ca534231c` (`createTime`),
  ADD KEY `IDX_82703e0477d1219261277df718` (`updateTime`),
  ADD KEY `IDX_4773d4d34db0d601516da30bf3` (`tenantId`),
  ADD KEY `IDX_85a70ee36c7c1b0a04bfa1ed27` (`title`);

--
-- 表的索引 `dict_info`
--
ALTER TABLE `dict_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_5c311a4af30de1181a5d7a7cc2` (`createTime`),
  ADD KEY `IDX_10362a62adbf120821fff209d8` (`updateTime`),
  ADD KEY `IDX_c26dc4b1ccb26e642191995edd` (`tenantId`);

--
-- 表的索引 `dict_type`
--
ALTER TABLE `dict_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_69734e5c2d29cc2139d5078f2c` (`createTime`),
  ADD KEY `IDX_6cccb2e33846cd354e8dc0e0ef` (`updateTime`),
  ADD KEY `IDX_7d4f3d2336e1afdda38278a07e` (`tenantId`);

--
-- 表的索引 `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_9eb1f2da11b56e629b61bff5c7` (`createTime`),
  ADD KEY `IDX_506ad2bdf6bcc5c6f764ea7f78` (`updateTime`),
  ADD KEY `IDX_2f23862f9e01cfc74d50d2ce45` (`tenantId`);

--
-- 表的索引 `plugin_info`
--
ALTER TABLE `plugin_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_071da0804576df95363c24357c` (`createTime`),
  ADD KEY `IDX_d94d7c2437aca9f1b183979b07` (`updateTime`),
  ADD KEY `IDX_89a39daf328b50686755795546` (`tenantId`),
  ADD KEY `IDX_95719662507de0fbf70ad1b5ee` (`keyName`);

--
-- 表的索引 `query-result-cache`
--
ALTER TABLE `query-result-cache`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `recycle_data`
--
ALTER TABLE `recycle_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_59fc783673f4a322e9c83e0599` (`createTime`),
  ADD KEY `IDX_c6a499c4a4fcd37f2930d27816` (`updateTime`),
  ADD KEY `IDX_6659453338145e11d9b5103f38` (`tenantId`),
  ADD KEY `IDX_f3ed09ba7090f3eb378cb83b5b` (`userId`);

--
-- 表的索引 `space_info`
--
ALTER TABLE `space_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_eb1da2f304c760846b5add09b3` (`createTime`),
  ADD KEY `IDX_d7a2539961e9aacba8b353f3c9` (`updateTime`),
  ADD KEY `IDX_6001c5ed2088b893c0d69bb244` (`tenantId`),
  ADD KEY `IDX_0975633032bfe6574468b3a4ae` (`fileId`);

--
-- 表的索引 `space_type`
--
ALTER TABLE `space_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6669449501d275f367ca295472` (`createTime`),
  ADD KEY `IDX_0749b509b68488caecd4cc2bbc` (`updateTime`),
  ADD KEY `IDX_5e7f846b8cdabbceba95ed3314` (`tenantId`);

--
-- 表的索引 `task_info`
--
ALTER TABLE `task_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6ced02f467e59bd6306b549bb0` (`createTime`),
  ADD KEY `IDX_2adc6f9c241391126f27dac145` (`updateTime`),
  ADD KEY `IDX_11b991dc4a7a5585c636008d3a` (`tenantId`);

--
-- 表的索引 `task_log`
--
ALTER TABLE `task_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_b9af0e100be034924b270aab31` (`createTime`),
  ADD KEY `IDX_8857d8d43d38bebd7159af1fa6` (`updateTime`),
  ADD KEY `IDX_fa4cb94036d961600c0f22ed91` (`tenantId`),
  ADD KEY `IDX_1142dfec452e924b346f060fda` (`taskId`);

--
-- 表的索引 `user_address`
--
ALTER TABLE `user_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_144621f4f7bf21e72ed6972d85` (`createTime`),
  ADD KEY `IDX_de647797f6286697bfe9527955` (`updateTime`),
  ADD KEY `IDX_d93103979d4be73c3192163996` (`tenantId`),
  ADD KEY `IDX_1abd8badc4a127b0f357d9ecbc` (`userId`),
  ADD KEY `IDX_905be3a22a4dfda68da8e4200a` (`phone`);

--
-- 表的索引 `user_computer`
--
ALTER TABLE `user_computer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_2e1d2b3c207ea4c96d17f225aa` (`createTime`),
  ADD KEY `IDX_d9372ff61b9e3c31f1d9a00194` (`updateTime`),
  ADD KEY `IDX_4207a38e18585a5a90ce58fc00` (`tenantId`);

--
-- 表的索引 `user_info`
--
ALTER TABLE `user_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_6edeceee578056a2c1e493563a` (`unionid`),
  ADD UNIQUE KEY `IDX_9234e7bac72991a93b172618e2` (`phone`),
  ADD KEY `IDX_e6386e92c288d85dbc43ac53f7` (`createTime`),
  ADD KEY `IDX_5271afbb87138d688b6220b589` (`updateTime`),
  ADD KEY `IDX_7c8ea8d68808b77734df54ce32` (`tenantId`);

--
-- 表的索引 `user_request_log`
--
ALTER TABLE `user_request_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_4e3e62ff363fb39ea4ea39b432` (`createTime`),
  ADD KEY `IDX_a00c5d264ca178bd36829f78a5` (`updateTime`),
  ADD KEY `IDX_bd1bc8ceabcaa29505aedf713a` (`tenantId`);

--
-- 表的索引 `user_wx`
--
ALTER TABLE `user_wx`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_e23b473abf5a6b00e44f3fd842` (`createTime`),
  ADD KEY `IDX_049adb91204e94c1ede5e6dd23` (`updateTime`),
  ADD KEY `IDX_f39f7e2dd63c906fcee61c50ad` (`tenantId`),
  ADD KEY `IDX_d22b5fa040a01ec1b09e1e181e` (`unionid`),
  ADD KEY `IDX_7946849febadd93cf81fc2b53f` (`openid`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `balance_date_signature`
--
ALTER TABLE `balance_date_signature`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=16;

--
-- 使用表AUTO_INCREMENT `balance_history`
--
ALTER TABLE `balance_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=18;

--
-- 使用表AUTO_INCREMENT `balance_recharge_code`
--
ALTER TABLE `balance_recharge_code`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=42;

--
-- 使用表AUTO_INCREMENT `base_sys_conf`
--
ALTER TABLE `base_sys_conf`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `base_sys_department`
--
ALTER TABLE `base_sys_department`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=19;

--
-- 使用表AUTO_INCREMENT `base_sys_log`
--
ALTER TABLE `base_sys_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=83514;

--
-- 使用表AUTO_INCREMENT `base_sys_menu`
--
ALTER TABLE `base_sys_menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=196;

--
-- 使用表AUTO_INCREMENT `base_sys_module`
--
ALTER TABLE `base_sys_module`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `base_sys_module_menu`
--
ALTER TABLE `base_sys_module_menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=687;

--
-- 使用表AUTO_INCREMENT `base_sys_param`
--
ALTER TABLE `base_sys_param`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `base_sys_role`
--
ALTER TABLE `base_sys_role`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `base_sys_role_department`
--
ALTER TABLE `base_sys_role_department`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=31;

--
-- 使用表AUTO_INCREMENT `base_sys_role_menu`
--
ALTER TABLE `base_sys_role_menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=581;

--
-- 使用表AUTO_INCREMENT `base_sys_tenant`
--
ALTER TABLE `base_sys_tenant`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=21;

--
-- 使用表AUTO_INCREMENT `base_sys_tenant_menu`
--
ALTER TABLE `base_sys_tenant_menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `base_sys_tenant_module`
--
ALTER TABLE `base_sys_tenant_module`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=69;

--
-- 使用表AUTO_INCREMENT `base_sys_tenant_register`
--
ALTER TABLE `base_sys_tenant_register`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `base_sys_user`
--
ALTER TABLE `base_sys_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=9;

--
-- 使用表AUTO_INCREMENT `base_sys_user_role`
--
ALTER TABLE `base_sys_user_role`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=22;

--
-- 使用表AUTO_INCREMENT `content_category`
--
ALTER TABLE `content_category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=72;

--
-- 使用表AUTO_INCREMENT `content_course`
--
ALTER TABLE `content_course`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=49;

--
-- 使用表AUTO_INCREMENT `content_course_content`
--
ALTER TABLE `content_course_content`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=112;

--
-- 使用表AUTO_INCREMENT `content_order`
--
ALTER TABLE `content_order`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=8;

--
-- 使用表AUTO_INCREMENT `content_user_course`
--
ALTER TABLE `content_user_course`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=51;

--
-- 使用表AUTO_INCREMENT `content_user_scores`
--
ALTER TABLE `content_user_scores`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `course_key`
--
ALTER TABLE `course_key`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=111;

--
-- 使用表AUTO_INCREMENT `demo_goods`
--
ALTER TABLE `demo_goods`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dict_info`
--
ALTER TABLE `dict_info`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=229;

--
-- 使用表AUTO_INCREMENT `dict_type`
--
ALTER TABLE `dict_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=26;

--
-- 使用表AUTO_INCREMENT `log`
--
ALTER TABLE `log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `plugin_info`
--
ALTER TABLE `plugin_info`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `query-result-cache`
--
ALTER TABLE `query-result-cache`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `recycle_data`
--
ALTER TABLE `recycle_data`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=140;

--
-- 使用表AUTO_INCREMENT `space_info`
--
ALTER TABLE `space_info`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=200;

--
-- 使用表AUTO_INCREMENT `space_type`
--
ALTER TABLE `space_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `task_info`
--
ALTER TABLE `task_info`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `task_log`
--
ALTER TABLE `task_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `user_address`
--
ALTER TABLE `user_address`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `user_computer`
--
ALTER TABLE `user_computer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=25;

--
-- 使用表AUTO_INCREMENT `user_info`
--
ALTER TABLE `user_info`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=109;

--
-- 使用表AUTO_INCREMENT `user_request_log`
--
ALTER TABLE `user_request_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=1014;

--
-- 使用表AUTO_INCREMENT `user_wx`
--
ALTER TABLE `user_wx`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 限制导出的表
--

--
-- 限制表 `content_user_course`
--
ALTER TABLE `content_user_course`
  ADD CONSTRAINT `FK_b6b76579edf349442ffb7faabd4` FOREIGN KEY (`courseId`) REFERENCES `content_course` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

# 🚤 知舟课堂 (ZhiZhou Academy)

> 一站式 IT 职业技能学习平台 · 让学习更有价值

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![Stars](https://img.shields.io/github/stars/yiyinideshang/ZhiZhou-Academy?style=social)](https://github.com/yiyinideshang/ZhiZhou-Academy) [![GitHub](https://img.shields.io/badge/GitHub-yiyinideshang-181717?style=flat&logo=github)](https://github.com/yiyinideshang) [![Email](https://img.shields.io/badge/Email-2779271357%40qq.com-blue?style=flat&logo=gmail)](mailto:2779271357@qq.com)

---

# 📖 项目概述

基于 **ASP.NET Web Forms** 开发的在线课程管理系统，采用三层架构（Model-DAL-BLL）设计模式。提供课程浏览、购买、收藏、评分、评论等核心功能，面向在线 IT 技能学习场景。

> ⚠️ **运行前请务必阅读 [#如何使用](#-如何使用) 和 [配置数据库](#3--配置数据库关键步骤)！**

# 🧱 技术栈

| 分类     | 技术                                            |
| -------- | ----------------------------------------------- |
| 框架     | ASP.NET Web Forms（.NET Framework 4.0+）        |
| 语言     | C#                                              |
| 数据库   | SQL Server                                      |
| 架构     | 三层架构（Model / DAL / BLL / DBUtility / Web） |
| 开发工具 | Visual Studio 2013+                             |
| 部署     | IIS 7.0+                                        |

# 👥 角色与功能

| 角色         | 核心功能                                             |
| ------------ | ---------------------------------------------------- |
| **普通用户** | 浏览课程、搜索筛选、加入购物车、收藏、购买、评分评论 |
| **VIP 用户** | 享有普通用户所有权限 + VIP 专属权益                  |
| **管理员**   | 用户管理、课程管理、分类管理、订单管理               |

# 🗂️ 项目结构

```
ZhiZhou-Academy/
├── Model/          # 数据实体模型
├── DAL/            # 数据访问层
├── BLL/            # 业务逻辑层
├── DBUtility/      # 数据库工具类
├── Web/            # 前端页面与后端交互
│   ├── Admin/      # 管理员后台
│   ├── images/     # 页面图片资源
│   └── music/      # 背景音乐资源
├── Lib/            # 第三方依赖库
└── 说明/           # 项目文档
```

# 🚀 如何使用

> ⚠️ **本项目需要在本地配置 SQL Server 数据库才能运行，请务必按以下步骤操作！**

## 1. 环境要求

| 依赖          | 版本要求          |
| :------------ | :---------------- |
| Windows       | 7+ / Server 2008+ |
| Visual Studio | 2013+             |
| SQL Server    | 2008+             |
| IIS           | 7.0+（部署用）    |

## 2. 获取源码

```bash
git clone https://github.com/yiyinideshang/ZhiZhou-Academy.git
```

## 3. ⭐ 配置数据库（关键步骤）

> 🚨 **此步骤若不完成，项目将无法正常运行！**

1. 找到 `SQL/CourseManagement.mdf` 数据库文件
2. 在 SQL Server Management Studio 中**附加**该数据库
3. 修改 `Web/Web.config` 中的连接字符串：
   - `server` 改为你的 SQL Server 实例名
   - `uid` 为数据库用户名
   - `pwd` 为数据库密码

```xml
<add key="ConnectionString" value="server=你的服务器名;database=CourseManagement;uid=sa;pwd=你的密码"/>
```

## 4. 配置图片资源

首页背景图等资源托管于独立仓库：

👉 [https://github.com/yiyinideshang/zhizhou-images](https://github.com/yiyinideshang/zhizhou-images)

将图片下载后放入 `Web/images/` 对应目录。

## 5. 运行项目

在 Visual Studio 中打开 `Group7.sln` → 右键 `Web` 项目 → 设为启动项目 → 按 `F5` 运行。

## 6. 部署到 IIS

将 `Web/` 目录发布到 IIS，应用程序池选择 .NET Framework 4.0，确保数据库连接正常。

# 👨‍💻 开发团队

| 成员     | 角色        |
| -------- | ----------- |
| zhang/Me | Team Member |
| wang     | Team Member |
| jin      | Team Member |

# 📄 说明

- 本项目为 **网络项目实训** 课程作品
- 仅供学习参考，**禁止商用**

---

<div align="center">
  <sub>Built with ❤️ for ZhiZhou Academy</sub>
</div>


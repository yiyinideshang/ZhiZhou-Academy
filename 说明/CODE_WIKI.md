# Code Wiki: 在线课程管理系统

## 一、项目概述

本项目是一个基于 **ASP.NET Web Forms** 开发的在线课程管理系统，采用经典的 **三层架构**（Model-BLL-DAL）设计模式。系统主要面向在线教育场景，提供课程浏览、购买、收藏、评分等核心功能。

### 1.1 技术栈

| 分类 | 技术 | 版本 |
|------|------|------|
| 框架 | ASP.NET Web Forms | .NET Framework |
| 语言 | C# | 4.0+ |
| 数据库 | SQL Server | - |
| 开发工具 | Visual Studio | 2013 |

### 1.2 项目定位

- **用户角色**：普通用户、VIP用户、管理员
- **核心能力**：课程管理、用户管理、订单管理、评论评分系统

---

## 二、项目架构

### 2.1 整体架构图

```
┌─────────────────────────────────────────────────────────────────┐
│                        Web 层 (Presentation)                    │
│   .aspx 页面 / .ascx 用户控件 / MasterPage 母版页                │
│   负责用户交互、页面渲染、Session 管理                          │
├─────────────────────────────────────────────────────────────────┤
│                        BLL 层 (Business Logic)                 │
│   业务逻辑处理、数据验证、缓存管理                              │
├─────────────────────────────────────────────────────────────────┤
│                        DAL 层 (Data Access)                    │
│   数据库操作、SQL 执行、数据映射                                │
├─────────────────────────────────────────────────────────────────┤
│                      DBUtility 层 (基础工具)                   │
│   数据库连接管理、SQL 帮助类、加密工具                          │
├─────────────────────────────────────────────────────────────────┤
│                        Model 层 (实体模型)                      │
│   数据实体定义、属性映射                                        │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        SQL Server 数据库                       │
└─────────────────────────────────────────────────────────────────┘
```

### 2.2 模块划分

| 模块 | 职责描述 | 主要文件 |
|------|----------|----------|
| **Web** | 前端页面展示、用户交互、Session管理 | Login.aspx, Default.aspx, UserCenter.aspx |
| **BLL** | 业务逻辑处理、事务管理、缓存 | Users.cs, Course.cs, Orders.cs |
| **DAL** | 数据库CRUD操作、SQL构建 | Users.cs, Course.cs, Cart.cs |
| **DBUtility** | 数据库连接、SQL帮助类、加密 | DbHelperSQL.cs, PubConstant.cs |
| **Model** | 数据实体定义 | Users.cs, Course.cs, Orders.cs |

---

## 三、目录结构

```
Group7/                              # 项目根目录
├── Web/                              # 前端展示层
│   ├── Admin/                        # 管理员后台
│   │   ├── Courseimg/                # 课程图片
│   │   ├── images/                   # 管理后台图片
│   │   ├── teacher/                  # 讲师头像
│   │   ├── AddUsers.aspx             # 添加用户
│   │   ├── AdminDefault.aspx         # 管理首页
│   │   ├── CateList.aspx             # 分类管理
│   │   ├── CourseList.aspx           # 课程列表
│   │   ├── Course_All_Mess.aspx      # 课程详情
│   │   ├── NewCourse.aspx            # 新增课程
│   │   └── UsersList.aspx            # 用户列表
│   ├── images/                       # 前端图片资源
│   ├── Default.aspx                  # 首页/课程列表
│   ├── Home.aspx                     # 首页
│   ├── Login.aspx                    # 登录页
│   ├── Register.aspx                 # 注册页
│   ├── StudyPath.aspx                # 学习路径
│   ├── Teacher.aspx                  # 讲师页面
│   ├── UserCenter.aspx               # 用户中心
│   ├── Site2.Master                  # 用户端母版页
│   └── Web.config                    # 配置文件
├── BLL/                              # 业务逻辑层
│   ├── Users.cs                      # 用户业务
│   ├── Course.cs                     # 课程业务
│   ├── Orders.cs                     # 订单业务
│   ├── Cart.cs                       # 购物车业务
│   ├── Favorite.cs                   # 收藏业务
│   ├── Categories.cs                 # 分类业务
│   ├── CourseRatings.cs              # 评分业务
│   ├── ReaderComments.cs             # 评论业务
│   └── UserRoles.cs                  # 用户角色业务
├── DAL/                              # 数据访问层
│   ├── Users.cs                      # 用户数据访问
│   ├── Course.cs                     # 课程数据访问
│   ├── Orders.cs                     # 订单数据访问
│   ├── Cart.cs                       # 购物车数据访问
│   ├── Favorite.cs                   # 收藏数据访问
│   ├── Categories.cs                 # 分类数据访问
│   ├── CourseRatings.cs              # 评分数据访问
│   └── ReaderComments.cs             # 评论数据访问
├── DBUtility/                        # 数据库工具层
│   ├── DbHelperSQL.cs                # SQL帮助类
│   ├── DbHelperMySQL.cs              # MySQL帮助类
│   ├── DbHelperSQLite.cs             # SQLite帮助类
│   ├── PubConstant.cs                # 常量配置
│   ├── DESEncrypt.cs                 # DES加密
│   └── CommandInfo.cs                # 命令信息
├── Model/                            # 实体模型层
│   ├── Users.cs                      # 用户实体
│   ├── Course.cs                     # 课程实体
│   ├── Orders.cs                     # 订单实体
│   ├── Cart.cs                       # 购物车实体
│   ├── Favorite.cs                   # 收藏实体
│   ├── Categories.cs                 # 分类实体
│   ├── CourseRatings.cs              # 评分实体
│   └── ReaderComments.cs             # 评论实体
├── Lib/                              # 第三方依赖库
├── Backup/                           # 备份文件
└── Group7.sln                        # 解决方案文件
```

---

## 四、核心模块详解

### 4.1 Model 层（实体模型）

#### 4.1.1 Users（用户实体）

**文件路径**: [Model/Users.cs](file:///C:/Users/Administrator/Desktop/Group58/Group7/Model/Users.cs)

| 属性名 | 类型 | 说明 |
|--------|------|------|
| Id | int | 用户ID（主键） |
| LoginId | string | 登录账号 |
| LoginPwd | string | 登录密码 |
| UserRoleld | int | 用户角色ID |
| Name | string | 用户姓名 |
| Adress | string | 地址 |
| Phone | string | 电话 |
| Mail | string | 邮箱 |
| Gender | int? | 性别 |
| mobile | string | 手机 |
| photo | string | 头像路径 |
| IsShow | int | 是否启用（0禁用/1启用） |

#### 4.1.2 Course（课程实体）

**文件路径**: [Model/Course.cs](file:///C:/Users/Administrator/Desktop/Group58/Group7/Model/Course.cs)

| 属性名 | 类型 | 说明 |
|--------|------|------|
| Id | int | 课程ID（主键） |
| Title | string | 课程标题 |
| Author | string | 作者/讲师 |
| CategoryId | int | 分类ID |
| Clicks | int? | 点击量 |
| PublishDate | DateTime? | 发布日期 |
| Duration | int? | 课时数 |
| ContentDescription | string | 课程介绍 |
| AurhorDescription | string | 讲师介绍 |
| EditorComment | string | 编辑推荐 |
| TOC | string | 课程大纲 |
| Registration | int? | 报名人数 |
| IsShow | int | 是否显示 |
| Price | decimal? | 价格 |
| StartDate | DateTime? | 开课日期 |
| beiyong | string | 备用字段（图片路径） |

#### 4.1.3 其他实体

| 实体类 | 说明 |
|--------|------|
| Orders | 订单实体 |
| Cart | 购物车实体 |
| Favorite | 收藏实体 |
| Categories | 分类实体 |
| CourseRatings | 课程评分实体 |
| ReaderComments | 用户评论实体 |
| UserRoles | 用户角色实体 |

---

### 4.2 DBUtility 层（数据库工具）

#### 4.2.1 PubConstant（常量配置）

**文件路径**: [DBUtility/PubConstant.cs](file:///C:/Users/Administrator/Desktop/Group58/Group7/DBUtility/PubConstant.cs)

**核心功能**:
- 从 `Web.config` 读取数据库连接字符串
- 支持连接字符串加密解密

**关键方法**:

| 方法名 | 返回值 | 说明 |
|--------|--------|------|
| ConnectionString | string | 获取默认连接字符串 |
| GetConnectionString(configName) | string | 获取指定配置的连接字符串 |

#### 4.2.2 DbHelperSQL（SQL帮助类）

**文件路径**: [DBUtility/DbHelperSQL.cs](file:///C:/Users/Administrator/Desktop/Group58/Group7/DBUtility/DbHelperSQL.cs)

**核心功能**:
- 封装 SQL Server 数据库操作
- 提供增删改查基础方法
- 支持事务操作

**关键方法**:

| 方法名 | 说明 |
|--------|------|
| ExecuteSql(string) | 执行SQL语句，返回影响行数 |
| ExecuteSql(string, SqlParameter[]) | 执行带参数SQL |
| GetSingle(string) | 执行查询，返回单个值 |
| Query(string) | 执行查询，返回DataSet |
| ExecuteSqlTran(List) | 执行多条SQL事务 |
| RunProcedure(string, IDataParameter[], string) | 执行存储过程 |

---

### 4.3 DAL 层（数据访问层）

#### 4.3.1 Users（用户数据访问）

**文件路径**: [DAL/Users.cs](file:///C:/Users/Administrator/Desktop/Group58/Group7/DAL/Users.cs)

**核心方法**:

| 方法名 | 说明 |
|--------|------|
| GetMaxId() | 获取最大用户ID |
| Exists(int) | 检查用户是否存在 |
| Exists(string, string) | 检查登录账号密码是否正确 |
| Add(Model.Users) | 添加用户 |
| Update(Model.Users) | 更新用户 |
| Delete(int) | 删除用户 |
| GetModel(int) | 获取用户实体 |
| GetList(string) | 按条件查询用户列表 |
| GetListByPage() | 分页查询 |

#### 4.3.2 Course（课程数据访问）

**文件路径**: [DAL/Course.cs](file:///C:/Users/Administrator/Desktop/Group58/Group7/DAL/Course.cs)

**核心方法**:

| 方法名 | 说明 |
|--------|------|
| GetMaxId() | 获取最大课程ID |
| Exists(int) | 检查课程是否存在 |
| Add(Model.Course) | 添加课程 |
| Update(Model.Course) | 更新课程 |
| Delete(int) | 删除课程 |
| GetModel(int) | 获取课程实体 |
| GetList(string) | 按条件查询课程列表 |

---

### 4.4 BLL 层（业务逻辑层）

#### 4.4.1 Users（用户业务逻辑）

**文件路径**: [BLL/Users.cs](file:///C:/Users/Administrator/Desktop/Group58/Group7/BLL/Users.cs)

**核心特点**:
- 内部持有 DAL.Users 实例
- 提供缓存机制（GetModelByCache）
- 封装基础 CRUD 操作

**关键方法**:

| 方法名 | 说明 |
|--------|------|
| GetModelByCache(int) | 从缓存获取用户实体 |
| DataTableToList(DataTable) | DataTable转实体列表 |

#### 4.4.2 Course（课程业务逻辑）

**文件路径**: [BLL/Course.cs](file:///C:/Users/Administrator/Desktop/Group58/Group7/BLL/Course.cs)

**核心特点**:
- 与 DAL 层对应
- 提供数据转换方法

---

### 4.5 Web 层（前端展示）

#### 4.5.1 Login.aspx（登录页面）

**文件路径**: [Web/Login.aspx.cs](file:///C:/Users/Administrator/Desktop/Group58/Group7/Web/Login.aspx.cs)

**核心功能**:
- 用户登录验证
- 角色判断（管理员/普通用户/VIP）
- Session 登录状态管理

**关键流程**:
1. 获取用户名密码
2. 调用 BLL.Users.GetModelList 查询
3. 验证用户状态（IsShow）
4. 保存用户信息到 Session
5. 根据角色跳转对应页面

#### 4.5.2 Default.aspx（首页/课程详情）

**文件路径**: [Web/Default.aspx.cs](file:///C:/Users/Administrator/Desktop/Group58/Group7/Web/Default.aspx.cs)

**核心功能**:
- 课程列表展示
- 课程详情查看
- 购物车操作
- 收藏操作
- 购买操作
- 评分评论

**关键方法**:

| 方法名 | 说明 |
|--------|------|
| LoadCategories() | 加载课程分类 |
| LoadCourses(int) | 加载指定分类课程 |
| LoadCourseDetail(int) | 加载课程详情 |
| LoadComments(int, int?) | 加载课程评论 |
| btnAddCart_Click() | 加入购物车 |
| btnFavorite_Click() | 收藏/取消收藏 |
| btnPurchase_Click() | 购买课程 |

#### 4.5.3 管理员后台

**文件路径**: [Web/Admin/](file:///C:/Users/Administrator/Desktop/Group58/Group7/Web/Admin/)

| 页面 | 功能 |
|------|------|
| AdminDefault.aspx | 管理首页 |
| AddUsers.aspx | 添加用户 |
| UsersList.aspx | 用户列表管理 |
| CateList.aspx | 分类管理 |
| CourseList.aspx | 课程列表 |
| NewCourse.aspx | 新增课程 |
| Course_All_Mess.aspx | 课程详情 |

---

## 五、数据库设计

### 5.1 核心数据表

#### Users（用户表）

| 字段名 | 类型 | 约束 |
|--------|------|------|
| Id | int | PRIMARY KEY |
| LoginId | nvarchar(50) | NOT NULL |
| LoginPwd | nvarchar(50) | NOT NULL |
| UserRoleld | int | NOT NULL |
| Name | nvarchar(50) | - |
| Adress | nvarchar(200) | - |
| Phone | nvarchar(100) | - |
| Mail | nvarchar(100) | - |
| Gender | int | NULL |
| mobile | nvarchar(50) | - |
| photo | nvarchar(max) | - |
| IsShow | int | NOT NULL |

#### Course（课程表）

| 字段名 | 类型 | 约束 |
|--------|------|------|
| Id | int | PRIMARY KEY |
| Title | nvarchar(200) | NOT NULL |
| Author | nvarchar(50) | - |
| CategoryId | int | FOREIGN KEY |
| Clicks | int | NULL |
| PublishDate | datetime | NULL |
| Duration | int | NULL |
| ContentDescription | nvarchar(max) | - |
| AurhorDescription | nvarchar(max) | - |
| EditorComment | nvarchar(max) | - |
| TOC | nvarchar(max) | - |
| Registration | int | NULL |
| IsShow | int | NOT NULL |
| Price | decimal(18,2) | NULL |
| StartDate | datetime | NULL |
| beiyong | nvarchar(max) | - |

#### Orders（订单表）

| 字段名 | 类型 | 约束 |
|--------|------|------|
| Id | int | PRIMARY KEY |
| OrderDate | datetime | NOT NULL |
| UserId | int | FOREIGN KEY |
| TotalPirce | decimal(18,2) | NOT NULL |
| beiyong | nvarchar(max) | - |

#### OrderCourse（订单课程关联表）

| 字段名 | 类型 | 约束 |
|--------|------|------|
| Id | int | PRIMARY KEY |
| OrderID | int | FOREIGN KEY |
| CourseID | int | FOREIGN KEY |
| beiyong1 | nvarchar(max) | - |
| beiyong2 | nvarchar(max) | - |

#### Cart（购物车表）

| 字段名 | 类型 | 约束 |
|--------|------|------|
| Id | int | PRIMARY KEY |
| UserId | int | FOREIGN KEY |
| CourseId | int | FOREIGN KEY |

#### Favorite（收藏表）

| 字段名 | 类型 | 约束 |
|--------|------|------|
| Id | int | PRIMARY KEY |
| UserId | int | FOREIGN KEY |
| CourseId | int | FOREIGN KEY |
| AddTime | datetime | NOT NULL |

#### CourseRatings（课程评分表）

| 字段名 | 类型 | 约束 |
|--------|------|------|
| Id | int | PRIMARY KEY |
| CourseId | int | FOREIGN KEY |
| UserId | int | FOREIGN KEY |
| Rating | int | NOT NULL |
| Title | nvarchar(200) | - |
| Comment | nvarchar(max) | - |
| Date | datetime | NOT NULL |
| IsShow | int | NOT NULL |
| beiyong | nvarchar(max) | - |

#### ReaderComments（读者评论表）

| 字段名 | 类型 | 约束 |
|--------|------|------|
| Id | int | PRIMARY KEY |
| CourseId | int | FOREIGN KEY |
| UserId | int | FOREIGN KEY |
| Title | nvarchar(200) | - |
| Comment | nvarchar(max) | NOT NULL |
| Date | datetime | NOT NULL |
| IsShow | int | NOT NULL |
| beiyong | nvarchar(max) | - |

#### Categories（分类表）

| 字段名 | 类型 | 约束 |
|--------|------|------|
| Id | int | PRIMARY KEY |
| Name | nvarchar(50) | NOT NULL |
| ParentId | int | NULL |
| IsShow | int | NOT NULL |

---

## 六、依赖关系

### 6.1 项目依赖

```
Web
├── BLL        (业务逻辑)
│   ├── DAL    (数据访问)
│   │   └── DBUtility (数据库工具)
│   ├── Model  (实体模型)
│   └── Maticsoft.Common (公共工具)
└── Model      (实体模型)

BLL
├── DAL
├── Model
└── Maticsoft.Common

DAL
├── DBUtility
└── Model

DBUtility
└── (无外部依赖)

Model
└── (无外部依赖)
```

### 6.2 第三方库

| 库名 | 说明 |
|------|------|
| Maticsoft.Common.dll | 公共工具库（缓存、验证等） |
| MySql.Data.dll | MySQL 数据驱动 |
| System.Data.SQLite.dll | SQLite 数据驱动 |
| LTP.Accounts.dll | 账户管理组件 |
| Microsoft.Practices.EnterpriseLibrary.Data.dll | Enterprise Library 数据访问 |

---

## 七、配置说明

### 7.1 Web.config 关键配置

```xml
<connectionStrings>
  <add name="CourseManagementConnectionString" 
       connectionString="Data Source=606-08;Initial Catalog=CourseManagement;Persist Security Info=True;User ID=sa;Password=123" 
       providerName="System.Data.SqlClient" />
</connectionStrings>

<appSettings>
  <add key="ConStringEncrypt" value="false"/>
  <add key="ConnectionString" value="server=606-08;database=CourseManagement;uid=sa;pwd=123"/>
</appSettings>
```

**配置项说明**:
- `ConStringEncrypt`: 是否加密连接字符串（true/false）
- `ConnectionString`: 数据库连接字符串
- `ConnectionString2`: 备用连接字符串（多数据库支持）

---

## 八、运行方式

### 8.1 环境要求

| 要求 | 说明 |
|------|------|
| 操作系统 | Windows Server / Windows 10+ |
| IIS | 7.0+ |
| .NET Framework | 4.0+ |
| SQL Server | 2008+ |

### 8.2 部署步骤

1. **数据库部署**
   - 创建数据库 `CourseManagement`
   - 执行数据库脚本（如有）创建表结构

2. **配置连接字符串**
   - 修改 `Web/Web.config` 中的数据库连接信息

3. **IIS 配置**
   - 创建新网站，指向 Web 目录
   - 设置应用程序池为 .NET Framework 4.0

4. **运行项目**
   - 启动 IIS 网站
   - 访问首页地址（如 http://localhost/）

### 8.3 开发调试

1. **打开解决方案**
   - 使用 Visual Studio 2013 打开 `Group7.sln`

2. **设置启动项目**
   - 设置 Web 项目为启动项目

3. **配置调试环境**
   - 确保数据库连接正确
   - 设置断点进行调试

4. **运行调试**
   - 按 F5 启动调试

---

## 九、安全注意事项

### 9.1 SQL 注入防护

当前代码存在 **SQL 注入风险**，以下代码需要修复：

**问题代码**（Login.aspx.cs）:
```csharp
List<Model.Users> loginUserlist = UsersBLL.GetModelList("LoginId='" + TextBox1.Text + "' and LoginPwd='" + TextBox2.Text + "'");
```

**修复建议**:
- 使用参数化查询
- 使用 ORM 框架（如 Entity Framework）
- 对用户输入进行严格验证和过滤

### 9.2 密码安全

- 当前密码以明文存储，存在安全风险
- 建议使用 BCrypt/SHA256 等算法加密存储

### 9.3 Session 管理

- Session 超时时间配置
- Session 安全传输（HTTPS）

---

## 十、扩展建议

### 10.1 架构优化

1. **引入 ORM 框架**：替换手写 SQL，使用 Entity Framework
2. **分层架构升级**：引入 Repository 模式
3. **前端技术升级**：使用 ASP.NET MVC 或现代前端框架

### 10.2 功能扩展

1. **支付集成**：接入支付宝、微信支付
2. **视频播放**：集成视频播放功能
3. **学习进度跟踪**：记录用户学习进度
4. **通知系统**：课程更新、活动通知

### 10.3 性能优化

1. **缓存策略**：使用 Redis 分布式缓存
2. **数据库优化**：添加索引、读写分离
3. **静态资源优化**：CDN 加速、资源压缩

---

## 附录：用户角色说明

| 角色ID | 角色名称 | 说明 |
|--------|----------|------|
| 1 | 普通用户 | 可浏览课程、购买课程、评论评分 |
| 2 | VIP用户 | 享受VIP价格、优先服务 |
| 5 | 管理员 | 管理用户、课程、订单等 |

---

**文档版本**: v1.0  
**生成日期**: 2026年5月  
**项目名称**: Group7 在线课程管理系统
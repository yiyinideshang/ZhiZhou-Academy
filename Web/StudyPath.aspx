<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudyPath.aspx.cs" Inherits="Maticsoft.Web.StudyPath" MasterPageFile="~/Site2.Master" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMainContent" runat="server">
    <style>
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .page-title {
            font-size: 32px;
            text-align: center;
            margin-bottom: 12px;
            color: #1677ff;
        }

        .page-desc {
            text-align: center;
            color: #666;
            margin-bottom: 50px;
            font-size: 16px;
        }

        .path-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(550px, 1fr));
            gap: 24px;
            margin-bottom: 50px;
        }

        .path-card {
            background: #fff;
            border-radius: 16px;
            padding: 28px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, .06);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
            position: relative;
        }

        .path-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 32px rgba(0, 0, 0, .1);
        }

        .path-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #1677ff, #69b1ff);
        }

        .path-header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 20px;
        }

        .path-icon {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, #e6f7ff, #bae7ff);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            flex-shrink: 0;
        }

        .path-info {
            flex: 1;
        }

        .path-name {
            font-size: 22px;
            font-weight: 600;
            color: #1677ff;
            margin-bottom: 4px;
        }

        .path-job {
            color: #666;
            font-size: 14px;
        }

        .stage-list {
            border-left: 2px solid #e5e6eb;
            padding-left: 20px;
            margin-left: 8px;
        }

        .stage {
            position: relative;
            margin-bottom: 18px;
        }

        .stage::before {
            content: '';
            position: absolute;
            left: -30px;
            top: 4px;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            background: #1677ff;
            border: 3px solid #fff;
            box-shadow: 0 0 0 2px #e6f7ff;
        }

        .stage h4 {
            font-size: 16px;
            margin-bottom: 6px;
            color: #222;
        }

        .stage p {
            color: #666;
            line-height: 1.6;
            font-size: 13px;
            margin-bottom: 6px;
        }

        .tags {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            margin-top: 4px;
        }

        .tag {
            background: #f5f7fa;
            color: #1677ff;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 12px;
            border: 1px solid #e6f7ff;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 40px;
        }

        .page-btn {
            padding: 8px 16px;
            border-radius: 8px;
            background: #fff;
            border: 1px solid #e5e6eb;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .page-btn.active {
            background: #1677ff;
            color: #fff;
            border-color: #1677ff;
        }

        .page-btn:hover:not(.active) {
            border-color: #1677ff;
            color: #1677ff;
        }

        .page-btn:disabled {
            opacity: 0.4;
            cursor: not-allowed;
        }

        @media (max-width: 1200px) {
            .path-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="container">
        <h1 class="page-title">📚 IT全品类学习路径</h1>
        <p class="page-desc">从零基础到就业，按企业真实需求规划，学完即可上岗</p>

        <div class="path-grid" id="pathGrid">
            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">☕</div>
                    <div class="path-info">
                        <div class="path-name">Java开发</div>
                        <div class="path-job">适合岗位：Java后端、微服务开发、架构师</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：Java基础与编程思维</h4>
                        <p>掌握Java语法、面向对象、集合、IO流、多线程，培养编程逻辑</p>
                        <div class="tags"><span class="tag">Java基础</span><span class="tag">面向对象</span><span class="tag">集合框架</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：数据库与Web基础</h4>
                        <p>MySQL数据库、SQL语句、JDBC、Servlet、Tomcat、HTTP协议</p>
                        <div class="tags"><span class="tag">MySQL</span><span class="tag">JDBC</span><span class="tag">Servlet</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：主流框架与SpringBoot</h4>
                        <p>Spring、SpringMVC、MyBatis（SSM）、SpringBoot快速开发</p>
                        <div class="tags"><span class="tag">Spring</span><span class="tag">MyBatis</span><span class="tag">SpringBoot</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：微服务与分布式实战</h4>
                        <p>SpringCloud、Nacos、Redis、MQ、高并发项目实战</p>
                        <div class="tags"><span class="tag">微服务</span><span class="tag">Redis</span><span class="tag">分布式</span></div>
                    </div>
                </div>
            </div>

            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">🐍</div>
                    <div class="path-info">
                        <div class="path-name">Python开发</div>
                        <div class="path-job">适合岗位：数据分析、AI开发、自动化、爬虫</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：Python核心语法</h4>
                        <p>基础语法、函数、面向对象、文件操作、并发编程</p>
                        <div class="tags"><span class="tag">Python基础</span><span class="tag">面向对象</span><span class="tag">并发</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：数据处理与爬虫</h4>
                        <p>Requests、Scrapy爬虫、Pandas、Numpy数据分析</p>
                        <div class="tags"><span class="tag">爬虫</span><span class="tag">Pandas</span><span class="tag">数据分析</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：机器学习与AI</h4>
                        <p>Sklearn经典算法、深度学习、Pytorch/TensorFlow</p>
                        <div class="tags"><span class="tag">机器学习</span><span class="tag">深度学习</span><span class="tag">AI</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：项目实战与就业</h4>
                        <p>数据分析项目、AI项目、自动化脚本、简历面试</p>
                        <div class="tags"><span class="tag">项目实战</span><span class="tag">就业</span></div>
                    </div>
                </div>
            </div>

            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">🌐</div>
                    <div class="path-info">
                        <div class="path-name">Web前端开发</div>
                        <div class="path-job">适合岗位：前端开发、小程序、H5、全栈</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：网页三剑客</h4>
                        <p>HTML5结构、CSS3样式、Flex/Grid布局、响应式设计</p>
                        <div class="tags"><span class="tag">HTML5</span><span class="tag">CSS3</span><span class="tag">响应式</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：JavaScript核心</h4>
                        <p>原生JS、DOM操作、Ajax、ES6+、异步编程、Promise</p>
                        <div class="tags"><span class="tag">JS</span><span class="tag">ES6+</span><span class="tag">Ajax</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：主流框架与工程化</h4>
                        <p>Vue3、React、Vite/Webpack、状态管理、工程化</p>
                        <div class="tags"><span class="tag">Vue3</span><span class="tag">React</span><span class="tag">工程化</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：跨端与全栈</h4>
                        <p>小程序、Uniapp、Node.js、全栈项目开发</p>
                        <div class="tags"><span class="tag">小程序</span><span class="tag">Node.js</span><span class="tag">全栈</span></div>
                    </div>
                </div>
            </div>

            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">⚙️</div>
                    <div class="path-info">
                        <div class="path-name">C++开发</div>
                        <div class="path-job">适合岗位：嵌入式、游戏开发、底层开发、高性能</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：C++基础语法</h4>
                        <p>C语言基础、C++面向对象、模板、STL标准库</p>
                        <div class="tags"><span class="tag">C++基础</span><span class="tag">STL</span><span class="tag">模板</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：数据结构与算法</h4>
                        <p>链表、树、图、排序、查找、动态规划、算法刷题</p>
                        <div class="tags"><span class="tag">数据结构</span><span class="tag">算法</span><span class="tag">LeetCode</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：系统编程与网络</h4>
                        <p>Linux系统编程、多线程、网络编程、Socket</p>
                        <div class="tags"><span class="tag">Linux</span><span class="tag">网络编程</span><span class="tag">多线程</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：方向进阶与项目</h4>
                        <p>嵌入式开发、游戏开发、高性能服务器、音视频开发</p>
                        <div class="tags"><span class="tag">嵌入式</span><span class="tag">游戏开发</span><span class="tag">高性能</span></div>
                    </div>
                </div>
            </div>

            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">🗄️</div>
                    <div class="path-info">
                        <div class="path-name">数据库开发</div>
                        <div class="path-job">适合岗位：DBA、数据库开发、数据运维</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：关系型数据库基础</h4>
                        <p>MySQL、SQL语句、事务、索引、存储过程、触发器</p>
                        <div class="tags"><span class="tag">MySQL</span><span class="tag">SQL</span><span class="tag">事务</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：数据库优化与运维</h4>
                        <p>性能调优、主从复制、备份恢复、高可用架构</p>
                        <div class="tags"><span class="tag">调优</span><span class="tag">高可用</span><span class="tag">运维</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：非关系型数据库</h4>
                        <p>Redis、MongoDB、Elasticsearch、缓存技术</p>
                        <div class="tags"><span class="tag">Redis</span><span class="tag">MongoDB</span><span class="tag">ES</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：大数据与数据仓库</h4>
                        <p>Hive、ClickHouse、数据仓库、ETL、数据治理</p>
                        <div class="tags"><span class="tag">数据仓库</span><span class="tag">ETL</span><span class="tag">大数据</span></div>
                    </div>
                </div>
            </div>

            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">📊</div>
                    <div class="path-info">
                        <div class="path-name">大数据开发</div>
                        <div class="path-job">适合岗位：大数据工程师、数仓开发、数据分析师</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：大数据基础与Linux</h4>
                        <p>Linux基础、Shell脚本、Hadoop生态、HDFS、MapReduce</p>
                        <div class="tags"><span class="tag">Linux</span><span class="tag">Hadoop</span><span class="tag">HDFS</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：大数据组件与数仓</h4>
                        <p>Hive、Spark、Flink、Kafka、数据仓库建模</p>
                        <div class="tags"><span class="tag">Spark</span><span class="tag">Flink</span><span class="tag">Kafka</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：实时计算与流处理</h4>
                        <p>Flink实时计算、流处理、实时数仓、数据同步</p>
                        <div class="tags"><span class="tag">Flink</span><span class="tag">实时计算</span><span class="tag">流处理</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：项目实战与就业</h4>
                        <p>离线/实时数仓项目、用户画像、推荐系统、面试</p>
                        <div class="tags"><span class="tag">项目实战</span><span class="tag">推荐系统</span><span class="tag">就业</span></div>
                    </div>
                </div>
            </div>

            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">🤖</div>
                    <div class="path-info">
                        <div class="path-name">AI课程</div>
                        <div class="path-job">适合岗位：AI算法工程师、大模型开发、AI应用</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：AI数学基础</h4>
                        <p>线性代数、概率论、微积分、统计学基础</p>
                        <div class="tags"><span class="tag">数学</span><span class="tag">概率论</span><span class="tag">线性代数</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：机器学习基础</h4>
                        <p>Sklearn、经典算法、特征工程、模型训练与评估</p>
                        <div class="tags"><span class="tag">机器学习</span><span class="tag">Sklearn</span><span class="tag">特征工程</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：深度学习与大模型</h4>
                        <p>神经网络、CNN、RNN、Transformer、大模型微调</p>
                        <div class="tags"><span class="tag">深度学习</span><span class="tag">Transformer</span><span class="tag">大模型</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：AI项目实战</h4>
                        <p>计算机视觉、NLP、大模型应用开发、AIGC</p>
                        <div class="tags"><span class="tag">CV</span><span class="tag">NLP</span><span class="tag">AIGC</span></div>
                    </div>
                </div>
            </div>

            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">✅</div>
                    <div class="path-info">
                        <div class="path-name">软件测试</div>
                        <div class="path-job">适合岗位：功能测试、自动化测试、测试开发</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：测试理论与流程</h4>
                        <p>软件生命周期、测试用例设计、缺陷管理、测试计划</p>
                        <div class="tags"><span class="tag">测试理论</span><span class="tag">用例设计</span><span class="tag">缺陷管理</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：功能与接口测试</h4>
                        <p>Web/App功能测试、Postman接口测试、JMeter压测</p>
                        <div class="tags"><span class="tag">功能测试</span><span class="tag">接口测试</span><span class="tag">JMeter</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：自动化测试</h4>
                        <p>Selenium、Appium、Pytest、UI/接口自动化框架</p>
                        <div class="tags"><span class="tag">Selenium</span><span class="tag">Pytest</span><span class="tag">自动化</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：测试开发与性能测试</h4>
                        <p>测试平台开发、性能测试、安全测试、测试左移</p>
                        <div class="tags"><span class="tag">测试开发</span><span class="tag">性能测试</span><span class="tag">安全测试</span></div>
                    </div>
                </div>
            </div>

            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">💡</div>
                    <div class="path-info">
                        <div class="path-name">软技能提升</div>
                        <div class="path-job">适合岗位：所有IT岗位、职场晋升</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：职场基础技能</h4>
                        <p>沟通表达、时间管理、项目协作、办公效率提升</p>
                        <div class="tags"><span class="tag">沟通</span><span class="tag">时间管理</span><span class="tag">办公</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：技术写作与文档</h4>
                        <p>技术文档编写、需求分析、产品思维、PPT/报告</p>
                        <div class="tags"><span class="tag">文档</span><span class="tag">需求分析</span><span class="tag">产品思维</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：面试与求职</h4>
                        <p>简历优化、面试技巧、谈薪、职业规划</p>
                        <div class="tags"><span class="tag">简历</span><span class="tag">面试</span><span class="tag">职业规划</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：领导力与管理</h4>
                        <p>团队管理、技术管理、项目管理、职场晋升</p>
                        <div class="tags"><span class="tag">管理</span><span class="tag">领导力</span><span class="tag">项目管理</span></div>
                    </div>
                </div>
            </div>

            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">🏢</div>
                    <div class="path-info">
                        <div class="path-name">企业内训课程</div>
                        <div class="path-job">适合对象：企业员工、技术团队、管理层</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：企业技术体系搭建</h4>
                        <p>技术栈选型、架构规范、代码规范、DevOps流程</p>
                        <div class="tags"><span class="tag">架构</span><span class="tag">规范</span><span class="tag">DevOps</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：团队技能提升</h4>
                        <p>新技术培训、代码评审、性能优化、安全培训</p>
                        <div class="tags"><span class="tag">培训</span><span class="tag">性能优化</span><span class="tag">安全</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：项目管理与协作</h4>
                        <p>敏捷开发、Scrum、项目管控、跨团队协作</p>
                        <div class="tags"><span class="tag">敏捷</span><span class="tag">Scrum</span><span class="tag">项目管理</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：数字化转型</h4>
                        <p>企业数字化、上云、低代码、AI赋能业务</p>
                        <div class="tags"><span class="tag">数字化</span><span class="tag">上云</span><span class="tag">AI赋能</span></div>
                    </div>
                </div>
            </div>

            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">🎓</div>
                    <div class="path-info">
                        <div class="path-name">计算机考研</div>
                        <div class="path-job">适合对象：计算机/软工考研、提升学历</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：公共课备考</h4>
                        <p>数学一/二、英语一/二、政治系统复习</p>
                        <div class="tags"><span class="tag">数学</span><span class="tag">英语</span><span class="tag">政治</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：专业课408</h4>
                        <p>数据结构、计算机组成原理、操作系统、计算机网络</p>
                        <div class="tags"><span class="tag">数据结构</span><span class="tag">组成原理</span><span class="tag">408</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：刷题与强化</h4>
                        <p>历年真题、模拟题、算法刷题、知识点强化</p>
                        <div class="tags"><span class="tag">真题</span><span class="tag">刷题</span><span class="tag">强化</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：复试与调剂</h4>
                        <p>复试专业课、机试、面试、调剂技巧</p>
                        <div class="tags"><span class="tag">复试</span><span class="tag">机试</span><span class="tag">调剂</span></div>
                    </div>
                </div>
            </div>

            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">📜</div>
                    <div class="path-info">
                        <div class="path-name">软考认证</div>
                        <div class="path-job">适合对象：职称评定、落户、项目招投标</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：软考基础与科目选择</h4>
                        <p>软考政策、科目选择（中级/高级）、考试大纲</p>
                        <div class="tags"><span class="tag">政策</span><span class="tag">科目</span><span class="tag">大纲</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：基础知识系统学习</h4>
                        <p>计算机基础、网络、数据库、软件工程、项目管理</p>
                        <div class="tags"><span class="tag">软件工程</span><span class="tag">项目管理</span><span class="tag">网络</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：案例分析与论文</h4>
                        <p>案例题答题技巧、论文写作、历年真题</p>
                        <div class="tags"><span class="tag">案例</span><span class="tag">论文</span><span class="tag">真题</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：冲刺与备考</h4>
                        <p>模拟题、押题、考前冲刺、证书领取</p>
                        <div class="tags"><span class="tag">冲刺</span><span class="tag">模拟</span><span class="tag">证书</span></div>
                    </div>
                </div>
            </div>

            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">📝</div>
                    <div class="path-info">
                        <div class="path-name">AI论文写作</div>
                        <div class="path-job">适合对象：研究生、科研人员、AI研究者</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：AI论文基础</h4>
                        <p>论文结构、学术规范、文献检索、阅读方法</p>
                        <div class="tags"><span class="tag">论文结构</span><span class="tag">文献</span><span class="tag">学术规范</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：AI前沿方向</h4>
                        <p>大模型、多模态、AIGC、计算机视觉、NLP前沿</p>
                        <div class="tags"><span class="tag">大模型</span><span class="tag">多模态</span><span class="tag">AIGC</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：实验与写作</h4>
                        <p>实验设计、结果分析、论文写作、LaTeX排版</p>
                        <div class="tags"><span class="tag">实验</span><span class="tag">写作</span><span class="tag">LaTeX</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：投稿与发表</h4>
                        <p>期刊选择、投稿流程、返修技巧、学术诚信</p>
                        <div class="tags"><span class="tag">投稿</span><span class="tag">返修</span><span class="tag">发表</span></div>
                    </div>
                </div>
            </div>

            <div class="path-card">
                <div class="path-header">
                    <div class="path-icon">🚀</div>
                    <div class="path-info">
                        <div class="path-name">全栈开发</div>
                        <div class="path-job">适合岗位：全栈工程师、独立开发者、创业</div>
                    </div>
                </div>
                <div class="stage-list">
                    <div class="stage">
                        <h4>阶段1：前端技术栈</h4>
                        <p>HTML/CSS/JS、Vue/React、工程化、跨端</p>
                        <div class="tags"><span class="tag">前端</span><span class="tag">Vue</span><span class="tag">React</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段2：后端技术栈</h4>
                        <p>Java/SpringBoot、Node.js、数据库、接口设计</p>
                        <div class="tags"><span class="tag">后端</span><span class="tag">SpringBoot</span><span class="tag">Node.js</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段3：DevOps与部署</h4>
                        <p>Docker、K8s、CI/CD、云服务器、项目上线</p>
                        <div class="tags"><span class="tag">Docker</span><span class="tag">K8s</span><span class="tag">CI/CD</span></div>
                    </div>
                    <div class="stage">
                        <h4>阶段4：全栈项目实战</h4>
                        <p>从零到一搭建项目、前后端联调、上线运维</p>
                        <div class="tags"><span class="tag">项目实战</span><span class="tag">联调</span><span class="tag">上线</span></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="pagination">
            <button type="button" class="page-btn" onclick="prevPage()">上一页</button>
            <div id="pageNumbers"></div>
            <button type="button" class="page-btn" onclick="nextPage()">下一页</button>
        </div>
    </div>

    <script type="text/javascript">
        const pageSize = 4;
        let currentPage = 1;
        const cards = document.querySelectorAll('.path-card');
        const totalPages = Math.ceil(cards.length / pageSize);

        function renderPage() {
            cards.forEach((card, index) => {
                const start = (currentPage - 1) * pageSize;
                const end = currentPage * pageSize;
                card.style.display = (index >= start && index < end) ? 'block' : 'none';
            });

            const numEl = document.getElementById('pageNumbers');
            numEl.innerHTML = '';
            for (let i = 1; i <= totalPages; i++) {
                const b = document.createElement('button');
                b.type = 'button';
                b.className = 'page-btn ' + (i === currentPage ? 'active' : '');
                b.innerText = i;
                b.onclick = () => {
                    currentPage = i;
                    renderPage();
                };
                numEl.appendChild(b);
            }
        }

        function prevPage() {
            if (currentPage > 1) {
                currentPage--;
                renderPage();
            }
        }

        function nextPage() {
            if (currentPage < totalPages) {
                currentPage++;
                renderPage();
            }
        }

        renderPage();

        function searchCourses() {
            const keyword = document.getElementById('searchInput').value.trim().toLowerCase();
            cards.forEach(card => {
                const name = card.querySelector('.path-name').textContent.toLowerCase();
                const desc = card.textContent.toLowerCase();
                if (keyword === '' || name.includes(keyword) || desc.includes(keyword)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>
</asp:Content>

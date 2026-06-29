<%@ Page Title="知舟课堂 - 让学习更有价值" Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Maticsoft.Web.Home1" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="images/favicon.png" type="image/png" sizes="32x32" />
    <title>知舟课堂 - 让学习更有价值</title>
    <link rel="stylesheet" href="lib/APlayer.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Microsoft YaHei", sans-serif;
        }
        body {
            line-height: 1.6;
            color: #333;
            background: #f7f8fa;
        }
        nav {
            background: #2c3e50;
            color: white;
            padding: 1rem 2rem;
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 999;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #fff;
        }
        .nav-links a {
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            margin-left: 2rem;
            transition: color 0.3s;
        }
        .nav-links a:hover {
            color: #3498db;
        }
        .banner {
            height: 100vh;
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            padding: 0 1rem;
            margin-top: 60px;
        }
        .banner-content h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            letter-spacing: 2px;
        }
        .banner-content p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            max-width: 700px;
            opacity: 0.9;
        }
        .btn {
            display: inline-block;
            padding: 12px 30px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1rem;
            transition: 0.3s;
            border: none;
            cursor: pointer;
        }
        .btn:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.4);
        }
        .btn-outline {
            background: transparent;
            border: 2px solid #3498db;
            color: #3498db;
            margin-left: 1rem;
        }
        .btn-outline:hover {
            background: #3498db;
            color: white;
        }
        .container {
            max-width: 1200px;
            margin: 4rem auto;
            padding: 0 2rem;
        }
        .section-title {
            text-align: center;
            font-size: 2rem;
            margin-bottom: 3rem;
            color: #2c3e50;
            position: relative;
        }
        .section-title::after {
            content: '';
            display: block;
            width: 60px;
            height: 3px;
            background: #3498db;
            margin: 10px auto 0;
            border-radius: 2px;
        }
        .section-subtitle {
            text-align: center;
            color: #666;
            margin-top: -2rem;
            margin-bottom: 3rem;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }
        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }
        .card {
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }
        .card h3 {
            margin: 1rem 0;
            color: #2c3e50;
        }
        .card p {
            color: #666;
            font-size: 0.95rem;
        }
        .card-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #3498db, #2980b9);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            color: white;
            font-size: 1.5rem;
        }

        /* 核心优势区块 */
        .advantages {
            background: #fff;
            padding: 4rem 0;
        }
        .advantage-item {
            text-align: left;
            padding: 2rem;
        }
        .advantage-item .card-icon {
            margin: 0 0 1.5rem 0;
        }

        /* 热门课程区块 */
        .courses {
            padding: 4rem 0;
        }
        .course-card {
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }
        .course-img {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }
        .course-content {
            padding: 1.5rem;
        }
        .course-tag {
            display: inline-block;
            background: #e8f4fd;
            color: #3498db;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            margin-bottom: 0.5rem;
        }
        .course-title {
            font-size: 1.1rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
            color: #2c3e50;
        }
        .course-desc {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            line-height: 1.5;
        }
        .course-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.85rem;
            color: #888;
        }
        .course-price {
            color: #e74c3c;
            font-weight: bold;
            font-size: 1.1rem;
        }

        /* 学习流程区块 */
        .process {
            background: #fff;
            padding: 4rem 0;
        }
        .process-steps {
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            margin-top: 4rem;
        }
        .process-steps::before {
            content: '';
            position: absolute;
            top: 50px;
            left: 10%;
            right: 10%;
            height: 2px;
            background: #e0e0e0;
            z-index: 1;
        }
        .step {
            text-align: center;
            position: relative;
            z-index: 2;
            flex: 1;
            padding: 0 1rem;
        }
        .step-number {
            width: 100px;
            height: 100px;
            background: #f7f8fa;
            border: 2px solid #e0e0e0;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2rem;
            font-weight: bold;
            color: #3498db;
            transition: all 0.3s;
        }
        .step:hover .step-number {
            background: #3498db;
            color: white;
            border-color: #3498db;
        }
        .step h3 {
            margin-bottom: 0.5rem;
            color: #2c3e50;
        }
        .step p {
            color: #666;
            font-size: 0.9rem;
        }

        /* 学员评价区块 */
        .testimonials {
            padding: 4rem 0;
        }
        .testimonial-card {
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: relative;
        }
        .testimonial-card::before {
            content: '"';
            font-size: 4rem;
            color: #3498db;
            opacity: 0.2;
            position: absolute;
            top: 10px;
            left: 20px;
            font-family: serif;
        }
        .testimonial-text {
            margin-bottom: 1.5rem;
            color: #555;
            line-height: 1.8;
            font-style: italic;
        }
        .testimonial-author {
            display: flex;
            align-items: center;
        }
        .author-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 1rem;
        }
        .author-info h4 {
            color: #2c3e50;
            margin-bottom: 2px;
        }
        .author-info p {
            color: #888;
            font-size: 0.85rem;
        }

        /* 平台数据区块 */
        .stats {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: white;
            padding: 4rem 0;
            text-align: center;
        }
        .stats .section-title {
            color: white;
        }
        .stats .section-title::after {
            background: white;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }
        .stat-item h3 {
            font-size: 3rem;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        .stat-item p {
            opacity: 0.9;
            font-size: 1.1rem;
        }

        /* 常见问题区块 */
        .faq {
            background: #fff;
            padding: 4rem 0;
        }
        .faq-item {
            margin-bottom: 1rem;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
        }
        .faq-question {
            background: #f7f8fa;
            padding: 1rem 1.5rem;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: bold;
            color: #2c3e50;
            transition: background 0.3s;
        }
        .faq-question:hover {
            background: #e8f4fd;
        }
        .faq-question::after {
            content: '+';
            font-size: 1.5rem;
            color: #3498db;
            transition: transform 0.3s;
        }
        .faq-question.active::after {
            transform: rotate(45deg);
        }
        .faq-answer {
            padding: 0 1.5rem;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease, padding 0.3s ease;
        }
        .faq-answer.active {
            padding: 1rem 1.5rem;
            max-height: 500px;
        }
        .faq-answer p {
            color: #666;
            line-height: 1.6;
        }

        /* Footer 样式 */
        .footer-zhipu {
            background: #2c3e50;
            color: #ccc;
            padding: 40px 20px 20px;
            font-size: 18px;
        }
        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .footer-main {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 40px;
            padding-bottom: 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .footer-brand {
            flex-shrink: 0;
        }
        .footer-brand-name {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        .footer-brand-name span {
            font-size: 18px;
            font-weight: bold;
            color: #fff;
        }
        .footer-slogan {
            color: #8899a6;
            font-size: 15px;
            margin-bottom: 20px;
        }
        /* 微信咨询区块 */
        .wechat-footer {
            margin-top: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .wechat-footer .wechat-icon-wrapper {
            background: transparent;
            padding: 0;
            display: inline-flex;
            align-items: center;
            cursor: pointer;
            position: relative;
        }
        .wechat-footer .wechat-icon-wrapper svg {
            width: 22.4px;
            height: 22.4px;
            fill: #b0b3b8;
            transition: fill 0.2s;
        }
        .wechat-footer .wechat-icon-wrapper:hover svg {
            fill: #07C160;
        }
        .wechat-footer span {
            font-size: 15px;
            color: #8899a6;
            cursor: pointer;
        }
        /* 二维码浮层 */
        .qr-hover-container {
            position: relative;
            display: inline-flex;
            align-items: center;
            cursor: pointer;
        }
        .qr-hover {
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%);
            margin-bottom: 12px;
            background: #fff;
            padding: 8px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.2s, visibility 0.2s;
            z-index: 1000;
            pointer-events: none;
            white-space: nowrap;
        }
        .qr-hover img {
            width: 120px;
            height: 120px;
            display: block;
            border-radius: 4px;
        }
        .qr-hover::after {
            content: '';
            position: absolute;
            top: 100%;
            left: 50%;
            transform: translateX(-50%);
            border-width: 6px;
            border-style: solid;
            border-color: #fff transparent transparent transparent;
        }
        .qr-hover-container:hover .qr-hover {
            opacity: 1;
            visibility: visible;
        }

        .footer-nav {
            display: flex;
            gap: 40px;
        }
        .footer-nav-group h4 {
            color: #fff;
            font-size: 15px;
            margin-bottom: 15px;
        }
        .footer-nav-group a {
            display: block;
            color: #8899a6;
            text-decoration: none;
            margin-bottom: 10px;
            font-size: 15px;
            transition: color 0.2s;
        }
        .footer-nav-group a:hover {
            color: #3498db;
        }
        .footer-contact {
            text-align: right;
        }
        .contact-line {
            display: flex;
            gap: 20px;
            justify-content: flex-end;
            margin-bottom: 15px;
            color: #8899a6;
            font-size: 15px;
            flex-wrap: wrap;
        }
        .qr-codes {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            flex-wrap: wrap;
        }
        .qr-item {
            text-align: center;
        }
        .qr-item img {
            width: 80px;
            height: 80px;
            border-radius: 4px;
            background: #fff;
            padding: 2px;
            object-fit: contain;
        }
        .qr-item span {
            display: block;
            margin-top: 5px;
            font-size: 15px;
            color: #8899a6;
        }

        .footer-bottom {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            padding-top: 20px;
            font-size: 14px;
            color: #667788;
        }
        .footer-copyright {
            font-size: 14px;
        }
        .footer-copyright1 {
            font-size: 16px;
        }
        .footer-copyright a {
            color: #667788;
            text-decoration: none;
        }
        .footer-copyright a:hover {
            color: #fff;
        }
        .footer-friend-links {
            text-align: right;
        }
        .footer-friend-links a {
            display: block;
            color: #667788;
            text-decoration: none;
            margin-bottom: 5px;
        }
        .footer-friend-links a:hover {
            color: #fff;
        }

        /* 返回顶部按钮样式 */
        .back-to-top {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            border: none;
            border-radius: 50%;
            font-size: 1.5rem;
            cursor: pointer;
            z-index: 1000;
            display: none;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.4);
            transition: all 0.3s;
        }
        .back-to-top:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 16px rgba(52, 152, 219, 0.5);
        }
        .back-to-top.show {
            display: flex;
        }
        /* 播放器样式微调 */
        .aplayer.aplayer-fixed {
            left: 20px;
            bottom: 20px;
            right: auto;
            z-index: 999;
        }

        /* 响应式优化 */
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            .banner-content h1 {
                font-size: 2rem;
            }
            .banner-content p {
                font-size: 1rem;
            }
            .btn-outline {
                margin-left: 0;
                margin-top: 1rem;
                display: block;
            }
            .process-steps {
                flex-direction: column;
                gap: 3rem;
            }
            .process-steps::before {
                display: none;
            }
            .footer-main {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }
            .footer-nav {
                flex-direction: column;
                gap: 20px;
            }
            .footer-contact {
                text-align: center;
            }
            .contact-line {
                flex-direction: column;
                align-items: center;
                gap: 5px;
            }
            .qr-codes {
                justify-content: center;
            }
            .footer-bottom {
                flex-direction: column;
                align-items: center;
                text-align: center;
                gap: 10px;
            }
            .footer-friend-links {
                text-align: center;
            }
            .qr-hover img {
                width: 100px;
                height: 100px;
            }
            .wechat-footer {
                justify-content: center;
            }
            .stat-item h3 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <nav>
        <div class="nav-container">
            <div class="logo">知舟课堂</div>
            <div class="nav-links">
                <a href="Default.aspx" target="_blank">首页</a>
                <a href="#" target="_blank">关于我们</a>
                <a href="StudyPath.aspx" target="_blank">学习路径</a>
                <a href="Teacher.aspx" target="_blank">名师大咖</a>
            </div>
        </div>
    </nav>

    <section class="banner">
        <div class="banner-content">
            <h1>知舟课堂</h1>
            <p>一站式IT职业技能学习平台，从零基础到就业，一线大厂讲师全程陪伴</p>
            <a href="Default.aspx" class="btn" target="_blank">开始学习</a>
        </div>
    </section>

    <div class="container">
        <h2 class="section-title">我们的服务</h2>
        <div class="cards">
            <div class="card">
                <div class="card-icon">📚</div>
                <h3>体系化课程</h3>
                <p>提供系统化的IT职业技能课程，覆盖全栈开发、AI、数据分析等热门方向</p>
            </div>
            <div class="card">
                <div class="card-icon">👨‍🏫</div>
                <h3>名师指导</h3>
                <p>一线互联网大厂资深工程师亲自授课，分享真实项目实战经验</p>
            </div>
            <div class="card">
                <div class="card-icon">🎯</div>
                <h3>专属学习路径</h3>
                <p>智能评估基础，定制个性化学习路线，高效达成职业目标</p>
            </div>
        </div>
    </div>

    <!-- 核心优势区块 -->
    <section class="advantages">
        <div class="container">
            <h2 class="section-title">为什么选择知舟课堂</h2>
            <p class="section-subtitle">我们专注于IT职业教育，致力于帮助每一位学员实现技术梦想，获得理想的工作机会</p>
            <div class="cards">
                <div class="card advantage-item">
                    <div class="card-icon">💼</div>
                    <h3>就业导向教学</h3>
                    <p>课程内容完全对标企业真实需求，注重实战能力培养，毕业即可上手工作</p>
                </div>
                <div class="card advantage-item">
                    <div class="card-icon">🔧</div>
                    <h3>真实项目实战</h3>
                    <p>参与多个企业级真实项目开发，积累项目经验，打造个人作品集</p>
                </div>
                <div class="card advantage-item">
                    <div class="card-icon">🤝</div>
                    <h3>一对一辅导</h3>
                    <p>专属导师全程跟踪学习进度，随时解答疑问，确保学习效果</p>
                </div>
                <div class="card advantage-item">
                    <div class="card-icon">💻</div>
                    <h3>在线直播授课</h3>
                    <p>直播+录播双模式，随时随地学习，错过直播也能随时回看</p>
                </div>
                <div class="card advantage-item">
                    <div class="card-icon">📝</div>
                    <h3>完善的作业体系</h3>
                    <p>每节课都有配套作业，导师逐一批改点评，及时发现并解决问题</p>
                </div>
                <div class="card advantage-item">
                    <div class="card-icon">🎓</div>
                    <h3>就业推荐服务</h3>
                    <p>与众多知名企业合作，提供简历优化、模拟面试和就业推荐服务</p>
                </div>
            </div>
        </div>
    </section>

    <!-- 主编推荐课程区块 -->
    <section class="courses">
        <div class="container">
            <h2 class="section-title">主编推荐课程</h2>
            <p class="section-subtitle">主编精心挑选，品质保证，助你快速成长</p>
            <div class="cards">
                <asp:Repeater ID="rptHotCourses" runat="server">
                    <ItemTemplate>
                        <a href='Default.aspx?id=<%# Eval("Id") %>' target="_blank" style="text-decoration:none; color:inherit;">
                            <div class="course-card">
                                <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("Title") %>' class="course-img" onerror="this.src='Admin/images/nono.png'">
                                <div class="course-content">
                                    <span class="course-tag" style="background: #f0f9eb; color: #67c23a;">主编推荐</span>
                                    <h3 class="course-title"><%# Eval("Title") %></h3>
                                    <p class="course-desc"><%# Eval("ShortDescription") %></p>
                                    <div class="course-info">
                                        <span>⏱️ <%# Eval("Duration") %>课时</span>
                                        <span class="course-price">¥<%# Eval("Price") %></span>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

        </div>
    </section>

    <!-- 学习流程区块 -->
    <section class="process">
        <div class="container">
            <h2 class="section-title">科学的学习流程</h2>
            <p class="section-subtitle">我们精心设计了六步学习法，帮助你高效学习，快速掌握技能</p>
            <div class="process-steps">
                <div class="step">
                    <div class="step-number">1</div>
                    <h3>入学评估</h3>
                    <p>专业测评你的技术基础，制定个性化学习计划</p>
                </div>
                <div class="step">
                    <div class="step-number">2</div>
                    <h3>理论学习</h3>
                    <p>系统学习理论知识，打好坚实的技术基础</p>
                </div>
                <div class="step">
                    <div class="step-number">3</div>
                    <h3>实战练习</h3>
                    <p>大量实战练习，将理论知识转化为实际能力</p>
                </div>
                <div class="step">
                    <div class="step-number">4</div>
                    <h3>项目开发</h3>
                    <p>参与企业级项目开发，积累真实项目经验</p>
                </div>
                <div class="step">
                    <div class="step-number">5</div>
                    <h3>就业指导</h3>
                    <p>简历优化、模拟面试，全面提升求职竞争力</p>
                </div>
                <div class="step">
                    <div class="step-number">6</div>
                    <h3>成功就业</h3>
                    <p>推荐优质企业，帮助你获得理想的工作机会</p>
                </div>
            </div>
        </div>
    </section>

    <!-- 学员评价区块 -->
    <section class="testimonials">
        <div class="container">
            <h2 class="section-title">学员真实评价</h2>
            <p class="section-subtitle">听听已经成功就业的学员怎么说</p>
            <div class="cards">
                <div class="testimonial-card">
                    <p class="testimonial-text">
                        知舟课堂的课程非常系统，老师讲得也很细致。从零基础开始学习，6个月后我成功入职了一家互联网公司做Java开发。感谢老师们的耐心指导！
                    </p>
                    <div class="testimonial-author">
                        <img src="images/photo/张明.jpg" alt="学员头像" class="author-avatar">
                        <div class="author-info">
                            <h4>张明</h4>
                            <p>Java开发工程师 @ 某互联网公司</p>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <p class="testimonial-text">
                        课程内容非常贴近企业实际需求，项目实战部分让我收获很大。老师不仅教技术，还会分享很多职场经验，对我帮助特别大。
                    </p>
                    <div class="testimonial-author">
                        <img src="images/photo/李华.jpg" alt="学员头像" class="author-avatar">
                        <div class="author-info">
                            <h4>李华</h4>
                            <p>前端开发工程师 @ 某科技公司</p>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <p class="testimonial-text">
                        作为一名转行的学员，我非常担心自己学不会。但知舟课堂的老师非常有耐心，一对一辅导解决了我很多问题。现在我已经成功转行了！
                    </p>
                    <div class="testimonial-author">
                        <img src="images/photo/王芳.jpg" alt="学员头像" class="author-avatar">
                        <div class="author-info">
                            <h4>王芳</h4>
                            <p>Python开发工程师 @ 某数据公司</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 平台数据区块 -->
    <section class="stats">
        <div class="container">
            <h2 class="section-title">平台实力数据</h2>
            <div class="stats-grid">
                <div class="stat-item">
                    <h3>50000+</h3>
                    <p>累计学员</p>
                </div>
                <div class="stat-item">
                    <h3>98%</h3>
                    <p>学员就业率</p>
                </div>
                <div class="stat-item">
                    <h3>100+</h3>
                    <p>合作企业</p>
                </div>
                <div class="stat-item">
                    <h3>50+</h3>
                    <p>一线名师</p>
                </div>
            </div>
        </div>
    </section>

    <!-- 常见问题区块 -->
    <section class="faq">
        <div class="container">
            <h2 class="section-title">常见问题</h2>
            <p class="section-subtitle">解答你最关心的问题</p>
            <div class="faq-list">
                <div class="faq-item">
                    <div class="faq-question">零基础可以学习吗？</div>
                    <div class="faq-answer">
                        <p>当然可以！我们的课程都是从零基础开始设计的，循序渐进，由浅入深。即使你没有任何编程基础，也能跟上学习进度。</p>
                    </div>
                </div>
                <div class="faq-item">
                    <div class="faq-question">学习时间是怎么安排的？</div>
                    <div class="faq-answer">
                        <p>我们采用直播+录播的教学模式。直播课一般安排在晚上和周末，方便上班族学习。错过直播也可以随时观看录播视频，学习时间非常灵活。</p>
                    </div>
                </div>
                <div class="faq-item">
                    <div class="faq-question">学完能找到工作吗？</div>
                    <div class="faq-answer">
                        <p>我们的课程完全对标企业真实需求，注重实战能力培养。同时我们提供完善的就业服务，包括简历优化、模拟面试和企业推荐，目前学员就业率达到98%以上。</p>
                    </div>
                </div>
                <div class="faq-item">
                    <div class="faq-question">学习过程中遇到问题怎么办？</div>
                    <div class="faq-answer">
                        <p>我们为每位学员配备专属导师，提供一对一辅导服务。你可以随时在学习群里提问，导师会在24小时内为你解答。同时我们还有定期的答疑直播课。</p>
                    </div>
                </div>
                <div class="faq-item">
                    <div class="faq-question">可以分期付款吗？</div>
                    <div class="faq-answer">
                        <p>可以的。我们提供多种分期付款方案，支持花呗、京东白条等分期方式，最长可分12期，让你学习无压力。</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="footer-zhipu">
        <div class="footer-container">
            <div class="footer-main">
                <!-- 左侧品牌区 -->
                <div class="footer-brand">
                    <div class="footer-brand-name">
                        <span>知舟课堂</span>
                    </div>
                    <div class="footer-slogan">让学习更有价值</div>
                    <!-- 微信售前咨询 -->
                    <div class="wechat-footer">
                        <div class="qr-hover-container">
                            <div class="wechat-icon-wrapper">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="22.4" height="22.4" fill="currentColor">
                                    <path fill-rule="evenodd" d="M16.128 8.799c-3.665 0-6.627 2.536-6.627 5.664 0 .481.074.962.223 1.425-.185.018-.352.018-.518.018a9.119 9.119 0 01-2.259-.296.554.554 0 00-.481.056L4.3 16.96c-.13.075-.277-.055-.24-.184l.555-1.963c.018-.13-.019-.259-.13-.332-1.592-1.111-2.61-2.777-2.61-4.628 0-3.35 3.276-6.053 7.33-6.053 3.61 0 6.608 2.166 7.2 4.998h-.277zm-3.48-.815a.987.987 0 00-.981-.98.988.988 0 00-.981.98c0 .538.444.982.98.982a.987.987 0 00.982-.982zm-5.905.982a.987.987 0 01-.981-.982c0-.537.444-.98.98-.98.538 0 .982.443.982.98a.975.975 0 01-.981.982zm9.31.37c3.35 0 6.072 2.295 6.072 5.108 0 1.573-.833 2.962-2.13 3.906a.45.45 0 00-.184.48l.296 1.204c.037.11-.092.204-.185.148l-1.5-.814a.835.835 0 00-.518-.056 6.53 6.53 0 01-1.832.24c-3.35 0-6.072-2.294-6.072-5.108 0-2.813 2.703-5.108 6.053-5.108zm-2.998 3.61c0 .462.37.832.833.832a.83.83 0 00.833-.833.83.83 0 00-.833-.832.83.83 0 00-.833.832zm4.924.832a.83.83 0 01-.833-.833.83.83 0 01.833-.832.83.83 0 01.833.832.841.841 0 01-.833.833z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                            <div class="qr-hover">
                                <img src="images/footer/zhang.jpg" alt="微信二维码">
                            </div>
                        </div>
                        <span>售前咨询</span>
                    </div>
                </div>

                <div class="footer-nav">
                    <div class="footer-nav-group">
                        <h4>学习</h4>
                        <a href="Default.aspx" target="_blank">全部课程</a>
                        <a href="StudyPath.aspx" target="_blank">学习路径</a>
                        <a href="Teacher.aspx" target="_blank">名师大咖</a>
                    </div>
                    <div class="footer-nav-group">
                        <h4>支持</h4>
                        <a href="#">帮助中心</a>
                        <a href="#">社区交流</a>
                        <a href="Login.aspx" target="_blank">管理系统</a>
                    </div>
                </div>

                <div class="footer-contact">
                    <div class="contact-line">
                        <span>电话：15231866708</span>
                        <span>邮箱：2779271357@qq.com</span>
                        <span>地址：北京市海淀区知舟科技大厦</span>
                    </div>
                    <div class="qr-codes">
                        <!-- 三个联系方式 -->
                        <div class="qr-item">
                            <img src="images/footer/zhang.jpg" alt="联系方式1+售前咨询">
                            <span>
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="22.4" height="22.4" fill="currentColor">
                                    <path fill-rule="evenodd" d="M16.128 8.799c-3.665 0-6.627 2.536-6.627 5.664 0 .481.074.962.223 1.425-.185.018-.352.018-.518.018a9.119 9.119 0 01-2.259-.296.554.554 0 00-.481.056L4.3 16.96c-.13.075-.277-.055-.24-.184l.555-1.963c.018-.13-.019-.259-.13-.332-1.592-1.111-2.61-2.777-2.61-4.628 0-3.35 3.276-6.053 7.33-6.053 3.61 0 6.608 2.166 7.2 4.998h-.277zm-3.48-.815a.987.987 0 00-.981-.98.988.988 0 00-.981.98c0 .538.444.982.98.982a.987.987 0 00.982-.982zm-5.905.982a.987.987 0 01-.981-.982c0-.537.444-.98.98-.98.538 0 .982.443.982.98a.975.975 0 01-.981.982zm9.31.37c3.35 0 6.072 2.295 6.072 5.108 0 1.573-.833 2.962-2.13 3.906a.45.45 0 00-.184.48l.296 1.204c.037.11-.092.204-.185.148l-1.5-.814a.835.835 0 00-.518-.056 6.53 6.53 0 01-1.832.24c-3.35 0-6.072-2.294-6.072-5.108 0-2.813 2.703-5.108 6.053-5.108zm-2.998 3.61c0 .462.37.832.833.832a.83.83 0 00.833-.833.83.83 0 00-.833-.832.83.83 0 00-.833.832zm4.924.832a.83.83 0 01-.833-.833.83.83 0 01.833-.832.83.83 0 01.833.832.841.841 0 01-.833.833z" clip-rule="evenodd"/>
                                </svg>
                                联系方式1
                            </span>
                        </div>
                        <div class="qr-item">
                            <img src="images/footer/wang.jpg" alt="联系方式2">
                            <span>
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="22.4" height="22.4" fill="currentColor">
                                    <path fill-rule="evenodd" d="M16.128 8.799c-3.665 0-6.627 2.536-6.627 5.664 0 .481.074.962.223 1.425-.185.018-.352.018-.518.018a9.119 9.119 0 01-2.259-.296.554.554 0 00-.481.056L4.3 16.96c-.13.075-.277-.055-.24-.184l.555-1.963c.018-.13-.019-.259-.13-.332-1.592-1.111-2.61-2.777-2.61-4.628 0-3.35 3.276-6.053 7.33-6.053 3.61 0 6.608 2.166 7.2 4.998h-.277zm-3.48-.815a.987.987 0 00-.981-.98.988.988 0 00-.981.98c0 .538.444.982.98.982a.987.987 0 00.982-.982zm-5.905.982a.987.987 0 01-.981-.982c0-.537.444-.98.98-.98.538 0 .982.443.982.98a.975.975 0 01-.981.982zm9.31.37c3.35 0 6.072 2.295 6.072 5.108 0 1.573-.833 2.962-2.13 3.906a.45.45 0 00-.184.48l.296 1.204c.037.11-.092.204-.185.148l-1.5-.814a.835.835 0 00-.518-.056 6.53 6.53 0 01-1.832.24c-3.35 0-6.072-2.294-6.072-5.108 0-2.813 2.703-5.108 6.053-5.108zm-2.998 3.61c0 .462.37.832.833.832a.83.83 0 00.833-.833.83.83 0 00-.833-.832.83.83 0 00-.833.832zm4.924.832a.83.83 0 01-.833-.833.83.83 0 01.833-.832.83.83 0 01.833.832.841.841 0 01-.833.833z" clip-rule="evenodd"/>
                                </svg>
                                联系方式2
                            </span>
                        </div>
                        <div class="qr-item">
                            <img src="images/footer/jin.jpg" alt="联系方式3">
                            <span>
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="22.4" height="22.4" fill="currentColor">
                                    <path fill-rule="evenodd" d="M16.128 8.799c-3.665 0-6.627 2.536-6.627 5.664 0 .481.074.962.223 1.425-.185.018-.352.018-.518.018a9.119 9.119 0 01-2.259-.296.554.554 0 00-.481.056L4.3 16.96c-.13.075-.277-.055-.24-.184l.555-1.963c.018-.13-.019-.259-.13-.332-1.592-1.111-2.61-2.777-2.61-4.628 0-3.35 3.276-6.053 7.33-6.053 3.61 0 6.608 2.166 7.2 4.998h-.277zm-3.48-.815a.987.987 0 00-.981-.98.988.988 0 00-.981.98c0 .538.444.982.98.982a.987.987 0 00.982-.982zm-5.905.982a.987.987 0 01-.981-.982c0-.537.444-.98.98-.98.538 0 .982.443.982.98a.975.975 0 01-.981.982zm9.31.37c3.35 0 6.072 2.295 6.072 5.108 0 1.573-.833 2.962-2.13 3.906a.45.45 0 00-.184.48l.296 1.204c.037.11-.092.204-.185.148l-1.5-.814a.835.835 0 00-.518-.056 6.53 6.53 0 01-1.832.24c-3.35 0-6.072-2.294-6.072-5.108 0-2.813 2.703-5.108 6.053-5.108zm-2.998 3.61c0 .462.37.832.833.832a.83.83 0 00.833-.833.83.83 0 00-.833-.832.83.83 0 00-.833.832zm4.924.832a.83.83 0 01-.833-.833.83.83 0 01.833-.832.83.83 0 01.833.832.841.841 0 01-.833.833z" clip-rule="evenodd"/>
                                </svg>
                                联系方式3
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="footer-copyright">
                    <div class="footer-copyright1">
                        <p>Copyright © 2026 知舟课堂 版权所有</p>
                    </div>
                    <p><a href="https://beian.miit.gov.cn/" target="_blank">京ICP备XXXXXXXX号 </a></p>
                    <p>service@zhizhou.cn</p>
                </div>
                <div class="footer-friend-links">
                    <a href="https://www.hebtu.edu.cn/" target="_blank">友情链接：河北师范大学官网</a>
                    <a href="https://huihua.hebtu.edu.cn/" target="_blank">友情链接：河北师范大学汇华学院官网</a>
                </div>
            </div>
        </div>
    </footer>

    </form>
    
    <!-- 返回顶部按钮 -->
    <button class="back-to-top" id="backToTop">↑</button>
    
    <!-- 本地音乐播放器 -->
    <div id="aplayer" class="aplayer"></div>
    
    <script src="lib/APlayer.min.js"></script>
    <script>
        // 随机背景图
        (function() {
            var base = 'https://cdn.jsdelivr.net/gh/yiyinideshang/zhizhou-images@main/';
            var images = ['nbg1.jpg', 'nbg2.jpg', 'nbg3.jpg', 'nbg4.jpg', 'nbg5.jpg', 'nbg6.jpg', 'nbg7.jpg', 'nbg8.jpg'];
            var random = images[Math.floor(Math.random() * images.length)];
            document.querySelector('.banner').style.backgroundImage =
                'linear-gradient(135deg, rgba(44, 62, 80, 0.85), rgba(52, 152, 219, 0.7)), url(' + base + random + ')';
        })();

        // 常见问题折叠面板功能
        document.querySelectorAll('.faq-question').forEach(question => {
            question.addEventListener('click', () => {
                const answer = question.nextElementSibling;
        const isActive = question.classList.contains('active');
                
        // 关闭所有其他面板
        document.querySelectorAll('.faq-question').forEach(q => {
            q.classList.remove('active');
        q.nextElementSibling.classList.remove('active');
        });
                
        // 打开当前面板
        if (!isActive) {
            question.classList.add('active');
            answer.classList.add('active');
        }
        });
        });

        // 平滑滚动
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth'
                    });
                }
            });
        });
        
        // 返回顶部按钮功能
        const backToTopBtn = document.getElementById('backToTop');
        
        window.addEventListener('scroll', () => {
            if (window.scrollY > 300) {
                backToTopBtn.classList.add('show');
        } else {
            backToTopBtn.classList.remove('show');
        }
        });
        
        backToTopBtn.addEventListener('click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
        
        // 页面加载完成后初始化播放器
        document.addEventListener('DOMContentLoaded', function() {
            const audioData = <%= GetMusicPlaylistJson() %>;
            
            const ap = new APlayer({
                container: document.getElementById('aplayer'),
                fixed: true,
                autoplay: false,
                lrcType: 2,
                audio: audioData
            });
            
            ap.on('error', function () {
                console.error('APlayer error');
            });
        });
    </script>
</body>
</html>

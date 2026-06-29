<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="AdminDefault.aspx.cs" Inherits="Maticsoft.Web.Admin.AdminDefault" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .admin-home { padding: 20px; }
        .area-section { background: #fff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); margin-bottom: 20px; overflow: hidden; }
        .area-header { padding: 14px 20px; font-size: 16px; font-weight: bold; color: #fff; display: flex; align-items: center; gap: 8px; }
        .area-header .area-icon { font-size: 20px; }
        .area-body { padding: 16px 20px; display: flex; flex-wrap: wrap; gap: 12px; }
        .area-item { display: inline-flex; align-items: center; gap: 6px; padding: 10px 20px; background: #f5f7fa; border-radius: 6px; text-decoration: none; color: #333; font-size: 14px; transition: all .2s; border: 1px solid #e8e8e8; }
        .area-item:hover { background: #e6f7ff; border-color: #1677ff; color: #1677ff; transform: translateY(-1px); }
        .area-item .item-icon { font-size: 18px; }
        .area-item .stat-badge { background: #ff4d4f; color: #fff; border-radius: 10px; padding: 1px 8px; font-size: 12px; margin-left: 4px; }
        .header-blue { background: linear-gradient(135deg, #1677ff, #409eff); }
        .header-green { background: linear-gradient(135deg, #52c41a, #73d13d); }
        .header-orange { background: linear-gradient(135deg, #fa8c16, #ffa940); }
        .header-purple { background: linear-gradient(135deg, #722ed1, #9254de); }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="admin-home">
        <div class="page-header">
            <h3>管理首页</h3>
            <span class="breadcrumb">课程管理系统</span>
        </div>

        <!-- 用户管理 -->
        <div class="area-section">
            <div class="area-header header-green">
                <span class="area-icon">&#x1F465;</span> 用户管理
            </div>
            <div class="area-body">
                <a class="area-item" href="UsersList.aspx">
                    <span class="item-icon">&#x1F4CB;</span> 用户列表
                    <span class="stat-badge"><asp:Literal ID="litUserCount" runat="server" Text="0" /></span>
                </a>
                <a class="area-item" href="AddUsers.aspx">
                    <span class="item-icon">&#x2795;</span> 新增用户
                </a>
            </div>
        </div>

        <!-- 课程管理 -->
        <div class="area-section">
            <div class="area-header header-blue">
                <span class="area-icon">&#x1F4DA;</span> 课程管理
            </div>
            <div class="area-body">
                <a class="area-item" href="CourseList.aspx">
                    <span class="item-icon">&#x1F4CB;</span> 课程列表
                    <span class="stat-badge"><asp:Literal ID="litCourseCount" runat="server" Text="0" /></span>
                </a>
                <a class="area-item" href="NewCourse.aspx">
                    <span class="item-icon">&#x2795;</span> 添加课程
                </a>
                <a class="area-item" href="CateList.aspx">
                    <span class="item-icon">&#x1F4C1;</span> 课程分类
                </a>
            </div>
        </div>

        <!-- 订单管理 -->
        <div class="area-section">
            <div class="area-header header-orange">
                <span class="area-icon">&#x1F4CB;</span> 订单管理
            </div>
            <div class="area-body">
                <a class="area-item" href="OrdersList.aspx">
                    <span class="item-icon">&#x1F4E6;</span> 订单列表
                    <span class="stat-badge"><asp:Literal ID="litOrderCount" runat="server" Text="0" /></span>
                </a>
                <a class="area-item" href="OrderCourseList.aspx">
                    <span class="item-icon">&#x1F4D6;</span> 订单课程明细
                </a>
            </div>
        </div>

        <!-- 界面管理 -->
        <div class="area-section">
            <div class="area-header header-purple">
                <span class="area-icon">&#x1F3A8;</span> 界面管理
            </div>
            <div class="area-body">
                <a class="area-item" href="/Default.aspx">
                    <span class="item-icon">&#x1F3E0;</span> 回到首页
                </a>
                <a class="area-item" href="/Home.aspx">
                    <span class="item-icon">&#x2139;&#xFE0F;</span> 查看关于我们
                </a>
                <a class="area-item" href="/StudyPath.aspx">
                    <span class="item-icon">&#x1F680;</span> 查看学习路径
                </a>
                <a class="area-item" href="/Teacher.aspx">
                    <span class="item-icon">&#x1F393;</span> 查看名师大咖
                </a>
            </div>
        </div>
    </div>
</asp:Content>

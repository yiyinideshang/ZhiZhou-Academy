<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="CourseList.aspx.cs" Inherits="Maticsoft.Web.Admin.CourseList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../StyleSheet.css" />

    <style>
        .search-box {
            background: #f8f9fa;
            padding: 10px 16px;
            border-radius: 6px;
            margin-bottom: 12px;
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

            .search-box select,
            .search-box input {
                padding: 5px 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 12px;
            }

        .search-btn {
            background: #409eff;
            color: #fff;
            border: none;
            padding: 5px 14px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }

        /* 已推荐标签列表 */
        .recommend-tag-bar {
            background: #f0f9eb;
            border: 1px solid #c2e7b0;
            border-radius: 6px;
            padding: 8px 12px;
            margin-bottom: 12px;
        }

            .recommend-tag-bar .bar-title {
                display: block;
                font-weight: bold;
                color: #67c23a;
                margin-bottom: 10px;
            }

            .recommend-tag-bar .card-container {
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
            }

            .recommend-tag-bar .tag-card {
                display: inline-block;
                background: #fff;
                border: 2px solid #67c23a;
                border-radius: 8px;
                padding: 8px;
                text-align: center;
                width: 120px;
                min-height: 155px;
                box-sizing: border-box;
                vertical-align: top;
                margin-right: 10px;
                margin-bottom: 10px;
            }

            .recommend-tag-bar .tag-card img {
                width: 100px;
                height: 70px;
                object-fit: cover;
                border-radius: 4px;
                margin-bottom: 4px;
            }

            .recommend-tag-bar .tag-card .tag-title {
                font-size: 13px;
                color: #333;
                word-break: break-all;
                line-height: 1.3;
                height: 40px;
                overflow: hidden;
                margin-bottom: 4px;
            }

            .recommend-tag-bar .cancel-recommend-btn {
                background: #f56c6c;
                color: #fff;
                border: none;
                border-radius: 4px;
                padding: 3px 10px;
                font-size: 12px;
                cursor: pointer;
                width: 100px;
            }

            .recommend-tag-bar .cancel-recommend-btn:hover {
                background: #e64242;
            }

            .recommend-tag-bar .tag-empty {
                display: block;
                color: #f56c6c;
                font-size: 14px;
                text-align: center;
                padding: 10px 0;
            }

        /* 推荐按钮样式 */
        .lnk-recommend {
            color: #e6a23c;
            text-decoration: none;
            font-size: 13px;
        }

        .lnk-recommended {
            color: #67c23a;
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
        }

        /* 分页样式 */
        .grid-pager a, .grid-pager span {
            color: White;
            padding: 2px 6px;
            margin: 0 2px;
            text-decoration: none;
            font-size: 12px;
        }
        .grid-pager a:hover {
            text-decoration: underline;
        }
        .grid-pager .current-page {
            color: #ff4d4f !important;
            font-weight: bold;
            font-size: 14px;
        }
        .grid-pager input[type=text] {
            width: 40px;
            font-size: 12px;
        }

        /* 减小字体 */
        .recommend-tag-bar { font-size: 12px; }
        .recommend-tag-bar .tag-card { font-size: 12px; }
        .recommend-tag-bar .tag-card img { width: 90px; height: 60px; }
        .recommend-tag-bar .tag-card .tag-title { font-size: 12px; height: 36px; }
        .recommend-tag-bar .cancel-recommend-btn { font-size: 11px; padding: 2px 8px; width: 90px; }
        #GridView1 { font-size: 13px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="page-header">
        <h3>课程列表</h3>
        <span class="breadcrumb">课程管理 / 课程列表</span>
    </div>

    <!-- ====================== 高级搜索区域 ====================== -->
    <div class="search-box">
        <asp:DropDownList ID="cboField" runat="server">
            <asp:ListItem Value="Title">课程名称</asp:ListItem>
            <asp:ListItem Value="Author">作者</asp:ListItem>
            <asp:ListItem Value="Price">价格</asp:ListItem>
            <asp:ListItem Value="CategoryId">分类编号</asp:ListItem>
            <asp:ListItem Value="Clicks">点击量</asp:ListItem>
            <asp:ListItem Value="Registration">报名量</asp:ListItem>
        </asp:DropDownList>

        <asp:TextBox ID="txtKeyword" runat="server" placeholder="请输入搜索内容"></asp:TextBox>
        <asp:Button ID="btnSearch" runat="server" Text="搜索" CssClass="search-btn" OnClick="btnSearch_Click" />
        <asp:Button ID="btnReset" runat="server" Text="重置" CssClass="search-btn" OnClick="btnReset_Click" />
    </div>

    <!-- ====================== 已推荐课程标签列表 ====================== -->
    <asp:Panel ID="pnlRecommendedBar" runat="server" Visible="false" CssClass="recommend-tag-bar">
        <span class="bar-title">已推荐课程：</span>
        <div class="card-container">
            <asp:Repeater ID="rptRecommended" runat="server" OnItemCommand="rptRecommended_ItemCommand">
                <ItemTemplate>
                    <div class="tag-card">
                        <img src='/Admin/Courseimg/<%# Eval("beiyong") %>' alt='<%# Eval("Title") %>' />
                        <div class="tag-title"><%# Eval("Title") %></div>
                        <asp:Button ID="btnCancelRecommend" runat="server" Text="取消推荐" CssClass="cancel-recommend-btn"
                            CommandName="CancelRecommend" CommandArgument='<%# Eval("Id") %>' />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Label ID="lblNoRecommend" runat="server" Text="暂无推荐" CssClass="tag-empty" Visible="false" />
        </div>
    </asp:Panel>

    <asp:Label ID="lblEmptyTip" runat="server" Text="⚠️ 没有找到相关课程数据"
        ForeColor="#999" Font-Size="14px" Visible="false"
        Style="display: block; text-align: center; padding: 30px 0; background: #f8f9fa; border-radius: 6px;"></asp:Label>


    <asp:GridView ID="GridView1" runat="server"
        AutoGenerateColumns="False"
        CellPadding="4"
        ForeColor="#333333"
        GridLines="None"
        Width="100%"
        AllowPaging="True"
        PageSize="8"
        OnPageIndexChanging="GridView1_PageIndexChanging"
        OnRowDataBound="GridView1_RowDataBound"
        DataKeyNames="Id" EnableModelValidation="True">

        <AlternatingRowStyle BackColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" Font-Size="14px" />
        <PagerSettings Mode="Numeric" Position="Bottom" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />

        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID">
                <ItemStyle CssClass="hiddenId" />
                <HeaderStyle CssClass="hiddenId" />
                <FooterStyle CssClass="hiddenId" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="图像">
                <ItemTemplate>
                    <asp:ImageButton
                        ID="imgBtnCourse"
                        runat="server"
                        ImageUrl='<%# "/Admin/Courseimg/" + Eval("beiyong") %>'
                        Style="width: 70px; height: 50px; object-fit: cover; border-radius: 4px; cursor: pointer;"
                        CommandName="ViewImg"
                        CommandArgument='<%# Eval("Id") %>'
                        OnClick="imgBtnCourse_Click" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Title" HeaderText="课程名" />
            <asp:BoundField DataField="Author" HeaderText="作者" />
            <asp:BoundField DataField="CategoryId" HeaderText="分类编号" />
            <asp:BoundField DataField="Clicks" HeaderText="点击量" />
            <asp:BoundField DataField="PublishDate" HeaderText="出版日期" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="Duration" HeaderText="时长" />
            <asp:BoundField DataField="TOC" HeaderText="目录" />
            <asp:BoundField DataField="Registration" HeaderText="报名量" />
            <asp:BoundField DataField="IsShow" HeaderText="是否显示" />
            <asp:BoundField DataField="Price" HeaderText="价格" />
            <asp:BoundField DataField="StartDate" HeaderText="开课日期" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" OnClientClick="return confirm('确定删除吗？')">删除</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton4" runat="server" OnClick="LinkButton4_Click">详情</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="主编推荐">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkRecommend" runat="server"
                        CssClass='<%# Eval("IsRecommended").ToString() == "1" ? "lnk-recommended" : "lnk-recommend" %>'
                        Text='<%# Eval("IsRecommended").ToString() == "1" ? "已推荐" : "主编推荐" %>'
                        CommandArgument='<%# Eval("Id") %>'
                        OnClick="lnkRecommend_Click" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>

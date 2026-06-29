<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="OrderCourseList.aspx.cs" Inherits="Maticsoft.Web.Admin.OrderCourseList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .search-box { display: flex; gap: 8px; align-items: center; margin-bottom: 16px; }
        .search-box input, .search-box select { padding: 6px 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 13px; }
        .search-box .btn { padding: 6px 16px; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; }
        .btn-search { background: #1677ff; color: #fff; }
        .btn-reset { background: #f0f0f0; color: #333; }
        .stat-row { display: flex; gap: 16px; margin-bottom: 16px; }
        .stat-item { background: #f5f7fa; padding: 10px 20px; border-radius: 6px; font-size: 13px; }
        .stat-item strong { color: #fa8c16; font-size: 18px; }
        .Hide { display: none; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="page-header">
        <h3>订单课程明细</h3>
        <span class="breadcrumb">订单管理 / 订单课程明细</span>
    </div>

    <div class="stat-row">
        <div class="stat-item">明细总数: <strong><asp:Literal ID="litTotalItems" runat="server" Text="0" /></strong></div>
    </div>

    <div class="search-box">
        <asp:DropDownList ID="cboField" runat="server">
            <asp:ListItem Value="OrderID">订单ID</asp:ListItem>
            <asp:ListItem Value="CourseID">课程ID</asp:ListItem>
        </asp:DropDownList>
        <asp:TextBox ID="txtKeyword" runat="server" placeholder="输入关键词" />
        <asp:Button ID="btnSearch" runat="server" Text="搜索" CssClass="btn btn-search" OnClick="btnSearch_Click" />
        <asp:Button ID="btnReset" runat="server" Text="重置" CssClass="btn btn-reset" OnClick="btnReset_Click" />
    </div>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
        ForeColor="#333333" GridLines="None" Width="100%"
        AllowPaging="True" PageSize="10"
        OnPageIndexChanging="GridView1_PageIndexChanging"
        OnRowDataBound="GridView1_RowDataBound"
        DataKeyNames="Id" EnableModelValidation="True">
        <AlternatingRowStyle BackColor="White" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="明细ID">
                <ItemStyle CssClass="Hide" />
                <HeaderStyle CssClass="Hide" />
            </asp:BoundField>
            <asp:BoundField DataField="Id" HeaderText="编号" />
            <asp:BoundField DataField="OrderID" HeaderText="订单ID" />
            <asp:BoundField DataField="CourseID" HeaderText="课程ID" />
            <asp:TemplateField HeaderText="课程名称">
                <ItemTemplate>
                    <asp:Literal ID="litCourseName" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="beiyong1" HeaderText="备注1" />
            <asp:BoundField DataField="beiyong2" HeaderText="备注2" />
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkDelete" runat="server" Text="删除" OnClick="lnkDelete_Click"
                        OnClientClick="return confirm('确定删除该明细吗？')" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

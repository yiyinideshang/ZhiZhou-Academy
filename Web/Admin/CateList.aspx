<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="CateList.aspx.cs" Inherits="Maticsoft.Web.Admin.CateList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .add-box {
            background: #f8f9fa;
            padding: 15px 20px;
            border-radius: 6px;
            margin-bottom: 20px;
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .add-box input {
            padding: 6px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            width: 250px;
        }

        .add-btn {
            background: #409eff;
            color: #fff;
            border: none;
            padding: 6px 18px;
            border-radius: 4px;
            cursor: pointer;
        }

        .empty-tip {
            text-align: center; padding: 30px; color: #999;
            background: #f8f9fa; border-radius: 6px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="page-header">
        <h3>课程分类</h3>
        <span class="breadcrumb">课程管理 / 课程分类</span>
    </div>

    <!-- 添加分类 -->
    <div class="add-box">
        <asp:TextBox ID="txtCateName" runat="server" placeholder="请输入分类名称"></asp:TextBox>
        <asp:Button ID="btnAdd" runat="server" Text="添加分类" CssClass="add-btn" OnClick="btnAdd_Click" />
    </div>

    <!-- 无数据提示 -->
    <asp:Label ID="lblEmptyTip" runat="server" Text="暂无分类数据" CssClass="empty-tip" Visible="false" />

    <!-- 分类列表 -->
    <asp:GridView ID="GridView1" runat="server"
        AutoGenerateColumns="False"
        CellPadding="4"
        ForeColor="#333333"
        GridLines="None"
        Width="100%"
        DataKeyNames="Id"
        OnRowDataBound="GridView1_RowDataBound" Height="382px">

        <AlternatingRowStyle BackColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#EFF3FB" />

        <Columns>
            <asp:BoundField DataField="Name" HeaderText="分类名称" />

            <asp:TemplateField HeaderText="是否显示">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">禁用</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click">启用</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton3" runat="server" 
                        OnClick="LinkButton3_Click"
                        OnClientClick="return confirm('确定删除该分类？')">
                        删除
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>
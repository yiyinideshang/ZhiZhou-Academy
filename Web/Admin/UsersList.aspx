<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="UsersList.aspx.cs" Inherits="Maticsoft.Web.Admin.UsersList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .Hide { display: none; }
        .avatar-img { width: 40px; height: 40px; border-radius: 50%; border: 1px solid #ddd; object-fit: cover; }
        .role-change-btn { margin-left: 6px; font-size: 12px; }
        .role-panel { margin-top: 4px; padding: 4px 6px; background: #f7f9fc; border: 1px dashed #c0c9d5; border-radius: 4px; }
        .upload-panel { margin: 10px 0; padding: 10px; background: #fffbe6; border: 1px solid #ffe58f; border-radius: 4px; }
        .gv-container { max-height: 500px; overflow-y: auto; overflow-x: auto; }
        .gv-compact { font-size: 13px; }
        .gv-compact th, .gv-compact td { padding: 6px 8px; white-space: nowrap; }
        .col-avatar { width: 70px; }
        .col-loginid { width: 80px; }
        .col-name { width: 80px; }
        .col-gender { width: 50px; }
        .col-mail { width: 120px; }
        .col-phone { width: 100px; }
        .col-address { width: 100px; }
        .col-role { width: 140px; }
        .col-action { width: 110px; }
        .col-delete { width: 60px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="page-header">
        <h3>用户列表</h3>
        <span class="breadcrumb">用户管理 / 用户列表</span>
    </div>

    <asp:Panel ID="pnlUpload" runat="server" CssClass="upload-panel" Visible="false">
        <strong>更换头像（用户ID：<asp:Label ID="lblUploadUserId" runat="server" />）</strong><br /><br />
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <asp:Button ID="btnSavePhoto" runat="server" Text="保存" OnClick="btnSavePhoto_Click" />
        <asp:Button ID="btnCancelPhoto" runat="server" Text="取消" CausesValidation="false" OnClick="btnCancelPhoto_Click" />
        <asp:Label ID="lblUploadMsg" runat="server" ForeColor="Red" />
        <asp:HiddenField ID="hfPhotoUserId" runat="server" />
    </asp:Panel>

    <div class="gv-container">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            CssClass="gv-compact" CellPadding="4" GridLines="None" Width="100%"
            OnRowDataBound="GridView1_RowDataBound1">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Id">
                    <HeaderStyle CssClass="Hide" />
                    <ItemStyle CssClass="Hide" />
                </asp:BoundField>

                <asp:TemplateField HeaderText="头像">
                    <ItemTemplate>
                        <img src='<%# GetAvatarUrl(Eval("photo")) %>'
                            onerror="this.src='<%# ResolveUrl("~/images/photo/default.png") %>'"
                            class="avatar-img" />
                        <br />
                        <asp:LinkButton ID="lnkChangePhoto" runat="server" Text="更换头像"
                            CommandArgument='<%# Eval("Id") %>' OnClick="lnkChangePhoto_Click"
                            Font-Size="Small" />
                    </ItemTemplate>
                    <HeaderStyle CssClass="col-avatar" />
                    <ItemStyle HorizontalAlign="Center" CssClass="col-avatar" />
                </asp:TemplateField>

                <asp:BoundField DataField="LoginId" HeaderText="登录号">
                    <HeaderStyle CssClass="col-loginid" />
                    <ItemStyle CssClass="col-loginid" />
                </asp:BoundField>

                <asp:BoundField DataField="Name" HeaderText="昵称">
                    <HeaderStyle CssClass="col-name" />
                    <ItemStyle CssClass="col-name" />
                </asp:BoundField>

                <asp:TemplateField HeaderText="性别">
                    <ItemTemplate><%# GetGenderText(Eval("Gender")) %></ItemTemplate>
                    <HeaderStyle CssClass="col-gender" />
                    <ItemStyle HorizontalAlign="Center" CssClass="col-gender" />
                </asp:TemplateField>

                <asp:BoundField DataField="Mail" HeaderText="邮箱">
                    <HeaderStyle CssClass="col-mail" />
                    <ItemStyle CssClass="col-mail" />
                </asp:BoundField>

                <asp:TemplateField HeaderText="电话">
                    <ItemTemplate>
                        <%# FormatPhone(Eval("Phone"), Eval("mobile")) %>
                    </ItemTemplate>
                    <HeaderStyle CssClass="col-phone" />
                    <ItemStyle CssClass="col-phone" />
                </asp:TemplateField>

                <asp:BoundField DataField="Adress" HeaderText="地址">
                    <HeaderStyle CssClass="col-address" />
                    <ItemStyle CssClass="col-address" />
                </asp:BoundField>

                <asp:TemplateField HeaderText="角色">
                    <ItemTemplate>
                        <asp:Label ID="lblRoleName" runat="server"
                            Text='<%# GetRoleName(Eval("UserRoleld")) %>' Font-Bold="true" />
                        <asp:LinkButton ID="lnkChangeRole" runat="server" CssClass="role-change-btn"
                            Text="更改" CommandArgument='<%# Eval("Id") %>' OnClick="lnkChangeRole_Click" />
                        <asp:Panel ID="pnlRole" runat="server" CssClass="role-panel" Visible="false">
                            <asp:DropDownList ID="ddlRoles" runat="server" DataTextField="Name" DataValueField="Id" />
                            <asp:Button ID="btnConfirmRole" runat="server" Text="确定"
                                CommandArgument='<%# Eval("Id") %>' OnClick="btnConfirmRole_Click" />
                            <asp:Button ID="btnCancelRole" runat="server" Text="取消" CausesValidation="false"
                                CommandArgument='<%# Eval("Id") %>' OnClick="btnCancelRole_Click" />
                        </asp:Panel>
                    </ItemTemplate>
                    <HeaderStyle CssClass="col-role" />
                    <ItemStyle CssClass="col-role" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="状态">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" Text="禁用"
                            CommandArgument='<%# Eval("Id") %>' OnClick="LinkButton1_Click" />
                        <asp:LinkButton ID="LinkButton2" runat="server" Text="启用"
                            CommandArgument='<%# Eval("Id") %>' OnClick="LinkButton2_Click" />
                    </ItemTemplate>
                    <HeaderStyle CssClass="col-action" />
                    <ItemStyle HorizontalAlign="Center" CssClass="col-action" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="操作">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton3" runat="server" Text="删除"
                            CommandArgument='<%# Eval("Id") %>' OnClick="LinkButton3_Click"
                            OnClientClick="return confirm('确定删除？')" />
                    </ItemTemplate>
                    <HeaderStyle CssClass="col-delete" />
                    <ItemStyle HorizontalAlign="Center" CssClass="col-delete" />
                </asp:TemplateField>
            </Columns>
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        </asp:GridView>
    </div>
</asp:Content>

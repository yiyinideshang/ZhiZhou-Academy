<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="NewCourse.aspx.cs" Inherits="Maticsoft.Web.Admin.NewCourse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-box {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .form-item {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .form-item label {
            width: 120px;
            font-weight: bold;
            margin-right: 10px;
        }

        .form-item input,
        .form-item select,
        .form-item textarea {
            flex: 1;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .form-item textarea {
            height: 80px;
        }

        .btn-submit {
            background: #409eff;
            color: white;
            border: none;
            padding: 10px 30px;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="page-header">
        <h3>添加课程</h3>
        <span class="breadcrumb">课程管理 / 添加课程</span>
    </div>

    <div class="form-box">
        <h2 style="text-align:center; margin-bottom:20px;">添加新课程</h2>

        <div class="form-item">
            <label>课程名称：</label>
            <asp:TextBox ID="txtTitle" runat="server" placeholder="请输入课程名称"></asp:TextBox>
        </div>

        <div class="form-item">
            <label>讲师：</label>
            <asp:TextBox ID="txtAuthor" runat="server" placeholder="请输入讲师名称"></asp:TextBox>
        </div>

        <div class="form-item">
            <label>所属分类：</label>
            <asp:DropDownList ID="ddlCategory" runat="server" DataTextField="Name" DataValueField="Id"></asp:DropDownList>
        </div>

        <div class="form-item">
            <label>价格：</label>
            <asp:TextBox ID="txtPrice" runat="server" Text="0.00"></asp:TextBox>
        </div>

        <div class="form-item">
            <label>时长(分钟)：</label>
            <asp:TextBox ID="txtDuration" runat="server" Text="0"></asp:TextBox>
        </div>

        <div class="form-item">
            <label>开课时间：</label>
            <asp:TextBox ID="txtStartDate" runat="server" placeholder="例如：2026-05-20"></asp:TextBox>
        </div>

        <div class="form-item">
            <label>封面图(文件名)：</label>
            <asp:TextBox ID="txtImg" runat="server" placeholder="例如：1.png"></asp:TextBox>
        </div>

        <div class="form-item">
            <label>课程简介：</label>
            <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine"></asp:TextBox>
        </div>

        <div class="form-item">
            <label>讲师介绍：</label>
            <asp:TextBox ID="txtAuthorDesc" runat="server" TextMode="MultiLine"></asp:TextBox>
        </div>

        <div class="form-item">
            <label>课程目录：</label>
            <asp:TextBox ID="txtTOC" runat="server" TextMode="MultiLine"></asp:TextBox>
        </div>

        <div style="text-align:center; margin-top:20px;">
            <asp:Button ID="btnSave" runat="server" Text="添加课程" CssClass="btn-submit" OnClick="btnSave_Click" />
        </div>
    </div>

</asp:Content>
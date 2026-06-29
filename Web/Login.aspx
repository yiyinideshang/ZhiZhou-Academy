<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Maticsoft.Web.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <%--   <title>Glassmorphism Login Form</title>--%>
    <title>登录</title>
    <style>
        /* 全局样式重置 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        /* 背景样式 - 新增相对定位，为固定按钮预留空间 */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: url('images/login1.jpg') no-repeat;
            background-size: cover;
            background-position: center;
            position: relative; /* 新增 */
        }

        /* 新增：回到主页按钮样式（适配玻璃拟态风格） */
        .back-home-btn {
            position: fixed;
            left: 30px;
            top: 30px;
            padding: 10px 20px;
            /* 玻璃拟态样式 */
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            color: #fff;
            border-radius: 40px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            z-index: 999; /* 确保按钮在最上层 */
        }

        .back-home-btn:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
        }

        .back-home-btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        /* 移动端适配 */
        @media (max-width: 500px) {
            .back-home-btn {
                left: 15px;
                top: 15px;
                padding: 8px 15px;
                font-size: 13px;
            }
        }

        /* 玻璃拟态容器 */
        .wrapper {
            width: 420px;
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px); /* 兼容Safari */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            color: #fff;
            border-radius: 10px;
            padding: 30px 40px;
        }

            /* 标题样式 */
            .wrapper h2 {
                font-size: 36px;
                text-align: center;
                margin-bottom: 20px;
            }

        /* 输入框容器 */
        .input-field {
            position: relative;
            width: 100%;
            height: 50px;
            margin: 30px 0;
        }

            /* 输入框样式 */
            .input-field input {
                width: 100%;
                height: 100%;
                background: transparent;
                border: none;
                outline: none;
                border: 2px solid rgba(255, 255, 255, 0.2);
                border-radius: 40px;
                font-size: 16px;
                color: #fff;
                padding: 20px 45px 20px 20px;
            }

                /* 输入框占位符样式 */
                .input-field input::placeholder {
                    color: #fff;
                    opacity: 0.8;
                }

            /* 输入框标签样式 */
            .input-field label {
                position: absolute;
                top: 50%;
                left: 20px;
                transform: translateY(-50%);
                font-size: 16px;
                color: #fff;
                pointer-events: none;
                transition: 0.3s;
                right: 272px;
            }

            /* 输入框聚焦/有内容时标签上移 */
            .input-field input:focus ~ label,
            .input-field input:valid ~ label {
                top: -10px;
                left: 20px;
                font-size: 12px;
                background: rgba(0, 0, 0, 0.3);
                padding: 0 5px;
                border-radius: 2px;
            }

        .error-tip {
            color: #ff4d4f; /* 红色 */
            font-size: 18px;
            margin: 0 15px; /* 和左右元素保持间距 */
        }

        .forget {
            display: flex;
            align-items: center; /* 垂直居中 */
            justify-content: space-between;
            font-size: 14.5px;
            margin: -15px 0 15px;
        }
        /* 登录按钮样式 */
        .wrapper button {
            width: 100%;
            height: 45px;
            background: #fff;
            border: none;
            outline: none;
            border-radius: 40px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            font-size: 16px;
            color: #333;
            font-weight: 600;
        }

        /* 注册提示区域 */
        .register {
            font-size: 14.5px;
            text-align: center;
            margin: 20px 0 15px;
        }

            .register p a {
                color: #fff;
                text-decoration: none;
                font-weight: 600;
            }

                .register p a:hover {
                    text-decoration: underline;
                }
    </style>

</head>
<body>
    <!-- 新增：回到主页按钮 -->
    <button class="back-home-btn" onclick="window.location.href='Default.aspx'">回到主页</button>

    <form id="form1" runat="server">
        <div class="wrapper">
            <h2>登录</h2>

            <!-- 用户名输入框（ASP.NET服务器控件）LoginId+LoginPwd -->
            <div class="input-field">
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-input" required placeholder=" "></asp:TextBox>
                <label>用户号：</label>
            </div>

            <!-- 密码输入框（ASP.NET服务器控件） -->
            <div class="input-field">
                <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" CssClass="form-input" required placeholder=" "></asp:TextBox>
                <label>密码：</label>
            </div>

            <!-- 记住我复选框 -->
            <div class="forget">
                <label for="remember">
                    <input type="checkbox" id="remember">
                    <p>记住密码</p>
                </label>
                <!-- 错误提示标签：默认隐藏，红色字体 -->
                <asp:Label ID="lblError" runat="server" Text="用户不存在或密码错误"
                    CssClass="error-tip" Visible="false"></asp:Label>
                <a href="#">忘记密码?</a>
            </div>

            <!-- 登录按钮（ASP.NET服务器控件） -->
            <asp:Button ID="Button1" runat="server" Height="45px" OnClick="Button1_Click" Text="登录"
                Style="width: 100%; border-radius: 40px; border: none; background: #fff; color: #333; font-weight: 600; cursor: pointer; font-size: 16px;" />

            <!-- 注册提示 -->
            <div class="register">
                <p>还没有账号， <a href="Register.aspx">去注册？</a></p>
            </div>
        </div>
    </form>
</body>
</html>
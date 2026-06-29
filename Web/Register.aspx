<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Maticsoft.Web.WebForm1" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        /* 新增：背景轮播容器样式 */
        .bg-slider {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1; /* 置于最底层，不遮挡内容 */
            overflow: hidden;
        }

        .bg-slide {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0;
            transition: opacity 1s ease-in-out; /* 切换过渡效果 */
            background-size: cover; /* 背景图片铺满 */
            background-position: center; /* 背景居中 */
            background-repeat: no-repeat;
        }

        .bg-slide.active {
            opacity: 1;
        }

        body {
            /* 移除原有背景色，改为透明 */
            background-color: transparent;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            /* 防止轮播背景遮挡滚动条 */
            position: relative;
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

        .register-container {
            background-color: rgba(255, 255, 255, 0.95); /* 增加透明度，透出背景 */
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            /* 增加层级，确保表单在背景之上 */
            z-index: 10;
        }

        .register-title {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
        }

        .avatar-box {
            text-align: center;
            margin-bottom: 30px;
        }
        .avatar-preview {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #eee;
            cursor: pointer;
            transition: border-color 0.3s;
        }
        .avatar-preview:hover {
            border-color: #409eff;
        }
        .avatar-tip {
            margin-top: 6px;
            font-size: 13px;
            color: #888;
        }
        #avatarInput {
            display: none;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label .required {
            color: #f56c6c;
            margin-left: 4px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .gender-group {
            display: flex;
            gap: 20px;
            padding: 8px 0;
        }
        .gender-option {
            display: flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
        }
        .gender-option input[type="radio"] {
            width: auto;
            padding: 0;
        }

        .form-group input:focus {
            outline: none;
            border-color: #409eff;
            box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
        }

        .error-message {
            color: #f56c6c;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }

        .register-btn {
            width: 100%;
            padding: 12px;
            background-color: #409eff;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .register-btn:hover {
            background-color: #337ecc;
        }

        .register-btn:active {
            background-color: #266ab9;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
            font-size: 14px;
        }

        .login-link a {
            color: #409eff;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 500px) {
            .register-container {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>

    <button class="back-home-btn" onclick="window.location.href='Default.aspx'">回到主页</button>

    <!-- 新增：背景轮播容器 -->
    <div class="bg-slider">
        <div class="bg-slide active" style="background-image: url('images/bg4.jpg');"></div>
        <div class="bg-slide" style="background-image: url('images/bg2.jpg');"></div>
        <div class="bg-slide" style="background-image: url('images/bg1.jpg');"></div>
        <div class="bg-slide" style="background-image: url('images/bg3.jpg');"></div>
    </div>

    <div class="register-container">
        <h2 class="register-title">用户注册</h2>

        <form id="registerForm" method="post" runat="server">
            <div class="avatar-box">
                <img id="avatarPreview" class="avatar-preview" src="images/photo/default.png" alt="头像" onclick="document.getElementById('<%= FileUploadAvatar.ClientID %>').click();">
                <asp:FileUpload ID="FileUploadAvatar" runat="server" style="display:none;" onchange="previewAvatar(this);" accept="image/*" />
                <div class="avatar-tip">点击头像上传（可选）</div>
            </div>

            <div class="form-group">
                <label for="username">用户名<span class="required">*</span></label>
                <input type="text" id="username" name="username" placeholder="请输入用户名">
                <div class="error-message" id="usernameError">用户名不能为空</div>
            </div>

            <div class="form-group">
                <label for="password">密码<span class="required">*</span></label>
                <input type="password" id="password" name="password" placeholder="请输入密码">
                <div class="error-message" id="passwordError">密码不能为空</div>
            </div>

            <div class="form-group">
                <label for="confirmPwd">确认密码<span class="required">*</span></label>
                <input type="password" id="confirmPwd" placeholder="请再次输入密码">
                <div class="error-message" id="confirmPwdError">确认密码不能为空</div>
            </div>

            <div class="form-group">
                <label for="name">姓名</label>
                <input type="text" id="name" name="name" placeholder="请输入您的姓名">
            </div>

            <div class="form-group">
                <label>性别</label>
                <div class="gender-group">
                    <div class="gender-option">
                        <input type="radio" id="genderMale" name="gender" value="男" checked>
                        <label for="genderMale">男</label>
                    </div>
                    <div class="gender-option">
                        <input type="radio" id="genderFemale" name="gender" value="女">
                        <label for="genderFemale">女</label>
                    </div>
                    <!-- 新增的"不显示"选项 -->
                    <div class="gender-option">
                        <input type="radio" id="genderHidden" name="gender" value="不显示">
                        <label for="genderHidden">不显示</label>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="email">邮箱</label>
                <input type="email" id="email" name="email" placeholder="请输入您的邮箱">
                <div class="error-message" id="emailError">邮箱格式错误</div>
            </div>

            <div class="form-group">
                <label for="phone">电话</label>
                <input type="text" id="phone" name="phone" placeholder="请输入11位手机号码">
                <div class="error-message" id="phoneError">手机号格式错误</div>
            </div>

            <div class="form-group">
                <label for="address">地址</label>
                <input type="text" id="address" name="address" placeholder="请输入您的联系地址">
            </div>

            <asp:Button ID="Button1" runat="server" Text="注册" CssClass="register-btn" OnClick="Button1_Click" />
        </form>
        <div class="login-link">
            已有账号？<a href="Login.aspx">立即登录</a>
        </div>
    </div>

    <script>
        // 新增：背景轮播逻辑
        const slides = document.querySelectorAll('.bg-slide');
        let currentSlide = 0;
        const slideInterval = 5000; // 5秒切换一次

        function nextSlide() {
            // 移除当前激活的slide的active类
            slides[currentSlide].classList.remove('active');
            // 切换到下一个slide，循环切换
            currentSlide = (currentSlide + 1) % slides.length;
            // 给下一个slide添加active类
            slides[currentSlide].classList.add('active');
        }

        // 页面加载后启动轮播
        window.onload = function () {
            // 初始显示第一个slide
            slides[0].classList.add('active');
            // 设置定时器，每5秒切换一次
            setInterval(nextSlide, slideInterval);
        };

        // 原有注册表单逻辑
        var registerForm = document.getElementById('registerForm');
        var username = document.getElementById('username');
        var password = document.getElementById('password');
        var confirmPwd = document.getElementById('confirmPwd');
        var name = document.getElementById('name');
        var email = document.getElementById('email');
        var phone = document.getElementById('phone');
        var address = document.getElementById('address');

        var avatarPreview = document.getElementById('avatarPreview');
        var avatarInput = document.getElementById('avatarInput');

        var usernameError = document.getElementById('usernameError');
        var passwordError = document.getElementById('passwordError');
        var confirmPwdError = document.getElementById('confirmPwdError');
        var avatarPreview = document.getElementById('avatarPreview');

        function previewAvatar(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    avatarPreview.src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        // 前端验证（仅验证不阻止提交，除非失败）
        registerForm.addEventListener('submit', function (e) {
            var isFormValid = true;

            // 用户名验证
            var usernameValue = username.value.trim();
            if (usernameValue === '') {
                usernameError.textContent = '用户名不能为空';
                usernameError.style.display = 'block';
                isFormValid = false;
            } else {
                usernameError.style.display = 'none';
            }

            // 密码验证
            var passwordValue = password.value;
            if (passwordValue === '') {
                passwordError.textContent = '密码不能为空';
                passwordError.style.display = 'block';
                isFormValid = false;
            } else {
                passwordError.style.display = 'none';
            }

            // 确认密码验证
            var confirmPwdValue = confirmPwd.value;
            if (confirmPwdValue === '') {
                confirmPwdError.textContent = '确认密码不能为空';
                confirmPwdError.style.display = 'block';
                isFormValid = false;
            } else if (confirmPwdValue !== passwordValue) {
                confirmPwdError.textContent = '两次输入的密码不一致';
                confirmPwdError.style.display = 'block';
                isFormValid = false;
            } else {
                confirmPwdError.style.display = 'none';
            }

            // 邮箱验证
            var emailValue = email.value.trim();
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (emailValue !== '' && !emailRegex.test(emailValue)) {
                emailError.textContent = '邮箱格式错误';
                emailError.style.display = 'block';
                isFormValid = false;
            } else {
                emailError.style.display = 'none';
            }

            // 手机号验证
            var phoneValue = phone.value.trim();
            var phoneRegex = /^1[3-9]\d{9}$/;
            if (phoneValue !== '' && !phoneRegex.test(phoneValue)) {
                phoneError.textContent = '手机号格式错误';
                phoneError.style.display = 'block';
                isFormValid = false;
            } else {
                phoneError.style.display = 'none';
            }

            // 验证不通过则阻止提交
            if (!isFormValid) {
                e.preventDefault();
            }
        });

        // 输入框聚焦隐藏错误
        var inputElements = [username, password, confirmPwd, name, email, phone, address];
        for (var i = 0; i < inputElements.length; i++) {
            inputElements[i].addEventListener('focus', function () {
                var errorId = this.id + 'Error';
                var errorEl = document.getElementById(errorId);
                if (errorEl) errorEl.style.display = 'none';
            });
        }
    </script>
</body>
</html>
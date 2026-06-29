<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="AddUsers.aspx.cs" Inherits="Maticsoft.Web.Admin.AddUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        .add-user-box {
            width: 100%;
            max-width: 680px;
            margin: 30px auto;
            padding: 30px 35px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        .form-title {
            text-align: center;
            margin-bottom: 28px;
            color: #222;
            font-size: 22px;
            font-weight: 600;
        }

        .avatar-box {
            text-align: center;
            margin-bottom: 28px;
        }

        .avatar-preview {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #eee;
            cursor: pointer;
        }

        .avatar-tip {
            font-size: 12px;
            color: #777;
            margin-top: 6px;
        }

        #avatarInput {
            display: none;
        }

        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            width: 100px;
            font-size: 14px;
            color: #333;
            font-weight: 500;
            text-align: right;
            padding-right: 10px;
        }

        .form-group .required {
            color: #f56c6c;
            margin-left: 3px;
        }

        .form-group input,
        .form-group select {
            flex: 1;
            padding: 11px 14px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #409eff;
        }

        .error-message {
            position: absolute;
            color: #f56c6c;
            font-size: 12px;
            left: 110px;
            top: 40px;
            display: none;
            white-space: nowrap;
        }

        .gender-group {
            display: inline-flex;
            align-items: center;
            flex: 1;
        }

        .gender-option {
            display: inline-flex;
            align-items: center;
            margin-right: 15px;
            font-size: 14px;
        }
        
        .gender-option input[type="radio"] {
            margin: 0;
            padding: 0;
        }
        
        .gender-option label {
            margin-left: 4px;
            cursor: pointer;
        }

        .submit-btn {
            width: 180px;
            margin: 30px auto 0 auto;
            display: block;
            padding: 12px 0;
            background: #409eff;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
        }

        .submit-btn:hover {
            background: #337ecc;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="page-header">
        <h3>新增用户</h3>
        <span class="breadcrumb">用户管理 / 新增用户</span>
    </div>
    <div class="add-user-box">
        <h3 class="form-title">管理员添加用户</h3>

        <div class="avatar-box">
            <img id="avatarPreview" class="avatar-preview" src="/images/photo/default.png" alt="头像" onclick="document.getElementById('<%= FileUploadAvatar.ClientID %>').click();">
            <asp:FileUpload ID="FileUploadAvatar" runat="server" style="display:none;" onchange="previewAvatar(this);" accept="image/*" />
            <div class="avatar-tip">点击上传</div>
        </div>

        <div class="form-group">
            <label for="username">用户名<span class="required">*</span></label>
            <input type="text" id="username" name="username" placeholder="请输入" />
            <div class="error-message" id="usernameError">用户名不能为空</div>
        </div>

        <div class="form-group">
            <label for="password">密码<span class="required">*</span></label>
            <input type="password" id="password" name="password" placeholder="请输入" />
            <div class="error-message" id="passwordError">密码不能为空</div>
        </div>

        <div class="form-group">
            <label for="confirmPwd">确认密码<span class="required">*</span></label>
            <input type="password" id="confirmPwd" name="confirmPwd" placeholder="请输入" />
            <div class="error-message" id="confirmPwdError">两次密码不一致</div>
        </div>

        <div class="form-group">
            <label for="name">姓名</label>
            <input type="text" id="name" name="name" placeholder="请输入" />
        </div>

        <div class="form-group">
            <label for="userRole">用户角色<span class="required">*</span></label>
            <select id="userRole" name="userRole">
                <option value="1">普通用户</option>
                <option value="2">VIP用户</option>
                <option value="5">管理员</option>
            </select>
        </div>

        <div class="form-group">
            <label>性别</label>
            <div class="gender-group">
                <div class="gender-option">
                    <input type="radio" id="genderMale" name="gender" value="男" checked />
                    <label for="genderMale">男</label>
                </div>
                <div class="gender-option">
                    <input type="radio" id="genderFemale" name="gender" value="女" />
                    <label for="genderFemale">女</label>
                </div>
                <div class="gender-option">
                    <input type="radio" id="genderHidden" name="gender" value="不显示" />
                    <label for="genderHidden">不显示</label>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="email">邮箱</label>
            <input type="email" id="email" name="email" placeholder="请输入" />
            <div class="error-message" id="emailError">邮箱格式错误</div>
        </div>

        <div class="form-group">
            <label for="phone">电话</label>
            <input type="text" id="phone" name="phone" placeholder="请输入" />
            <div class="error-message" id="phoneError">手机号格式错误</div>
        </div>

        <div class="form-group">
            <label for="address">地址</label>
            <input type="text" id="address" name="address" placeholder="请输入" />
        </div>

        <asp:Button ID="btnAdd" runat="server" Text="添加用户" CssClass="submit-btn" OnClick="btnAdd_Click" OnClientClick="return validateForm();" />
    </div>

    <script>
        const avatarPreview = document.getElementById('avatarPreview');
        
        function previewAvatar(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = (e) => avatarPreview.src = e.target.result;
                reader.readAsDataURL(input.files[0]);
            }
        }

        // 表单验证
        const username = document.getElementById('username');
        const password = document.getElementById('password');
        const confirmPwd = document.getElementById('confirmPwd');
        const email = document.getElementById('email');
        const phone = document.getElementById('phone');

        const usernameError = document.getElementById('usernameError');
        const passwordError = document.getElementById('passwordError');
        const confirmPwdError = document.getElementById('confirmPwdError');
        const emailError = document.getElementById('emailError');
        const phoneError = document.getElementById('phoneError');

        function validateForm() {
            let isValid = true;

            // 用户名
            const userVal = username.value.trim();
            if (!userVal) {
                usernameError.style.display = 'block';
                isValid = false;
            } else usernameError.style.display = 'none';

            // 密码
            const pwdVal = password.value.trim();
            if (!pwdVal) {
                passwordError.style.display = 'block';
                isValid = false;
            } else passwordError.style.display = 'none';

            // 确认密码
            const cpwdVal = confirmPwd.value.trim();
            if (!cpwdVal) {
                confirmPwdError.innerText = '确认密码不能为空';
                confirmPwdError.style.display = 'block';
                isValid = false;
            } else if (cpwdVal !== pwdVal) {
                confirmPwdError.innerText = '两次密码不一致';
                confirmPwdError.style.display = 'block';
                isValid = false;
            } else confirmPwdError.style.display = 'none';

            // 邮箱
            const emailVal = email.value.trim();
            const emailReg = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (emailVal && !emailReg.test(emailVal)) {
                emailError.style.display = 'block';
                isValid = false;
            } else emailError.style.display = 'none';

            // 手机
            const phoneVal = phone.value.trim();
            const phoneReg = /^1[3-9]\d{9}$/;
            if (phoneVal && !phoneReg.test(phoneVal)) {
                phoneError.style.display = 'block';
                isValid = false;
            } else phoneError.style.display = 'none';

            return isValid;
        }

        // 输入时隐藏错误
        [username, password, confirmPwd, email, phone].forEach(item => {
            item.addEventListener('focus', () => {
                const err = document.getElementById(item.id + 'Error');
        if (err) err.style.display = 'none';
        });
        });
    </script>
</asp:Content>
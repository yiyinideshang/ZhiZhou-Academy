using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace Maticsoft.Web
{
    public partial class Login : System.Web.UI.Page
    {
        BLL.Users UsersBLL = new BLL.Users();
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            lblError.Visible = false;
            // 获取登录用户信息（根据账号密码查询）
            List<Model.Users> loginUserlist = UsersBLL.GetModelList("LoginId='" + TextBox1.Text + "' and LoginPwd='" + TextBox2.Text + "'");
            if (loginUserlist.Count > 0)
            {
                string jumpUrl = "";
                Model.Users user = loginUserlist[0];
                // 检查用户是否被禁用
                if (user.IsShow != 1)
                {
                    string roleText = "";
                    if (user.UserRoleld == 5)
                        roleText = "管理员";
                    else if (user.UserRoleld == 2)
                        roleText = "VIP用户";
                    else
                        roleText = "用户";
                    lblError.Text = "当前" + roleText + "被禁用！";
                    lblError.Visible = true;
                    return;
                }
                // ========== 新增：保存用户信息到 Session ==========
                Session["UserId"] = user.Id;
                Session["UserName"] = user.Name;
                Session["UserRoleId"] = user.UserRoleld;
                Session["LoginId"] = user.LoginId;
                // 处理头像路径
                string photoPath = user.photo;
                if (string.IsNullOrEmpty(photoPath))
                {
                    // 使用默认头像
                    photoPath = "images/photo/default.png";
                }
                Session["UserPhoto"] = photoPath;
                // ================================================
                // 根据角色判断跳转地址
                if (user.UserRoleld == 5) // 管理员
                {
                    jumpUrl = "Default.aspx";
                    //"Admin/AdminDefault.aspx";
                }
                else // 普通用户和VIP用户
                {
                    jumpUrl = "Default.aspx";
                }
                string redirectScript = @"
	                // 创建优雅的提示框
	                var tipDiv = document.createElement('div');
	                tipDiv.style.position = 'fixed';
	                tipDiv.style.top = '10%';
	                tipDiv.style.left = '50%';
	                tipDiv.style.transform = 'translate(-50%, -50%)';
	                tipDiv.style.padding = '25px 50px';
	                tipDiv.style.backgroundColor = 'white';
	                tipDiv.style.color = '#333';
	                tipDiv.style.fontSize = '18px';
	                tipDiv.style.borderRadius = '12px';
	                tipDiv.style.boxShadow = '0 4px 20px rgba(0,0,0,0.1)';
	                tipDiv.style.border = '1px solid #f0f0f0';
	                tipDiv.style.zIndex = '9999';
	                tipDiv.style.textAlign = 'center';
	                tipDiv.style.lineHeight = '1.8';
	                // 倒计时变量
	                var countdown = 3;
	                // 创建两行元素
	                var line1 = document.createElement('div');
	                line1.innerText = '登录成功！' + countdown + '秒后自动跳转首页';
	                var line2 = document.createElement('div');
	                line2.style.color = '#1677ff';
	                line2.style.fontSize = '16px';
	                line2.style.textDecoration = 'underline';
	                line2.style.cursor = 'pointer';
	                line2.innerText = '点击此处立即跳转';
	                // 仅第二行绑定点击事件
	                line2.onclick = function() {
	                    window.location.href = '" + jumpUrl + @"';
	                };
	                // 组装提示框
	                tipDiv.appendChild(line1);
	                tipDiv.appendChild(line2);
	                document.body.appendChild(tipDiv);
	                // 倒计时逻辑
	                var timer = setInterval(function() {
	                    countdown--;
	                    if (countdown <= 0) {
	                        clearInterval(timer);
	                        window.location.href = '" + jumpUrl + @"';
	                    } else {
	                        line1.innerText = '登录成功！' + countdown + '秒后自动跳转首页';
	                    }
	                }, 1000);
	            ";
                // 注册脚本到页面
                ClientScript.RegisterStartupScript(this.GetType(), "LoginSuccess", redirectScript, true);
            }
            else
            {
                // 显示错误提示
                lblError.Visible = true;
                // 清空密码框
                TextBox2.Text = "";
            }
        }
    }
}
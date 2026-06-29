using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace Maticsoft.Web.Admin
{
    public partial class AddUsers : System.Web.UI.Page
    {
        BLL.Users UsersBLL = new BLL.Users();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. 获取前端表单数据（兼容低版本C#）
                string loginId = "";
                if (Request.Form["username"] != null)
                {
                    loginId = Request.Form["username"].Trim();
                }

                string loginPwd = "";
                if (Request.Form["password"] != null)
                {
                    loginPwd = Request.Form["password"].Trim();
                }

                // ===================== 修复 1：获取确认密码 =====================
                string confirmPwd = "";
                if (Request.Form["confirmPwd"] != null)
                {
                    confirmPwd = Request.Form["confirmPwd"].Trim();
                }

                string name = "";
                if (Request.Form["name"] != null)
                {
                    name = Request.Form["name"].Trim();
                }

                string genderStr = "男";
                if (Request.Form["gender"] != null && !string.IsNullOrEmpty(Request.Form["gender"].Trim()))
                {
                    genderStr = Request.Form["gender"];
                }

                string phone = "";
                if (Request.Form["phone"] != null)
                {
                    phone = Request.Form["phone"].Trim();
                }

                string mail = "";
                if (Request.Form["email"] != null)
                {
                    mail = Request.Form["email"].Trim();
                }

                string adress = "";
                if (Request.Form["address"] != null)
                {
                    adress = Request.Form["address"].Trim();
                }

                // ===================== 修复 2：获取前端选择的角色 =====================
                int userRole = 1;
                if (Request.Form["userRole"] != null)
                {
                    int.TryParse(Request.Form["userRole"], out userRole);
                }

                // 2. 验证必填项
                if (string.IsNullOrEmpty(loginId))
                {
                    ShowAlert("用户名不能为空");
                    return;
                }
                if (string.IsNullOrEmpty(loginPwd))
                {
                    ShowAlert("密码不能为空");
                    return;
                }

                // ===================== 修复 3：验证两次密码一致 =====================
                if (loginPwd != confirmPwd)
                {
                    ShowAlert("两次密码不一致！");
                    return;
                }

                // ===================== 修复 4：用户名重复判断（只查账号） =====================
                bool isUserNameExists = UsersBLL.Exists(loginId);
                if (isUserNameExists)
                {
                    ShowAlert("用户名已存在，请更换其他用户名！");
                    return;
                }

                // 3. 性别转换
                int? gender = null;
                if (genderStr == "男")
                {
                    gender = 1;
                }
                else if (genderStr == "女")
                {
                    gender = 2;
                }

                // 4. 头像上传
                string photoPath = "images/photo/default.png";
                if (FileUploadAvatar.HasFile && FileUploadAvatar.PostedFile != null && FileUploadAvatar.PostedFile.ContentLength > 0)
                {
                    HttpPostedFile file = FileUploadAvatar.PostedFile;
                    string[] allowedExts = { ".jpg", ".jpeg", ".png", ".gif", ".bmp" };
                    string fileExt = Path.GetExtension(file.FileName).ToLower();

                    bool isExtAllowed = false;
                    foreach (string ext in allowedExts)
                    {
                        if (ext == fileExt)
                        {
                            isExtAllowed = true;
                            break;
                        }
                    }
                    if (!isExtAllowed)
                    {
                        ShowAlert("仅支持上传jpg、png、gif、bmp格式的图片");
                        return;
                    }

                    string uploadDir = Server.MapPath("~/images/photo/");
                    if (!Directory.Exists(uploadDir))
                    {
                        Directory.CreateDirectory(uploadDir);
                    }

                    string fileName = Guid.NewGuid().ToString() + fileExt;
                    string savePath = Path.Combine(uploadDir, fileName);
                    file.SaveAs(savePath);
                    photoPath = "images/photo/" + fileName;
                }

                // 5. 封装数据
                Model.Users newUser = new Model.Users();
                newUser.LoginId = loginId;
                newUser.LoginPwd = loginPwd;
                newUser.Name = name;
                newUser.Phone = phone;
                newUser.UserRoleld = userRole; // 修复：使用前端选择的角色
                newUser.Adress = adress;
                newUser.Mail = mail;
                newUser.Gender = gender;
                newUser.photo = photoPath;
                newUser.IsShow = 1;

                // 6. 写入数据库
                int result = UsersBLL.Add(newUser);

                if (result > 0)
                {
                    ShowAlertAndRedirect("注册成功！", "/Admin/UsersList.aspx");
                }
                else
                {
                    ShowAlert("注册失败，请检查数据库连接或BLL层代码");
                }
            }
            catch (Exception ex)
            {
                ShowAlert("注册错误：" + ex.Message);
            }
        }

        /// <summary>
        /// 显示弹窗提示
        /// </summary>
        private void ShowAlert(string message)
        {
            string safeMessage = message.Replace("'", "\\'").Replace("\"", "\\\"");
            Response.Write("<script>alert('" + safeMessage + "');</script>");
        }

        /// <summary>
        /// 显示弹窗并跳转
        /// </summary>
        private void ShowAlertAndRedirect(string message, string url)
        {
            string safeMessage = message.Replace("'", "\\'").Replace("\"", "\\\"");
            Response.Write("<script>alert('" + safeMessage + "');location.href='" + url + "';</script>");
        }
    }
}

using System;
using System.IO;
using System.Web;
using System.Web.UI;

namespace Maticsoft.Web
{
    public partial class WebForm1 : Page
    {
        // 确保你的项目中有 BLL.Users 和 Model.Users 类
        BLL.Users UsersBLL = new BLL.Users();

        protected void Page_Load(object sender, EventArgs e)
        {
            // 页面首次加载逻辑（如果需要）
        }

        protected void Button1_Click(object sender, EventArgs e)
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

                bool isUserNameExists = UsersBLL.Exists(loginId);
                if (isUserNameExists)
                {
                    ShowAlert("用户名已存在，请更换其他用户名！");
                    return;
                }

                // 3. 性别转换（关键修改：增加"不显示"判断，设置为null）
                int? gender = null; // 改为可空int类型（int?）
                if (genderStr == "男")
                {
                    gender = 1;
                }
                else if (genderStr == "女")
                {
                    gender = 2;
                }
                // 选择"不显示"时，gender保持null

                // 4. 头像上传处理
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

                // 5. 封装用户数据
                Model.Users newUser = new Model.Users();
                newUser.LoginId = loginId;
                newUser.LoginPwd = loginPwd; // 实际项目中请加密存储密码（如MD5/SHA256）
                newUser.Name = name;
                newUser.Phone = phone;
                newUser.UserRoleld = 1; // 普通用户角色
                newUser.Adress = adress;
                newUser.Mail = mail;
                newUser.Gender = gender; // 直接赋值（null/1/2）
                newUser.photo = photoPath;
                newUser.IsShow = 1;

                // 6. 写入数据库
                int result = UsersBLL.Add(newUser);

                if (result > 0)
                {
                    ShowAlertAndRedirect("注册成功！", "Login.aspx");
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

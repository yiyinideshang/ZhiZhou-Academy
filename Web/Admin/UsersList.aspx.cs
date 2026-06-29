using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.Admin
{
    public partial class UsersList : System.Web.UI.Page
    {
        BLL.Users UsersBLL = new BLL.Users();
        BLL.UserRoles RolesBLL = new BLL.UserRoles();

        private static List<Maticsoft.Model.UserRoles> _cachedRoles;

        private List<Maticsoft.Model.UserRoles> GetAllRoles()
        {
            if (_cachedRoles == null)
                _cachedRoles = RolesBLL.GetModelList("");
            return _cachedRoles;
        }

        /// <summary>性别显示：1=男, 2=女, 其他=未填</summary>
        protected string GetGenderText(object gender)
        {
            if (gender == null || Convert.IsDBNull(gender)) return "未填";
            string s = gender.ToString().Trim();
            if (string.IsNullOrEmpty(s)) return "未填";

            int val;
            if (int.TryParse(s, out val))
            {
                if (val == 1) return "男";
                else if (val == 2) return "女";
                return "未填";
            }

            if (s == "男") return "男";
            else if (s == "女") return "女";
            return "未填";
        }

        /// <summary>头像 URL：支持 ~/、images/photo/ 开头及纯文件名，空值用 default.png</summary>
        protected string GetAvatarUrl(object photo)
        {
            string defaultUrl = ResolveUrl("~/images/photo/default.png");
            if (photo == null || Convert.IsDBNull(photo)) return defaultUrl;
            string path = photo.ToString().Trim();
            if (string.IsNullOrEmpty(path)) return defaultUrl;

            // 完整 URL 直接返回
            if (path.StartsWith("http://", StringComparison.OrdinalIgnoreCase) ||
                path.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
                return path;

            // ~/ 开头，直接 Resolve
            if (path.StartsWith("~/")) return ResolveUrl(path);

            // images/photo/ 开头，补上 ~/
            if (path.StartsWith("images/photo/", StringComparison.OrdinalIgnoreCase))
                return ResolveUrl("~/" + path);

            // 纯文件名（如 1.jpeg），补上 images/photo/
            return ResolveUrl("~/images/photo/" + path);
        }

        /// <summary>电话显示</summary>
        protected string FormatPhone(object phone, object mobile)
        {
            string p = (phone == null || Convert.IsDBNull(phone)) ? "" : phone.ToString().Trim();
            string m = (mobile == null || Convert.IsDBNull(mobile)) ? "" : mobile.ToString().Trim();
            if (string.IsNullOrEmpty(p) && string.IsNullOrEmpty(m)) return "-";
            if (string.IsNullOrEmpty(p)) return m;
            if (string.IsNullOrEmpty(m)) return p;
            return p + "/" + m;
        }

        /// <summary>角色名显示</summary>
        protected string GetRoleName(object userRoleId)
        {
            if (userRoleId == null || Convert.IsDBNull(userRoleId)) return "未设置";
            int id;
            if (!int.TryParse(userRoleId.ToString(), out id)) return "未设置";
            var role = GetAllRoles().Find(r => r.Id == id);
            return role != null ? role.Name : id.ToString();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid();
        }

        private void BindGrid()
        {
            _cachedRoles = null;
            GridView1.DataSource = UsersBLL.GetModelList("");
            GridView1.DataBind();
        }

        protected void GridView1_RowDataBound1(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            var user = e.Row.DataItem as Maticsoft.Model.Users;
            if (user == null) return;

            // 禁用/启用按钮显隐
            var lnkDisable = (LinkButton)e.Row.FindControl("LinkButton1");
            var lnkEnable = (LinkButton)e.Row.FindControl("LinkButton2");
            if (lnkDisable != null && lnkEnable != null)
            {
                lnkDisable.Visible = user.IsShow == 1;
                lnkEnable.Visible = user.IsShow != 1;
            }

            // 角色下拉绑定
            var ddl = (DropDownList)e.Row.FindControl("ddlRoles");
            if (ddl != null)
            {
                ddl.DataSource = GetAllRoles();
                ddl.DataBind();
                var item = ddl.Items.FindByValue(user.UserRoleld.ToString());
                if (item != null) ddl.SelectedValue = user.UserRoleld.ToString();
            }
        }

        // 禁用
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            int id = int.Parse(((LinkButton)sender).CommandArgument);
            var u = UsersBLL.GetModel(id);
            if (u != null) { u.IsShow = 0; UsersBLL.Update(u); }
            BindGrid();
        }

        // 启用
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            int id = int.Parse(((LinkButton)sender).CommandArgument);
            var u = UsersBLL.GetModel(id);
            if (u != null) { u.IsShow = 1; UsersBLL.Update(u); }
            BindGrid();
        }

        // 删除
        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            int id = int.Parse(((LinkButton)sender).CommandArgument);
            UsersBLL.Delete(id);
            BindGrid();
        }

        // 展开/折叠角色更改面板
        protected void lnkChangeRole_Click(object sender, EventArgs e)
        {
            var lnk = (LinkButton)sender;
            var row = (GridViewRow)lnk.NamingContainer;
            var pnl = (Panel)row.FindControl("pnlRole");
            if (pnl != null) pnl.Visible = !pnl.Visible;
        }

        // 确认更改角色
        protected void btnConfirmRole_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            int id = int.Parse(btn.CommandArgument);
            var row = (GridViewRow)btn.NamingContainer;
            var ddl = (DropDownList)row.FindControl("ddlRoles");
            if (ddl != null)
            {
                var u = UsersBLL.GetModel(id);
                if (u != null) { u.UserRoleld = int.Parse(ddl.SelectedValue); UsersBLL.Update(u); }
            }
            BindGrid();
        }

        // 取消更改角色
        protected void btnCancelRole_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            var row = (GridViewRow)btn.NamingContainer;
            var pnl = (Panel)row.FindControl("pnlRole");
            if (pnl != null) pnl.Visible = false;
        }

        // 点击更换头像
        protected void lnkChangePhoto_Click(object sender, EventArgs e)
        {
            int id = int.Parse(((LinkButton)sender).CommandArgument);
            hfPhotoUserId.Value = id.ToString();
            lblUploadUserId.Text = id.ToString();
            lblUploadMsg.Text = "";
            pnlUpload.Visible = true;
        }

        // 保存头像
        protected void btnSavePhoto_Click(object sender, EventArgs e)
        {
            int id;
            if (!int.TryParse(hfPhotoUserId.Value, out id)) { lblUploadMsg.Text = "ID无效"; return; }
            if (!FileUpload1.HasFile) { lblUploadMsg.Text = "请选图片"; return; }

            string ext = Path.GetExtension(FileUpload1.FileName).ToLower();
            if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".gif")
            { lblUploadMsg.Text = "仅jpg/png/gif"; return; }

            if (FileUpload1.FileBytes.Length > 2 * 1024 * 1024)
            { lblUploadMsg.Text = "≤2MB"; return; }

            string dir = Server.MapPath("~/images/photo/");
            if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);

            string fileName = "user_" + id + "_" + Guid.NewGuid().ToString("N").Substring(0, 8) + ext;
            FileUpload1.SaveAs(Path.Combine(dir, fileName));

            var u = UsersBLL.GetModel(id);
            if (u != null) { u.photo = "~/images/photo/" + fileName; UsersBLL.Update(u); }

            pnlUpload.Visible = false;
            BindGrid();
        }

        // 取消上传头像
        protected void btnCancelPhoto_Click(object sender, EventArgs e)
        {
            pnlUpload.Visible = false;
            lblUploadMsg.Text = "";
        }
    }
}
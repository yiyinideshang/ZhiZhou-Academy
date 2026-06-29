using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace Maticsoft.Web
{
    public partial class Site : System.Web.UI.MasterPage
    {
        public int CurrentCategoryId
        {
            get
            {
                int categoryId = 0;
                if (hfCategoryId.Value != null)
                {
                    int.TryParse(hfCategoryId.Value, out categoryId);
                }
                return categoryId;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            CheckLoginStatus();
        }
        private void LoadCategories()
        {
            Maticsoft.BLL.Categories categoriesBll = new Maticsoft.BLL.Categories();
            object dataSource = categoriesBll.GetModelList("");
        }
        private void CheckLoginStatus()
        {
            if (Session["UserId"] != null && Session["UserName"] != null)
            {
                pnlNotLogin.Visible = false;
                pnlLoggedIn.Visible = true;
                lblUserName.Text = Session["UserName"].ToString();
                string photoPath = Session["UserPhoto"] as string;
                if (string.IsNullOrEmpty(photoPath))
                {
                    imgAvatar.ImageUrl = "images/photo/default.png";
                }
                else
                {
                    imgAvatar.ImageUrl = photoPath;
                }
                int roleId = 0;
                if (Session["UserRoleId"] != null)
                {
                    int.TryParse(Session["UserRoleId"].ToString(), out roleId);
                }
                if (roleId == 5)
                {
                    lblAdminBadge.Visible = true;
                    lblVipBadge.Visible = false;
                    lblNormalBadge.Visible = false;
                    hlAdmin.NavigateUrl = "~/Admin/AdminDefault.aspx";
                    hlAdmin.Attributes.Remove("onclick");
                }
                else if (roleId == 2)
                {
                    lblAdminBadge.Visible = false;
                    lblVipBadge.Visible = true;
                    lblNormalBadge.Visible = false;
                    hlAdmin.Attributes["onclick"] = "return checkAdminAccess(event, false);";
                }
                else
                {
                    lblAdminBadge.Visible = false;
                    lblVipBadge.Visible = false;
                    lblNormalBadge.Visible = true;
                    hlAdmin.Attributes["onclick"] = "return checkAdminAccess(event, false);";
                }
            }
            else
            {
                pnlNotLogin.Visible = true;
                pnlLoggedIn.Visible = false;
                hlAdmin.Attributes["onclick"] = "alert('请先登录管理员账号！'); return false;";
            }
        }
        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}
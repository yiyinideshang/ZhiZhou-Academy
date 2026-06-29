using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.Admin
{
    public partial class Course_All_Mess : System.Web.UI.Page
    {
        BLL.Course CourseBLL = new BLL.Course();
        BLL.Categories CateBLL = new BLL.Categories();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void DetailsView1_DataBound(object sender, EventArgs e)
        {
            if (DetailsView1.CurrentMode != DetailsViewMode.ReadOnly)
                return;

            // 1. CategoryId → 分类名称
            string catIdText = DetailsView1.Rows[3].Cells[1].Text;
            int catId = int.Parse(catIdText);
            Model.Categories model = CateBLL.GetModel(catId);
            DetailsView1.Rows[3].Cells[1].Text = model.Name;

            // 2. IsShow 显示文本
            string isShow = DetailsView1.Rows[12].Cells[1].Text;
            DetailsView1.Rows[12].Cells[1].Text = (isShow == "1") ? "已上架" : "未上架";
        }

        protected void DetailsView1_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            Response.Write("<script>alert('更新成功！');window.opener.location=window.opener.location;</script>");
        }
    }
}
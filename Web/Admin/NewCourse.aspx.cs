using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.Admin
{
    public partial class NewCourse : System.Web.UI.Page
    {
        BLL.Course CourseBLL = new BLL.Course();
        BLL.Categories CateBLL = new BLL.Categories();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 绑定分类下拉框
                ddlCategory.DataSource = CateBLL.GetModelList("IsShow=1");
                ddlCategory.DataBind();
            }
        }

        // 保存课程
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string title = txtTitle.Text.Trim();
                // ====================== 1. 验证课程名称必填 ======================
                if (string.IsNullOrEmpty(title))
                {
                    Response.Write("<script>alert('请输入课程名称！');</script>");
                    return;
                }

                // ====================== 2. 验证课程名称不能重复（核心代码）======================
                var existList = CourseBLL.GetModelList("Title='" + title + "'");
                if (existList != null && existList.Count > 0)
                {
                    Response.Write("<script>alert('该课程名称已存在，请勿重复添加！');</script>");
                    return;
                }

                Model.Course model = new Model.Course();

                model.Title = title;
                model.Author = txtAuthor.Text.Trim();
                model.CategoryId = int.Parse(ddlCategory.SelectedValue);
                model.Price = decimal.Parse(txtPrice.Text.Trim());
                model.Duration = int.Parse(txtDuration.Text.Trim());

                if (!string.IsNullOrEmpty(txtStartDate.Text))
                {
                    model.StartDate = DateTime.Parse(txtStartDate.Text.Trim());
                }
                else
                {
                    model.StartDate = null;
                }

                model.ContentDescription = txtContent.Text.Trim();
                model.AurhorDescription = txtAuthorDesc.Text.Trim();
                model.TOC = txtTOC.Text.Trim();

                // 封面图（空→默认）
                if (string.IsNullOrEmpty(txtImg.Text.Trim()))
                {
                    model.beiyong = "../images/nono.png";
                }
                else
                {
                    model.beiyong = txtImg.Text.Trim();
                }

                model.Clicks = 0;
                model.Registration = 0;
                model.IsShow = 1;
                model.PublishDate = DateTime.Now;

                CourseBLL.Add(model);

                Response.Write("<script>alert('课程添加成功！');location.href='CourseList.aspx';</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('添加失败：" + ex.Message.Replace("'", "") + "')</script>");
            }
        }


    }
}
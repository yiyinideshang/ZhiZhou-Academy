using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.Admin
{
    public partial class OrderCourseList : System.Web.UI.Page
    {
        BLL.OrderCourse OrderCourseBLL = new BLL.OrderCourse();
        BLL.Course CourseBLL = new BLL.Course();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData("");
            }
        }

        private void BindData(string condition)
        {
            var data = OrderCourseBLL.GetModelList(condition);
            GridView1.DataSource = data;
            GridView1.DataBind();

            litTotalItems.Text = data.Count.ToString();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string field = cboField.SelectedValue;
            string keyword = txtKeyword.Text.Trim();
            if (!string.IsNullOrEmpty(keyword))
            {
                string where = field + " LIKE '%" + keyword + "%'";
                BindData(where);
            }
            else
            {
                BindData("");
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtKeyword.Text = "";
            BindData("");
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            btnSearch_Click(null, null);
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.setAttribute('data-original-bg', this.style.backgroundColor); this.style.backgroundColor='#e6f7ff'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor = this.getAttribute('data-original-bg') || ''");

                // 显示课程名称
                var litCourseName = e.Row.FindControl("litCourseName") as Literal;
                if (litCourseName != null)
                {
                    int courseId = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "CourseID"));
                    var course = CourseBLL.GetModel(courseId);
                    litCourseName.Text = course != null ? course.Title : "(课程不存在)";
                }
            }
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            int id = Convert.ToInt32(GridView1.DataKeys[gvr.RowIndex].Value);
            OrderCourseBLL.Delete(id);
            BindData("");
        }
    }
}

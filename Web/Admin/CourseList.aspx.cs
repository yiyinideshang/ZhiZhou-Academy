using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.Admin
{
    public partial class CourseList : System.Web.UI.Page
    {
        BLL.Course CourseBLL = new BLL.Course();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData("");
                LoadRecommendedBar();
            }
        }

        /// <summary>
        /// 通用绑定数据（带查询条件 + 空数据提示）
        /// 修复：不使用List，完全兼容你的原有项目
        /// </summary>
        private void BindData(string condition)
        {
            var data = CourseBLL.GetModelList(condition);
            ViewState["TotalCount"] = data.Count;
            GridView1.DataSource = data;
            GridView1.DataBind();

            // 根据GridView行数量判断是否有数据（绝对不报错）
            if (GridView1.Rows.Count == 0)
            {
                lblEmptyTip.Visible = true;
            }
            else
            {
                lblEmptyTip.Visible = false;
            }
        }

        /// <summary>
        /// 搜索按钮
        /// </summary>
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
            LoadRecommendedBar();
        }

        /// <summary>
        /// 重置按钮
        /// </summary>
        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtKeyword.Text = "";
            BindData("");
            LoadRecommendedBar();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            btnSearch_Click(null, null);
        }

        /// <summary>
        /// 光棒效果（和用户列表一致）
        /// </summary>
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.setAttribute('data-original-bg', this.style.backgroundColor); this.style.backgroundColor='#e6f7ff'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor = this.getAttribute('data-original-bg') || ''");
            }
            else if (e.Row.RowType == DataControlRowType.Pager)
            {
                GridView gv = sender as GridView;
                if (gv == null) return;
                int current = gv.PageIndex + 1;
                HighlightCurrentPage(e.Row.Cells[0], current.ToString());
            }
        }

        private void HighlightCurrentPage(Control parent, string pageText)
        {
            foreach (Control c in parent.Controls)
            {
                if (c.Controls.Count > 0)
                {
                    HighlightCurrentPage(c, pageText);
                    continue;
                }

                System.Web.UI.WebControls.Literal lit = c as System.Web.UI.WebControls.Literal;
                if (lit != null && lit.Text.Trim() == pageText)
                {
                    lit.Text = "<span style='color:Red;font-weight:bold;font-size:16px;'>" + pageText + "</span>";
                    return;
                }

                Label lbl = c as Label;
                if (lbl != null && lbl.Text.Trim() == pageText)
                {
                    lbl.ForeColor = System.Drawing.Color.Red;
                    lbl.Font.Bold = true;
                    lbl.Font.Size = FontUnit.Parse("16px");
                    return;
                }

                DataControlFieldCell cell = c as DataControlFieldCell;
                if (cell != null && cell.Text.Trim() == pageText)
                {
                    cell.Text = "<span style='color:Red;font-weight:bold;font-size:16px;'>" + pageText + "</span>";
                    return;
                }
            }
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            // 获取当前行索引
            GridViewRow gvr = (GridViewRow)((LinkButton)sender).NamingContainer;
            int rowIndex = gvr.RowIndex;

            
            int courseId = Convert.ToInt32(GridView1.DataKeys[rowIndex].Value);

            // 删除
            CourseBLL.Delete(courseId);

            // 刷新
            btnSearch_Click(null, null);
        }

        protected void imgBtnCourse_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton imgBtn = sender as ImageButton;
            int courseId = Convert.ToInt32(imgBtn.CommandArgument);
            Response.Write("<script>window.open('Course_All_Mess.aspx?bid=" + courseId + "','','height=900, width=740, top=50, left=700, toolbar=no, menubar=no, location=no, status=no')</script>");
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            LinkButton bt = (LinkButton)sender;
            GridViewRow gvr = (GridViewRow) bt.Parent.Parent;
            //Response.Redirect("Course_All_Mess.aspx?bid=" + gvr.Cells[0].Text);
            Response.Write("<script>window.open('Course_All_Mess.aspx?bid=" + gvr.Cells[0].Text + "','','height=900, width=740, top=50, left=700, toolbar=no, menubar=no, location=no, status=no')</script>");
        }

        /// <summary>
        /// 加载已推荐课程标签列表
        /// </summary>
        private void LoadRecommendedBar()
        {
            var list = CourseBLL.GetModelList("IsRecommended=1");
            if (list.Count > 0)
            {
                pnlRecommendedBar.Visible = true;
                rptRecommended.DataSource = list;
                rptRecommended.DataBind();
                lblNoRecommend.Visible = false;
            }
            else
            {
                pnlRecommendedBar.Visible = true;
                rptRecommended.DataSource = null;
                rptRecommended.DataBind();
                lblNoRecommend.Visible = true;
            }
        }

        /// <summary>
        /// 切换主编推荐状态
        /// </summary>
        protected void rptRecommended_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "CancelRecommend")
            {
                int courseId = Convert.ToInt32(e.CommandArgument);
                var model = CourseBLL.GetModel(courseId);
                if (model != null)
                {
                    model.IsRecommended = 0; // 取消推荐
                    CourseBLL.Update(model);
                }
                BindData("");
                LoadRecommendedBar();
            }
        }

        protected void lnkRecommend_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int courseId = Convert.ToInt32(btn.CommandArgument);
            var model = CourseBLL.GetModel(courseId);
            if (model != null)
            {
                model.IsRecommended = (model.IsRecommended == 1) ? 0 : 1;
                CourseBLL.Update(model);
            }
            BindData("");
            LoadRecommendedBar();
        }
    }
}
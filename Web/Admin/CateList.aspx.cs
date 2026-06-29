using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace Maticsoft.Web.Admin
{
    public partial class CateList : System.Web.UI.Page
    {
        BLL.Categories CateBLL = new BLL.Categories();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindList();
            }
        }

        private void BindList()
        {
            var data = CateBLL.GetModelList("");
            GridView1.DataSource = data;
            GridView1.DataBind();
            lblEmptyTip.Visible = GridView1.Rows.Count == 0;
        }

        // ====================== 添加分类（带重复判断）======================
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string name = txtCateName.Text.Trim();

            if (string.IsNullOrEmpty(name))
            {
                Response.Write("<script>alert('请输入分类名称！')</script>");
                return;
            }

            // 检查是否重复
            var existList = CateBLL.GetModelList("Name='" + name + "'");
            if (existList != null && existList.Count > 0)
            {
                Response.Write("<script>alert('该分类已存在，请勿重复添加！')</script>");
                return;
            }

            Model.Categories model = new Model.Categories();
            model.Name = name;
            model.IsShow = 1;
            model.beiyong = "";
            CateBLL.Add(model);

            txtCateName.Text = "";
            BindList();
            Response.Write("<script>alert('分类添加成功！')</script>");
        }

        // 禁用
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            LinkButton jinyong = (LinkButton)sender;
            GridViewRow gvr = (GridViewRow)jinyong.Parent.Parent;
            int id = Convert.ToInt32(GridView1.DataKeys[gvr.RowIndex].Value);

            Model.Categories model = CateBLL.GetModel(id);
            model.IsShow = 0;
            CateBLL.Update(model);
            BindList();
        }

        // 启用
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            LinkButton qiyong = (LinkButton)sender;
            GridViewRow gvr = (GridViewRow)qiyong.Parent.Parent;
            int id = Convert.ToInt32(GridView1.DataKeys[gvr.RowIndex].Value);

            Model.Categories model = CateBLL.GetModel(id);
            model.IsShow = 1;
            CateBLL.Update(model);
            BindList();
        }

        // 删除
        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((LinkButton)sender).NamingContainer;
            int id = Convert.ToInt32(GridView1.DataKeys[gvr.RowIndex].Value);
            CateBLL.Delete(id);
            BindList();
        }

        // 行绑定
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int id = Convert.ToInt32(GridView1.DataKeys[e.Row.RowIndex].Value);
                Model.Categories model = CateBLL.GetModel(id);

                LinkButton btnDisable = (LinkButton)e.Row.FindControl("LinkButton1");
                LinkButton btnEnable = (LinkButton)e.Row.FindControl("LinkButton2");

                if (model.IsShow == 1)
                {
                    btnDisable.Visible = true;
                    btnEnable.Visible = false;
                }
                else
                {
                    btnDisable.Visible = false;
                    btnEnable.Visible = true;
                }

                // 光棒效果
                e.Row.Attributes.Add("onmouseover", "this.setAttribute('data-original-bg', this.style.backgroundColor); this.style.backgroundColor='#e6f7ff'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor = this.getAttribute('data-original-bg') || ''");
            }
        }
    }
}
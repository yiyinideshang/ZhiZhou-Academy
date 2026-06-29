using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.Admin
{
    public partial class OrdersList : System.Web.UI.Page
    {
        BLL.Orders OrdersBLL = new BLL.Orders();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData("");
            }
        }

        private void BindData(string condition)
        {
            var data = OrdersBLL.GetModelList(condition);
            GridView1.DataSource = data;
            GridView1.DataBind();

            // 统计
            litTotalOrders.Text = data.Count.ToString();
            decimal total = 0;
            foreach (var order in data)
            {
                total += order.TotalPirce;
            }
            litTotalAmount.Text = total.ToString("N2");
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
            }
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            int orderId = Convert.ToInt32(GridView1.DataKeys[gvr.RowIndex].Value);
            OrdersBLL.Delete(orderId);
            BindData("");
        }
    }
}

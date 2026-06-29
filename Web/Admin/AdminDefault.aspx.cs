using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.Admin
{
    public partial class AdminDefault : System.Web.UI.Page
    {
        BLL.Course CourseBLL = new BLL.Course();
        BLL.Users UsersBLL = new BLL.Users();
        BLL.Orders OrdersBLL = new BLL.Orders();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                litCourseCount.Text = CourseBLL.GetModelList("").Count.ToString();
                litUserCount.Text = UsersBLL.GetModelList("").Count.ToString();
                litOrderCount.Text = OrdersBLL.GetModelList("").Count.ToString();
            }
        }
    }
}
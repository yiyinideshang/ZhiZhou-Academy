using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web
{
    public partial class Teacher : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTeachers();
            }
        }

        private void LoadTeachers()
        {
            Maticsoft.BLL.Author authorBll = new Maticsoft.BLL.Author();
            rptTeachers.DataSource = authorBll.GetModelList("");
            rptTeachers.DataBind();
        }

        public List<Maticsoft.Model.Course> GetTeacherCourses(int authorId)
        {
            Maticsoft.BLL.Course courseBll = new Maticsoft.BLL.Course();
            return courseBll.GetModelList("Author = '" + authorId + "'");
        }
    }
}

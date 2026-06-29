using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web
{
    public partial class Home1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadHotCourses();
            }
        }

        private void LoadHotCourses()
        {
            Maticsoft.BLL.Course courseBll = new Maticsoft.BLL.Course();
            List<Maticsoft.Model.Course> courses = courseBll.GetModelList("IsRecommended=1"); // 查询主编推荐的课程

            Maticsoft.BLL.CourseRatings ratingBll = new Maticsoft.BLL.CourseRatings();
            Maticsoft.BLL.ReaderComments commentBll = new Maticsoft.BLL.ReaderComments();

            DataTable dt = new DataTable();
            dt.Columns.Add("Id", typeof(int));
            dt.Columns.Add("Title", typeof(string));
            dt.Columns.Add("CategoryId", typeof(int));
            dt.Columns.Add("Duration", typeof(int));
            dt.Columns.Add("Price", typeof(decimal));
            dt.Columns.Add("beiyong", typeof(string));
            dt.Columns.Add("AvgRating", typeof(double));
            dt.Columns.Add("CommentCount", typeof(int));
            dt.Columns.Add("ContentDescription", typeof(string));
            dt.Columns.Add("ImageUrl", typeof(string));
            dt.Columns.Add("ShortDescription", typeof(string));

            int count = 0;
            foreach (var c in courses)
            {
                if (count >= 6) break;

                DataRow dr = dt.NewRow();
                dr["Id"] = c.Id;
                dr["Title"] = c.Title ?? "";
                dr["CategoryId"] = c.CategoryId;
                dr["Duration"] = c.Duration ?? 0;
                dr["Price"] = c.Price ?? 0;
                dr["beiyong"] = c.beiyong ?? "";

                string contentDesc = c.ContentDescription ?? "";
                dr["ContentDescription"] = contentDesc;

                if (contentDesc.Length > 50)
                {
                    dr["ShortDescription"] = contentDesc.Substring(0, 50) + "...";
                }
                else
                {
                    dr["ShortDescription"] = contentDesc;
                }

                string imgUrl = "Admin/images/nono.png";
                if (!string.IsNullOrEmpty(c.beiyong))
                {
                    if (c.beiyong.Contains("../"))
                    {
                        imgUrl = c.beiyong.Replace("../", "");
                    }
                    else
                    {
                        imgUrl = "Admin/Courseimg/" + c.beiyong;
                    }
                }
                dr["ImageUrl"] = imgUrl;

                int ratingCount = ratingBll.GetRecordCount("CourseId = " + c.Id);
                if (ratingCount > 0)
                {
                    var ratings = ratingBll.GetModelList("CourseId = " + c.Id);
                    double sum = 0;
                    foreach (var r in ratings) sum += r.Rating;
                    dr["AvgRating"] = Math.Round(sum / ratingCount, 1);
                }
                else
                {
                    dr["AvgRating"] = 0.0;
                }

                dr["CommentCount"] = commentBll.GetRecordCount("CourseId = " + c.Id);
                dt.Rows.Add(dr);
                count++;
            }

            rptHotCourses.DataSource = dt;
            rptHotCourses.DataBind();
        }

        public string GetMusicPlaylistJson()
        {
            #region
            var musicFiles = new[]
            {
                new { name = "艾比利 - 一个人想着一个人", artist = "艾比利", url = "music/艾比利 - 一个人想着一个人 (说唱版).mp3", cover = "music/cover/艾比利-一个人想着一个人.jpg", lrcFile = "music/lyrics/艾比利 - 一个人想着一个人.lrc" },
                new { name = "周传雄-男人海洋", artist = "周传雄", url = "music/周传雄-男人海洋.mp3", cover = "music/cover/周传雄-男人海洋.jpg", lrcFile = "music/lyrics/周传雄-男人海洋.lrc" },
                new { name = "王大毛-去年夏天", artist = "王大毛", url = "music/王大毛-去年夏天.mp3", cover = "music/cover/王大毛-去年夏天.jpg", lrcFile = "music/lyrics/王大毛-去年夏天.lrc" },
                new { name = "Everything Goes On", artist = "Porter Robinson", url = "music/Porter Robinson - Everything Goes On.mp3", cover = "music/cover/Everything Goes On.jpg", lrcFile = "music/lyrics/Porter Robinson - Everything Goes On.lrc" }

                //Porter Robinson - Everything Goes On
            };

            var audioItems = new List<string>();
            foreach (var music in musicFiles)
            {
                string lrcContent = "";
                try
                {
                    string lrcPath = Server.MapPath("~/" + music.lrcFile);
                    if (System.IO.File.Exists(lrcPath))
                    {
                        lrcContent = System.IO.File.ReadAllText(lrcPath).Replace("\\", "\\\\").Replace("\"", "\\\"").Replace("\r", "").Replace("\n", "\\n");
                    }
                }
                catch
                {
                    lrcContent = "";
                }

                audioItems.Add(string.Format(
                    "{{name:\"{0}\",artist:\"{1}\",url:\"{2}\",cover:\"{3}\",lrc:\"{4}\"}}",
                    music.name.Replace("\"", "\\\""),
                    music.artist.Replace("\"", "\\\""),
                    music.url,
                    music.cover,
                    lrcContent
                ));
            }

            return "[" + string.Join(",", audioItems.ToArray()) + "]";
            #endregion
        }
    }
}

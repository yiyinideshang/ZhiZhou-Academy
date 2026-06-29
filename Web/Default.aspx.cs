using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web
{
    public partial class Default : System.Web.UI.Page
    {
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl courseList;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl courseDetailPanel;
        protected global::System.Web.UI.WebControls.Image imgDetail;
        protected global::System.Web.UI.WebControls.Label lblDetailTitle;
        protected global::System.Web.UI.WebControls.Label lblDetailDuration;
        protected global::System.Web.UI.WebControls.Label lblDetailPrice;
        protected global::System.Web.UI.WebControls.Label lblDetailDesc;
        protected global::System.Web.UI.WebControls.Label lblDetailAvgRating;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl detailStars;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl detailCommentCount;
        protected global::System.Web.UI.WebControls.Button btnAddCart;
        protected global::System.Web.UI.WebControls.Button btnFavorite;
        protected global::System.Web.UI.WebControls.Button btnPurchase;
        protected global::System.Web.UI.WebControls.Label lblActionMsg;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl ratingSection;
        protected global::System.Web.UI.WebControls.HiddenField hfSelectedRating;
        protected global::System.Web.UI.WebControls.Button btnSubmitRating;
        protected global::System.Web.UI.WebControls.Label lblRatingMsg;
        protected global::System.Web.UI.WebControls.Repeater rptCategoriesLeft;
        protected global::System.Web.UI.WebControls.Repeater rptCategoriesRight;
        protected global::System.Web.UI.WebControls.Repeater rptCourses;
        protected global::System.Web.UI.WebControls.Repeater rptComments;
        protected global::System.Web.UI.WebControls.Label lblNoComments;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl commentInputArea;
        protected global::System.Web.UI.HtmlControls.HtmlTextArea txtComment;
        protected global::System.Web.UI.WebControls.Button btnSubmitComment;
        protected global::System.Web.UI.WebControls.Label lblCommentMsg;
        protected global::System.Web.UI.WebControls.Repeater rptPurchaseReviews;
        protected global::System.Web.UI.WebControls.Label lblNoPurchaseReviews;
        protected global::System.Web.UI.HtmlControls.HtmlInputText txtRatingTitle;
        protected global::System.Web.UI.HtmlControls.HtmlTextArea txtRatingComment;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl purchaseReviewInputArea;
        protected global::System.Web.UI.WebControls.Label lblPurchaseReviewMsg;
        protected global::System.Web.UI.WebControls.Button btnSubmitPurchaseReview;
        protected global::System.Web.UI.HtmlControls.HtmlInputText txtCommentTitle;
        protected global::System.Web.UI.WebControls.HiddenField hfActiveCommentTab;

        private int _currentCourseId = 0;
        private string _currentFilter = "all"; // "all" or "recommended"

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                string idStr = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out _currentCourseId))
                {
                    LoadCourseDetail(_currentCourseId);
                }
                else
                {
                    Site masterPage = this.Master as Site;
                    int categoryId = 0;
                    if (masterPage != null)
                    {
                        categoryId = masterPage.CurrentCategoryId;
                    }
                    LoadCourses(categoryId);
                }
            }
            else
            {
                string idStr = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(idStr))
                {
                    int.TryParse(idStr, out _currentCourseId);
                }
            }
        }

        private void LoadCategories()
        {
            Maticsoft.BLL.Categories categoriesBll = new Maticsoft.BLL.Categories();
            object dataSource = categoriesBll.GetModelList("");
            rptCategoriesLeft.DataSource = dataSource;
            rptCategoriesLeft.DataBind();
            rptCategoriesRight.DataSource = dataSource;
            rptCategoriesRight.DataBind();
        }

        private void LoadCourses(int categoryId)
        {
            Maticsoft.BLL.Course courseBll = new Maticsoft.BLL.Course();
            string where = "";
            if (categoryId > 0)
            {
                where = "CategoryId = " + categoryId.ToString();
            }
            if (_currentFilter == "recommended")
            {
                if (!string.IsNullOrEmpty(where)) where += " AND ";
                where += "IsRecommended=1";
            }
            List<Maticsoft.Model.Course> courses = courseBll.GetModelList(where);
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
            dt.Columns.Add("PurchaseReviewCount", typeof(int));
            dt.Columns.Add("IsRecommended", typeof(int));

            foreach (var c in courses)
            {
                DataRow dr = dt.NewRow();
                dr["Id"] = c.Id;
                dr["Title"] = c.Title ?? "";
                dr["CategoryId"] = c.CategoryId;
                dr["Duration"] = c.Duration ?? 0;
                dr["Price"] = c.Price ?? 0;
                dr["beiyong"] = c.beiyong ?? "";
                dr["IsRecommended"] = c.IsRecommended;

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
                dr["PurchaseReviewCount"] = ratingBll.GetRecordCount("CourseId = " + c.Id + " AND IsShow = 1");
                dt.Rows.Add(dr);
            }

            rptCourses.DataSource = dt;
            rptCourses.DataBind();
        }

        protected void rptCourses_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
        }

        private void LoadCourseDetail(int courseId)
        {
            Maticsoft.BLL.Course courseBll = new Maticsoft.BLL.Course();
            Maticsoft.Model.Course course = courseBll.GetModel(courseId);

            if (course == null)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            lblDetailTitle.Text = course.Title;
            lblDetailDuration.Text = (course.Duration ?? 0) + "课时";
            lblDetailPrice.Text = course.Price.ToString();
            lblDetailDesc.Text = string.IsNullOrEmpty(course.ContentDescription) ? "暂无课程介绍" : course.ContentDescription;

            List<string> tags = new List<string>();
            tags.Add("热门");
            if (course.IsRecommended == 1)
            {
                tags.Add("主编推荐");
            }
            if (tags.Count > 0)
            {
                lblDetailTags.Text = string.Join(" / ", tags.ToArray());
                pnlDetailTags.Visible = true;
            }
            else
            {
                pnlDetailTags.Visible = false;
            }

            if (!string.IsNullOrEmpty(course.beiyong))
            {
                imgDetail.ImageUrl = course.beiyong.Contains("../")
                    ? course.beiyong.Replace("../", "")
                    : "Admin/Courseimg/" + course.beiyong;
            }
            else
            {
                imgDetail.ImageUrl = "Admin/images/nono.png";
            }

            Maticsoft.BLL.CourseRatings ratingBll = new Maticsoft.BLL.CourseRatings();
            Maticsoft.BLL.ReaderComments commentBll = new Maticsoft.BLL.ReaderComments();

            int ratingCount = ratingBll.GetRecordCount("CourseId = " + courseId);
            double avgRating = 0;
            if (ratingCount > 0)
            {
                var ratings = ratingBll.GetModelList("CourseId = " + courseId);
                double sum = 0;
                foreach (var r in ratings) sum += r.Rating;
                avgRating = Math.Round(sum / ratingCount, 1);
            }
            lblDetailAvgRating.Text = avgRating > 0 ? avgRating.ToString("0.0") + "分" : "暂无评分";

            int fullStars = (int)Math.Floor(avgRating);
            string starsHtml = "";
            for (int i = 1; i <= 5; i++)
            {
                if (i <= fullStars)
                    starsHtml += "★";
                else
                    starsHtml += "<span class=\"empty\">★</span>";
            }
            detailStars.InnerHtml = starsHtml;

            int commentCount = commentBll.GetRecordCount("CourseId = " + courseId);
            detailCommentCount.InnerHtml = commentCount + "条评论";

            int? userId = GetCurrentUser();
            if (userId.HasValue)
            {
                Maticsoft.BLL.Cart cartBll = new Maticsoft.BLL.Cart();
                int cartCount = cartBll.GetRecordCount("UserId = " + userId.Value + " AND CourseId = " + courseId);
                if (cartCount > 0)
                {
                    btnAddCart.Text = "已在购物车";
                    btnAddCart.CssClass = "action-btn btn-in-cart";
                    btnAddCart.Enabled = false;
                }

                Maticsoft.BLL.Favorite favBll = new Maticsoft.BLL.Favorite();
                int favCount = favBll.GetRecordCount("UserId = " + userId.Value + " AND CourseId = " + courseId);
                if (favCount > 0)
                {
                    btnFavorite.Text = "已收藏";
                    btnFavorite.CssClass = "action-btn btn-favorited";
                }

                bool purchased = IsUserPurchasedCourse(userId.Value, courseId);
                if (purchased)
                {
                    btnPurchase.Text = "已购买";
                    btnPurchase.CssClass = "action-btn btn-purchased";
                    btnPurchase.Enabled = false;
                    btnAddCart.Text = "已购买";
                    btnAddCart.CssClass = "action-btn btn-purchased";
                    btnAddCart.Enabled = false;
                    ratingSection.Visible = true;
                    purchaseReviewInputArea.Visible = true;

                    int myRatingCount = ratingBll.GetRecordCount("CourseId = " + courseId + " AND UserId = " + userId.Value);
                    if (myRatingCount > 0)
                    {
                        var myRatings = ratingBll.GetModelList("CourseId = " + courseId + " AND UserId = " + userId.Value);
                        int myRating = myRatings[0].Rating;
                        hfSelectedRating.Value = myRating.ToString();
                    }
                }
                else
                {
                    ratingSection.Visible = false;
                    purchaseReviewInputArea.Visible = false;
                }
            }
            else
            {
                ratingSection.Visible = false;
                purchaseReviewInputArea.Visible = false;
            }

            courseList.Style["display"] = "none";
            courseDetailPanel.Style["display"] = "block";

            LoadPurchaseReviews(courseId);
            LoadComments(courseId, userId);
        }

        private void LoadPurchaseReviews(int courseId)
        {
            Maticsoft.BLL.CourseRatings ratingBll = new Maticsoft.BLL.CourseRatings();
            Maticsoft.BLL.Users userBll = new Maticsoft.BLL.Users();

            var ratings = ratingBll.GetModelList("CourseId = " + courseId + " AND IsShow = 1");

            if (ratings.Count == 0)
            {
                lblNoPurchaseReviews.Visible = true;
                rptPurchaseReviews.DataSource = null;
                rptPurchaseReviews.DataBind();
                return;
            }

            lblNoPurchaseReviews.Visible = false;
            DataTable dt = new DataTable();
            dt.Columns.Add("UserName", typeof(string));
            dt.Columns.Add("Rating", typeof(int));
            dt.Columns.Add("StarsHtml", typeof(string));
            dt.Columns.Add("Title", typeof(string));
            dt.Columns.Add("Comment", typeof(string));
            dt.Columns.Add("Date", typeof(DateTime));

            foreach (var r in ratings)
            {
                string userName = "匿名用户";
                var user = userBll.GetModel(r.UserId);
                if (user != null && !string.IsNullOrEmpty(user.Name))
                    userName = user.Name;
                else if (user != null && !string.IsNullOrEmpty(user.LoginId))
                    userName = user.LoginId;

                int fullStars = r.Rating;
                string starsHtml = "";
                for (int i = 1; i <= 5; i++)
                {
                    if (i <= fullStars)
                        starsHtml += "★";
                    else
                        starsHtml += "<span class=\"empty\">★</span>";
                }

                DataRow dr = dt.NewRow();
                dr["UserName"] = userName;
                dr["Rating"] = r.Rating;
                dr["StarsHtml"] = starsHtml;
                dr["Title"] = r.Title ?? "";
                dr["Comment"] = r.Comment ?? "";
                dr["Date"] = r.Date ?? DateTime.Now;
                dt.Rows.Add(dr);
            }

            rptPurchaseReviews.DataSource = dt;
            rptPurchaseReviews.DataBind();
        }

        private void LoadComments(int courseId, int? userId)
        {
            Maticsoft.BLL.ReaderComments commentBll = new Maticsoft.BLL.ReaderComments();
            Maticsoft.BLL.Users userBll = new Maticsoft.BLL.Users();

            var comments = commentBll.GetModelList("CourseId = " + courseId + " AND IsShow = 1");

            if (comments.Count == 0)
            {
                lblNoComments.Visible = true;
                rptComments.DataSource = null;
                rptComments.DataBind();
            }
            else
            {
                lblNoComments.Visible = false;
                DataTable dt = new DataTable();
                dt.Columns.Add("UserName", typeof(string));
                dt.Columns.Add("Title", typeof(string));
                dt.Columns.Add("Comment", typeof(string));
                dt.Columns.Add("Date", typeof(DateTime));

                foreach (var c in comments)
                {
                    string userName = "匿名用户";
                    var user = userBll.GetModel(c.UserId);
                    if (user != null && !string.IsNullOrEmpty(user.Name))
                        userName = user.Name;
                    else if (user != null && !string.IsNullOrEmpty(user.LoginId))
                        userName = user.LoginId;

                    DataRow dr = dt.NewRow();
                    dr["UserName"] = userName;
                    dr["Title"] = c.Title ?? "";
                    dr["Comment"] = c.Comment ?? "";
                    dr["Date"] = c.Date;
                    dt.Rows.Add(dr);
                }

                rptComments.DataSource = dt;
                rptComments.DataBind();
            }

            if (userId.HasValue)
            {
                commentInputArea.Visible = true;
            }
            else
            {
                commentInputArea.Visible = false;
            }
        }

        private int? GetCurrentUser()
        {
            if (Session["UserId"] != null)
            {
                int uid;
                if (int.TryParse(Session["UserId"].ToString(), out uid))
                    return uid;
            }
            return null;
        }

        private bool IsUserPurchasedCourse(int userId, int courseId)
        {
            Maticsoft.BLL.OrderCourse ocBll = new Maticsoft.BLL.OrderCourse();
            Maticsoft.BLL.Orders orderBll = new Maticsoft.BLL.Orders();
            var orderCourses = ocBll.GetModelList("CourseID = " + courseId);
            foreach (var oc in orderCourses)
            {
                var order = orderBll.GetModel(oc.OrderID);
                if (order != null && order.UserId == userId)
                    return true;
            }
            return false;
        }

        protected void btnAddCart_Click(object sender, EventArgs e)
        {
            int? userId = GetCurrentUser();
            if (!userId.HasValue)
            {
                lblActionMsg.Text = "请先登录后再操作！";
                return;
            }
            if (_currentCourseId <= 0) return;

            Maticsoft.BLL.Cart cartBll = new Maticsoft.BLL.Cart();
            int existCount = cartBll.GetRecordCount("UserId = " + userId.Value + " AND CourseId = " + _currentCourseId);
            if (existCount > 0)
            {
                lblActionMsg.Text = "该课程已在购物车中！";
                return;
            }

            Maticsoft.Model.Cart cart = new Maticsoft.Model.Cart();
            cart.UserId = userId.Value;
            cart.CourseId = _currentCourseId;
            cartBll.Add(cart);

            lblActionMsg.Text = "已成功加入购物车！";
            btnAddCart.Text = "已在购物车";
            btnAddCart.CssClass = "action-btn btn-in-cart";
            btnAddCart.Enabled = false;
        }

        protected void btnFavorite_Click(object sender, EventArgs e)
        {
            int? userId = GetCurrentUser();
            if (!userId.HasValue)
            {
                lblActionMsg.Text = "请先登录后再操作！";
                return;
            }
            if (_currentCourseId <= 0) return;

            Maticsoft.BLL.Favorite favBll = new Maticsoft.BLL.Favorite();
            int existCount = favBll.GetRecordCount("UserId = " + userId.Value + " AND CourseId = " + _currentCourseId);

            if (existCount > 0)
            {
                var favs = favBll.GetModelList("UserId = " + userId.Value + " AND CourseId = " + _currentCourseId);
                foreach (var f in favs)
                {
                    favBll.Delete(f.Id);
                }
                lblActionMsg.Text = "已取消收藏！";
                btnFavorite.Text = "收藏";
                btnFavorite.CssClass = "action-btn btn-favorite";
            }
            else
            {
                Maticsoft.Model.Favorite fav = new Maticsoft.Model.Favorite();
                fav.UserId = userId.Value;
                fav.CourseId = _currentCourseId;
                fav.AddTime = DateTime.Now;
                favBll.Add(fav);

                lblActionMsg.Text = "已成功收藏！";
                btnFavorite.Text = "已收藏";
                btnFavorite.CssClass = "action-btn btn-favorited";
            }
        }

        protected void btnPurchase_Click(object sender, EventArgs e)
        {
            int? userId = GetCurrentUser();
            if (!userId.HasValue)
            {
                lblActionMsg.Text = "请先登录后再购买！";
                return;
            }
            if (_currentCourseId <= 0) return;

            if (IsUserPurchasedCourse(userId.Value, _currentCourseId))
            {
                lblActionMsg.Text = "您已购买过该课程！";
                return;
            }

            Maticsoft.BLL.Course courseBll = new Maticsoft.BLL.Course();
            Maticsoft.Model.Course course = courseBll.GetModel(_currentCourseId);
            if (course == null) return;

            Maticsoft.BLL.Orders orderBll = new Maticsoft.BLL.Orders();
            Maticsoft.Model.Orders order = new Maticsoft.Model.Orders();
            order.Id = orderBll.GetMaxId();
            order.OrderDate = DateTime.Now;
            order.UserId = userId.Value;
            order.TotalPirce = course.Price ?? 0;
            order.beiyong = "";
            bool orderAdded = orderBll.Add(order);

            if (orderAdded)
            {
                int maxOrderId = order.Id;
                Maticsoft.BLL.OrderCourse ocBll = new Maticsoft.BLL.OrderCourse();
                Maticsoft.Model.OrderCourse oc = new Maticsoft.Model.OrderCourse();
                oc.OrderID = maxOrderId;
                oc.CourseID = _currentCourseId;
                oc.beiyong1 = "";
                oc.beiyong2 = "";
                ocBll.Add(oc);

                Maticsoft.BLL.Cart cartBll = new Maticsoft.BLL.Cart();
                var cartItems = cartBll.GetModelList("UserId = " + userId.Value + " AND CourseId = " + _currentCourseId);
                foreach (var ci in cartItems)
                {
                    cartBll.Delete(ci.Id);
                }

                lblActionMsg.Text = "购买成功！";
                btnPurchase.Text = "已购买";
                btnPurchase.CssClass = "action-btn btn-purchased";
                btnPurchase.Enabled = false;
                btnAddCart.Text = "已在购物车";
                btnAddCart.CssClass = "action-btn btn-in-cart";
                btnAddCart.Enabled = false;
                ratingSection.Visible = true;
                LoadCourseDetail(_currentCourseId);
            }
            else
            {
                lblActionMsg.Text = "购买失败，请重试！";
            }
        }

        protected void btnShowAll_Click(object sender, EventArgs e)
        {
            _currentFilter = "all";
            btnShowAll.CssClass = "filter-btn active";
            btnShowRecommended.CssClass = "filter-btn";
            Site masterPage = this.Master as Site;
            int categoryId = masterPage != null ? masterPage.CurrentCategoryId : 0;
            LoadCourses(categoryId);
        }

        protected void btnShowRecommended_Click(object sender, EventArgs e)
        {
            _currentFilter = "recommended";
            btnShowAll.CssClass = "filter-btn";
            btnShowRecommended.CssClass = "filter-btn active";
            Site masterPage = this.Master as Site;
            int categoryId = masterPage != null ? masterPage.CurrentCategoryId : 0;
            LoadCourses(categoryId);
        }

        protected void btnSubmitRating_Click(object sender, EventArgs e)
        {
            int? userId = GetCurrentUser();
            if (!userId.HasValue)
            {
                lblRatingMsg.Text = "请先登录后再评分！";
                return;
            }
            if (_currentCourseId <= 0) return;

            if (!IsUserPurchasedCourse(userId.Value, _currentCourseId))
            {
                lblRatingMsg.Text = "只有购买过该课程的用户才能评分！";
                return;
            }

            int rating = 0;
            int.TryParse(hfSelectedRating.Value, out rating);
            if (rating < 1 || rating > 5)
            {
                lblRatingMsg.Text = "请选择1-5星评分！";
                return;
            }

            Maticsoft.BLL.CourseRatings ratingBll = new Maticsoft.BLL.CourseRatings();
            int existCount = ratingBll.GetRecordCount("CourseId = " + _currentCourseId + " AND UserId = " + userId.Value);

            if (existCount > 0)
            {
                var existRatings = ratingBll.GetModelList("CourseId = " + _currentCourseId + " AND UserId = " + userId.Value);
                foreach (var er in existRatings)
                {
                    er.Rating = rating;
                    ratingBll.Update(er);
                }
                lblRatingMsg.Text = "评分已更新为" + rating + "星！";
            }
            else
            {
                Maticsoft.Model.CourseRatings cr = new Maticsoft.Model.CourseRatings();
                cr.CourseId = _currentCourseId;
                cr.UserId = userId.Value;
                cr.Rating = rating;
                cr.Comment = "";
                cr.Title = "";
                cr.Date = DateTime.Now;
                cr.IsShow = 1;
                cr.beiyong = "";
                ratingBll.Add(cr);
                lblRatingMsg.Text = "评分成功：" + rating + "星！";
            }

            LoadCourseDetail(_currentCourseId);
        }

        protected void btnSubmitPurchaseReview_Click(object sender, EventArgs e)
        {
            int? userId = GetCurrentUser();
            if (!userId.HasValue)
            {
                lblPurchaseReviewMsg.Text = "请先登录后再评论！";
                return;
            }
            if (_currentCourseId <= 0) return;

            if (!IsUserPurchasedCourse(userId.Value, _currentCourseId))
            {
                lblPurchaseReviewMsg.Text = "只有购买过该课程的用户才能发表购买评论！";
                return;
            }

            string ratingTitle = txtRatingTitle.Value != null ? txtRatingTitle.Value.Trim() : "";
            string ratingComment = txtRatingComment.Value != null ? txtRatingComment.Value.Trim() : "";
            if (string.IsNullOrEmpty(ratingTitle) && string.IsNullOrEmpty(ratingComment))
            {
                lblPurchaseReviewMsg.Text = "请输入评价标题或评价内容！";
                return;
            }

            Maticsoft.BLL.CourseRatings ratingBll = new Maticsoft.BLL.CourseRatings();
            int existCount = ratingBll.GetRecordCount("CourseId = " + _currentCourseId + " AND UserId = " + userId.Value);

            if (existCount > 0)
            {
                var existRatings = ratingBll.GetModelList("CourseId = " + _currentCourseId + " AND UserId = " + userId.Value);
                foreach (var er in existRatings)
                {
                    er.Title = ratingTitle;
                    er.Comment = ratingComment;
                    er.Date = DateTime.Now;
                    ratingBll.Update(er);
                }
                lblPurchaseReviewMsg.Text = "购买评论已更新！";
            }
            else
            {
                Maticsoft.Model.CourseRatings cr = new Maticsoft.Model.CourseRatings();
                cr.CourseId = _currentCourseId;
                cr.UserId = userId.Value;
                cr.Rating = 0;
                cr.Title = ratingTitle;
                cr.Comment = ratingComment;
                cr.Date = DateTime.Now;
                cr.IsShow = 1;
                cr.beiyong = "";
                ratingBll.Add(cr);
                lblPurchaseReviewMsg.Text = "购买评论提交成功！";
            }

            txtRatingTitle.Value = "";
            txtRatingComment.Value = "";
            LoadCourseDetail(_currentCourseId);
        }

        protected void btnSubmitComment_Click(object sender, EventArgs e)
        {
            int? userId = GetCurrentUser();
            if (!userId.HasValue)
            {
                lblCommentMsg.Text = "请先登录后再评论！";
                return;
            }
            if (_currentCourseId <= 0) return;

            string commentTitle = txtCommentTitle.Value != null ? txtCommentTitle.Value.Trim() : "";
            string commentText = txtComment.Value != null ? txtComment.Value.Trim() : "";
            if (string.IsNullOrEmpty(commentText))
            {
                lblCommentMsg.Text = "请输入评论内容！";
                return;
            }

            Maticsoft.BLL.ReaderComments commentBll = new Maticsoft.BLL.ReaderComments();
            Maticsoft.Model.ReaderComments comment = new Maticsoft.Model.ReaderComments();
            comment.CourseId = _currentCourseId;
            comment.UserId = userId.Value;
            comment.Title = commentTitle;
            comment.Comment = commentText;
            comment.Date = DateTime.Now;
            comment.IsShow = 1;
            comment.beiyong = "";
            commentBll.Add(comment);

            lblCommentMsg.Text = "评论成功！";
            txtCommentTitle.Value = "";
            txtComment.Value = "";
            LoadCourseDetail(_currentCourseId);
        }
    }
}

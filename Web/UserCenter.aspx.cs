using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web
{
    public partial class UserCenter : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.Panel pnlCartSummary;
        protected global::System.Web.UI.WebControls.Literal ltlCartTotal;
        protected global::System.Web.UI.WebControls.Repeater rptCart;
        protected global::System.Web.UI.WebControls.Label lblCartEmpty;
        protected global::System.Web.UI.WebControls.Repeater rptFavorite;
        protected global::System.Web.UI.WebControls.Label lblFavEmpty;
        protected global::System.Web.UI.WebControls.Repeater rptPurchased;
        protected global::System.Web.UI.WebControls.Label lblPurchasedEmpty;
        protected global::System.Web.UI.WebControls.Button btnCheckout;
        protected global::System.Web.UI.WebControls.HiddenField hfActiveTab;
        protected global::System.Web.UI.WebControls.HiddenField hfSelectedCartIds;
        protected global::System.Web.UI.WebControls.HiddenField hfSelectedFavIds;
        protected global::System.Web.UI.WebControls.Panel pnlCartSelectBar;
        protected global::System.Web.UI.WebControls.Panel pnlFavSelectBar;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                LoadCart();
                LoadFavorites();
                LoadPurchased();
            }
        }

        private int GetCurrentUserId()
        {
            int uid = 0;
            if (Session["UserId"] != null)
                int.TryParse(Session["UserId"].ToString(), out uid);
            return uid;
        }

        private void LoadCart()
        {
            int userId = GetCurrentUserId();
            Maticsoft.BLL.Cart cartBll = new Maticsoft.BLL.Cart();
            Maticsoft.BLL.Course courseBll = new Maticsoft.BLL.Course();

            var cartItems = cartBll.GetModelList("UserId = " + userId);
            if (cartItems.Count == 0)
            {
                lblCartEmpty.Visible = true;
                pnlCartSummary.Visible = false;
                pnlCartSelectBar.Visible = false;
                rptCart.DataSource = null;
                rptCart.DataBind();
                return;
            }

            lblCartEmpty.Visible = false;
            pnlCartSummary.Visible = true;
            pnlCartSelectBar.Visible = true;

            DataTable dt = new DataTable();
            dt.Columns.Add("CartId", typeof(int));
            dt.Columns.Add("CourseId", typeof(int));
            dt.Columns.Add("Title", typeof(string));
            dt.Columns.Add("Price", typeof(decimal));
            dt.Columns.Add("ImageUrl", typeof(string));
            dt.Columns.Add("AddTime", typeof(DateTime));

            decimal total = 0;
            foreach (var ci in cartItems)
            {
                var course = courseBll.GetModel(ci.CourseId);
                if (course == null) continue;

                DataRow dr = dt.NewRow();
                dr["CartId"] = ci.Id;
                dr["CourseId"] = ci.CourseId;
                dr["Title"] = course.Title ?? "";
                dr["Price"] = course.Price ?? 0;
                dr["ImageUrl"] = string.IsNullOrEmpty(course.beiyong)
                    ? "Admin/images/nono.png"
                    : (course.beiyong.Contains("../") ? course.beiyong.Replace("../", "") : "Admin/Courseimg/" + course.beiyong);
                dr["AddTime"] = ci.AddTime;
                total += course.Price ?? 0;
                dt.Rows.Add(dr);
            }

            ltlCartTotal.Text = total.ToString("0.00");
            rptCart.DataSource = dt;
            rptCart.DataBind();
        }

        private void LoadFavorites()
        {
            int userId = GetCurrentUserId();
            Maticsoft.BLL.Favorite favBll = new Maticsoft.BLL.Favorite();
            Maticsoft.BLL.Course courseBll = new Maticsoft.BLL.Course();

            var favItems = favBll.GetModelList("UserId = " + userId);
            if (favItems.Count == 0)
            {
                lblFavEmpty.Visible = true;
                pnlFavSelectBar.Visible = false;
                rptFavorite.DataSource = null;
                rptFavorite.DataBind();
                return;
            }

            lblFavEmpty.Visible = false;
            pnlFavSelectBar.Visible = true;

            DataTable dt = new DataTable();
            dt.Columns.Add("FavoriteId", typeof(int));
            dt.Columns.Add("CourseId", typeof(int));
            dt.Columns.Add("Title", typeof(string));
            dt.Columns.Add("Price", typeof(decimal));
            dt.Columns.Add("ImageUrl", typeof(string));
            dt.Columns.Add("AddTime", typeof(DateTime));

            foreach (var fi in favItems)
            {
                var course = courseBll.GetModel(fi.CourseId);
                if (course == null) continue;

                DataRow dr = dt.NewRow();
                dr["FavoriteId"] = fi.Id;
                dr["CourseId"] = fi.CourseId;
                dr["Title"] = course.Title ?? "";
                dr["Price"] = course.Price ?? 0;
                dr["ImageUrl"] = string.IsNullOrEmpty(course.beiyong)
                    ? "Admin/images/nono.png"
                    : (course.beiyong.Contains("../") ? course.beiyong.Replace("../", "") : "Admin/Courseimg/" + course.beiyong);
                dr["AddTime"] = fi.AddTime;
                dt.Rows.Add(dr);
            }

            rptFavorite.DataSource = dt;
            rptFavorite.DataBind();
        }

        private void LoadPurchased()
        {
            int userId = GetCurrentUserId();
            Maticsoft.BLL.Orders orderBll = new Maticsoft.BLL.Orders();
            Maticsoft.BLL.OrderCourse ocBll = new Maticsoft.BLL.OrderCourse();
            Maticsoft.BLL.Course courseBll = new Maticsoft.BLL.Course();
            Maticsoft.BLL.CourseRatings ratingBll = new Maticsoft.BLL.CourseRatings();

            var orders = orderBll.GetModelList("UserId = " + userId);
            DataTable dt = new DataTable();
            dt.Columns.Add("CourseId", typeof(int));
            dt.Columns.Add("Title", typeof(string));
            dt.Columns.Add("Price", typeof(decimal));
            dt.Columns.Add("ImageUrl", typeof(string));
            dt.Columns.Add("OrderDate", typeof(DateTime));
            dt.Columns.Add("MyRating", typeof(double));

            foreach (var order in orders)
            {
                var ocs = ocBll.GetModelList("OrderID = " + order.Id);
                foreach (var oc in ocs)
                {
                    var course = courseBll.GetModel(oc.CourseID);
                    if (course == null) continue;

                    bool alreadyAdded = false;
                    foreach (DataRow existingRow in dt.Rows)
                    {
                        if ((int)existingRow["CourseId"] == oc.CourseID)
                        {
                            alreadyAdded = true;
                            break;
                        }
                    }
                    if (alreadyAdded) continue;

                    DataRow dr = dt.NewRow();
                    dr["CourseId"] = oc.CourseID;
                    dr["Title"] = course.Title ?? "";
                    dr["Price"] = course.Price ?? 0;
                    dr["ImageUrl"] = string.IsNullOrEmpty(course.beiyong)
                        ? "Admin/images/nono.png"
                        : (course.beiyong.Contains("../") ? course.beiyong.Replace("../", "") : "Admin/Courseimg/" + course.beiyong);
                    dr["OrderDate"] = order.OrderDate;

                    int myRatingCount = ratingBll.GetRecordCount("CourseId = " + oc.CourseID + " AND UserId = " + userId);
                    if (myRatingCount > 0)
                    {
                        var myRatings = ratingBll.GetModelList("CourseId = " + oc.CourseID + " AND UserId = " + userId);
                        dr["MyRating"] = myRatings[0].Rating;
                    }
                    else
                    {
                        dr["MyRating"] = 0.0;
                    }
                    dt.Rows.Add(dr);
                }
            }

            if (dt.Rows.Count == 0)
            {
                lblPurchasedEmpty.Visible = true;
                rptPurchased.DataSource = null;
                rptPurchased.DataBind();
                return;
            }

            lblPurchasedEmpty.Visible = false;
            rptPurchased.DataSource = dt;
            rptPurchased.DataBind();
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "RemoveCart")
            {
                int cartId = int.Parse(e.CommandArgument.ToString());
                Maticsoft.BLL.Cart cartBll = new Maticsoft.BLL.Cart();
                cartBll.Delete(cartId);
                LoadCart();
            }
            else if (e.CommandName == "BuyNow")
            {
                int cartId = int.Parse(e.CommandArgument.ToString());

                // 获取购物车项信息
                Maticsoft.BLL.Cart cartBll = new Maticsoft.BLL.Cart();
                var cartItem = cartBll.GetModel(cartId);

                if (cartItem != null)
                {
                    // 创建单个课程的订单
                    int userId = GetCurrentUserId();
                    Maticsoft.BLL.Course courseBll = new Maticsoft.BLL.Course();
                    Maticsoft.BLL.Orders orderBll = new Maticsoft.BLL.Orders();
                    Maticsoft.BLL.OrderCourse ocBll = new Maticsoft.BLL.OrderCourse();

                    var course = courseBll.GetModel(cartItem.CourseId);
                    if (course != null)
                    {
                        // 创建订单
                        Maticsoft.Model.Orders order = new Maticsoft.Model.Orders();
                        order.Id = orderBll.GetMaxId();
                        order.OrderDate = DateTime.Now;
                        order.UserId = userId;
                        order.TotalPirce = course.Price ?? 0;
                        order.beiyong = "";

                        bool orderAdded = orderBll.Add(order);

                        if (orderAdded)
                        {
                            // 创建订单课程关联
                            Maticsoft.Model.OrderCourse oc = new Maticsoft.Model.OrderCourse();
                            oc.OrderID = order.Id;
                            oc.CourseID = cartItem.CourseId;
                            oc.beiyong1 = "";
                            oc.beiyong2 = "";
                            ocBll.Add(oc);

                            // 从购物车中移除
                            cartBll.Delete(cartId);

                            // 刷新购物车列表
                            LoadCart();
                            LoadPurchased();

                            // 显示成功消息并跳转到已购课程
                            ClientScript.RegisterStartupScript(this.GetType(), "buyNowSuccess",
                                "switchTab('purchased'); alert('购买成功！课程已添加到已购课程中。');", true);
                        }
                    }
                }
            }
        }

        protected void rptFavorite_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "RemoveFavorite")
            {
                int favId = int.Parse(e.CommandArgument.ToString());
                Maticsoft.BLL.Favorite favBll = new Maticsoft.BLL.Favorite();
                favBll.Delete(favId);
                LoadFavorites();
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            int userId = GetCurrentUserId();
            Maticsoft.BLL.Cart cartBll = new Maticsoft.BLL.Cart();
            Maticsoft.BLL.Course courseBll = new Maticsoft.BLL.Course();
            Maticsoft.BLL.Orders orderBll = new Maticsoft.BLL.Orders();
            Maticsoft.BLL.OrderCourse ocBll = new Maticsoft.BLL.OrderCourse();

            var cartItems = cartBll.GetModelList("UserId = " + userId);
            if (cartItems.Count == 0) return;

            decimal total = 0;
            foreach (var ci in cartItems)
            {
                var course = courseBll.GetModel(ci.CourseId);
                if (course != null) total += course.Price ?? 0;
            }

            Maticsoft.Model.Orders order = new Maticsoft.Model.Orders();
            order.Id = orderBll.GetMaxId();
            order.OrderDate = DateTime.Now;
            order.UserId = userId;
            order.TotalPirce = total;
            order.beiyong = "";
            bool orderAdded = orderBll.Add(order);

            if (orderAdded)
            {
                int maxOrderId = order.Id;
                foreach (var ci in cartItems)
                {
                    Maticsoft.Model.OrderCourse oc = new Maticsoft.Model.OrderCourse();
                    oc.OrderID = maxOrderId;
                    oc.CourseID = ci.CourseId;
                    oc.beiyong1 = "";
                    oc.beiyong2 = "";
                    ocBll.Add(oc);
                    cartBll.Delete(ci.Id);
                }
            }

            LoadCart();
            LoadPurchased();

            if (orderAdded)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "checkoutSuccess",
                    "switchTab('purchased'); alert('结算成功！课程已添加到已购课程中。');", true);
            }
        }

        protected void btnBatchBuy_Click(object sender, EventArgs e)
        {
            string idsStr = hfSelectedCartIds.Value;
            if (string.IsNullOrEmpty(idsStr)) return;

            int userId = GetCurrentUserId();
            Maticsoft.BLL.Cart cartBll = new Maticsoft.BLL.Cart();
            Maticsoft.BLL.Course courseBll = new Maticsoft.BLL.Course();
            Maticsoft.BLL.Orders orderBll = new Maticsoft.BLL.Orders();
            Maticsoft.BLL.OrderCourse ocBll = new Maticsoft.BLL.OrderCourse();

            string[] idArr = idsStr.Split(',');
            decimal total = 0;
            var buyItems = new List<int>();

            foreach (string idStr in idArr)
            {
                int cartId;
                if (!int.TryParse(idStr, out cartId)) continue;
                var cartItem = cartBll.GetModel(cartId);
                if (cartItem == null) continue;
                var course = courseBll.GetModel(cartItem.CourseId);
                if (course == null) continue;
                total += course.Price ?? 0;
                buyItems.Add(cartId);
            }

            if (buyItems.Count == 0) return;

            Maticsoft.Model.Orders order = new Maticsoft.Model.Orders();
            order.Id = orderBll.GetMaxId();
            order.OrderDate = DateTime.Now;
            order.UserId = userId;
            order.TotalPirce = total;
            order.beiyong = "";
            bool orderAdded = orderBll.Add(order);

            if (orderAdded)
            {
                int maxOrderId = order.Id;
                foreach (int cartId in buyItems)
                {
                    var cartItem = cartBll.GetModel(cartId);
                    if (cartItem == null) continue;

                    Maticsoft.Model.OrderCourse oc = new Maticsoft.Model.OrderCourse();
                    oc.OrderID = maxOrderId;
                    oc.CourseID = cartItem.CourseId;
                    oc.beiyong1 = "";
                    oc.beiyong2 = "";
                    ocBll.Add(oc);
                    cartBll.Delete(cartId);
                }
            }

            LoadCart();
            LoadPurchased();

            if (orderAdded)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "batchBuySuccess",
                    "switchTab('purchased'); alert('批量购买成功！已购买 " + buyItems.Count + " 门课程。');", true);
            }
        }

        protected void btnBatchDeleteCart_Click(object sender, EventArgs e)
        {
            string idsStr = hfSelectedCartIds.Value;
            if (string.IsNullOrEmpty(idsStr)) return;

            Maticsoft.BLL.Cart cartBll = new Maticsoft.BLL.Cart();
            string[] idArr = idsStr.Split(',');
            int count = 0;
            foreach (string idStr in idArr)
            {
                int cartId;
                if (int.TryParse(idStr, out cartId))
                {
                    cartBll.Delete(cartId);
                    count++;
                }
            }
            LoadCart();
            ClientScript.RegisterStartupScript(this.GetType(), "batchDeleteCart",
                "alert('已删除 " + count + " 项课程。');", true);
        }

        protected void btnBatchUnfav_Click(object sender, EventArgs e)
        {
            string idsStr = hfSelectedFavIds.Value;
            if (string.IsNullOrEmpty(idsStr)) return;

            Maticsoft.BLL.Favorite favBll = new Maticsoft.BLL.Favorite();
            string[] idArr = idsStr.Split(',');
            int count = 0;
            foreach (string idStr in idArr)
            {
                int favId;
                if (int.TryParse(idStr, out favId))
                {
                    favBll.Delete(favId);
                    count++;
                }
            }
            LoadFavorites();
            ClientScript.RegisterStartupScript(this.GetType(), "batchUnfav",
                "alert('已取消收藏 " + count + " 项课程。');", true);
        }
    }
}

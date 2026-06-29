	<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Maticsoft.Web.Default" MaintainScrollPositionOnPostback="true" %>
	<asp:Content ID="Content1" ContentPlaceHolderID="cphMainContent" runat="server">
        <style>
	        .page-wrapper { 
	            max-width: 1400px; 
	            margin: 0 auto; 
	            position: relative; 
	            padding: 0 20px;
	            margin-left: 290px; 
	        }
	        .sidebar { 
	            position: fixed; 
	            left: 0; 
	            top: 70px; 
	            width: 260px; 
	            height: calc(100vh - 70px); 
	            background: #1677ff; 
	            border-radius: 0 12px 12px 0; 
	            padding: 20px; 
	            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.08); 
	            overflow-y: auto; 
	            z-index: 90; 
	        }
	        .sidebar::-webkit-scrollbar { width: 6px; }
	        .sidebar::-webkit-scrollbar-thumb { background: rgba(255, 255, 255, 0.3); border-radius: 10px; }
	        .category { margin: -50px auto 30px; position: relative; z-index: 10; }
	        .category .cat-box { background: #fff; border-radius: 12px; box-shadow: 0 4px 20px rgba(0, 0, 0, .08); display: flex; flex-wrap: wrap; padding: 16px 20px; gap: 12px; }
	        .cat-item { padding: 8px 16px; background: #f5f7fa; border-radius: 8px; font-size: 14px; cursor: pointer; }
	        .cat-item:hover { background: #1677ff; color: #fff; }
	        .cat-item.active { background: #1677ff; color: #fff; }
	        .sidebar .cat-box { background: transparent; box-shadow: none; padding: 0; }
	        .sidebar .cat-item { background: rgba(255,255,255,0.15); color: #fff; margin-bottom: 8px; }
	        .sidebar .cat-item:hover, .sidebar .cat-item.active { background: #fff; color: #1677ff; }
	        .banner { height: 380px; background: linear-gradient(90deg, #0052d9, #1677ff); color: #fff; display: flex; align-items: center; justify-content: center; text-align: center; padding: 0 20px; border-radius: 12px; margin-top: 20px; }
	        .banner h1 { font-size: 38px; margin-bottom: 12px; }
	        .pagination {
	            display: flex;
	            justify-content: center;
	            align-items: center;
	            gap: 10px;
	            margin-top: 40px;
	        }
	        .page-btn {
	            padding: 8px 16px;
	            border-radius: 8px;
	            background: #fff;
	            border: 1px solid #e5e6eb;
	            cursor: pointer;
	            font-size: 14px;
	            transition: all 0.2s ease;
	        }
	        .page-btn.active {
	            background: #1677ff;
	            color: #fff;
	            border-color: #1677ff;
	        }
	        .page-btn:hover:not(.active) {
	            border-color: #1677ff;
	            color: #1677ff;
	        }
	        .page-btn:disabled {
	            opacity: 0.4;
	            cursor: not-allowed;
	        }
	        .main-content { margin-left: 290px; }
	        .course-meta { display: flex; align-items: center; gap: 12px; margin-top: 8px; font-size: 13px; color: #999; }
	        .stars { color: #faad14; letter-spacing: 1px; }
	        .stars .empty { color: #e8e8e8; }
	        .purchase-review-count { color: #1677ff; }
	        .comment-count { color: #999; }
	        .detail-stars { color: #faad14; font-size: 22px; letter-spacing: 2px; }
	        .detail-stars .empty { color: #e8e8e8; }
	        .detail-comment-count { font-size: 14px; color: #999; margin-left: 10px; }
	        .detail-actions { display: flex; gap: 12px; margin: 20px 0; flex-wrap: wrap; }
	        .detail-actions .action-btn { padding: 10px 24px; border-radius: 8px; border: none; cursor: pointer; font-size: 15px; font-weight: 500; transition: all 0.2s; }
	        .btn-cart { background: #ff9800; color: #fff; }
	        .btn-cart:hover { background: #f57c00; }
	        .btn-favorite { background: #ff4d4f; color: #fff; }
	        .btn-favorite:hover { background: #cf1322; }
	        .btn-favorited { background: #52c41a; color: #fff; cursor: default; }
	        .btn-purchase { background: #1677ff; color: #fff; }
	        .btn-purchase:hover { background: #0958d9; }
	        .btn-purchased { background: #52c41a; color: #fff; cursor: default; }
	        .btn-in-cart { background: #52c41a; color: #fff; cursor: default; }
	        .rating-section { margin-top: 25px; padding: 20px; border-top: 1px solid #eee; background: #f7f8fa; border-radius: 8px; }
	        .rating-section h4 { font-size: 16px; margin-bottom: 12px; }
	        .rating-stars-select { display: flex; gap: 6px; }
	        .rating-stars-select .star-btn { font-size: 28px; cursor: pointer; color: #e8e8e8; border: none; background: none; padding: 0; transition: color 0.15s; }
	        .rating-stars-select .star-btn.active { color: #faad14; }
	        .rating-stars-select .star-btn:hover { color: #faad14; }
	        .rating-submit-btn { margin-top: 10px; padding: 8px 20px; background: #1677ff; color: #fff; border: none; border-radius: 6px; cursor: pointer; font-size: 14px; }
	        .rating-submit-btn:hover { background: #0958d9; }
	        .rating-msg { margin-top: 8px; font-size: 13px; color: #999; }
	        .comments-section { margin-top: 25px; padding: 20px; background: #f7f8fa; border-radius: 8px; }
	        .comments-section h4 { font-size: 16px; margin-bottom: 12px; }
	        .comment-item { background: #fff; border-radius: 8px; padding: 14px 18px; margin-bottom: 10px; box-shadow: 0 1px 4px rgba(0,0,0,.04); }
	        .comment-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px; }
	        .comment-user { font-weight: 600; color: #333; font-size: 14px; }
	        .comment-date { font-size: 12px; color: #999; }
	        .comment-text { font-size: 14px; color: #555; line-height: 1.6; }
	        .comment-input-area { margin-top: 16px; }
	        .comment-input-area input[type="text"] { width: 100%; padding: 8px 12px; border: 1px solid #e5e6eb; border-radius: 6px; font-size: 14px; box-sizing: border-box; margin-bottom: 8px; }
	        .comment-input-area textarea { width: 100%; min-height: 80px; border: 1px solid #e5e6eb; border-radius: 8px; padding: 12px; font-size: 14px; resize: vertical; box-sizing: border-box; }
	        .comment-input-area textarea:focus { outline: none; border-color: #1677ff; }
	        .comment-submit-btn { margin-top: 8px; padding: 8px 20px; background: #1677ff; color: #fff; border: none; border-radius: 6px; cursor: pointer; font-size: 14px; }
	        .comment-submit-btn:hover { background: #0958d9; }
	        .comment-msg { margin-top: 6px; font-size: 13px; color: #52c41a; }
	        .no-comments { color: #999; font-size: 14px; padding: 10px 0; }
	        .purchase-reviews-section { margin-top: 25px; padding: 20px; background: #f7f8fa; border-radius: 8px; }
	        .purchase-reviews-section h4 { font-size: 16px; margin-bottom: 12px; color: #d48806; }
	        .review-item { background: #fff; border-radius: 8px; padding: 14px 18px; margin-bottom: 10px; box-shadow: 0 1px 4px rgba(0,0,0,.04); }
	        .review-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px; }
	        .review-user { font-weight: 600; color: #333; font-size: 14px; }
	        .review-date { font-size: 12px; color: #999; }
	        .review-title { font-size: 14px; font-weight: 600; color: #333; margin-bottom: 4px; }
	        .review-text { font-size: 14px; color: #555; line-height: 1.6; }
	        .review-stars { color: #faad14; font-size: 14px; }
	        .review-stars .empty { color: #e8e8e8; }
	        .rating-input-area { margin-top: 12px; }
	        .rating-input-area input[type="text"] { width: 100%; padding: 8px 12px; border: 1px solid #e5e6eb; border-radius: 6px; font-size: 14px; box-sizing: border-box; margin-bottom: 8px; }
	        .rating-input-area textarea { width: 100%; min-height: 60px; border: 1px solid #e5e6eb; border-radius: 6px; padding: 8px 12px; font-size: 14px; resize: vertical; box-sizing: border-box; margin-bottom: 8px; }
	        .comment-tabs { display: flex; gap: 0; margin-top: 25px; border-bottom: 2px solid #e5e6eb; }
	        .comment-tab { padding: 10px 24px; font-size: 15px; cursor: pointer; border: none; background: none; color: #666; border-bottom: 3px solid transparent; margin-bottom: -2px; transition: all 0.2s; }
	        .comment-tab:hover { color: #1677ff; }
	        .comment-tab.active { color: #1677ff; border-bottom-color: #1677ff; font-weight: 600; }
	        .comment-panel { display: none; padding: 20px; background: #f7f8fa; border-radius: 0 0 8px 8px; }
	        .comment-panel.active { display: block; }
	        @media (max-width: 900px) {
	            .page-wrapper { margin-left: 0; padding: 0 15px; }
	            .sidebar { display: none; }
	            .main-content { margin-left: 0; }
	        }
	    </style>
	    <div class="sidebar">
	        <h3 style="color: #fff; margin-bottom: 16px; font-size: 18px;">课程分类</h3>
	        <div class="cat-box">
	            <div class="cat-item active" data-type="all" onclick="switchCate(this, 'all')">全部课程</div>
	            <asp:Repeater ID="rptCategoriesLeft" runat="server">
	                <ItemTemplate>
	                    <div class="cat-item" data-type='<%# Eval("Id") %>' onclick="switchCate(this, '<%# Eval("Id") %>')"><%# Eval("Name") %></div>
	                </ItemTemplate>
	            </asp:Repeater>
	        </div>
	    </div>
	    <div class="page-wrapper">
	        <div class="banner">
	            <div>
	                <h1>一站式IT职业技能学习平台</h1>
	                <p>从零基础到就业，一线大厂讲师全程陪伴</p>
	            </div>
	        </div>
	        <div class="category">
	            <div class="cat-box">
	                <div class="cat-item active" data-type="all" onclick="switchCate(this, 'all')">全部课程</div>
	                <asp:Repeater ID="rptCategoriesRight" runat="server">
	                    <ItemTemplate>
	                        <div class="cat-item" data-type='<%# Eval("Id") %>' onclick="switchCate(this, '<%# Eval("Id") %>')"><%# Eval("Name") %></div>
	                    </ItemTemplate>
	            </asp:Repeater>
	            </div>
	        </div>
	        <div style="display: flex; justify-content: space-between; align-items: center; margin: 30px 0 20px;">
            <h2 style="font-size: 26px; margin: 0;">精品好课</h2>
            <div>
                <asp:Button ID="btnShowAll" runat="server" Text="全部课程" CssClass="filter-btn active" OnClick="btnShowAll_Click" />
                <asp:Button ID="btnShowRecommended" runat="server" Text="主编推荐" CssClass="filter-btn" OnClick="btnShowRecommended_Click" />
            </div>
        </div>
        <div class="course-list main-course-list" id="courseList" runat="server">
            <asp:Repeater ID="rptCourses" runat="server" OnItemDataBound="rptCourses_ItemDataBound">
                <ItemTemplate>
                    <a href='Default.aspx?id=<%# Eval("Id") %>' class="course-link">
                        <div class="course" data-title='<%# Eval("Title") %>' data-cate='<%# Eval("CategoryId") %>' data-id='<%# Eval("Id") %>'>
                            <img class="course-img" src='<%# Eval("beiyong").ToString().Contains("../") ? Eval("beiyong").ToString().Replace("../", "") : "Admin/Courseimg/" + Eval("beiyong").ToString() %>' onerror="this.src='Admin/images/nono.png'" />
                            <div class="course-body">
                                <div class="tag">热门</div>
                                <%# Eval("IsRecommended").ToString() == "1" ? "<div class=\"tag tag-recommend\">主编推荐</div>" : "" %>
                                <div class="title"><%# Eval("Title") %></div>
                                <div class="course-meta">
                                    <span class="stars" data-rating='<%# Eval("AvgRating") %>'></span>
                                    <span class="purchase-review-count"><%# Eval("PurchaseReviewCount") %>条购买评论</span>
                                    <span class="comment-count"><%# Eval("CommentCount") %>条用户评论</span>
                                </div>
                                <div class="info">
                                    <span><%# Eval("Duration") %>课时</span>
                                    <span class="price">¥<%# Eval("Price") %></span></div>
                            </div>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
            <br />
        </div>

        <div id="courseDetailPanel" class="course-detail-panel" style="display:none;" runat="server">
	            <a href="Default.aspx" class="detail-back-btn">← 返回课程列表</a>
	            <asp:Image ID="imgDetail" runat="server" CssClass="detail-img" />
	            <div class="detail-content">
	                <asp:Label ID="lblDetailTitle" runat="server" CssClass="detail-title"></asp:Label>
	                <div style="display:flex; align-items:center; margin: 10px 0;">
	                    <span class="detail-stars" id="detailStars" runat="server"></span>
	                    <asp:Label ID="lblDetailAvgRating" runat="server" style="font-size:16px; color:#faad14; margin-left:8px;"></asp:Label>
	                    <span class="detail-comment-count" id="detailCommentCount" runat="server"></span>
	                </div>
	                <div class="detail-info-line">课时：<asp:Label ID="lblDetailDuration" runat="server"></asp:Label>
                    <asp:Panel ID="pnlDetailTags" runat="server" style="display:inline-block; margin-left:12px;">
                        <asp:Label ID="lblDetailTags" runat="server" CssClass="detail-tags"></asp:Label>
                    </asp:Panel>
                </div>
	                <div class="detail-price">价格：¥<asp:Label ID="lblDetailPrice" runat="server"></asp:Label></div>
	                <div class="detail-actions">
	                    <asp:Button ID="btnAddCart" runat="server" Text="加入购物车" CssClass="action-btn btn-cart" OnClick="btnAddCart_Click" />
	                    <asp:Button ID="btnFavorite" runat="server" Text="收藏" CssClass="action-btn btn-favorite" OnClick="btnFavorite_Click" />
	                    <asp:Button ID="btnPurchase" runat="server" Text="立即购买" CssClass="action-btn btn-purchase" OnClick="btnPurchase_Click" OnClientClick="return confirm('是否立即购买该课程？');" />
	                </div>
	                <asp:Label ID="lblActionMsg" runat="server" style="color:#ff4d4f; font-size:14px;"></asp:Label>
	                <div class="detail-desc-title">课程介绍</div>
	                <asp:Label ID="lblDetailDesc" runat="server" CssClass="detail-desc-content"></asp:Label>
	                <div class="rating-section" id="ratingSection" runat="server">
	                    <h4>购买评分</h4>
	                    <div class="rating-stars-select" id="ratingStarsSelect">
	                        <button type="button" class="star-btn" data-value="1" onclick="selectRating(1)">★</button>
	                        <button type="button" class="star-btn" data-value="2" onclick="selectRating(2)">★</button>
	                        <button type="button" class="star-btn" data-value="3" onclick="selectRating(3)">★</button>
	                        <button type="button" class="star-btn" data-value="4" onclick="selectRating(4)">★</button>
	                        <button type="button" class="star-btn" data-value="5" onclick="selectRating(5)">★</button>
	                    </div>
	                    <asp:HiddenField ID="hfSelectedRating" runat="server" Value="0" />
	                    <asp:Button ID="btnSubmitRating" runat="server" Text="提交评分" CssClass="rating-submit-btn" OnClick="btnSubmitRating_Click" OnClientClick="saveScrollPosition()" />
	                    <asp:Label ID="lblRatingMsg" runat="server" CssClass="rating-msg"></asp:Label>
	                </div>
	                <asp:HiddenField ID="hfActiveCommentTab" runat="server" Value="purchase" />
                <asp:HiddenField ID="hfScrollY" runat="server" Value="0" />
	                <div class="comment-tabs">
	                    <button type="button" class="comment-tab active" onclick="switchCommentTab('purchase')">购买评论</button>
	                    <button type="button" class="comment-tab" onclick="switchCommentTab('user')">用户评论</button>
	                </div>
	                <div class="comment-panel active" id="panelPurchaseReviews">
	                    <asp:Repeater ID="rptPurchaseReviews" runat="server">
	                        <ItemTemplate>
	                            <div class="review-item">
	                                <div class="review-header">
	                                    <span class="review-user"><%# Eval("UserName") %></span>
	                                    <span class="review-date"><%# Eval("Date", "{0:yyyy-MM-dd HH:mm}") %></span>
	                                </div>
	                                <div class="review-stars"><%# Eval("StarsHtml") %></div>
	                                <%# (Eval("Title") != null && Eval("Title").ToString() != "") ? "<div class=\"review-title\">" + Eval("Title") + "</div>" : "" %>
	                                <%# (Eval("Comment") != null && Eval("Comment").ToString() != "") ? "<div class=\"review-text\">" + Eval("Comment") + "</div>" : "" %>
	                            </div>
	                        </ItemTemplate>
	                    </asp:Repeater>
	                    <asp:Label ID="lblNoPurchaseReviews" runat="server" Text="暂无购买评论" CssClass="no-comments" Visible="false"></asp:Label>
	                    <div class="comment-input-area" id="purchaseReviewInputArea" runat="server">
	                        <input type="text" id="txtRatingTitle" runat="server" placeholder="评价标题(选填)" class="rating-input-area" />
	                        <textarea id="txtRatingComment" runat="server" placeholder="请输入您的购买评论..."></textarea>
	                        <asp:Button ID="btnSubmitPurchaseReview" runat="server" Text="提交购买评论" CssClass="comment-submit-btn" OnClick="btnSubmitPurchaseReview_Click" OnClientClick="saveScrollPosition()" />
	                        <asp:Label ID="lblPurchaseReviewMsg" runat="server" CssClass="comment-msg"></asp:Label>
	                    </div>
	                </div>
	                <div class="comment-panel" id="panelUserComments">
	                    <asp:Repeater ID="rptComments" runat="server">
	                        <ItemTemplate>
	                            <div class="comment-item">
	                                <div class="comment-header">
	                                    <span class="comment-user"><%# Eval("UserName") %></span>
	                                    <span class="comment-date"><%# Eval("Date", "{0:yyyy-MM-dd HH:mm}") %></span>
	                                </div>
	                                <%# (Eval("Title") != null && Eval("Title").ToString() != "") ? "<div class=\"review-title\">" + Eval("Title") + "</div>" : "" %>
	                                <div class="comment-text"><%# Eval("Comment") %></div>
	                            </div>
	                        </ItemTemplate>
	                    </asp:Repeater>
	                    <asp:Label ID="lblNoComments" runat="server" Text="暂无评论" CssClass="no-comments" Visible="false"></asp:Label>
	                    <div class="comment-input-area" id="commentInputArea" runat="server">
	                        <input type="text" id="txtCommentTitle" runat="server" placeholder="评论标题(选填)" />
	                        <textarea id="txtComment" runat="server" placeholder="请输入您的评论..."></textarea>
	                        <asp:Button ID="btnSubmitComment" runat="server" Text="提交评论" CssClass="comment-submit-btn" OnClick="btnSubmitComment_Click" OnClientClick="saveScrollPosition()" />
	                        <asp:Label ID="lblCommentMsg" runat="server" CssClass="comment-msg"></asp:Label>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <div id="paginationWrapper" class="pagination">
	            <button type="button" class="page-btn" onclick="prevPage()">上一页</button>
	            <div id="pageNumbers"></div>
	            <button type="button" class="page-btn" onclick="nextPage()">下一页</button>
	        </div>
	    </div>
	    <script type="text/javascript">
	        function switchCommentTab(tabName) {
	            var tabs = document.querySelectorAll('.comment-tab');
	            var panels = document.querySelectorAll('.comment-panel');
	            for (var i = 0; i < tabs.length; i++) tabs[i].classList.remove('active');
	            for (var j = 0; j < panels.length; j++) panels[j].classList.remove('active');
	            if (tabName === 'purchase') { tabs[0].classList.add('active'); document.getElementById('panelPurchaseReviews').classList.add('active'); }
	            else if (tabName === 'user') { tabs[1].classList.add('active'); document.getElementById('panelUserComments').classList.add('active'); }
	            document.getElementById('<%= hfActiveCommentTab.ClientID %>').value = tabName;
	        }
	        var pageSize = 8;
        var currentPage = 1;
        var currentCategory = 'all';
        var currentKeyword = '';
        var recommendedPageSize = 4;
        var recommendedCurrentPage = 1;

        function renderStars(rating) {
	            var full = Math.floor(rating);
	            var html = '';
	            for (var i = 1; i <= 5; i++) {
	                if (i <= full) {
	                    html += '★';
	                } else {
	                    html += '<span class="empty">★</span>';
	                }
	            }
	            return html;
	        }
	        function initAllStars() {
	            var starEls = document.querySelectorAll('.stars[data-rating]');
	            for (var i = 0; i < starEls.length; i++) {
	                var r = parseFloat(starEls[i].getAttribute('data-rating'));
	                starEls[i].innerHTML = renderStars(r);
	            }
	        }
	        function renderView() {
            var courses = document.querySelectorAll('.main-course-list .course');
	            var filteredCourses = [];
	            for (var i = 0; i < courses.length; i++) {
	                var course = courses[i];
	                var courseLink = course.parentElement;
	                var cate = course.getAttribute('data-cate');
	                var title = course.getAttribute('data-title').toLowerCase();
	                var titleEl = course.querySelector('.title');
	                var originalTitle = course.getAttribute('data-title');
	                var matchCate = (currentCategory === 'all' || cate === currentCategory);
	                var matchSearch = (currentKeyword === '' || title.indexOf(currentKeyword) > -1);
	                if (matchCate && matchSearch) {
	                    filteredCourses.push({ link: courseLink, titleEl: titleEl, originalTitle: originalTitle });
	                    if (currentKeyword !== '') {
	                        var escapedKeyword = currentKeyword.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
	                        var reg = new RegExp('(' + escapedKeyword + ')', 'gi');
	                        titleEl.innerHTML = originalTitle.replace(reg, '<span class="highlight">$1</span>');
	                    } else {
	                        titleEl.innerText = originalTitle;
	                    }
	                } else {
	                    courseLink.style.display = 'none';
	                }
	            }
	            var totalPages = Math.ceil(filteredCourses.length / pageSize);
	            if (totalPages === 0) totalPages = 1;
	            if (currentPage > totalPages) currentPage = totalPages;
	            var start = (currentPage - 1) * pageSize;
	            var end = currentPage * pageSize;
	            for (var j = 0; j < filteredCourses.length; j++) {
	                if (j >= start && j < end) {
	                    filteredCourses[j].link.style.display = 'block';
	                } else {
	                    filteredCourses[j].link.style.display = 'none';
	                }
	            }
	            renderPagination(totalPages);
	        }
	        function renderPagination(totalPages) {
	            var numEl = document.getElementById('pageNumbers');
	            numEl.innerHTML = '';
	            for (var i = 1; i <= totalPages; i++) {
	                var b = document.createElement('button');
	                b.className = 'page-btn ' + (i === currentPage ? 'active' : '');
	                b.innerText = i;
	                (function (page) {
	                    b.onclick = function () {
	                        currentPage = page;
	                        renderView();
	                    };
	                })(i);
	                numEl.appendChild(b);
	            }
	        }
	        function prevPage() {
	            if (currentPage > 1) {
	                currentPage--;
	                renderView();
	            }
	        }
	        function nextPage() {
            var courses = document.querySelectorAll('.main-course-list .course');
	            var filteredCount = 0;
	            for (var i = 0; i < courses.length; i++) {
	                var cate = courses[i].getAttribute('data-cate');
	                var title = courses[i].getAttribute('data-title').toLowerCase();
	                var matchCate = (currentCategory === 'all' || cate === currentCategory);
	                var matchSearch = (currentKeyword === '' || title.indexOf(currentKeyword) > -1);
	                if (matchCate && matchSearch) filteredCount++;
	            }
	            var totalPages = Math.ceil(filteredCount / pageSize);
	            if (totalPages === 0) totalPages = 1;
	            if (currentPage < totalPages) {
	                currentPage++;
	                renderView();
	            }
	        }
	        function switchCate(element, type) {
	            var items = document.querySelectorAll('.cat-item');
	            for (var i = 0; i < items.length; i++) {
	                items[i].classList.remove('active');
	            }
	            element.classList.add('active');
	            var relatedItems = document.querySelectorAll('.cat-item[data-type="' + type + '"]');
	            for (var j = 0; j < relatedItems.length; j++) {
	                relatedItems[j].classList.add('active');
	            }
	            currentCategory = type;
	            currentPage = 1;
	            renderView();
	        }
	        function searchCourses() {
            currentKeyword = document.getElementById('searchInput').value.trim().toLowerCase();
            currentPage = 1;
            renderView();
        }

        function renderRecommendedView() {
            var courses = document.querySelectorAll('.recommended-course-list .course');
            var allCourses = [];
            for (var i = 0; i < courses.length; i++) {
                var course = courses[i];
                var courseLink = course.parentElement;
                allCourses.push({ link: courseLink });
            }
            var totalPages = Math.ceil(allCourses.length / recommendedPageSize);
            if (totalPages === 0) totalPages = 1;
            if (recommendedCurrentPage > totalPages) recommendedCurrentPage = totalPages;
            var start = (recommendedCurrentPage - 1) * recommendedPageSize;
            var end = recommendedCurrentPage * recommendedPageSize;
            for (var j = 0; j < allCourses.length; j++) {
                if (j >= start && j < end) {
                    allCourses[j].link.style.display = 'block';
                } else {
                    allCourses[j].link.style.display = 'none';
                }
            }
            renderRecommendedPagination(totalPages);
        }

        function renderRecommendedPagination(totalPages) {
            var numEl = document.getElementById('recommendedPageNumbers');
            numEl.innerHTML = '';
            for (var i = 1; i <= totalPages; i++) {
                var b = document.createElement('button');
                b.className = 'page-btn ' + (i === recommendedCurrentPage ? 'active' : '');
                b.innerText = i;
                (function (page) {
                    b.onclick = function () {
                        recommendedCurrentPage = page;
                        renderRecommendedView();
                    };
                })(i);
                numEl.appendChild(b);
            }
        }

        function prevPageRecommended() {
            if (recommendedCurrentPage > 1) {
                recommendedCurrentPage--;
                renderRecommendedView();
            }
        }

        function nextPageRecommended() {
            var courses = document.querySelectorAll('.recommended-course-list .course');
            var totalPages = Math.ceil(courses.length / recommendedPageSize);
            if (totalPages === 0) totalPages = 1;
            if (recommendedCurrentPage < totalPages) {
                recommendedCurrentPage++;
                renderRecommendedView();
            }
        }

        var selectedRating = 0;
	        function selectRating(value) {
	            selectedRating = value;
	            document.getElementById('<%= hfSelectedRating.ClientID %>').value = value;
	            var btns = document.querySelectorAll('.rating-stars-select .star-btn');
	            for (var i = 0; i < btns.length; i++) {
	                if (parseInt(btns[i].getAttribute('data-value')) <= value) {
	                    btns[i].classList.add('active');
	                } else {
	                    btns[i].classList.remove('active');
	                }
	            }
	        }
	        function saveScrollPosition() {
            document.getElementById('<%= hfScrollY.ClientID %>').value = window.pageYOffset || document.documentElement.scrollTop;
        }
        window.onload = function () {
            var scrollHF = document.getElementById('<%= hfScrollY.ClientID %>');
            if (scrollHF && parseInt(scrollHF.value) > 0) {
                window.scrollTo(0, parseInt(scrollHF.value));
            }
            initAllStars();
	            var ratingHF = document.getElementById('<%= hfSelectedRating.ClientID %>');
	            if (ratingHF && parseInt(ratingHF.value) > 0) {
	                selectRating(parseInt(ratingHF.value));
	            }
	            var commentTabHF = document.getElementById('<%= hfActiveCommentTab.ClientID %>');
	            if (commentTabHF && commentTabHF.value && commentTabHF.value !== 'purchase') {
	                switchCommentTab(commentTabHF.value);
	            }
	            var isDetail = window.location.href.indexOf('?id=') !== -1;
            var paginationWrapper = document.getElementById('paginationWrapper');
            var recommendedPagination = document.getElementById('recommendedPagination');
            if (isDetail) {
                if (paginationWrapper) paginationWrapper.style.display = 'none';
                if (recommendedPagination) recommendedPagination.style.display = 'none';
                return;
            }
            if (paginationWrapper) renderView();
            if (recommendedPagination) renderRecommendedView();
	        };
	    </script>
	</asp:Content>

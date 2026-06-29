<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserCenter.aspx.cs" Inherits="Maticsoft.Web.UserCenter" MasterPageFile="~/Site2.Master" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMainContent" runat="server">
    <style>
        .uc-container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }
        .uc-title { font-size: 28px; font-weight: 700; color: #1677ff; margin-bottom: 24px; }
        .uc-tabs { display: flex; gap: 0; margin-bottom: 24px; border-bottom: 2px solid #e5e6eb; position: relative; z-index: 10; }
        .uc-tab { padding: 12px 28px; font-size: 16px; cursor: pointer; border: none; background: none; color: #666; border-bottom: 3px solid transparent; margin-bottom: -2px; transition: all 0.2s; }
        .uc-tab:hover { color: #1677ff; }
        .uc-tab.active { color: #1677ff; border-bottom-color: #1677ff; font-weight: 600; }
        .uc-panel { display: none; }
        .uc-panel.active { display: block; }
        .uc-card { background: #fff; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,.05); padding: 20px; margin-bottom: 16px; display: flex; align-items: center; gap: 20px; transition: box-shadow 0.2s; }
        .uc-card:hover { box-shadow: 0 6px 20px rgba(0,0,0,.1); }
        .uc-card-img { width: 120px; height: 80px; border-radius: 8px; object-fit: cover; flex-shrink: 0; }
        .uc-card-info { flex: 1; }
        .uc-card-title { font-size: 17px; font-weight: 600; color: #333; margin-bottom: 6px; }
        .uc-card-title a { color: #1677ff; text-decoration: none; }
        .uc-card-title a:hover { text-decoration: underline; }
        .uc-card-meta { font-size: 13px; color: #999; margin-bottom: 4px; }
        .uc-card-price { font-size: 18px; color: #ff4d4f; font-weight: 600; }
        .uc-card-actions { display: flex; gap: 8px; flex-shrink: 0; }
        .uc-card-checkbox { display: flex; align-items: center; flex-shrink: 0; }
        .uc-card-checkbox input[type="checkbox"] { width: 18px; height: 18px; cursor: pointer; accent-color: #1677ff; }
        .uc-select-bar { background: #fff; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,.05); padding: 14px 20px; margin-bottom: 16px; display: flex; align-items: center; gap: 16px; }
        .uc-select-bar label { display: flex; align-items: center; gap: 6px; cursor: pointer; font-size: 14px; color: #333; user-select: none; }
        .uc-select-bar input[type="checkbox"] { width: 18px; height: 18px; cursor: pointer; accent-color: #1677ff; }
        .uc-select-bar .batch-info { font-size: 14px; color: #666; margin-left: auto; }
        .uc-select-bar .batch-info span { color: #ff4d4f; font-weight: 600; }
        .uc-btn { padding: 8px 18px; border-radius: 6px; border: none; cursor: pointer; font-size: 13px; transition: all 0.2s; }
        .uc-btn-danger { background: #ff4d4f; color: #fff; }
        .uc-btn-danger:hover { background: #cf1322; }
        .uc-btn-primary { background: #1677ff; color: #fff; }
        .uc-btn-primary:hover { background: #0958d9; }
        .uc-btn-success { background: #52c41a; color: #fff; }
        .uc-btn-success:hover { background: #389e0d; }
        .uc-btn-warning { background: #faad14; color: #fff; }
        .uc-btn-warning:hover { background: #d48806; }
        .uc-empty { text-align: center; padding: 60px 20px; color: #999; font-size: 16px; }
        .uc-summary { background: #fff; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,.05); padding: 20px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
        .uc-summary-total { font-size: 18px; color: #333; }
        .uc-summary-total span { color: #ff4d4f; font-size: 24px; font-weight: 700; }
        .stars { color: #faad14; letter-spacing: 1px; }
        .stars .empty { color: #e8e8e8; }
        .rating-section { margin-top: 8px; }
        .rating-stars-select { display: flex; gap: 4px; }
        .rating-stars-select .star-btn { font-size: 20px; cursor: pointer; color: #e8e8e8; border: none; background: none; padding: 0; transition: color 0.15s; }
        .rating-stars-select .star-btn.active { color: #faad14; }
        .rating-stars-select .star-btn:hover { color: #faad14; }
        .rating-submit-btn { margin-top: 4px; padding: 4px 12px; background: #1677ff; color: #fff; border: none; border-radius: 4px; cursor: pointer; font-size: 12px; }
        .rating-msg { margin-top: 4px; font-size: 12px; color: #52c41a; }
    </style>

    <div class="uc-container">
        <h1 class="uc-title">个人中心</h1>
        <asp:HiddenField ID="hfActiveTab" runat="server" Value="cart" />
        <div class="uc-tabs">
            <button type="button" class="uc-tab active" onclick="switchTab('cart')">购物车</button>
            <button type="button" class="uc-tab" onclick="switchTab('favorite')">我的收藏</button>
            <button type="button" class="uc-tab" onclick="switchTab('purchased')">已购课程</button>
        </div>

        <div class="uc-panel active" id="panelCart">
            <asp:HiddenField ID="hfSelectedCartIds" runat="server" Value="" />
            <asp:Panel ID="pnlCartSelectBar" runat="server" Visible="false">
                <div class="uc-select-bar">
                    <label><input type="checkbox" id="chkAllCart" onclick="toggleAllCart(this)" />全选</label>
                    <asp:Button ID="btnBatchBuy" runat="server" Text="批量购买选中" CssClass="uc-btn uc-btn-success" OnClick="btnBatchBuy_Click" OnClientClick="return prepareCartBatch();" />
                    <asp:Button ID="btnBatchDeleteCart" runat="server" Text="批量删除选中" CssClass="uc-btn uc-btn-danger" OnClick="btnBatchDeleteCart_Click" OnClientClick="return prepareCartBatch();" />
                    <div class="batch-info">已选 <span id="cartSelectedCount">0</span> 项，合计 <span id="cartSelectedTotal">¥0.00</span></div>
                </div>
            </asp:Panel>
            <asp:Panel ID="pnlCartSummary" runat="server" Visible="false">
                <div class="uc-summary">
                    <div class="uc-summary-total">合计：<span>¥<asp:Literal ID="ltlCartTotal" runat="server"></asp:Literal></span></div>
                    <asp:Button ID="btnCheckout" runat="server" Text="结算购物车" CssClass="uc-btn uc-btn-primary" OnClick="btnCheckout_Click" OnClientClick="return confirm('是否立即购买购物车全部中的课程？');" />
                </div>
            </asp:Panel>
            <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
                <ItemTemplate>
                    <div class="uc-card">
                        <div class="uc-card-checkbox">
                            <input type="checkbox" class="cart-item-chk" data-id='<%# Eval("CartId") %>' data-price='<%# Eval("Price") %>' onclick="onCartCheckChange()" />
                        </div>
                        <img class="uc-card-img" src='<%# Eval("ImageUrl") %>' onerror="this.src='Admin/images/nono.png'" />
                        <div class="uc-card-info">
                            <div class="uc-card-title"><a href='Default.aspx?id=<%# Eval("CourseId") %>'><%# Eval("Title") %></a></div>
                            <div class="uc-card-meta">加入时间：<%# Eval("AddTime", "{0:yyyy-MM-dd}") %></div>
                            <div class="uc-card-price">¥<%# Eval("Price") %></div>
                        </div>
                        <div class="uc-card-actions">
                            <asp:Button ID="btnBuyNow" runat="server" Text="立即购买" CssClass="uc-btn uc-btn-success" 
                                CommandName="BuyNow" CommandArgument='<%# Eval("CartId") %>' 
                                OnClientClick="return confirm('是否立即购买该课程？');" />
                            <asp:Button ID="btnRemoveCart" runat="server" Text="删除" CssClass="uc-btn uc-btn-danger" CommandName="RemoveCart" CommandArgument='<%# Eval("CartId") %>' />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Label ID="lblCartEmpty" runat="server" Visible="false" Text="购物车是空的，去选购课程吧！" CssClass="uc-empty"></asp:Label>
        </div>

        <div class="uc-panel" id="panelFavorite">
            <asp:HiddenField ID="hfSelectedFavIds" runat="server" Value="" />
            <asp:Panel ID="pnlFavSelectBar" runat="server" Visible="false">
                <div class="uc-select-bar">
                    <label><input type="checkbox" id="chkAllFav" onclick="toggleAllFav(this)" />全选</label>
                    <asp:Button ID="btnBatchUnfav" runat="server" Text="批量取消收藏" CssClass="uc-btn uc-btn-danger" OnClick="btnBatchUnfav_Click" OnClientClick="return prepareFavBatch();" />
                    <div class="batch-info">已选 <span id="favSelectedCount">0</span> 项</div>
                </div>
            </asp:Panel>
            <asp:Repeater ID="rptFavorite" runat="server" OnItemCommand="rptFavorite_ItemCommand">
                <ItemTemplate>
                    <div class="uc-card">
                        <div class="uc-card-checkbox">
                            <input type="checkbox" class="fav-item-chk" data-id='<%# Eval("FavoriteId") %>' onclick="onFavCheckChange()" />
                        </div>
                        <img class="uc-card-img" src='<%# Eval("ImageUrl") %>' onerror="this.src='Admin/images/nono.png'" />
                        <div class="uc-card-info">
                            <div class="uc-card-title"><a href='Default.aspx?id=<%# Eval("CourseId") %>'><%# Eval("Title") %></a></div>
                            <div class="uc-card-meta">收藏时间：<%# Eval("AddTime", "{0:yyyy-MM-dd}") %></div>
                            <div class="uc-card-price">¥<%# Eval("Price") %></div>
                        </div>
                        <div class="uc-card-actions">
                            <asp:Button ID="btnRemoveFav" runat="server" Text="取消收藏" CssClass="uc-btn uc-btn-danger" CommandName="RemoveFavorite" CommandArgument='<%# Eval("FavoriteId") %>' />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Label ID="lblFavEmpty" runat="server" Visible="false" Text="还没有收藏任何课程！" CssClass="uc-empty"></asp:Label>
        </div>

        <div class="uc-panel" id="panelPurchased">
            <asp:Repeater ID="rptPurchased" runat="server">
                <ItemTemplate>
                    <div class="uc-card">
                        <img class="uc-card-img" src='<%# Eval("ImageUrl") %>' onerror="this.src='Admin/images/nono.png'" />
                        <div class="uc-card-info">
                            <div class="uc-card-title"><a href='Default.aspx?id=<%# Eval("CourseId") %>'><%# Eval("Title") %></a></div>
                            <div class="uc-card-meta">购买时间：<%# Eval("OrderDate", "{0:yyyy-MM-dd}") %></div>
                            <div class="uc-card-price">¥<%# Eval("Price") %></div>
                            <div>我的评分：<span class="stars" data-rating='<%# Eval("MyRating") %>'></span></div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Label ID="lblPurchasedEmpty" runat="server" Visible="false" Text="还没有购买任何课程！" CssClass="uc-empty"></asp:Label>
        </div>

    </div>

    <script type="text/javascript">
        function switchTab(tabName) {
            var tabs = document.querySelectorAll('.uc-tab');
            var panels = document.querySelectorAll('.uc-panel');
            for (var i = 0; i < tabs.length; i++) tabs[i].classList.remove('active');
            for (var j = 0; j < panels.length; j++) panels[j].classList.remove('active');
            if (tabName === 'cart') { tabs[0].classList.add('active'); document.getElementById('panelCart').classList.add('active'); }
            else if (tabName === 'favorite') { tabs[1].classList.add('active'); document.getElementById('panelFavorite').classList.add('active'); }
            else if (tabName === 'purchased') { tabs[2].classList.add('active'); document.getElementById('panelPurchased').classList.add('active'); }
            document.getElementById('<%= hfActiveTab.ClientID %>').value = tabName;
        }
        function renderStars(rating) {
            var full = Math.floor(rating);
            var html = '';
            for (var i = 1; i <= 5; i++) {
                if (i <= full) html += '★';
                else html += '<span class="empty">★</span>';
            }
            return html;
        }

        // 购物车全选
        function toggleAllCart(el) {
            var checks = document.querySelectorAll('.cart-item-chk');
            for (var i = 0; i < checks.length; i++) checks[i].checked = el.checked;
            onCartCheckChange();
        }
        function onCartCheckChange() {
            var checks = document.querySelectorAll('.cart-item-chk');
            var allCheck = document.getElementById('chkAllCart');
            var count = 0, total = 0;
            for (var i = 0; i < checks.length; i++) {
                if (checks[i].checked) {
                    count++;
                    total += parseFloat(checks[i].getAttribute('data-price')) || 0;
                }
            }
            allCheck.checked = checks.length > 0 && count === checks.length;
            document.getElementById('cartSelectedCount').innerText = count;
            document.getElementById('cartSelectedTotal').innerText = '¥' + total.toFixed(2);
        }
        function prepareCartBatch() {
            var checks = document.querySelectorAll('.cart-item-chk');
            var ids = [];
            for (var i = 0; i < checks.length; i++) {
                if (checks[i].checked) ids.push(checks[i].getAttribute('data-id'));
            }
            if (ids.length === 0) {
                alert('请至少选择一项！');
                return false;
            }
            document.getElementById('<%= hfSelectedCartIds.ClientID %>').value = ids.join(',');
            return confirm('确认对选中的 ' + ids.length + ' 项执行操作？');
        }

        // 收藏全选
        function toggleAllFav(el) {
            var checks = document.querySelectorAll('.fav-item-chk');
            for (var i = 0; i < checks.length; i++) checks[i].checked = el.checked;
            onFavCheckChange();
        }
        function onFavCheckChange() {
            var checks = document.querySelectorAll('.fav-item-chk');
            var allCheck = document.getElementById('chkAllFav');
            var count = 0;
            for (var i = 0; i < checks.length; i++) {
                if (checks[i].checked) count++;
            }
            allCheck.checked = checks.length > 0 && count === checks.length;
            document.getElementById('favSelectedCount').innerText = count;
        }
        function prepareFavBatch() {
            var checks = document.querySelectorAll('.fav-item-chk');
            var ids = [];
            for (var i = 0; i < checks.length; i++) {
                if (checks[i].checked) ids.push(checks[i].getAttribute('data-id'));
            }
            if (ids.length === 0) {
                alert('请至少选择一项！');
                return false;
            }
            document.getElementById('<%= hfSelectedFavIds.ClientID %>').value = ids.join(',');
            return confirm('确认取消收藏选中的 ' + ids.length + ' 项？');
        }

        window.onload = function () {
            var starEls = document.querySelectorAll('.stars[data-rating]');
            for (var i = 0; i < starEls.length; i++) {
                var r = parseFloat(starEls[i].getAttribute('data-rating'));
                starEls[i].innerHTML = renderStars(r);
            }
            var activeTab = document.getElementById('<%= hfActiveTab.ClientID %>').value;
            if (activeTab && activeTab !== 'cart') {
                switchTab(activeTab);
            }
        };
    </script>
</asp:Content>

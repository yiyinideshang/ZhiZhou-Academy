<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course_All_Mess.aspx.cs" Inherits="Maticsoft.Web.Admin.Course_All_Mess" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="../StyleSheet.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="Id" DataSourceID="SqlDataSource1" EnableModelValidation="True" ForeColor="#333333" GridLines="None" Height="50px" Width="711px" OnItemUpdating="DetailsView1_ItemUpdating" OnDataBound="DetailsView1_DataBound">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id">
                        <FooterStyle CssClass="hiddenId" />
                        <HeaderStyle CssClass="hiddenId" />
                        <ItemStyle CssClass="hiddenId" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Title" HeaderText="课程名" SortExpression="Title" />
                    <asp:BoundField DataField="Author" HeaderText="作者" SortExpression="Author" />
                    <asp:BoundField DataField="CategoryId" HeaderText="种类号" SortExpression="CategoryId" />
                    <asp:BoundField DataField="Clicks" HeaderText="点击量" SortExpression="Clicks" />
                    <asp:BoundField DataField="PublishDate" HeaderText="出版日期" SortExpression="PublishDate" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="Duration" HeaderText="时长" SortExpression="Duration" />
                    <asp:BoundField DataField="ContentDescription" HeaderText="内容简介" SortExpression="ContentDescription">
                        <ItemStyle CssClass="long-text " />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="作者简介" SortExpression="AurhorDescription">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("AurhorDescription") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("AurhorDescription") %>'
                                TextMode="MultiLine" Rows="5" Width="400px"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="编辑评论" SortExpression="EditorComment">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("EditorComment") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("EditorComment") %>'
                                TextMode="MultiLine" Rows="4" Width="400px"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="目录" SortExpression="TOC">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("TOC") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("TOC") %>'
                                TextMode="MultiLine" Rows="6" Width="400px"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Registration" HeaderText="报名量" SortExpression="Registration" />
                    <asp:BoundField DataField="IsShow" HeaderText="是否显示" SortExpression="IsShow" />
                    <asp:BoundField DataField="Price" HeaderText="价格" SortExpression="Price" />
                    <asp:BoundField DataField="StartDate" HeaderText="开课日期" SortExpression="StartDate" />
                    <asp:BoundField DataField="beiyong" HeaderText="备用" SortExpression="beiyong" />
                    <asp:CommandField ShowEditButton="True" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />

            </asp:DetailsView>
            <asp:SqlDataSource
                ID="SqlDataSource1"
                runat="server"
                ConnectionString="<%$ ConnectionStrings:CourseManagementConnectionString %>"
                SelectCommand="SELECT * FROM [Course] WHERE ([Id] = @Id)" DeleteCommand="DELETE FROM [Course] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Course] ([Title], [Author], [CategoryId], [Clicks], [PublishDate], [Duration], [ContentDescription], [AurhorDescription], [EditorComment], [TOC], [Registration], [IsShow], [Price], [StartDate], [beiyong]) VALUES (@Title, @Author, @CategoryId, @Clicks, @PublishDate, @Duration, @ContentDescription, @AurhorDescription, @EditorComment, @TOC, @Registration, @IsShow, @Price, @StartDate, @beiyong)" UpdateCommand="UPDATE [Course] SET [Title] = @Title, [Author] = @Author, [CategoryId] = @CategoryId, [Clicks] = @Clicks, [PublishDate] = @PublishDate, [Duration] = @Duration, [ContentDescription] = @ContentDescription, [AurhorDescription] = @AurhorDescription, [EditorComment] = @EditorComment, [TOC] = @TOC, [Registration] = @Registration, [IsShow] = @IsShow, [Price] = @Price, [StartDate] = @StartDate, [beiyong] = @beiyong WHERE [Id] = @Id">

                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="Author" Type="String" />
                    <asp:Parameter Name="CategoryId" Type="Int32" />
                    <asp:Parameter Name="Clicks" Type="Int32" />
                    <asp:Parameter Name="PublishDate" Type="DateTime" />
                    <asp:Parameter Name="Duration" Type="Int32" />
                    <asp:Parameter Name="ContentDescription" Type="String" />
                    <asp:Parameter Name="AurhorDescription" Type="String" />
                    <asp:Parameter Name="EditorComment" Type="String" />
                    <asp:Parameter Name="TOC" Type="String" />
                    <asp:Parameter Name="Registration" Type="Int32" />
                    <asp:Parameter Name="IsShow" Type="Int32" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                    <asp:Parameter Name="StartDate" Type="DateTime" />
                    <asp:Parameter Name="beiyong" Type="String" />
                </InsertParameters>

                <SelectParameters>
                    <asp:QueryStringParameter Name="Id" QueryStringField="bid" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="Author" Type="String" />
                    <asp:Parameter Name="CategoryId" Type="Int32" />
                    <asp:Parameter Name="Clicks" Type="Int32" />
                    <asp:Parameter Name="PublishDate" Type="DateTime" />
                    <asp:Parameter Name="Duration" Type="Int32" />
                    <asp:Parameter Name="ContentDescription" Type="String" />
                    <asp:Parameter Name="AurhorDescription" Type="String" />
                    <asp:Parameter Name="EditorComment" Type="String" />
                    <asp:Parameter Name="TOC" Type="String" />
                    <asp:Parameter Name="Registration" Type="Int32" />
                    <asp:Parameter Name="IsShow" Type="Int32" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                    <asp:Parameter Name="StartDate" Type="DateTime" />
                    <asp:Parameter Name="beiyong" Type="String" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

        </div>
    </form>
</body>
</html>

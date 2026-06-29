<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher.aspx.cs" Inherits="Maticsoft.Web.Teacher" MasterPageFile="~/Site2.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMainContent" runat="server">
    <style>
        .content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
            color: #1677ff;
        }

        .teacher-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
        }

        .teacher {
            background: #fff;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 4px 18px rgba(0, 0, 0, .05);
            transition: .3s;
            padding: 24px;
        }

        .teacher:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 32px rgba(0, 0, 0, .09);
        }

        .teacher-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin: 0 auto 20px;
            object-fit: cover;
            border: 3px solid #1677ff;
        }

        .teacher-name {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 12px;
            text-align: center;
        }

        .teacher-profile {
            font-size: 14px;
            line-height: 1.6;
            color: #666;
            margin-bottom: 16px;
        }

        .teacher-courses {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
        }

        .teacher-courses h4 {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .course-item {
            font-size: 14px;
            margin-bottom: 8px;
        }

        .course-item a {
            color: #1677ff;
        }

        .course-item a:hover {
            text-decoration: underline;
        }

        .highlight {
            background: #fff3cd;
            color: #856404;
            padding: 1px 3px;
            border-radius: 3px;
        }
    </style>
    
    <div class="content">
        <h1 class="title">名师大咖</h1>
        <div class="teacher-list">
            <asp:Repeater ID="rptTeachers" runat="server">
                <ItemTemplate>
                    <div class="teacher">
                        <img class="teacher-avatar" src='<%# Eval("beiyong").ToString().Contains("http") ? Eval("beiyong").ToString() : "Admin/teacher/" + Eval("beiyong").ToString() %>' onerror="this.src='images/photo/default.png'" />
                        <h3 class="teacher-name"><%# Eval("Name") %></h3>
                        <p class="teacher-profile"><%# Eval("Profile") %></p>
                        <div class="teacher-courses">
                            <h4>主讲课程</h4>
                            <asp:Repeater ID="rptCourses" runat="server" DataSource='<%# GetTeacherCourses((int)Eval("Id")) %>'>
                                <ItemTemplate>
                                    <div class="course-item">
                                        <a href="CourseDetail.aspx?id=<%# Eval("Id") %>"><%# Eval("Title") %></a>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
    
    <script type="text/javascript">
        function searchCourses() {
            const keyword = document.getElementById('searchInput').value.trim().toLowerCase();
            const teachers = document.querySelectorAll('.teacher');
            
            teachers.forEach(teacher => {
                const name = teacher.querySelector('.teacher-name').textContent.toLowerCase();
                const profile = teacher.querySelector('.teacher-profile').textContent.toLowerCase();
                
                if (keyword === '' || name.includes(keyword) || profile.includes(keyword)) {
                    teacher.style.display = 'block';
                } else {
                    teacher.style.display = 'none';
                }
            });
        }
    </script>
</asp:Content>

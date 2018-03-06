<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Admin.Master" AutoEventWireup="true"
    CodeBehind="StudentsCourses.aspx.cs" Inherits="ITIAspOnlineExams.Admin.StudentsCourses" Theme="Bootstrap" %>
<%@ MasterType VirtualPath="~/Masters/Admin.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="myForm" runat="server">
        <h4>Filters</h4>
        <div class="form-inline">
            <label class="sr-only" for="filterByStudent">Filter By Student</label>
            <asp:DropDownList ID="filterByStudent" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="filter_SelectedIndexChanged">
                <asp:ListItem Value=""></asp:ListItem>
            </asp:DropDownList>

            <label class="sr-only" for="filterByCourse">Filter By Course</label>
            <asp:DropDownList ID="filterByCourse" runat="server" AutoPostBack="true" 
                OnSelectedIndexChanged="filter_SelectedIndexChanged">
                <asp:ListItem Value=""></asp:ListItem>
            </asp:DropDownList>

            <asp:Button ID="btnClear" CssClass="btn btn-secondary mx-1 handButton" runat="server" Text="Clear" OnClick="btnClear_Click" />
            <asp:Button ID="btnCreateNew" CssClass="btn btn-success mx-3 handButton" runat="server" Text="Add New" OnClick="btnCreateNew_Click" />
        </div>
        <hr />
        <h3>Students - Courses</h3>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="StudentsCoursesDS">
            <Columns>
                <asp:BoundField DataField="St_Id" HeaderText="Student ID" SortExpression="St_Id"></asp:BoundField>
                <asp:BoundField DataField="St_Name" HeaderText="Student Name" ReadOnly="True" SortExpression="St_Name"></asp:BoundField>
                <asp:BoundField DataField="Crs_Id" HeaderText="Course ID" SortExpression="Crs_Id"></asp:BoundField>
                <asp:BoundField DataField="Crs_Name" HeaderText="Course Name" SortExpression="Crs_Name"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource runat="server" ID="StudentsCoursesDS" ConnectionString='<%$ ConnectionStrings:OnlineExamsProject %>' 
            SelectCommand="select s.St_Id, (s.St_Fname + ' ' + s.St_Lname) as St_Name, sc.Crs_Id, c.Crs_Name, sc.Grade from Stud_Course sc 
inner join Student s on sc.St_Id = s.St_Id 
inner join Course c on c.Crs_Id = sc.Crs_Id"></asp:SqlDataSource>
    </form>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Admin.Master" AutoEventWireup="true"
    CodeBehind="InstructorsCourses.aspx.cs" Inherits="ITIAspOnlineExams.Admin.InstructorsCourses" Theme="Bootstrap" %>

<%@ MasterType VirtualPath="~/Masters/Admin.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="myForm" runat="server">
        <h4>Filters</h4>
        <div class="form-inline">
            <label class="sr-only" for="filterByInstructor">Filter By Instructor</label>
            <asp:DropDownList ID="filterByInstructor" runat="server" AutoPostBack="true"
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
        <h3>Instructors - Courses</h3>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="InstructorsCoursesDS">
            <Columns>
                <asp:BoundField DataField="Ins_Id" HeaderText="Ins_Id" SortExpression="Instructor ID"></asp:BoundField>
                <asp:BoundField DataField="Ins_Name" HeaderText="Ins_Name" SortExpression="Instructor Name"></asp:BoundField>
                <asp:BoundField DataField="Crs_Id" HeaderText="Crs_Id" SortExpression="Course ID"></asp:BoundField>
                <asp:BoundField DataField="Crs_Name" HeaderText="Crs_Name" SortExpression="Course Name"></asp:BoundField>
                <asp:BoundField DataField="Evaluation" HeaderText="Evaluation" SortExpression="Evaluation"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource runat="server" ID="InstructorsCoursesDS" ConnectionString='<%$ ConnectionStrings:OnlineExamsProject %>' 
            SelectCommand="select i.Ins_Id, i.Ins_Name, ic.Crs_Id, c.Crs_Name, ic.Evaluation from Ins_Course ic 
inner join Instructor i on i.Ins_Id = ic.Ins_Id
inner join Course c on c.Crs_Id = ic.Crs_Id"></asp:SqlDataSource>
    </form>
</asp:Content>

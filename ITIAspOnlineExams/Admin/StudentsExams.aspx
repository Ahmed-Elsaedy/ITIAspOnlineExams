<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Admin.Master" AutoEventWireup="true" 
    CodeBehind="StudentsExams.aspx.cs" Inherits="ITIAspOnlineExams.Admin.StudentsExams" Theme="Bootstrap" %>
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
            <asp:Button ID="btnGenerateExam" CssClass="btn btn-success mx-3 handButton" runat="server" Text="Generate Exam" OnClick="btnGenerateExam_Click" />
        </div>
        <hr />
        <h3>Students - Exams</h3>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="StudentsExamsDS">
                <Columns>
                    <asp:BoundField DataField="Exam_Id" HeaderText="Exam ID" ReadOnly="True" InsertVisible="False" SortExpression="Exam_Id"></asp:BoundField>
                    <%--<asp:BoundField DataField="St_Id" HeaderText="St_Id" SortExpression="Student ID"></asp:BoundField>--%>
                    <asp:BoundField DataField="ST_NAME" HeaderText="Student Name" ReadOnly="True" SortExpression="ST_NAME"></asp:BoundField>
                    <%--<asp:BoundField DataField="Crs_Id" HeaderText="Course ID" SortExpression="Crs_Id"></asp:BoundField>--%>
                    <asp:BoundField DataField="Crs_Name" HeaderText="Course Name" SortExpression="Crs_Name"></asp:BoundField>
                    <asp:BoundField DataField="Exam_Grade" HeaderText="Grade" SortExpression="Exam_Grade"></asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="StudentsExamsDS" ConnectionString='<%$ ConnectionStrings:OnlineExamsProject %>' 
                SelectCommand="select e.Exam_Id, s.St_Id, (S.ST_FNAME + ' ' + S.ST_LNAME) AS ST_NAME, e.Crs_Id, c.Crs_Name, e.Exam_Grade from Exam e inner join Student s on s.St_Id = e.St_Id inner join Course c on c.Crs_Id = e.Crs_Id"></asp:SqlDataSource>
        </form>
</asp:Content>

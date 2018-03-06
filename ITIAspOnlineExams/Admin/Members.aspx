<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Admin.Master" AutoEventWireup="true"
    CodeBehind="Members.aspx.cs" Inherits="ITIAspOnlineExams.Admin.Members" Theme="Bootstrap" %>
<%@ MasterType VirtualPath="~/Masters/Admin.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h4>Insert</h4>
    <form id="myForm" runat="server">
        <div class="form-inline">
            <label class="sr-only" for="txt_user">Username</label>
            <asp:TextBox ID="txt_user" type="text" placeholder="Username" runat="server"></asp:TextBox>

            <label class="sr-only" for="txt_pass">Name</label>
            <asp:TextBox runat="server" ID="txt_passw" type="text" placeholder="Password"></asp:TextBox>

            <label class="sr-only" for="roleType">Role Type</label>
            <asp:DropDownList ID="roleType" runat="server" AutoPostBack="True" 
                OnSelectedIndexChanged="roleType_SelectedIndexChanged">
                <asp:ListItem>Administrator</asp:ListItem>
                <asp:ListItem>Instructor</asp:ListItem>
                <asp:ListItem>Student</asp:ListItem>
            </asp:DropDownList>

            <label class="sr-only" for="roleTarget">Role Target</label>
            <asp:DropDownList Visible="false" ID="roleTarget" runat="server"></asp:DropDownList>

            <asp:SqlDataSource ID="StudentsDS" runat="server" ConnectionString='<%$ ConnectionStrings:OnlineExamsProject %>' 
                SelectCommand="SELECT ST_ID, (CONVERT(VARCHAR(10), ST_ID) + ' - ' + ST_FNAME + ' ' + ST_LNAME) AS ST_NAME FROM STUDENT"></asp:SqlDataSource>
            <asp:SqlDataSource ID="InstructorsDS" runat="server" ConnectionString='<%$ ConnectionStrings:OnlineExamsProject %>' 
                SelectCommand="SELECT Ins_Id , (CONVERT(varchar(10), Ins_Id) + ' - ' + Ins_Name ) as Ins_Name from Instructor"></asp:SqlDataSource>

            <asp:Button ID="btnInsert" CssClass="btn btn-primary" type="submit" runat="server" Text="Create User" OnClick="btnInsert_Click" />
            <asp:Button ID="btnClear" CssClass="btn btn-secondary mx-1 handButton" runat="server" Text="Clear" OnClick="btnClear_Click" />
        </div>
        <hr />
        <h3>Members Data</h3>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="UsersDS">
            <Columns>
                <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName"></asp:BoundField>
                <asp:BoundField DataField="RoleType" HeaderText="Role" SortExpression="RoleType"></asp:BoundField>
                <asp:BoundField DataField="Instructor" HeaderText="Instuctor" SortExpression="Instructor"></asp:BoundField>
                <asp:BoundField DataField="Student" HeaderText="Student" SortExpression="Student"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource runat="server" ID="UsersDS" ConnectionString='<%$ ConnectionStrings:OnlineExamsProject %>' 
            SelectCommand="select u.UserName, u.RoleType, (convert(varchar(10),u.Ins_Id) + ' ' + i.Ins_Name) as Instructor, (convert(varchar(10),u.St_Id) + ' ' + s.St_Fname + ' ' + s.St_LName) as Student from [dbo].[aspnet_Users] u left join Student s on u.St_Id = s.St_Id left join Instructor i on u.Ins_Id = i.Ins_Id"></asp:SqlDataSource>
    </form>
</asp:Content>

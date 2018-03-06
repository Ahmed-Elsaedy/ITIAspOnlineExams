<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Admin.Master" AutoEventWireup="true" 
    CodeBehind="Courses.aspx.cs" Inherits="ITIAspOnlineExams.Admin.Courses" Theme="Bootstrap" %>
<%@ MasterType VirtualPath="~/Masters/Admin.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h4>Insert</h4>
    <form id="myForm" runat="server">
        <div class="form-inline">
            <label class="sr-only" for="courseId">ID</label>
            <asp:TextBox ID="txt_courseId" type="number" runat="server" placeholder="Course ID" TextMode="Number"></asp:TextBox>

            <label class="sr-only" for="txt_courseName">Course Name</label>
            <asp:TextBox ID="txt_courseName" type="text" runat="server" placeholder="Course Name"></asp:TextBox>

            <label class="sr-only" for="txt_courseDuration">Duration</label>
            <asp:TextBox ID="txt_courseDuration" type="number" runat="server" placeholder="Duration"></asp:TextBox>

            <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Insert" OnClick="btnSubmit_Click" />
            <Button ID="btnClear" type="button" class="btn btn-secondary mx-1" 
                OnClick="document.getElementById('myForm').reset()">Clear</Button>
        </div>
        <hr />
        <h3>Courses List</h3>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Crs_Id" DataSourceID="CourseDS">
            <Columns>
                <asp:BoundField DataField="Crs_Id" HeaderText="Course ID" ReadOnly="True" SortExpression="Crs_Id" />
                <asp:BoundField DataField="Crs_Name" HeaderText="Course Name" SortExpression="Crs_Name" />
                <asp:BoundField DataField="Crs_Duration" HeaderText="Course Duration" SortExpression="Crs_Duration" />
                 <asp:CommandField ShowEditButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="CourseDS" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineExamsProject %>" 
            SelectCommand="SELECT * FROM [Course]" 
            DeleteCommand="DELETE FROM [Course] WHERE [Crs_Id] = @Crs_Id" 
            InsertCommand="INSERT INTO [Course] ([Crs_Id], [Crs_Name], [Crs_Duration]) VALUES (@Crs_Id, @Crs_Name, @Crs_Duration)" 
            UpdateCommand="UPDATE [Course] SET [Crs_Name] = @Crs_Name, [Crs_Duration] = @Crs_Duration WHERE [Crs_Id] = @Crs_Id">
            <DeleteParameters>
                <asp:Parameter Name="Crs_Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Crs_Id" Type="Int32" />
                <asp:Parameter Name="Crs_Name" Type="String" />
                <asp:Parameter Name="Crs_Duration" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Crs_Name" Type="String" />
                <asp:Parameter Name="Crs_Duration" Type="Int32" />
                <asp:Parameter Name="Crs_Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</asp:Content>

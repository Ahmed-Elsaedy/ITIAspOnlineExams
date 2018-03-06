<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Admin.Master" AutoEventWireup="true" 
    CodeBehind="Departments.aspx.cs" Inherits="ITIAspOnlineExams.Admin.Departments" Theme="Bootstrap" %>

<%@ MasterType VirtualPath="~/Masters/Admin.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h4>Insert</h4>
    <form id="myForm" runat="server">
        <div class="form-inline">
            <label class="sr-only" for="deptId">ID</label>
            <asp:TextBox ID="deptId" type="number" placeholder="ID" runat="server"></asp:TextBox>

            <label class="sr-only" for="deptName">Name</label>
            <asp:TextBox runat="server" ID="deptName" type="text" placeholder="Name"></asp:TextBox>

            <label class="sr-only" for="deptLocation">Description</label>
            <asp:TextBox runat="server" ID="deptDescription" type="text" placeholder="Description"></asp:TextBox>

            <label class="sr-only" for="deptLocation">Location</label>
            <asp:TextBox runat="server" ID="deptLocation" type="text" placeholder="Location"></asp:TextBox>

            <asp:Button ID="btnInsert" CssClass="btn btn-primary" type="submit" runat="server" Text="Insert" OnClick="btnInsert_Click" />
            <button id="btnClear" type="button" class="btn btn-secondary mx-1" 
                onclick="document.getElementById('myForm').reset()">Clear</button>
        </div>
        <hr />
        <h3>Departments List</h3>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Dept_Id" DataSourceID="DepartmentsDS">
            <Columns>
                <asp:BoundField DataField="Dept_Id" HeaderText="ID" ReadOnly="True" SortExpression="Dept_Id" />
                <asp:BoundField DataField="Dept_Name" HeaderText="Name" SortExpression="Dept_Name" />
                <asp:BoundField DataField="Dept_Desc" HeaderText="Description" SortExpression="Dept_Desc" />
                <asp:BoundField DataField="Dept_Location" HeaderText="Location" SortExpression="Dept_Location" />
                <asp:CommandField ShowEditButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="DepartmentsDS" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineExamsProject %>"
            SelectCommand="SELECT * FROM [Department]" DeleteCommand="DELETE FROM [Department] WHERE [Dept_Id] = @Dept_Id" InsertCommand="INSERT INTO [Department] ([Dept_Id], [Dept_Name], [Dept_Desc], [Dept_Location]) VALUES (@Dept_Id, @Dept_Name, @Dept_Desc, @Dept_Location)" UpdateCommand="UPDATE [Department] SET [Dept_Name] = @Dept_Name, [Dept_Desc] = @Dept_Desc, [Dept_Location] = @Dept_Location WHERE [Dept_Id] = @Dept_Id">
            <DeleteParameters>
                <asp:Parameter Name="Dept_Id" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Dept_Id" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="Dept_Name" Type="String"></asp:Parameter>
                <asp:Parameter Name="Dept_Desc" Type="String"></asp:Parameter>
                <asp:Parameter Name="Dept_Location" Type="String"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Dept_Name" Type="String"></asp:Parameter>
                <asp:Parameter Name="Dept_Desc" Type="String"></asp:Parameter>
                <asp:Parameter Name="Dept_Location" Type="String"></asp:Parameter>
                <asp:Parameter Name="Dept_Id" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</asp:Content>

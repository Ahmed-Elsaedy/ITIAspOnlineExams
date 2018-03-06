<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Admin.Master" AutoEventWireup="true" 
    CodeBehind="Students.aspx.cs" Inherits="ITIAspOnlineExams.Admin.Students" Theme="Bootstrap" %>
<%@ MasterType VirtualPath="~/Masters/Admin.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h4>Insert</h4>
    <form id="myForm" runat="server">
        <div class="form-inline">
            <label class="sr-only" for="studId">ID</label>
            <asp:TextBox type="number" runat="server" ID="studId" placeholder="ID" ></asp:TextBox>

            <label class="sr-only" for="studFName">First Name</label>
            <asp:TextBox type="text" runat="server" ID="studFName" placeholder="First Name"></asp:TextBox>

            <label class="sr-only" for="studLName">Second Name</label>
            <asp:TextBox type="text" runat="server" ID="studLName" placeholder="Last Name"></asp:TextBox>

            <label class="sr-only" for="studAddress">Address</label>
            <asp:TextBox runat="server" type="text" ID="studAddress" placeholder="Address"></asp:TextBox>

            <label class="sr-only" for="studAge">Age</label>
            <asp:TextBox type="number" runat="server" ID="studAge" placeholder="Age"></asp:TextBox>

            <label class="sr-only" for="studDepartment">Department</label>
            <asp:DropDownList ID="studDepartment" runat="server" DataSourceID="DepartmentsDS"
                DataTextField="Dept_Name" DataValueField="Dept_Id">
            </asp:DropDownList>

            <asp:SqlDataSource ID="DepartmentsDS" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineExamsProject %>"
                SelectCommand="SELECT [Dept_Name],[Dept_Id]  FROM [Department]"></asp:SqlDataSource>

            <asp:Button type="submit" ID="btnInsert" runat="server" CssClass="btn btn-primary" Text="Insert" OnClick="btnInsert_Click" ></asp:Button>
            <Button ID="btnClear" type="button" class="btn btn-secondary mx-1" 
                OnClick="document.getElementById('myForm').reset()">Clear</Button>
        </div>
        <hr />
        <h3>Students List</h3>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="St_Id" DataSourceID="StudentsDS">
            <Columns>
                <asp:BoundField DataField="St_Id" HeaderText="ID" ReadOnly="True" SortExpression="St_Id" />
                <asp:BoundField DataField="St_Fname" HeaderText="First Name" SortExpression="St_Fname" />
                <asp:BoundField DataField="St_Lname" HeaderText="Last Name" SortExpression="St_Lname" />
                <asp:BoundField DataField="St_Address" HeaderText="Address" SortExpression="St_Address" />
                <asp:BoundField DataField="St_Age" HeaderText="Age" SortExpression="St_Age" />
                <asp:TemplateField HeaderText="Department" SortExpression="Dept_Id">
                    <EditItemTemplate>
                        <asp:DropDownList ID="insDepartmentList" runat="server" 
                            SelectedValue='<%# Bind("Dept_Id") %>' DataSourceID="DepartmentsDS"
                            DataTextField="Dept_Name" DataValueField="Dept_Id">
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Dept_Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="StudentsDS" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineExamsProject %>" 
            DeleteCommand="DELETE FROM [Student] WHERE [St_Id] = @St_Id" 
            InsertCommand="INSERT INTO [Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id]) VALUES (@St_Id, @St_Fname, @St_Lname, @St_Address, @St_Age, @Dept_Id)" 
            SelectCommand="SELECT S.*, D.DEPT_NAME FROM STUDENT S INNER JOIN DEPARTMENT D ON S.DEPT_ID = D.DEPT_ID" UpdateCommand="UPDATE [Student] SET [St_Fname] = @St_Fname, [St_Lname] = @St_Lname, [St_Address] = @St_Address, [St_Age] = @St_Age, [Dept_Id] = @Dept_Id WHERE [St_Id] = @St_Id">
            <DeleteParameters>
                <asp:Parameter Name="St_Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="St_Id" Type="Int32" />
                <asp:Parameter Name="St_Fname" Type="String" />
                <asp:Parameter Name="St_Lname" Type="String" />
                <asp:Parameter Name="St_Address" Type="String" />
                <asp:Parameter Name="St_Age" Type="Int32" />
                <asp:Parameter Name="Dept_Id" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="St_Fname" Type="String" />
                <asp:Parameter Name="St_Lname" Type="String" />
                <asp:Parameter Name="St_Address" Type="String" />
                <asp:Parameter Name="St_Age" Type="Int32" />
                <asp:Parameter Name="Dept_Id" Type="Int32" />
                <asp:Parameter Name="St_Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</asp:Content>

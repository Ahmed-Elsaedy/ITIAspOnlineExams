<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Admin.Master" AutoEventWireup="true" 
    CodeBehind="Instructors.aspx.cs" Inherits="ITIAspOnlineExams.Admin.Instructors" Theme="Bootstrap" %>

<%@ MasterType VirtualPath="~/Masters/Admin.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h4>Insert</h4>
    <form id="myForm" runat="server">
        <div class="form-inline">
            <label class="sr-only" for="insId">ID</label>
            <asp:TextBox type="number" ID="instId" runat="server" placeholder="ID"></asp:TextBox>

            <label class="sr-only" for="insName">Name</label>
            <asp:TextBox type="text" ID="insName" runat="server" placeholder="Name"></asp:TextBox>

            <label class="sr-only" for="insDegree">Degree</label>
            <asp:TextBox type="text" ID="insDegree" runat="server" placeholder="Degree"></asp:TextBox>

            <label class="sr-only" for="insSalary">Salary</label>
            <asp:TextBox type="number" ID="insSalary" runat="server" placeholder="Salary"></asp:TextBox>

            <label class="sr-only" for="insDepartment">Department</label>
            <asp:DropDownList ID="insDepartment" runat="server" DataSourceID="DepartmentsDS"
                DataTextField="Dept_Name" DataValueField="Dept_Id">
            </asp:DropDownList>

            <asp:SqlDataSource ID="DepartmentsDS" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineExamsProject %>"
                SelectCommand="SELECT [Dept_Name],[Dept_Id]  FROM [Department]"></asp:SqlDataSource>

            <asp:Button ID="btnInsert" type="submit" runat="server" CssClass="btn btn-primary" Text="Insert" OnClick="btnInsert_Click" />
            <button id="btnClear" type="button" class="btn btn-secondary mx-1" 
                onclick="document.getElementById('myForm').reset()">Clear</button>
        </div>
        <hr />
        <h3>Instructors List</h3>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Ins_Id" DataSourceID="InstructorsDS">
            <Columns>
                <asp:BoundField DataField="Ins_Id" HeaderText="ID" ReadOnly="True" SortExpression="Ins_Id" />
                <asp:BoundField DataField="Ins_Name" HeaderText="Name" SortExpression="Ins_Name" />
                <asp:BoundField DataField="Ins_Degree" HeaderText="Degree" SortExpression="Ins_Degree" />
                <asp:BoundField DataField="Salary" HeaderText="Salary" SortExpression="Salary" />
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
        <asp:SqlDataSource ID="InstructorsDS" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineExamsProject %>" 
            DeleteCommand="DELETE FROM [Instructor] WHERE [Ins_Id] = @Ins_Id" 
            InsertCommand="INSERT INTO [Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (@Ins_Id, @Ins_Name, @Ins_Degree, @Salary, @Dept_Id)" 
            SelectCommand="SELECT I.*, D.DEPT_NAME FROM INSTRUCTOR I INNER JOIN DEPARTMENT D ON I.DEPT_ID = D.DEPT_ID" 
            UpdateCommand="UPDATE [Instructor] SET [Ins_Name] = @Ins_Name, [Ins_Degree] = @Ins_Degree, [Salary] = @Salary, [Dept_Id] = @Dept_Id WHERE [Ins_Id] = @Ins_Id">
            <DeleteParameters>
                <asp:Parameter Name="Ins_Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Ins_Id" Type="Int32" />
                <asp:Parameter Name="Ins_Name" Type="String" />
                <asp:Parameter Name="Ins_Degree" Type="String" />
                <asp:Parameter Name="Salary" Type="Decimal" />
                <asp:Parameter Name="Dept_Id" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Ins_Name" Type="String" />
                <asp:Parameter Name="Ins_Degree" Type="String" />
                <asp:Parameter Name="Salary" Type="Decimal" />
                <asp:Parameter Name="Dept_Id" Type="Int32" />
                <asp:Parameter Name="Ins_Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</asp:Content>

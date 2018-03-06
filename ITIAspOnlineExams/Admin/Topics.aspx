<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Admin.Master" AutoEventWireup="true" 
    CodeBehind="Topics.aspx.cs" Inherits="ITIAspOnlineExams.Admin.Topics" Theme="Bootstrap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h4>Insert</h4>
    <form id="myForm" runat="server">
        <div class="form-inline">
            <label class="sr-only" for="topicId">ID</label>
            <asp:TextBox type="number" runat="server" ID="topicId" placeholder="ID"></asp:TextBox>

            <label class="sr-only" for="topicName">topic Name</label>
            <asp:TextBox type="text" runat="server" ID="topicName" placeholder="Topic Name"></asp:TextBox>

            <label class="sr-only" for="topicCourse">Course</label>
            <asp:DropDownList ID="topicCourse" runat="server" DataSourceID="CourseDS" 
                DataTextField="Crs_Name" DataValueField="Crs_Id"></asp:DropDownList>

            <asp:SqlDataSource runat="server" ID="CourseDS" ConnectionString='<%$ ConnectionStrings:OnlineExamsProject %>' 
                SelectCommand="SELECT [Crs_Id], [Crs_Name] FROM [Course]"></asp:SqlDataSource>
            
            <asp:Button type="submit" runat="server" CssClass="btn btn-primary" Text="Insert" />
            <Button ID="btnClear" type="button" class="btn btn-secondary mx-1" 
                OnClick="document.getElementById('myForm').reset()">Clear</Button>
        </div>
        <hr />
        <h3>Topics List</h3>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Top_Id" DataSourceID="TopicsDS">
            <Columns>
                <asp:BoundField DataField="Top_Id" HeaderText="Topic ID" ReadOnly="True" SortExpression="Top_Id" />
                <asp:BoundField DataField="Top_Name" HeaderText="Topic Name" SortExpression="Top_Name" />
                <asp:TemplateField HeaderText="Course" SortExpression="Crs_Id">
                    <EditItemTemplate>
                        <asp:DropDownList ID="coursesList" runat="server"
                            SelectedValue='<%# Bind("Crs_Id") %>' DataTextField="Crs_Name" 
                            DataValueField="Crs_Id" DataSourceID="CourseDS">
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Crs_Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="TopicsDS" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineExamsProject %>" 
            DeleteCommand="DELETE FROM [Topic] WHERE [Top_Id] = @Top_Id" 
            InsertCommand="INSERT INTO [Topic] ([Top_Id], [Top_Name], [Crs_Id]) VALUES (@Top_Id, @Top_Name, @Crs_Id)" 
            SelectCommand="SELECT T.*, C.CRS_NAME FROM TOPIC T INNER JOIN COURSE C ON T.CRS_ID = C.CRS_ID" 
            UpdateCommand="UPDATE [Topic] SET [Top_Name] = @Top_Name, [Crs_Id] = @Crs_Id WHERE [Top_Id] = @Top_Id">
            <DeleteParameters>
                <asp:Parameter Name="Top_Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Top_Id" Type="Int32" />
                <asp:Parameter Name="Top_Name" Type="String" />
                <asp:Parameter Name="Crs_Id" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Top_Name" Type="String" />
                <asp:Parameter Name="Crs_Id" Type="Int32" />
                <asp:Parameter Name="Top_Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</asp:Content>

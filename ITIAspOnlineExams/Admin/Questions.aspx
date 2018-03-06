<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Admin.Master" AutoEventWireup="true"
    CodeBehind="Questions.aspx.cs" Inherits="ITIAspOnlineExams.Admin.Questions" Theme="Bootstrap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="myForm" runat="server">
        <h4>Filters</h4>
        <div class="form-inline">
            <label class="sr-only" for="filterByType">Filter By Type</label>
            <asp:DropDownList ID="filterByType" runat="server">
                <asp:ListItem Selected="True" Value=""></asp:ListItem>
                <asp:ListItem Value="MCQ">Multiple Choice</asp:ListItem>
                <asp:ListItem Value="TFQ">True Or False</asp:ListItem>
            </asp:DropDownList>

            <label class="sr-only" for="filterByCourse">Filter By Course</label>
            <asp:DropDownList ID="filterByCourse" runat="server">
                <asp:ListItem Selected="True" Value=""></asp:ListItem>
            </asp:DropDownList>

            <label class="sr-only" for="filterByExam">Filter By Exam</label>
            <asp:TextBox ID="filterByExam" type="number" runat="server" placeholder="Exam ID"></asp:TextBox>

            <asp:Button ID="btnFilter" CssClass="btn btn-primary handButton" runat="server" Text="Filter" OnClick="btnFilter_Click" />
            <asp:Button ID="btnClear" CssClass="btn btn-secondary mx-1 handButton" runat="server" Text="Clear" OnClick="btnClear_Click" />
            <asp:Button ID="btnCreateNew" CssClass="btn btn-success mx-2 handButton" runat="server" Text="New Question..." />
        </div>
        <hr />
        <h3>Questions List</h3>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Qstn_Id" DataSourceID="QuestionsDS">
            <Columns>
                <asp:BoundField DataField="Qstn_Id" HeaderText="ID" ReadOnly="True" SortExpression="Qstn_Id" />
                <asp:BoundField DataField="Qstn_Text" HeaderText="Text" SortExpression="Qstn_Text" />
                <asp:BoundField DataField="Qstn_Type" HeaderText="Type" SortExpression="Qstn_Type" />
                <asp:BoundField DataField="Qstn_Answer" HeaderText="Answer" SortExpression="Qstn_Answer" />
                <asp:TemplateField HeaderText="Course" SortExpression="Crs_Id">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Crs_Name") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Crs_Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="QuestionsDS" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineExamsProject %>"
            DeleteCommand="DELETE FROM [Question] WHERE [Qstn_Id] = @Qstn_Id" 
            SelectCommand="SELECT Q.*, C.CRS_NAME FROM [Question] Q INNER JOIN [COURSE] C ON Q.CRS_ID = C.CRS_ID">
            <DeleteParameters>
                <asp:Parameter Name="Qstn_Id" Type="Int32" />
            </DeleteParameters>
        </asp:SqlDataSource>
    </form>
</asp:Content>

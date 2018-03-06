<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/User.Master" AutoEventWireup="true" CodeBehind="Exam.aspx.cs"
    Inherits="ITIAspOnlineExams.Student.Exam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/exam.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="form-exam">
            <form id="form1" runat="server">
                <div class="row">
                    <asp:GridView ID="questionsGridView" runat="server" AutoGenerateColumns="False" DataSourceID="ExamQuestionsDS"
                        OnRowDataBound="questionsGridView_RowDataBound" DataKeyNames="Qstn_Id,Qstn_stAnswer" AllowPaging="True" PageSize="1"
                        OnPageIndexChanging="questionsGridView_PageIndexChanging" ShowHeader="False"
                        BackColor="#f5f5f5" BorderStyle="None" BorderWidth="0" BorderColor="#f5f5f5" CssClass="table">
                        <Columns>
                            <asp:TemplateField HeaderText="Qstn_Text" SortExpression="Qstn_Text">
                                <ItemTemplate>
                                    <div class="container">
                                        <div class="card">
                                            <div class="card-header p-2">
                                                <asp:Label CssClass="h6" runat="server" Text='<%# Bind("Qstn_Text") %>' ID="Label1"></asp:Label>
                                            </div>
                                            <div class="card-block">
                                                <div class="card-title">
                                                    <asp:GridView ID="choicesGridView" runat="server" AutoGenerateColumns="False"
                                                        DataKeyNames="Chc_Id,Qstn_Id" DataSourceID="ChoicesDS" ShowHeader="false"
                                                        OnSelectedIndexChanged="choicesGridView_SelectedIndexChanged" OnSelectedIndexChanging="choicesGridView_SelectedIndexChanging"
                                                        CssClass="table table-sm" BackColor="White" BorderStyle="None" BorderWidth="0px" BorderColor="White">
                                                        <Columns>
                                                            <asp:TemplateField ShowHeader="False" ItemStyle-Width="100px">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton runat="server" Text="Select" CommandName="Select" CausesValidation="False" ID="LinkButton1"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Chc_Text" HeaderText="Chc_Text" SortExpression="Chc_Text" ShowHeader="False"></asp:BoundField>
                                                        </Columns>
                                                        <SelectedRowStyle Font-Bold="true" Font-Underline="true" ForeColor="Blue" />
                                                    </asp:GridView>
                                                    <asp:SqlDataSource runat="server" ID="ChoicesDS" ConnectionString='<%$ ConnectionStrings:OnlineExamsProject %>'
                                                        SelectCommand="select * from Choice where Qstn_Id = 11"></asp:SqlDataSource>
                                                </div>
                                                <div>
                                                    <asp:Label CssClass="h6" runat="server" ID="lblAnswer"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerSettings Mode="NumericFirstLast" />
                    </asp:GridView>
                    <asp:SqlDataSource runat="server" ID="ExamQuestionsDS" ConnectionString='<%$ ConnectionStrings:OnlineExamsProject %>'
                        SelectCommand=""></asp:SqlDataSource>
                </div>
                <div class="form-group text-right">
                    <asp:Button ID="btnFinish" CssClass="btn btn-primary" runat="server" Text="Finish"
                        OnClick="btnFinish_Click" />
                </div>
                <div class="form-group text-center">
                    <asp:Label ID="lblResult" Visible="false" runat="server" CssClass="h5">Your Result ...</asp:Label>
                </div>
            </form>
        </div>
    </div>

</asp:Content>

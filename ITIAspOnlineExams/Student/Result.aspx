<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/User.Master" AutoEventWireup="true"
    CodeBehind="Result.aspx.cs" Inherits="ITIAspOnlineExams.Student.Result" Theme="Bootstrap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/exam.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="form-exam">
            <form id="form1" runat="server">
                <div class="row">
                    <div class="container">
                        <div class="card">
                            <div class="card-header p-2">
                                <p class="h5">Exam Result</p>
                            </div>
                            <div class="card-block">
                                <div class="card-title">
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" PageSize="5"
                                        DataKeyNames="Exam_Id,Qstn_Id" DataSourceID="ExamResultDS" AllowPaging="True">
                                        <Columns>
                                            <asp:BoundField DataField="Exam_Id" HeaderText="Exam_Id" ReadOnly="True" SortExpression="Exam_Id"></asp:BoundField>
                                            <asp:BoundField DataField="Qstn_Id" HeaderText="Qstn_Id" ReadOnly="True" SortExpression="Qstn_Id"></asp:BoundField>
                                            <asp:BoundField DataField="Qstn_stAnswer" HeaderText="Qstn_stAnswer" SortExpression="Qstn_stAnswer"></asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource runat="server" ID="ExamResultDS" ConnectionString='<%$ ConnectionStrings:OnlineExamsProject %>' 
                                        SelectCommand="SELECT * FROM [Exam_Question]"></asp:SqlDataSource>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group text-right">
                    <asp:Button ID="btnFinish" CssClass="btn btn-primary" runat="server" Text="Finish" />
                </div>
            </form>
        </div>
    </div>

</asp:Content>

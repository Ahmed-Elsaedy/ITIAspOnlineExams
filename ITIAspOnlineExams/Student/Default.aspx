<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/User.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" 
    Inherits="ITIAspOnlineExams.Student.Default" Theme="Bootstrap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/student.css" rel="stylesheet" />
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="form-student">
            <form id="form1" runat="server">
                <div class="form-group row">
                    <label for="selectElement">Available Exams</label>
                    <asp:DropDownList ID="examsList" runat="server">
                    </asp:DropDownList>
                </div>
                <div class="form-group row">
                    <asp:Button ID="btnStart" CssClass="btn btn-primary" runat="server" Text="Start" OnClick="btnStart_Click" />
                </div>
            </form>
        </div>
    </div>
</asp:Content>

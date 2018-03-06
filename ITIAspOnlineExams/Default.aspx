<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ITIAspOnlineExams.Default" %>

<!doctype html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Signin Template for Bootstrap</title>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" />
    <link href="CSS/signin.css" rel="stylesheet" />
</head>
<body class="text-center">
    <form id="form1" runat="server" class="form-signin">
        <asp:Login ID="Login1" runat="server" CssClass="form-signin" OnLoggedIn="Login1_LoggedIn">
            <LayoutTemplate>
                <img class="mb-4" src="https://getbootstrap.com/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72" />
                <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
                <table>
                    <tr>
                        <td style="width: 100%;">
                            <label for="inputEmail" class="sr-only">Email address</label>
                            <asp:TextBox ID="UserName" runat="server"  CssClass="form-control" placeholder="Email address" autofocus="autofocus" required="required"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%;">
                            <label for="inputPassword" class="sr-only">Password</label>
                            <asp:TextBox ID="Password" runat="server" TextMode="Password" type="password" CssClass="form-control" placeholder="Password" required="required"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="checkbox mb-3">
                                <label>
                                    <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me" type="checkbox" value="remember-me" />
                                </label>
                            </div>
                            <asp:Button ID="LoginButton" runat="server" CssClass="btn btn-lg btn-primary btn-block loginBtn" 
                                CommandName="Login" Text="Log In" ValidationGroup="Login1" />
                            <p class="mt-5 mb-3 text-muted">
                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                            </p>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
        </asp:Login>
    </form>
</body>
</html>

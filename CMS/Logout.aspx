<%@ Page Language="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Session("IsAdmin") <> "YES" Then Response.Redirect("Login.aspx")
        Session.Abandon()
    End Sub
    
    Protected Sub btnOK_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If IsAdmin() = True Then
            Session("IsAdmin") = "YES"
            Response.Redirect("Default.aspx")
        Else
            lblMsg.Text = "نام کاربری یا کلمه رمز اشتباه است"
        End If
    End Sub

    Private Function IsAdmin() As Boolean
        Try
            Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
            Dim objSqlCmd As SqlCommand = New SqlCommand()
            Dim objDataReader As SqlDataReader
            '---------------------------------
            objConnection.Open()
            objSqlCmd.Connection = objConnection
            objSqlCmd.CommandText = "SELECT * FROM tblAdmin WHERE ((UN = '" + txtUserName.Text.Trim + "') AND (PW = '" + txtPassword.Text.Trim + "'))"
            objDataReader = objSqlCmd.ExecuteReader
            '---------------------------------
            If objDataReader.HasRows = True Then
                objConnection.Close()
                objConnection = Nothing
                objSqlCmd.Dispose()
                objSqlCmd = Nothing
                Return True
            Else
                objConnection.Close()
                objConnection = Nothing
                objSqlCmd.Dispose()
                objSqlCmd = Nothing
                Return False
            End If
        Catch ex As Exception
            lblMsg.Text = ex.Message
        End Try
    End Function
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>نرم افزار مدیریت اتحادیه صنف پوشاک کرج</title>
</head>

<body>
<form id="form1" runat="server">
<p>&nbsp;</p>
<p>&nbsp;</p>
<table width="674" height="351" border="0" align="center" cellpadding="0" cellspacing="0" background="../images/login.jpg">
  <tr>
    <td width="292" id="TD1">&nbsp;</td>
    <td width="269" align="center"><table width="269" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td style="width: 150px; height: 33px" align="center">
            <asp:TextBox ID="txtUsername" runat="server" Width="136px"></asp:TextBox>
        </td>
        <td width="118" align="center" dir="rtl" style="height: 33px">
            نام کاربری :</td>
      </tr>
      <tr>
        <td style="width: 150px" align="center">
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="136px"></asp:TextBox></td>
        <td align="center" dir="rtl">
            کلمه عبور :</td>
      </tr>
      <tr>
        <td style="width: 150px">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td style="width: 150px" align="center">&nbsp;<asp:Button ID="btnCancel" runat="server" Text="بازگشت به صفحه اصلی" Width="120px" PostBackUrl="~/Default.aspx"/></td>
        <td align="left">&nbsp;<asp:Button ID="btnOK" runat="server" Text="تایید" Width="60px" OnClick="btnOK_Click" /></td>
      </tr>
      <tr>
        <td style="width: 150px">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
        <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label></td>
    <td width="113">&nbsp;</td>
  </tr>
</table>
</form>
</body>
</html>
<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="Untitled Page" %>

<script runat="server">

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
            objConnection.Open()
            Dim objSqlCmd As SqlCommand = New SqlCommand()
            objSqlCmd.Connection = objConnection
            objSqlCmd.CommandText = "INSERT INTO tblPayam(Payam) VALUES ('" & txtPayam.Text.Trim & "')"
            objSqlCmd.ExecuteNonQuery()
            objConnection.Close()
            objConnection = Nothing
            objSqlCmd.Dispose()
            objSqlCmd = Nothing
            txtPayam.Text = ""
            Label1.ForeColor = Drawing.Color.Green
            Label1.Text = "داده جدید با موفقیت ثبت گردید"
        Catch ex As Exception
            Label1.ForeColor = Drawing.Color.Red
            Label1.Text = "به علت بروز خطا امکان ادامه عملیات افزودن داده امکان پذیر نمی باشد"
        End Try
    End Sub
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Session("IsAdmin") <> "YES" Then Response.Redirect("Login.aspx")
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<center>
    &nbsp;</center>
    <center>
        <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>&nbsp;</center>
    <center>
    <br />
    <table>
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
                متن پیام :</td>
            <td style="width: 100px" align="center">
                <asp:TextBox ID="txtPayam" runat="server" Width="232px"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPayam"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        
    </table>
    </center>
    <center>
        &nbsp;</center>
    <center>
        <table>
            <tr>
                <td style="width: 100px; height: 21px">
                    <asp:Button ID="btnSave" runat="server" Text="ثبت" Width="60px" OnClick="btnSave_Click" /></td>
                <td style="width: 100px; height: 21px">
                    <input id="Reset1" type="reset" value="پاک کردن" /></td>
            </tr>
        </table>
    </center>
</asp:Content>


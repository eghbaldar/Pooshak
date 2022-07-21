<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="Untitled Page" %>

<script runat="server">

    Dim StrSql As String
    Dim Result As Object = Nothing

    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'چک کردن درست وارد شدن رمز جدید
        lblMsg.Text = ""

        If TextBox2.Text.Trim.ToLower <> TextBox3.Text.Trim.ToLower Then
            lblMsg.Text = "لطفا تکرار رمز جدید را درست وارد کنید"
            Exit Sub
        End If
        
        'تغییر رمز
        Try
            Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
            objConnection.Open()
            Dim objSqlCmd As SqlCommand = New SqlCommand()
            objSqlCmd.Connection = objConnection
            objSqlCmd.CommandText = "UPDATE tblAdmin SET PW = '" + TextBox3.Text.Trim + "'"
            objSqlCmd.ExecuteNonQuery()
            objConnection.Close()
            objConnection = Nothing
            objSqlCmd.Dispose()
            objSqlCmd = Nothing
            lblMsg.ForeColor = Drawing.Color.Green
            lblMsg.Text = "کلمه رمز با موفقیت تغییر یافت"
        Catch ex As Exception
            lblMsg.ForeColor = Drawing.Color.Red
            lblMsg.Text = "ادامه انجام عملییات میسر نیست"
            'Response.Write(ex.Message)
        End Try

    End Sub
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Session("IsAdmin") <> "YES" Then Response.Redirect("Login.aspx")
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblMsg" runat="server" Font-Size="Large" ForeColor="Red"></asp:Label><br />
    <br />
    <table>
        <tr>
            <td style="width: 129px">
                رمز جدید :</td>
            <td style="width: 125px" dir="ltr">
                <asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td style="width: 129px">تکرار رمز جدید :</td>
            <td style="width: 125px" dir="ltr">
                <asp:TextBox ID="TextBox3" runat="server" TextMode="Password"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox3"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
    </table>
    <br />
    <table>
        <tr>
            <td style="width: 100px">
                <asp:Button ID="btnOk" runat="server" Text="تغییر رمز" Width="60px" OnClick="btnOk_Click" /></td>
            <td style="width: 100px">
                <input id="Reset1" type="reset" value="پاک کردن" /></td>
        </tr>
    </table>
</asp:Content>
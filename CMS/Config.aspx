<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="Untitled Page" %>

<script runat="server">

    Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Page.IsPostBack = False Then
            Try
                If Session("IsAdmin") <> "YES" Then Response.Redirect("Login.aspx")
                objConnection.Open()
                Dim objCmd As New SqlCommand
                Dim objDataReader As SqlDataReader
                objCmd.Connection = objConnection
                objCmd.CommandText = "SELECT * FROM tblConfig WHERE ID=1"
                objDataReader = objCmd.ExecuteReader
                If objDataReader.Read = True Then
                    txtEte.Text = objDataReader("TedadEtelaeyeh").ToString
                    txtLink.Text = objDataReader("TedadLink").ToString
                End If
                objConnection.Close()
                objCmd.Dispose()
                objDataReader.Close()
            Catch ex As Exception
            End Try
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        '
        Try
            objConnection.Open()
            Dim objSqlCmd As New SqlCommand
            objSqlCmd.Connection = objConnection
            objSqlCmd.CommandText = "UPDATE tblConfig SET TedadLink = @TedadLink, TedadEtelaeyeh = @TedadEtelaeyeh WHERE ID = 1"
            objSqlCmd.Parameters.AddWithValue("@TedadLink", Val(txtLink.Text.Trim))
            objSqlCmd.Parameters.AddWithValue("@TedadEtelaeyeh", Val(txtEte.Text.Trim))
            
            objSqlCmd.ExecuteNonQuery()
            objConnection.Close()
            objConnection = Nothing
            objSqlCmd.Dispose()
            objSqlCmd = Nothing
            '===============
            lblMsg.ForeColor = Drawing.Color.Green
            lblMsg.Text = "عملیات با موفقیت انجام شد"
        Catch ex As Exception
            lblMsg.ForeColor = Drawing.Color.Red
            lblMsg.Text = "به علت بروز خطا امکان ادامه عملیات امکان پذیر نمی باشد"
        End Try
        '
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblMsg" runat="server"></asp:Label><br />
    <br />
    <table>
        <tr>
            <td align="right" style="width: 175px">
                تعداد اطلاعیه ها در صفحه اول :</td>
            <td align="right" style="width: 100px">
                <asp:TextBox ID="txtEte" runat="server" Width="50px"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEte"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td align="right" style="width: 175px; height: 21px">
                تعداد لینک ها در صفحه اول :</td>
            <td align="right" style="width: 100px; height: 21px">
                <asp:TextBox ID="txtLink" runat="server" Width="50px"></asp:TextBox></td>
            <td style="width: 100px; height: 21px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLink"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
    </table>
    <br />
    <br />
    <table>
        <tr>
            <td style="width: 100px">
                <asp:Button ID="btnSave" runat="server" Text="ذخیره" Width="60px" OnClick="btnSave_Click" /></td>
            <td style="width: 100px">
                <input id="Reset1" type="reset" value="پاک کردن" /></td>
        </tr>
    </table>
</asp:Content>


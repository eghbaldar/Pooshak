<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="Untitled Page" %>

<script runat="server">

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ServerSavePath As String = Request.PhysicalApplicationPath + "Etelaiiye\"
        If FileUpload1.HasFile Then
            ServerSavePath += FileUpload1.FileName
            FileUpload1.SaveAs(ServerSavePath)
        Else
            Exit Sub
        End If
        
        Try
            Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
            objConnection.Open()
            Dim objSqlCmd As SqlCommand = New SqlCommand()
            objSqlCmd.Connection = objConnection
            objSqlCmd.CommandText = "INSERT INTO tblEtelaeyeh (Titr, Tooltip, FileName) VALUES(@Titr, @Tooltip, @FileName)"
            objSqlCmd.Parameters.AddWithValue("@Titr", txtEteName.Text.Trim)
            objSqlCmd.Parameters.AddWithValue("@Tooltip", txtTooltip.Text.Trim)
            objSqlCmd.Parameters.AddWithValue("@FileName", FileUpload1.FileName)
            objSqlCmd.ExecuteNonQuery()
            objConnection.Close()
            objConnection = Nothing
            objSqlCmd.Dispose()
            objSqlCmd = Nothing
            txtEteName.Text = ""
            txtTooltip.Text = ""
            lblMsg.ForeColor = Drawing.Color.Green
            lblMsg.Text = "داده جدید با موفقیت ثبت گردید"
        Catch ex As Exception
            lblMsg.ForeColor = Drawing.Color.Red
            lblMsg.Text = "به علت بروز خطا امکان ادامه عملیات افزودن داده امکان پذیر نمی باشد"
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Session("IsAdmin") <> "YES" Then Response.Redirect("Login.aspx")
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblMsg" runat="server" Font-Size="Medium"></asp:Label><br />
    <br />
    <table>
        <tr>
            <td align="right" style="width: 100px">
                نام اطلاعیه :</td>
            <td align="right" style="width: 100px">
                <asp:TextBox ID="txtEteName" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEteName"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td align="right" style="width: 100px">
                متن کمکی :</td>
            <td align="right" style="width: 100px">
                <asp:TextBox ID="txtTooltip" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtTooltip"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td align="right" style="width: 100px">
                فایل اطلاعیه :</td>
            <td style="width: 100px">
                <asp:FileUpload ID="FileUpload1" runat="server" Width="300px" BorderWidth="1px" /></td>
            <td style="width: 100px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="FileUpload1"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
    </table>
    <br />
    <table>
        <tr>
            <td style="width: 100px">
                <asp:Button ID="btnSave" runat="server" Text="ذخیره" Width="60px" OnClick="btnSave_Click" /></td>
            <td style="width: 100px">
                <input id="Reset1" size="" type="reset" value="پاک کردن" /></td>
        </tr>
    </table>
    <br />
    <br />
    &nbsp;
</asp:Content>


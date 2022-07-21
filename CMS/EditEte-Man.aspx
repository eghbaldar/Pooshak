<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="Untitled Page" %>

<script runat="server">

    Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
    Dim RequestID
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        RequestID = Request("ID")
        If Page.IsPostBack = False Then
            If RequestID <> 0 Then
                If Session("IsAdmin") <> "YES" Then Response.Redirect("Login.aspx")
                objConnection.Open()
                Dim objCmd As New SqlCommand
                Dim objDataReader As SqlDataReader
                objCmd.Connection = objConnection
                objCmd.CommandText = "SELECT * FROM tblEtelaeyeh WHERE ID=" + RequestID
                objDataReader = objCmd.ExecuteReader
                If objDataReader.Read = True Then
                    txtEteName.Text = objDataReader("Titr").ToString
                    txtTooltip.Text = objDataReader("Tooltip").ToString
                End If
                objConnection.Close()
                objCmd.Dispose()
                objDataReader.Close()
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            objConnection.Open()
            Dim objSqlCmd As New SqlCommand
            objSqlCmd.Connection = objConnection
            objSqlCmd.CommandText = "UPDATE tblEtelaeyeh SET Titr = @Titr, Tooltip = @Tooltip, FileName = @FileName WHERE ID = " & RequestID
            objSqlCmd.Parameters.AddWithValue("@Titr", txtEteName.Text.Trim)
            objSqlCmd.Parameters.AddWithValue("@Tooltip", txtTooltip.Text.Trim)
            objSqlCmd.Parameters.AddWithValue("@Filename", FileUpload1.FileName)
            
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
        <tr style="color: #000000">
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
            <td style="width: 100px; height: 26px;">
                <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="ذخیره" Width="60px" /></td>
            <td style="width: 100px; height: 26px;">
                <input id="Reset1" type="reset" value="پاک کردن" /></td>
        </tr>
    </table>
    <br />
    <br />
    &nbsp;
</asp:Content>


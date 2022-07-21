<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="Untitled Page" %>

<script runat="server">

    Dim PicName As String
    
    Protected Sub btnSendPic_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ServerSavePath As String = Request.PhysicalApplicationPath + "Images\MonasebatPic\"
        If FileUpload1.HasFile Then
            ServerSavePath += FileUpload1.FileName
            FileUpload1.SaveAs(ServerSavePath)
        End If
        'Image1.ImageUrl = ServerSavePath
        Image1.ImageUrl = "~/Images/MonasebatPic/" + FileUpload1.FileName
    End Sub
    
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
            objConnection.Open()
            Dim objSqlCmd As SqlCommand = New SqlCommand()
            objSqlCmd.Connection = objConnection
            PicName = Image1.ImageUrl
            'Response.Write("Picture : " + PicName + "<br />")
            objSqlCmd.CommandText = "INSERT INTO tblMonasebat (PhotoName, Matn, Date) VALUES ('" + Image1.ImageUrl + "', '" + txtMatn.Text.Trim + "', '" + Now.ToShortDateString + "')"
            objSqlCmd.ExecuteNonQuery()
            objConnection.Close()
            objConnection = Nothing
            objSqlCmd.Dispose()
            objSqlCmd = Nothing
            Call ClearForm()
            Label1.ForeColor = Drawing.Color.Green
            Label1.Text = "داده جدید با موفقیت ثبت گردید"
        Catch ex As Exception
            Label1.ForeColor = Drawing.Color.Red
            Label1.Text = "به علت بروز خطا امکان ادامه عملیات افزودن داده امکان پذیر نمی باشد"
        End Try
    End Sub
    
    Private Sub ClearForm()
        txtMatn.Text = ""
        Image1.ImageUrl = ""
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
                عکس مورد نظر :</td>
            <td style="width: 100px" align="center">
                <asp:FileUpload ID="FileUpload1" runat="server" BorderWidth="1px" /></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
                <asp:Button ID="btnSendPic" runat="server" Text="ارسال و نمایش" OnClick="btnSendPic_Click" /></td>
            <td style="width: 100px" align="center">
                <asp:Image ID="Image1" runat="server" Width="201" Height="122" /></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
                متن متحرک</td>
            <td style="width: 100px" align="center">
                <asp:TextBox ID="txtMatn" runat="server" Width="232px"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMatn"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px" align="center">
            </td>
            <td style="width: 100px">
            </td>
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


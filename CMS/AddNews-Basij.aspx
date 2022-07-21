<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="مدیریت خبرها"  ValidateRequest="false" %>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>

<script runat="server">

    Dim PicName As String = ""
    Dim StrSql As String
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
            objConnection.Open()
            Dim objSqlCmd As SqlCommand = New SqlCommand()
            objSqlCmd.Connection = objConnection
            PicName = Image1.ImageUrl
            StrSql = "INSERT INTO tblNews (Date, Titr, Lid, Text, PhotoName, NewsType) VALUES (@Date, @Titr, @Lid, @Text, @PhotoName, 2)"
            objSqlCmd.CommandText = StrSql
            objSqlCmd.Parameters.AddWithValue("@Date", Now.ToShortDateString)
            objSqlCmd.Parameters.AddWithValue("@Titr", txtTitr.Text.Trim)
            objSqlCmd.Parameters.AddWithValue("@Lid", HttpUtility.HtmlEncode(FCKlid.Value))
            objSqlCmd.Parameters.AddWithValue("@Text", HttpUtility.HtmlEncode(FCKmatn.Value))
            objSqlCmd.Parameters.AddWithValue("@PhotoName", PicName)
            objSqlCmd.ExecuteNonQuery()
            objConnection.Close()
            objConnection = Nothing
            objSqlCmd.Dispose()
            objSqlCmd = Nothing
            Call ClearForm()
            Label1.ForeColor = Drawing.Color.Green
            Label1.Text = "خبر جدید با موفقیت ثبت گردید"
        Catch ex As Exception
            Label1.ForeColor = Drawing.Color.Red
            Label1.Text = "به علت بروز خطا امکان ادامه عملیات افزودن داده امکان پذیر نمی باشد"
            'Label1.Text = ex.Message
            'Response.Write(strsql)
        End Try
    End Sub

    Protected Sub btnSendPic_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ServerSavePath As String = Request.PhysicalApplicationPath + "Images\NewsPic\"
        If FileUpload1.HasFile Then
            ServerSavePath += FileUpload1.FileName
            FileUpload1.SaveAs(ServerSavePath)
        End If
        Image1.ImageUrl = "~/Images/NewsPic/" + FileUpload1.FileName
    End Sub
    
    Private Sub ClearForm()
        txtTitr.Text = ""
        FCKlid.Value = ""
        FCKmatn.Value = ""
        Image1.ImageUrl = ""
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Session("IsAdmin") <> "YES" Then Response.Redirect("Login.aspx")
        If Page.IsPostBack = False Then
            FCKlid.Value = "<span style=""font-family:Tahoma; font-size:10pt""></span>"
            FCKmatn.Value = "<span style=""font-family:Tahoma; font-size:10pt""></span>"
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <center>
        <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>&nbsp;</center>
    <center>
        &nbsp;</center>
    <center>
        &nbsp;<asp:Label ID="Label2" runat="server" Font-Bold="False" Font-Size="X-Large"
            Text="قسمت افزودن اخبار  بسیج اتحادیه"></asp:Label></center>
    <center>
        &nbsp;</center>
    <center>
        <table>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; font-size: 17px;" align="left">
                    تیتر خبر :</td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtTitr" runat="server" Width="422px" Font-Names="Tahoma"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitr"
                        ErrorMessage="*"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 100px; height: 58px;">
                </td>
                <td style="width: 100px; font-size: 17px;" align="left">
                    لید خبر :</td>
                <td style="width: 100px; height: 58px;">
                    <FCKeditorV2:FCKeditor ID="FCKlid" runat="server" Width="430px" Height="100" BasePath="~/fckeditor/" ToolbarSet="MyBasic">
                    </FCKeditorV2:FCKeditor>
                </td>
                <td style="width: 100px; height: 58px;">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="FCKLid"
                        ErrorMessage="*"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; font-size: 17px;" align="left">
                    متن خبر :</td>
                <td style="width: 100px">
                    <FCKeditorV2:FCKeditor ID="FCKmatn" runat="server" Width="645px" Height="500px" 
                        BasePath="~/fckeditor/" 
                        ToolbarSet="MyDefault">
                    </FCKeditorV2:FCKeditor>
                </td>
                <td style="width: 100px">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="FCKmatn"
                        ErrorMessage="*"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; font-size: 17px;" align="left">
                    عکس خبر</td>
                <td style="width: 100px">
                    <asp:FileUpload ID="FileUpload1" runat="server" Width="320px" BorderWidth="1px" /></td>
                <td style="width: 100px">
                    </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; font-size: 20px;" align="left">
                    <asp:Button ID="btnSendPic" runat="server" Text="ارسال و پیش نمایش" OnClick="btnSendPic_Click" /></td>
                <td style="width: 100px" align="center">
                    <asp:Image ID="Image1" runat="server" /></td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; font-size: 20px;" align="left">
                </td>
                <td style="width: 100px">
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
                <td style="width: 100px">
                    <asp:Button ID="btnSave" runat="server" Text="ثبت" Width="60px" OnClick="btnSave_Click" /></td>
                <td style="width: 100px">
                    <input id="Reset1" type="reset" value="پاک کردن" /></td>
            </tr>
        </table>
    </center>
</asp:Content>


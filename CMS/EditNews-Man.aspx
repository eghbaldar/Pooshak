<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="Untitled Page"  ValidateRequest="false" %>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>

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
                objCmd.CommandText = "SELECT * FROM tblNews WHERE ID=" + RequestID
                objDataReader = objCmd.ExecuteReader()
                If objDataReader.Read() Then
                    txtTitr.Text = objDataReader("Titr").ToString
                    FCKlid.Value = HttpUtility.HtmlDecode(objDataReader("Lid").ToString)
                    FCKmatn.Value = HttpUtility.HtmlDecode(objDataReader("Text").ToString)
                    Image1.ImageUrl = objDataReader("PhotoName").ToString
                End If
                objConnection.Close()
                objCmd.Dispose()
                objDataReader.Close()
            End If
        End If
    End Sub

    Protected Sub btnSendPic_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ServerSavePath As String = Request.PhysicalApplicationPath + "Images\NewsPic\"
        If FileUpload1.HasFile Then
            ServerSavePath += FileUpload1.FileName
            FileUpload1.SaveAs(ServerSavePath)
        End If
        Image1.ImageUrl = "~/Images/NewsPic/" + FileUpload1.FileName
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        '-----------------------
        If Page.IsPostBack Then
            
            Try
                objConnection.Open()
                Dim objSqlCmd As New SqlCommand
                objSqlCmd.Connection = objConnection
                objSqlCmd.CommandText = "UPDATE tblNews SET Titr = @Titr, Lid = @Lid, Text = @Text , PhotoName = @PhotoName WHERE ID = " + RequestID
                objSqlCmd.Parameters.AddWithValue("@Titr", txtTitr.Text.Trim)
                objSqlCmd.Parameters.AddWithValue("@lid", HttpUtility.HtmlEncode(FCKlid.Value))
                objSqlCmd.Parameters.AddWithValue("@Text", HttpUtility.HtmlEncode(FCKmatn.Value))
                objSqlCmd.Parameters.AddWithValue("@PhotoName", Image1.ImageUrl)
                objSqlCmd.ExecuteNonQuery()
                objConnection.Close()
                objConnection = Nothing
                objSqlCmd.Dispose()
                objSqlCmd = Nothing
                '=================================
                Label1.ForeColor = Drawing.Color.Green
                Label1.Text = "عملیات با موفقیت انجام شد"
                Call ClearForm()
            Catch ex As Exception
                Label1.ForeColor = Drawing.Color.Red
                Label1.Text = "به علت بروز خطا امکان ادامه عملیات امکان پذیر نمی باشد"
                'Label1.Text = ex.Message
            End Try
        End If
    End Sub
    
    Private Sub ClearForm()
        txtTitr.Text = ""
        FCKlid.Value = ""
        FCKmatn.Value = ""
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <center >
        <center>
            <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>&nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            <table>
                <tr>
                    <td style="width: 100px">
                    </td>
                    <td style="font-size: 17px; width: 100px">
                        تیتر خبر :</td>
                    <td style="width: 100px" align="right">
                        <asp:TextBox ID="txtTitr" runat="server" Font-Names="Tahoma" Width="422px"></asp:TextBox></td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitr"
                            ErrorMessage="*"></asp:RequiredFieldValidator></td>
                </tr>
                <tr style="color: #000000">
                    <td style="width: 100px; height: 58px">
                    </td>
                    <td style="font-size: 17px; width: 100px; height: 58px">
                        لید خبر :</td>
                    <td style="width: 100px; height: 58px" align="right">
                        &nbsp;<FCKeditorV2:FCKeditor ID="FCKlid" runat="server" BasePath="~/fckeditor/" Height="100"
                            ToolbarSet="MyBasic" Width="430px">
                        </FCKeditorV2:FCKeditor>
                        </td>
                    <td style="height: 58px">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="FCKlid"
                            ErrorMessage="*"></asp:RequiredFieldValidator></td>
                </tr>
                <tr style="color: #000000">
                    <td style="width: 100px">
                    </td>
                    <td style="font-size: 17px; width: 100px">
                        متن خبر :</td>
                    <td style="width: 100px">
                        &nbsp;<FCKeditorV2:FCKeditor ID="FCKmatn" runat="server" BasePath="~/fckeditor/"
                            Height="500px" ToolbarSet="MyDefault" Width="645px">
                        </FCKeditorV2:FCKeditor>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="FCKmatn"
                            ErrorMessage="*"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                    <td style="font-size: 17px; width: 100px">
                        عکس خبر</td>
                    <td style="width: 100px">
                        <asp:FileUpload ID="FileUpload1" runat="server" Width="320px" BorderWidth="1px" /></td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                    <td style="font-size: 20px; width: 100px">
                        <asp:Button ID="btnSendPic" runat="server" OnClick="btnSendPic_Click" Text="ارسال و پیش نمایش" /></td>
                    <td align="center" style="width: 100px">
                        <asp:Image ID="Image1" runat="server" /></td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                    <td style="font-size: 20px; width: 100px">
                    </td>
                    <td style="width: 100px">
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
            &nbsp;</center>
        <center>
            <table>
                <tr>
                    <td style="width: 100px">
                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="ثبت" Width="60px" /></td>
                    <td style="width: 100px">
                        <input id="Reset1" type="reset" value="پاک کردن" /></td>
                </tr>
            </table>
        </center>
    
    </center>
</asp:Content>


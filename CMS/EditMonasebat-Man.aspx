<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="Untitled Page" %>

<script runat="server">

    Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
    Dim RequestID
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        RequestID = Request("ID")
        If Page.IsPostBack = False Then
            
            If RequestID <> 0 Then
                If Session("IsAdmin") <> "YES" Then Response.Redirect("Login.aspx")
                'Response.Write("request = " & RequestID)
                'Response.Write("<br />")
                objConnection.Open()
                Dim objCmd As New SqlCommand
                Dim objDataReader As SqlDataReader
                objCmd.Connection = objConnection
                objCmd.CommandText = "SELECT * FROM tblMonasebat WHERE ID=" + RequestID
                objDataReader = objCmd.ExecuteReader
                If objDataReader.Read = True Then
                    txtMatn.Text = objDataReader("Matn").ToString
                    Image1.ImageUrl = objDataReader("PhotoName").ToString
                End If
                objConnection.Close()
                objCmd.Dispose()
                objDataReader.Close()
            End If

        End If
        
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        '-----------------------
        Try
            objConnection.Open()
            Dim objSqlCmd As New SqlCommand
            objSqlCmd.Connection = objConnection
            objSqlCmd.CommandText = "UPDATE tblMonasebat SET PhotoName = '" + Image1.ImageUrl + "', Matn = '" + txtMatn.Text.Trim + "', Date = '" + Now.ToShortDateString + "' WHERE ID = " + RequestID
            objSqlCmd.ExecuteNonQuery()
            objConnection.Close()
            objConnection = Nothing
            objSqlCmd.Dispose()
            objSqlCmd = Nothing
            '===============Response.Redirect("ListBook.aspx")
            Label1.ForeColor = Drawing.Color.Green
            Label1.Text = "عملیات با موفقیت انجام شد"
        Catch ex As Exception
            Label1.ForeColor = Drawing.Color.Red
            Label1.Text = "به علت بروز خطا امکان ادامه عملیات امکان پذیر نمی باشد"
            'Label1.Text = ex.Message
        End Try
        
    End Sub

    Protected Sub btnSendPic_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ServerSavePath As String = Request.PhysicalApplicationPath + "MonasebatPic\"
        If FileUpload1.HasFile Then
            ServerSavePath += FileUpload1.FileName
            FileUpload1.SaveAs(ServerSavePath)
        End If
        'Image1.ImageUrl = ServerSavePath
        Image1.ImageUrl = "~/MonasebatPic/" + FileUpload1.FileName
    End Sub
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <center>
        <center>
            <asp:Label id="Label1" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>&nbsp;</center>
        <center>
            <br />
            <table>
                <tr>
                    <td style="width: 100px">
                    </td>
                    <td style="width: 100px">
                        عکس مورد نظر :</td>
                    <td align="center" style="width: 100px">
                        <asp:FileUpload ID="FileUpload1" runat="server" BorderWidth="1px" /></td>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                    <td style="width: 100px">
                        <asp:Button ID="btnSendPic" runat="server" OnClick="btnSendPic_Click" Text="ارسال و نمایش" /></td>
                    <td align="center" style="width: 100px">
                        <asp:Image ID="Image1" runat="server" Width="201" Height="122"/></td>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                    <td style="width: 100px">
                        متن متحرک</td>
                    <td align="center" style="width: 100px">
                        <asp:TextBox ID="txtMatn" runat="server" Width="232px"></asp:TextBox></td>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                    <td style="width: 100px">
                    </td>
                    <td align="center" style="width: 100px">
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
                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="ثبت" Width="60px" /></td>
                    <td style="width: 100px; height: 21px">
                        <input id="Reset1" type="reset" value="پاک کردن" /></td>
                </tr>
            </table>
        </center>
    
    </center>
</asp:Content>


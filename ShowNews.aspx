<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" Title="Untitled Page" %>

<script runat="server">

    Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
    Dim objCmd As New SqlCommand
    Dim objDataReader As SqlDataReader
    Dim RequestID As Integer
    Dim Titr As String
    Dim ImageName As String
    Dim Matn As String
    Dim Matn_Monasebat As String
    Dim News_Date As String
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        RequestID = Request("ID")
        objConnection.Open()
        objCmd.Connection = objConnection
        If RequestID <> 0 Then
            Try
                objCmd.CommandText = "SELECT * FROM tblNews WHERE ID=" + Str(RequestID)
                objDataReader = objCmd.ExecuteReader
                If objDataReader.Read = True Then
                    Dim pt As New PersianToolS.PersinToolsClass 'ايجاد عضو جديد از کلاس******
                    News_Date = pt.DateToPersian(objDataReader("Date").ToString).LongDate
                    Titr = objDataReader("Titr").ToString
                    Matn = objDataReader("Text").ToString
                    Dim Path As String = Mid(objDataReader("PhotoName").ToString, 3)
                    ImageName = "<img src=" + Path + " width=225 height=169>"
                    lblShowDate.Text = "تاریخ درج خبر : " + pt.DateToPersian(objDataReader("Date").ToString).LongDate
                    lblShowCode.Text = "کد خبر : " + Request("ID")
                End If
                objCmd.Dispose()
                objDataReader.Close()
            Catch ex As Exception
            End Try
        End If

        objCmd.Connection = objConnection
        objCmd.CommandText = "SELECT TOP 1 ID, PhotoName, Matn FROM tblMonasebat ORDER BY ID DESC"
        objDataReader = objCmd.ExecuteReader
        If objDataReader.Read = True Then
            Matn_Monasebat = objDataReader("Matn").ToString
        End If
        objCmd.Dispose()
        objDataReader.Close()
        objConnection.Close()
    End Sub
    
    Protected Sub btnSend_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        '
        If Request("ID") <> 0 Then
            Try
                Dim Mail As New SendEmail
                Dim Body As String = "از طرف : " + txtName_1.Text.Trim + vbCrLf + "به ادرس زیر مراجعه کن" + vbCrLf + Request.Url.AbsoluteUri + vbCrLf + txtBody.Text.Trim
                Mail.SendMessage("اتحادیه صنف پوشاک فروشان کرج", Body, "Info@Atropatgan.net", txtEmail.Text.Trim)
            Catch ex As Exception
            End Try
        End If
        '
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <table style="width: 100%">
        <tr>
            <td>
                <asp:Label ID="lblShowCode" runat="server" ForeColor="#404000" Font-Size="Small"></asp:Label></td>
            <td>
            </td>
            <td align="left">
                    <asp:Label ID="lblShowDate" runat="server" Font-Size="Small" ForeColor="#404000"></asp:Label>
            </td> 
        </tr>
    </table>
    <hr />
    <table width="666" border="0" cellspacing="0" cellpadding="0" dir="ltr" class="style3" style="style3">
      <tr>
        <td width="225"><br /><%Response.Write(ImageName)%></td>
        <td width="12">&nbsp;</td>
        <td width="429" dir="rtl" style="font-size: large" class="style3">
            <%=Titr%>
        </td>
      </tr>
      <tr align="right" dir="rtl">
        <td colspan="3" style="font-size: small; vertical-align: top; text-align: right;" class="style3" valign="top">
            <br />
            <%=HttpUtility.HtmlDecode(Matn)%>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server"  Font-Size=Small  ForeColor=green><%=News_Date%></asp:Label>
        </td>
      </tr>
    </table>
    <hr />
    <asp:Label ID="Label2" runat="server" Font-Bold="True" Text="ارسال خبر برای دوستان"></asp:Label>
    <br />
    <table>
        <tr>
            <td style="width: 141px">
                نام شما :</td>
            <td style="width: 100px">
                <asp:TextBox ID="txtName_1" runat="server" Width="224px"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName_1"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td style="width: 141px">
                نام شخص گیرنده :</td>
            <td style="width: 100px">
                <asp:TextBox ID="txtName_2" runat="server" Width="224px"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtName_2"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td style="width: 141px">
                ایمیل شخص گیرنده :</td>
            <td style="width: 100px">
                <asp:TextBox ID="txtEmail" runat="server" Width="224px"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td style="width: 141px">
                پیام( اختیاری) :</td>
            <td style="width: 100px">
                <asp:TextBox ID="txtBody" runat="server" Height="112px" TextMode="MultiLine" Width="224px"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtBody"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td style="width: 141px">
            </td>
            <td style="width: 100px">
                <div style="text-align: center">
                    <asp:Button ID="btnSend" runat="server" Text="ارسال" Width="88px" OnClick="btnSend_Click" />&nbsp;</div>
            </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 141px; height: 20px">
            </td>
            <td>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="ادرس ایمیل شخص گیرنده را درست وارد کنید" Font-Size="Small" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
            <td style="width: 100px; height: 20px">
            </td>
        </tr>
    </table>
    <hr />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="آخرین خبرها :"></asp:Label><br />
    <br />
    <asp:DataList ID="DataList1" runat="server" DataKeyField="ID" DataSourceID="SqlDataSource2">
        <ItemTemplate>
            <a href='ShowNews.aspx?id=<%# Eval("ID")%>'>
                <%# Eval("Titr") %>
            </a>
            <br />
            <br />
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT TOP (10) ID, Titr FROM tblNews ORDER BY ID DESC">
    </asp:SqlDataSource>
    <br />
</asp:Content>
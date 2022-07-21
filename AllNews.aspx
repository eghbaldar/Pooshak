<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" Title="Untitled Page" %>

<script runat="server">

    'Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
    'Dim Matn_Monasebat As String

    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
    '    Try
    '        objConnection.Open()
    '        Dim objCmd As New SqlCommand
    '        Dim objDataReader As SqlDataReader
    '        objCmd.Connection = objConnection
    '        objCmd.CommandText = "SELECT ID, Date, Titr FROM tblNews ORDER BY ID DESC"
    '        objDataReader = objCmd.ExecuteReader
    '        '===========================================
    '        Do While objDataReader.Read
    '            Dim r As New TableRow()
    '            Dim c1 As New TableCell()
    '            Dim c2 As New TableCell()
    '            '---------
    '            'c1.Width = 100
    '            c1.Height = 30
                
    '            Dim pt As New PersianToolS.PersinToolsClass 'ÇíÌÇÏ ÚÖæ ÌÏíÏ ÇÒ ˜áÇÓ******
    '            c1.Text = "&nbsp; &nbsp; &nbsp; &nbsp;" + pt.DateToPersian(objDataReader("Date").ToString).LongDate + "&nbsp; &nbsp; &nbsp; &nbsp;"
                
    '            'c1.Text = CDate(objDataReader("Date").ToString).ToShortDateString
    '            c2.Text = "<a href=ShowNews.aspx?ID=" + objDataReader("ID").ToString + ">" + objDataReader("Titr").ToString + "</a>"
    '            '---------
    '            r.Cells.Add(c1)
    '            r.Cells.Add(c2)
    '            '---------
    '            Table1.Rows.Add(r)
    '        Loop
    '        objCmd.Dispose()
    '        objDataReader.Close()
    '        '===========================================
    '        objCmd.CommandText = "SELECT TOP 1 ID, PhotoName, Matn FROM tblMonasebat ORDER BY ID DESC"
    '        objDataReader = objCmd.ExecuteReader()
    '        If objDataReader.Read = True Then
    '            Matn_Monasebat = objDataReader("Matn").ToString
    '        End If
    '        objCmd.Dispose()
    '        objDataReader.Close()
    '        '===========================================
    '        objConnection.Close()
    '    Catch ex As Exception
    '    End Try
    'End Sub
    
    Private Function ConvertDate(ByVal d As Date) As String
        Dim pt As New PersianToolS.PersinToolsClass 'ÇíÌÇÏ ÚÖæ ÌÏíÏ ÇÒ ˜áÇÓ******
        Return pt.DateToPersian(d).LongDate
    End Function
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
<asp:Panel ID="Panel1" runat="server" BackColor="White" BorderColor="Black"
            BorderWidth="1px" Height="370px" ScrollBars="Vertical" Width="670px" Font-Size="Small">
    <br />
      <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <HeaderTemplate>
          <table>
        </HeaderTemplate>
        <ItemTemplate>
          <tr>
            <td>
              <a href=shownews.aspx?id=<%# Eval("ID") %>><%# Eval("Titr") %></a>
            </td>
            <td>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(<asp:Label runat="server" ID="Label1" Font-Size=Smaller ForeColor=brown  Text='<%# ConvertDate(Eval("Date"))%>'/>)
              <br />
            </td>
          </tr>
        </ItemTemplate>
        <FooterTemplate>
          </table>
        </FooterTemplate>
        
      </asp:Repeater>
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT ID, Date, Titr FROM tblNews WHERE (NewsType = @NewsType) ORDER BY ID DESC">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="" Name="NewsType" QueryStringField="Cat" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Panel>
</asp:Content>


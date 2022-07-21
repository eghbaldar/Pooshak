<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="Untitled Page" %>

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Session("IsAdmin") <> "YES" Then Response.Redirect("Login.aspx")
    End Sub

    Private Function Conv(ByVal d As Date) As String
        Dim FarsiDate As New PersianToolS.PersinToolsClass 'ايجاد عضو جديد از کلاس******
        Return FarsiDate.DateToPersian(d).LongDate
    End Function
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <center>
        &nbsp;</center>
    <center>
        <asp:GridView ID="gvNews" runat="server" AllowPaging="True" AllowSorting="True" CssClass="tablecloth-theme"
            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSource1"
            ForeColor="#333333" Width="712px">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="شماره خبر" InsertVisible="False" ReadOnly="True"
                    SortExpression="ID" />
                <asp:BoundField DataField="Titr" HeaderText="تیتر خبر" SortExpression="Titr" />
                <asp:TemplateField HeaderText="تاریخ درج">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text=""><%#Conv(Eval("Date"))%></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ButtonType="Button" DeleteText="حذف" HeaderText="حذف خبر" ShowDeleteButton="True" />
                <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="EditNews-Man.aspx?ID={0}"
                    HeaderText="اصلاح خبر" Text="اطلاح" />
                <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="~/ShowNews.aspx?ID={0}"
                    HeaderText="مشاهده خبر" Text="مشاهده" />
            </Columns>
            <RowStyle BackColor="#EFF3FB" />
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
            <EmptyDataTemplate>
                <asp:Label ID="Label1" runat="server" Font-Size="Large" ForeColor="Red" Text="هیچ گونه اطلاعاتی در این بخش موجود نمی باشد."></asp:Label>
            </EmptyDataTemplate>
        </asp:GridView>
        &nbsp;</center>
    <center>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            DeleteCommand="DELETE FROM [tblNews] WHERE [ID] = @ID" SelectCommand="SELECT ID, Titr, Date FROM tblNews WHERE (NewsType = 2) ORDER BY ID DESC">
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32" />
            </DeleteParameters>
        </asp:SqlDataSource>
        &nbsp;
        &nbsp; &nbsp;</center>
</asp:Content>


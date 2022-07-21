<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="Untitled Page" %>

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Session("IsAdmin") <> "YES" Then Response.Redirect("Login.aspx")
    End Sub

    Private Function Conv(ByVal d As Date) As String
        Dim FarsiDate As New PersianTools.PersinToolsClass 'ايجاد عضو جديد از کلاس******
        Return FarsiDate.DateToPersian(d).LongDate
    End Function
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <center>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" CssClass="tablecloth-theme"
            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSource1"
            ForeColor="#333333" PageSize="5">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="شماره" InsertVisible="False" ReadOnly="True"
                    SortExpression="ID" />
                <asp:TemplateField HeaderText="تاریخ">
                    <ItemTemplate>
                        <br />
                        <asp:Label ID="Label2" runat="server" Text=""><%#Conv(Eval("Date"))%></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>                
                <asp:BoundField DataField="Matn" HeaderText="متن" SortExpression="Matn" />
                <asp:TemplateField HeaderText="سایز">
                    <ItemTemplate >
                        <asp:Image ID="Image1" runat="server" ImageUrl=<%#Eval("PhotoName")%> Width="201" Height="122" />
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:ButtonField ButtonType="Button" CommandName="Delete" HeaderText="حذف رکورد"
                    ShowHeader="True" Text="حذف" />
                <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="EditMonasebat-Man.aspx?ID={0}"
                    HeaderText="اصلاح رکورد" Text="اطلاح" />
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            DeleteCommand="DELETE FROM [tblMonasebat] WHERE [ID] = @ID" InsertCommand="INSERT INTO [tblMonasebat] ([Date], [Matn], [PhotoName]) VALUES (@Date, @Matn, @PhotoName)"
            SelectCommand="SELECT [ID], [Date], [Matn], [PhotoName] FROM [tblMonasebat] ORDER BY [ID] DESC"
            UpdateCommand="UPDATE [tblMonasebat] SET [Date] = @Date, [Matn] = @Matn, [PhotoName] = @PhotoName WHERE [ID] = @ID">
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Date" Type="DateTime" />
                <asp:Parameter Name="Matn" Type="String" />
                <asp:Parameter Name="PhotoName" Type="String" />
                <asp:Parameter Name="ID" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="Date" Type="DateTime" />
                <asp:Parameter Name="Matn" Type="String" />
                <asp:Parameter Name="PhotoName" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
    
    </center>
</asp:Content>


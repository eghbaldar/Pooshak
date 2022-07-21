<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSource1" ForeColor="#333333"
        Width="344px">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="ID" />
            <asp:BoundField DataField="Titr" HeaderText="نام اطلاعیه" SortExpression="Titr" />
            <asp:BoundField DataField="Tooltip" HeaderText="متن کمکی" SortExpression="Tooltip" />
            <asp:BoundField DataField="FileName" HeaderText="نام فایل" SortExpression="FileName" />
            <asp:CommandField ButtonType="Button" DeleteText="حذف" HeaderText="حذف رکورد" ShowDeleteButton="True"
                ShowHeader="True" />
            <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="EditEte-Man.aspx?ID={0}"
                HeaderText="اطلاح رکورد" Text="اصلاح..." />
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [tblEtelaeyeh] WHERE [ID] = @original_ID AND [Titr] = @original_Titr AND [FileName] = @original_FileName AND [Tooltip] = @original_Tooltip"
        InsertCommand="INSERT INTO [tblEtelaeyeh] ([Titr], [FileName], [Tooltip]) VALUES (@Titr, @FileName, @Tooltip)"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID], [Titr], [FileName], [Tooltip] FROM [tblEtelaeyeh] ORDER BY [ID] DESC"
        UpdateCommand="UPDATE [tblEtelaeyeh] SET [Titr] = @Titr, [FileName] = @FileName, [Tooltip] = @Tooltip WHERE [ID] = @original_ID AND [Titr] = @original_Titr AND [FileName] = @original_FileName AND [Tooltip] = @original_Tooltip">
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Titr" Type="String" />
            <asp:Parameter Name="original_FileName" Type="String" />
            <asp:Parameter Name="original_Tooltip" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Titr" Type="String" />
            <asp:Parameter Name="FileName" Type="String" />
            <asp:Parameter Name="Tooltip" Type="String" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Titr" Type="String" />
            <asp:Parameter Name="original_FileName" Type="String" />
            <asp:Parameter Name="original_Tooltip" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Titr" Type="String" />
            <asp:Parameter Name="FileName" Type="String" />
            <asp:Parameter Name="Tooltip" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <center>
        &nbsp;</center>
</asp:Content>


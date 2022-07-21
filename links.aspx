<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <a href=<%# Eval("URL") %> target=_blank ><%# Eval("Tozihat") %></a>
            <br />
            <br />
        </ItemTemplate>
    </asp:DataList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT [Tozihat], [URL] FROM [tblLinks] ORDER BY [ID] DESC"></asp:SqlDataSource>
</asp:Content>
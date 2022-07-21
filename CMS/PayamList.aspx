<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
        DataKeyNames="ID" DataSourceID="SqlDataSource1" ForeColor="#333333" Width="408px">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="شماره ردیف">
                <ItemTemplate>
                    <br />
                    <asp:Label ID="Label2" runat="server" Text=""><%#DataBinder.Eval(Container, "DataItemIndex") + 1%></asp:Label>
                </ItemTemplate>
                <HeaderStyle Width="10%" />
            </asp:TemplateField>
            <asp:BoundField DataField="Payam" HeaderText="متن پیام" SortExpression="Payam" />
            <asp:CommandField ButtonType="Button" CancelText="انصراف" EditText="اصلاح" ShowEditButton="True"
                UpdateText="بروزرسانی">
                <HeaderStyle Width="10%" />
            </asp:CommandField>
            <asp:CommandField ButtonType="Button" DeleteText="حذف رکورد" ShowDeleteButton="True">
                <HeaderStyle Width="15%" />
            </asp:CommandField>
        </Columns>
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [tblPayam] WHERE [ID] = @original_ID AND [Payam] = @original_Payam"
        InsertCommand="INSERT INTO [tblPayam] ([Payam]) VALUES (@Payam)" OldValuesParameterFormatString="original_{0}"
        SelectCommand="SELECT [ID], [Payam] FROM [tblPayam] ORDER BY [ID] DESC" UpdateCommand="UPDATE [tblPayam] SET [Payam] = @Payam WHERE [ID] = @original_ID AND [Payam] = @original_Payam">
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Payam" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Payam" Type="String" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Payam" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Payam" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>


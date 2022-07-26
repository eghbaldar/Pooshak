<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage2.master" Title="Untitled Page" %>

<script runat="server">

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        '
        Try
            Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
            objConnection.Open()
            Dim objSqlCmd As SqlCommand = New SqlCommand()
            objSqlCmd.Connection = objConnection

            'Response.Write("Picture : " + PicName + "<br />")
            objSqlCmd.CommandText = "INSERT INTO tblLinks(Tozihat, URL) VALUES(@Tozihat,@URL)"
            objSqlCmd.Parameters.AddWithValue("@Tozihat", txtLink.Text.Trim)
            objSqlCmd.Parameters.AddWithValue("@URL", txtURL.Text.Trim)
            objSqlCmd.ExecuteNonQuery()
            objConnection.Close()
            objConnection = Nothing
            objSqlCmd.Dispose()
            objSqlCmd = Nothing
            txtLink.Text = ""
            txtURL.Text = ""
            lblMsg.ForeColor = Drawing.Color.Green
            lblMsg.Text = "داده جدید با موفقیت ثبت گردید"
            GridView1.DataBind()
        Catch ex As Exception
            lblMsg.ForeColor = Drawing.Color.Red
            lblMsg.Text = "به علت بروز خطا امکان ادامه عملیات افزودن داده امکان پذیر نمی باشد"
            'Response.Write(ex.Message)
        End Try
        '
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Session("IsAdmin") <> "YES" Then Response.Redirect("Login.aspx")
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="text-align: center">
        <div style="text-align: center">
            <table style="vertical-align: top; width: 664px; text-align: center">
                <tr>
                    <td style="width: 100px; vertical-align: top; text-align: center;" align="center">
                        <asp:Label ID="Label3" runat="server" ForeColor="Blue" Text="توجه : ادرس اینترنتی را حتما باید با //:http شروع کنید"
                            Width="552px"></asp:Label><br />
                        <br />
                        <asp:Label ID="lblMsg" runat="server" Width="328px"></asp:Label><br />
                        <table>
                            <tr>
                                <td align="right" style="width: 81px">
                                    <asp:Label ID="Label1" runat="server" Text="نام لینک :" Width="100px"></asp:Label></td>
                                <td align="right" style="width: 10px">
                                    <asp:TextBox ID="txtLink" runat="server" ValidationGroup="Insert"></asp:TextBox></td>
                                <td style="width: 100px">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtLink"
                                        ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator></td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 81px">
                                    <asp:Label ID="Label2" runat="server" Text="ادرس اینترنتی :" Width="100px"></asp:Label></td>
                                <td style="width: 10px">
                                    <asp:TextBox ID="txtURL" runat="server" Width="216px" ValidationGroup="Insert"></asp:TextBox></td>
                                <td style="width: 100px">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtURL"
                                        ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator></td>
                            </tr>
                        </table>
                        <br />
                        <div style="text-align: center" align="center">
                            <table style="width: 256px">
                                <tr>
                                    <td style="width: 100px">
                                    </td>
                                    <td style="width: 100px">
                                        <asp:Button ID="btnSave" runat="server" Text="ثبت" OnClick="btnSave_Click" Width="60px" ValidationGroup="Insert" /></td>
                                    <td style="width: 100px">
                                        <input id="Reset1" type="reset" value="پاک کردن" /></td>
                                </tr>
                            </table>
                        </div>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; vertical-align: top; text-align: center;" align="center">
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                            CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSource1" ForeColor="#333333"
                            Width="336px">
                            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container, "DataItemIndex") + 1%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="ID" HeaderText="ردیف" InsertVisible="False" ReadOnly="True"
                                    SortExpression="ID" Visible="False" />
                                <asp:BoundField DataField="Tozihat" HeaderText="نام لینک" SortExpression="Tizihat" />
                                <asp:BoundField DataField="URL" HeaderText="ادرس اینترنتی" SortExpression="URL" />
                                <asp:CommandField ButtonType="Button" CancelText="انصزاف" EditText="اطلاح" ShowEditButton="True"
                                    UpdateText="بروزرسانی" />
                                <asp:CommandField ButtonType="Button" DeleteText="حذف" ShowDeleteButton="True" />
                            </Columns>
                            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                            DeleteCommand="DELETE FROM [tblLinks] WHERE [ID] = @original_ID AND [Tozihat] = @original_Tozihat AND [URL] = @original_URL" SelectCommand="SELECT [ID], [Tozihat], [URL] FROM [tblLinks] ORDER BY [ID] DESC"
                            UpdateCommand="UPDATE [tblLinks] SET [Tozihat] = @Tozihat, [URL] = @URL WHERE [ID] = @original_ID AND [Tozihat] = @original_Tozihat AND [URL] = @original_URL" ConflictDetection="CompareAllValues" InsertCommand="INSERT INTO [tblLinks] ([Tozihat], [URL]) VALUES (@Tozihat, @URL)" OldValuesParameterFormatString="original_{0}">
                            <DeleteParameters>
                                <asp:Parameter Name="original_ID" Type="Int32" />
                                <asp:Parameter Name="original_Tozihat" Type="String" />
                                <asp:Parameter Name="original_URL" Type="String" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="Tozihat" Type="String" />
                                <asp:Parameter Name="URL" Type="String" />
                                <asp:Parameter Name="original_ID" Type="Int32" />
                                <asp:Parameter Name="original_Tozihat" Type="String" />
                                <asp:Parameter Name="original_URL" Type="String" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="Tozihat" Type="String" />
                                <asp:Parameter Name="URL" Type="String" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>


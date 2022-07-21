<%@ Page Language="VB" MasterPageFile="~/CMS/MasterPage.master" Title="Untitled Page" %>

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Session("IsAdmin") <> "YES" Then Response.Redirect("Login.aspx")
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <center>
        &nbsp;</center>        
    <center>
        <asp:Label ID="Label1" runat="server" Font-Size="X-Large" Text="به بخش مدیریت خوش امدید" Width="360px"></asp:Label>
    </center>
    <br />
    <br />
<script language="javascript">
<!-- 
function NavIn(menItem) {
	menItem.style.borderColor='#990000'; 
	menItem.style.backgroundColor='#D7D9E2';
}
function NavOut(menItem) {
	menItem.style.borderColor='#B9D1E3';
	menItem.style.backgroundColor='#B9D1E3';
}
//   -->
</script>    
    <table width="500" cellspacing="15" style="text-align: center">
        <tr>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href="../Default.aspx">
                        <asp:image ID="Image10" runat="server" class="adminThumb" ImageUrl="~/Images/Admin/home.gif" />
                        <br />
                        [  صفحه اصلی  ]
                    </a>
                </center>
            </td>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=Config.aspx >
                        <asp:image ID="Image11" runat="server" class="adminThumb" ImageUrl="~/Images/Admin/config_site.gif" />
                        <br />
                        [ تنظیمات سایت ]
                    </a>
                </center>
            </td>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=Amar.aspx>
                        <asp:image ID="Image19" runat="server" class="adminThumb" ImageUrl="~/Images/Admin/man_stats.gif" Height="48px" Width="48px" />
                        <br />
                        [  امار بازدید کنندگان  ]
                    </a>
                </center>
            </td>
        </tr>
        <tr>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href="AddNews-Man.aspx">
                        <asp:image ID="Image13" runat="server" class="adminThumb" ImageUrl="~/Images/Admin/AddNews.gif" />
                        <br />
                        [  افزودن خبر  ]
                    </a>
                </center>
            </td>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=newsList.aspx>
                        <asp:image ID="Image17" runat="server" class="adminThumb" ImageUrl="~/Images/Admin/NewsList.gif" />
                        <br />
                        [  لیست خبرها  ]
                    </a>
                </center>
            </td>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=AddMonasebat-Man.aspx>
                        <asp:image ID="Image14" runat="server" class="adminThumb" ImageUrl="~/Images/Admin/Monasebat.gif" />
                        <br />
                        [  مناسبت  ]
                    </a>
                </center>
            
            </td>
        </tr>
        <tr>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=MonasebatList.aspx>
                    <asp:image ID="Image18" runat="server" class="adminThumb" ImageUrl="~/Images/Admin/MonasebatList.gif" />
                    <br />
                    [  لیست مناسبتها  ]
                    </a>
                </center>
            </td>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=ChangePass.aspx>
                        <asp:image ID="Image16" runat="server" class="adminThumb" ImageUrl="~/Images/Admin/password.gif" />
                        <br />
                        [  تغییر کلمه عبور  ]
                    </a>
                </center>
     
            </td>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=logout.aspx>
                        <asp:image ID="Image12" runat="server" class="adminThumb" ImageUrl="~/Images/Admin/logout.gif" />
                        <br />
                        [  خروج  ]
                    </a>
                </center>            
            </td>
        </tr>
        <tr>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=Link-Man.aspx>
                    <asp:image ID="Image1" runat="server" class="adminThumb" Height="50px" ImageUrl="~/Images/Admin/man_url.gif" Width="50px" />
                    <br />
                    [  مدیریت لینک ها  ]
                    </a>
                </center>
            </td>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=AddEte-Man.aspx>
                        <asp:image ID="Image2" runat="server" class="adminThumb" />
                        <br />
                        [ افزودن اطلاعیه جدید ]
                    </a>
                </center>
     
            </td>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=Ete-list.aspx>
                        <asp:image ID="Image3" runat="server" class="adminThumb" />
                        <br />
                        [ لیست اطلاعیه ها ]
                    </a>
                </center>            
            </td>
        </tr>
        <tr>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=AddPayam-Man.aspx>
                    <asp:image ID="Image4" runat="server" class="adminThumb" />
                    <br />
                    [ پیام روز ]
                    </a>
                </center>
            </td>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=PayamList.aspx>
                        <asp:image ID="Image5" runat="server" class="adminThumb" />
                        <br />
                        [ لیست پیام ها ]
                    </a>
                </center>
     
            </td>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=AddNews-Basij.aspx>
                        <asp:image ID="Image6" runat="server" class="adminThumb" />
                        <br />
                        [ اخبار بسیج ]
                    </a>
                </center>            
            </td>
        </tr>
        <tr>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=NewsList-Basij.aspx>
                    <asp:image ID="Image7" runat="server" class="adminThumb" />
                    <br />
                    [ لیست خبرهای بسیج ]
                    </a>
                </center>
            </td>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=AddNews-Sport.aspx>
                        <asp:image ID="Image8" runat="server" class="adminThumb" />
                        <br />
                        [ اخبار ورزشی ]
                    </a>
                </center>
     
            </td>
            <td class="adminHome" onmouseover="NavIn(this)" onmouseout="NavOut(this)" valign="middle">
                <center>
                    <a href=NewsList-Sport.aspx>
                        <asp:image ID="Image9" runat="server" class="adminThumb" />
                        <br />
                        [ لیست خبرهای ورزشی ]
                    </a>
                </center>            
            </td>
        </tr>
    </table>    
</asp:Content>


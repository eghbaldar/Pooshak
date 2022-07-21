<%@ Page Language="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
    Dim objCmd As New SqlCommand
    Dim objDataReader As SqlDataReader
    Dim Matn_Monasebat As String
    Dim Payam As String
    Dim Rabet As New clsUtility
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        '================================================================================
        'نمايش عکس و متن مربوط به مناسبت ها
        objConnection.Open()
        objCmd.Connection = objConnection
        objCmd.CommandText = "SELECT TOP 1 ID, PhotoName, Matn FROM tblMonasebat ORDER BY ID DESC"
        objDataReader = objCmd.ExecuteReader
        If objDataReader.Read = True Then
            Matn_Monasebat = objDataReader("Matn").ToString
        End If
        objCmd.Dispose()
        objDataReader.Close()
        objConnection.Close()
        '================================================================================
        'نمایش پیام روز    
        Payam = Rabet.ExcuteQ("SELECT TOP 1 Payam FROM tblPayam ORDER BY NewID()")
        '================================================================================
    End Sub
    
    Protected Sub tbnSend_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim EMail1 As New SendEmail
        Dim Body As String = txtSender.Text.Trim + vbCrLf + vbCrLf + txtNote.Text.Trim
        Dim Maghsad As String = ""
        
        Select Case ddlRecive.SelectedIndex
            Case 0
                Maghsad = "Seddigh@pooshakkaraj.ir"
            Case 1
                Maghsad = "kazemi@pooshakkaraj.ir"
            Case 2
                Maghsad = "kazemi@pooshakkaraj.ir"
            Case 3
                Maghsad = "info@pooshakkaraj.ir"
            Case 4
                Maghsad = "kazemi@pooshakkaraj.ir"
            Case 5
                Maghsad = "info@pooshakkaraj.ir"
        End Select
        
        Try
            EMail1.SendMessage(txtSubject.Text.Trim, Body, txtEmail.Text.Trim, Maghsad)
            lblMessage.ForeColor = Drawing.Color.Green
            lblMessage.Text = "پیام شما برای مدیریت سایت ارسال شد"
        Catch ex As Exception
            lblMessage.ForeColor = Drawing.Color.Red
            lblMessage.Text = "پیام شما بدلیل خطا ارسال نشد"
        End Try
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>ارتباط با ما</title>
<style type="text/css">
<!--
.style2 {font-size: 12px}
.style3 {font-family: Tahoma; font-size: 5px; }
.style4 {font-family: Tahoma; font-size: 12px; font-weight: bold; }
a:link {
	text-decoration: none;
	color: #003366;
}
a:visited {
	text-decoration: none;
	color: #006699;
}
a:hover {
	text-decoration: none;
}
a:active {
	text-decoration: none;
}
body {
	background-image: url(images/background.jpg);
}
.style6 {font-family: Tahoma; font-size: 13px; }
-->
</style>
<script type="text/javascript" language="JavaScript1.2" src="stmenu.js"></script>
</head>
<body style="vertical-align: top; text-align: center">
    <form id="form1" runat="server">
    <div>
<table width="929" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="230"><img src="images/001.jpg" width="230" height="228"></td>
    <td width="392" background="images/002.jpg"><table width="348" height="198" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td style="height: 49px"><p>&nbsp;</p>
          </td>
      </tr>
      <tr>
        <td><marquee class="style4" direction="right"><%=Payam%></marquee></td>
      </tr>
    </table></td>
    <td width="307"><img src="images/003.jpg" width="307" height="228"></td>
  </tr>
</table>
<table width="929" height="40" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#eeeeee" style="height: 40px"><table width="929" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td>
<script type="text/javascript" language="JavaScript1.2">
stm_bm(["menu55be",600,"","blank.gif",0,"","",0,0,0,0,50,1,0,0,"","",0,0,1,0,"default","hand",""],this);
stm_bp("p0",[0,4,0,0,1,4,0,7,100,"",-2,"",-2,90,1,1,"#999999","transparent","",3,0,0,"#FFFFFF"]);
stm_ai("p0i0",[0,"کميسيون ها","","",-1,-1,0,"komision.aspx","_self","","","","",0,0,0,"arrow_r.gif","arrow_r.gif",7,7,0,1,1,"#FFFFFF",1,"#FFFFFF",1,"xp3.gif","xp4.gif",3,3,1,1,"#CCCCCC","#999999","#333333","#000000","bold 8pt tahoma","bold 8pt Tahoma",0,0],140,30);
stm_bpx("p1","p0",[1,4,0,0,1,4,0,0]);
stm_aix("p1i0","p0i0",[0,"رسيدگي به شکايات","","",-1,-1,0,"komisiyon-shekayat.aspx","_self","","","","",0,0,0,"","",0,0,0,1,1,"#FFFFFF",1,"#FFFFFF",1,"xp3.gif","xp4.gif",3,3,1,1,"#CCCCCC","#999999","#333333","#000000","bold 8pt Tahoma"],138,0);
stm_aix("p1i1","p1i0",[0,"کميسيون آموزش","","",-1,-1,0,"komisiyon-amoozesh.aspx"],138,0);
stm_aix("p1i2","p1i0",[0,"کميسيون فني","","",-1,-1,0,"komisiyon-fani.aspx"],138,0);
stm_aix("p1i3","p1i0",[0,"حل اختلاف","","",-1,-1,0,"komisiyon-haleekhtelaf.aspx"],138,0);
stm_aix("p1i4","p1i0",[0,"بازرسي ","","",-1,-1,0,"komisiyon-bazresi.aspx"],138,0);
stm_ep();
stm_aix("p0i1","p1i0",[0,"بخش امور اعضا","","",-1,-1,0,"","_self","","","","",0,0,0,"arrow_r.gif","arrow_r.gif",7,7],140,30);
stm_bpx("p2","p1",[]);
stm_aix("p2i0","p1i0",[0,"مدارک","","",-1,-1,0,"aza-madarek.aspx","_self","","","","",0,0,0,"","",0,0,0,2],138,0);
stm_aix("p2i1","p2i0",[0,"ديدن وضعيت ","","",-1,-1,0,"aza-didanevaziyat.aspx"],138,0);
stm_aix("p2i2","p2i0",[0,"درخواست مجوز حراج","","",-1,-1,0,"aza-darkhastmojavez.aspx"],138,0);
stm_aix("p2i3","p2i0",[0,"تمديد و تعويض پروانه","","",-1,-1,0,"aza-tamdidparvane.aspx"],138,0);
stm_aix("p2i4","p2i2",[0,"درخواست صدور پروانه "],138,0);
stm_aix("p2i5","p2i0",[0,"فروش فوق العاده","","",-1,-1,0,"aza-forushfogholade.aspx"],138,0);
stm_ep();
stm_aix("p0i2","p1i0",[0,"  آمار پروانه هاي صادره  ","","",-1,-1,0,"amar.aspx"],138,30);
stm_aix("p0i3","p0i1",[0,"قانون نظام صنفي"],135,30);
stm_bpx("p3","p1",[]);
stm_aix("p3i0","p2i0",[0,"تعاريف","","",-1,-1,0,"ghanoon-taarif.aspx"],135,0);
stm_aix("p3i1","p2i0",[0,"فرد صنفي","","",-1,-1,0,"ghanoon-fardesenfi.aspx"],135,0);
stm_aix("p3i2","p2i0",[0,"اتحاديه ها","","",-1,-1,0,"ghanoon-etehadiye.aspx"],135,0);
stm_aix("p3i3","p2i0",[0,"مجمع امور صنفي","","",-1,-1,0,"ghanoon-majma.aspx"],135,0);
stm_aix("p3i4","p2i0",[0,"شوراي اصناف","","",-1,-1,0,"ghanoon-shora.aspx"],135,0);
stm_aix("p3i5","p2i0",[0,"کميسيون نظارت","","",-1,-1,0,"ghanoon-nezarat.aspx"],135,0);
stm_aix("p3i6","p2i0",[0,"هيات عالي نظارت","","",-1,-1,0,"ghanoon-heyateali.aspx"],135,0);
stm_aix("p3i7","p2i0",[0,"تخلفات و جريمه ها","","",-1,-1,0,"ghanoon-takhalof.aspx"],135,0);
stm_aix("p3i8","p2i0",[0,"ساير مقررات","","",-1,-1,0,"ghanoon-sayer.aspx"],135,0);
stm_ep();
stm_aix("p0i4","p1i0",[0,"اعضاي هيئت رئيسه","","",-1,-1,0,"heyatraeise.aspx"],128,30);
stm_aix("p0i5","p1i0",[0,"اخبار","","",-1,-1,0,"AllNews.aspx"],115,30);
stm_aix("p0i6","p2i0",[0,"صفحه اصلي     ","","",-1,-1,0,"Default.aspx","_self","","","","",0,0,0,"arrow_r.gif","arrow_r.gif",7,7],123,30);
stm_bpx("p4","p1",[]);
stm_aix("p4i0","p1i0",[0,"بسیج اتحاديه","","",-1,-1,0,"Basij.aspx"],125,0);
stm_aix("p4i1","p1i0",[0,"عملکرد اتحاديه","","",-1,-1,0,"amalkard.aspx"],125,0);
stm_aix("p4i2","p1i0",[0,"سايتهاي مرتبط","","",-1,-1,0,"links.aspx"],125,0);
stm_aix("p4i3","p1i0",[0,"فعاليتهاي ورزشي","","",-1,-1,0,"sport.aspx"],125,0);
stm_aix("p4i4","p1i0",[0,"صندوق قرض الحسنه","","",-1,-1,0,"sandoogh.aspx"],125,0);
stm_aix("p4i5","p1i0",[0,"ارتباط با ما","","",-1,-1,0,"Contact.aspx"],125,30);
stm_ep();
stm_ep();
stm_em();
//-->
</script>
</td>
      </tr>
    </table></td>
  </tr>
</table>   
        <br />
        
        <center style="background-position-x: center; background-repeat: repeat">
           <asp:Label ID="lblMessage" runat="server"></asp:Label>
        <br />
        <br />
            <table dir="rtl">
                <tr>
                    <td style="width: 100px">
                        فرستنده&nbsp; :</td>
                    <td style="width: 100px">
                        <asp:TextBox ID="txtSender" runat="server" Width="240px"></asp:TextBox></td>
                    <td style="width: 100px">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSender"
                            ErrorMessage="*"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        ادرس ایمیل&nbsp; :</td>
                    <td style="width: 100px">
                        <asp:TextBox ID="txtEmail" runat="server" Width="240px"></asp:TextBox></td>
                    <td style="width: 100px">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="*"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        گیرنده&nbsp; :</td>
                    <td style="width: 100px">
                        <asp:DropDownList ID="ddlRecive" runat="server" Width="245px">
                            <asp:ListItem>هیات رئیسه</asp:ListItem>
                            <asp:ListItem>بازرسی</asp:ListItem>
                            <asp:ListItem Value="مدیر اجرایی">مدیر اجرایی</asp:ListItem>
                            <asp:ListItem>صندوق قرض الحسنه</asp:ListItem>
                            <asp:ListItem>روابط عمومی</asp:ListItem>
                            <asp:ListItem>بسیج</asp:ListItem>
                        </asp:DropDownList></td>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        موضوع&nbsp; :</td>
                    <td style="width: 100px">
                        <asp:TextBox ID="txtSubject" runat="server" Width="240px"></asp:TextBox></td>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        متن پیام&nbsp; :</td>
                    <td style="width: 100px">
                        <asp:TextBox ID="txtNote" runat="server" Height="160px" TextMode="MultiLine" Width="240px"></asp:TextBox></td>
                    <td style="width: 100px">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNote"
                            ErrorMessage="*"></asp:RequiredFieldValidator></td>
                </tr>
            </table>
    </center> 
 
    </div>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail"
            ErrorMessage="لطفا ادرس ایمیل را درست وارد کنید" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
            Width="208px"></asp:RegularExpressionValidator><br />
        <br />
        <table>
            <tr>
                <td style="width: 100px">
                    <input id="Reset1" type="reset" value="پاک کردن" /></td>
                <td style="width: 100px">
                    <asp:Button ID="tbnSend" runat="server" OnClick="tbnSend_Click" Text="ارسال" Width="64px" /></td>
            </tr>
        </table>
    </form>
</body>
</html>

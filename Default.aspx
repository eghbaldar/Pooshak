<%@ Page Language="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
    Dim objCmd As New SqlCommand
    Dim objDataReader As SqlDataReader
    Dim Matn_Monasebat As String = ""
    Dim Image_Monasebat As String = ""
    Dim News_Image(3) As String
    Dim News_Titr(3) As String
    Dim News_Lid(3) As String
    Dim News_Countinue(3) As String
    Dim Anavin_Titr As String
    Dim Amar1 As Integer
    Dim Amar2 As Integer
    Dim Amar3 As Integer
    Dim i As Byte
    Dim Payam As String
    '
    Dim Rabet As New clsUtility
    Dim EteShow As String = ""
    Dim LinkShow As String = ""
    '
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        'بروز رساني امار
        UpdateAmar()
        '================================================================================
        'نمايش عکس و متن مربوط به مناسبت ها
        objConnection.Open()
        objCmd.Connection = objConnection
        objCmd.CommandText = "SELECT TOP 1 ID, PhotoName, Matn FROM tblMonasebat ORDER BY ID DESC"
        objDataReader = objCmd.ExecuteReader
        If objDataReader.Read = True Then
            Matn_Monasebat = objDataReader("Matn").ToString
            Dim Path As String = "Images/MonasebatPic/" + System.IO.Path.GetFileName(objDataReader("PhotoName").ToString)
            Image_Monasebat = "<img src=" + Path + " width=201 height=122/>"
        End If
        objCmd.Dispose()
        objDataReader.Close()
        '================================================================================
        'نمايش خبرهاي اتحاديه
        objCmd.Connection = objConnection
        objCmd.CommandText = "SELECT TOP 3 ID, Titr, Lid, PhotoName FROM tblNews ORDER BY ID DESC"
        objDataReader = objCmd.ExecuteReader
        i = 0
        Do While objDataReader.Read
            News_Image(i) = "<img src=" + Mid(objDataReader("PhotoName").ToString, 3) + " width=136 height=78>"
            News_Titr(i) = "<a href=ShowNews.aspx?ID=" + objDataReader("ID").ToString + ">" + objDataReader("Titr").ToString + "</a>"
            News_Lid(i) = objDataReader("Lid").ToString
            News_Countinue(i) = "<a href=ShowNews.aspx?ID=" + objDataReader("ID").ToString + "><span class=style3><br>ادامه مطلب</span></a>"
            i = i + 1
        Loop
        objCmd.Dispose()
        objDataReader.Close()
        '================================================================================
        'نمايش عناوين خبرها
        objCmd.Connection = objConnection
        objCmd.CommandText = "SELECT TOP 10 ID, Titr FROM tblNews ORDER BY ID DESC"
        objDataReader = objCmd.ExecuteReader
        Do While objDataReader.Read
            Anavin_Titr += "<a href=ShowNews.aspx?ID=" + objDataReader("ID").ToString + ">" + objDataReader("Titr").ToString + "</a>" + "<br />" + "<br />"
        Loop
        objCmd.Dispose()
        objDataReader.Close()
        '================================================================================
        'نمايش امار بازديد کنندگان
        Dim Today_Date As String = Date.Today.ToShortDateString
        Dim Yesterday_Date As Date = CDate(Date.Today.AddDays(-1)).ToShortDateString
        Dim Rabet As New clsUtility
        
        Dim SqlAmar1 As String = "SELECT COUNT(ID) AS Expr1 FROM tblamar WHERE Date='" & Today.ToShortDateString & "'"
        Dim sqlAmar2 As String = "SELECT COUNT(ID) AS Expr1 FROM tblamar WHERE Date='" & Yesterday_Date & "'"
        Dim SqlAmar3 As String = "SELECT COUNT(ID) AS Expr1 FROM tblamar"
        Dim status As Byte = 0
        '
        Try
            Amar1 = Rabet.ExcuteQ(SqlAmar1)
            Amar1 = IIf(Nothing, "0", Str(Amar1))
            objCmd.Dispose()
        Catch ex As Exception
            Amar1 = IIf(Nothing, "0", Str(Amar1))
        End Try
        '
        Try
            Amar2 = Rabet.ExcuteQ(sqlAmar2)
            Amar2 = IIf(Nothing, "0", Str(Amar2))
            objCmd.Dispose()
        Catch ex As Exception
            Amar2 = IIf(Nothing, "0", Str(Amar2))
        End Try
        '
        Try
            Amar3 = Rabet.ExcuteQ(SqlAmar3)
            Amar3 = IIf(Nothing, "0", Str(Amar3))
            objCmd.Dispose()
        Catch ex As Exception
            Amar3 = IIf(Nothing, "0", Str(Amar3))
        End Try
        'objConnection.Open()
        '================================================================================
        'نمایش تاریخ امروز
        Dim ShowDate As New clsUtility
        lblToday.Text = ShowDate.Conv(Today)
        '================================================================================
        'نمایش لینک ها و اطلاعیه ها
        Dim TedadLink As Byte = Rabet.ExcuteQ("SELECT TedadLink FROM tblConfig WHERE ID=1")
        Dim TedadEte As Byte = Rabet.ExcuteQ("SELECT TedadEtelaeyeh FROM tblConfig WHERE ID=1")
        
        objCmd.Connection = objConnection
        objCmd.CommandText = "SELECT TOP " & Str(TedadEte) & " ID, Titr, Tooltip, FileName FROM tblEtelaeyeh ORDER BY ID DESC"
        objDataReader = objCmd.ExecuteReader
        Do While objDataReader.Read
            EteShow += "<a href=""Etelaiiye/" & objDataReader("FileName").ToString & """>" & objDataReader("Titr").ToString & "</a>" + "<br />"
        Loop
        objCmd.Dispose()
        objDataReader.Close()
        
        objCmd.Connection = objConnection
        objCmd.CommandText = "SELECT TOP " & Str(TedadLink) & " ID, Tozihat, URL FROM tblLinks ORDER BY ID DESC"
        objDataReader = objCmd.ExecuteReader
        Do While objDataReader.Read
            LinkShow += "<A style=""color: White"" target=_blank href=""" & objDataReader("URL").ToString & """>" & objDataReader("Tozihat").ToString & "</A><BR/>"
            
        Loop
        objCmd.Dispose()
        objDataReader.Close()
        '================================================================================
        'نمایش پیام روز    
        Payam = Rabet.ExcuteQ("SELECT TOP 1 Payam FROM tblPayam ORDER BY NewID()")
        '================================================================================
        
        '
    End Sub
    
    Private Sub UpdateAmar()
        '
        Dim Url As String = ""
        If Not Request.UrlReferrer = Nothing Then
            Url = Request.UrlReferrer.AbsoluteUri
        End If
        '        
        Dim objSqlCmd As New SqlCommand
        Try
            objConnection.Open()
            objSqlCmd.Connection = objConnection
            objSqlCmd.CommandText = "INSERT INTO tblAmar(Date, IP, URL) VALUES (@Date, @IP, @URL)"
            objSqlCmd.Parameters.AddWithValue("@Date", Today.Date)
            objSqlCmd.Parameters.AddWithValue("@IP", CStr(Request.UserHostAddress))
            objSqlCmd.Parameters.AddWithValue("@URL", Url)
            objSqlCmd.ExecuteNonQuery()
            '-------            
            objConnection.Close()
            'objConnection = Nothing
            objSqlCmd.Dispose()
            objSqlCmd = Nothing
        Catch ex As Exception
        End Try
        '
    End Sub
    
    Protected Sub btnOK_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If IsAdmin() = True Then
            Session("IsAdmin") = "YES"
            Response.Redirect("CMS/Default.aspx")
        Else
            lblMsg.Text = "نام کاربری یا کلمه رمز اشتباه است"
        End If
    End Sub

    Private Function IsAdmin() As Boolean
        Try
            Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
            Dim objSqlCmd As SqlCommand = New SqlCommand()
            Dim objDataReader As SqlDataReader
            '---------------------------------
            objConnection.Open()
            objSqlCmd.Connection = objConnection
            objSqlCmd.CommandText = "SELECT * FROM tblAdmin WHERE ((UN = '" + txtUserName.Text.Trim + "') AND (PW = '" + txtPassword.Text.Trim + "'))"
            objDataReader = objSqlCmd.ExecuteReader
            '---------------------------------
            If objDataReader.HasRows = True Then
                objConnection.Close()
                objConnection = Nothing
                objSqlCmd.Dispose()
                objSqlCmd = Nothing
                Return True
            Else
                objConnection.Close()
                objConnection = Nothing
                objSqlCmd.Dispose()
                objSqlCmd = Nothing
                Return False
            End If
        Catch ex As Exception
            lblMsg.Text = ex.Message
        End Try
    End Function

    
</script>

<html>
<head>

<title>Pooshakkaraj.ir اتحاديه صنف پوشاک فروشان کرج</title>
<style type="text/css">
<!--
.style2 {font-size: 12px}
.style3 {font-family: Tahoma; font-size: 12px; }
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

<body style="text-align: center">

<table width="929" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="230"><img src="images/001.jpg" width="230" height="228"></td>
    <td width="392" background="images/002.jpg"><table width="348" height="198" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td style="height: 56px"><p>&nbsp;</p>
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
    <td bgcolor="#eeeeee"><table width="929" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td>
<script type="text/javascript" language="JavaScript1.2">
<!--
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
stm_aix("p4i5","p1i0",[0,"ارتباط با ما","","",-1,-1,0,"contact.aspx"],125,30);
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
<table width="929" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width="223" align="center" valign="top">
    <table border="0" cellpadding="0" cellspacing="0" background="images/bg-small-kadr.jpg">
      <tr>
        <td><img src="images/up2ee.jpg" width="214" height="15" /></td>
      </tr>
      <tr>
        <td>
            <asp:Label ID="lblToday" runat="server"></asp:Label>
        </td>
      </tr>
      <tr>
        <td><img src="images/bg-small-kadr-down.jpg" width="214" height="5" /></td>
      </tr>
    </table>
    <br />    
    <table border="0" cellpadding="0" cellspacing="0" background="images/bg-small-kadr.jpg">
      <tr>
        <td><img src="images/up2ee.jpg" width="214" height="15" /></td>
      </tr>
      <tr>
        <td>
<!-- Google CSE Search Box Begins  -->
<form action="http://pooshakkaraj.ir/search.aspx" id="cse-search-box">
  <input type="hidden" name="cx" value="018364098256072545151:tgntltmrfjg" style="width: 106px" />
  <input type="hidden" name="cof" value="FORID:11" style="width: 109px" />
  <input type="text" name="q" style="width: 146px" /><br />
    <img src="Images/google.jpg" />
    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<input type="submit" name="sa" value="Search" />
</form>
<script type="text/javascript" src="http://www.google.com/coop/cse/brand?form=cse-search-box&lang=en"></script>
<!-- Google CSE Search Box Ends -->
        </td>
      </tr>
      <tr>
        <td><img src="images/bg-small-kadr-down.jpg" width="214" height="5" /></td>
      </tr>
    </table>
      <br />
      <img src="images/up2ee.jpg" width="214" height="15" /><br />
      <table height="100" border="0" align="center" cellpadding="0" cellspacing="0" background="images/bg-small-kadr.jpg">
        <form id="form1" runat="server" defaultbutton="btnOk">
        <tr>
          <td><div align="center" class="style4">&#1608;&#1585;&#1608;&#1583; &#1575;&#1593;&#1590;&#1575;&#1569; 
              <br />
              <br />
          </div></td>
        </tr>
        <tr>
          <td>
          <table width="184" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="86"><span class="style3">
                  <label> </label>
                  </span> <span class="style2">
                  <label></label>
                  </span>
                  <div align="right" class="style3">
                      <asp:TextBox ID="txtUsername" runat="server" Width="100px"></asp:TextBox>&nbsp;</div>
                  </td>
                <td width="114"><div align="center" class="style3">&#1705;&#1604;&#1605;&#1607; &#1705;&#1575;&#1585;&#1576;&#1585;&#1740; </div></td>
              </tr>
              <tr>
                <td><div align="right" class="style3">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="100px"></asp:TextBox>&nbsp;</div></td>
                <td><div align="center" class="style3">&#1585;&#1605;&#1586; &#1593;&#1576;&#1608;&#1585; </div></td>
              </tr>
              <tr>
                <td colspan="2"><span class="style3">
                    <br />
                    <asp:Button ID="btnOK" runat="server" OnClick="btnOK_Click" Text="ورود" Width="72px" /></span></td>
              </tr>
          </table>
              <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label></td>
        </tr>
        <tr>
          <td><img src="images/bg-small-kadr-down.jpg" width="214" height="5" /></td>
        </tr>
        </form>
      </table>
      <br />
      <table border="0" align="center" cellpadding="0" cellspacing="0" background="images/bg-small-kadr.jpg">
        <tr>
          <td><img src="images/agahi.jpg" width="214" height="36" /></td>
        </tr>
        <tr>
          <td><div align="center">
            <p>
              <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="200" height="150">
                <param name="movie" value="swf/Bazar.swf" />
                <param name="quality" value="high" />
                <embed src="swf/Bazar.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="200" height="150"></embed>
              </object>
            </p>
            <p>
              <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="200" height="150">
                <param name="movie" value="swf/amini.swf" />
                <param name="quality" value="high" />
                <embed src="swf/amini.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="200" height="150"></embed>
              </object>
            </p>
          </div></td>
        </tr>
        <tr>
          <td><img src="images/bg-small-kadr-down.jpg" width="214" height="5" /></td>
        </tr>
    </table></td>
    <td width="487" valign="top"><table width="480" border="0" cellpadding="0" cellspacing="0" background="images/bg-onvan-khabar.jpg">
      <tr>
        <td colspan="7"><img src="images/onvan-akhbar.jpg" width="484" height="37" /></td>
      </tr>
      <tr>
        <td width="7" style="height: 152px"><p align="right" class="style4" dir="rtl"><br />  
            <br />
        </p>          <p align="right" class="style3" dir="rtl"><span class="style3"><br />
              <br />
              <br />
          </span></p></td>
        <td width="154" class="style3" style="height: 152px"><span class="style3">
          <label></label>
        </span>
          <table width="143" border=0 align="center" cellpadding=2 cellspacing=0 
                              bgcolor=#eeeeee>
            <tbody>
              <tr>
                <td width="157" bgcolor="#FFFFFF" align="right" dir="rtl">
                    <marquee direction="up" width="131" height="151" scrollamount="1" onMouseOver="this.stop()" onMouseOut="this.start()"><%=Anavin_Titr%></marquee>                
                </td>
              </tr>
            </tbody>
          </table></td>
        <td width="6" background="images/noghtechin.jpg" style="height: 152px">&nbsp;</td>
        <td width="155" style="vertical-align: top; height: 152px;" class="style3"><table width="140" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><%Response.Write(News_Image(2))%></td>
          </tr>
          <tr>
            <td class="style4"><div align="right"><a href="#"><strong><span dir="RTL"><%=News_Titr(2)%></span></strong></a></div></td>
          </tr>
          <tr>
            <td class="style3" align="right"><%=HttpUtility.HtmlDecode(News_Lid(2))%></td>
          </tr>
          <tr>
            <td style="height: 28px"><span class="style3"><%=News_Countinue(2)%></span></td>
          </tr>
        </table></td>
        <td width="4" background="images/noghtechin.jpg" style="height: 152px">&nbsp;</td>
        <td width="152" style="vertical-align: top; height: 152px;" class="style3"><table width="140" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><%Response.Write(News_Image(1))%></td>
            </tr>
          <tr>
            <td class="style4"><div align="right"><%=News_Titr(1)%>&nbsp;</div></td>
          </tr>
          <tr>
            <td class="style3"><div align="right"><%=HttpUtility.HtmlDecode(News_Lid(1))%>
                &nbsp;</div></td>
          </tr>
          <tr>
            <td><%=News_Countinue(1)%></td>
          </tr>
        </table>          </td>
        <td width="6" style="height: 152px">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="7"><img src="images/onvan-akhbar-down.jpg" width="484" height="6" /></td>
      </tr>
    </table>
      <table width="480" border="0" cellpadding="0" cellspacing="0" background="images/bg-onvan-khabar.jpg">
      <tr>
        <td colspan="3"><img src="images/akhbar-etehadiye.jpg" width="484" height="38" /></td>
      </tr>
      <tr>
        <td width="13">&nbsp;</td>
        <td width="460" align="right"><p align="right" class="style4" dir="rtl"><br /><%=News_Titr(0)%> </p>
          <p align="justify" class="style3" dir="rtl"><br /><%=HttpUtility.HtmlDecode(News_Lid(0))%></p>
          <a href="#"><span class="style3"><%=News_Countinue(0)%><br />
          <br />
          </span></a>          </td>
        <td width="11">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="3"><img src="images/onvan-akhbar-down.jpg" width="484" height="6" /></td>
      </tr>
    </table>
      <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="480" height="89">
        <param name="movie" value="swf/MElatkart.swf" />
        <param name="quality" value="high" />
        <embed src="swf/MElatkart.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="480" height="89"></embed>
      </object></td>
    <td width="219" valign="top"><table border="0" cellpadding="0" cellspacing="0" background="images/bg-small-kadr-right.jpg">
      <tr>
        <td><img src="images/up2ee.jpg" width="208" height="15" /></td>
      </tr>
      <tr>
        <td><div align="center"><%Response.Write(Image_Monasebat)%></div></td>
      </tr>
      <tr>
        <td><marquee class="style4" direction="right"><%=Matn_Monasebat %></marquee></td>
      </tr>
      <tr>
        <td><img src="images/bg-small-kadr-down.jpg" width="208" height="5" /></td>
      </tr></table>
      <br />
      <table border="0" cellpadding="0" cellspacing="0" background="images/bg-small-kadr-right.jpg">
        <tr>
          <td><img src="images/etelaiiye.jpg" width="208" height="35" /></td>
        </tr>
        <tr>
          <td style="height: 76px">
          <center>
              &nbsp;<strong>
                        <span style="font-size: 11pt; font-family: Arial (Arabic)">
                            <%=eteshow%>
                        </span>
                    </strong>
            </center>
          </td>
        </tr>
        <tr>
          <td><img src="images/bg-small-kadr-down.jpg" width="208" height="5" /></td>
        </tr>
      </table>
      <br>
      <table width="206" border="1" cellpadding="0" cellspacing="0" bordercolor="#32739D">
        <tr>
          <td height="26"><div align="center" class="style4">سايت هاي مرتبط </div></td>
        </tr>
        <tr>
          <td bgcolor="#006699">
          <table width="143" border=0 align="center" cellpadding=2 cellspacing=0 bgcolor=#eeeeee>
              <tbody>
                <tr>
                  <td bgcolor="#006699" style="width: 171px">
                  <marquee direction="up" width="131" height="151" scrollamount="1" onMouseOver="this.stop()" onMouseOut="this.start()">
                    <DIV class="style5"  align="center">
                        <FONT face="arial,helvetica,sans-serif" size=1>
                            <SPAN style="FONT-SIZE: 11pt">
                                <STRONG>
                                    <%=LinkShow%>
                                </STRONG>
                            </SPAN>
                        </FONT>
                    </DIV>
                  </marquee>
                  </td>
                </tr>
              </tbody>
          </table></td>
        </tr>
      </table>
      <table width="216" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table>
      <table height="100" border="0" cellpadding="0" cellspacing="0" background="images/bg-small-kadr-right.jpg">
        <tr>
          <td><img src="images/up2ee.jpg" width="208" height="15" /></td>
        </tr>
        <tr>
          <td><div align="center" class="style4">آمار بازديد از سايت <br>
                  <br>
            </div>
              <table width="200" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="86" bgcolor="#669933"><span class="style3">
                    <label> </label>
                    </span> <span class="style2">
                    <label></label>
                    </span>
                    <div align="center"><%=Amar1%></div>
                    </td>
                  <td width="114" bgcolor="#669933"><div align="center">بازديد امروز </div></td>
                </tr>
                <tr>
                  <td bgcolor="#8CCD52"><div align="center"><%=Amar2%></div></td>
                  <td bgcolor="#8CCD52"><div align="center">بازديد ديروز </div></td>
                </tr>
                <tr>
                  <td bgcolor="#FFFFCC"><div align="center"><%=Amar3%>
                      &nbsp;</div></td>
                  <td bgcolor="#FFFFCC"><div align="center">بازديد کل </div></td>
                </tr>
            </table></td>
        </tr>
        <tr>
          <td><img src="images/bg-small-kadr-down.jpg" width="208" height="5" /></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="929" border="0" align="center" cellpadding="0" cellspacing="0" style="height: 53px">
  <tr>
    <td bgcolor="#FFFFFF" style="height: 29px; text-align: center">
        <span style="font-size: 7pt; font-family: Tahoma"></span>
    </td>
  </tr>
  <tr style="font-size: 12pt; font-family: Times New Roman">
    <td bgcolor="#FFFFFF" style="height: 19px; text-align: center" rowspan="2">
        <span style="font-size: 7pt; font-family: Tahoma"></span>
    </td>
  </tr>
</table>
<table width="929" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td style="height: 19px; text-align: center">
        <span style="color: #000066">&nbsp;<span style="font-size: 9pt; font-family: Tahoma"><a href="Default.aspx"><span>صفحه اصلی</span></a><span>&nbsp; |&nbsp;
            </span><a href="amalkard.aspx"><span>عملکرد اتحادیه</span></a><span>&nbsp; |&nbsp; </span><a href="links.aspx"><span>
                    سایتهای مرتبط</span></a><span>&nbsp; | &nbsp; </span>
            <a href="ertebat.aspx"><span>ارتباط با اتحادیه</span></a><span>&nbsp; |&nbsp; </span><a href="AllNews.aspx"><span>
                    اخبار اتحادیه</span></a><span>&nbsp; |&nbsp; </span>
            <a href="sandoogh.aspx"><span>صندوق قرض الحسنه</span></a><span>&nbsp; |&nbsp; </span><a href="komision.aspx"><span>
                    کمیسیون ها</span></a></span></span></td>
  </tr>
</table>
    <span style="font-size: 8pt; font-family: Tahoma"><a href="http://www.atropatgan.net">
        <span style="color: #ffffff">Atropatgan.net</span></a> © 2008 &nbsp;طراحی و اجراء
        : <a href="http://www.atropatgan.net"><span style="color: #000000">شرکت آتروپاتگان کاسپین</span></a>
        <br />
        <span style="font-size: 7pt; color: #ccffff">کلیه حقوق این وب سایت برای اتحادیه صنف
            پوشاک فروشان کرج محفوظ است</span></span>
</body>
</html>
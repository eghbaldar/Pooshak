<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <asp:Panel ID="Panel1" runat="server" BackColor="White" BorderColor="Black"
            BorderWidth="1px" Height="370px" ScrollBars="Vertical" Width="670px">
            &nbsp;
<!-- Google Search Result Snippet Begins -->
<div id="cse-search-results"></div>
<script type="text/javascript">
  var googleSearchIframeName = "cse-search-results";
  var googleSearchFormName = "cse-search-box";
  var googleSearchFrameWidth = 600;
  var googleSearchDomain = "www.google.com";
  var googleSearchPath = "/cse";
</script>
<script type="text/javascript" src="http://www.google.com/afsonline/show_afs_search.js"></script>

<!-- Google Search Result Snippet Ends -->

    </asp:Panel>
</asp:Content>


Imports Microsoft.VisualBasic
Imports System.Net.Mail


Public Class SendEmail

    ''' <summary>
    ''' Sends an e-mail message using FCSA's mail server.
    ''' </summary>
    ''' <param name="subject">The subject of the message being sent.</param>
    ''' <param name="messageBody">The message body.</param>
    ''' <param name="fromAddress">The sender's e-mail address.</param>
    ''' <param name="toAddress">The recipient's e-mail address (separate multiple e-mail addresses
    ''' with a semi-colon).</param>
    ''' <example>
    ''' <code>
    '''   ' Send a quick e-mail message
    '''   SendEmail.SendMessage("This is a Test", _
    '''                         "This is a test message...", _
    '''                         "noboday@nowhere.com", _
    '''                         "somebody@somewhere.com", _
    '''                         "ccme@somewhere.com")
    ''' </code>
    ''' </example>
    Public Sub SendMessage(ByVal subject As String, ByVal messageBody As String, _
        ByVal fromAddress As String, ByVal toAddress As String)

        Dim message As New MailMessage()
        Dim client As New SmtpClient()

        'Set the sender's address
        message.From = New MailAddress(fromAddress)

        'Allow multiple "To" addresses to be separated by a semi-colon
        If (toAddress.Trim.Length > 0) Then
            For Each addr As String In toAddress.Split(";"c)
                message.To.Add(New MailAddress(addr))
            Next
        End If

        'Set the subject and message body text
        message.Subject = subject
        message.Body = messageBody

        'Set the SMTP server to be used to send the message
        client.Host = "mail.pooshakkaraj.ir"

        'Send the e-mail message
        client.Send(message)
    End Sub

End Class

Imports Microsoft.VisualBasic

Public Class clsUtility

    Public Function Conv(ByVal d As Date) As String
        Dim FarsiDate As New PersianToolS.PersinToolsClass 'ÇíÌÇÏ ÚÖæ ÌÏíÏ ÇÒ ˜áÇÓ******
        Return FarsiDate.DateToPersian(d).LongDate
    End Function

    Public Function ExcuteQ(ByVal Sql As String) As Object
        Dim Result
        Try
            Dim objConnection As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
            objConnection.Open()
            Dim objSqlCmd As SqlCommand = New SqlCommand()
            objSqlCmd.Connection = objConnection
            objSqlCmd.CommandText = Sql
            Result = objSqlCmd.ExecuteScalar
            Return Result
            objConnection.Close()
            objConnection = Nothing
            objSqlCmd.Dispose()
            objSqlCmd = Nothing
        Catch ex As Exception
            Return Nothing
        End Try
    End Function


End Class

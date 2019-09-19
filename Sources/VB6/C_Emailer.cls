VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "C_Emailer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public Sub Send(MFrom As String, MTo As String, MMsg As String, Optional Msub As String = "")
    Dim u As String
    
    Set ObjMessage = CreateObject("CDO.Message")
    If Msub = "" Then
        ObjMessage.subject = "RiskPointer (" & Format(Date, "ddd dd-MMM-yyyy") & ")"
    Else
        ObjMessage.subject = Msub
    End If
    
    ObjMessage.From = MFrom
    ObjMessage.To = MTo
    
    'Converte para html
'    u = ""
'    For i = 1 To Len(MMsg) - 1
'        If Mid(MMsg, i, 1) = " " And Mid(MMsg, i + 1, 1) = " " Then u = u + "&nbsp" Else u = u + Mid(MMsg, i, 1)
'    Next i
'    u = u + Right(MMsg, 1)
    
    'ObjMessage.bodyformat = olformathtml
    ObjMessage.htmlbody = "<font face='Courier' size='2'><pre>" + MMsg + "</pre>"
    
    'ObjMessage.TextBody = MMsg
    
        
    '==This section provides the configuration information for the remote SMTP server.
    '==Normally you will only change the server name or IP.
    
     'Use SSL for the connection (False or True)
    ObjMessage.Configuration.Fields.Item _
    ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = False
    
     ObjMessage.Configuration.Fields.Item _
    ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    
     'Type of authentication, NONE, Basic (Base64 encoded), NTLM
    ObjMessage.Configuration.Fields.Item _
    ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1

        
        'Your UserID on the SMTP server
    ObjMessage.Configuration.Fields.Item _
    ("http://schemas.microsoft.com/cdo/configuration/sendusername") = Config.Email
    
    ObjMessage.Configuration.Fields.Item _
    ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
    
    'Your password on the SMTP server
    ObjMessage.Configuration.Fields.Item _
    ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = Config.Senha
    
    ObjMessage.Configuration.Fields.Item _
    ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    
    'Name or IP of Remote SMTP Server
    ObjMessage.Configuration.Fields.Item _
    ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.gmail.com"
    
    'Server port (typically 25)
    ObjMessage.Configuration.Fields.Item _
    ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465 '25 '587
      
    ObjMessage.Configuration.Fields.Update
    
    '==End remote SMTP server configuration section==
    
    ObjMessage.Send
End Sub

'-----------------------------------------------------------------------------------------------------------------------------------------------
'                                                        E  N  V  I  A
'-----------------------------------------------------------------------------------------------------------------------------------------------

Sub SendList(msg As String, List As String, header As String)
    'Envia para todos os contatos de uma determinada lista
    Dim i As Integer, GTo As String
    For i = 1 To Config.MailerN
        If InStr(Config.MailerContactList(i), List) > 0 Then
            If GTo <> "" Then GTo = GTo + ";"
            GTo = GTo + Config.MailerContactEmail(i)
        End If
    Next i
    Send "grc@capitania.net", GTo, msg, header + " (" & Format(Date, "ddd dd-MMM-yyyy") & ")"
End Sub

Sub SendForRC(msg As String, header As String)
    Dim i As Integer, GTo As String
    GTo = ""
    For i = 1 To Config.MailerN
        If Config.MailerContactFunction(i) = 2 Then
            If GTo <> "" Then GTo = GTo + ";"
            GTo = GTo + Config.MailerContactEmail(i)
        End If
    Next i
    Send "grc@capitania.net", GTo, msg, header + " (" & Format(Date, "ddd dd-MMM-yyyy") & ")"
End Sub

VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CUser"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public username As String
Public Imports As Integer
Public Reports As Integer
Public acesso As String
Private L_Cleared As Boolean


Property Get Cleared() As Boolean
    Cleared = L_Cleared
End Property

Property Get BatchUser() As Boolean
    BatchUser = (acesso = "BATCH")
End Property

Public Sub ReadDB()
    Dim db As ADODB.Connection, rs As ADODB.Recordset
    L_Cleared = False
    username = Environ("username")
    
    Set db = OpenTheDatabase
    Set rs = db.Execute("SELECT * FROM TUSERS WHERE LOGIN='" + username + "'")
    If Not rs.EOF Then
        L_Cleared = True
        Imports = rs("IMPORTA")
        Reports = rs("REPORTA")
        acesso = rs("ACESSO")
    End If

End Sub

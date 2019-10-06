VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CCrise"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Public nome As String
Public Ini As Date
Public Fim As Date

Public ChgIPCA2Y As Double
Public ChgIPCA5Y As Double
Public ChgIPCA10Y As Double
Public ChgIMAB5 As Double
Public ChgIFIX As Double
Public ChgDolar As Double
Public ChgPRE2Y As Double
Public ChgPRE5Y As Double

Property Get DurMos() As Double
    DurMos = (Fim - Ini) / 30
End Property

Public Sub Populate(db As ADODB.Connection)
    ChgIPCA2Y = ChangeInRiskFactor("IPCA2Y", db)
    ChgIPCA5Y = ChangeInRiskFactor("IPCA5Y", db)
    ChgIPCA10Y = ChangeInRiskFactor("IPC102Y", db)
    ChgIMAB5 = ChangeInRiskFactor("IMAB5", db)
    ChgIFIX = ChangeInRiskFactor("IFIX", db)
    ChgDolar = ChangeInRiskFactor("DOLAR", db)
    ChgPRE2Y = ChangeInRiskFactor("PRE2Y", db)
    ChgPRE5Y = ChangeInRiskFactor("PRE5Y", db)
End Sub

Private Function ChangeInRiskFactor(nome As String, db As ADODB.Connection) As Double
    Dim rs As ADODB.Recordset, mxdata As Date, a As Double
    
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT MAX(DATA) AS MAXDATE FROM TFACTORHIST WHERE FACTORID='" + nome + "' AND DATA<=" + SQLD(Ini), db, adOpenForwardOnly, adLockReadOnly)
    If Not IsNull(rs("MAXDATE")) Then
        mxdata = rs("MAXDATE")
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT * FROM TFACTORHIST WHERE FACTORID='" + nome + "' AND DATA=" + SQLD(mxdata), db, adOpenForwardOnly, adLockReadOnly)
        If Not rs.EOF Then
            a = rs("VALOR")
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT MAX(DATA) AS MAXDATE FROM TFACTORHIST WHERE FACTORID='" + nome + "' AND DATA<=" + SQLD(Fim), db, adOpenForwardOnly, adLockReadOnly)
            If Not IsNull(rs("MAXDATE")) And a > 0 Then
                Set rs = New ADODB.Recordset
                Call rs.open("SELECT * FROM TFACTORHIST WHERE FACTORID='" + nome + "' AND DATA=" + SQLD(mxdata), db, adOpenForwardOnly, adLockReadOnly)
                If Not rs.EOF Then
                    ChangeInRiskFactor = rs("VALOR") / a - 1
                Else
                    ChangeInRiskFactor = 0
                End If
            Else
                ChangeInRiskFactor = 0
            End If
        Else
            ChangeInRiskFactor = 0
        End If
    Else
        ChangeInRiskFactor = 0
    End If
End Function

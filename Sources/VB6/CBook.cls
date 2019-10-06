VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBook"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public ID As Long
Public nome As String
Public c As Collection

Public FundosAplicN As Integer

Public Sub ReadRulesDB()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, x As CRegra
    Set c = New Collection
    
    Set db = OpenTheDatabase
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM TBOOKREGRA WHERE RULEBOOK=" + Str(ID), db, adOpenForwardOnly, adLockReadOnly)
    If Not rs.EOF Then rs.MoveFirst
    While Not rs.EOF
        Set x = Regras.search(rs("Regra"))
        If x Is Nothing Then
            WriteLogError "Regra não encontrada", Str(rs("Regra"))
        Else
            c.Add x
        End If
        rs.MoveNext
    Wend
    
End Sub


Public Sub ClearRules()
    Set c = New Collection
End Sub


Public Sub AddNewRule(x As Integer)
    c.Add Regras.search(x)
End Sub


Public Sub WriteDB()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, sb As String, x As CBook, b As CRegra, dtcriado As Date
    
    If MainStatus = "LIVE" Then
        
        Set db = OpenTheDatabase
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT * FROM TRULEBOOKS WHERE ID=" + Str(Me.ID), db, adOpenForwardOnly, adLockReadOnly)
        If Not rs.EOF Then
            dtcriado = rs("DT_CREATED")
            db.Execute ("DELETE FROM TRULEBOOKS WHERE ID=" + Str(Me.ID))
            rs.Close
        Else
            dtcriado = BaseDate
            rs.Close
        End If
        
        db.Execute ("INSERT INTO TRULEBOOKS (ID, NOME, DT_CREATED, DT_DELETED, DELETED) VALUES (" + Str(Me.ID) + ", '" + Me.nome + "'," + SQLD(dtcriado) + "," + SQLBaseDate + ",FALSE)")
        
        db.Execute ("DELETE FROM TBOOKREGRA WHERE RULEBOOK=" + Str(Me.ID))
        For Each b In c
            db.Execute ("INSERT INTO TBOOKREGRA (RULEBOOK, REGRA) VALUES (" + Str(Me.ID) + ", " + Str(b.ID) + ")")
        Next b
        
    End If
End Sub


Property Get MinhasRegras() As String
    Dim a As String, x As CRegra
    For Each x In c
        a = a + x.nome + ", "
    Next x
    If a <> "" Then a = Left(a, Len(a) - 2)
    MinhasRegras = a
End Property


Property Get IHaveRule(x As CRegra) As Boolean
    Dim y As CRegra, a As Boolean
    a = False
    For Each y In c
        If y.ID = x.ID Then a = True
    Next y
    IHaveRule = a
End Property


Property Get FundosAplic() As Collection
    Dim fd As CFundo, u As CNomeValor
    Dim a As Collection
    Set a = New Collection
    For Each fd In Fundos.c
        For Each bk In fd.MyBooks
            If bk Is Me Then
                Set u = New CNomeValor
                u.nome = fd.nome
                a.Add u
            End If
        Next bk
    Next fd
    Set FundosAplic = a
End Property




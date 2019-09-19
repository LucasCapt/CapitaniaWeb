VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBooks"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public c As Collection

Public Sub ReadDB()
    Dim db As Database, rs As Recordset, x As CBook
    Set c = New Collection
    
    Set db = OpenTheDatabase
    Set rs = db.OpenRecordset("SELECT * FROM TRULEBOOKS WHERE DT_CREATED<=" + SQLBaseDate + " AND NOT (DELETED AND DT_DELETED<=" + SQLBaseDate + ") ORDER BY NOME")
    If Not rs.EOF Then rs.MoveFirst
    While Not rs.EOF
        Set x = New CBook
        x.ID = rs("ID")
        x.nome = rs("Nome")
        x.ReadRulesDB
        c.Add x
        rs.MoveNext
    Wend
    db.Close
End Sub

Public Function search(x As String) As CBook
    Dim y As CBook
    For Each y In c
        If y.nome = x Then Set search = y
    Next y
End Function


Public Function searchID(x As Long) As CBook
    Dim y As CBook
    For Each y In c
        If y.ID = x Then Set searchID = y
    Next y
End Function


Public Function Cria(x As String) As CBook
    Dim db As Database, rs As Recordset, y As CBook, NextID As Integer
        
    
    Set db = OpenTheDatabase
    Set rs = db.OpenRecordset("SELECT MAX(ID) AS MAXID FROM TRULEBOOKS")
    If rs.EOF() Then NextID = 1 Else NextID = rs("MAXID") + 1
    
    Set y = New CBook
    y.ID = NextID
    Set y.c = New Collection
    y.nome = x
    c.Add y
    
    Set Cria = y
    
    If MainStatus = "LIVE" Then
        db.Execute ("INSERT INTO TRULEBOOKS (ID, NOME, DT_CREATED, DT_DELETED, DELETED) VALUES (" + Str(NextID) + ", '" + x + "'," + SQLBaseDate + "," + SQLBaseDate + ",FALSE)")
        Set rs = db.OpenRecordset("SELECT * FROM TRULEBOOKS WHERE ID=" + Str(NextID))
        If rs.EOF Then Set Cria = Nothing
    End If
    
    db.Close
    
End Function

Public Sub HighLevelCria()
    Dim bnome As String, b As CBook
    bnome = FInput.Pergunte("Nome do Book a ser criado:")
    If bnome <> "" Then
        If search(bnome) Is Nothing Then
            Set b = Cria(bnome)
            If b Is Nothing Then
                MsgBox ("Falha ao criar o livro " + bnome)
            Else
                FEditBook.showfor b
            End If
        Else
            MsgBox ("Nome já existente.")
        End If
    End If
End Sub


Public Sub Deleta(x As CBook)
    Dim db As Database, rs As Recordset, y As CBook, f As CFundo, vai As Boolean, i As Integer
    
    If MainStatus = "LIVE" Then
        vai = True
        For Each f In Fundos.c
            vai = vai And Not f.IAmAssignedToBook(x)
        Next f
        
        If vai Then
            Set db = OpenTheDatabase
            db.Execute ("UPDATE TRULEBOOKS SET DELETED=TRUE, DT_DELETED=" + SQLBaseDate + " WHERE ID=" + Str(x.ID))
            'db.Execute ("DELETE FROM TBOOKREGRA WHERE RULEBOOK=" + Str(x.ID))
            db.Close
            
            For i = 1 To c.Count - 1
                If c(i).ID = x.ID Then c.remove (i)
            Next i
            If c(c.Count).ID = x.ID Then c.remove (c.Count)
                    
        Else
            MsgBox ("Book está sendo utilizado por fundos. Impossível excluir.")
        End If
    End If
End Sub


Public Sub Recalc()
    'Basicamente, refaz o número de referências de books e regras
    Dim bk As CBook, rl As CRegra, N As Integer
    For Each rl In Regras.c
        rl.FundosAplicN = 0
        rl.BooksAplicN = 0
    Next rl
    For Each bk In c
        N = bk.FundosAplic.Count
        bk.FundosAplicN = N
        For Each rl In bk.c
            rl.BooksAplicN = rl.BooksAplicN + 1
            rl.FundosAplicN = rl.FundosAplicN + N
        Next rl
    Next bk
End Sub


Public Sub FillComboListWithNomes(ByRef x As Object)
    Dim f As CBook
    x.Clear
    For Each f In c
        x.AddItem f.nome
    Next f
End Sub

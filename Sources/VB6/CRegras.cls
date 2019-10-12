VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CRegras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public c As New Collection

Public Sub ReadDB()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, x As CRegra
    Set c = New Collection
    
    Set db = OpenTheDatabase
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM TREGRAS WHERE DT_CREATED<=" + SQLBaseDate + " AND NOT (DELETED = 1 AND DT_DELETED<=" + SQLBaseDate + ") ORDER BY NOME", db, adOpenForwardOnly, adLockReadOnly)
    If Not rs.EOF Then rs.MoveFirst
    While Not rs.EOF
        DoEvents
        Set x = New CRegra
        x.ID = rs("ID")
        x.nome = rs("Nome")
        x.Limite = rs("Limite")
        x.MaxMin = rs("MaxMin")
        x.PARA = rs("Para")
        Set x.Para_prop = Props.search(rs("PARA_Prop"))
        x.Para_comp = rs("PARA_COMP")
        x.Para_valor = rs("Para_valor")
        x.Por = rs("Por")
        x.Aberta = rs("aberta")
        Set x.Por_Prop = Props.search(rs("POR_Prop"))
        x.Warn = rs("Warn")
        x.MovementRule = rs("MovementRule")
        x.ANDRule = rs("ANDRULE")
        Set x.AND_prop = Props.search(CritN(rs("AND_PROP")))
        x.AND_comp = CritS(rs("AND_COMP"))
        x.AND_valor = CritS(rs("AND_VALOR"))
        x.Escopo = CritS(rs("ESCOPO"))
        x.Lim_Ref = CritS(rs("LIM_REF"))
        x.Conector = rs("CONECTOR")
        x.AND2Rule = rs("AND2RULE")
        x.AND2_comp = CritS(rs("AND2_COMP"))
        x.AND2_valor = CritS(rs("AND2_VALOR"))
        Set x.AND2_prop = Props.search(CritN(rs("AND2_PROP")))
        x.AND3Rule = rs("AND3RULE")
        x.AND3_comp = CritS(rs("AND3_COMP"))
        x.AND3_valor = CritS(rs("AND3_VALOR"))
        Set x.AND3_prop = Props.search(CritN(rs("AND3_PROP")))
        
        
        Set x.Issue_Prop = Props.search(CritN(rs("Issue_Prop")))
        c.Add x
        rs.MoveNext
    Wend
    
End Sub

Public Function search(x As Integer) As CRegra
    Dim y As CRegra
    For Each y In c
        If y.ID = x Then Set search = y
    Next y
End Function

Public Function searchNome(x As String) As CRegra
    Dim y As CRegra
    For Each y In c
        If y.nome = x Then Set searchNome = y
    Next y
End Function

Public Sub Exclui(x As CRegra)
    Dim b As CBook, EhUsada As Boolean, R1 As CRegra
    Dim db As ADODB.Connection, rs As ADODB.Recordset, i As Integer
    
    'Verifica se regra é usada em algum book
    EhUsada = False
    For Each b In Books.c
        For Each R1 In b.c
            If R1 Is x Then EhUsada = True
        Next R1
    Next b
    
    If EhUsada Then
        MsgBox ("Regra está em uso. Exclusão cancelada.")
    Else
        'Retira do Database
        If MainStatus = "LIVE" Then
            
            Set db = OpenTheDatabase
            db.Execute ("UPDATE TREGRAS SET DELETED=1, DT_DELETED=" + SQLBaseDate + " WHERE ID=" + Str(x.ID))
            
        End If
        
        'Retira da Lista
        For i = 1 To c.Count - 1
            If c(i) Is x Then c.remove (i)
        Next i
        If c(c.Count) Is x Then c.remove c.Count
        
        'Refaz Forms
        Books.Recalc
        FMain.Refaz
    End If
    
End Sub


Public Function Cria(x As String) As CRegra
    Dim db As ADODB.Connection, rs As ADODB.Recordset, y As CRegra, LastNumber As Integer
    
    If MainStatus = "LIVE" Then
        
        Set db = OpenTheDatabase
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT MAX (ID) AS MAXID FROM TREGRAS", db, adOpenForwardOnly, adLockReadOnly)
        If rs.EOF Then LastNumber = 0 Else LastNumber = rs("MAXID")
        rs.Close
        
        order = "INSERT INTO TREGRAS (ID, NOME, MAXMIN, LIMITE, POR, POR_PROP, PARA, PARA_PROP, PARA_VALOR, WORKLOW, WARN, PARA_COMP, ABERTA, DELETED, DT_CREATED, DT_DELETED, ESCOPO, LIM_REF) " + _
            "VALUES (" + Str(LastNumber + 1) + ", '" + x + "', 'MAX', 0, FALSE, 0, FALSE, 0, '', 0, 0, '', 0, 0, " + SQLBaseDate + "," + SQLBaseDate + ",'CTRL','PL')"
        
        db.Execute order
        
    
        Set y = New CRegra
        y.ID = LastNumber + 1
        y.nome = x
        c.Add y
    Else
        Set y = New CRegra
        y.ID = 9999
        y.nome = x
        c.Add y
    End If
    Set Cria = y
End Function


Public Sub HighLevelCria()
    Dim xnome As String, x As CRegra
    xnome = FInput.Pergunte("Nome da Regra a ser criada:")
    If xnome <> "" Then
        If searchNome(xnome) Is Nothing Then
            Set x = Cria(xnome)
            FEditRegra.showfor x
        Else
            MsgBox ("Nome já existente.")
        End If
    End If
End Sub


Public Sub Clona(y As CRegra)
    Dim xnome As String, x As CRegra, sugg As String
    For i = 10 To 1 Step -1
        If Me.searchNome(y.nome + " (" + Trim(Str(i)) + ")") Is Nothing Then sugg = y.nome + " (" + Trim(Str(i)) + ")"
    Next i
    
    xnome = FInput.Pergunte("Nome da Regra a ser criada:", "STRING", sugg)
    If xnome <> "" Then
        If searchNome(xnome) Is Nothing Then
            Set x = Cria(xnome)
            x.CloneFrom y
            x.WriteDB
            FEditRegra.showfor x
        Else
            MsgBox ("Nome já existente.")
        End If
    End If
End Sub


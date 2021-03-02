VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CPropriedades"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public c As New Collection

Public PropK1 As CPropriedade
Public PropK2 As CPropriedade
Public PropK3 As CPropriedade
Public PropK4 As CPropriedade
Public PropK5 As CPropriedade
Public PropK6 As CPropriedade

Private PropertyIndex(1000) As Integer 'referencia cruzada de propriedade: input:ID, output:index

Public CreditPropertyIdx As Integer
Public IRBPropertyIdx As Integer
Public LastRatingPropertyIdx As Integer


Property Get PropIndex(ID As Integer) As Integer
    'Expoe o array para uso externo
    PropIndex = PropertyIndex(ID)
End Property


Private Sub FazPropIndex()
    Dim i As Integer
    For i = 1 To c.Count
        PropertyIndex(c(i).ID) = i
    Next i
End Sub

Public Sub ReadDB()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, x As CPropriedade
    Set c = New Collection
    
    Set db = OpenTheDatabase(True)
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM TPROPRIEDADES ORDER BY NOME", db, adOpenForwardOnly, adLockReadOnly)
    If Not rs.EOF Then rs.MoveFirst
    While Not rs.EOF
        DoEvents
        Set x = New CPropriedade
        x.Nome = rs("Nome")
        x.ID = rs("ID")
        x.ValorLivre = rs("ValorLivre")
        Set db = OpenTheDatabase
        Set rs1 = New ADODB.Recordset
        Call rs1.open("SELECT * FROM TPROPVALUES WHERE PROPRIEDADE=" + Str(rs("ID")) + " ORDER BY VALOR", db, adOpenForwardOnly, adLockReadOnly)
        If Not rs1.EOF Then rs1.MoveFirst
        While Not rs1.EOF
            DoEvents
            x.AddNew (rs1("Valor"))
            rs1.MoveNext
        Wend
        c.Add x
        rs.MoveNext
    Wend
    
    
    
    '---Cria os dummys das extras (mas não inclui na coleção)
    Set PropK1 = New CPropriedade: PropK1.ID = -1: PropK1.Nome = K_PropName1
    Set PropK2 = New CPropriedade: PropK2.ID = -2: PropK2.Nome = K_PropName2
    Set PropK3 = New CPropriedade: PropK3.ID = -3: PropK3.Nome = K_PropName3
    Set PropK4 = New CPropriedade: PropK4.ID = -4: PropK4.Nome = K_PropName4
    Set PropK5 = New CPropriedade: PropK5.ID = -5: PropK5.Nome = K_PropName5
    Set PropK6 = New CPropriedade: PropK6.ID = -6: PropK6.Nome = K_PropName6
    Set PropK10 = New CPropriedade: PropK10.ID = -10: PropK10.Nome = K_PropName10
    Set PropK11 = New CPropriedade: PropK11.ID = -11: PropK11.Nome = K_PropName11
    
    '---Monta PropertyIdx
    FazPropIndex
    
    
    '---Busca e Coloca as Propriedades com nomes
    CreditPropertyIdx = 0
    IRBPropertyIdx = 0
    LastRatingProperty = 0
    For i = 1 To c.Count
        If UCase(c(i).Nome) = UCase(Config.CreditRatingProperty) Then CreditPropertyIdx = i
        If UCase(c(i).Nome) = UCase(Config.IRBRatingProperty) Then IRBPropertyIdx = i
        If UCase(c(i).Nome) = UCase(Config.LastRatingProperty) Then LastRatingPropertyIdx = i
    Next i
End Sub


Public Function search(x As Integer) As CPropriedade
    Dim y As CPropriedade
    Select Case x
    Case -1
        Set search = PropK1
    Case -2
        Set search = PropK2
    Case -3
        Set search = PropK3
    Case -4
        Set search = PropK4
    Case -5
        Set search = PropK5
    Case -6
        Set search = PropK6
    Case -10
        Set search = PropK10
    Case -11
        Set search = PropK11
    Case Else
        For Each y In c
            If y.ID = x Then Set search = y
        Next y
    End Select
End Function


Public Function searchName(x As String) As CPropriedade
    Dim y As CPropriedade
    Select Case x
    Case K_PropName1
        Set searchName = PropK1
    Case K_PropName2
        Set searchName = PropK2
    Case K_PropName3
        Set searchName = PropK3
    Case K_PropName4
        Set searchName = PropK4
    Case K_PropName5
        Set searchName = PropK5
    Case K_PropName6
        Set searchName = PropK6
    Case K_PropName10
        Set searchName = PropK10
    Case K_PropName11
        Set searchName = PropK11
    Case Else
        For Each y In c
            If UCase(y.Nome) = UCase(x) Then Set searchName = y
        Next y
    End Select
End Function

Public Function SearchIndexByName(x As String) As Integer
    Dim i As Integer
    Select Case x
    Case K_PropName1
        SearchIndexByName = -1
    Case K_PropName2
        SearchIndexByName = -2
    Case K_PropName3
        SearchIndexByName = -3
    Case K_PropName4
        SearchIndexByName = -4
    Case K_PropName5
        SearchIndexByName = -5
    Case K_PropName6
        SearchIndexByName = -6
    Case K_PropName10
        SearchIndexByName = -10
    Case K_PropName11
        SearchIndexByName = -11
    Case Else
        For i = 1 To c.Count
            If c(i).Nome = x Then SearchIndexByName = i
        Next i
    End Select
End Function

Public Function SearchIndex(x As Integer) As Integer
    Dim i As Integer, j As Integer
    If x < 0 Then
        SearchIndex = x
    Else
        SearchIndex = PropertyIndex(x)
    End If
End Function

Public Sub FillComboWithProps(ByRef x As ComboBox, Optional WithExtras As Boolean = False)
    Dim y As CPropriedade
    x.Clear
    If WithExtras Then
        x.AddItem K_PropName1
        x.AddItem K_PropName2
        x.AddItem K_PropName3
        x.AddItem K_PropName4
        x.AddItem K_PropName5
        x.AddItem K_PropName6
    End If
    For Each y In c
        x.AddItem y.Nome
    Next y
    x.AddItem K_PropName10
    x.AddItem K_PropName11
End Sub

Public Sub FillComboWithPropValues(h As String, ByRef x As ComboBox)
    Dim y As CPropriedade, i As Integer
    
    x.Clear
    Select Case h
        Case K_PropName1
            x.AddItem "CASH"
            x.AddItem "OVER"
            x.AddItem "TITPUB"
            x.AddItem "CDBS"
            x.AddItem "EUROBOND"
            x.AddItem "CDBN"
            x.AddItem "CDBM"
            x.AddItem "LF"
            x.AddItem "DEB400"
            x.AddItem "CDBSUB"
            x.AddItem "LFSUB"
            x.AddItem "NOTAP"
            x.AddItem "FIILIST"
            x.AddItem "DEB400CALL"
            x.AddItem "DEB476"
            x.AddItem "F409"
            x.AddItem "FIDC"
            x.AddItem "CRI"
        Case K_PropName2
            x.AddItem "OVER"
            x.AddItem "ZERO"
            x.AddItem "MATURITY"
            x.AddItem "PERP"
        Case K_PropName3
            x.AddItem "CDI+"
            x.AddItem "%CDI"
            x.AddItem "IPCA+"
            x.AddItem "IGPM+"
            x.AddItem "IGPDI+"
            x.AddItem "FIXED"
            x.AddItem "IFIX"
        Case K_PropName4
            Papeis.FillComboWithNames x
        Case K_PropName5
            Papeis.FillComboWithISIN x
        Case K_PropName6
            Papeis.FillComboWithCETIP x
        Case K_PropName10
            'nada
        Case K_PropName11
            'nada
        Case Else
            Set y = searchName(h)
            If Not y Is Nothing Then
                For i = 1 To y.N
                    x.AddItem y.Valor(i)
                Next i
            End If
    End Select
End Sub



Public Function Cria(x As String) As CPropriedade
    Dim db As ADODB.Connection, rs As ADODB.Recordset, y As CPropriedade, LastNumber As Integer
    
    If MainStatus = "LIVE" Then
        
        Set db = OpenTheDatabase
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT MAX (ID) AS MAXID FROM TPROPRIEDADES", db, adOpenForwardOnly, adLockReadOnly)
        If rs.EOF Then LastNumber = 0 Else LastNumber = rs("MAXID")
        rs.Close
            
        db.Execute ("INSERT INTO TPROPRIEDADES (ID, NOME) VALUES (" + Str(LastNumber + 1) + ",'" + x + "')")
        
    
        Set y = New CPropriedade
        y.ID = LastNumber + 1
        y.Nome = x
        c.Add y
    Else
        Set y = New CPropriedade
        y.ID = 9999
        y.Nome = x
        c.Add y
    End If
    FazPropIndex
    Set Cria = y
    
End Function

Public Sub HighLevelCria()
    Dim xnome As String, x As CPropriedade
    xnome = FInput.Pergunte("Nome da Propriedade a ser criada:")
    If xnome <> "" Then
        If searchName(xnome) Is Nothing Then
            Set x = Cria(xnome)
            FEditprop.showfor x
        Else
            MsgBox ("Nome já existente.")
        End If
    End If
End Sub


Public Sub Delete(ID As String)
    Dim i As Integer, f As CPapel
    Dim db As ADODB.Connection, rs As ADODB.Recordset, y As CPropriedade, LastNumber As Integer
    
    If MainStatus = "LIVE" Then
        
        Set db = OpenTheDatabase
        db.Execute ("DELETE FROM TPROPRIEDADES WHERE ID=" + Str(ID))
        db.Execute ("DELETE FROM TPROPVALUES WHERE PROPRIEDADE = " + Str(ID))
        db.Execute ("DELETE FROM TPAPELPROP WHERE PROPRIEDADE = " + Str(ID))
        
    End If
    
    'Deleta da lista e dos papéis
    For Each f In Papeis.c
        f.DeleteProp (ID)
    Next f
    
    For i = 1 To c.Count - 1
        If c(i).ID = ID Then c.remove (i)
    Next i
    If c(c.Count).ID = ID Then c.remove (c.Count)
    
    FazPropIndex
End Sub


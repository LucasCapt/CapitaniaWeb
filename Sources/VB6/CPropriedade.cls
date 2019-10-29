VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CPropriedade"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public ID As Integer
Public nome As String
Public ValorLivre As Boolean
Private L_Valor(1000) As String
Public N As Integer

Property Get Valor(i As Integer) As String
    Valor = L_Valor(i)
End Property

'Property Set Valor(i As Integer, v As String)
'    L_Valor(i) = v
'End Property

Public Sub Clear()
    N = 0
End Sub

Public Sub AddNew(v As String)
    'Acrescenta Ordenado
    
    Dim i As Integer
    i = 1
    While i <= N And v > L_Valor(i)
        i = i + 1
    Wend
    N = N + 1
    For j = N To i + 1 Step -1
        L_Valor(j) = L_Valor(j - 1)
    Next j
    L_Valor(i) = v
End Sub

Property Get search(v As String) As Integer
    i = 1
    While i <= N And L_Valor(i) <> v: i = i + 1: Wend
    If L_Valor(i) <> v Then search = 0 Else search = i
End Property

Property Get IncludesOneOf(v As String) As Boolean
    Dim palavra As String
    i = 1: b = 1
    IncludesOneOf = False
    While InStr(i, v, ",") <> 0
        b = InStr(i, v, ",")
        palavra = Trim(Mid(v, i, b - 1))
        If search(palavra) > 0 Then IncludesOneOf = True
        i = b + 1
    Wend
    palavra = Trim(Mid(v, i))
    If search(palavra) > 0 Then IncludesOneOf = True
End Property

Property Get valores() As String
    Dim i As Integer, a As String
        a = ""
    If ValorLivre Then
        valores = "(livre)"
    Else
        For i = 1 To N
            a = a + L_Valor(i) + ", "
        Next i
        If a <> "" Then valores = Left(a, Len(a) - 2)
    End If
End Property


Public Sub WriteDB()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, sbPor As String, sbPara As String, order As String, SpPara As String, SpPor As String
    Dim u1 As String
    
    If MainStatus = "LIVE" Then
        
        Set db = OpenTheDatabase
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT * FROM TPROPRIEDADES WHERE ID=" + Str(Me.ID), db, adOpenForwardOnly, adLockReadOnly)
        If Not rs.EOF Then
            rs.Close
            db.Execute ("DELETE FROM TPROPRIEDADES WHERE ID=" + Str(Me.ID))
        Else
            rs.Close
        End If
            
        If Me.ValorLivre Then u1 = "1" Else u1 = "0"
        db.Execute ("INSERT INTO TPROPRIEDADES (ID, NOME, VALORLIVRE) VALUES (" + Str(Me.ID) + ", '" + Me.nome + "'," + u1 + ")")
        
        db.Execute ("DELETE FROM TPROPVALUES WHERE PROPRIEDADE=" + Str(Me.ID))
        For i = 1 To N
            db.Execute ("INSERT INTO TPROPVALUES (PROPRIEDADE, VALOR) VALUES (" + Str(Me.ID) + ", '" + L_Valor(i) + "')")
        Next i
        
        
    End If
End Sub


Public Function succ(x As String) As String
    Dim i As Integer
    If ValorLivre Then
        succ = x
    Else
        If x = "" Or L_Valor(N) = x Then
            succ = L_Valor(1)
        Else
            For i = 1 To N - 1
                If L_Valor(i) = x Then succ = L_Valor(i + 1)
            Next i
        End If
    End If
End Function

Public Function FirstWithLetter(a As String, x As String) As String
    Dim i As Integer
    If ValorLivre Then
        FirstWithLetter = x
    Else
        i = 1
        While i <= N And StrComp(Left(L_Valor(i), 1), a, vbTextCompare) = -1
            i = i + 1
        Wend
        FirstWithLetter = L_Valor(i)
    End If
End Function

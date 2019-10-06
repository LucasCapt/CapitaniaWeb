VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CStress"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private Nomes(1000) As String
Private Titulos(1000) As String
Private Percent(1000) As Double
Private N As Integer

Public Sub ReadDB()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, x As CPapel
    
    Set db = OpenTheDatabase(True)
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM TSTRESS ORDER BY NOME", db, adOpenForwardOnly, adLockReadOnly)
    If Not rs.EOF Then rs.MoveFirst
    N = 0
    While Not rs.EOF
        DoEvents
        N = N + 1
        Nomes(N) = rs("nome")
        Titulos(N) = rs("titulo")
        Percent(N) = rs("Percentual")
        rs.MoveNext
    Wend
    Ordena
End Sub


Property Get ListaDeCenarios() As Collection
    Dim u As CNomeValor, a As Collection
    
    Set a = New Collection
    If N > 0 Then
        Set u = New CNomeValor
        u.Nome = Nomes(1)
        a.Add u
    End If
    For i = 2 To N
        If Nomes(i) <> Nomes(i - 1) Then
            Set u = New CNomeValor
            u.Nome = Nomes(i)
            a.Add u
        End If
    Next i
    
    Set ListaDeCenarios = a
End Property

Public Sub WriteDB()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, x As CPapel
    If MainStatus = "LIVE" Then
        
        Set db = OpenTheDatabase(True)
        Ordena
        db.Execute ("DELETE FROM TSTRESS")
        For i = 1 To N
            db.Execute ("INSERT INTO TSTRESS (NOME, TITULO, PERCENTUAL) VALUES ('" + Nomes(i) + "','" + Titulos(i) + "'," + Str(Percent(i)) + ")")
        Next i
    End If
End Sub


Public Function ApplyToFund(cenario As String, x As CFundo) As Double
    Dim impacto As Double, i As Integer, v As Double, q As Double

    If x.PLTotal > 0 Then
        impacto = 0
        For i = 1 To N
            If Nomes(i) = cenario Then
                x.PapelValues Titulos(i), True, v, q
                impacto = impacto + max(0, v) * Percent(i)
            End If
        Next i
        ApplyToFund = impacto / x.PLTotal
    Else
        ApplyToFund = 0
    End If
End Function

Public Sub FillComboWithNome(x As Object)
    x.Clear
    If N > 0 Then x.AddItem Nomes(1)
    For i = 2 To N
        If Nomes(i) <> Nomes(i - 1) Then x.AddItem Nomes(i)
    Next i
End Sub

Public Sub FillGridColsWithNome(x As MSFlexGrid)
    x.Cols = 1
    If N > 0 Then
        x.Cols = 2
        x.TextMatrix(0, 1) = Nomes(1)
    End If
    For i = 2 To N
        If Nomes(i) <> Nomes(i - 1) Then
            x.Cols = x.Cols + 1
            x.TextMatrix(0, x.Cols - 1) = Nomes(i)
        End If
    Next i
End Sub

Public Sub FillGrid(Nome As String, x As MSFlexGrid)
    Dim i As Integer, L As Integer
    L = 0
    x.Rows = 1
    For i = 1 To N
        If Nomes(i) = Nome Then
            L = L + 1
            x.AddItem Format(Percent(i), "##0.00%")
            x.TextMatrix(L, 1) = Titulos(i)
        End If
    Next i
End Sub


Private Sub Ordena()
    Dim i As Integer, j As Integer, p1 As Double, n1 As String, t1 As String
    For i = 1 To N - 1
        For j = i + 1 To N
            If Nomes(j) < Nomes(i) Then
                n1 = Nomes(i)
                t1 = Titulos(i)
                p1 = Percent(i)
                Nomes(i) = Nomes(j)
                Titulos(i) = Titulos(j)
                Percent(i) = Percent(j)
                Nomes(j) = n1
                Titulos(j) = t1
                Percent(j) = p1
            End If
        Next j
    Next i
End Sub


Public Sub Exclui(cenario As String, titulo As String)
    'Exclui 1 choque do cenário
    Dim i As Integer, j As Integer
    i = 1
    While i <= N
        If Nomes(i) = cenario And Titulos(i) = titulo Then
            For j = i To N - 1
                Nomes(j) = Nomes(j + 1)
                Titulos(j) = Titulos(j + 1)
                Percent(j) = Percent(j + 1)
            Next j
            N = N - 1
        End If
        i = i + 1
    Wend
End Sub


Public Sub Deleta(cenario As String)
    Dim i As Integer, j As Integer
    'Exclui 1 cenário inteiro
    i = 1
    While i <= N
        If Nomes(i) = cenario Then
            For j = i To N - 1
                Nomes(j) = Nomes(j + 1)
                Titulos(j) = Titulos(j + 1)
                Percent(j) = Percent(j + 1)
            Next j
            N = N - 1
        End If
        i = i + 1
    Wend
End Sub

Public Sub Inlcui(cenario As String, titulo As String, Perc As Double)
    Dim achou As Boolean, i As Integer
    
    achou = False
    For i = 1 To N
        If Nomes(i) = cenario And Titulos(i) = titulo Then
            achou = True
            Percent(i) = Perc
        End If
    Next i
    If Not achou Then
        i = 1
        While i <= N And Nomes(i) <= cenario
            i = i + 1
        Wend
        N = N + 1
        For j = N To i + 1 Step -1
            Nomes(j) = Nomes(j - 1)
            Titulos(j) = Titulos(j - 1)
            Percent(j) = Percent(j - 1)
        Next j
        Nomes(i) = cenario
        Titulos(i) = titulo
        Percent(i) = Perc
    End If
End Sub

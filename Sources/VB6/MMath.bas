Attribute VB_Name = "MMath"
'V. 2.127 - Alterada a sub AtualizaErros(). Trocado CritN() por CritNN().


Public Function CritString(x As String) As String
    Dim a As String, i As Integer
    For i = 1 To Len(x)
        If Mid(x, i, 1) <> "'" And Mid(x, i, 1) <> Chr(34) Then a = a + Mid(x, i, 1)
    Next i
    CritString = a
End Function

Public Function CritS(x) As String
    If IsNull(x) Then CritS = "" Else CritS = x
End Function

Public Function CritN(x) As Integer
    If IsNull(x) Then CritN = 0 Else CritN = x
End Function

Public Function CritNN(x) As Double
    If IsNull(x) Then CritNN = 0 Else CritNN = x
End Function

Public Function CritD(x) As Date
    If IsNull(x) Then CritD = LongTimeAgo Else CritD = CDate(x)
End Function

Public Function Bol2Check(x As Boolean) As Integer
    If x Then Bol2Check = vbChecked Else Bol2Check = vbUnchecked
End Function

Public Function Check2Bol(x As Integer) As Boolean
    Check2Bol = (x = vbChecked)
End Function

Public Function CNPJComPonto(x As String) As String
    If IsNumeric(x) Then CNPJComPonto = Left(x, 2) + "." + Mid(x, 3, 3) + "." + Mid(x, 6, 3) + "/" + Mid(x, 9, 4) + "-" + Right(x, 2) Else CNPJComPonto = x
End Function

Public Function SQLD(x As Date) As String
    SQLD = "'" + Format(x, "yyyy-MM-dd") + "'"
End Function

Public Function SQLBaseDate() As String
    SQLBaseDate = SQLD(BaseDate)
End Function

Public Function SQLNow() As String
    SQLNow = SQLD(Now())
End Function

Public Function SQLTimeStamp() As String
    SQLTimeStamp = SQLLongTime(Now())
End Function

Public Function SQLLongTime(x As Date) As String
    SQLLongTime = "'" + Format(x, "yyyy-MM-dd HH:mm:ss") + "'"
End Function

Public Function FormatLimit(x As Double, r As CRegra)
    If r.Lim_Ref = "VALUE" Then
        FormatLimit = FNumkMM(x)
    Else
        FormatLimit = Format(x, "##0.00") + "%"
    End If
End Function

Public Function FormatLiqSt(x As Double) As String
    If x <= 0# Then
        FormatLiqSt = "<1%"
    ElseIf x >= 0.25 Then
        FormatLiqSt = ">25%"
    Else
        FormatLiqSt = Format(x, "##0.0%")
    End If
End Function

Public Sub PintaLinha(Grid As MSFlexGrid, L As Integer, cor As Long)
    Grid.FillStyle = flexFillRepeat
    Grid.Row = L: Grid.Col = 0
    Grid.RowSel = L: Grid.ColSel = Grid.Cols - 1
    Grid.CellBackColor = cor
End Sub

Public Function CNPJSemPonto(x As String) As String
    Dim a As String, i As Integer
    a = ""
    For i = 1 To Len(x)
        u = Mid(x, i, 1)
        If u <> "." And u <> "/" And u <> "-" Then a = a + u
    Next i
    CNPJSemPonto = a
End Function

Public Function FNumkMM(x As Double) As String
    If Abs(x) > 1000000# Then
        FNumkMM = Format(x / 1000000#, "##0.0") + "MM"
    Else
        FNumkMM = Format(x / 1000, "##0.0") + "k"
    End If
End Function


Public Function min(a, b As Variant) As Variant
    If a < b Then min = a Else min = b
End Function

Public Function max(a, b As Variant) As Variant
    If a > b Then max = a Else max = b
End Function

Public Function FileExists(x As String) As Boolean
    FileExists = (FileSystem.Dir(x) <> "")
End Function


Public Function GetFolders(x As String) As Collection
    Dim c As Collection, y As CNomeValor, a As String
    Set c = New Collection
    a = FileSystem.Dir(x + "*.", vbDirectory)
    While a <> ""
        If a <> "." And a <> ".." Then
            Set y = New CNomeValor
            y.nome = a
            c.Add y
        End If
        a = FileSystem.Dir()
    Wend
    Set GetFolders = c
End Function


Public Function BinomDist(k, N, p) As Double
    If k = 0 Then
        BinomDist = (1 - p) ^ N
    Else
        BinomDist = p * (N - k + 1) / (1 - p) / k * BinomDist(k - 1, N, p)
    End If
End Function


'-------------------------------------------------------------------------------------------------------------
'  Ct-C
'-------------------------------------------------------------------------------------------------------------
Public Sub CopyRangeToClipboard(Obj As Object, Optional Plain As Boolean = False)
    'Copia um range para o clipboard
    'Plain faz com que os cabeçalhos de linhas não sejam copiados
    Dim i As Integer, j As Integer
    Dim inirow As Integer, fimrow As Integer, inicol As Integer, fimcol As Integer
    Dim st As String
    If Obj.RowSel > 0 Then
        inirow = min(Obj.Row, Obj.RowSel)
        fimrow = max(Obj.Row, Obj.RowSel)
    Else
        inirow = Obj.Row
        fimrow = inirow
    End If
    If Obj.ColSel > 0 Then
        inicol = min(Obj.Col, Obj.ColSel)
        fimcol = max(Obj.Col, Obj.ColSel)
    Else
        inicol = Obj.Col
        fimcol = inicol
    End If
    st = "" + Chr(9)
    '--Grava a primeira linha
    For j = inicol To fimcol - 1
        st = st + TiraCR(Obj.TextMatrix(0, j)) + Chr(9)
    Next j
    st = st + TiraCR(Obj.TextMatrix(0, fimcol)) + Chr(13)
    For i = inirow To fimrow
        If Not Plain Then st = st + TiraCR(Obj.TextMatrix(i, 0)) + Chr(9)
        For j = inicol To fimcol - 1
            st = st + ClipCR(Obj.TextMatrix(i, j)) + Chr(9)
        Next j
        st = st + ClipCR(Obj.TextMatrix(i, fimcol)) + Chr(13)
    Next i
    Clipboard.Clear
    Call Clipboard.SetText(st, vbCFText)
End Sub

Private Function ClipCR(x As String) As String
    'Retorna a porção de x anterior ao CR ou LF
    Dim p1, p As Integer, u As String
    p1 = InStr(1, x, Chr(13))
    p = InStr(1, x, Chr(10))
    If p = 0 Then
        p = p1
    ElseIf p1 <> 0 Then
        p = min(p, p1)
    End If
    '--- antes de 1.28:
    '    If p > 1 Then ClipCR = left(x, p - 1) Else ClipCR = x
    '---1.28 em diante:
    If p > 1 Then u = Left(x, p - 1) Else u = x
    ClipCR = Replace(u, ",", "")
End Function

Private Function TiraCR(x As String) As String
    Dim y As String
    y = Replace(x, Chr(13), ".")
    TiraCR = Replace(y, Chr(10), " ")
End Function

Public Function FitString(x As String, N As Integer, Optional align As String = "R") As String
    If Len(x) < N Then
        Select Case align
            Case "R"
                FitString = Right(Space(N + 1) + x, N)
            Case "L"
                FitString = Left(x + Space(N + 1), N)
            Case "C"
                FitString = Left(Space((N - Len(x)) / 2) + x + Space(N), N)
        End Select
    Else
        FitString = Left(x, N)
    End If
End Function


Public Function WrapText(MaxLen As Integer, Ident As Integer, s As String) As String
    Dim h As String, a As String
    h = s
    a = ""
    While Len(h) > MaxLen
        a = a + Left(h, MaxLen) + vbCr
        h = Space(Ident) + Mid(h, MaxLen + 1)
    Wend
    a = a + Left(h, MaxLen)
    WrapText = a
End Function

Public Function ConsonantsTo(x As String, N As Integer) As String
    'Retorna as n primeiras consoantes
    Dim a As String, u As String
    a = ""
    For i = 1 To Len(x)
        u = Mid(x, i, 1)
        If u <> "a" And u <> "e" And u <> "i" And u <> "o" And u <> "u" And Len(a) < N Then a = a + u
    Next i
    ConsonantsTo = a
End Function


Public Function ClipNames(x As String, N As Integer) As String
    'Clipa uma lista de nomes em [] para N caracteres + "+"
    Dim i As Integer, i1 As Integer, n1 As Integer
    If Len(x) <= N Then
        ClipNames = x
    Else
        'procura o ]
        i = 0
        While i < N
            i1 = i
            i = InStr(i + 1, x, "]")
        Wend
        If i1 > 0 Then i = i1
        n1 = i + 1
        a = 0
        For i = n1 To Len(x)
            If Mid(x, i, 1) = "[" Then a = a + 1
        Next i
        ClipNames = Left(x, n1) + "+" + Str(a)
    End If
End Function

Public Function Bol2String(x As Boolean) As String
    If x Then Bol2String = "TRUE" Else Bol2String = "FALSE"
End Function


'-------------------------------------------------------------------------------------------------------------
'  log
'-------------------------------------------------------------------------------------------------------------
Public Sub WriteLog(acao As String)
    Dim db As ADODB.Connection, rs As ADODB.Recordset
    
    Set db = OpenTheDatabase
    db.Execute ("INSERT INTO TLOG (DATAHORA, ACAO, [USER], COMPUTER) VALUES ('" + Format(Now(), "YYYY-MM-DD HH:MM:SS") + "','" + acao + "','" + User.username + "','" + Environ("ComputerName") + "')")
End Sub


Public Sub WriteLogPerf(acao As String, items As Integer, segundos As Double)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, i_s As Double, s_i As Double
    If segundos > 0 Then i_s = items / segundos
    If items > 0 Then s_i = segundos / items
    
    Set db = OpenTheDatabase
    db.Execute ("INSERT INTO TLOGPERF (DATAHORA, OPER, [USER], ITENS, SECS, ITEMPERSEC, SECPERITEM) VALUES " + _
                "('" + Format(Now(), "YYYY-MM-DD HH:MM:SS AM/PM") + "','" + acao + "','" + User.username + "'," + _
                Str(items) + "," + Str(segundos) + "," + Str(i_s) + "," + Str(s_i) + ")")
End Sub

Public Sub WriteLogError(ErrMsg As String, ErrItem As String)
    Dim db As ADODB.Connection, rs As ADODB.Recordset
    
    Set db = OpenTheDatabase
    db.Execute ("INSERT INTO TLOGERRO (DATAHORA, MSGERRO, ITEM, [USER]) VALUES ('" + Format(Now(), "YYYY-MM-DD HH:MM:SS") + "','" + ErrMsg + "','" + ErrItem + "','" + User.username + "')")
End Sub

Public Sub AtualizaErros()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, d As Date
    
    Set db = OpenTheDatabase
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT MAX (DATAHORA) AS LASTREVISION FROM TLOG WHERE ACAO = 'REVIU ERROS'", db, adOpenForwardOnly, adLockReadOnly)
    If rs.EOF Then d = LongTimeAgo Else d = CritD(rs("LASTREVISION"))
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT COUNT(1) AS NERROS FROM TLOGERRO WHERE DATAHORA>" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
    If rs.EOF Then NumErrors = 0 Else NumErrors = CritNN(rs("NERROS"))
End Sub

'-------------------------------------------------------------------------------------------------------------
'  flags de importação e exportação
'-------------------------------------------------------------------------------------------------------------

Public Function JahImportouNoDia(qual As String) As Boolean
    Dim db As ADODB.Connection, rs As ADODB.Recordset
    
    Set db = OpenTheDatabase
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM THISTIMPORTREPORT WHERE QUAL='" + qual + "' AND DATARUN=" + SQLNow, db, adOpenForwardOnly, adLockReadOnly)
    JahImportouNoDia = Not rs.EOF

End Function

Public Function JahReportouNoDia() As Boolean
    Dim db As ADODB.Connection, rs As ADODB.Recordset
    
    Set db = OpenTheDatabase
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM THISTIMPORTREPORT WHERE QUAL='REPORT' AND DATARUN=" + SQLNow, db, adOpenForwardOnly, adLockReadOnly)
    JahReportouNoDia = Not rs.EOF

End Function

Public Sub FlagImportouNoDia(qual As String)
    Dim db As ADODB.Connection, rs As ADODB.Recordset
    
    Set db = OpenTheDatabase
    db.Execute ("INSERT INTO THISTIMPORTREPORT (DATARUN, QUAL, QUEM) VALUES (" + SQLNow + ",'" + qual + "','" + User.username + "')")

End Sub

Public Sub FlagReportouNoDia()
    Dim db As ADODB.Connection, rs As ADODB.Recordset
    
    Set db = OpenTheDatabase
    db.Execute ("INSERT INTO THISTIMPORTREPORT (DATARUN, QUAL, QUEM) VALUES (" + SQLNow + ",'REPORT','" + User.username + "')")
End Sub



Public Function RatingPlus1(x As String) As String
    Select Case x
        Case "", "-", "n/a"
            RatingPlus1 = ""
        Case "AAA"
            RatingPlus1 = "AAA"
        Case "AA+"
            RatingPlus1 = "AAA"
        Case "AA"
            RatingPlus1 = "AA+"
        Case "AA-"
            RatingPlus1 = "AA"
        Case "A+"
            RatingPlus1 = "AA-"
        Case "A"
            RatingPlus1 = "A+"
        Case "A-"
            RatingPlus1 = "A"
        Case "BBB+"
            RatingPlus1 = "A-"
        Case "BBB"
            RatingPlus1 = "BBB+"
        Case "BBB-"
            RatingPlus1 = "BBB"
        Case "BB+"
            RatingPlus1 = "BBB-"
        Case "BB"
            RatingPlus1 = "BB+"
        Case "BB-"
            RatingPlus1 = "BB"
        Case "B+"
            RatingPlus1 = "BB-"
        Case "B"
            RatingPlus1 = "B+"
        Case "B-"
            RatingPlus1 = "B"
        Case "CCC", "CC", "C"
            RatingPlus1 = "B-"
    End Select
End Function

Public Function PDFromRating(Rating As String) As Double
    Select Case Rating
        Case "AAA"
            PDFromRating = Config.EDFAAA / 100
        Case "AA+", "Aa1"
            PDFromRating = (Config.EDFAAA + Config.EDFAA) / 200
        Case "AA", "Aa2"
            PDFromRating = Config.EDFAA / 100
        Case "AA-", "Aa3"
            PDFromRating = (Config.EDFAA * 2 + Config.EDFA) / 300
        Case "A+", "A1"
            PDFromRating = (Config.EDFAA + Config.EDFA * 2) / 300
        Case "A", "A2"
            PDFromRating = Config.EDFA / 100
        Case "A-", "A3"
            PDFromRating = (Config.EDFA * 2 + Config.EDFBBB) / 300
        Case "BBB+", "Baa1"
            PDFromRating = (Config.EDFA + Config.EDFBBB * 2) / 300
        Case "BBB", "Baa2"
            PDFromRating = Config.EDFBBB / 100
        Case "BBB-", "Baa3"
            PDFromRating = (Config.EDFBBB * 2 + Config.EDFBB) / 300
        Case "BB+", "Ba1"
            PDFromRating = (Config.EDFBBB + Config.EDFBB * 2) / 300
        Case "BB", "Ba2"
            PDFromRating = Config.EDFBB / 100
        Case "BB-", "Ba3"
            PDFromRating = (Config.EDFBB * 2 + Config.EDFB) / 300
        Case "B+", "B1"
            PDFromRating = (Config.EDFBB + Config.EDFB * 2) / 300
        Case "B", "B2"
            PDFromRating = Config.EDFB / 100
        Case "B-", "B3"
            PDFromRating = (Config.EDFB + Config.EDFCCC) / 200
        Case "CCC", "CC", "C"
            PDFromRating = Config.EDFCCC / 100
        Case "D"
            PDFromRating = Config.EDFCCC / 100
        Case "não há"
            PDFromRating = Config.EDFBB / 100
        Case "em desenvolvimento"
            PDFromRating = Config.EDFBB / 100
        Case Else
            PDFromRating = Config.EDFBB / 100
    End Select
End Function


Public Function RatingFromPD(PD As Double) As String
    If PD <= Config.EDFAAAask / 100 Then
        RatingFromPD = "AAA"
    ElseIf PD <= (Config.EDFAAAask + Config.EDFAAask) / 200 Then
        RatingFromPD = "AA+"
    ElseIf PD <= Config.EDFAAask / 100 Then
        RatingFromPD = "AA"
    ElseIf PD <= (Config.EDFAAask * 2 + Config.EDFAask) / 300 Then
        RatingFromPD = "AA-"
    ElseIf PD <= (Config.EDFAAask + Config.EDFAask * 2) / 300 Then
        RatingFromPD = "A+"
    ElseIf PD <= Config.EDFAask / 100 Then
        RatingFromPD = "A"
        
    ElseIf PD <= (Config.EDFAask * 2 + Config.EDFBBBask) / 300 Then
        RatingFromPD = "A-"
    ElseIf PD <= (Config.EDFAask + Config.EDFBBBask * 2) / 300 Then
        RatingFromPD = "BBB+"
    ElseIf PD <= Config.EDFBBBask / 100 Then
        RatingFromPD = "BBB"
    ElseIf PD <= (Config.EDFBBBask * 2 + Config.EDFBBask) / 300 Then
        RatingFromPD = "BBB-"
    ElseIf PD <= (Config.EDFBBBask + Config.EDFBBask * 2) / 300 Then
        RatingFromPD = "BB+"
    ElseIf PD <= Config.EDFBBask / 100 Then
        RatingFromPD = "BB"
    ElseIf PD <= (Config.EDFBBask * 2 + Config.EDFBask) / 300 Then
        RatingFromPD = "BB-"
    ElseIf PD <= (Config.EDFBBask + Config.EDFBask * 2) / 300 Then
        RatingFromPD = "B+"
    ElseIf PD <= Config.EDFBask / 100 Then
        RatingFromPD = "B"
    ElseIf PD <= (Config.EDFBask + Config.EDFCCCask) / 200 Then
        RatingFromPD = "B-"
    Else
        RatingFromPD = "CCC"
    End If
End Function

Public Function CredMelhor(a As String, b As String)
    Dim escala As Variant
    escala = Array("AAA", "AA+", "AA", "AA-", "A+", "A", "A-", "BBB+", "BBB", "BBB-", "BB+", "BB", "BB-", "B+", "B", "B-", "CCC", "CC", "C", "D")
    escala2 = Array("AAA", "Aa1", "Aa2", "Aa3", "A1", "A2", "A3", "Baa1", "Baa2", "Baa3", "Ba1", "Ba2", "Ba3", "B1", "B2", "B3", "Caa1", "Caa2", "Caa3", "Ca")
    Dim i As Integer, j As Integer, k As Integer
    j = 20
    k = 0
    For i = 0 To 19
        If escala(i) = a Then j = i
        If escala2(i) = a Then j = i
        If escala(i) = b Then k = i
        If escala2(i) = b Then k = i
    Next i
    CredMelhor = (j <= k)
End Function



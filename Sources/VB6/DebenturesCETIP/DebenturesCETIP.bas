Attribute VB_Name = "MMain"
Private ArrAtivo(2000) As String
Private NAtivo As Integer

Sub Main()
    importa
    exporta
End Sub



Sub importa()
    Dim Valores(30) As String, i As Integer, j As Integer, LastDate As Date, Maxdate As Date
    Dim db As Database, db2 As Database, rs As Recordset, rs2 As Recordset
    Dim L As String, Filename As String
    
    FProgress.Show
    Status = "RUN IMPORT NO RECORD"
    C = 0
    Filename = Lastfilename

    
    'Detecta a última data importada
    Set db = DBEngine.Workspaces(0).OpenDatabase("V:\DebsCETIP\DebsCETIP.accdb")
    'Set db = DBEngine.Workspaces(0).OpenDatabase("C:\DebenturesCETIP\DebsCETIP.accdb")
    Set rs = db.OpenRecordset("SELECT MAX(DATA) AS LASTDATE FROM TDEALS")
    If rs.EOF Then LastDate = DateSerial(1990, 1, 1) Else LastDate = rs("LastDate")
    If IsNull(LastDate) Then LastDate = DateSerial(1990, 1, 1)
    Maxdate = LastDate
    
    Open Filename For Input As #1
    While Not EOF(1)
        DoEvents
        If Status = "RUN IMPORT NO RECORD" Then Status = "RUN IMPORT NO DATE"
        Line Input #1, L
        C = C + 1
        If Left(L, 1) >= "0" And Left(L, 1) <= "9" Then
            If ParseDate(L) > LastDate Then
                Status = "RUN IMPORT NEW"
                If ParseDate(L) > Maxdate Then Maxdate = ParseDate(L)
                For j = 1 To 11: Valores(j) = "": Next j
                j = 1
                For i = 1 To Len(L)
                    If Asc(Mid(L, i, 1)) = 9 Then
                        j = j + 1
                    Else
                        Valores(j) = Valores(j) + Mid(L, i, 1)
                    End If
                Next i
                
                'Parse e coloca no Database
                s = "INSERT INTO TDEALS (DATA, EMISSOR, ATIVO, ISIN, QUANT, NEGS, PUMIN, PUMED, PUMAX, PERCPU) VALUES (" + _
                "#" + Format(ParseDate(Valores(1)), "MM/DD/YYYY") + "#," + _
                "'" + Valores(2) + "'," + _
                "'" + Valores(3) + "'," + _
                "'" + Valores(4) + "'," + _
                ConvNumber(Valores(5)) + "," + _
                ConvNumber(Valores(6)) + "," + _
                ConvNumber(Valores(7)) + "," + _
                ConvNumber(Valores(8)) + "," + _
                ConvNumber(Valores(9)) + "," + _
                ConvNumber(Valores(10)) + ")"
                
                db.Execute s
                
            End If 'se a data é posterior à LastDate
        End If 'se a linha é válida
        
        If C \ 100 = C / 100 Then
            FProgress.Label1 = Str(C)
            FProgress.Refresh
        End If
    Wend
    
    If C > 0 Then Status = Status + " " + Str(C) + " LINES"
    db.Execute ("INSERT INTO TLOG (DATA, STATUS, LASTDATE, LASTDATE2, FILENAME) VALUES (#" + _
        Format(Now(), "MM/DD/YYYY HH:MM") + "#,'" + Status + "',#" + Format(LastDate, "MM/DD/YYYY") + "#,#" + Format(Maxdate, "MM/DD/YYYY") + "#,'" + Filename + "')")
    
    Close #1
    db.Close
    FProgress.Hide
    Unload FProgress
End Sub

Public Function ExistAtivo(x As String) As Boolean
    Dim i As Integer
    i = 1
    While i <= NAtivo And ArrAtivo(i) <> x: i = i + 1: Wend
    ExistAtivo = (ArrAtivo(i) = x)
End Function

Public Sub exporta()
    Dim db As Database, rs As Recordset, rs2 As Recordset, rs3 As Recordset, d As Date, Maxdate As Date, LastDate As Date
    Dim db2 As ADODB.Connection
    Dim rsSQL As ADODB.Recordset
    Dim i As Integer, N As Integer, ativo As String, C As Integer
    Dim Adtv As Double, AdtvCond As Double, AdtvClasse As Double, AdtvClasseCond As Double
    
    'Ao completar o Database do Enquadramento, sempre pega de D-5, para evitar o problema de LastDate)
    FProgress.Show
    
    FProgress.Label1 = "Exportando..."
    'Set db = DBEngine.Workspaces(0).OpenDatabase("C:\DebenturesCETIP\DebsCETIP.accdb")
    Set db = DBEngine.Workspaces(0).OpenDatabase("V:\DebsCETIP\DebsCETIP.accdb")
    Set db2 = New ADODB.Connection
    Call db2.Open("Provider=SQLNCLI11;Server=S14;Database=db_capitania_prd;Uid=sa;pwd=DS!2002nt; DataTypeCompatibility=80")
    'Call db2.Open("Provider=SQLNCLI11;Server=WIN10DEV;Database=db_capitania;Uid=sa;pwd=Capitania2019; DataTypeCompatibility=80")
    'Le todos os ativos CETIP da base de Títulos
        Set rsSQL = db2.Execute("SELECT CODCETIP FROM TPAPEL WHERE DELETED =0 AND (TIPO='TITPRIVADO' OR TIPO='DEBENTURE') AND CODCETIP<>''")
        N = 0
        While Not rsSQL.EOF
            NAtivo = NAtivo + 1
            ArrAtivo(NAtivo) = rsSQL("CODCETIP")
            rsSQL.MoveNext
        Wend
        
    '----------------------------------------------------------------------------------------------------ADTV
    Status = "RUN EXPORT ADTV NO RECORD"
    C = 0
    'Determina a última data da base de ADTV
        Set rsSQL = db2.Execute("SELECT MAX(DATA) AS LASTDATE FROM TADTV")
        If rsSQL.EOF Then LastDate = DateSerial(2018, 9, 1) Else LastDate = rsSQL("LastDate")
        If IsNull(LastDate) Then LastDate = DateSerial(2018, 10, 1)
        
        d = LastDate - 7
        Maxdate = d
        C = 0
        'd = DateSerial(2018, 10, 1)
        
    While d <= Now()
        DoEvents
        If Status = "RUN EXPORT ADTV NO RECORD" Then Status = "RUN EXPORT ADTV NO DATE"
        D2 = d - 90
        Set rs = db.OpenRecordset("SELECT ATIVO, EMISSOR, SUM(QUANT) AS QT, AVG(PUMED) AS PM, SUM(1) AS NUMD FROM TDEALS WHERE DATA>=#" + Format(D2, "MM/DD/YYYY") + "# AND DATA <=#" + Format(d, "MM/DD/YYYY") + "# AND QUANT*PUMED/NEGS<50000000 GROUP BY ATIVO, EMISSOR ORDER BY ATIVO")
        While Not rs.EOF
            ativo = rs("ATIVO")
            DoEvents
            While ExistAtivo(ativo) And Not rs.EOF
                DoEvents
                Adtv = rs("QT") / 62 * rs("PM")
                If rs("NUMD") = 0 _
                    Then AdtvCond = Adtv _
                    Else AdtvCond = rs("QT") * rs("PM") / rs("NUMD")
                Set rs2 = db.OpenRecordset("SELECT EMISSOR, SUM(QUANT) AS QT, AVG(PUMED) AS PM, SUM(1) AS NUMD FROM TDEALS WHERE DATA>=#" + Format(D2, "MM/DD/YYYY") + "# AND DATA <=#" + Format(d, "MM/DD/YYYY") + "# AND QUANT*PUMED/NEGS<50000000 AND EMISSOR='" + rs("EMISSOR") + "' GROUP BY EMISSOR")
                If rs2.EOF Then
                    AdtvClasse = Adtv
                    AdtvClasseCond = Adtv
                Else
                    AdtvClasse = rs2("QT") / 62 * rs2("PM")
                    If rs2("NUMD") = 0 _
                        Then AdtvClasseCond = Adtv _
                        Else AdtvClasseCond = rs2("QT") * rs2("PM") / rs2("NUMD")
                End If
                
                db2.Execute ("DELETE FROM TADTV WHERE NOME='" + rs("ATIVO") + "' AND DATA='" + Format(d, "yyyy-MM-dd") + "'")
                db2.Execute ("INSERT INTO TADTV (DATA, NOME, ADTV, ADTVCOND, ADTVCLASSE, ADTVCLASSECOND) VALUES ('" + Format(d, "yyyy-MM-dd") + "', '" + rs("ATIVO") + "'," + Str(Adtv) + "," + Str(AdtvCond) + "," + Str(AdtvClasse) + "," + Str(AdtvClasseCond) + ")")
                rs.MoveNext
                If d > Maxdate Then Maxdate = d
                C = C + 1
                Status = "RUN EXPORT ADTV NEW"
                If Not rs.EOF Then ativo = rs("ATIVO") Else ativo = ""
            Wend
            If Not rs.EOF Then ativo = rs("ATIVO") Else ativo = ""
            While Not ExistAtivo(ativo) And Not rs.EOF
                rs.MoveNext
                If Not rs.EOF Then ativo = rs("ATIVO") Else ativo = ""
            Wend
        Wend
        If Weekday(d) = 6 Then d = d + 3 Else d = d + 1
        FProgress.Label1 = "ADTV " + Format(d, "dd-mmm-yyyy")
        FProgress.Refresh
    Wend
    
    If C > 0 Then Status = Status + " " + Str(C) + " RECORDS"
    db.Execute ("INSERT INTO TLOG (DATA, STATUS, LASTDATE, LASTDATE2) VALUES (#" + _
    Format(Now(), "MM/DD/YYYY HH:MM") + "#,'" + Status + "',#" + Format(LastDate, "MM/DD/YYYY") + "#,#" + Format(Maxdate, "MM/DD/YYYY") + "#)")
            
    '------------------------------------------------------------------------------------------------PRICING
    Status = "RUN EXPORT PRICE NO RECORD"
    C = 0
    'Determina a última data do database de Pricing
        Set rsSQL = db2.Execute("SELECT MAX(DATAOBS) AS LASTDATE FROM TPRICING")
        If rsSQL.EOF Then LastDate = DateSerial(2018, 9, 1) Else LastDate = rsSQL("LastDate")
        If IsNull(LastDate) Then LastDate = DateSerial(2018, 9, 1)
        d = LastDate - 7
        Maxdate = d
        'd = DateSerial(2018, 10, 1)
                
        For i = 1 To NAtivo
            DoEvents
            Set rs = db.OpenRecordset("SELECT DATA, ATIVO, PUMED FROM TDEALS WHERE DATA>=#" + Format(d, "MM/DD/YYYY") + "# AND ATIVO='" + ArrAtivo(i) + "'")
            If Not rs.EOF Then
                db2.Execute ("DELETE FROM TPRICING WHERE ATIVO='" + ArrAtivo(i) + "' AND DATAOBS>='" + Format(d, "yyyy-MM-dd") + "'")
                While Not rs.EOF
                    DoEvents
                    db2.Execute ("INSERT INTO TPRICING (DATAOBS, ATIVO, PRECO) VALUES ('" + Format(rs("DATA"), "yyyy-MM-dd") + "','" + ArrAtivo(i) + "'," + Str(rs("PUMED")) + ")")
                    rs.MoveNext
                    Status = "RUN EXPORT PRICE NEW"
                    If Not rs.EOF Then
                        If rs("DATA") > Maxdate Then Maxdate = rs("DATA")
                    End If
                    C = C + 1
                Wend
            End If 'not eof
            FProgress.Label1 = "Pricing " + Format(i / NAtivo, "##0%")
            FProgress.Refresh
        Next i
            
    'Termina
        If C > 0 Then Status = Status + " " + Str(C) + " RECORDS"
        db.Execute ("INSERT INTO TLOG (DATA, STATUS, LASTDATE, LASTDATE2) VALUES (#" + _
        Format(Now(), "MM/DD/YYYY HH:MM") + "#,'" + Status + "',#" + Format(LastDate, "MM/DD/YYYY") + "#,#" + Format(Maxdate, "MM/DD/YYYY") + "#)")
    
        db.Close
        db2.Close
        FProgress.Hide
        Unload FProgress
End Sub

Public Function ParseDate(x As String) As Date
    'Parse no formado d/M/y
    Dim segs(4) As String, i As Integer, j As Integer
    i = 1
    j = 1
    While Asc(Mid(x, i, 1)) <> 19 And i < Len(x)
        If Mid(x, i, 1) = "/" Then j = j + 1 Else segs(j) = segs(j) + Mid(x, i, 1)
        i = i + 1
    Wend
    If i = Len(x) Then segs(j) = segs(j) + Mid(x, i, 1)
    ParseDate = DateSerial(Val(segs(3)), Val(segs(2)), Val(segs(1)))
End Function


Public Function ConvNumber(x As String) As String
    a = ""
    For i = 1 To Len(x)
        If Mid(x, i, 1) <> "." Then
            If Mid(x, i, 1) = "," Then a = a + "." Else a = a + Mid(x, i, 1)
        End If
    Next i
    If IsNumeric(a) Then ConvNumber = Str(Val(a)) Else ConvNumber = "-1"
End Function


Public Function Lastfilename() As String
    mask = "V:\DebsCETIP\Debentures.com.br_PrecosNegociacao_em_*.*"
    'mask = "C:\DebenturesCETIP\Debentures.com.br_PrecosNegociacao_em_*.*"
    a = FileSystem.Dir(mask)
    d = Mid(a, 39, 10)
    achamp = a
    dd = DateSerial(Val(Right(d, 4)), Val(Mid(d, 4, 2)), Val(Left(d, 2)))
    While a <> ""
        d1 = Mid(a, 39, 10)
        d1d = DateSerial(Val(Right(d1, 4)), Val(Mid(d1, 4, 2)), Val(Left(d1, 2)))
        If d1d > dd Then
            dd = d1d
            achamp = a
        End If
        a = FileSystem.Dir
    Wend
    Lastfilename = "V:\DebsCETIP\" + achamp
'    Lastfilename = "C:\DebenturesCETIP\" + achamp
    
End Function

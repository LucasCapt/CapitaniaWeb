VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CImporter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public LastDate

Private Excel As Object


Public Sub ImportaTudo(Level As Integer, EhBatch As Boolean, ehPreTrade As Boolean, Optional f As Form)
    Dim Lvl As Integer
    If ehPreTrade Then Lvl = 1 Else Lvl = Level
    ImportaPosicao Lvl, EhBatch, f
    ImportaResgates Lvl, f
    ImportRiskSeries Lvl, f
    ImportMaxCotistas Lvl, f
    ImportaTrades Level, f
    ImportaPricing Lvl, f
    importaADTV Lvl, f
End Sub

'-----------------------------------------------------------------------------------------------------------
'                               I M P O R T A Ç Ã O     D E     P R I C I N G
'-----------------------------------------------------------------------------------------------------------
Sub importaADTV(Level As Integer, Optional f As Form)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, LastDate As Date, d As Date, adtv As Double, adtvCond As Double
    
    If Level = 2 Or (Level = 1 And Not JahImportouNoDia("ADTV")) Then
        
        
        Set db = OpenTheDatabase(True)
        If Not f Is Nothing Then f.Say ("Importando ADTV")
        
        Set rs1 = New ADODB.Recordset
        Call rs1.open("SELECT MAX(DATA) AS LASTDATE FROM TADTV WHERE DATA<=" + SQLD(Now()), db, adOpenForwardOnly, adLockReadOnly)
        If Not IsNull(rs1("LASTDATE")) Then LastDate = rs1("LASTDATE") - 5
        If LastDate < DateSerial(2015, 10, 1) Then LastDate = DateSerial(2015, 10, 1)
        rs1.Close
        
        If LastDate < Now() Then
            CaptureExcel
            Set ws = OpenAndSetExcel(Excel, Config.FIIFileName, Config.FIIADTVTab)
            
            If Not ws Is Nothing Then
                j = 1
                While ws.cells(1, j) <> ""
                    DoEvents
                    If InStr(ws.cells(1, j), " ") > 1 _
                        Then Ativo = Left(ws.cells(1, j), InStr(ws.cells(1, j), " ") - 1) _
                        Else Ativo = ws.cells(1, j)
                    i = 4
                    d = DateSerial(2015, 1, 1)
                    While ws.cells(i, j) <> "" And i < 100
                        DoEvents
                        If ws.cells(i, j) > LastDate Then
                            d = ws.cells(i, j)
                            If IsNumeric(ws.cells(1, j + 1)) And ws.cells(i, j) <> "" Then
                                adtv = ws.cells(1, j + 1)
                                Call FStart.Say("Importando ADTV Ativo " & Ativo & " Data " & d)
                                If IsNumeric(ws.cells(1, j + 2)) Then adtvCond = ws.cells(1, j + 2) Else adtvCond = adtv
                                db.Execute ("DELETE FROM TADTV WHERE NOME ='" + Ativo + "' AND DATA=" + SQLD(d))
                                db.Execute ("INSERT INTO TADTV (DATA, NOME, ADTV, ADTVCOND, ADTVCLASSE, ADTVCLASSECOND) VALUES (" + SQLD(d) + ", '" + Ativo + "', " + Str(adtv) + "," + Str(adtvCond) + "," + Str(adtv) + "," + Str(adtvCond) + ")")
                            End If
                        End If
                        i = i + 1
                    Wend
                    j = j + 3
                Wend
                ws.Parent.Close
            End If 'ws is nothing
            
            If Not Excel Is Nothing Then ReleaseExcel
        End If
        
        FlagImportouNoDia "ADTV"
        WriteLog "IMPORTOU ADTV"
        
    End If 'importa?
End Sub


Sub ImportaPricing(Level As Integer, Optional f As Form)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, LastDate As Date, d As Date
    Dim Nome As String, L As String, fdo As String, pp As String, vl As String
    
    If Level = 2 Or (Level = 1 And Not JahImportouNoDia("PRICING")) Then
    
        Set db = OpenTheDatabase(True)
        
        If Not f Is Nothing Then f.Say ("Importando Pricing")
        
        'Identifica a última data que consta do database de pricing
        Set rs1 = New ADODB.Recordset
        Call rs1.open("SELECT MAX(DATAOBS) AS LASTDATE FROM TPRICING WHERE DATAOBS<=" + SQLD(Now()), db, adOpenForwardOnly, adLockReadOnly)
        If Not IsNull(rs1("LASTDATE")) Then LastDate = rs1("LASTDATE") - 5
        If LastDate < DateSerial(2015, 10, 1) Then LastDate = DateSerial(2015, 10, 1)
        rs1.Close
        
        If LastDate < Now() Then
        
            CaptureExcel
            Set ws = OpenAndSetExcel(Excel, Config.FIIFileName, Config.FIIFileTab)
                
            d = LastDate + 1
            While d <= Now() 'Importa para cada data após o 5o dia anterior ao último registrado
            
                If Not f Is Nothing Then f.Say ("Checando pricing " + Format(d, "dd-MMM-yy"))
                Nome = Config.PricingFilePrefix + Format(Year(d), "0000") + Format(Month(d), "00") + Format(Day(d), "00") + ".txt"
                
                If FileExists(Nome) Then
                    '---------Importa da Planilha
                    If Not f Is Nothing Then f.Say ("Importando pricing " + Format(d, "dd-MMM-yy"))
                    Open Nome For Input As 1
                    
                    If Not EOF(1) Then Line Input #1, L
                    
                    While Not EOF(1)
                        DoEvents
                        Line Input #1, L
                        
                        'Procura a 3a vírgula e separa o ativo
                        i = 1
                        cvirg = 0
                        While i < Len(L) And cvirg < 3
                            DoEvents
                            If Mid(L, i, 1) = ";" Then cvirg = cvirg + 1
                            i = i + 1
                        Wend
                        If cvirg = 3 Then
                            Ativo = ""
                            While i < Len(L) And Mid(L, i, 1) <> ";"
                                Ativo = Ativo + Mid(L, i, 1)
                                i = i + 1
                            Wend
                        End If
                        
                        'Procura a 2a virgula de tras p/ frente e separa o preço
                        i = Len(L)
                        While i > 1 And Mid(L, i, 1) <> ";": i = i - 1: Wend
                        i = i - 1
                        j = i
                        While i > 1 And Mid(L, i, 1) <> ";": i = i - 1: Wend
                        preco = Mid(L, i + 1, j - i)
                        
                        If Not f Is Nothing Then f.Say ("Importando pricing " + Format(d, "dd-MMM-yy") + " Ativo: " & Ativo)
                        'Grava
                        db.Execute ("DELETE FROM TPRICING WHERE DATAOBS=" + SQLD(d) + " AND ATIVO='" + Ativo + "'")
                        db.Execute ("INSERT INTO TPRICING (DATAOBS, ATIVO, PRECO) VALUES (" + SQLD(d) + ", '" + Ativo + "', " + preco + ")")
                        
                    Wend
                    Close 1
                End If 'FileExists
                    
                    
                If Not ws Is Nothing Then
                    '-------- Importa FII/ debentures (uma vez que importa, trava a importação do anterior)
                    j = 1
                    While ws.cells(1, j) <> ""
                        DoEvents
                        If InStr(ws.cells(1, j), " ") > 1 _
                            Then Ativo = Left(ws.cells(1, j), InStr(ws.cells(1, j), " ") - 1) _
                            Else Ativo = ws.cells(1, j)
                        i = 4
                        While ws.cells(i, j) <> "" And ws.cells(i, j) <> d
                            i = i + 1
                        Wend
                        If ws.cells(i, j) = d Then
                            db.Execute ("DELETE FROM TPRICING WHERE DATAOBS=" + SQLD(d) + " AND ATIVO='" + Ativo + "'")
                            db.Execute ("INSERT INTO TPRICING (DATAOBS, ATIVO, PRECO) VALUES (" + SQLD(d) + ", '" + Ativo + "', " + Str(ws.cells(i, j + 1)) + ")")
                        End If
                        j = j + 3
                    Wend
                Else
                    WriteLogError "Arquivo/Tab de preços inexistente", Config.FIIFileName + "/" + Config.FIIFileTab
                End If 'ws is nothing
                    
                d = d + 1
            Wend 'while d<Now()
        
            If Not ws Is Nothing Then ws.Parent.Close
            If Not Excel Is Nothing Then ReleaseExcel
        End If 'Lastdate<Now()
        
        FlagImportouNoDia "PRICING"
        WriteLog "IMPORTOU PRICING"
        
    End If 'importa?
End Sub


'-----------------------------------------------------------------------------------------------------------
'                               I M P O R T A Ç Ã O     D E     P O S I Ç Õ E S
'-----------------------------------------------------------------------------------------------------------

Sub ImportaPosicao(Level As Integer, ForceLast As Boolean, Optional f As Form)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, x As CPosic, LastDate As Date, d As Date
    Dim Nome As String, L As String, Ativo As String, preco As String, cvirg As Integer, i As Integer
    
    If Level = 2 Or (Level = 1 And Not JahImportouNoDia("POSICAO")) Then
    
        Set db = OpenTheDatabase(True)
        
        If Not f Is Nothing Then f.Say ("Importando Posições")
        
        'Identifica a última data que consta do database de posicao
        Set rs1 = New ADODB.Recordset
        Call rs1.open("SELECT MAX(DATA) AS LASTDATE FROM TPOSIC WHERE DATA<=" + SQLD(Now()), db, adOpenForwardOnly, adLockReadOnly)
        If Not IsNull(rs1("LASTDATE")) Then LastDate = rs1("LASTDATE")
        If LastDate < DateSerial(2015, 1, 1) Then LastDate = DateSerial(2015, 1, 1)
        rs1.Close
        
        If LastDate < Now() Then
        
                'Lê todos os arquivos-texto entre a LastDate e Hoje
                If ForceLast Then d = LastDate Else d = LastDate + 1
                While d <= Now()
                    If Not f Is Nothing Then f.Say ("Checando posição " + Format(d, "dd-MMM-yy"))
                    Nome = Config.PosicFilePrefix + Format(Month(d), "00") + "." + Format(Day(d), "00") + "." + Format(Year(d), "0000") + ".txt"
                    If FileExists(Nome) Then
                        If Not f Is Nothing Then f.Say ("Importando posição TXT " + Format(d, "dd-MMM-yy"))
                        ImportaPosicaoParaData d, False
                    End If
                    If Not f Is Nothing Then f.Say ("Importando posição XML " + Format(d, "dd-MMM-yy"))
                    ImportaXMLANBIMAparaData d, False
                    Layt22MainParaData d
                    d = d + 1
                Wend
        
        End If
        
        FlagImportouNoDia "POSICAO"
        WriteLog "IMPORTOU POSICAO"
        
    End If 'Importa?
End Sub



Sub ImportaPosicaoParaData(d As Date, Optional Notify As Boolean = False)
    'Esta rotina importa apenas carteiras .txt
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, x As CPosic, LastDate As Date, Nome As String
    
    Set db = OpenTheDatabase(True)
    Nome = Config.PosicFilePrefix + Format(Month(d), "00") + "." + Format(Day(d), "00") + "." + Format(Year(d), "0000") + ".txt"
    If FileExists(Nome) Then
        Open Nome For Input As 1
        'Limpa a base para a data d
        db.Execute ("DELETE FROM TPOSIC WHERE DATA=#" + Format(d, "MM/DD/YYYY") + "#")
        Line Input #1, L 'Pula primeira linha)
        While Not EOF(1)
            Line Input #1, L
                        
            t1 = InStr(L, Chr(9))
            t2 = InStr(t1 + 1, L, Chr(9))
            If t1 > 0 And t2 > 0 Then
                fdo = Left(L, t1 - 1)
                pp = Mid(L, t1 + 1, t2 - t1 - 1)
                vl = Right(L, Len(L) - t2)
                                        
                db.Execute ("INSERT INTO TPOSIC (FUNDO, PAPEL, VALOR, DATA, TIPO) VALUES (" + fdo + " ,'" + pp + "' ," + vl + ", " + SQLD(d) + ",1)")
            End If
        Wend
        Close 1
    Else
        If Notify Then MsgBox ("Arquivo para importação da data " + Format(d, "dd-MMM-yy") + " não encontrado.")
    End If
    
End Sub



'-----------------------------------------------------------------------------------------------------------
'                               I M P O R T A     R E S G A T E S
'-----------------------------------------------------------------------------------------------------------
Sub ImportaResgates(Level As Integer, Optional f As Form)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, d As Date, fd As String, vs As String, v As Double
    Dim w As Object, wb As Object, MaxLines As Integer, spg As String, tp As Boolean
    Dim LastDate As Date, CutDate As Date, S_Cancel As String
    
    If Level = 2 Or (Level = 1 And Not JahImportouNoDia("RESGATES")) Then
    
        MaxLines = 30000
        
        If Not f Is Nothing Then f.Say ("Importando Resgates")
        
        
        Set db = OpenTheDatabase(True)
          
        'Identifica a última data que consta do database de resgates
        Set rs1 = New ADODB.Recordset
        Call rs1.open("SELECT MAX(DATAOBS) AS LASTDATE FROM TRESGATES WHERE DATAOBS<=" + SQLD(Now()), db, adOpenForwardOnly, adLockReadOnly)
        If Not IsNull(rs1("LASTDATE")) Then LastDate = rs1("LASTDATE")
        If LastDate < DateSerial(2012, 1, 1) Then LastDate = DateSerial(2012, 1, 1)
        rs1.Close
        
        If LastDate < Now() Then
        
                'Lê a planilha desde a data LastDate
                'Inicializa Excel e a Planilha
                    CaptureExcel
                    Set w = OpenAndSetExcel(Excel, Config.RedemptionFilePath + Config.RedemptionFileName, Config.RedemptionFileTab)
                    Set wt = OpenAndSetExcel(Excel, Config.RedemptionFilePath + Config.RedemptionFileName, Config.RedemptionFileTransferTab)
                    
                
                '------------------------------------------------< IMPORTA OS RESGATES>
                If Not w Is Nothing Then
                
                    CutDate = LastDate - 365
                
                    'Vai reimportar os últimos 365 dias de resgates agendados, para cobrir os cancelados
                    'Elimina todos os resgates agendados depois de CutDate
                    
                    db.Execute ("DELETE FROM TRESGATES WHERE DATAOBS >= " + SQLD(CutDate))
                    
                    'localiza aproximadamente o início da série (Cutdate)
                    i = 16384
                    
                    While w.cells(i, 1) = "" Or w.cells(i, 1) > CutDate And i > 4
                        i = i / 2
                    Wend
                    
                    If i = 4 Then i = 3
                    While w.cells(i, 1) <> "" And i < MaxLines And w.cells(i, 1) < CutDate
                        i = i + 1
                    Wend
                    
                    
                    While w.cells(i, 1) <> "" And i < MaxLines And w.cells(i, 1) <= Now()
                        DoEvents
                        d = w.cells(i, 1)
                        fd = w.cells(i, 2)
                        vs = w.cells(i, 5)
                        tp = (w.cells(i, 7) = "T")
                        
                        If Not IsDate(w.cells(i, 10)) Then d1 = LongTimeAgo Else d1 = w.cells(i, 10)
                        If w.cells(i, 9) <> "" Then S_Cancel = "1" Else S_Cancel = "0"
                        
                        If Left(vs, 2) = "R$" Then v = Val(Trim(Mid(vs, 3))) Else v = Val(vs)
                        If w.cells(i, 6) = "" Then spg = Format(d, "YYYY-MM-DD") Else spg = Format(CDate(w.cells(i, 6)), "YYYY-MM-DD")
                        If tp Then uu = "1" Else uu = "0"
                        
                        order = "INSERT INTO TRESGATES (DATAOBS, FUNDO, DATALIQ, VALOR, DATACANCEL, CANCELADO, TOTAL) VALUES " + _
                        "(" + SQLD(d) + _
                        ",'" + fd + "'" + _
                        "," + SQLD(CDate(spg)) + "" + _
                        "," + Str(v) + _
                        "," + SQLD(CDate(d1)) + _
                        "," + S_Cancel + _
                        "," + uu + ")"
                        
                        db.Execute (order)
                        If Not f Is Nothing Then f.Say ("Importando resgates " + Format(d, "dd-MMM-yy"))
                        
                        i = i + 1
                    Wend
                    
                End If 'w is nothing
                
                '------------------------------------------------< IMPORTA AS TRANSFERÊNCIAS>
                
                If Not wt Is Nothing Then
                
                    CutDate = LastDate - 365
                
                    'Vai reimportar os últimos 365 dias de resgates agendados, para cobrir os cancelados
                    'Elimina todos os resgates agendados depois de CutDate
                    
                    db.Execute ("DELETE FROM TTRANSFERS WHERE DATAOBS >= " + SQLD(CutDate))
                    
                    'localiza aproximadamente o início da série (Cutdate)
                    i = 2048
                    While wt.cells(i, 1) = "" Or wt.cells(i, 1) > CutDate And i > 4
                        i = i / 2
                    Wend
                    If i = 4 Then i = 3
                    While wt.cells(i, 1) <> "" And i < MaxLines And wt.cells(i, 1) < CutDate
                        i = i + 1
                    Wend
                    
                    While wt.cells(i, 1) <> "" And i < MaxLines And wt.cells(i, 1) <= Now()
                        DoEvents
                        
                        d = wt.cells(i, 1)
                        fd = wt.cells(i, 4) 'Fundo que recebe a transferência
                        vs = wt.cells(i, 5)
                        If Not IsDate(wt.cells(i, 10)) Then d1 = LongTimeAgo Else d1 = wt.cells(i, 10)
                        If wt.cells(i, 9) = "X" Then S_Cancel = "1" Else S_Cancel = "0"
                        
                        If Left(vs, 2) = "R$" Then v = Val(Trim(Mid(vs, 3))) Else v = Val(vs)
                        If wt.cells(i, 6) = "" Then spg = SQLD(d) Else spg = SQLD(CDate(wt.cells(i, 6)))
                        
                        order = "INSERT INTO TTRANSFERS (DATAOBS, FUNDO, DATALIQ, VALOR, DATACANCEL, CANCELADO) VALUES " + _
                        "(" + SQLD(d) + _
                        ",'" + fd + "'" + _
                        "," + spg + _
                        "," + Str(v) + _
                        "," + SQLD(CDate(d1)) + _
                        "," + S_Cancel + ")"
                        
                        db.Execute (order)
                        If Not f Is Nothing Then f.Say ("Importando transferências " + Format(d, "dd-MMM-yy"))
                        
                        i = i + 1
                    Wend
                    
                End If 'wT is nothing
        
        End If
        
        If Not w Is Nothing Then w.Parent.Close
        If Not Excel Is Nothing Then ReleaseExcel
        
        
        FlagImportouNoDia "RESGATES"
        WriteLog "IMPORTOU RESGATES"
        
    End If 'Importa?
End Sub


'-----------------------------------------------------------------------------------------------------------
'                               I M P O R T A     M A I O R E S    C O T I S T A S
'-----------------------------------------------------------------------------------------------------------
Public Sub ImportMaxCotistas(Level As Integer, Optional f As Form)
    Dim d As Date, cot(4) As Double
    
    If Level = 2 Or (Level = 1 And Not JahImportouNoDia("MAXCOTISTAS")) Then
    
        If Not f Is Nothing Then f.Say ("Importando maiores cotistas")
        
        Set db = OpenTheDatabase(True)
        
        'Inicializa Excel e a Planilha
            CaptureExcel
            Set wb = OpenAndSetExcel(Excel, Config.ShareFilePath + Config.ShareFileName, "\WORKBOOK")
            
        'Importa
            If Not wb Is Nothing Then
                Set w = wb.worksheets("DATA")
                d = w.cells(1, 1)
                db.Execute ("DELETE FROM TMAIORCOTISTA WHERE DATAOBS=" + SQLD(d))
                
                For Each w In wb.worksheets
                    DoEvents
                    If w.Name <> "DATA" Then
                        nom = w.Name
                        If w.cells(1, 3) = "VALOR BRUTO" Then
                            Col = 3
                        ElseIf w.cells(1, 4) = "VALOR BRUTO" Or Not IsNumeric(w.cells(2, 3)) Then
                            Col = 4
                        Else
                            Col = 3
                        End If
                        i = 2: j = 1: cot(1) = 0: cot(2) = 0: cot(3) = 0
                        While w.cells(i, 1) <> "" And i < 100 And j < 4
                            DoEvents
                            If w.cells(i, Col + 1) = "" Then
                                If IsNumeric(w.cells(i, Col)) Then cot(j) = w.cells(i, Col) Else cot(j) = 0
                                j = j + 1
                            End If
                            i = i + 1
                        Wend
                        db.Execute ("INSERT INTO TMAIORCOTISTA (DATAOBS, FUNDO, MAXCOT1, MAXCOT2, MAXCOT3) VALUES (" + _
                             SQLD(d) + "," + _
                            "'" + nom + "'," + _
                            Str(cot(1)) + "," + Str(cot(2)) + "," + Str(cot(3)) + ")")
                    End If
                Next w
            End If
            
        If Not wb Is Nothing Then wb.Close
        If Not Excel Is Nothing Then ReleaseExcel
        
        FlagImportouNoDia "MAXCOTISTAS"
        WriteLog "IMPORTOU MAXCOTISTAS"
        
    End If 'Importa?
End Sub


'-----------------------------------------------------------------------------------------------------------
'                               I M P O R T A     T R A D E S
'-----------------------------------------------------------------------------------------------------------
Public Sub ImportaTrades(Level As Integer, Optional f As Form, Optional SinceDate As Date = 0)
    Dim d As Date
    Dim d1 As Date, f1 As String, a1 As String, CV As String, q1 As Double, t1 As Double, p1 As Double, b1 As String, pr1 As Double, ps1 As String, PR As String, vf As Double
    Dim L As String, FileName As String, c As Integer, fundoid As Integer, NegFilePath As String
    Dim hi As Integer, lo As Integer, meio As Integer, celmeio As Variant
    Dim rs As ADODB.Recordset
    
    If Level = 2 Or Level = 3 Or (Level = 1 And Not JahImportouNoDia("TRADES")) Or ehPreTrade Then
    
        If Not f Is Nothing Then f.Say ("Importando trades")
        
        
        Set db = OpenTheDatabase(True)
        
        If SinceDate <> 0 Then
            d = SinceDate
        Else
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT MAX(DATA) AS MAXDATE FROM TTRADES", db, adOpenForwardOnly, adLockReadOnly)
            If rs.EOF Then
                d = Now() - 30
            ElseIf IsNull(rs("MAXDATE")) Then
                d = Now() - 30
            ElseIf rs("MAXDATE") > Now() Then
                d = Now() - 1
            Else
                d = rs("MAXDATE")
            End If
        End If
        
        db.Execute ("DELETE FROM TTRADES WHERE DATA>=" + SQLD(d))
        
        If Not f Is Nothing Then f.Say ("Importando trades desde " + Format(d, "dd-MMM-yy"))
        
        'Importa CRM (database)
            'Database do CRM
            Set db1 = DBEngine.Workspaces(0).OpenDatabase(Config.CRMDataBase)
            Set rs1 = db1.OpenRecordset("SELECT * FROM DEALS WHERE TIMESTAMP>=" + SQLD(d))
            While Not rs1.EOF
            
                If rs1("Timestamp") <= Now() Then
                
                    d1 = rs1("Timestamp")
                    f1 = rs1("Book")
                    a1 = rs1("Instrument")
                    If rs1("BuySell") = "Buy" Then CV = "C" Else CV = "V"
                    q1 = rs1("Amount")
                    t1 = rs1("Price")
                    If Left(Ativo, 3) = "LFT" And rs1("Unitvalue") < 100 Then p1 = rs1("Unitvalue") * 1000 Else p1 = rs1("Unitvalue")
                    b1 = rs1("Corretora")
                    PR = rs1("Strategy")
                    NA = a1
                    vf = CritNN(rs1("Value"))
                    
                    db.Execute ("INSERT INTO TTRADES (DATA, HORA, HORA_MS, FUNDO, ATIVO, CV, QUANT, TAXA, PU, PRICEREF, PRICESRC, BROKER, PRODUTO, NOMEATIVO, VALFIN) VALUES ( " + _
                    SQLD(d1) + ", #" + Format(Now(), "hh:mm:ss") + "#," + Str(Timer()) + ",'" + f1 + "','" + a1 + "','" + CV + "'," + Str(q1) + "," + Str(t1) + "," + Str(p1) + ",0,'','" + b1 + "','" + PR + "','" + NA + "'," + Str(vf) + ")")
                
                End If
                rs1.MoveNext
            Wend
            db1.Close
        
        'Importa Trdes de RFE (arquivo .xls)
            If FileSystem.Dir(Config.RFETradeSheet) <> "" Then
                CaptureExcel
                Set ws = OpenAndSetExcel(Excel, Config.RFETradeSheet, Config.RFETradeTab)
                
                If Not ws Is Nothing Then
                    'Procura a data d
                    hi = 16000: lo = 10: meio = (hi + lo) \ 2: celmeio = 0
                    While hi > lo And celmeio <> d
                        meio = (hi + lo) \ 2
                        celmeio = ws.cells(meio, 1)
                        If celmeio > d Or celmeio = "" Then hi = meio - 1 Else lo = meio + 1
                    Wend
                    i = meio
                    'Procura início de d ou da próxima data
                    While ws.cells(i, 1) >= d And i > 5
                        i = i - 1
                    Wend
                    While ws.cells(i, 1) < d And ws.cells(i, 1) <> ""
                        i = i + 1
                    Wend
                    
                    While ws.cells(i, 1) <> ""
                        d1 = ws.cells(i, 1)
                        f1 = ws.cells(i, 2)
                        a1 = ws.cells(i, 10)
                        CV = ws.cells(i, 4)
                        q1 = ws.cells(i, 5)
                        t1 = 0
                        p1 = ws.cells(i, 6)
                        b1 = ws.cells(i, 3)
                        PR = ws.cells(i, 23)
                        NA = CritString(ws.cells(i, 24))
                        vf = ws.cells(i, 7)
                                                
                        db.Execute ("INSERT INTO TTRADES (DATA, HORA, HORA_MS, FUNDO, ATIVO, CV, QUANT, TAXA, PU, PRICEREF, PRICESRC, BROKER, PRODUTO, NOMEATIVO, VALFIN) VALUES ( " + _
                        SQLD(d1) + ", #" + Format(Now(), "hh:mm:ss") + "#," + Str(Timer()) + ",'" + f1 + "','" + a1 + "','" + CV + "'," + Str(q1) + "," + Str(t1) + "," + Str(p1) + ",0,'','" + b1 + "','" + PR + "','" + NA + "'," + Str(vf) + ")")
                        
                        i = i + 1
                    Wend
                    If Not ws Is Nothing Then ws.Parent.Close
                    If Not Excel Is Nothing Then ReleaseExcel
                End If 'not ws is nothing
            End If
            
        'Importa NEGS (arquivo .txt)
            d1 = d
            While d1 <= Now()
                If Not f Is Nothing Then f.Say Format(d1, "dd-MMM-yy") + " neg"
                ehpraincluir = False
                NegFilePath = ""
                For i = Len(Config.NEGSFilePrefix) To 1 Step -1
                    If Mid(Config.NEGSFilePrefix, i, 1) = "\" Then ehpraincluir = True
                    If ehpraincluir Then NegFilePath = Mid(Config.NEGSFilePrefix, i, 1) + NegFilePath
                Next i
                FileName = Config.NEGSFilePrefix + "*" + Format(Day(d1), "00") + "_" + Format(Month(d1), "00") + "_" + Format(Year(d1), "00") + ".txt"
                filename1 = FileSystem.Dir(FileName)
                While filename1 <> ""
                    Open NegFilePath + filename1 For Input As 1
                    While Not EOF(1)
                        Line Input #1, L
                        i = 1
                        c = 0: i1 = 0
                        f1 = "": CV = "": a1 = "": b1 = "": q1 = 0: p1 = 0
                        While c < 13 And i < Len(L)
                            If Mid(L, i, 1) = "#" Then
                                c = c + 1
                                Select Case c
                                    Case 3
                                        f1 = Mid(L, i1 + 1, i - i1 - 1)
                                    Case 4
                                        CV = Mid(L, i1 + 1, 1)
                                    Case 7
                                        a1 = Mid(L, i1 + 1, i - i1 - 1)
                                    Case 9
                                        b1 = Mid(L, i1 + 1, i - i1 - 1)
                                    Case 11
                                        q1 = Val(Mid(L, i1 + 1, i - i1 - 1))
                                    Case 12
                                        p1 = Val(Mid(L, i1 + 1, i - i1 - 1))
                                End Select
                                i1 = i
                            End If
                            i = i + 1
                        Wend
                        If f1 <> "" And a1 <> "" And p1 <> 0 Then
                            db.Execute ("INSERT INTO TTRADES (DATA, HORA, HORA_MS, FUNDO, ATIVO, CV, QUANT, TAXA, PU, PRICEREF, PRICESRC, BROKER, PRODUTO) VALUES (" + _
                            SQLD(d1) + ", #" + Format(Now(), "hh:mm:ss") + "#," + Str(Timer()) + ",'" + f1 + "','" + a1 + "','" + CV + "'," + Str(q1) + "," + Str(p1) + "," + Str(p1) + ",0,'','" + b1 + "','RV')")
                        End If
                    Wend
                    Close #1
                    filename1 = FileSystem.Dir()
                Wend
                d1 = d1 + 1
            Wend 'd1<=now()
            
        Fundos.ResetPreTradeCompl
        FlagImportouNoDia "TRADES"
        WriteLog "IMPORTOU TRADES"
        
    End If 'Importa?
End Sub


'-----------------------------------------------------------------------------------------------------------
'                               I M P O R T A     S E R I E S    D E     M E R C A D O
'-----------------------------------------------------------------------------------------------------------

Public Sub ImportRiskSeries(Level As Integer, Optional f As Form)
    'Lê a planilha, coloca no Database, e lê para a memória
    Dim w As Object, wb As Object, w1 As Object, a As String, db As ADODB.Connection, rs As ADODB.Recordset, d1 As Date
    
    If Level = 2 Or (Level = 1 And Not JahImportouNoDia("SERIES")) Then
    
        
        Set db = OpenTheDatabase(True)
    
        'Inicializa Excel e a Planilha
        CaptureExcel
            
        '--------------Importa as séries de mercado
            If Not f Is Nothing Then f.Say ("Importando séries de mercado")
            Set w = OpenAndSetExcel(Excel, Config.HistFilePath + Config.HistFileName, Config.HistFileTab)
            If Not w Is Nothing Then
                'Percorre cada série
                ImportaSerie "IFIX", Config.HistfileIFIX, w, db
                ImportaSerie "IPCA2Y", Config.HistFileIPCA2Y, w, db
                ImportaSerie "IPCA5Y", Config.HistFileIPCA5Y, w, db
                ImportaSerie "IPCA10Y", Config.HistFileIPCA10Y, w, db
                ImportaSerie "IMAB5", Config.HistFileIMAB5, w, db
                ImportaSerie "PRE2Y", Config.HistFilePre2Y, w, db
                ImportaSerie "PRE5Y", Config.HistFilePre5Y, w, db
                ImportaSerie "DOLAR", Config.HistFileDolar, w, db
                ImportaSerie "IDA", Config.HistFileIDA, w, db
            End If
        
        '--------------Importa os Ratings
            If Not f Is Nothing Then f.Say ("Importando os ratings")
            Set w = OpenAndSetExcel(Excel, Config.HistFilePath + Config.HistFileName, Config.HistFileRatingsTab)
            If Not w Is Nothing Then
                i = 1
                While w.cells(1, i) <> "" And i < 256
                    DoEvents
                    a = w.cells(1, i)
                    If Not f Is Nothing Then f.Say ("Importando os ratings " & w.cells(1, i))
                    If InStr(a, " ") > 0 Then a = Left(a, InStr(a, " ") - 1)
                    If IsDate(w.cells(4, i)) Then
                        d1 = w.cells(4, i)
                        db.Execute ("DELETE FROM TRATINGS WHERE ID='" + a + "' AND DATA>=" + SQLD(d1))
                        j = 4
                        While IsDate(w.cells(j, i))
                            DoEvents
                            db.Execute ("INSERT INTO TRATINGS (DATA, ID, RATING) VALUES (" + SQLD(w.cells(j, i)) + ",'" + a + "','" + w.cells(j, i + 1) + "')")
                            j = j + 1
                        Wend
                    End If
                    i = i + 2
                Wend
            End If
            
        '--------------Importa as Quotas
            If Not f Is Nothing Then f.Say ("Importando as quotas")
            Set w = OpenAndSetExcel(Excel, Config.HistFilePath + Config.HistFileName, Config.HistFileQuotaTab)
            If Not w Is Nothing Then
                i = 1
                While w.cells(1, i) <> "" And i < 256
                    DoEvents
                    If IsNumeric(w.cells(1, i)) Then
                        fundoid = w.cells(1, i) 'numero do fundo
                        If Not f Is Nothing Then f.Say ("Importando as quotas - fundo " + Str(fundoid))
                        If IsDate(w.cells(6, i)) Then
                            d1 = w.cells(6, i)
                            db.Execute ("DELETE FROM TQUOTAS WHERE FUNDO=" + Str(fundoid) + " AND DATA>=" + SQLD(d1))
                            j = 6
                            While IsDate(w.cells(j, i))
                                db.Execute ("INSERT INTO TQUOTAS (DATA, FUNDO, QUOTA) VALUES (" + SQLD(w.cells(j, i)) + "," + Str(fundoid) + "," + Str(w.cells(j, i + 1)) + ")")
                                j = j + 1
                            Wend
                        End If 'Is date
                    End If 'Is numeric FundID
                    i = i + 3
                Wend
            
        
            End If
        
        If Not w Is Nothing Then w.Parent.Close
        If Not Excel Is Nothing Then ReleaseExcel
        
        FlagImportouNoDia "SERIES"
        WriteLog "IMPORTOU SERIES"
    
    End If 'Importa?
End Sub




Private Sub ImportaSerie(DBName As String, WSName As String, w As Object, db As ADODB.Connection)
    Dim rs As ADODB.Recordset, d As Date, Incompleta As Boolean, UltData As Date
    
    
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT MAX(DATA) AS LASTDATE FROM TFACTORHIST WHERE FACTORID='" + DBName + "' AND DATA<=" + SQLBaseDate + " AND DATA >=" + SQLD(Now() - 720), db, adOpenForwardOnly, adLockReadOnly)
    UltData = Now() - 3650
    If rs.EOF Then
        Incompleta = True
    ElseIf IsNull(rs("LASTDATE")) Then
        Incompleta = True
    Else
        UltData = rs("LASTDATE")
        Incompleta = UltData < sub1util(Now())
    End If
    
    If Incompleta And Not w Is Nothing Then
        'Busca na planilha e preenche database
        j = SearchColumn(WSName, w)
        If j <> 0 Then
            i = 4
            While w.cells(i, j) <> "" And i < 2000
                If w.cells(i, j) > UltData Then _
                    db.Execute ("INSERT INTO TFACTORHIST (FACTORID, DATA, VALOR) VALUES ('" + DBName + "', " + SQLD(w.cells(i, j)) + ", " + Str(w.cells(i, j + 1)) + ")")
                i = i + 1
            Wend
        End If
    End If
End Sub

Private Function sub1util(d As Date) As Date
    If Weekday(d) = 2 Then sub1util = d - 3 Else sub1util = d - 1
End Function

Private Function SearchColumn(x As String, w As Object) As Integer
    Dim i As Integer
    i = 1
    While w.cells(1, i) <> x And i < 100
        i = i + 2
    Wend
    If w.cells(1, i) = x Then SearchColumn = i Else SearchColumn = 0
End Function

'-----------------------------------------------------------------------------------------------------------
'                               C A P T U R A    E X C E L
'-----------------------------------------------------------------------------------------------------------

Private Sub CaptureExcel()
    On Error GoTo ErrHnd
    Set Excel = GetObject(, "Excel.Application")
    ExcelWarns = Excel.displayalerts
    Excel.displayalerts = False
    GoTo Fim
ErrHnd:
    On Error GoTo ErrHnd2
    Set Excel = CreateObject("Excel.Application")
    ExcelWarns = Excel.displayalerts
    Excel.displayalerts = False
    GoTo Fim
ErrHnd2:
    Set Excel = Nothing
Fim:
End Sub

Private Sub ReleaseExcel()
    If Not Excel Is Nothing Then Excel.displayalerts = ExcelWarns
End Sub



'-----------------------------------------------------------------------------------------------------------
'                               C R I T I C A    D E     P O S I C A O
'-----------------------------------------------------------------------------------------------------------
Public Sub CriticaPosicaoParaData(d As Date)
    'Procura por unknowns e não identificados e compara com data anterior
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, d1 As Date, achou As Boolean, achou2 As Boolean
    Dim alterou As Boolean, lf As String
    
    alterou = False
    lf = Chr(10)
    
    Set db = OpenTheDatabase(True)
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM TPOSIC WHERE DATA=" + SQLD(d) + " AND PAPEL='00000000000000'", db, adOpenForwardOnly, adLockReadOnly)
    While Not rs.EOF
        d1 = d - 1
        achou = False
        While Not achou And d1 > d - 7
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT * FROM TPOSIC WHERE DATA=" + SQLD(d1) + " AND FUNDO=" + Str(rs("FUNDO")), db, adOpenForwardOnly, adLockReadOnly)
            achou = Not rs1.EOF
            If Not achou Then d1 = d1 - 1
        Wend
        If achou Then
            l1 = rs("VALOR") * 0.9
            L2 = rs("VALOR") * 1.1
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT * FROM TPOSIC WHERE DATA=" + SQLD(d1) + " AND FUNDO=" + Str(rs("FUNDO")) + " AND VALOR>=" + Str(l1) + " AND VALOR<=" + Str(L2), db, adOpenForwardOnly, adLockReadOnly)
            achou2 = False
            While Not rs1.EOF And Not achou2
                If MsgBox("O papel dessa posição: " + lf + _
                            "Fundo: " + Str(rs("FUNDO")) + lf + _
                            "Data : " + Format(rs("DATA"), "dd-MMM-yyyy") + lf + _
                            "Papel: " + rs("PAPEL") + lf + _
                            "Valor: " + Format(rs("VALOR"), "###,###,##0.0000") + lf + lf + _
                            "é o mesmo dessa posição?" + lf + _
                            "Fundo: " + Str(rs1("FUNDO")) + lf + _
                            "Data : " + Format(rs1("DATA"), "dd-MMM-yyyy") + lf + _
                            "Papel: " + rs1("PAPEL") + lf + _
                            "Valor: " + Format(rs1("VALOR"), "###,###,##0.0000") + lf + lf, vbYesNo) = vbYes Then
                            
                        alterou = True
                        achou2 = True
                        rs("PAPEL") = rs1("PAPEL")
                        rs.Update
                End If
                rs1.MoveNext
            Wend
        End If
        rs.MoveNext
    Wend
    rs.Close
    
    If alterou Then
        FStart.Show vbModeless
        MMain.ResetAll FStart
        FStart.Hide
        FMain.Refaz
    End If
    MsgBox ("Crítica terminada.")
End Sub


'-----------------------------------------------------------------------------------------------------------
'                               I M P O R T A Ç Ã O     D E     X M L A N B I M A
'-----------------------------------------------------------------------------------------------------------
Public Sub ImportaXMLANBIMAparaData(d As Date, Optional Notify As Boolean = False)
    Dim c As Collection, y As CNomeValor
    
    Set c = GetFolders(Config.XMLANBIMAPath)
    
    For Each y In c
        ImportaXMLANBIMADePastaParaData y.Nome, d, Notify
        DoEvents
    Next y
    
End Sub


Public Sub ImportaXMLANBIMADePastaParaData(pasta As String, d As Date, Optional Notify As Boolean = False)
    'Importa arquivo XML para tabela TPOSICLAYOUT2
    'Data d é a data do arquivo, não necessariamente da posição

    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, x As CPosic, LastDate As Date
    Dim fundoid As Integer, plind As Double, Nome As String, CNPJ As String, dtposic As Date, dtposicSt As String
    Dim XML As New DOMDocument, noh As IXMLDOMNode, noh2 As IXMLDOMNode, Root As IXMLDOMElement
    Dim pIsin As String, pCod As String, q1 As String, v1 As String
    Dim TDesp As Double, TProv As Double, TPL As Double, VResgatas As Double
    Dim di As Date, dv As Date, Sindex As String, Scupom As String, Spindex As String
    Dim Scnpji As String, daux As String, compr As Boolean, ucomp As String
    Dim z As CProvFilterElement, z1 As CProvFilterElement, ProvFilter As New Collection
    
    
    Set db = OpenTheDatabase(True)
    
    XML.async = False
    XML.resolveExternals = False
    
    Nome = FileSystem.Dir(Config.XMLANBIMAPath + pasta + "\*" + Format(d, "_YYYYMMDD_") + "*.xml")
    
    'Lê o provfilter
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM TPROVFILTER WHERE DT_CREATED<=" + SQLBaseDate + " AND NOT (DELETED = 1  AND DT_DELETED<=" + SQLBaseDate + ")", db, adOpenForwardOnly, adLockReadOnly)
    Set ProvFilter = New Collection
    While Not rs.EOF
        Set z = New CProvFilterElement
        z.Fundo = CritN(rs("FUNDO"))
        z.ProvCod = CritS(rs("PROV_COD"))
        z.ProvData = CritS(rs("PROV_DATA"))
        z.PPTipo = CritS(rs("PP_TIPO"))
        z.PPCod = CritS(rs("PP_COD"))
        z.PPISIN = CritS(rs("PP_ISIN"))
        ProvFilter.Add z
        rs.MoveNext
    Wend
    
    If Nome = "" And Notify Then MsgBox ("Arquivo XML para importação da data " + Format(d, "dd-MMM-yy") + " não encontrado na pasta " + pasta)
    
    While Nome <> ""
        
        DoEvents
        
        If Not XML.Load(Config.XMLANBIMAPath + pasta + "\" + Nome) Then
            If Notify Then MsgBox ("Arquivo XML " + Chr(13) + Nome + Chr(13) + " não decifrado." + Chr(13) + XML.parseError.reason + Chr(13) + "Linha " + Str(XML.parseError.Line))
        Else
            'Lê o XML
            
            Set Root = XML.documentElement
            For Each noh In Root.childNodes 'Para cada fundo
                'Pega nome, cnpj
                    
                    If Not noh.selectSingleNode("header/cnpj") Is Nothing Then
                        CNPJ = noh.selectSingleNode("header/cnpj").Text
                    ElseIf Not noh.selectSingleNode("header/cnpjcpf") Is Nothing Then
                        CNPJ = noh.selectSingleNode("header/cnpjcpf").Text
                    Else
                        CNPJ = "0000000000"
                    End If
                    
                    If Not noh.selectSingleNode("header/nome") Is Nothing _
                        Then Nome = noh.selectSingleNode("header/nome").Text
                    
                    If noh.selectSingleNode("header/patliq") Is Nothing _
                        Then pling = 1 _
                        Else plind = Val(noh.selectSingleNode("header/patliq").Text)
                    
                    If noh.selectSingleNode("header/dtposicao") Is Nothing Then
                        dtposic = BaseDate
                    Else
                        dtposicSt = noh.selectSingleNode("header/dtposicao").Text
                        dtposic = DateSerial(Val(Left(dtposicSt, 4)), Val(Mid(dtposicSt, 5, 2)), Val(Mid(dtposicSt, 7, 2)))
                    End If
                    
                    If noh.selectSingleNode("header/vlcotasresgatar") Is Nothing _
                        Then VResgatar = 0 _
                        Else VResgatar = Val(noh.selectSingleNode("header/vlcotasresgatar").Text)

                
                'Busca o fundo no database e obtém o ID
                    Set rs = New ADODB.Recordset
                    Call rs.open("SELECT * FROM TFUNDOS WHERE CNPJ='" + CNPJ + "' AND (DELETED = 0 OR DT_DELETED>" + SQLD(d) + ")", db, adOpenForwardOnly, adLockReadOnly)
                    If Not rs.EOF Then
                        fundoid = rs("ID")
                    Else
                        Set rs = New ADODB.Recordset
                        Call rs.open("SELECT * FROM TFUNDOS WHERE NOME='" + Nome + "' AND (DELETED = 0 OR DT_DELETED>" + SQLD(d) + ")", db, adOpenForwardOnly, adLockReadOnly)
                        If Not rs.EOF Then fundoid = rs("ID") Else fundoid = -1
                    End If
                                    
                'Verifica se vai
                    If fundoid > 0 Then
                    
                        'Limpa a base para a data d, fundo fundoid
                        db.Execute ("DELETE FROM TPOSICLAYOUT2 WHERE DATA=" + SQLD(d) + " AND FUNDO=" + Str(fundoid))
                        TDesp = 0
                        TProv = -VResgatar
                        TPL = 0
                        
                        For Each noh2 In noh.childNodes
                                                    
                            DoEvents
                            '---valores default
                                di = LongTimeAgo
                                dv = LongTimeAgo
                                Scnpji = ""
                                Sindex = ""
                                Scupom = "0"
                                Spindex = "0"
                                compr = False
                                                    
                            grava = False
                            Select Case noh2.nodeName
                                Case "acoes"
                                    grava = True
                                    ltipo = noh2.nodeName
                                    pIsin = noh2.selectSingleNode("isin").Text
                                    pCod = noh2.selectSingleNode("codativo").Text
                                    q1 = Str(Val(noh2.selectSingleNode("qtdisponivel").Text) + Val(noh2.selectSingleNode("qtgarantia").Text))
                                    v1 = Str(Val(noh2.selectSingleNode("valorfindisp").Text) + Val(noh2.selectSingleNode("valorfinemgar").Text))
                                    If noh2.selectSingleNode("classeoperacao").Text = "V" Then v1 = -v1
                                    TPL = TPL + Val(v1)
                                    
                                Case "titpublico", "titprivado"
                                    grava = True
                                    ltipo = noh2.nodeName
                                    pIsin = noh2.selectSingleNode("isin").Text
                                    pCod = noh2.selectSingleNode("codativo").Text
                                    q1 = Str(Val(noh2.selectSingleNode("qtdisponivel").Text) + Val(noh2.selectSingleNode("qtgarantia").Text))
                                    v1 = Str(Val(noh2.selectSingleNode("valorfindisp").Text) + Val(noh2.selectSingleNode("valorfinemgar").Text))
                                    If noh2.selectSingleNode("classeoperacao").Text = "V" Then v1 = -v1
                                    If noh2.nodeName <> "titpublico" Then Scnpji = noh2.selectSingleNode("cnpjemissor").Text
                                    daux = noh2.selectSingleNode("dtemissao").Text
                                    di = DateSerial(Val(Left(daux, 4)), Val(Mid(daux, 5, 2)), Val(Right(daux, 2)))
                                    daux = noh2.selectSingleNode("dtvencimento").Text
                                    dv = DateSerial(Val(Left(daux, 4)), Val(Mid(daux, 5, 2)), Val(Right(daux, 2)))
                                    Sindex = noh2.selectSingleNode("indexador").Text
                                    Scupom = noh2.selectSingleNode("coupom").Text
                                    Spindex = noh2.selectSingleNode("percindex").Text
                                    If Not noh2.selectSingleNode("compromisso") Is Nothing Then compr = True
                                    TPL = TPL + Val(v1)
                                    
                                Case "debenture"
                                    grava = True
                                    ltipo = noh2.nodeName
                                    pIsin = noh2.selectSingleNode("isin").Text
                                    pCod = noh2.selectSingleNode("coddeb").Text
                                    q1 = Str(Val(noh2.selectSingleNode("qtdisponivel").Text) + Val(noh2.selectSingleNode("qtgarantia").Text))
                                    v1 = Str(Val(noh2.selectSingleNode("valorfindisp").Text) + Val(noh2.selectSingleNode("valorfinemgar").Text))
                                    If noh2.selectSingleNode("classeoperacao").Text = "V" Then v1 = -v1
                                    daux = noh2.selectSingleNode("dtemissao").Text
                                    di = DateSerial(Val(Left(daux, 4)), Val(Mid(daux, 5, 2)), Val(Right(daux, 2)))
                                    daux = noh2.selectSingleNode("dtvencimento").Text
                                    dv = DateSerial(Val(Left(daux, 4)), Val(Mid(daux, 5, 2)), Val(Right(daux, 2)))
                                    Scnpji = noh2.selectSingleNode("cnpjemissor").Text
                                    Sindex = noh2.selectSingleNode("indexador").Text
                                    Scupom = noh2.selectSingleNode("coupom").Text
                                    Spindex = noh2.selectSingleNode("percindex").Text
                                    TPL = TPL + Val(v1)
                                    
                                Case "caixa"
                                    grava = True
                                    ltipo = noh2.nodeName
                                    pIsin = noh2.selectSingleNode("isininstituicao").Text
                                    pCod = "CONTA"
                                    q1 = noh2.selectSingleNode("saldo").Text
                                    v1 = q1
                                    TPL = TPL + Val(v1)
                                    
                                Case "cotas"
                                    grava = True
                                    ltipo = noh2.nodeName
                                    pIsin = noh2.selectSingleNode("isin").Text
                                    pCod = noh2.selectSingleNode("cnpjfundo").Text
                                    Scnpji = noh2.selectSingleNode("cnpjfundo").Text
                                    q1 = Str(Val(noh2.selectSingleNode("qtdisponivel").Text) + Val(noh2.selectSingleNode("qtgarantia").Text))
                                    v1 = Str(Val(noh2.selectSingleNode("puposicao").Text) * Val(q1))
                                    TPL = TPL + Val(v1)
                                    
                                Case "despesas"
                                    grava = False
                                    TDesp = TDesp - Val(noh2.selectSingleNode("txadm").Text)
                                    
                                Case "outrasdespesas"
                                    grava = False
                                    TDesp = TDesp - Val(noh2.selectSingleNode("valor").Text)
                                    
                                Case "provisao"
                                    'Verifica filtro de provisão
                                    Set z1 = Nothing
                                    For Each z In ProvFilter
                                        If z.Fundo = fundoid And z.ProvCod = noh2.selectSingleNode("codprov").Text And z.ProvData = noh2.selectSingleNode("dt").Text Then Set z1 = z
                                    Next z
                                    If z1 Is Nothing Then
                                        grava = False
                                        If noh2.selectSingleNode("credeb").Text <> "D" Then m = 1 Else m = -1
                                        TProv = TProv + Val(noh2.selectSingleNode("valor").Text) * m
                                    Else
                                        'achou um título no filtro de provisão
                                        grava = True
                                        ltipo = z1.PPTipo
                                        pIsin = z1.PPISIN
                                        pCod = z1.PPCod
                                        q1 = 1
                                        v1 = Str(Val(noh2.selectSingleNode("valor").Text) * Val(q1))
                                        If noh2.selectSingleNode("credeb").Text = "D" Then v1 = -v1
                                        TPL = TPL + Val(v1)
                                    End If
                                    
                                Case "futuros"
                                    grava = True
                                    ltipo = noh2.nodeName
                                    pIsin = noh2.selectSingleNode("isin").Text
                                    pCod = noh2.selectSingleNode("ativo").Text + noh2.selectSingleNode("serie").Text
                                    If noh2.selectSingleNode("classeoperacao").Text = "C" Then mss = "" Else mss = "-"
                                    'Corrige o erro do XML DAP
                                        If noh2.selectSingleNode("ativo").Text = "DAP" And _
                                            Val(noh2.selectSingleNode("vltotalpos").Text) < 50000 * Val(noh2.selectSingleNode("quantidade").Text) Then
                                        
                                            q1 = mss + Str(Val(noh2.selectSingleNode("quantidade").Text) * 120000)
                                        Else
                                            q1 = mss + noh2.selectSingleNode("vltotalpos").Text
                                        End If
                                        
                                    v1 = noh2.selectSingleNode("vlajuste").Text
                                    daux = noh2.selectSingleNode("dtvencimento").Text
                                    dv = DateSerial(Val(Left(daux, 4)), Val(Mid(daux, 5, 2)), Val(Right(daux, 2)))
                                    TPL = TPL + Val(v1)
                                    
                                Case "imoveis"
                                    grava = True
                                    ltipo = noh2.nodeName
                                    pIsin = "IMOVEL"
                                    q1 = "1"
                                    v1 = noh2.selectSingleNode("valoravaliacao").Text
                                    If v1 = "0.00" Then v1 = noh2.selectSingleNode("valorcontabil").Text
                                    pCod = noh2.selectSingleNode("logradouro").Text + " " + noh2.selectSingleNode("numero").Text
                                
                                Case "header"
                                    grava = False
                                    
                                Case Else
                                    grava = True
                                    ltipo = "!outro"
                                    pIsin = noh2.nodeName
                                    pCod = "OUTRO"
                                    v1 = "0"
                                    q1 = "0"
                                    
                            End Select
                            
                            Scupom = Str(Val(Scupom) / 100)
                            If compr Then ucomp = "1" Else ucomp = "0"
                            
                            If grava Then _
                                db.Execute ("INSERT INTO TPOSICLAYOUT2 (FUNDO, TIPO, PAPEL_ISIN, PAPEL_COD, QUANT, VALOR, DATA, DTVENC, DTISSUE, [INDEX],CUPOM,PINDEX,CNPJISSUE, IMPORTFOLDER, COMPROMISSADA) VALUES (" + _
                                Str(fundoid) + ", '" + ltipo + "', '" + pIsin + "', '" + pCod + "'," + q1 + ", " + v1 + ", " + SQLD(d) + "," + SQLD(dv) + "," + SQLD(di) + ",'" + Sindex + "'," + Scupom + "," + Spindex + ",'" + Scnpji + "','" + pasta + "'," + ucomp + ")")
                        
                        Next noh2 'proxima posição
                        
                        'Grava Totais de provisão e despesa
                        If TProv <> 0 Then db.Execute ("INSERT INTO TPOSICLAYOUT2 (FUNDO, TIPO, PAPEL_ISIN, PAPEL_COD, QUANT, VALOR, DATA, DTVENC, DTISSUE, [INDEX],CUPOM,PINDEX,CNPJISSUE, IMPORTFOLDER, COMPROMISSADA) VALUES (" + Str(fundoid) + ", 'PROVISAO', 'PROVISAO', 'PROVISAO'," + Str(TProv) + ", " + Str(TProv) + ", " + SQLD(d) + ",'1990-01-01','1990-01-01','',0,0,'','" + pasta + "',0)")
                        If TDesp <> 0 Then db.Execute ("INSERT INTO TPOSICLAYOUT2 (FUNDO, TIPO, PAPEL_ISIN, PAPEL_COD, QUANT, VALOR, DATA, DTVENC, DTISSUE, [INDEX],CUPOM,PINDEX,CNPJISSUE, IMPORTFOLDER, COMPROMISSADA) VALUES (" + Str(fundoid) + ", 'DESPESA', 'DESPESA', 'DESPESA'," + Str(TDesp) + ", " + Str(TDesp) + ", " + SQLD(d) + ",'1990-01-01','1990-01-01','',0,0,'','" + pasta + "',0)")
                        TPL = TPL + TProv + TDesp
                        If Abs(TPL - plind) > 0.05 * plind Then
                            If Notify Then MsgBox ("Fundo " + Nome + " inconsistente na importação XML:" + Chr(13) + Format(TPL, "###,###,##0") + " x " + Format(plind, "###,###,##0"))
                            WriteLogError "Importação PL inconsistente", Nome
                        End If
                        
                    Else
                        If Notify Then MsgBox (Nome + " nao encontrado")
                        WriteLogError "Fundo não encontrado durante Importação", Nome
                    End If
                    
            Next noh 'proximo fundo
        End If 'XML.Parse
        
        Nome = FileSystem.Dir()

    Wend
End Sub


Private Function ConsultaPapelNaBase(db As ADODB.Connection, ID As String) As ADODB.Recordset
    'Procura o papel na base (db aberto) e no Alias
    Dim r As ADODB.Recordset, R1 As ADODB.Recordset
    Set r = New ADODB.Recordset
    Call r.open("SELECT * FROM TPAPEL WHERE ID='" + ID + "'", db, adOpenForwardOnly, adLockReadOnly)
    If r.EOF Then
        'Procura tb na lista de alias
        Set R1 = New ADODB.Recordset
        Call R1.open("SELECT * FROM TAKA WHERE FROMID='" + ID + "'", db, adOpenForwardOnly, adLockReadOnly)
        If Not R1.EOF Then
            Set r = New ADODB.Recordset
            Call r.open("SELECT * FROM TPAPEL WHERE ID='" + CritS(R1("TOID")) + "'", db, adOpenForwardOnly, adLockReadOnly)
        End If
    End If
    Set ConsultaPapelNaBase = r
End Function



Public Sub Layt22MainParaData(d As Date)
    'Lê do TPOSICLAYOUT2 e grava em TPOSIC;
    'Substitui TPOSIC preexistente de cada fundo/data encontrado em TPOSICLAYOUT2
    'cadastra os títulos que não forem encontrados (ISIN) em TPAPEL
    
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, rs2 As ADODB.Recordset, rs3 As ADODB.Recordset
    Dim pp As CPapel, po As CPosic, fd As CFundo, a As String, fvez As Integer
    Dim ppID As String, PPISIN As String, PapelAchado As Boolean
    Dim SelectOrder As String
    
    
    Set db = OpenTheDatabase(True)
    
    SelectOrder = "SELECT FUNDO, PAPEL_ISIN, SUM(QUANT) AS SQ, SUM(VALOR) AS SV, DATA, PAPEL_COD," + _
                  " MAX(TIPO) AS TIPO1, MAX(DTVENC) AS DTVENC1, MIN(DTISSUE) AS DTISSUE1, MAX([INDEX]) AS INDEX1, MIN(CUPOM) AS CUPOM1, MIN(PINDEX) AS PINDEX1, CNPJISSUE, IMPORTFOLDER, COMPROMISSADA" + _
                  " FROM TPOSICLAYOUT2" + _
                  " WHERE DATA=" + SQLD(d) + _
                  " GROUP BY FUNDO, PAPEL_ISIN, DATA, PAPEL_COD, CNPJISSUE, IMPORTFOLDER, COMPROMISSADA" + _
                  " ORDER BY FUNDO"
                  
    
    Set rs = New ADODB.Recordset
    Call rs.open(SelectOrder, db, adOpenForwardOnly, adLockReadOnly)
    
    fvez = 0
    
    While Not rs.EOF
            
        DoEvents
        If rs("FUNDO") <> fvez Then 'Limpa TPOSIC fundo a fundo
            db.Execute ("DELETE FROM TPOSIC WHERE DATA=" + SQLD(d) + " AND FUNDO = " + Str(rs("FUNDO")))
            fvez = rs("FUNDO")
        End If
                
        '---------------------------------------------< Tenta achar o papel já existente (no database)
        PapelAchado = False
        Call FStart.Say("Importando posição XML " & d & " Fundo: " & rs("fundo") & " Papel: " & rs("PAPEL_ISIN"))
        If rs("COMPROMISSADA") Then
            'É compromissada
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT * FROM TPAPEL WHERE ID='OVER'", db, adOpenForwardOnly, adLockReadOnly)
            If rs1.EOF Then
                Set rs1 = New ADODB.Recordset
                Call rs1.open("SELECT * FROM TPAPEL WHERE ID='COMPROMISSADA'", db, adOpenForwardOnly, adLockReadOnly)
            End If
            PapelAchado = Not rs1.EOF
        End If
        
        If Not PapelAchado And InStr(CritS(rs("PAPEL_ISIN")), "**") = 0 Then
            'Procura o papel na TPAPEL pelo ISIN = ISIN
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT * FROM TPAPEL WHERE ISIN='" + CritS(rs("PAPEL_ISIN")) + "' AND DT_CREATED<=" + SQLD(d) + " AND (DELETED =0 OR DT_DELETED>=" + SQLD(d) + ")", db, adOpenForwardOnly, adLockReadOnly)
            PapelAchado = Not rs1.EOF
        End If
        
        If Not PapelAchado And InStr(CritS(rs("PAPEL_ISIN")), "**") = 0 Then
            'Procura o papel na TPAPEL por ID = ISIN
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT * FROM TPAPEL WHERE ID='" + CritS(rs("PAPEL_ISIN")) + "' AND DT_CREATED<=" + SQLD(d) + " AND (DELETED = 0 OR DT_DELETED>=" + SQLD(d) + ")", db, adOpenForwardOnly, adLockReadOnly)
            PapelAchado = Not rs1.EOF
        End If
        
        If Not PapelAchado Then
            'Procura no AKA por FromID = ISIN
            Set rs2 = New ADODB.Recordset
            Call rs2.open("SELECT * FROM TAKA WHERE FROMID='" + CritS(rs("PAPEL_ISIN")) + "' AND DT_CREATED<=" + SQLD(d) + " AND (DELETED =0 OR DT_DELETED>=" + SQLD(d) + ")", db, adOpenForwardOnly, adLockReadOnly)
            If rs2.EOF Then
                PapelAchado = False
            Else
                Set rs1 = New ADODB.Recordset
                Call rs1.open("SELECT * FROM TPAPEL WHERE ID='" + CritS(rs2("TOID")) + "'", db, adOpenForwardOnly, adLockReadOnly)
                PapelAchado = Not rs1.EOF
            End If
        End If
        
        If Not PapelAchado And CritS(rs("TIPO1")) = "cotas" Then
            'Verifica, se for fundo, por CNPJ = CNPJISSUE
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT * FROM TPAPEL WHERE CNPJ<>'' AND CNPJ='" + CritS(rs("CNPJISSUE")) + "' AND DT_CREATED<=" + SQLD(d) + " AND (DELETED =0 OR DT_DELETED>=" + SQLD(d) + ")", db, adOpenForwardOnly, adLockReadOnly)
            PapelAchado = Not rs1.EOF
        End If
        
        If Not PapelAchado And CritS(rs("TIPO1")) = "cotas" Then
            'Verifica se é um dos fundos da casa por CNPJ=CNPJISSUE
            Set rs2 = New ADODB.Recordset
            Call rs2.open("SELECT * FROM TFUNDOS WHERE CNPJ='" + CritS(rs("CNPJISSUE")) + "'", db, adOpenForwardOnly, adLockReadOnly)
            If rs2.EOF Then
                PapelAchado = False
            Else
                Set rs1 = New ADODB.Recordset
                Call rs1.open("SELECT * FROM TPAPEL WHERE ID='" + CritS(rs2("IDTITULO")) + "'", db, adOpenForwardOnly, adLockReadOnly)
                PapelAchado = Not rs1.EOF
            End If
        End If
        
        If Not PapelAchado And CritS(rs("TIPO1")) = "cotas" Then
            'Procura, se fundo, no AKA por FromID = CNPJISSUE
            Set rs2 = New ADODB.Recordset
            Call rs2.open("SELECT * FROM TAKA WHERE FROMID='" + CritS(rs("CNPJISSUE")) + "' AND DT_CREATED<=" + SQLD(d) + " AND (DELETED = 0 OR DT_DELETED>=" + SQLD(d) + ")", db, adOpenForwardOnly, adLockReadOnly)
            If rs2.EOF Then
                PapelAchado = False
            Else
                Set rs1 = New ADODB.Recordset
                Call rs1.open("SELECT * FROM TPAPEL WHERE ID='" + CritS(rs2("TOID")) + "'", db, adOpenForwardOnly, adLockReadOnly)
                PapelAchado = Not rs1.EOF
            End If
        End If
            
        If Not PapelAchado Then
            'Tenta achar por ID = Papel_Cod
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT * FROM TPAPEL WHERE ID='" + CritS(rs("PAPEL_COD")) + "' AND DT_CREATED<=" + SQLD(d) + " AND (DELETED = 0 OR DT_DELETED>=" + SQLD(d) + ")", db, adOpenForwardOnly, adLockReadOnly)
            PapelAchado = Not rs1.EOF
        End If
        
        If Not PapelAchado Then
            'Tenta achar por CodCetip = Papel_Cod
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT * FROM TPAPEL WHERE CODCETIP='" + CritS(rs("PAPEL_COD")) + "' AND DT_CREATED<=" + SQLD(d) + " AND (DELETED = 0 OR DT_DELETED>=" + SQLD(d) + ")", db, adOpenForwardOnly, adLockReadOnly)
            PapelAchado = Not rs1.EOF
        End If
        
        If Not PapelAchado Then
            'Procura, se fundo, no AKA por FromID = Papel_Cod
            Set rs2 = New ADODB.Recordset
            Call rs2.open("SELECT * FROM TAKA WHERE FROMID='" + CritS(rs("PAPEL_COD")) + "' AND DT_CREATED<=" + SQLD(d) + " AND (DELETED = 0 OR DT_DELETED>=" + SQLD(d) + ")", db, adOpenForwardOnly, adLockReadOnly)
            If rs2.EOF Then
                PapelAchado = False
            Else
                Set rs1 = New ADODB.Recordset
                Call rs1.open("SELECT * FROM TPAPEL WHERE ID='" + CritS(rs2("TOID")) + "'", db, adOpenForwardOnly, adLockReadOnly)
                PapelAchado = Not rs1.EOF
            End If
        End If
        
        '---------------------------------------------< Indexa o papel que existe e Trata o que não existe
        If PapelAchado Then
            'rs1 tem um registro válido
            PPISIN = CritS(rs1("ISIN"))
            ppID = rs1("ID")
        
        Else
            'Cria o papel
            
            Set pp = New CPapel
            
            If rs("COMPROMISSADA") Then
            
                pp.ID = "OVER"
                pp.ISIN = "OVER"
                pp.Nome = "COMPROMISSADA"
                pp.Status = "AUTO_TIPO2"
                s2 = "0"
                pp.Dt_Emissao = Now()
                pp.Dt_Venc = Now()
                pp.Index = "CDI+"
                pp.Coupon = 0
                pp.DayCount = "Bus/252"
                pp.CodCetip = "OVER"
                pp.Tipo = "TITPRIVADO"
                pp.Class_Liq = "CASH"
                pp.Class_Rent = "OVER"
                pp.Senior = "SR_SECURED"
                pp.Holdings = 1
            
            Else 'não é compromissada
            
                pp.ISIN = CritS(rs("PAPEL_ISIN"))
                If InStr(pp.ISIN, "**") > 0 Or pp.ISIN = "" Then pp.ID = CritS(rs("PAPEL_COD")) Else pp.ID = pp.ISIN
                
                
                'verifica se ID já existe e cria ID unica
                    Set rs2 = New ADODB.Recordset
                    Call rs2.open("SELECT * FROM TPAPEL WHERE ID='" + pp.ID + "'", db, adOpenForwardOnly, adLockReadOnly)
                    If Not rs2.EOF Then
                        i = 0
                        While Not rs2.EOF
                            i = i + 1
                            Set rs2 = New ADODB.Recordset
                            Call rs2.open("SELECT * FROM TPAPEL WHERE ID='" + pp.ID + "(" + Trim(Str(i)) + ")'", db, adOpenForwardOnly, adLockReadOnly)
                        Wend
                        pp.ID = pp.ID + "(" + Trim(Str(i)) + ")"
                        WriteLogError "Papel importado com ID provavelmente já existente", pp.ID
                    End If
                
                'Continua a criação do papel
                'Coloca os defaults
                pp.Nome = "Unknown (" + pp.ID + ")"
                pp.Status = "AUTO_TIPO2"
                s2 = "0" 'eh fundo?
                pp.Dt_Emissao = Now()
                pp.Dt_Venc = Now()
                pp.Index = "CDI+"
                pp.Senior = "SR_CLEAN"
                pp.Holdings = 1
                pp.Coupon = 0
                pp.DayCount = "Bus/252"
                pp.CodCetip = CritS(rs("PAPEL_COD"))
                pp.Tipo = "TITPRIVADO"
                pp.CNPJ = ""
                pp.NameCr = ""
                            
                Select Case CritS(rs("TIPO1"))
                    Case "cotas"
                        pp.Class_Liq = "FIDC"
                        pp.Class_Rent = "PERP"
                        pp.Tipo = "COTAS"
                        pp.CNPJ = rs("CNPJISSUE")
                        
                    Case "caixa"
                        pp.Class_Liq = "CASH"
                        pp.Class_Rent = "OVER"
                        pp.Tipo = "CAIXA"
                        
                    Case "DESPESA"
                        pp.Class_Liq = "CASH"
                        pp.Class_Rent = "OVER"
                        pp.Tipo = "DESPESA"
                        
                    Case "PROVISAO"
                        pp.Class_Liq = "CASH"
                        pp.Class_Rent = "OVER"
                        pp.Tipo = "PROVISAO"
                        
                    Case "titpublico"
                        pp.Class_Liq = "TITPUB"
                        pp.Class_Rent = "MATURITY"
                        pp.Dt_Emissao = CritD(rs("DTISSUE1"))
                        pp.Dt_Venc = CritD(rs("DTVENC1"))
                        If rs("pindex1") = 100 Then
                            pp.Coupon = Val(rs("cupom1"))
                            a = "+"
                        Else
                            pp.Coupon = Val(rs("pindex1"))
                            a = "%"
                        End If
                        pp.Index = ConvIndex(rs("INDEX1"), a)
                        pp.Tipo = "TITPUBLICO"
                        
                        
                    Case "titprivado"
                        If Left(rs("PAPEL_COD"), 2) = "LF" Then
                            pp.Class_Liq = "LF"
                        ElseIf Mid(rs("PAPEL_ISIN"), 7, 3) = "CRI" Then
                            pp.Class_Liq = "CRI"
                        Else
                            pp.Class_Liq = "DEB476"
                        End If
                        pp.Class_Rent = "MATURITY"
                        pp.Dt_Emissao = CritD(rs("DTISSUE1"))
                        pp.Dt_Venc = CritD(rs("DTVENC1"))
                        If rs("pindex1") = 100 Then
                            pp.Coupon = Val(rs("cupom1"))
                            a = "+"
                        Else
                            pp.Coupon = Val(rs("pindex1")) / 100
                            a = "%"
                        End If
                        pp.Index = ConvIndex(rs("INDEX1"), a)
                        pp.Tipo = "TITPRIVADO"
                        pp.CNPJ = rs("CNPJISSUE")
                        
                        
                    Case "debenture"
                        pp.Class_Liq = "DEB476"
                        pp.Class_Rent = "MATURITY"
                        pp.Dt_Emissao = CritD(rs("DTISSUE1"))
                        pp.Dt_Venc = CritD(rs("DTVENC1"))
                        If rs("pindex1") = 100 Then
                            pp.Coupon = Val(rs("cupom1"))
                            a = "+"
                        Else
                            pp.Coupon = Val(rs("pindex1")) / 100
                            a = "%"
                        End If
                        pp.Index = ConvIndex(rs("INDEX1"), a)
                        pp.Tipo = "DEBENTURE"
                        pp.CNPJ = rs("CNPJISSUE")
                        
                        
                    Case "acoes"
                        codigo = CritS(rs("PAPEL_COD"))
                        If Val(Right(codigo, 2)) > 10 Or Val(Right(codigo, 3)) > 10 Then
                            'Fundo imobiliário
                            pp.Class_Liq = "FIILIST"
                            pp.Class_Rent = "PERP"
                            pp.Tipo = "COTAS"
                        Else
                            'Ação
                            pp.Class_Liq = "CASH"
                            pp.Class_Rent = "PERP"
                            pp.Tipo = "ACOES"
                        End If
                        
                        
                    Case "futuros"
                        pp.Class_Liq = "CASH"
                        pp.Class_Rent = "OVER"
                        pp.Tipo = "FUTUROS"
                        pp.Dt_Venc = CritD(rs("DTVENC1"))
                        pp.Nome = "Fut" + pp.CodCetip
                        
                        
                    Case "imoveis"
                        pp.Class_Liq = "FIINLIST"
                        pp.Class_Rent = "PERP"
                        pp.Tipo = "IMOVEL"
                        pp.Nome = "Imovel " + pp.CodCetip
                    
                End Select
                
            End If 'é compromissada
                
            'Insere o papel criado
            If pp.Coupon > 0.5 Or (pp.Coupon > 2 And pp.Index = "%CDI") Then
                WriteLogError "Importação de cupom anormal", pp.ID
                pp.Coupon = 0
            End If
            
            'Tenta achar o Nome crédito pelo CNPJ
            If pp.CNPJ <> "" Then
                Set rs3 = New ADODB.Recordset
                Call rs3.open("SELECT * FROM TCNPJNOME WHERE CNPJ='" + pp.CNPJ + "'", db, adOpenForwardOnly, adLockReadOnly)
                If Not rs3.EOF Then pp.NameCr = rs3("NOMECREDITO")
            End If
            db.Execute ("INSERT INTO TPAPEL (NOME, ID, STATUS, FUNDO, CLASS_LIQ, CLASS_RENTAB, DATA_EMISSAO, DATA_VENCTO, " + _
                "[INDEX], COUPON, DAYCOUNT, SENIOR, NAMECR, HOLDINGS, ISIN, CNPJ, CODCETIP, DT_CREATED, DT_DELETED, DELETED, TIPO) VALUES " + _
                "('" + pp.Nome + "', '" + _
                pp.ID + "','" + _
                pp.Status + "', '" + _
                s2 + "', '" + _
                pp.Class_Liq + "','" _
                + pp.Class_Rent + "'," + _
                SQLD(pp.Dt_Emissao) + " , " + _
                SQLD(pp.Dt_Venc) + ",'" + _
                pp.Index + "', " + _
                Str(pp.Coupon) + ",'" + _
                pp.DayCount + "','" + _
                pp.Senior + "','" + _
                pp.NameCr + "'," + _
                Str(pp.Holdings) + ",'" + _
                pp.ISIN + "','" + _
                pp.CNPJ + "','" + _
                pp.CodCetip + "'," + _
                SQLD(d) + "," + _
                SQLD(d) + ",0,'" + pp.Tipo + "')")
                    
            'Deixa nas variáveis padrão para inserir em TPOSIC
                PPISIN = pp.ISIN
                ppID = pp.ID
                
        End If '--------------------------------------------------------------------< Papel achado / não achado
        
        'Insere a POSICAO
        
        db.Execute ("INSERT INTO TPOSIC (FUNDO, PAPEL, ISIN, VALOR, DATA, QUANT, TIPO) VALUES (" + _
        Str(rs("fundo")) + ",'" + ppID + "','" + PPISIN + "'," + Str(rs("sv")) + "," + SQLD(d) + "," + Str(rs("sq")) + ",2)")
        
        rs.MoveNext
    Wend
End Sub


Private Function ConvIndex(x As String, Optional a As String) As String
    Select Case x
        Case "SEL"
            ConvIndex = "SELIC"
        Case "DI1"
            If a = "+" Then ConvIndex = "CDI+" Else ConvIndex = "%CDI"
        Case "PRE"
            ConvIndex = "PRE"
        Case "IGD"
            ConvIndex = "IGPM+"
        Case "IAP"
            ConvIndex = "IPCA+"
        Case Else
            ConvIndex = "IGPM+"
    End Select
End Function



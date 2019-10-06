VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "C_CompReporter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False


Public Sub report_Blotter()
    Dim db As ADODB.Connection, ts1 As String, u As CTrade
    Set db = OpenTheDatabase(True)
    ts1 = SQLTimeStamp
    For Each u In Trades.CTodayTrades
        db.Execute ("INSERT INTO THISTTRADEERRS (DATARUN, DATA, TRADEKEY, ADDR, FUNDO, ATIVO, CV, QUANT, TAXA, PU, EXTENSO) VALUES (" + _
        ts1 + "," + SQLBaseDate + ",'" + u.TradeKey + "','" + u.Addr + "','" + u.Fundo + "','" + u.Ativo + "','" + u.CV + "'," + Str(u.Quant) + "," + Str(u.Taxa) + "," + Str(u.PU) + ",'" + u.Extenso + "')")
    Next u
End Sub

Public Sub Report_Allocation(Optional frm As Form)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, x As CAlocacao
    
    Set db = OpenTheDatabase(True)
    
    If Not frm Is Nothing Then frm.Say ("Gravando Resultado de Alocação")
    db.Execute ("DELETE FROM THISTALLOC WHERE DATA = " + SQLBaseDate)
    
    For Each x In Trades.cAlloc
        db.Execute ("INSERT INTO THISTALLOC (DATA, FUNDO, ATIVO, PUFUNDO, PUGERAL, CV, COMPLIANT) VALUES (" + SQLBaseDate + ", '" + _
        x.Fundo + "','" + x.Ativo + "'," + Str(x.PUFundo) + "," + Str(x.PUGeral) + ",'" + x.CV + "','" + x.Compliant + "')")
    Next x
End Sub

Public Sub Report_CashReport(Optional frm As Form)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, f As CFundo
    
    Set db = OpenTheDatabase(True)
    
    If Not frm Is Nothing Then frm.Say ("Gravando Cash Report")
    db.Execute ("DELETE FROM TCASHREPORTHIST WHERE DATA = " + SQLBaseDate)
    For Each f In Fundos.c
        If f.Favorit_Cash Then
            ad = f.StaticDisp
            a1 = f.StaticCash
            a2 = f.StaticCashPct
            a3 = f.StaticCashFree
            a4 = f.StaticCashFreePct
            a5 = f.liquidityAteh(BaseDate + 91) - f.liquidityAteh(BaseDate + 1)
            a6 = f.LiqNeededAteh(BaseDate + 91)
            a7 = a3 + a5 - a6
            db.Execute ("INSERT INTO TCASHREPORTHIST (DATA, FUNDO, DISPO, CASH, PCASH, CASHFREE, PCASHFREE, LIQ3M, REQ3M, CASHFREE3M) VALUES " + _
            "(" + SQLBaseDate + ",'" + f.Nome + "'," + Str(ad) + "," + Str(a1) + "," + Str(a2) + "," + Str(a3) + "," + Str(a4) + "," + Str(a5) + "," + Str(a6) + "," + Str(a7) + ")")
        End If
    Next f
End Sub


Public Sub Report_AML(Optional frm As Form)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, trd As CTrade, trd1 As CTrade, m As String, bkr As CCtpt, vai As String
    
    Set db = OpenTheDatabase(True)
    
    'Grava AML
            If Not frm Is Nothing Then frm.Say ("Gravando Resultado de AML")
            db.Execute ("DELETE FROM THISTAML WHERE DATA = " + SQLBaseDate)
            
            fdant = "": atant = "": cvant = "": qant = 0
            For Each trd In Trades.CTodayTrades
                m = ""
                If trd.Exempt Then
                    m = "Isento"
                Else
                    If trd.Points > 0 Then m = m + Str(trd.Points) + " pontos"
                    If trd.ExtPoints > 0 Then m = m + " Ext.Valued"
                End If
                
                u = trd.CV + " @ " + Str(trd.Comparavel) + " Banda=(" + Str(trd.BandaLow) + " - " + Str(trd.BandaHigh) + "); " + m
                db.Execute ("INSERT INTO THISTAML (DATA, TRADE, CTPT, COMPLIANT, COMENT, ATIVO, FUNDO) VALUES (" + _
                SQLBaseDate + "," + Str(trd.ID) + ",'" + trd.Broker + "','" + trd.Compliant + "','" + u + "','" + trd.Ativo + "','" + trd.Fundo + "')")
                
'                If trd.Fundo = fdant And trd.Ativo = atant And trd.CV <> cvant And Not trd.Exempt And Not UCase(trd.Ativo) = "COMPROMISSADA" Then
'                    'Day-Trade
'                    u = "Day-Trade " + trd.CV + " " + Str(trd.Quant) + " x " + cvant + " " + Str(qant)
'                    db.Execute ("INSERT INTO THISTAML (DATA, TRADE, CTPT, COMPLIANT, COMENT, ATIVO, FUNDO) VALUES (" + _
'                    SQLBaseDate + "," + Str(trd.ID) + ",'" + trd.Broker + "','WARN-DT','" + u + "','" + trd.Ativo + "','" + trd.Fundo + "')")
'                End If
                
                'Contraparte não cadastrada
                Set bkr = Trades.searchctpt(trd.Broker)
                If bkr Is Nothing And Trim(trd.Broker) <> "" Then
                    u = "Contraparte nao cadastrada TradeID=" + Str(trd.ID) + " Ctpt=" + trd.Broker
                    db.Execute ("INSERT INTO THISTAML (DATA, TRADE, CTPT, COMPLIANT, COMENT, ATIVO, FUNDO) VALUES (" + _
                    SQLBaseDate + "," + Str(trd.ID) + ",'" + trd.Broker + "','WARN-CT','" + u + "','" + trd.Ativo + "','" + trd.Fundo + "')")
                End If
                
                'Contraparte com alto risco
                If Not bkr Is Nothing Then
                    If UCase(bkr.PerfilRisco) = "ALTO" Then
                        u = "Trade com Contraparte de ALTO RISCO; TradeID=" + Str(trd.ID) + " Ctpt=" + trd.Broker
                        db.Execute ("INSERT INTO THISTAML (DATA, TRADE, CTPT, COMPLIANT, COMENT, ATIVO, FUNDO) VALUES (" + _
                        SQLBaseDate + "," + Str(trd.ID) + ",'" + trd.Broker + "','WARN-CT','" + u + "','" + trd.Ativo + "','" + trd.Fundo + "')")
                    End If
                End If
                
                'Procura day-trade
                If Not trd.MyFund Is Nothing Then
                    If trd.MyFund.Rule_NoDayTrd Then vai = "BREACH-DT" Else vai = ""
                Else
                    vai = "WARN-DT"
                End If
                If vai <> "" Then
                    For Each trd1 In Trades.CTodayTrades
                        If (Not trd1 Is trd) And trd1.Ativo = trd.Ativo And trd1.Fundo = trd.Fundo And trd.CV <> trd1.CV Then
                            u = "Day-Trade " + trd.CV + " " + Str(trd.Quant) + " x " + trd1.CV + " " + Str(trd1.Quant)
                            db.Execute ("INSERT INTO THISTAML (DATA, TRADE, CTPT, COMPLIANT, COMENT, ATIVO, FUNDO) VALUES (" + _
                            SQLBaseDate + "," + Str(trd.ID) + ",'" + trd.Broker + "','WARN-DT','" + u + "','" + trd.Ativo + "','" + trd.Fundo + "')")
                        End If
                    Next trd1
                End If
                
                'Procura trades entre fundos
                If Not trd.MyFund Is Nothing Then
                    If trd.MyFund.Rule_NoCrssTrd Then vai = "BREACH-CT" Else vai = ""
                Else
                    vai = "WARN-CT"
                End If
                If vai <> "" Then
                    For Each trd1 In Trades.CTodayTrades
                        If (Not trd1 Is trd) And trd1.Ativo = trd.Ativo And trd1.Fundo <> trd.Fundo And trd.CV <> trd1.CV Then
                            u = "Cross Trade " + trd.CV + " " + Str(trd.Quant) + " x " + trd1.Fundo + ": " + Str(trd1.Quant)
                            order = "INSERT INTO THISTAML (DATA, TRADE, CTPT, COMPLIANT, COMENT, ATIVO, FUNDO) VALUES (" + _
                            SQLBaseDate + "," + Str(trd.ID) + ",'" + trd.Broker + "','WARN-TF','" + u + "','" + trd.Ativo + "','" + trd.Fundo + "')"
                            
                            db.Execute (order)
                        End If
                    Next trd1
                End If
                fdant = trd.Fundo: atant = trd.Ativo: cvant = trd.CV: qant = trd.Quant
            Next trd
                                
End Sub


Sub GravaDB(Optional frm As Form)

    Dim f As CFundo, b As CBook, r As CRegra, px As Integer, c As Collection, h As CNomeValor
    Dim u As String, u1 As String, u2 As String, m As Double
    Dim db As ADODB.Connection, rs As ADODB.Recordset
    Dim v As Double, s As Double, s1 As Double, i As Integer, prop As CPropriedade, trd As CTrade
    Dim t0 As Date, td As Double, ti As Integer
    Dim RR As CRuleResult
    
    If MainStatus = "LIVE" Then
        t0 = Now()
        
        'Grava Allocation
            Report_Allocation frm
        
        'Grava AML
            Report_AML frm
            
        'GravaCashReport
            Report_CashReport frm
           
        
        Set db = OpenTheDatabase(True)
        
        'Grava Compliance
            If Not frm Is Nothing Then frm.Say ("Gravando Resultado de Compliance")
            db.Execute ("DELETE FROM THISTCOMPL WHERE DATA = " + SQLBaseDate)
            db.Execute ("DELETE FROM THISTCOMPBREACHES WHERE DATA = " + SQLBaseDate)
            
            For Each f In Fundos.c
                DoEvents
                For Each b In f.MyBooks
                    DoEvents
                    ruls = ""
                    ruls1 = ""
                    u = f.IAmCompliantWithBook(b, "ALL")
                    If u <> "OK" And f.CarteiraUpdateStatus <> "INV" Then
                        'Procura regra a regra P/ gravar arquivo de detalhe de compliance
                        For Each r In b.c
                            Set RR = f.ComputeRule(r)
                            If RR.Compliant <> "OK" Then
                                If r.Lim_Ref = "VALUE" Then
                                    u2 = "V"
                                    m = 1
                                Else
                                    u2 = "P"
                                    m = 0.01
                                End If
                                ruls = ruls + ", " + r.Nome
                                ruls1 = ruls1 + "-->" + RR.Compliant + ":" + r.Nome + ":" + r.Extensa + "<--"
                                db.Execute ("INSERT INTO THISTCOMPBREACHES (DATA, FUNDO, TIPO, LIVRO, REGRA, REGRATEXTO, ALOCACAO, DELTA, ESCOPO, PAPEIS, VERSAO, TIPOLIMITE) VALUES (" + _
                                    SQLBaseDate + ", '" + _
                                    f.Nome + "', '" + RR.Compliant + "', '" + b.Nome + "', '" + r.Nome + "', '" + r.Extensa + "', " + Str(RR.MaxOut * m) + "," + Str(RR.DeltaOut) + ",'" + r.Escopo + "','" + RR.PapelDescr + "',3,'" + u2 + "')")
                            End If
                        Next r
                    End If
                    'Grava o arquivo de teste de compliance
                    db.Execute ("INSERT INTO THISTCOMPL (DATA, DATAINFO, FUNDO, LIVRO, RESULT, RULEBREACHES, DATAWRITE, FUNDSTATUS, RULEBREACHTEXT) VALUES (" + _
                     SQLBaseDate + "," + SQLD(f.Dt_LastInfo) + ", '" + _
                    f.Nome + "','" + b.Nome + "','" + u + "','" + ruls + "', '" + Format(Now(), "YYYY-MM-DD HH:MM:SS") + "', '" + f.CarteiraUpdateStatus + "', '" + ruls1 + "')")
                Next b
            Next f 'Próximo fundo
                
        'Grava Risco
            If Not frm Is Nothing Then frm.Say ("Gravando Resultado de Risco e Liquidez")
            db.Execute ("DELETE FROM THISTRISK WHERE DATARUN = " + SQLBaseDate)
            
            Dim vConexaoTemp As ADODB.Connection
            If (vConexaoTemp Is Nothing) Then
                Set vConexaoTemp = New ADODB.Connection
                vConnectionString = "Provider=SQLNCLI11;Server=Win10Dev;Database=db_capitania;Integrated Security=SSPI;DataTypeCompatibility=80"
                Call vConexaoTemp.open(vConnectionString)
            End If
            
            For Each f In Fundos.c
                DoEvents
                order = "INSERT INTO THISTRISK (DATAWRITE, DATARUN, DATAINFO, FUNDO, PL, VAR, VARQUOTA, STRESS, E_IMOB, E_INFL, E_PRE, E_DOLAR, CAIXA, DISP, "
                order = order + "LIQ_OK, LIQ_1, LIQ_5, LIQ_21, LIQ_42, LIQ_63, LIQ_126, LIQ_252, "
                order = order + "REQ_CASH_1, REQ_CASH_5, REQ_CASH_21, REQ_CASH_42, REQ_CASH_63, REQ_CASH_126, REQ_CASH_252, "
                order = order + "VERSION, FUNDTYPE, FUNDSTATUS, CRD_EL, CRD_VAR, CRD_EL1, CRD_VAR1, AREA, RISKMKTOK, RISKCRDOK, LIQSTRESSNEED, LIQSTRESSAVAIL, LIQSTRESSREQ,"
                order = order + "LIQSTRESSPERCENTILE, E_IDA, E_IMOIDIO) VALUES "
                
                
                order = order + "('" + Format(Now(), "YYYY-MM-DD HH:MM:SS") + "'" + _
                    ", " + SQLBaseDate + _
                    ", " + SQLD(f.Dt_LastPortfolio) + _
                    ", '" + f.Nome + "'" + _
                    ", " + Str(f.PLTotal) + _
                    ", " + Str(f.StaticVar) + _
                    ", " + Str(f.StaticVarQuota) + _
                    ", " + Str(f.StaticStress) + _
                    ", " + Str(f.StaticEImob) + _
                    ", " + Str(f.StaticEInfl) + _
                    ", " + Str(f.StaticEPre) + _
                    ", " + Str(f.StaticEDolar) + _
                    ", " + Str(f.PctCaixa) + _
                    ", " + Str(f.StaticDisp)
                    
                order = order + _
                    ", '" + f.LiquidityOK + "'" + _
                    ", " + Str(f.LiqCovAteh(BaseDate + 1)) + _
                    ", " + Str(f.LiqCovAteh(BaseDate + 7)) + _
                    ", " + Str(f.LiqCovAteh(BaseDate + 30)) + _
                    ", " + Str(f.LiqCovAteh(BaseDate + 60)) + _
                    ", " + Str(f.LiqCovAteh(BaseDate + 90)) + _
                    ", " + Str(f.LiqCovAteh(BaseDate + 182)) + _
                    ", " + Str(f.LiqCovAteh(BaseDate + 365))
                
                If f.LiquidityOK = "BREACH" Then
                    a1 = f.LiqNeededAteh(BaseDate + 1) - f.liquidityAteh(BaseDate + 1)
                    a7 = f.LiqNeededAteh(BaseDate + 7) - f.liquidityAteh(BaseDate + 7)
                    a30 = f.LiqNeededAteh(BaseDate + 30) - f.liquidityAteh(BaseDate + 30)
                    a60 = f.LiqNeededAteh(BaseDate + 60) - f.liquidityAteh(BaseDate + 60)
                    a90 = f.LiqNeededAteh(BaseDate + 90) - f.liquidityAteh(BaseDate + 90)
                    a182 = f.LiqNeededAteh(BaseDate + 182) - f.liquidityAteh(BaseDate + 182)
                    a365 = f.LiqNeededAteh(BaseDate + 365) - f.liquidityAteh(BaseDate + 365)
                Else
                    a1 = 0: a7 = 0: a30 = 0: a60 = 0: a90 = 0: a182 = 0: a365 = 0
                End If
                
                order = order + _
                    ", " + Str(a1) + _
                    ", " + Str(a7) + _
                    ", " + Str(a30) + _
                    ", " + Str(a60) + _
                    ", " + Str(a90) + _
                    ", " + Str(a182) + _
                    ", " + Str(a365)
                    
                order = order + ", 8" + _
                    ",'" + f.Tipo + "'" + _
                    ", '" + f.CarteiraUpdateStatus + "'" + _
                    ", " + Str(f.StaticEL) + _
                    ", " + Str(f.StaticUL) + _
                    ", " + Str(f.StaticEL1) + _
                    ", " + Str(f.StaticUL1) + _
                    ", '" + f.area + "'"
                    
                order = order + ",'" + f.IAmCompliantWithMarketRisk + "','" + f.IAmCompliantWithCreditRisk + "'"
                
                as1 = f.LiqNeededStressCVM
                as2 = f.liquidityAteh(BaseDate + f.PrazoResgate)
                as3 = max(0, as1 - as2)
                
                order = order + "," + Str(as1) + "," + Str(as2) + "," + Str(as3)
                
                order = order + "," + Str(f.LiqStressPercentile) + "," + Str(f.StaticEIDA) + "," + Str(f.StaticEIdio)
                
                
                order = order + ")"
                    
                db.Execute (order)
            Next f 'Próximo fundo (grava risco)
            
        'Grava Resultados de Stress
            If Not frm Is Nothing Then frm.Say ("Gravando Resultado de Stress")
            db.Execute ("DELETE FROM THISTSTRESS WHERE DATARUN = " + SQLBaseDate)
            For Each f In Fundos.c
                For Each h In Stress.ListaDeCenarios
                    DoEvents
                    If Not frm Is Nothing Then frm.Say ("Gravando Resultado de Stress  Fundo " & Trim(f.Nome) & "Cenario " & h.Nome)
                    v = Stress.ApplyToFund(h.Nome, f)
                    db.Execute ("INSERT INTO THISTSTRESS (DATARUN, FUNDO, CENARIO, STRESS, AREA) VALUES (" + _
                        SQLBaseDate + ",'" + f.Nome + "','" + h.Nome + "'," + Str(v) + ",'" + f.area + "')")
                Next h
                'Grava a provisao
            Next f 'Próximo fundo (Resultado de Stress)
            
        'Gava Concentração
            If Not frm Is Nothing Then frm.Say ("Gravando Resultado de Concentração")
            db.Execute ("DELETE FROM TCONCENTRA WHERE DATA = " + SQLBaseDate)
            
            For Each f In Fundos.c
                s = f.PLTotal
                DoEvents
                For i = 1 To 3
                    DoEvents
                    u = Config.ConcentrationP(i)
                    Set prop = Props.searchName(u)
                    If Not prop Is Nothing Then
                        px = Props.SearchIndex(prop.ID)
                        If px > 0 Then
                            Set c = f.MyConcentration(px)
                            For Each h In c
                                DoEvents
                                If s = 0 Then s1 = 0 Else s1 = h.Valor / s
                                If Not frm Is Nothing Then frm.Say ("Gravando Resultado de Concentração Fundo " & f.Nome & " Propriedade " & u)
                                db.Execute ("INSERT INTO TCONCENTRA (DATA, NOME, PROPRIEDADE, VALORPROP, CONCENTRACAO) VALUES " + _
                                "(" + SQLBaseDate + "," + _
                                "'" + f.Nome + "'," + _
                                "'" + u + "'," + _
                                "'" + h.Nome + "'," + _
                                Str(s1) + ")")
                            Next h
                        End If
                    End If
                Next i
            Next f 'próximo fundo (Concentração)
            
        
        td = (Now() - t0) * 24 * 3600
        WriteLogPerf "REPORT_COMP", 1, td
        
    End If 'LIVE
End Sub

Public Sub Report_PreTrade(Optional ActionBy As String = "SYSTEM")
    Dim f As CFundo, db As ADODB.Connection, stt As String, u As CPreTradeCompItem
    Dim td As CTrade, ReportTime As String, achou As Boolean, ti As Double
    Dim FrontString As String, St_Status As String, St_Obs As String, St_ok As String
    
    
    Set db = OpenTheDatabase(True)
    ReportTime = SQLTimeStamp()
    t0 = Now()
    
    '---Reporta para TPTC
        For Each f In Fundos.c
            If f.area = "ASSET" Then
                If Not f.PTCExecuted Then f.PreTradeCompliance
                Select Case f.PTCResult
                    Case 0
                        stt = "OK"
                    Case 1
                        stt = "RESOLVEU"
                    Case 2
                        stt = "PIOROU"
                    Case 3
                        stt = "BREACH"
                End Select
                db.Execute ("INSERT INTO TPTC (DATA, DATARUN, FUNDO, RESULT, TRADES) VALUES (" + SQLBaseDate + "," + ReportTime + ",'" + f.Nome + "','" + stt + "'," + Str(f.PTCNTrades) + ")")
            
            End If
        Next f
    
    '---Reporta para TPTCDETAIL
        
        For Each td In Trades.CTodayTrades
            'Reporta os não endereçados
            achou = False
            FrontString = "INSERT INTO TPTCDETAIL (DATARUN, DATA, ACTIONBY, TRADEKEY, FUNDO, ADDR, STATUS, OBS, OK) VALUES (" + _
                ReportTime + "," + SQLBaseDate + ",'" + ActionBy + "','" + td.TradeKey + "','" + td.Fundo + "','" + td.Addr + "',"
            
            If td.Addr <> "OK" Then
                db.Execute (FrontString + "'NAO ENDERECADO','NAO ENDERECADO',FALSE)")
            ElseIf td.MyFund Is Nothing Then
                db.Execute (FrontString + "'FALTA FUNDO','FALTA FUNDO',FALSE)")
            Else
                'o trade foi endereçado e tem fundo. Procurar o PTC do fundo
                St_ok = "TRUE"
                St_Obs = ""
                St_Status = "OK"
                achou = False
                
                For Each u In td.MyFund.PTCNodes
                    'PTCNodes pode conter mais de um nó por trade
                    If u.MyTrade Is td Then
                        If u.Result > 1 Then
                            St_Obs = St_Obs + u.regra.Nome + " "
                            St_ok = "FALSE"
                            If u.Result = 3 Then
                                St_Status = "VIOLOU"
                            ElseIf u.Result = 2 And St_Status <> "VIOLOU" Then
                                St_Status = "PIOROU"
                            End If
                        End If
                        achou = True
                    End If
                Next u
                If achou _
                    Then db.Execute (FrontString + "'" + St_Status + "','" + St_Obs + "'," + St_ok + ")") _
                    Else db.Execute (FrontString + "'NAO ACHOU TRADE NO FUNDO','NAO ACHOU TRADE NO FUNDO',FALSE)")
            End If
        Next td
    
    ti = (Now() - t0) * 24 * 3600
    WriteLogPerf "REPORT_PTC", 1, ti
End Sub


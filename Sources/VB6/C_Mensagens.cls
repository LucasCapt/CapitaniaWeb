VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "C_Mensagens"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'
'                                                  B  L  O  C  O  S
'
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

'---------------------------------------------------------------------------------------------------------
'                                         Lista de Contrapartes de Alto Risco
'---------------------------------------------------------------------------------------------------------
Private Function SubCtptAlto() As String
    Dim db As ADODB.Connection, rs As ADODB.Recordset, m As String
    
    Set db = OpenTheDatabase

    m = "CONTRAPARTES COM RISCO DE COMPLIANCE ALTO" + vbCr + FitString("Contraparte", 24, "L") + FitString("Razão Social", 24, "L") + FitString("Atualização", 12) + vbCr
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM TCTPT WHERE PERFILRISCO='ALTO'", db, adOpenForwardOnly, adLockReadOnly)
    While Not rs.EOF
        m = m + FitString(rs("NOME"), 24, "L") + FitString(rs("RAZAOSOCIAL"), 24, "L") + FitString(rs("ATUALIZADO"), 12) + vbCr
        rs.MoveNext
    Wend
    
    
    SubCtptAlto = m
End Function



'---------------------------------------------------------------------------------------------------------
'                                                 Lista de Maiores Alocações
'---------------------------------------------------------------------------------------------------------
Private Function SubMaiores() As String
    'Não usa o Database; reporta a partir do estado interno
    Dim m As String, x As CPapel, days2 As String, days3 As String, days4 As String
    m = "MAIORES ALOCAÇÕES" + vbCr + FitString("Nome", 24, "L") + " " + FitString("Código", 8, "L") + " " + FitString("Posição", 12) + " " + _
        FitString("Dias Liq", 12) + FitString("Dias Grp", 12) + FitString("Dias Cnd", 12) + vbCr
    For Each x In Papeis.Maiores(20)
        If x.adtv > 0 _
            Then days2 = Format(x.PosicTotalV / x.adtv / 0.2, "##0") _
            Else days2 = "n.a."
        If x.adtvClasse > 0 _
            Then days3 = Format(x.PosicTotalV / x.adtvClasse / 0.2, "##0") _
            Else days3 = "n.a."
        If x.adtvClasseCond > 0 _
            Then days4 = Format(x.PosicTotalV / x.adtvClasseCond / 0.2, "##0") _
            Else days4 = "n.a."
            
        m = m + FitString(x.nome, 24, "L") + " " + _
                FitString(x.CodCetip, 8, "L") + " " + _
                FitString(FNumkMM(x.PosicTotalV), 12) + " " + _
                FitString(days2, 12) + _
                FitString(days3, 12) + _
                FitString(days4, 12) + vbCr
    Next x
    
    SubMaiores = m
End Function



'---------------------------------------------------------------------------------------------------------
'                                                 Lista de Limites
'---------------------------------------------------------------------------------------------------------
Private Function SubLim() As String
    'Não usa o Database; reporta a partir do estado interno
    Dim m As String, f As CFundo, b As CBook, r As CRegra, RR As CRuleResult
    
    Set f = Fundos.search(Config.ConcentrationFundID)
    If f Is Nothing Then saux = "?" Else saux = f.nome
    m = "LIMITES DE CRÉDITO EM " + saux + ":" + vbCr + FitString("Regra", 24, "L") + FitString("Limite", 12) + FitString("Posição", 12) + FitString("Delta", 12) + "Compliant?" + vbCr
    
    For Each b In f.MyBooks
        For Each r In b.c
            If r.Escopo = "LIM" Then
                Set RR = f.ComputeRule(r)
                m = m + FitString(r.nome, 24, "L") + FitString(Format(r.Limite / 1000000#, "##0.0"), 12) + FitString(Format(RR.MaxOut / 1000000#, "##0.0"), 12) + FitString(Format((r.Limite - plsob) / 1000000#, "##0.0"), 12) + "     " + f.IAmCompliantWithRule(r, "LIM") + vbCr
            End If
        Next r
    Next b
    
    SubLim = m
End Function


'---------------------------------------------------------------------------------------------------------
'                                                 Pre Trade Compliance
'---------------------------------------------------------------------------------------------------------
Private Function SubPTC() As String
    'Não usa o Database; reporta a partir do estado interno
    Dim m As String, f As CFundo, u As CPreTradeCompItem, db As ADODB.Connection, rs As ADODB.Recordset, mxd As Date, N As Integer
    Dim t0 As Date, td As Double
    
    t0 = Now()
    
    m = vbCr + vbCr + "== Pré-Trade Compliance ==" + vbCr + vbCr
    
    '---- Reporta trades não endereçados
        N = 0
        Set db = OpenTheDatabase
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT MAX(DATARUN) AS MAXDATE FROM THISTTRADEERRS WHERE DATARUN>" + SQLD(Now() - 1), db, adOpenForwardOnly, adLockReadOnly)
            If Not rs.EOF Then
                If Not IsNull(rs("MAXDATE")) Then
                    mxd = rs("MAXDATE")
                    Set rs = New ADODB.Recordset
                    Call rs.open("SELECT * FROM THISTTRADEERRS WHERE DATARUN=" + SQLLongTime(mxd) + " AND ADDR<>'OK'", db, adOpenForwardOnly, adLockReadOnly)
                    If rs.EOF Then
                        m = m + vbCr + "0 erros de endereçamento" + vbCr
                    Else
                        m = m + vbCr + "ATENÇÃO: HÁ ERROS DE ENDEREÇAMENTO NOS TRADES" + vbCr + "RESULTADOS NÃO SÃO CONFIÁVEIS" + vbCr + "FAVOR CORRIGIR OS ERROS." + vbCr
                        While Not rs.EOF
                            m = m + Format(mxd, "dd-MMM-yyyy HH:MM") + " erro=" + rs("ADDR") + ", Trade=" + rs("EXTENSO") + vbCr
                            rs.MoveNext
                            N = N + 1
                        Wend
                    End If
                End If
            End If
        m = m + Str(N) + " erros de endereçamento de trades (falta fundo ou papel)" + vbCr + vbCr
    
    '---- Faz por Fundo (apenas trades corretamente endereçados)
        For Each f In Fundos.c
            If f.area = "ASSET" Then
                If Not f.PTCExecuted Then f.PreTradeCompliance
                m = m + vbCr + FitString(f.nome, 24, "L") + " (" + Format(f.PTCNTrades, "000") + " trades) "
                If f.PTCResult < 2 Or f.PTCNTrades = 0 Then
                    m = m + "OK"
                Else
                    m = m + "Não OK" + vbCr
                    For Each u In f.PTCNodes
                        If u.Result > 1 Then
                            If Not u.MyTrade Is Nothing And Not u.regra Is Nothing Then
                                m = m + vbCr + Space(38) + u.MyTrade.Extenso + vbCr + _
                                                    Space(38) + u.regra.nome + vbCr + _
                                                    Space(38) + u.regra.LimiteExtenso + "  (" + FormatLimit(u.PLSubA, u.regra) + " -> " + FormatLimit(u.PLSubB, u.regra) + ")" + "  {" + FNumkMM(u.DeltaA) + " -> " + FNumkMM(u.DeltaB) + "}" + vbCr
                            Else
                                m = m + Space(38) + "?" + vbCr
                            End If
                        End If
                    Next u
                End If
            End If
        Next f
    
    'Acrescenta o AML
    ComReporter.Report_AML
    
    SubPTC = m + vbCr + vbCr + subAML
    
    
    td = (Now() - t0) * 24 * 3600
    WriteLogPerf "MSG_PTC", 1, td
End Function

'---------------------------------------------------------------------------------------------------------
'                                                 E R R O S
'---------------------------------------------------------------------------------------------------------
Private Function SubErrors() As String
    Dim db As ADODB.Connection, rs As ADODB.Recordset, m As String
    m = ""
    
    Set db = OpenTheDatabase
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM TLOGERRO WHERE DATAHORA>=" + SQLD(TimeInit), db, adOpenForwardOnly, adLockReadOnly)
    While Not rs.EOF
        m = m + vbCr + Format(rs("DATAHORA"), "DD/MM/YYYY HH:MM:SS") + " " + FitString(rs("MSGERRO"), 45, "L") + FitString(rs("ITEM"), 35, "L")
        rs.MoveNext
    Wend
    SubErrors = m
End Function

'---------------------------------------------------------------------------------------------------------
'                                                 R I S C O
'---------------------------------------------------------------------------------------------------------
Private Function SubRisk(area As String, qual As String) As String
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, m As String, h1 As String, h2 As String, hh As String
    m = "AREA: " + area + vbCr
    Select Case qual
        Case "CTRL"
            m = m + "FUNDO                     SIZE         DISPD0  CAIXA   VAR  VARQUOT  STRESS  MKTRISK  EL.ext  DATA    "
        Case "GER1"
            m = m + "FUNDO                     SIZE         CAIXA   VAR   STRESS   C." + ConsonantsTo(Config.ConcentrationProp1, 6) + "C." + ConsonantsTo(Config.ConcentrationProp2, 6) + "  EL.int  UL.int  DATA    "
    End Select
    
    
    Set db = OpenTheDatabase
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM THISTRISK WHERE DATARUN = " + SQLBaseDate + " AND AREA='" + area + "' ORDER BY VAR DESC", db, adOpenForwardOnly, adLockReadOnly)
    While Not rs.EOF
        If rs("FUNDSTATUS") <> "INV" Then
            Select Case qual
            Case "GER1"
                hh = " AND VALORPROP<>'Tesouro' AND VALORPROP<>'BNY Mellon' AND VALORPROP<>'BNYMellon' AND VALORPROP<>'Caixa'"
                Set rs1 = New ADODB.Recordset
                Call rs1.open("SELECT MAX(CONCENTRACAO) AS MAXCONC FROM TCONCENTRA WHERE NOME='" + rs("FUNDO") + "' AND DATA=" + SQLBaseDate + " AND PROPRIEDADE='" + Config.ConcentrationProp1 + "' " + hh, db, adOpenForwardOnly, adLockReadOnly)
                If Not rs1.EOF Then h1 = Format(CritNN(rs1("MAXCONC")), "##0%") Else h1 = "-"
                Set rs1 = New ADODB.Recordset
                Call rs1.open("SELECT MAX(CONCENTRACAO) AS MAXCONC FROM TCONCENTRA WHERE NOME='" + rs("FUNDO") + "' AND DATA=" + SQLBaseDate + " AND PROPRIEDADE='" + Config.ConcentrationProp2 + "' " + hh, db, adOpenForwardOnly, adLockReadOnly)
                If Not rs1.EOF Then h2 = Format(CritNN(rs1("MAXCONC")), "##0%") Else h2 = "-"
                m = m + vbCr + _
                      FitString(rs("FUNDO"), 20, "L") + _
                      FitString(Format(rs("PL"), "###,###,###"), 16) + _
                      FitString(Format(rs("CAIXA"), "##0%"), 8) + _
                      FitString(Format(rs("VAR"), "#0.00%"), 8) + _
                      FitString(Format(rs("STRESS"), "#0.00%"), 8) + _
                      FitString(h1, 8) + _
                      FitString(h2, 8) + _
                      FitString(Format(CritNN(rs("crd_el1")), "##0.00%"), 8) + _
                      FitString(Format(CritNN(rs("crd_var1")), "##0.00%"), 8) + _
                      FitString(Format(rs("DATAINFO"), "dd-MMM"), 8)
            Case "CTRL"
                m = m + vbCr + _
                      FitString(rs("FUNDO"), 20, "L") + _
                      FitString(Format(rs("PL"), "###,###,###"), 16) + _
                      FitString(Format(rs("DISP") / 1000000#, "##0"), 8) + _
                      FitString(Format(rs("CAIXA"), "##0%"), 8) + _
                      FitString(Format(rs("VAR"), "#0.00%"), 8) + _
                      FitString(Format(rs("VARQUOTA"), "#0.00%"), 8) + _
                      FitString(Format(rs("STRESS"), "#0.00%"), 8) + _
                      FitString(CritS(rs("RISKMKTOK")), 8, "C") + _
                      FitString(Format(CritNN(rs("crd_el")), "##0.00%"), 8) + _
                      FitString(Format(rs("DATAINFO"), "dd-MMM"), 8)
            End Select
        Else
            m = m + vbCr + FitString(rs("FUNDO"), 20, "L") + "DADOS INVALIDOS"
        End If
        rs.MoveNext
    Wend
    m = m + vbCr + "VAR diario a 99%; Credit-VaR (UL) anual a 90%" + vbCr
    SubRisk = m
End Function

'---------------------------------------------------------------------------------------------------------
'                                            L I Q U I D E Z
'---------------------------------------------------------------------------------------------------------
Private Function SubLiquidity() As String
    Dim db As ADODB.Connection, rs As ADODB.Recordset, m As String
    m1 = "": m2 = ""
    
    Set db = OpenTheDatabase
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM THISTRISK WHERE DATARUN = " + SQLBaseDate + " ORDER BY VAR DESC", db, adOpenForwardOnly, adLockReadOnly)
    While Not rs.EOF
        If Fundos.TypeReportsLiquidity(rs("FUNDTYPE"), rs("AREA")) Then
            If rs("FUNDSTATUS") <> "INV" Then
                m1 = m1 + vbCr + FitString(rs("FUNDO"), 24, "L") + _
                          FitString(rs("LIQ_OK"), 6, "L") + _
                          FitString(Format(rs("LIQ_1"), "##0%"), 8) + _
                          FitString(Format(rs("LIQ_5"), "##0%"), 8) + _
                          FitString(Format(rs("LIQ_21"), "##0%"), 8) + _
                          FitString(Format(rs("LIQ_42"), "##0%"), 8) + _
                          FitString(Format(rs("LIQ_63"), "##0%"), 8) + _
                          FitString(Format(rs("LIQ_126"), "##0%"), 8) + _
                          FitString(Format(rs("LIQ_252"), "##0%"), 8)
                
                If rs("LIQ_OK") = "BREACH" Then
                    m2 = m2 + vbCr + FitString(rs("FUNDO"), 24, "L") + _
                          FitString(rs("LIQ_OK"), 6, "L") + _
                          FitString(Format(max(0, rs("REQ_CASH_1") / 1000000#), "##0"), 8) + _
                          FitString(Format(max(0, rs("REQ_CASH_5") / 1000000#), "##0"), 8) + _
                          FitString(Format(max(0, rs("REQ_CASH_21") / 1000000#), "##0"), 8) + _
                          FitString(Format(max(0, rs("REQ_CASH_42") / 1000000#), "##0"), 8) + _
                          FitString(Format(max(0, rs("REQ_CASH_63") / 1000000#), "##0"), 8) + _
                          FitString(Format(max(0, rs("REQ_CASH_126") / 1000000#), "##0"), 8) + _
                          FitString(Format(max(0, rs("REQ_CASH_252") / 1000000#), "##0"), 8)
                End If
            Else
                m1 = m1 + vbCr + Left(rs("FUNDO") + Space(24), 24) + "DADOS INVALIDOS"
            End If
        End If
        rs.MoveNext
    Wend
    m = "ENQUADRAMENTO DE LIQUIDEZ" + vbCr + _
        "FUNDO                   COMP?      1d      5d      21d     42d     63d    126d    252d  " + m1
        
    If m2 > "" Then
        m = m + vbCr + vbCr + "NECESSIDADE DE CAIXA (MM)" + vbCr + _
        "FUNDO                   COMP?      1d      5d      21d     42d     63d    126d    252d  " + m2
    End If

    SubLiquidity = m
End Function

'---------------------------------------------------------------------------------------------------------
'                                           C A S H    R E P O R T
'---------------------------------------------------------------------------------------------------------
Private Function subCashReport() As String
    Dim db As ADODB.Connection, rs As ADODB.Recordset, m As String
    m = "CASH REPORT (Fundos Selecionados)" + vbCr + _
    "FUNDO                      DISP MM  CASH MM  %CASH    Free MM  %Free    3mLiq    3mReq    3mCASHFree  "
    
    Set db = OpenTheDatabase
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM TCASHREPORTHIST WHERE DATA=" + SQLBaseDate, db, adOpenForwardOnly, adLockReadOnly)
    t1 = 0
    t2 = 0
    While Not rs.EOF
        m = m + vbCr + FitString(rs("FUNDO"), 24, "L") + _
                   FitString(Format(CritNN(rs("DISPO")) / 1000000#, "##0.0"), 9) + _
                   FitString(Format(CritNN(rs("CASH")) / 1000000#, "##0.0"), 9) + _
                   FitString(Format(CritNN(rs("PCASH")), "#0.0%"), 9) + _
                   FitString(Format(CritNN(rs("CASHFREE")) / 1000000#, "##0.0"), 9) + _
                   FitString(Format(CritNN(rs("PCASHFREE")), "#0.0%"), 9) + _
                   FitString(Format(CritNN(rs("LIQ3M")) / 1000000#, "##0.0"), 9) + _
                   FitString(Format(CritNN(rs("REQ3M")) / 1000000#, "##0.0"), 9) + _
                   FitString(Format(CritNN(rs("CASHFREE3M")) / 1000000#, "##0.0"), 9)
        t1 = t1 + CritNN(rs("CASHFREE"))
        t2 = t2 + CritNN(rs("CASHFREE3M"))
        rs.MoveNext
    Wend
    m = m + vbCr + "TOTAL" + Space(45) + FitString(Format(t1 / 1000000#, "##0.0"), 10) + Space(26) + FitString(Format(t2 / 1000000#, "##0.0"), 10)

    subCashReport = m
End Function


'---------------------------------------------------------------------------------------------------------
'                                    S T R E S S    D E    L I Q U I D E Z
'---------------------------------------------------------------------------------------------------------
Private Function subLiqStress(qual As String) As String
    Dim db As ADODB.Connection, rs As ADODB.Recordset, m As String
    m = "STRESS DE LIQUIDEZ" + vbCr + _
    "FUNDO                        Saque Stress   Liq Dispo.   Liq Req.     Percentile"
    
    Set db = OpenTheDatabase
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM THISTRISK WHERE DATARUN = " + SQLBaseDate + " ORDER BY FUNDO", db, adOpenForwardOnly, adLockReadOnly)
    While Not rs.EOF
        If Fundos.TypeReportsLiquidity(rs("FUNDTYPE"), rs("AREA")) Then
            m = m + vbCr + FitString(rs("Fundo"), 24, "L") + _
                    FitString(Format(CritNN(rs("LIQSTRESSNEED")) / 1000000#, "##0.0"), 12) + _
                    FitString(Format(CritNN(rs("LIQSTRESSavail")) / 1000000#, "##0.0"), 13) + _
                    FitString(Format(CritNN(rs("LIQSTRESSREQ")) / 1000000#, "##0.0"), 13) + _
                    FitString(FormatLiqSt(CritNN(rs("LIQSTRESSPERCENTILE"))), 13)
        End If
        rs.MoveNext
    Wend
    rs.Close
    subLiqStress = m
End Function




'---------------------------------------------------------------------------------------------------------
'                                         E N Q U A D R A M E N T O
'---------------------------------------------------------------------------------------------------------
Private Function subCompliance(qual As String) As String
    Dim db As ADODB.Connection, rs As ADODB.Recordset, m As String, m1 As String, m2 As String, m3 As String, m4 As String, fml As String
    Dim n1 As Integer, n2 As Integer, n3 As Integer, n4 As Integer
    m = ""
    m1 = "": m2 = "": m3 = "": m4 = ""
    
    Set db = OpenTheDatabase
    n1 = 0: n2 = 0: n3 = 0: n4 = 0
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM THISTCOMPBREACHES WHERE DATA=" + SQLBaseDate, db, adOpenForwardOnly, adLockReadOnly)
        While Not rs.EOF
            If rs("TIPOLIMITE") = "V" Then
                fml = FNumkMM(rs("ALOCACAO"))
            Else
                fml = Format(rs("ALOCACAO"), "##0.00%")
            End If
            m0 = vbCr + WrapText(100, 50, FitString(rs("FUNDO"), 24, "L") + _
                FitString(rs("REGRA"), 24, "L") + " " + _
                Right("     (" + fml + ")", 9) + " " + _
                rs("REGRATEXTO") + "; papeis: " + _
                ClipNames(CritS(rs("PAPEIS")), 50)) + vbCr + String(100, "-") + vbCr
            If rs("TIPO") = "BREACH" And rs("ESCOPO") = "CTRL" Then
                n1 = n1 + 1
                m1 = m1 + Str(n1) + ")" + m0
            ElseIf rs("TIPO") = "WARN" And rs("ESCOPO") = "CTRL" Then
                n2 = n2 + 1
                m2 = m2 + Str(n2) + ")" + m0
            ElseIf rs("TIPO") = "BREACH" And rs("ESCOPO") = "GER" Then
                n3 = n3 + 1
                m3 = m3 + Str(n3) + ")" + m0
            ElseIf rs("TIPO") = "WARN" And rs("ESCOPO") = "GER" Then
                n4 = n4 + 1
                m4 = m4 + Str(n4) + ")" + m0
            Else
                'Só pode ser Breach ou Warn de Limite
                n5 = n5 + 1
                m5 = m5 + Str(n5) + ")" + m0
            End If
        rs.MoveNext
    Wend

    Select Case qual
        Case "CTRL"
            If m1 = "" Then m1 = vbCr + "NÃO HÁ VIOLAÇÕES DE ENQUADRAMENTO (BREACHES)" Else m1 = m1 + vbCr + "Favor enquadrar ou justificar."
            m = m + vbCr + vbCr + "ATENÇÃO! " + Str(n1) + " VIOLAÇÕES DE ENQUADRAMENTO (BREACHES):" + vbCr + m1
            If m2 = "" Then m2 = " não há warnings"
            m = m + vbCr + vbCr + "SINAL AMARELO DE ENQUADRAMENTO (" + Str(n2) + " WARNINGS):" + m2
        Case "GER1"
            If m3 = "" Then m3 = " não há violações"
            m = m + vbCr + vbCr + Str(n3) + " INDICADORES INTERNOS GERENCIAIS EM ESTADO 'VERMELHO':" + m3
            If m4 = "" Then m4 = " não há warnings"
            m = m + vbCr + vbCr + Str(n4) + " INDICADORES INTERNOS GERENCIAIS EM ESTADO 'AMARELO':" + m4
        Case "LIM"
            If m5 = "" Then m5 = " não há violações ou warnings de Limites gerenciais"
            m = m + vbCr + vbCr + Str(n5) + " violações ou warnings de limites gerenciais:" + m5
    End Select
    subCompliance = m
End Function

'---------------------------------------------------------------------------------------------------------
'                                         C O N C E N T R A C A O
'---------------------------------------------------------------------------------------------------------
Private Function SubConcentra() As String
    Dim db As ADODB.Connection, rs1 As ADODB.Recordset, rs2 As ADODB.Recordset, rs3 As ADODB.Recordset, m As String, f As CFundo, saux As String

    Set f = Fundos.search(Config.ConcentrationFundID)
    If f Is Nothing Then saux = "?" Else saux = f.nome
    m = "CONCENTRACAO EM " + saux + ":" + vbCr + _
        FitString(Config.ConcentrationProp1, 24, "L") + FitString(Config.ConcentrationProp2, 24, "L") + FitString(Config.ConcentrationProp3, 24, "L")
        
    
    Set db = OpenTheDatabase
    Set rs1 = New ADODB.Recordset
    Call rs1.open("SELECT * FROM TCONCENTRA WHERE DATA=" + SQLBaseDate + " AND NOME='" + saux + "' AND PROPRIEDADE = '" + Config.ConcentrationProp1 + "' ORDER BY CONCENTRACAO DESC", db, adOpenForwardOnly, adLockReadOnly)
    Set rs2 = New ADODB.Recordset
    Call rs2.open("SELECT * FROM TCONCENTRA WHERE DATA=" + SQLBaseDate + " AND NOME='" + saux + "' AND PROPRIEDADE = '" + Config.ConcentrationProp2 + "' ORDER BY CONCENTRACAO DESC", db, adOpenForwardOnly, adLockReadOnly)
    Set rs3 = New ADODB.Recordset
    Call rs3.open("SELECT * FROM TCONCENTRA WHERE DATA=" + SQLBaseDate + " AND NOME='" + saux + "' AND PROPRIEDADE = '" + Config.ConcentrationProp3 + "' ORDER BY CONCENTRACAO DESC", db, adOpenForwardOnly, adLockReadOnly)
    
    While (Not rs1.EOF) Or (Not rs2.EOF) Or (Not rs3.EOF)
        m = m + vbCr
        If Not rs1.EOF Then
            m = m + FitString(rs1("VALORPROP"), 16, "L") + FitString(Format(rs1("CONCENTRACAO"), "##0.0%"), 6) + "  "
            rs1.MoveNext
        Else
            m = m + Space(24)
        End If
        
        If Not rs2.EOF Then
            m = m + FitString(rs2("VALORPROP"), 16, "L") + FitString(Format(rs2("CONCENTRACAO"), "##0.0%"), 6) + "  "
            rs2.MoveNext
        Else
            m = m + Space(24)
        End If
        
        If Not rs3.EOF Then
            m = m + FitString(rs3("VALORPROP"), 16, "L") + FitString(Format(rs3("CONCENTRACAO"), "##0.0%"), 6) + "  "
            rs3.MoveNext
        Else
            m = m + Space(24)
        End If
    Wend
    SubConcentra = m
End Function


'---------------------------------------------------------------------------------------------------------
'                                                   A  M  L
'---------------------------------------------------------------------------------------------------------
Private Function subAML() As String
    Dim db As ADODB.Connection, rs1 As ADODB.Recordset, rs2 As ADODB.Recordset, m As String
    
    Set db = OpenTheDatabase
    m = "AML NOS TRADES em " + Format(BaseDate, "dd-MMM-yyyy")
    Set rs1 = New ADODB.Recordset
    Call rs1.open("SELECT COUNT(1) AS NORMS FROM THistAML WHERE DATA=" + SQLBaseDate + " AND COMPLIANT='OK'", db, adOpenForwardOnly, adLockReadOnly)
    Set rs2 = New ADODB.Recordset
    Call rs2.open("SELECT COUNT(1) AS TOTAIS FROM THistAML WHERE DATA=" + SQLBaseDate, db, adOpenForwardOnly, adLockReadOnly)
    If Not rs1.EOF Then m = m + vbCr + Str(rs1("NORMS")) + " trades normais/" + Str(rs2("TOTAIS")) + " trades totais"
    
    Set rs1 = New ADODB.Recordset
    Call rs1.open("SELECT * FROM THistAML WHERE DATA=" + SQLBaseDate + " AND COMPLIANT<>'OK'", db, adOpenForwardOnly, adLockReadOnly)
    If Not rs1.EOF Then rs1.MoveFirst
    While Not rs1.EOF
        m = m + vbCr + rs1("COMPLIANT") + " Fundo:" + rs1("Fundo") + " Ativo:" + rs1("Ativo") + " " + rs1("COMENT")
        rs1.MoveNext
    Wend
    subAML = m
End Function


'---------------------------------------------------------------------------------------------------------
'                                                 R A T E I O
'---------------------------------------------------------------------------------------------------------
Private Function subRateio() As String
    Dim db As ADODB.Connection, rs1 As ADODB.Recordset, rs2 As ADODB.Recordset, m As String
    
    Set db = OpenTheDatabase
    m = "Conformidade da Divisão e Alocação de ordens em " + Format(BaseDate, "dd-MMM-yyyy")
    Set rs1 = New ADODB.Recordset
    Call rs1.open("SELECT COUNT(1) AS NORMS FROM THistAlloc WHERE DATA=" + SQLBaseDate + " AND (COMPLIANT='OK' OR COMPLIANT = '(OK)')", db, adOpenForwardOnly, adLockReadOnly)
    Set rs2 = New ADODB.Recordset
    Call rs2.open("SELECT COUNT(1) AS TOTAIS FROM THistAlloc WHERE DATA=" + SQLBaseDate, db, adOpenForwardOnly, adLockReadOnly)
    If Not rs1.EOF Then m = m + vbCr + Str(rs1("NORMS")) + " alocações conformes/" + Str(rs2("TOTAIS")) + " alocações totais"
    Set rs1 = New ADODB.Recordset
    Call rs1.open("SELECT * FROM THistAlloc WHERE DATA=" + SQLBaseDate + " AND COMPLIANT<>'OK' AND COMPLIANT <> '(OK)'", db, adOpenForwardOnly, adLockReadOnly)
    If Not rs1.EOF Then rs1.MoveFirst
    While Not rs1.EOF
        m = m + vbCr + rs1("COMPLIANT") + " Fundo:" + rs1("Fundo") + " Ativo:" + rs1("Ativo") + " " + Str(rs1("PUFUNDO")) + " x " + Str(rs1("PUGERAL"))
        rs1.MoveNext
    Wend

    subRateio = m
End Function

'---------------------------------------------------------------------------------------------------------
'                                                S T R E S S
'---------------------------------------------------------------------------------------------------------
Private Function ArrayNulo() As Variant
    Dim a(5, 1) As Variant
    a(0, 1) = 0
    a(1, 1) = Chr(255)
    a(2, 1) = ""
    a(3, 1) = 0
    a(4, 1) = ""
    ArrayNulo = a
End Function

Private Function subStress() As String
    Dim db As ADODB.Connection, rs1 As ADODB.Recordset, rs2 As ADODB.Recordset, m As String
    Dim a1 As Variant, a2 As Variant, a3 As Variant, a4 As Variant, a5 As Variant
    Dim i1 As Integer, i2 As Integer, i3 As Integer, i4 As Integer, i5 As Variant, FundoDaVez As String
    Dim LC As Integer 'largura da coluna
    Dim t0 As Date, td As Double, N As Integer
    Dim rs As ADODB.Recordset
    
    t0 = Now()
    N = 0
    LC = 14
    
    Set db = OpenTheDatabase
    
    m = "CENÁRIOS DE STRESS"
    m = m + vbCr + FitString("FUNDO", 24, "L") + FitString(Config.RStress1, LC, "R") + FitString(Config.RStress2, LC, "R") + _
                 FitString(Config.RStress3, LC, "R") + FitString(Config.RStress4, LC, "R") + FitString(Config.RStress5, LC, "R") + vbCr
           
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM THISTSTRESS WHERE DATARUN=" + SQLBaseDate + " AND AREA='ASSET' AND CENARIO='" + Config.RStress1 + "' ORDER BY FUNDO", db, adOpenKeyset, adLockReadOnly)
    If rs.RecordCount > 0 Then a1 = rs.GetRows(rs.RecordCount) Else a1 = ArrayNulo
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM THISTSTRESS WHERE DATARUN=" + SQLBaseDate + " AND AREA='ASSET' AND CENARIO='" + Config.RStress2 + "' ORDER BY FUNDO", db, adOpenKeyset, adLockReadOnly)
    If rs.RecordCount > 0 Then a2 = rs.GetRows(rs.RecordCount) Else a2 = ArrayNulo
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM THISTSTRESS WHERE DATARUN=" + SQLBaseDate + " AND AREA='ASSET' AND CENARIO='" + Config.RStress3 + "' ORDER BY FUNDO", db, adOpenKeyset, adLockReadOnly)
    If rs.RecordCount > 0 Then a3 = rs.GetRows(rs.RecordCount) Else a3 = ArrayNulo
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM THISTSTRESS WHERE DATARUN=" + SQLBaseDate + " AND AREA='ASSET' AND CENARIO='" + Config.RStress4 + "' ORDER BY FUNDO", db, adOpenKeyset, adLockReadOnly)
    If rs.RecordCount > 0 Then a4 = rs.GetRows(rs.RecordCount) Else a4 = ArrayNulo
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM THISTSTRESS WHERE DATARUN=" + SQLBaseDate + " AND AREA='ASSET' AND CENARIO='" + Config.RStress5 + "' ORDER BY FUNDO", db, adOpenKeyset, adLockReadOnly)
    If rs.RecordCount > 0 Then a5 = rs.GetRows(rs.RecordCount) Else a5 = ArrayNulo
    i1 = 1: i2 = 1: i3 = 1: i4 = 1: i5 = 1
    
    While i1 < UBound(a1, 2) Or i2 < UBound(a2, 2) Or i3 < UBound(a3, 2) Or i4 < UBound(a4, 2) Or i5 < UBound(a5, 2)
    
        If i1 <= UBound(a1, 2) Then FundoDaVez = a1(1, i1) Else FundoDaVez = Chr(255)
        If i2 <= UBound(a2, 2) Then FundoDaVez = min(a2(1, i2), FundoDaVez)
        If i3 <= UBound(a3, 2) Then FundoDaVez = min(a3(1, i3), FundoDaVez)
        If i4 <= UBound(a4, 2) Then FundoDaVez = min(a4(1, i4), FundoDaVez)
        If i5 <= UBound(a5, 2) Then FundoDaVez = min(a5(1, i5), FundoDaVez)
    
        m = m + FitString(FundoDaVez, 24, "L")
        
        If i1 < UBound(a1, 2) Then
            If a1(1, i1) = FundoDaVez Then
                m = m + FitString(Format(a1(3, i1), "##0.00%"), LC, "R")
                i1 = i1 + 1
            Else
                m = m + Space(LC)
            End If
        Else
            m = m + Space(LC)
        End If
        If i2 < UBound(a2, 2) Then
            If a2(1, i2) = FundoDaVez Then
                m = m + FitString(Format(a2(3, i2), "##0.00%"), LC, "R")
                i2 = i2 + 1
            Else
                m = m + Space(LC)
            End If
        Else
            m = m + Space(LC)
        End If
        If i3 < UBound(a3, 2) Then
            If a3(1, i3) = FundoDaVez Then
                m = m + FitString(Format(a3(3, i3), "##0.00%"), LC, "R")
                i3 = i3 + 1
            Else
                m = m + Space(LC)
            End If
        Else
            m = m + Space(LC)
        End If
        If i4 < UBound(a4, 2) Then
            If a4(1, i4) = FundoDaVez Then
                m = m + FitString(Format(a4(3, i4), "##0.00%"), LC, "R")
                i4 = i4 + 1
            Else
                m = m + Space(LC)
            End If
        Else
            m = m + Space(LC)
        End If
        If i5 < UBound(a5, 2) Then
            If a5(1, i5) = FundoDaVez Then
                m = m + FitString(Format(a5(3, i5), "##0.00%"), LC, "R")
                i5 = i5 + 1
            Else
                m = m + Space(LC)
            End If
        Else
            m = m + Space(LC)
        End If
        
        m = m + vbCr
        N = N + 1
    Wend
    subStress = m
    
    td = (Now() - t0) * 24 * 3600
    WriteLogPerf "MSG_STRESS", N, td
End Function


'---------------------------------------------------------------------------------------------------------
'                                          I N T E R N A L    R A T I N G
'---------------------------------------------------------------------------------------------------------
Private Function subIRB() As String
    Dim u As CCreditName, m As String
    m = "CREDIT SCORE ACTIONS - 1 SEMANA"
    m = m + vbCr + FitString("Nome", 32, "L") + FitString("Score", 16, "L") + FitString("ScoreW-1", 16, "L") + FitString("Action", 16, "L")
    For Each u In CrNames.c
        If u.RatingAction = "UP" Or u.RatingAction = "DOWN" Then _
            m = m + vbCr + FitString(u.nome, 32, "L") + _
                        FitString(u.ScoreNRating, 16, "L") + _
                        FitString(u.ScoreNRatingW_1, 16, "L") + _
                        FitString(u.RatingAction, 16, "L")
    Next u
    subIRB = m
End Function


'---------------------------------------------------------------------------------------------------------
'                                                 Evolução do PL
'---------------------------------------------------------------------------------------------------------
Private Function SubPL() As String
    Dim db As ADODB.Connection, rs As ADODB.Recordset, m As String, f As CFundo
    Dim d1 As Date, d2 As Date, d3 As Date, s1 As String, s2 As String, s3 As String
    Dim t0 As Date, td As Double, N As Integer
    
    t0 = Now()
    m = "EVOLUÇÃO DO PL E CAIXA (Fundos Selecionados)" + vbCr + _
    "                                   ---------------P.L.---------------  --------------Caixa%--------------  " + vbCr + _
    "FUNDO                              Último      W-1         M-1         Último      W-1         M-1         " + vbCr
    
    Set db = OpenTheDatabase
    'determina as datas
    i = 0
    d1 = LongTimeAgo: d2 = LongTimeAgo: d3 = LongTimeAgo
    While i > -5
        If d1 = LongTimeAgo Then
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM THISTRISK WHERE DATARUN = " + SQLD(BaseDate + i), db, adOpenForwardOnly, adLockReadOnly)
            If Not rs.EOF Then d1 = BaseDate + i
        End If
        
        If d2 = LongTimeAgo Then
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM THISTRISK WHERE DATARUN = " + SQLD(BaseDate - 7 + i), db, adOpenForwardOnly, adLockReadOnly)
            If Not rs.EOF Then d2 = BaseDate - 7 + i
        End If
        
        If d3 = LongTimeAgo Then
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM THISTRISK WHERE DATARUN = " + SQLD(DateSerial(Year(BaseDate), Month(BaseDate) - 1, Day(BaseDate)) + i), db, adOpenForwardOnly, adLockReadOnly)
            If Not rs.EOF Then d3 = DateSerial(Year(BaseDate), Month(BaseDate) - 1, Day(BaseDate)) + i
        End If
        
        i = i - 1
    Wend
    
    N = 0
    For Each f In Fundos.c
        s1 = Space(12): s2 = s1: s3 = s1: s11 = s1: s12 = s1: s13 = s1
        If f.Favorit_Cash Or f.ID = Config.ConcentrationFundID Then
            'Põe d1
                If d1 > LongTimeAgo Then
                    Set rs = New ADODB.Recordset
                    Call rs.open("SELECT * FROM THISTRISK WHERE FUNDO='" + f.nome + "' AND DATARUN=" + SQLD(d1), db, adOpenForwardOnly, adLockReadOnly)
                    i = 0
                    While rs.EOF And i > -5
                        Set rs = New ADODB.Recordset
                        Call rs.open("SELECT * FROM THISTRISK WHERE FUNDO='" + f.nome + "' AND DATARUN=" + SQLD(d1 + i), db, adOpenForwardOnly, adLockReadOnly)
                        i = i - 1
                    Wend
                    If Not rs.EOF Then
                        s1 = FitString(Format(rs("PL") / 1000000#, "#,##0.0"), 12, "R")
                        s11 = FitString(Format(rs("Caixa"), "##0%"), 12, "R")
                    End If
                End If
            
            'Põe d2
                If d2 > LongTimeAgo Then
                    Set rs = New ADODB.Recordset
                    Call rs.open("SELECT * FROM THISTRISK WHERE FUNDO='" + f.nome + "' AND DATARUN=" + SQLD(d2), db, adOpenForwardOnly, adLockReadOnly)
                    i = 0
                    While rs.EOF And i > -5
                        Set rs = New ADODB.Recordset
                        Call rs.open("SELECT * FROM THISTRISK WHERE FUNDO='" + f.nome + "' AND DATARUN=" + SQLD(d2 + i), db, adOpenForwardOnly, adLockReadOnly)
                        i = i - 1
                    Wend
                    If Not rs.EOF Then
                        s2 = FitString(Format(rs("PL") / 1000000#, "#,##0.0"), 12, "R")
                        s12 = FitString(Format(rs("Caixa"), "##0%"), 12, "R")
                    End If
                End If
                
            'Põe d3
                If d3 > LongTimeAgo Then
                    Set rs = New ADODB.Recordset
                    Call rs.open("SELECT * FROM THISTRISK WHERE FUNDO='" + f.nome + "' AND DATARUN=" + SQLD(d3), db, adOpenForwardOnly, adLockReadOnly)
                    i = 0
                    While rs.EOF And i > -5
                        Set rs = New ADODB.Recordset
                        Call rs.open("SELECT * FROM THISTRISK WHERE FUNDO='" + f.nome + "' AND DATARUN=" + SQLD(d3 + i), db, adOpenForwardOnly, adLockReadOnly)
                        i = i - 1
                    Wend
                    If Not rs.EOF Then
                        s3 = FitString(Format(rs("PL") / 1000000#, "#,##0.0"), 12, "R")
                        s13 = FitString(Format(rs("Caixa"), "##0%"), 12, "R")
                    End If
                End If
                
            m = m + FitString(f.nome, 28, "L") + s1 + s2 + s3 + s11 + s12 + s13 + vbCr
            
            N = N + 1
        End If 'Se fundo = favorito ou Consolidado
    Next f
    
    SubPL = m
    
    td = (Now() - t0) * 24 * 3600
    WriteLogPerf "MSG_PL", N, td
End Function

'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'
'                                                 M E N S A G E N S
'
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Public Function Message(Optional f As Form) As String
    Dim m As String
    m = "RELATÓRIO DE RISCO E COMPLIANCE DATA " + Format(Now(), "dd-MMM-yyyy") + " CARTEIRAS DE " + Format(BaseDate, "dd-MMM-yyyy")
    
    If Not f Is Nothing Then f.Say ("Relatório de Controle 1/5")
    m = m + vbCr + vbCr + SubRisk("ASSET", "CTRL") + SubRisk("ADV", "CTRL")
    
    If Not f Is Nothing Then f.Say ("Relatório de Controle 2/5")
    m = m + vbCr + vbCr + SubLiquidity()
    
    If Not f Is Nothing Then f.Say ("Relatório de Controle 3/5")
    m = m + vbCr + vbCr + subCompliance("CTRL")
    
    If Not f Is Nothing Then f.Say ("Relatório de Controle 4/5")
    m = m + vbCr + vbCr + subAML
    
    If Not f Is Nothing Then f.Say ("Relatório de Controle 5/5")
    m = m + vbCr + vbCr + subRateio

    Message = m
End Function


Public Function MessageGerencial(Optional f As Form) As String
    Dim m As String
       
    m = "RELATÓRIO == GERENCIAL == DE RISCO E COMPLIANCE DATA " + Format(Now(), "dd-MMM-yyyy") + " CARTEIRAS DE " + Format(BaseDate, "dd-MMM-yyyy")
    
    If Not f Is Nothing Then f.Say ("Relatório Gerencial 1/11")
    m = m + vbCr + vbCr + SubRisk("ASSET", "GER1")
    
    If Not f Is Nothing Then f.Say ("Relatório Gerencial 2/11")
    m = m + vbCr + vbCr + subCashReport
    
    If Not f Is Nothing Then f.Say ("Relatório Gerencial 3/11")
    m = m + vbCr + vbCr + subLiqStress("GER1")
    
    If Not f Is Nothing Then f.Say ("Relatório Gerencial 4/11")
    m = m + vbCr + vbCr + subCompliance("GER1")
    
    If Not f Is Nothing Then f.Say ("Relatório Gerencial 5/11")
    m = m + vbCr + vbCr + SubLim
    
    If Not f Is Nothing Then f.Say ("Relatório Gerencial 6/11")
    m = m + vbCr + vbCr + subStress
    
    If Not f Is Nothing Then f.Say ("Relatório Gerencial 7/11")
    m = m + vbCr + vbCr + subIRB
    
    If Not f Is Nothing Then f.Say ("Relatório Gerencial 8/11")
    m = m + vbCr + vbCr + SubConcentra
    
    If Not f Is Nothing Then f.Say ("Relatório Gerencial 9/11")
    m = m + vbCr + vbCr + SubMaiores
    
    If Not f Is Nothing Then f.Say ("Relatório Gerencial 10/11")
    m = m + vbCr + vbCr + SubPL
    
    If Not f Is Nothing Then f.Say ("Relatório Gerencial 11/11")
    m = m + vbCr + vbCr + SubCtptAlto
    
    MessageGerencial = m
End Function


Public Function MessageErrors(Optional f As Form) As String
    MessageErrors = "RELATÓRIO DE ERROS DO SISTEMA DE GRC EM " + Format(Now(), "dd-MMM-yyyy") + vbCr + vbCr + SubErrors
End Function


Public Function MessagePreTrade(Optional f As Form) As String
    MessagePreTrade = "RELATÓRIO DE PRE-TRADE COMPLIANCE " + Format(Now(), "dd-MMM-yyyy") + vbCr + vbCr + SubPTC
End Function

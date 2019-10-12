VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FHistoricos 
   Caption         =   "Historicos"
   ClientHeight    =   11115
   ClientLeft      =   165
   ClientTop       =   450
   ClientWidth     =   8025
   LinkTopic       =   "Form1"
   ScaleHeight     =   11115
   ScaleWidth      =   8025
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   360
      TabIndex        =   2
      Top             =   0
      Width           =   3855
   End
   Begin MSComctlLib.TabStrip TabWho 
      Height          =   10815
      Left            =   0
      TabIndex        =   1
      Top             =   360
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   19076
      MultiRow        =   -1  'True
      Placement       =   2
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   3
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Hoje"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "30d"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "12m"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   10815
      Left            =   360
      TabIndex        =   0
      Top             =   360
      Width           =   7575
      _ExtentX        =   13361
      _ExtentY        =   19076
      _Version        =   393216
      BackColor       =   16777152
      AllowUserResizing=   1
   End
   Begin MSForms.ToggleButton ToggleButton1 
      Height          =   375
      Left            =   4200
      TabIndex        =   3
      Top             =   0
      Width           =   1095
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      DisplayStyle    =   6
      Size            =   "1931;661"
      Value           =   "0"
      Caption         =   "Filtro"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
End
Attribute VB_Name = "FHistoricos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Filtro As Boolean
Private What As String

Public Sub showfor(qual As String)
    What = qual
    Select Case qual
        Case "ERRO"
            Me.Caption = "Histórico de Erros"
            Me.Width = 9500
        Case "COMPL"
            Me.Caption = "Histórico de Compliance"
            Me.Width = 9500
        Case "BREACH"
            Me.Caption = "Histórico de Violações de Compliance"
            Me.Width = 11000
        Case "CASE"
            Me.Caption = "Histórico de Casos de Compliance"
            Me.Width = 10000
        Case "RISK"
            Me.Caption = "Histórico de Risco"
            Me.Width = 9000
        Case "LIQ"
            Me.Caption = "Histórico de Liquidez"
            Me.Width = 11000
        Case "PL"
           Me.Caption = "Histórico de PL"
           Me.Width = 6000
        Case "REDEMP"
            Me.Caption = "Histórico de Resgates"
            Me.Width = 10000
        Case "TRANSFERS"
            Me.Caption = "Histórico de Transferências"
            Me.Width = 10000
        Case "SERIES"
            Me.Caption = "Séries históricas"
            Me.Width = 5000
        Case "ADTV"
            Me.Caption = "ADTV"
            Me.Width = 12000
        Case "MAIORCOT"
            Me.Caption = "Histórico de Maior cotista"
            Me.Width = 9000
        Case "AML"
            Me.Caption = "Histórico de AML"
            Me.Width = 11000
        Case "TRADES"
            Me.Caption = "Histórico de Trades"
            Me.Width = 10000
        Case "CTPT"
            Me.Caption = "Histórico de Contrapartes"
            Me.Width = 12000
        Case "POSSOURCE"
            Me.Caption = "Histórico de fontes de posição"
            Me.Width = 6000
        Case "ALLOC"
            Me.Caption = "Histórico de alocação de ordens"
            Me.Width = 10000
        Case "CASHR"
            Me.Caption = "Histórico do Cash Report"
            Me.Width = 11000
        Case "SCORE"
            Me.Caption = "Histórico do Credit Score"
            Me.Width = 5000
        Case "QUOTAS"
            Me.Caption = "Histórico do Quotas"
            Me.Width = 5000
        Case "SYSTEMPERFORMANCE"
            Me.Caption = "Performance do Sistema"
            Me.Width = 7000
        Case "CONCENTRA"
            Me.Caption = "Histórico de Concentração"
            Me.Width = 9000
        Case "LIQSTRESS"
            Me.Caption = "Histórico de Stress de Liquidez"
            Me.Width = 9000
    End Select
    ToggleButton1 = False
    Filtro = False
    newrefresh
End Sub


Public Sub newrefresh()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset
    Dim d As Date, L As Integer, dt As Date, ky As String, ky2 As String, a As String
    Dim Mky As Boolean, search1 As String, search2 As String, pp As Integer
    
    
    Set db = OpenTheDatabase
    
    Grid.Rows = 1
    
    Select Case TabWho.SelectedItem.Caption
        Case "Hoje"
            d = BaseDate
        Case "30d"
            d = BaseDate - 30
        Case "12m"
            d = BaseDate - 365
        Case "Tudo"
            d = LongTimeAgo
    End Select
    
    '---detecta multiple key
        Mky = (InStr(Text1, "+") > 0)
        If Mky Then
            pp = InStr(Text1, "+")
            search1 = UCase(Left(Text1, pp - 1))
            search2 = UCase(Right(Text1, Len(Text1) - pp))
        Else
            search1 = UCase(Text1)
        End If
    
    
    Select Case What
        Case "ERRO"
            Grid.FormatString = "Data/Hora         |Erro                                             |Ítem                                                                |User          "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TLOGERRO WHERE DATAHORA <=" + SQLD(Now() + 1) + " AND DATAHORA>=" + SQLD(Now() - (BaseDate - d)) + " ORDER BY DATAHORA DESC", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1)AS NUM FROM TLOGERRO WHERE DATAHORA <=" + SQLD(Now() + 1) + " AND DATAHORA>=" + SQLD(Now() - (BaseDate - d)), db, adOpenForwardOnly, adLockReadOnly)
        Case "COMPL"
            Grid.FormatString = "Data         |Fundo                                              |Livro                      |Result          |Rule Breaches                            "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM THISTCOMPL WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " ORDER BY DATA", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1)AS NUM FROM THISTCOMPL WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "BREACH"
            Grid.FormatString = "Data         |Fundo                                              |Regra                   |Alocação       |Condição                                                                     "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM THISTCOMPBREACHES WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " AND TIPO='BREACH' ORDER BY DATA", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1)AS NUM FROM THISTCOMPBREACHES WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " AND TIPO='BREACH' ", db, adOpenForwardOnly, adLockReadOnly)
        Case "CASE"
            Grid.FormatString = "Data         |Fundo                                              |Regra                   "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT DISTINCT FUNDO, REGRA, Month(DATA)+YEAR(DATA)*12 AS DATAINDEX FROM THISTCOMPBREACHES WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " AND TIPO='BREACH'", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM (SELECT DISTINCT FUNDO, REGRA, Month(DATA)+YEAR(DATA)*12 AS DATAINDEX FROM THISTCOMPBREACHES WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " AND TIPO='BREACH') ", db, adOpenForwardOnly, adLockReadOnly)
        Case "RISK"
            Grid.FormatString = "Data         |Fundo                                              |PL                     |VaR             |Stress              |Caixa                "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT DATARUN, DATAINFO, FUNDO, PL, VAR, STRESS, CAIXA FROM THISTRISK WHERE DATARUN <=" + SQLBaseDate + " AND DATARUN>=" + SQLD(d) + " ORDER BY DATARUN", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM THISTRISK WHERE DATARUN <=" + SQLBaseDate + " AND DATARUN>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "LIQ"
            Grid.FormatString = "Data         |Fundo                                              |Liquidity OK    |Cov. 1d  |Cov. 5d  |Cov. 21d |Cov. 42d |Cov. 63d |Cov. 126d|Cov. 252d"
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT DATARUN, FUNDO, LIQ_OK, LIQ_1, LIQ_5, LIQ_21, LIQ_42, LIQ_63, LIQ_126, LIQ_252 FROM THISTRISK WHERE DATARUN <=" + SQLBaseDate + " AND DATARUN>=" + SQLD(d) + " ORDER BY DATARUN", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM THISTRISK WHERE DATARUN <=" + SQLBaseDate + " AND DATARUN>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "SERIES"
            Grid.FormatString = "Data         |Fator                        |Valor            "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TFACTORHIST WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " ORDER BY DATA", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM TFACTORHIST WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "ADTV"
            Grid.FormatString = "Data         |Ativo                        |ADTV           |ADTV Condic.   |ADTV Classe    |ADTV Cond.Classe"
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TADTV WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " ORDER BY DATA", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM TADTV WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "REDEMP"
            Grid.FormatString = "Data         |Fundo                                              |Data Pagamento|Valor              |^Total? |Cancelado|Data Cancelado"
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TRESGATES WHERE DATAOBS <=" + SQLBaseDate + " AND DATAOBS>=" + SQLD(d) + " ORDER BY DATAOBS", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM TRESGATES WHERE DATAOBS <=" + SQLBaseDate + " AND DATAOBS>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "PL"
            Grid.FormatString = "Data         |Fundo                                              |PL                  "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT DATARUN, FUNDO, PL FROM THISTRISK WHERE DATARUN <=" + SQLBaseDate + " AND DATARUN>=" + SQLD(d) + " ORDER BY DATARUN", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM THISTRISK WHERE DATARUN <=" + SQLBaseDate + " AND DATARUN>=" + SQLD(d) + "", db, adOpenForwardOnly, adLockReadOnly)
        Case "TRANSFERS"
            Grid.FormatString = "Data         |Fundo                                              |Data Aporte   |Valor              |Cancelado|Data Cancelado"
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TTRANSFERS WHERE DATAOBS <=" + SQLBaseDate + " AND DATAOBS>=" + SQLD(d) + " ORDER BY DATAOBS", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM TTRANSFERS WHERE DATAOBS <=" + SQLBaseDate + " AND DATAOBS>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "MAIORCOT"
            Grid.FormatString = "Data         |Fundo                                              |1º COTISTA        |2º COTISTA        |3º COTISTA        "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TMAIORCOTISTA WHERE DATAOBS <=" + SQLBaseDate + " AND DATAOBS>=" + SQLD(d) + " ORDER BY DATAOBS", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM TMAIORCOTISTA WHERE DATAOBS <=" + SQLBaseDate + " AND DATAOBS>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "AML"
            Grid.FormatString = "Data         |<Fundo                           |Ativo                 |Compliant|Obs                                                                                                       "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM THISTAML WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " ORDER BY DATA", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM THISTAML WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "TRADES"
            Grid.FormatString = "Data         |<Fundo                           |Ativo                 |C/V|Quantidade               |PU                |Contraparte                         "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TTRADES WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " ORDER BY DATA", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM TTRADES WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "CTPT"
            Grid.FormatString = "Último Trade |<Broker                  |ID        |Razão Social                                     |CNPJ                  |Atividade           |Atualização      |Valor Total       "
            a = "SELECT X.BROKER, X.MAXDATA, X.TVALOR, y.ID, Y.CNPJ, Y.RAZAOSOCIAL, Y.ATIVIDADE, Y.ATUALIZADO FROM (SELECT DISTINCT TTRADES.BROKER, MAX(DATA)AS MAXDATA, SUM(PU*QUANT) AS TVALOR FROM TTRADES GROUP BY BROKER)X "
            a = a + "INNER JOIN TCTPT Y ON X.BROKER = Y.NOME "
            a = a + "WHERE MAXDATA <=" + SQLBaseDate + " AND MAXDATA>=" + SQLD(d) + " "
            a = a + "ORDER BY X.MAXDATA DESC"
            Set rs = New ADODB.Recordset
            Call rs.open(a, db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM (" + a + ")", db, adOpenForwardOnly, adLockReadOnly)
        Case "POSSOURCE"
            Grid.FormatString = "Data         |Fundo                                              |Fonte           "
            a = "SELECT  DATA, TFUNDOS.NOME, TPOSIC.TIPO  FROM TPOSIC INNER JOIN TFUNDOS ON TPOSIC.FUNDO = TFUNDOS.ID WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " GROUP BY TFUNDOS.NOME, DATA, TPOSIC.TIPO ORDER BY DATA"
            Set rs = New ADODB.Recordset
            Call rs.open(a, db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM (" + a + ")", db, adOpenForwardOnly, adLockReadOnly)
        Case "ALLOC"
            Grid.FormatString = "Data         |<Ativo                    |<Fundo                    |C/V  |PU Fundo           |PU Geral           |^Compliant         "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM THISTALLOC WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " ORDER BY DATA, ATIVO", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM THISTALLOC WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "CASHR"
            Grid.FormatString = "Data         |<Fundo                   |>Cash (MM)    |>Cash (%)     |>Free Cash(MM)|>Free Cash (%)|>3m Geraç (MM)|>3m Req (MM)  |>3m FreeCash(MM)"
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TCASHREPORTHIST WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " ORDER BY DATA, FUNDO", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM TCASHREPORTHIST WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "SCORE"
            Grid.FormatString = "Data         |<Name                      |Credit Score   "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TRATINGS WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " ORDER BY DATA, ID", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM TRATINGS WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "QUOTAS"
            Grid.FormatString = "Data         |<Fundo                              |Quota       "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TQUOTAS INNER JOIN TFUNDOS ON TQUOTAS.FUNDO = TFUNDOS.ID WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " ORDER BY DATA, TFUNDOS.NOME", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM TQUOTAS INNER JOIN TFUNDOS ON TQUOTAS.FUNDO = TFUNDOS.ID WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "SYSTEMPERFORMANCE"
            Grid.FormatString = "Data/Hora           |Evento               |Tempo(seg)|User                        "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TLOGPERF WHERE DATAHORA <=" + SQLD(Now() + 1) + " AND DATAHORA>=" + SQLD(Now() - (BaseDate - d)) + " ORDER BY DATAHORA", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM TLOGPERF WHERE DATAHORA <=" + SQLD(Now() + 1) + " AND DATAHORA>=" + SQLD(Now() - (BaseDate - d)), db, adOpenForwardOnly, adLockReadOnly)
        Case "CONCENTRA"
            Grid.FormatString = "Data        |<Valor                               |<Propriedade                    |Fundo                                 |Concentração"
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TCONCENTRA WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " ORDER BY DATA, NOME, PROPRIEDADE", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM TCONCENTRA WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        Case "LIQSTRESS"
            Grid.FormatString = "Data        |^Percentil       |^Meses          |^Liq. Requerida   "
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TLIQGABARITO WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d) + " ORDER BY DATA, PERCENTIL, MESES", db, adOpenForwardOnly, adLockReadOnly)
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT COUNT(1) AS NUM FROM TLIQGABARITO WHERE DATA <=" + SQLBaseDate + " AND DATA>=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
    End Select
    
    
    If Not rs.EOF Then
        Grid.Visible = False
        Grid.Rows = rs1("NUM") + 1
        rs.MoveFirst
        L = 0
        While Not rs.EOF
            col0Format = "dd-MMM-yy"
            Select Case What
                Case "ERRO"
                    dt = rs("DATAHORA")
                    ky = rs("MSGERRO")
                    ky2 = rs("ITEM")
                Case "COMPL"
                    dt = rs("DATA")
                    ky = rs("FUNDO")
                    ky2 = rs("RESULT")
                Case "BREACH"
                    dt = rs("DATA")
                    ky = rs("FUNDO")
                    ky2 = rs("REGRA")
                Case "CASE"
                    dt = DateSerial(rs("DATAINDEX") \ 12, rs("DATAINDEX") Mod 12, 1)
                    ky = rs("FUNDO")
                    ky2 = rs("REGRA")
                Case "RISK"
                    dt = rs("DATARUN")
                    ky = rs("FUNDO")
                Case "LIQ"
                    dt = rs("DATARUN")
                    ky = rs("FUNDO")
                    ky2 = rs("LIQ_OK")
                Case "PL"
                    dt = rs("DATARUN")
                    ky = rs("FUNDO")
                Case "REDEMP", "TRANSFERS"
                    dt = rs("DATAOBS")
                    ky = rs("FUNDO")
                Case "SERIES"
                    dt = rs("DATA")
                    ky = rs("FACTORID")
                Case "ADTV"
                    dt = rs("DATA")
                    ky = rs("NOME")
                Case "MAIORCOT"
                    dt = rs("DATAOBS")
                    ky = rs("FUNDO")
                Case "AML"
                    dt = rs("DATA")
                    ky = rs("FUNDO")
                    ky2 = rs("COMPLIANT")
                Case "TRADES"
                    dt = rs("DATA")
                    ky = rs("FUNDO")
                    ky2 = rs("ATIVO")
                Case "CTPT"
                    dt = rs("MAXDATA")
                    ky = rs("BROKER")
                    ky2 = CritS(rs("RAZAOSOCIAL"))
                Case "POSSOURCE"
                    dt = rs("DATA")
                    ky = rs("NOME")
                Case "ALLOC"
                    dt = rs("DATA")
                    ky = rs("ATIVO")
                    ky2 = rs("FUNDO")
                Case "CASHR"
                    dt = rs("DATA")
                    ky = rs("FUNDO")
                Case "SCORE"
                    dt = rs("DATA")
                    ky = rs("ID")
                Case "QUOTAS"
                    dt = rs("DATA")
                    ky = rs("NOME")
                Case "SYSTEMPERFORMANCE"
                    dt = rs("DATAHORA")
                    ky = rs("OPER")
                    col0Format = "dd-MMM-yy HH:MM"
                Case "CONCENTRA"
                    dt = rs("DATA")
                    ky = rs("VALORPROP")
                    ky2 = rs("NOME")
                Case "LIQSTRESS"
                    dt = rs("DATA")
                    ky = Format(rs("PERCENTIL"), "###0%")
            End Select

            If Not Filtro Or _
                (Not Mky And (InStr(UCase(ky), search1) Or InStr(UCase(ky2), search1))) Or _
                (Mky And InStr(UCase(ky), search1) * InStr(UCase(ky2), search2) > 0) _
                Then
                    L = L + 1
                    Grid.TextMatrix(L, 0) = Format(dt, col0Format)
                    Grid.TextMatrix(L, 1) = ky
                    Select Case What
                        Case "ERRO"
                            Grid.TextMatrix(L, 0) = Format(dt, "dd-MMM hh:mm")
                            If dt >= TimeInit Then PintaLinha Grid, L, &H8000000E
                            Grid.TextMatrix(L, 2) = rs("Item")
                            Grid.TextMatrix(L, 3) = rs("User")
                        Case "COMPL"
                            Grid.TextMatrix(L, 2) = rs("Livro")
                            Grid.TextMatrix(L, 3) = rs("Result")
                            Grid.TextMatrix(L, 4) = rs("RuleBreaches")
                        Case "BREACH"
                            Grid.TextMatrix(L, 2) = rs("Regra")
                            Grid.TextMatrix(L, 3) = Format(rs("alocacao"), "##0.00%")
                            Grid.TextMatrix(L, 4) = rs("Regratexto")
                        Case "CASE"
                            Grid.TextMatrix(L, 2) = rs("Regra")
                        Case "RISK"
                            Grid.TextMatrix(L, 2) = Format(rs("PL"), "###,###,##0")
                            Grid.TextMatrix(L, 3) = Format(rs("VaR"), "##0.00%")
                            Grid.TextMatrix(L, 4) = Format(rs("Stress"), "##0.00%")
                            Grid.TextMatrix(L, 5) = Format(rs("Caixa"), "##0.00%")
                        Case "LIQ"
                            Grid.TextMatrix(L, 2) = rs("Liq_OK")
                            Grid.TextMatrix(L, 3) = Format(rs("Liq_1"), "##0.00%")
                            Grid.TextMatrix(L, 4) = Format(rs("Liq_5"), "##0.00%")
                            Grid.TextMatrix(L, 5) = Format(rs("Liq_21"), "##0.00%")
                            Grid.TextMatrix(L, 6) = Format(rs("Liq_42"), "##0.00%")
                            Grid.TextMatrix(L, 7) = Format(rs("Liq_63"), "##0.00%")
                            Grid.TextMatrix(L, 8) = Format(rs("Liq_126"), "##0.00%")
                            Grid.TextMatrix(L, 9) = Format(rs("Liq_252"), "##0.00%")
                        Case "PL"
                            Grid.TextMatrix(L, 2) = Format(rs("PL"), "###,###,##0")
                        Case "REDEMP", "TRANSFERS"
                            Grid.TextMatrix(L, 2) = Format(rs("DATALIQ"), "dd-MMM-yy")
                            Grid.TextMatrix(L, 3) = Format(rs("VALOR"), "###,###,##0")
                            If What = "REDEMP" Then
                                If rs("TOTAL") Then Grid.TextMatrix(L, 4) = "Sim" Else Grid.TextMatrix(L, 4) = "não"
                            Else
                                Grid.TextMatrix(L, 4) = ""
                            End If
                            If rs("CANCELADO") Then Grid.TextMatrix(L, 5) = "X" Else Grid.TextMatrix(L, 5) = ""
                            Grid.TextMatrix(L, 6) = Format(rs("DATACANCEL"), "dd-MMM-yyyy")
                        Case "SERIES"
                            Grid.TextMatrix(L, 2) = Format(rs("VALOR"), "###,##0.0000")
                        Case "ADTV"
                            Grid.TextMatrix(L, 2) = Format(CritNN(rs("ADTV")), "###,###,##0")
                            Grid.TextMatrix(L, 3) = Format(CritNN(rs("ADTVCOND")), "###,###,##0")
                            Grid.TextMatrix(L, 4) = Format(CritNN(rs("ADTVCLASSE")), "###,###,##0")
                            Grid.TextMatrix(L, 5) = Format(CritNN(rs("ADTVCLASSECOND")), "###,###,##0")
                        Case "MAIORCOT"
                            Grid.TextMatrix(L, 2) = Format(rs("MAXCOT1"), "###,###,##0")
                            Grid.TextMatrix(L, 3) = Format(rs("MAXCOT2"), "###,###,##0")
                            Grid.TextMatrix(L, 4) = Format(rs("MAXCOT3"), "###,###,##0")
                        Case "AML"
                            Grid.TextMatrix(L, 2) = rs("ATIVO")
                            Grid.TextMatrix(L, 3) = rs("COMPLIANT")
                            Grid.TextMatrix(L, 4) = rs("COMENT")
                        Case "TRADES"
                            Grid.TextMatrix(L, 2) = rs("ATIVO")
                            Grid.TextMatrix(L, 3) = rs("CV")
                            Grid.TextMatrix(L, 4) = Str(rs("QUANT"))
                            Grid.TextMatrix(L, 5) = Str(rs("PU"))
                            Grid.TextMatrix(L, 6) = CritS(rs("BROKER"))
                        Case "CTPT"
                            Grid.TextMatrix(L, 2) = rs("ID")
                            Grid.TextMatrix(L, 3) = CritS(rs("RAZAOSOCIAL"))
                            Grid.TextMatrix(L, 4) = CritS(rs("CNPJ"))
                            Grid.TextMatrix(L, 5) = CritS(rs("ATIVIDADE"))
                            Grid.TextMatrix(L, 6) = Format(rs("ATUALIZADO"), "dd-MMM-yy")
                            Grid.TextMatrix(L, 7) = Format(rs("TVALOR"), "#,###,###,##0")
                        Case "POSSOURCE"
                            Select Case rs("TIPO")
                                Case 1
                                    Grid.TextMatrix(L, 2) = "TXT"
                                Case 2
                                    Grid.TextMatrix(L, 2) = "XML ANBIMA "
                                Case 3
                                    Grid.TextMatrix(L, 2) = "VIRADA"
                                Case Else
                                    Grid.TextMatrix(L, 2) = "n/a"
                            End Select
                        Case "ALLOC"
                            Grid.TextMatrix(L, 2) = rs("FUNDO")
                            Grid.TextMatrix(L, 3) = rs("CV")
                            Grid.TextMatrix(L, 4) = Format(rs("PUFUNDO"), "###,##0.0000")
                            Grid.TextMatrix(L, 5) = Format(rs("PUGERAL"), "###,##0.0000")
                            Grid.TextMatrix(L, 6) = rs("COMPLIANT")
                        Case "CASHR"
                            Grid.TextMatrix(L, 2) = Format(CritNN(rs("CASH")) / 1000000#, "##0.0")
                            Grid.TextMatrix(L, 3) = Format(CritNN(rs("PCASH")), "##0.0%")
                            Grid.TextMatrix(L, 4) = Format(CritNN(rs("CASHFREE")) / 1000000#, "##0.0")
                            Grid.TextMatrix(L, 5) = Format(CritNN(rs("PCASHFREE")), "##0.0%")
                            Grid.TextMatrix(L, 6) = Format(CritNN(rs("LIQ3M")) / 1000000#, "##0.0")
                            Grid.TextMatrix(L, 7) = Format(CritNN(rs("REQ3M")) / 1000000#, "##0.0")
                            Grid.TextMatrix(L, 8) = Format(CritNN(rs("CASHFREE3M")) / 1000000#, "##0.0")
                        Case "SCORE"
                            Grid.TextMatrix(L, 2) = CritS(rs("RATING"))
                        Case "QUOTAS"
                            Grid.TextMatrix(L, 2) = CritNN(rs("QUOTA"))
                        Case "SYSTEMPERFORMANCE"
                            Grid.TextMatrix(L, 2) = Format(rs("SECS"), "##0.00")
                            Grid.TextMatrix(L, 3) = rs("USER")
                        Case "CONCENTRA"
                            Grid.TextMatrix(L, 2) = rs("PROPRIEDADE")
                            Grid.TextMatrix(L, 3) = rs("NOME")
                            Grid.TextMatrix(L, 4) = Format(rs("CONCENTRACAO"), "##0.00%")
                        Case "LIQSTRESS"
                            Grid.TextMatrix(L, 2) = Format(rs("MESES"), "##0")
                            Grid.TextMatrix(L, 3) = Format(rs("LREQ"), "##0.00%")
                    End Select
            End If 'inclui na lista?
            rs.MoveNext
        Wend
        Grid.Rows = L + 1
        Grid.Visible = True
    End If
    
    If What = "ERRO" Then
        WriteLog "REVIU ERROS"
        AtualizaErros
        FMain.FazStatusBar
    End If
    
    
    Me.Show
End Sub


Private Function CritS(a As Variant) As String
    If IsNull(a) Then CritS = "" Else CritS = a
End Function


Private Sub form_resize()
    If Me.Height > 750 And Me.Width > 100 Then
        lastwidth = Grid.Width
        Grid.Width = Me.Width - 570
        a = Grid.Width / lastwidth
        For i = 0 To Grid.Cols - 1
            Grid.ColWidth(i) = Grid.ColWidth(i) * a
        Next i
        Grid.Height = Me.Height - 850
        TabWho.Height = Grid.Height
    End If
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub TabWho_Click()
    newrefresh
End Sub

Private Sub Text1_Change()
    If Filtro Then newrefresh
End Sub

Private Sub ToggleButton1_Click()
    Filtro = ToggleButton1
    newrefresh
End Sub




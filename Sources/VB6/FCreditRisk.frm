VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FCreditRisk 
   Caption         =   "Risco de Crédito"
   ClientHeight    =   9480
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10530
   LinkTopic       =   "Form1"
   ScaleHeight     =   9480
   ScaleWidth      =   10530
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   0
      TabIndex        =   1
      Text            =   "Combo1"
      Top             =   0
      Width           =   8055
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   9015
      Left            =   0
      TabIndex        =   0
      Top             =   360
      Width           =   10575
      _ExtentX        =   18653
      _ExtentY        =   15901
      _Version        =   393216
      BackColor       =   12648384
      AllowUserResizing=   1
   End
End
Attribute VB_Name = "FCreditRisk"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Obj As CFundo
Private WhatFor As String

'V. 2.126 - Incluída a coluna "COD CETIP" (nova 2a coluna) após "Ativo" em todos os relatórios
'           Todas as colunas após a 1 foram alteradas para +1. Cabeçalhos foram alterados

Public Sub newshow(ForWhat As String, Optional Fundo As String = "")
    Dim uu As String
    WhatFor = ForWhat
    Fundos.FillComboListWithNomes Combo1
    uu = Combo1.List(1)
    If Fundo <> "" Then
        uu = Fundo
    ElseIf FFundos.Visible Then
        If FFundos.Grid.Row > 0 Then uu = FFundos.Grid.TextMatrix(FFundos.Grid.Row, 0)
    End If
    Combo1 = uu
    Set Obj = Fundos.searchName(Combo1)
    Select Case WhatFor
        Case "CREDITO"
            Me.Caption = "Risco de Crédito da Carteira (rating externo)"
            Grid.FormatString = "Ativo                                                  |<Cod CETIP        |Valor                  |^Rating    |PD (rating)|^Last Rating  |PD        |LGD          |>EL (%)     |>EL ($)           "
        Case "MERCADO"
            Me.Caption = "Risco de Mercado da Carteira"
            Grid.FormatString = "Ativo                                                  |<Cod CETIP        |Valor                  |Indexador |Duration   |VaR Imob.Ix  |VaR Inflat   |VaR Pré      |VaR  Dólar   |VaR IDA      |VaR Imob.Id  "
        Case "STRESS"
            Me.Caption = "Stress de Mercado da Carteira"
            Grid.FormatString = "Ativo                                                  |<Cod CETIP        |Valor                  |Indexador |Duration   |Str Imob.Ix  |Str Inflat   |Str Pré      |Str  Dólar   |Str IDA      |VaR Imob.Id  "
        Case "IRB"
            Me.Caption = "Risco de Crédito da Carteira (IRB)"
            Grid.FormatString = "Ativo                                                  |<Cod CETIP        |Valor                  |Cr score  |Mkt impld |Senioridade|Rating A  |Rating ext|IRB Rating|PD        |LGD          |>EL (%)     |>EL ($)           "
        Case "LIQ", "LIQC", "LIQF", "LIQA"
            Select Case WhatFor
                Case "LIQ"
                    Me.Caption = "Risco de Liquidez da Carteira (ANBIMA)"
                Case "LIQC"
                    Me.Caption = "Risco de Liquidez da Carteira (Constrained)"
                Case "LIQF"
                    Me.Caption = "Risco de Liquidez da Carteira (Cash Flow)"
                Case "LIQF"
                    Me.Caption = "Risco de Liquidez da Carteira (ADTV)"
            End Select
            Grid.FormatString = "Ativo                                                  |<Cod CETIP        |Constraint|Class.Liq   |ADTV       |^1            |^5            |^21           |^42           |^63           |^126          |^252          "
    End Select
    newrefresh
    Me.Show
End Sub

Public Sub newrefresh()
    Dim posic As Collection, y As CPosic, d1 As Date
    Dim a As Double, b As Double, c As Double, d As Double, e As Double, f As Double, g As Double, Metodo As String
    Dim aa As Double, bb As Double, cc As Double, dd As Double, ee As Double, ff As Double, gg As Double, lrd As Date
    
    Dias = Array(0, 1, 5, 21, 42, 63, 126, 252)
    
    Set posic = Obj.MyPosicConsol
    
    Grid.Rows = 1
    L = 0
    aa = 0: bb = 0: cc = 0: dd = 0: ee = 0: ff = 0: gg = 0
    For Each y In posic
        L = L + 1
        Select Case WhatFor
            Case "CREDITO"
                a = y.Papel.AdjCredPD
                b = y.Papel.CredLGD
                c = y.Valor
                d = a * b
                e = d * c
                
                lrd = y.Papel.LastRatingDate
                Grid.AddItem y.Papel.nome
                Grid.TextMatrix(L, 1) = y.Papel.CodCetip
                Grid.TextMatrix(L, 2) = Format(c, "###,###,##0")
                Grid.TextMatrix(L, 3) = y.Papel.CreditRating
                Grid.TextMatrix(L, 4) = Format(y.Papel.CredPD, "##0.00%")
                If lrd = LongTimeAgo Or lrd = BaseDate Then Grid.TextMatrix(L, 5) = "-" Else Grid.TextMatrix(L, 5) = Format((BaseDate - lrd) / 365, "#0.0") + " Ys"
                Grid.TextMatrix(L, 6) = Format(a, "##0.00%")
                Grid.TextMatrix(L, 7) = Format(b, "##0.00%")
                Grid.TextMatrix(L, 8) = Format(d, "##0.00%")
                Grid.TextMatrix(L, 9) = Format(e, "###,###,##0")
            Case "IRB"
                a = y.Papel.IRBPD
                b = y.Papel.CredLGD
                c = y.Valor
                d = a * b
                e = d * c
                Grid.AddItem y.Papel.nome
                Grid.TextMatrix(L, 1) = y.Papel.CodCetip
                Grid.TextMatrix(L, 2) = Format(c, "###,###,##0")
                Grid.TextMatrix(L, 3) = y.Papel.UserCreditRating
                Grid.TextMatrix(L, 4) = y.Papel.NameCreditScore
                Grid.TextMatrix(L, 5) = y.Papel.Senior
                Grid.TextMatrix(L, 6) = y.Papel.InternalRatingGuess2
                Grid.TextMatrix(L, 7) = y.Papel.internalRatingGuess3
                Grid.TextMatrix(L, 8) = y.Papel.BaseIRBRating
                Grid.TextMatrix(L, 9) = Format(a, "##0.00%")
                Grid.TextMatrix(L, 10) = Format(b, "##0.00%")
                Grid.TextMatrix(L, 11) = Format(d, "##0.00%")
                Grid.TextMatrix(L, 12) = Format(e, "###,###,##0")
                
            Case "MERCADO"
                If y.Papel.Tipo = "FUTUROS" Then e = y.Quant Else e = y.Valor
                a = Abs(y.Papel.MktEImob) * e * RiskMgr.VolIFIX * Config.VaRConf
                b = Abs(y.Papel.MktEIPCA) * e * RiskMgr.VolIPCA(d1) / 100 * Config.VaRConf
                c = Abs(y.Papel.MktEPre) * e * RiskMgr.VolPRE(d1) / 100 * Config.VaRConf
                d = Abs(y.Papel.MktEDolar) * e * RiskMgr.VolDolar * Config.VaRConf
                f = Abs(y.Papel.MktEIdio) * e * RiskMgr.VolIdio * Config.VaRConf
                g = Abs(y.Papel.MktEIDA) * e * RiskMgr.VolIDA * Config.VaRConf
                
                d1 = y.Papel.PresumedMaturity
                Grid.AddItem y.Papel.nome
                Grid.TextMatrix(L, 1) = y.Papel.CodCetip
                Grid.TextMatrix(L, 2) = Format(e, "###,###,##0")
                Grid.TextMatrix(L, 3) = y.Papel.Index
                Grid.TextMatrix(L, 4) = Format(y.Papel.Duration, "#0.00")
                Grid.TextMatrix(L, 5) = Format(a, "###,###,##0")
                Grid.TextMatrix(L, 6) = Format(b, "###,###,##0")
                Grid.TextMatrix(L, 7) = Format(c, "###,###,##0")
                Grid.TextMatrix(L, 8) = Format(d, "###,###,##0")
                Grid.TextMatrix(L, 9) = Format(g, "###,###,##0")
                Grid.TextMatrix(L, 10) = Format(f, "###,###,##0")
                
            Case "STRESS"
                If y.Papel.Tipo = "FUTUROS" Then e = y.Quant Else e = y.Valor
                    
                a = Abs(y.Papel.MktEImob) * e * RiskMgr.StressIFIX
                b = Abs(y.Papel.MktEIPCA) * e * RiskMgr.StressIPCA(d1) / 100
                c = Abs(y.Papel.MktEPre) * e * RiskMgr.StressPRE(d1) / 100
                d = Abs(y.Papel.MktEDolar) * e * RiskMgr.StressDolar
                g = Abs(y.Papel.MktEIDA) * e * RiskMgr.StressIDA
                f = Abs(y.Papel.MktEIdio) * e * RiskMgr.StressIdio
                
                d1 = y.Papel.PresumedMaturity
                Grid.AddItem y.Papel.nome
                Grid.TextMatrix(L, 1) = y.Papel.CodCetip
                Grid.TextMatrix(L, 2) = Format(e, "###,###,##0")
                Grid.TextMatrix(L, 3) = y.Papel.Index
                Grid.TextMatrix(L, 4) = Format(y.Papel.Duration, "#0.00")
                Grid.TextMatrix(L, 5) = Format(a, "###,###,##0")
                Grid.TextMatrix(L, 6) = Format(b, "###,###,##0")
                Grid.TextMatrix(L, 7) = Format(c, "###,###,##0")
                Grid.TextMatrix(L, 8) = Format(d, "###,###,##0")
                Grid.TextMatrix(L, 9) = Format(g, "###,###,##0")
                Grid.TextMatrix(L, 10) = Format(f, "###,###,##0")
                
            Case "LIQ", "LIQC", "LIQF", "LIQA"
                Select Case WhatFor
                    Case "LIQ"
                        Metodo = "ANBIMA"
                    Case "LIQC"
                        Metodo = "CONSTR"
                    Case "LIQF"
                        Metodo = "CFLOW"
                    Case "LIQA"
                        Metodo = "ADTV"
                End Select
                Grid.AddItem y.Papel.nome
                Grid.TextMatrix(L, 1) = y.Papel.CodCetip
                Grid.TextMatrix(L, 2) = Format(y.LiqConstraint, "##0")
                Grid.TextMatrix(L, 3) = y.Papel.Class_Liq
                Grid.TextMatrix(L, 4) = FNumkMM(y.Papel.adtv)
                a = y.liquidityAteh(BaseDate + Dias(1) / 252 * 365, Metodo) / 1000000#
                b = y.liquidityAteh(BaseDate + Dias(2) / 252 * 365, Metodo) / 1000000#
                c = y.liquidityAteh(BaseDate + Dias(3) / 252 * 365, Metodo) / 1000000#
                d = y.liquidityAteh(BaseDate + Dias(4) / 252 * 365, Metodo) / 1000000#
                e = y.liquidityAteh(BaseDate + Dias(5) / 252 * 365, Metodo) / 1000000#
                f = y.liquidityAteh(BaseDate + Dias(6) / 252 * 365, Metodo) / 1000000#
                g = y.liquidityAteh(BaseDate + Dias(7) / 252 * 365, Metodo) / 1000000#
                Grid.TextMatrix(L, 5) = Format(a, "##0.0")
                Grid.TextMatrix(L, 6) = Format(b, "##0.0")
                Grid.TextMatrix(L, 7) = Format(c, "##0.0")
                Grid.TextMatrix(L, 8) = Format(d, "##0.0")
                Grid.TextMatrix(L, 9) = Format(e, "##0.0")
                Grid.TextMatrix(L, 10) = Format(f, "##0.0")
                Grid.TextMatrix(L, 11) = Format(g, "##0.0")
                
        End Select
        aa = aa + a
        bb = bb + b
        cc = cc + c
        dd = dd + d
        ee = ee + e
        ff = ff + f
        gg = gg + g
    Next y 'cada posição
    
    '---Cria as linhas de totalização
    Select Case WhatFor
        Case "CREDITO", "IRB"
            If Obj.PLTotal > 0 Then cc = Obj.PLTotal
            If WhatFor = "CREDITO" Then RCol = 7 Else RCol = 12
            Grid.AddItem ("===SOMA===")
            Grid.TextMatrix(L + 1, 2) = Format(cc, "###,###,##0")
            Grid.TextMatrix(L + 1, RCol) = Format(ee, "###,###,##0")
            If cc > 0 Then
                Grid.AddItem ("===PERCENT===")
                Grid.TextMatrix(L + 2, RCol) = Format(ee / cc, "##0.00%")
            End If
        
        Case "MERCADO", "STRESS"
            If Obj.PLTotal > 0 Then ee = Obj.PLTotal
            Grid.AddItem ("===SOMA===")
            Grid.TextMatrix(L + 1, 2) = Format(ee, "###,###,##0")
            Grid.TextMatrix(L + 1, 5) = Format(aa, "###,###,##0")
            Grid.TextMatrix(L + 1, 6) = Format(bb, "###,###,##0")
            Grid.TextMatrix(L + 1, 7) = Format(cc, "###,###,##0")
            Grid.TextMatrix(L + 1, 8) = Format(dd, "###,###,##0")
            Grid.TextMatrix(L + 1, 9) = Format(gg, "###,###,##0")
            Grid.TextMatrix(L + 1, 10) = Format(ff, "###,###,##0")
            If ee > 0 Then
                Grid.AddItem ("===PERCENT===")
                Grid.TextMatrix(L + 2, 5) = Format(aa / ee, "##0.00%")
                Grid.TextMatrix(L + 2, 6) = Format(bb / ee, "##0.00%")
                Grid.TextMatrix(L + 2, 7) = Format(cc / ee, "##0.00%")
                Grid.TextMatrix(L + 2, 8) = Format(dd / ee, "##0.00%")
                Grid.TextMatrix(L + 2, 9) = Format(gg / ee, "##0.00%")
                Grid.TextMatrix(L + 2, 10) = Format(ff / ee, "##0.00%")
            End If
            
        Case "LIQ", "LIQC"
            Grid.AddItem ("===SOMA===")
            Grid.TextMatrix(L + 1, 5) = Format(aa, "##0.0")
            Grid.TextMatrix(L + 1, 6) = Format(bb, "##0.0")
            Grid.TextMatrix(L + 1, 7) = Format(cc, "##0.0")
            Grid.TextMatrix(L + 1, 8) = Format(dd, "##0.0")
            Grid.TextMatrix(L + 1, 9) = Format(ee, "##0.0")
            Grid.TextMatrix(L + 1, 10) = Format(ff, "##0.0")
            Grid.TextMatrix(L + 1, 11) = Format(gg, "##0.0")
            
    End Select
End Sub


Private Sub Grid_dblClick()
    Dim pp As CPapel
    If Grid.Row > 0 Then
        Set pp = Papeis.searchName(Grid.TextMatrix(Grid.Row, 0))
        If Not pp Is Nothing Then
            FTitulo.showfor pp
        End If
    End If
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub


Private Sub Combo1_lostfocus()
    Set Obj = Fundos.searchName(Combo1)
    newrefresh
End Sub


Private Sub form_resize()
    Grid.Width = max(1, Me.Width - 200)
    Combo1.Width = Grid.Width
    Grid.Height = max(1, Me.Height - 950)
End Sub

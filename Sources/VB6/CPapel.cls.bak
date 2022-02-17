VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CPapel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public ID As String
Public nome As String
Public Fundo As Boolean
Public Status As String         'Antigo "Liberado"
Public IDFluxo As String
Public CFFound As Boolean
Public ISIN As String
Public CNPJ As String
Public Tipo As String

Public CodCetip As String
Public Class_Liq As String
Public Class_Rent As String
Public Dt_Emissao As Date
Public Dt_Venc As Date
Public Duration As Double
Public V_AssetValue As Double
Public V_AssetVol As Double
Public V_SeniorBefore As Double
Public Index As String
Public Yield As Double
Public Coupon As Double
Public DayCount As String
Private LiqANBIMA As Double
Public adtv As Double
Public adtvClasse As Double
Public adtvCond As Double
Public adtvClasseCond As Double
Public Dt_Created As Date
Public Holdings As Integer
Public Senior As String
Public NameCr As String

Private PropValues(1000) As String 'valores das propriedades, na mesma ordem que Props
Private PropIDs(1000) As Long 'IDs das propriedades, na mesma ordem que Props

'---Variáveis de Cashflow:
Private NFlows As Integer
Private CFDates(1000) As Date
Private CFPrin(1000) As Double      'taxa de amortização
Private CFInt(1000) As Double       'taxa de juros


Public MyFundo As CFundo 'Link para o fundo, se for fundo
Public MyCrdName As CCreditName 'Link para o nome de crédito

Public PosicTotalV As Double
Public PosicAssetV As Double
Public DisplayType As Integer


Public Sub Linka()
    'Linka MyFundo (se papel for um fundo) e MyCrdName
    If Fundo Then Set MyFundo = Fundos.searchIDTitulo(ID)
    If NameCr <> "" And NameCr <> "-" Then Set MyCrdName = CrNames.SearchCreditName(NameCr)
End Sub


Public Sub MakeMeCash()
    ID = "System.Cash"
    nome = "System.Cash"
    Class_Liq = "CASH"
    Class_Rent = "OVER"
    Fundo = False
    Index = "CDI+"
    Tipo = "CAIXA"
    Senior = "SR_CLEAN"
    Coupon = 0
    If Props.CreditPropertyIdx > 0 Then
        PropIDs(Props.CreditPropertyIdx) = Props.c(Props.CreditPropertyIdx).ID
        PropValues(Props.CreditPropertyIdx) = "AAA"
    End If
End Sub

Public Sub CloneFrom(x As CPapel)
    Dim i As Integer
    
    Class_Liq = x.Class_Liq
    Class_Rent = x.Class_Rent
    Coupon = x.Coupon
    DayCount = x.DayCount
    DisplayType = x.DisplayType
    Dt_Emissao = x.Dt_Emissao
    Dt_Venc = x.Dt_Venc
    Fundo = x.Fundo
    Holdings = x.Holdings
    Index = x.Index
    NameCr = x.NameCr
    Senior = x.Senior
    Tipo = x.Tipo
    Set x.MyCrdName = x.MyCrdName
    Set x.MyFundo = x.MyFundo
                
    For i = 1 To Props.c.Count
        PropValues(i) = x.PropV(i)
        PropIDs(i) = x.PropID(i)
    Next i
End Sub


Private Function SearchArray(x As Variant, key As String)
    'Auxiliar de GetYourADTVIn e funções GetRows - retorna o 1o da sequencia
    Dim n As Integer, i As Integer, hi As Integer, lo As Integer
    n = UBound(x, 2)
    hi = n: lo = 0: i = (hi + lo) \ 2
    While UCase(x(1, i)) <> key And hi > lo
        If UCase(x(1, i)) > key Then hi = i - 1 Else lo = i + 1
        i = (hi + lo) \ 2
    Wend
    If UCase(x(1, i)) = key Then
        While UCase(x(1, i)) = key And i > 1
            i = i - 1
        Wend
        If UCase(x(1, i)) <> key Then i = i + 1
    End If
    SearchArray = i
End Function

Public Sub GetYourADTVIn(x As Variant)
    'Procura o ADTV no array "GetRows" x
    Dim i As Integer, vai As Boolean
    
    vai = False
    i = SearchArray(x, UCase(CodCetip))
    vai = (UCase(x(1, i)) = UCase(CodCetip))
    If Not vai Then
        i = SearchArray(x, UCase(ID))
        vai = (UCase(x(1, i)) = UCase(ID))
    End If
    
    If vai Then
        adtv = x(2, i)
        adtvClasse = x(3, i)
        adtvCond = x(4, i)
        adtvClasseCond = x(5, i)
    Else
        adtv = 0
        adtvClasse = 0
        adtvCond = 0
        adtvClasseCond = 0
    End If
End Sub


Public Sub Refresh()
    'Seta variáveis estáticas
    Dim f As CFundo, pf As Double
    
    'Refresh DisplayType
        Select Case Tipo
            Case "TITPUBLICO"
                DisplayType = 1
            Case "COTAS"
                Select Case Class_Liq
                    Case "FIILIST"
                        DisplayType = 7
                    Case "FIDC", "FIDCNP"
                        DisplayType = 8
                    Case Else
                        DisplayType = 2
                End Select
            Case "TITPRIVADO"
                Select Case Class_Liq
                    Case "CRI"
                        DisplayType = 6
                    Case "LF", "LFSUB"
                        DisplayType = 4
                    Case "CDBS", "CDBN", "CDBM"
                        DisplayType = 3
                    Case Else
                        DisplayType = 11
                End Select
            Case "ACOES"
                DisplayType = 9
            Case "DEBENTURE"
                DisplayType = 5
            Case "FUTUROS"
                DisplayType = 10
            Case Else
                DisplayType = 11
        End Select

    'Calcula posição total
        PosicTotalV = 0
        PosicAssetV = 0
        For Each f In Fundos.c
            If f.area <> "EXTERNO" And f.Tipo <> "CONS" Then
                pf = f.PplRecValue(Me)
                PosicTotalV = PosicTotalV + pf
                If f.area = "ASSET" Then PosicAssetV = PosicAssetV + pf
            End If
        Next f
End Sub

Public Sub ResetCFlow()
    NFlows = 0
End Sub

Property Get ehcaixa() As Boolean
    ehcaixa = (Class_Liq = "CASH" Or Class_Liq = "OVER" Or Class_Liq = "CDBS" Or Class_Liq = "TITPUB" Or Class_Liq = "CDBN" Or Class_Liq = "CDBM" Or Class_Liq = "LF")
    'ehcaixa = (Class_Liq = "CASH" Or Class_Liq = "OVER" Or Class_Liq = "CDBS" Or Class_Liq = "TITPUB" Or Class_Liq = "CDBN" Or Class_Liq = "CDBM")
End Function

Property Get ehcaixaANBIMA() As Boolean
    ehcaixaANBIMA = (Class_Liq = "OVER" Or Class_Liq = "CDBS" Or Class_Liq = "TITPUB" Or Class_Liq = "CASH")
End Property

Public Sub ZeraFlowsPor(Meses As Integer)
    Dim i As Integer
    For i = 1 To NFlows
        If CFDates(i) <= DateSerial(Year(BaseDate), Month(BaseDate) + Meses, Day(BaseDate)) Then
            CFPrin(i) = 0
            CFInt(i) = 0
        End If
    Next i
End Sub

Property Get CF_NFlows() As Integer
    CF_NFlows = NFlows
End Property

Property Get CF_Dt(i) As Date
    CF_Dt = CFDates(i)
End Property

Property Get CF_Pr(i) As Date
    CF_Pr = CFPrin(i)
End Property

Property Get CF_Ju(i) As Date
    CF_Ju = CFInt(i)
End Property

Public Sub IncluiCFlow(d As Date, am As Double, j As Double)
    NFlows = NFlows + 1
    CFDates(NFlows) = d
    CFPrin(NFlows) = am
    CFInt(NFlows) = j
End Sub

Property Get PresumedMaturity() As Date
    Dim EmatDY As Integer, EmatYr As Integer
    
    If Year(Dt_Venc) > 2000 Then
        PresumedMaturity = Dt_Venc
    Else
        EmatDY = 0: EmatYr = 0
        Select Case Class_Rent 'determina a maturity provável para o caso de não haver Dt_Venc
            Case "OVER"
                EmatDY = 1
            Case "ZERO"
                EmatYr = 2
            Case "MATURITY"
                EmatYr = 10
            Case "PERP"
                EmatYr = 20
            Case Else
                EmatYr = 10
        End Select
        PresumedMaturity = DateSerial(Year(BaseDate) + EmatYr, Month(BaseDate), Day(BaseDate) + EmatDY)
    End If
End Property

Public Sub FazFluxo()
    Dim i As Integer, a As Double, PNA As Double, dataant As Date, v As Double, vpf As Double
    Dim d As Date, Aux(1000) As Double
    Dim MoInc As Integer, YrInc As Integer
    
    'Normaliza o principal (p/ principal não amortizado)
        If Not CFFound Then
        
            'Se não achou fluxos, tenta construir (já normalizado)
            
            If Class_Rent = "ZERO" Or Class_Rent = "OVER" Then
                NFlows = 1
                CFDates(1) = PresumedMaturity
            Else
                MoInc = 0: YrInc = 0
                If Class_Rent = "PERP" Then MoInc = 1 Else YrInc = 1
                dfim = PresumedMaturity
                d = DateSerial(Year(BaseDate) - YrInc, Month(dfim) - MoInc, Day(dfim)) 'Start
                NFlows = 0
                While d <= dfim
                    NFlows = NFlows + 1
                    d = DateSerial(Year(d) + YrInc, Month(d) + MoInc, Day(d))
                    CFDates(NFlows) = d
                    CFPrin(NFlows) = 0
                Wend
            End If
            CFPrin(NFlows) = 1
            
        Else
            'Normaliza o fluxo de caixa importado - para percentual do Par
            If CFPrin(NFlows) = 1 Then
                'Fluxo importado do tipo 1 = percentual do PNA
                a = 1
                For i = 1 To NFlows
                    If CFDates(i) > BaseDate Then
                        Aux(i) = CFPrin(i) * a
                        a = a - Aux(i)
                    Else
                        Aux(i) = 0
                    End If
                Next i
                For i = 1 To NFlows
                    CFPrin(i) = Aux(i)
                Next i
            Else
                'Fluxo importado do tipo 2 = percentual do Par
                a = 0
                For i = 1 To NFlows
                    If CFDates(i) > BaseDate Then a = a + CFPrin(i)
                Next i
                If a = 0 Then
                    NFlows = 1
                    CFDates(1) = Dt_Venc
                    CFPrin(1) = 1
                Else
                    For i = 1 To NFlows
                        If CFDates(i) <= BaseDate Then CFPrin(i) = 0 Else CFPrin(i) = CFPrin(i) / a
                    Next i
                End If
            End If
        End If
        
          
    'calcula os juros
    'simplificação: inflação=2Y, cdi=2Y; inflação não-carecada
        PNA = 0
        For i = NFlows To 1 Step -1
            If i = 1 Then dataant = BaseDate Else dataant = CFDates(i - 1)
            PNA = PNA + CFPrin(i)
            Select Case Index
                Case "IGPDI +", "IPCA +", "IGPM +", "IGPDI+", "IPCA+", "IGPM+"
                    Tx = Coupon 'a inflação corrige o principal, não é paga em juros
                Case "CDI +", "CDI+"
                    Tx = RiskMgr.GenLvlDI + Coupon
                Case "%CDI", "% CDI", "SELIC"
                    Tx = Coupon * RiskMgr.GenLvlDI
                Case "Fixo", "FIXED", "PRE", "IFIX"
                    Tx = Coupon
                Case Else
                    Tx = Coupon
            End Select
            If CFDates(i) > BaseDate Then CFInt(i) = PNA * ((1 + Tx) ^ ((CFDates(i) - dataant) / 365) - 1) Else CFInt(i) = 0
        Next i
        
    'calcula Duration
    'simplificação: Yield=Cupom, papel no par
        Select Case Class_Rent
            Case "OVER"
                Duration = 0
            Case "MATURITY", "ZERO"
                a = 0
                v = 0
                For i = 1 To NFlows
                    vpf = (CFPrin(i) + CFInt(i)) / (1 + Tx) ^ ((CFDates(i) - BaseDate) / 365.25)
                    If CFDates(i) > BaseDate Then
                        a = a + ((CFDates(i) - BaseDate) / 365.25) * vpf
                        v = v + vpf
                    End If
                Next i
                If v <= 0 Then Duration = (Dt_Venc - BaseDate) / 365.25 / (1 + Tx) Else Duration = a / v / (1 + Tx)
            Case "PERP"
                If Tx = 0 Then Duration = 30 Else Duration = 1 / Tx
            Case Else
                Duration = 10
        End Select
    
    'Atualiza o principal caso inflação
    'simplificação: inflação=6%, cdi=10%; inflação não-carecada
    'Obs: tem que vir DEPOIS do cálculo de Duration (que é em relação ao cupom)
        If Index = "IGPDI+" Or Index = "IPCA+" Or Index = "IGPM+" Then
            For i = 1 To NFlows
                CFPrin(i) = CFPrin(i) * (1 + RiskMgr.GenLvlInflation) ^ ((CFDates(i) - BaseDate) / 365.25)
                CFInt(i) = CFInt(i) * (1 + RiskMgr.GenLvlInflation) ^ ((CFDates(i) - BaseDate) / 365.25)
            Next i
        End If
        
    'Preseta a constante de Liquidez ANBIMA
    Select Case Class_Liq
        Case "CASH", "CDBS", "TITPUB", "OVER"
            LiqANBIMA = 0
        Case "EUROBOND"
            LiqANBIMA = 0.25
        Case "CDBN", "CDBM", "LF", "DEB400"
            LiqANBIMA = 0.5
        Case "CDBSUB", "LFSUB", "NOTAP", "FIILIST", "DEB400CALL", "DEB476"
            LiqANBIMA = 0.75
        Case Else
            LiqANBIMA = 1
    End Select
End Sub



Public Sub DeleteProp(ID As Integer)
    Dim i As Integer, j As Integer
    For i = 1 To Props.c.Count
        If PropIDs(i) = ID Then
            For j = i To Props.c.Count
                PropIDs(j) = PropIDs(j + 1)
                PropValues(j) = PropValues(j + 1)
            Next j
        End If
    Next i
End Sub


Public Sub colocprop(idprop As Integer, Valor As String)
    Dim i As Integer
    i = Props.PropIndex(idprop)
    PropIDs(i) = idprop
    PropValues(i) = Valor
End Sub

Property Get PropV(i As Integer) As String
    If i > 0 Then
        PropV = PropValues(i)
    ElseIf i = -1 Then
        PropV = Class_Liq
    ElseIf i = -2 Then
        PropV = Class_Rent
    ElseIf i = -3 Then
        PropV = Index
    ElseIf i = -4 Then
        PropV = nome
    ElseIf i = -5 Then
        PropV = ISIN
    ElseIf i = -6 Then
        PropV = CodCetip
    ElseIf i = -10 Then
        PropV = Format(Duration, "##0.0")
    ElseIf i = -11 Then
        PropV = MMath.FNumkMM(adtv)
    End If
End Property

Property Get PropID(i As Integer) As String
    PropID = PropIDs(i)
End Property

Property Let PropV(i As Integer, x As String)
    PropValues(i) = x
End Property

'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                              L I Q U I D E Z
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Public Function InternalLiquidityAteh(d As Date, method As String, decay As Double) As Double
    'InternalLiquidityAteh só considera a liquidez gerada pelo papel (Cashflow ou ANBIMA)
    'A opção ADTV retorna a liquidez interna sob decay das vendas secundárias
    '
    Dim i As Integer, a As Double, EfCFDate As Date, VM As Date, b As Double
    a = 0
    Select Case method
        Case "ANBIMA"
            If LiqANBIMA = 0 Then
                a = 1
            Else
                For i = 1 To NFlows
                    EfCFDate = max(BaseDate, BaseDate + (CFDates(i) - BaseDate) * LiqANBIMA)
                    If EfCFDate <= d Then a = a + (CFPrin(i) + CFInt(i)) * (1 + RiskMgr.GenLvlDI) ^ ((d - CFDates(i)) / 365.25)
                    'Traz de (CFDates a EfCfDate e leva de EfCfDate para d)
                Next i
            End If
            
        Case "CFLOW"
            If ehcaixa Then
                a = 1 * (1 + RiskMgr.GenLvlDI) ^ ((d - BaseDate) / 365.25)
            Else
                For i = 1 To NFlows
                    If CFDates(i) <= d Then a = a + (CFPrin(i) + CFInt(i)) * (1 + RiskMgr.GenLvlDI) ^ ((d - CFDates(i)) / 365.25)
                Next i
            End If
            
        Case "ADTV"
            'Decay é quanto % do principal é reduzido (por venda secundária) por dia
            If ehcaixa Then
                a = 1 * (1 + RiskMgr.GenLvlDI) ^ ((d - BaseDate) / 365.25)
            Else
                For i = 1 To NFlows
                    If CFDates(i) <= d Then a = a + max(0, 1 - decay * (CFDates(i) - BaseDate) * 5 / 7) * (CFPrin(i) + CFInt(i)) * (1 + RiskMgr.GenLvlDI) ^ ((d - CFDates(i)) / 365.25)
                Next i
            End If
    End Select
    InternalLiquidityAteh = a
End Function


Private Function AtendeA1Crit(PropID As Integer, Comparador As String, valores As String) As Boolean
    Dim j As Integer, j1 As Integer, tested As String, tester As String, i As Integer, r As Boolean, R1 As Boolean
     
    i = Props.SearchIndex(PropID)
    
    If i <> 0 Then
        
        If IsNumeric(valores) And IsNumeric(PropV(i)) And InStr(valores, ",") = 0 And Len(Comparador) = 1 Then
            Select Case Trim(Comparador)
                Case "="
                    r = (Val(PropV(i)) = Val(valores))
                Case "<>"
                    r = (Val(PropV(i)) <> Val(valores))
                Case "<"
                    r = (Val(PropV(i)) < Val(valores))
                Case ">"
                    r = (Val(PropV(i)) > Val(valores))
            End Select
        ElseIf IsDate(valores) And IsDate(PropV(i)) And Len(Comparador) = 1 Then
            Select Case Trim(Comparador)
                Case "="
                    r = (CDate(PropV(i)) = CDate(valores))
                Case "<>"
                    r = (CDate(PropV(i)) <> CDate(valores))
                Case "<"
                    r = (CDate(PropV(i)) < CDate(valores))
                Case ">"
                    r = (CDate(PropV(i)) > CDate(valores))
            End Select
        Else 'Não é número nem data, é string
            Select Case Trim(Comparador)
                    Case "="
                            r = False
                            j = 1: j1 = 1
                            While j1 > 0 And Not r
                                j1 = InStr(j, valores, ",")
                                If j1 = 0 Then tested = Trim(Right(valores, Len(valores) - j + 1)) Else tested = Trim(Mid(valores, j, j1 - j))
                                If tested = PropV(i) And tested <> "" Then r = True
                                j = j1 + 1
                            Wend
                    Case "<>"
                            r = True
'                            tested = ""
'                            tester = valores + ","
'                            For j = 1 To Len(tester)
'                                If Mid(tester, j, 1) = "," Then
'                                    If Trim(tested) = PropV(i) And Trim(tested) <> "" Then r = False
'                                    tested = ""
'                                Else
'                                    tested = tested + Mid(tester, j, 1)
'                                End If
'                            Next j
                            
                            r = True
                            j = 1: j1 = 1
                            While j1 > 0 And r
                                j1 = InStr(j, valores, ",")
                                If j1 = 0 Then tested = Trim(Right(valores, Len(valores) - j + 1)) Else tested = Trim(Mid(valores, j, j1 - j))
                                If tested = PropV(i) And tested <> "" Then r = False
                                j = j1 + 1
                            Wend
                            
                            
                    Case "<"
                        r = (PropV(i) < valores)
                    Case ">"
                        r = (PropV(i) > valores)
                    Case "crmelhor"
                        r = (CredMelhor(PropV(i), valores))
                    Case "crpior"
                        r = Not (CredMelhor(PropV(i), valores))
                    Case "<DaysAgo"
                        r = BaseDate - CDate(PropV(i)) < Val(valores)
                    Case ">DaysAgo"
                        r = BaseDate - CDate(PropV(i)) > Val(valores)
            End Select
        
        End If 'IsNumeric, IsDate, etc
        
    End If 'i<>0
    
    AtendeA1Crit = r
End Function

Property Get AtendeA(x As CRegra) As Boolean
    Dim r As Boolean
    Dim R1 As Boolean
    
    If x.PARA Then
        r = AtendeA1Crit(x.Para_prop.ID, x.Para_comp, x.Para_valor)
        If x.ANDRule Then
            R1 = AtendeA1Crit(x.AND_prop.ID, x.AND_comp, x.AND_valor)
            If x.AND2Rule Then R1 = R1 And AtendeA1Crit(x.AND2_prop.ID, x.AND2_comp, x.AND2_valor)
            If x.AND3Rule Then R1 = R1 And AtendeA1Crit(x.AND3_prop.ID, x.AND3_comp, x.AND3_valor)
            If x.Conector Then AtendeA = (r Or R1) Else AtendeA = r And R1
        Else
            AtendeA = r
        End If
    Else
        AtendeA = True
    End If
End Property



'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                              C R E D I T O
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Property Get NameCreditScore() As String
    'Credit SCORING do Nome
    If MyCrdName Is Nothing Then
        NameCreditScore = ""
    Else
        If MyCrdName.Score = "n/a" Or MyCrdName.Score = "-" _
            Then NameCreditScore = "" _
            Else NameCreditScore = MyCrdName.Score
    End If
End Property

Property Get CreditRating() As String
    'Credit Rating Externo (das propriedades)
    CreditRating = PropValues(Props.CreditPropertyIdx)
End Property


Property Get UserCreditRating() As String
    'Credit Rating Interno (das propriedades)
    UserCreditRating = PropValues(Props.IRBPropertyIdx)
End Property

Public Function BaseIRBRating() As String
    If InternalRatingGuess1 <> "" Then
        BaseIRBRating = InternalRatingGuess1
    ElseIf InternalRatingGuess2 <> "" Then
        BaseIRBRating = InternalRatingGuess2
    ElseIf internalRatingGuess3 <> "" And UCase(internalRatingGuess3) <> UCase("não há") And UCase(internalRatingGuess3) <> UCase("Em desenvolvimento") Then
        BaseIRBRating = internalRatingGuess3
    Else
        BaseIRBRating = InternalRatingGuess4
    End If
End Function

Public Function LastRatingDate() As Date
    Dim dd As String
    If Props.LastRatingPropertyIdx = 0 Then
        LastRatingDate = BaseDate
        'Se não estiver implementada esta propriedade, considera que todos os ratings são atuais
    Else
        dd = PropV(Props.LastRatingPropertyIdx)
        If IsDate(dd) Then LastRatingDate = CDate(dd) Else LastRatingDate = LongTimeAgo
    End If
End Function

Public Function InternalRatingGuess1() As String
    InternalRatingGuess1 = UserCreditRating
End Function

Public Function InternalRatingGuess2() As String
    Dim a As String
    If Tipo = "TITPUBLICO" Then
        a = "AAA"
    ElseIf MyCrdName Is Nothing Then
        a = ""
    Else
        If Senior = "SR_SECURED" _
            Then a = RatingPlus1(MyCrdName.Rating) _
            Else a = MyCrdName.Rating
        If Class_Liq = "CDBN" Or Class_Liq = "CDBS" Or Class_Liq = "OVER" Then a = RatingPlus1(RatingPlus1(RatingPlus1(a)))
    End If
    InternalRatingGuess2 = a
End Function

Public Function internalRatingGuess3() As String
    internalRatingGuess3 = CreditRating
End Function

Public Function InternalRatingGuess4() As String
    InternalRatingGuess4 = "BB"
End Function


Public Function IRBPD() As Double
    IRBPD = PDFromRating(BaseIRBRating)
End Function

Public Function CredPD() As Double
    CredPD = PDFromRating(CreditRating)
End Function

Public Function AdjCredPD() As Double
    Dim d As Date
    d = LastRatingDate
    If d > BaseDate - 365 Or d = LongTimeAgo _
        Then AdjCredPD = CredPD _
        Else AdjCredPD = PDFromRating("BB") + (CredPD - PDFromRating("BB")) * 0.5 ^ ((BaseDate - d) / 365.25)
End Function


Public Function CredLGD() As Double
    Select Case Senior
        Case "SR_SECURED"
            CredLGD = Config.CredLGDSec
        Case "SR_CLEAN"
            CredLGD = Config.CredLGD
        Case "SUB", "JR", "MEZ", "JUNIOR"
            CredLGD = 1
        Case "EQUITY"
            CredLGD = 0
        Case Else
            CredLGD = Config.CredLGD
    End Select
End Function





'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                              M K T R I S K
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Public Function MktEIdio() As Double
    If Holdings > 0 Then MktEIdio = MktEImob / Sqr(Holdings) Else MktEIdio = MktEImob
End Function

Public Function MktEImob() As Double
    If Class_Liq = "FIILIST" Or Index = "IFIX" Or Tipo = "IMOVEL" Then
        If Senior = "EQUITY" Then MktEImob = 1.07 Else MktEImob = 0.75
    Else
        MktEImob = 0
    End If
End Function

Public Function MktEPre() As Double
    If Class_Liq = "FIILIST" Then
        MktEPre = 0
    ElseIf Index = "FIXED" Or Index = "PRE" Or (Tipo = "FUTUROS" And Index <> "IPCA+") Then
        MktEPre = Duration
    ElseIf Index = "%CDI" Then
        MktEPre = Duration * (Coupon - 1)
    Else
        MktEPre = 0
    End If
End Function

Public Function MktEIPCA() As Double
    If Class_Liq = "FIILIST" Then
        MktEIPCA = 0
    ElseIf Index = "IPCA+" Or Index = "IGPM+" Or Index = "IGPDI+" Then
        MktEIPCA = Duration
    Else
        MktEIPCA = 0
    End If
End Function

Public Function MktEIDA() As Double
    If Class_Liq = "DEB400" Or Class_Liq = "DEB476" Or Class_Liq = "DEB400CALL" Or Class_Liq = "DEB476CALL" Then
        MktEIDA = 1
    Else
        MktEIDA = 0
    End If
End Function


Public Function MktEDolar() As Double
    If Class_Liq = "FIILIST" Then
        MktEDolar = 0
    ElseIf Index = "DOLAR" Then
        MktEDolar = 1
    Else
        MktEDolar = 0
    End If
End Function





VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CFundo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public ID As Long
Public nome As String
Public nomeLiq As String
Public nomeBlotter As String
Public Tipo As String
Public CNPJ As String
Public qualif As String
Public IDTitulo As String
Public Consol As String
Public PrazoResgate As Integer
Public Concentracao As String
Public tipo409 As String
Public area As String
Public LiqMethod As String

Public Favorit_Cash As Boolean
Public Favorit_Credit As Boolean
Public Favorit_Mkt As Boolean

Public StaticLiquidityOK As String
Public StaticVar As Double
Public StaticVarQuota As Double
Public StaticStress As Double
Public StaticEImob As Double
Public StaticEInfl As Double
Public StaticEPre As Double
Public StaticEDolar As Double
Public StaticEIDA As Double
Public StaticEIdio As Double
Public StaticEL As Double
Public StaticUL As Double
Public StaticEL1 As Double
Public StaticUL1 As Double
Public Static_Rating As String
Public Static_LV As String
Public Static_LS As String
Public Static_LE As String
Public Static_LU As String
Public Static_LE1 As String
Public Static_LU1 As String

Public StaticDisp As Double
Public StaticCash As Double
Public StaticCashPct As Double
Public StaticCashFree As Double
Public StaticCashFreePct As Double
Public StaticFundSpread As Double

Public PLTotal As Double

Public MyBooks As New Collection
Public MyPosics As New Collection
Public MyPosicConsol As New Collection

Public MyQuotas As New Collection
Public MyTrades As New Collection

'---Resultados de Pre-Trade Compliance
Public PTCNodes As Collection
Public PTCResult As Integer
Public PTCNTrades As Integer
Public PTCExecuted As Boolean


'-----Resgates
Private NResg As Integer
Private ResgatesV(1000) As Double        'Valor
Private ResgatesD(1000) As Date          'Data de Liquidação
Private ResgatesT(1000) As Boolean       'Total?
Private ResgatesD0(1000) As Date         'data de pedido

'-----Transferencias
Private NTrans As Integer
Private TransferV(1000) As Double
Private TransferD(1000) As Date

Public MaiorCotista As Double
Public VolPL As Double              'volatilidade anual do PL
Public VolResg As Double            'volatilidade anual dos resgates em %PL

'----- Limites de Risco, Mandatos e regras
Public LIM_VaR As Double
Public LIM_Stress As Double
Public LIM_EL As Double
Public LIM_UL As Double
Public LIM_Dur As Double
Public OverrideLimit As Boolean
Public LimCredReg As Boolean
Public CaixaMandato As Double
Public Rule_NoDayTrd As Boolean
Public Rule_NoCrssTrd As Boolean


Public Dt_Created As Date

Public Tolerancia1 As Integer
Public Tolerancia2 As Integer
Public Dt_LastPortfolio As Date
Public Dt_LastInfo As Date


'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                                       T    R    A    D    E    S
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Public Sub ResetTrades()
    Dim x As CPosic
    Set MyTrades = New Collection
    Dt_LastInfo = Dt_LastPortfolio
    For Each x In MyPosics
        x.QuantD = 0
        x.ValorD = 0
    Next x
End Sub
    
Public Sub AddTrade(x As CTrade)
    'Só inclui os trades posteriores ao último portfolio
    Dim i As Integer, p As CPosic, CriaPosic As Boolean
    If x.Data > Dt_LastPortfolio Then
        MyTrades.Add x
        If Not x.MyPaper Is Nothing Then
            'inclui na posição
                If x.CV = "C" Then m = 1 Else m = -1
                i = 1
                If MyPosics.Count = 0 Then
                    CriaPosic = True
                Else
                    While i < MyPosics.Count And Not MyPosics(i).Papel Is x.MyPaper
                        i = i + 1
                    Wend
                    CriaPosic = Not (MyPosics(i).Papel Is x.MyPaper)
                End If
            
                If Not CriaPosic Then
                    MyPosics(i).QuantD = MyPosics(i).QuantD + m * x.Quant
                    MyPosics(i).ValorD = MyPosics(i).ValorD + m * x.ValFin
                    If x.Data = BaseDate Then
                        MyPosics(i).QuantDBD = MyPosics(i).QuantDBD + m * x.Quant
                        MyPosics(i).ValorDBD = MyPosics(i).ValorDBD + m * x.ValFin
                    End If
                    Set x.MyPosic = MyPosics(i)
                Else
                    Set p = IncluiPosic(x.MyPaper.ID, 0, 0, True, "AUTO_TIPO_3")
                    If Not p Is Nothing Then
                        p.QuantD = m * x.Quant
                        p.ValorD = m * x.ValFin
                        If x.Data = BaseDate Then
                            p.QuantDBD = m * x.Quant
                            p.ValorDBD = m * x.ValFin
                        End If
                        Set x.MyPosic = p
                    End If
                End If
            Dt_LastInfo = max(Dt_LastInfo, x.Data)
        End If 'trade.papel não é nothing
    End If
End Sub

Property Get CarteiraUpdateStatus() As String
    If Weekday(BaseDate) = 2 Then aj = 2 Else aj = 0
    
    If Dt_LastPortfolio = BaseDate Then
        CarteiraUpdateStatus = "ACT"
    ElseIf Dt_LastPortfolio >= BaseDate - Tolerancia1 - aj Then
        CarteiraUpdateStatus = "PRV"
    ElseIf Dt_LastPortfolio >= BaseDate - Tolerancia2 - aj Then
        CarteiraUpdateStatus = "EST"
    Else
        CarteiraUpdateStatus = "INV"
    End If
End Property



'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                              C   A   R   T   E   I   R   A
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Public Function IncluiPosic(Papel As String, Valor As Double, Quant As Double, Ordena As Boolean, MsgAuto As String) As CPosic
    Dim x As CPosic, h As CPapel
    
    Set h = Papeis.search(Papel)
    If h Is Nothing Then
        Set h = Papeis.Cria(Papel, MsgAuto)
    End If
    
    Set x = New CPosic
    Set x.Papel = h
    x.Fundo = ID
    x.Valor0 = Valor
    x.Quant0 = Quant
    x.ValorD = 0
    x.QuantD = 0
    x.LiqConstraint = 0 'Só é usado na consolidação
    
    If x.Papel.Status <> "LIBERADO" And Me.area <> "EXTERNO" Then
        WriteLogError "Papel não liberado", x.Papel.nome + " (" + Me.nome + ")"
    End If
        
    If Ordena And MyPosics.Count > 0 Then
        'Procura a ordem decrescente de valor
        i = 1
        While MyPosics(i).Valor > Valor And i < MyPosics.Count
            i = i + 1
        Wend
        If i = MyPosics.Count Then
            If MyPosics(i).Valor < Valor Then MyPosics.Add x, before:=i Else MyPosics.Add x
        Else
            MyPosics.Add x, before:=i
        End If
    Else
        MyPosics.Add x
    End If
    
    Set IncluiPosic = x
End Function


Property Get MyConcentration(ppi As Integer) As Collection
    Dim x As CPosic, y As CNomeValor, b As Collection, ppv As String, achou As Boolean

    Set h = MyPosicConsol

    Set b = New Collection
    For Each x In h
        ppv = x.Papel.PropV(ppi)
        achou = False
        For Each y In b
            If y.nome = ppv Then
                y.Valor = y.Valor + x.Valor
                achou = True
            End If
        Next y
        If Not achou Then
            Set y = New CNomeValor
            y.nome = ppv
            y.Valor = x.Valor
            b.Add y
        End If
    Next x

    Set MyConcentration = b
   
End Property

Public Sub Consolida()
    'Consolida as carteiras e salva em MyPosicConsol
    Dim y As CPosic, z As CPosic
    
    Dim pl As Double, b As Collection
    Select Case Consol
        Case "PROPORCIONAL"
            L_MyPosicsAberta b, PLTotal
        Case "FULL"
            L_MyPosicConsol b, PLTotal
        Case "ATIVA"
            L_MyPosicsExCaixa b, PLTotal
    End Select
    
    Set b2 = New Collection
    If Not b Is Nothing Then
        For Each y In b
            achou = False
            For Each z In b2
                If z.Papel.ID = y.Papel.ID And z.LiqConstraint = y.LiqConstraint Then
                    z.Valor0 = z.Valor0 + y.Valor0
                    z.Quant0 = z.Quant0 + y.Quant0
                    z.ValorD = z.ValorD + y.ValorD
                    z.QuantD = z.QuantD + y.QuantD
                    achou = True
                End If
            Next z
            If Not achou Then
                Set z = New CPosic
                z.Fundo = Me.ID
                Set z.Papel = y.Papel
                z.Valor0 = y.Valor0
                z.Quant0 = y.Quant0
                z.ValorD = y.ValorD
                z.QuantD = y.QuantD
                z.LiqConstraint = y.LiqConstraint
                b2.Add z
            End If
        Next y
    End If
  
    Set MyPosicConsol = b2
End Sub


Public Sub L_MyPosicConsol(a As Collection, pl As Double)
    Dim b As Collection, b1 As Collection, x As CPosic, y As CPosic, PLb As Double
    
    'Esta função apenas faz a consolidação TOTAL
    'Consolida todas as folhas e elimina os duplicados
    
    'Agrega todos na coleção b
    Set b = New Collection
    For Each x In MyPosics
        If x.Papel.Fundo And Not x.Papel.MyFundo Is Nothing Then
            If x.Papel.MyFundo.area <> "EXTERNO" Then
                If x.Papel.MyFundo Is Me Then
                    b.Add x
                    WriteLogError "Fundo investindo nele próprio", Me.nome
                Else
                    x.Papel.MyFundo.L_MyPosicConsol b1, PLb
                    For Each y In b1
                        b.Add y
                    Next y
                End If
            Else
                b.Add x
            End If
        Else
            b.Add x
        End If
    Next x
    
    'Consolida - elimina duplicadas
    i = 1
    While i < b.Count
        j = i + 1
        While j < b.Count
            If b(i) Is b(j) Then
                b.remove j
            Else
                j = j + 1
            End If
        Wend
        i = i + 1
    Wend
    
    'Calcula PL
    pl = 0
    For Each x In b
        pl = pl + x.Valor
    Next x
            
    Set a = b
End Sub

Public Sub L_MyPosicsAberta(ByRef a As Collection, ByRef pl As Double)
    Dim x As CPosic, y As CPosic, z As CPosic, b As Collection, b1 As Collection, b2 As Collection, PLDoInvestido As Double
    Dim achou As Boolean
    'Esta função retorna a posição consolidada PROPORCIONAL de D-1(pelo %PL no fundo investido) para PRE-TRADE Compliance
    'Altera ValorD e QuantD para refletir trade em BaseDate
    
    'Agrega todos na coleção b
        Set b = New Collection
        For Each x In MyPosics
            If x.Papel.Fundo And Not x.Papel.MyFundo Is Nothing Then
            
                If Not x.Papel.MyFundo Is Me Then
                    x.Papel.MyFundo.L_MyPosicsAberta b1, PLDoInvestido
                    If PLDoInvestido > 0 Then
                        For Each y In b1
                            Set z = New CPosic
                            Set z.Papel = y.Papel
                            z.Valor0 = y.Valor0 * x.Valor / PLDoInvestido
                            z.Quant0 = y.Quant0 * x.Valor / PLDoInvestido
                            z.ValorD = y.ValorD * x.Valor / PLDoInvestido
                            z.QuantD = y.QuantD * x.Valor / PLDoInvestido
                            z.Fundo = x.Fundo
                            z.LiqConstraint = max(y.LiqConstraint, x.Papel.MyFundo.PrazoResgate)
                            b.Add z
                        Next y
                    Else
                        WriteLogError "PL zerado em consolidação de carteira", x.Papel.MyFundo.nome
                    End If 'pl do investido>0
                End If 'fundo not me
                
            Else
                b.Add x
            End If
        Next x
        
    'Calcula PL
    pl = 0
    For Each x In b
        pl = pl + x.Valor
    Next x
        
    Set a = b
End Sub


Public Sub L_MyPosicsExCaixa(ByRef a As Collection, ByRef pl As Double)
     Dim b As Collection, b1 As Collection, x As CPosic, y As CPosic, PLb As Double
    
    'Esta função apenas faz a consolidação TOTAL
    'Consolida todas as folhas e elimina os duplicados
    
    'Agrega todos na coleção b
    Set b = New Collection
    For Each x In MyPosics
        If x.Papel.Fundo And Not x.Papel.MyFundo Is Nothing Then
            If x.Papel.MyFundo.area <> "EXTERNO" Then
                x.Papel.MyFundo.L_MyPosicConsol b1, PLb
                    For Each y In b1
                    If Not y.Papel.ehcaixa Then b.Add y
            
                Next y
            Else
                If Not x.Papel.ehcaixa Then b.Add x
            End If
        Else
            If Not x.Papel.ehcaixa Then b.Add x
        End If
    Next x
    
    'Consolida - elimina duplicadas
    i = 1
    While i < b.Count
        j = i + 1
        While j < b.Count
            If b(i) Is b(j) Then
                b.remove j
            Else
                j = j + 1
            End If
        Wend
        i = i + 1
    Wend
    
    'Calcula PL
    pl = 0
    For Each x In b
        pl = pl + x.Valor
    Next x
            
    Set a = b
End Sub

'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                              C   O   M   P   L   I   A   N   C   E
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Property Get AtendeA(x As String) As Boolean
    AtendeA = (area = x) Or (x = "TODOS") Or (x = "FAVORITOS" And (Favorit_Cash Or Favorit_Credit Or Favorit_Mkt))
End Property

Public Sub AddNewBook(x As Long)
    Dim u As CBook
    Set u = Books.searchID(x)
    If u Is Nothing Then
        WriteLogError "Book não encontrado", Str(x)
    Else
        MyBooks.Add Books.searchID(x)
    End If
End Sub

Public Sub ClearBooks()
    Set MyBooks = New Collection
End Sub

Property Get IAmAssignedToBook(x As CBook) As Boolean
    Dim a As Boolean, b As CBook
    a = False
    For Each b In MyBooks
        If b.ID = x.ID Then a = True
    Next b
    IAmAssignedToBook = a
End Property


Property Get MeusLivros() As String
    Dim a As String, x As CBook
    For Each x In MyBooks
        a = a + x.nome + ", "
    Next x
    If a <> "" Then a = Left(a, Len(a) - 2)
    MeusLivros = a
End Property


Public Function ComputeRule(x As CRegra, Optional ForceCart As Collection = Nothing) As CRuleResult
    'Recebe uma regra e retorna o PLSobRegra (%) e os papéis

    Dim subportfolio As New Collection, p As CPosic
    Dim Class(1000) As String, ClassPL(1000) As Double, ClassRef(1000) As Double, ClassPp(1000) As String, ClassPU(1000) As Double, NClass As Integer
    Dim ClassIndex As Integer, achou As Boolean
    Dim i As Integer, j As Integer, k As Integer, m As Integer, PU As Double, issuepropk As Integer
    Dim carteira As Collection
    Dim RR As CRuleResult, Element As CNomeValor, Delta As Double, DeltaW As Double, denom As Double, MxTest As Double

    Set a = New Collection
    Set RR = New CRuleResult
    RR.Compliant = "OK"
    
    If ForceCart Is Nothing Then
        If x.Aberta Then
            Set carteira = MyPosicConsol
        Else
            Set carteira = MyPosics
        End If
    Else
        Set carteira = ForceCart
    End If

    For Each p In carteira
        If p.Papel.AtendeA(x) Then subportfolio.Add p
    Next p
    
    If x.MaxMin = "MAX" Then m = 1 Else m = -1

    'Verifica se é necessária a propriedade de 'Emissão'
    If x.Lim_Ref = "ISSUEV" Or x.Lim_Ref = "ISSUEQ" _
        Then issuepropk = Props.SearchIndexByName(x.Issue_Prop.nome) _
        Else issuepropk = 0

    If x.Por And Not x.Por_Prop Is Nothing Then '------------------------------------------------------
        'Tem POR: Classifica; Preenche as Classes

        'Obtem todos os valores e PLs da propriedade Agrupadora
            NClass = 0
            ClassIndex = Props.SearchIndex(x.Por_Prop.ID)
            For Each p In subportfolio
                classvalue = p.Papel.PropV(ClassIndex)

                'Procura o valor da propriedade POR na lista de classes
                achou = False
                For k = 1 To NClass
                    If Class(k) = classvalue Then
                        achou = True
                        idx = k
                    End If
                Next k
                If Not achou Then
                    NClass = NClass + 1
                    Class(NClass) = classvalue
                    idx = NClass
                End If

                'Idx contém o índice da classe no vetor
                'Acrescenta o nome do papel
                ClassPp(idx) = ClassPp(idx) + "[" + p.Papel.nome + "] "

                'Soma quantidade ou valor, conforme for a regra
                If x.Lim_Ref = "ISSUEQ" Then
                    ClassPL(idx) = ClassPL(idx) + p.Quant
                    If p.Quant <> 0 Then ClassPU(idx) = p.Valor / p.Quant
                Else
                    ClassPL(idx) = ClassPL(idx) + p.Valor
                    ClassPU(idx) = 1
                End If
                

                'Se é sobre a issue, soma as issues de cada elemento da classe
                If issuepropk > 0 _
                    Then ClassRef(idx) = ClassRef(idx) + Val(p.Papel.PropV(issuepropk))
            Next p

        'Se existem classes identificadas, calcula
            If NClass > 0 Then

                'Verifica se a base de comparação é PL ou Issue
                
                For i = 1 To NClass
                    Select Case x.Lim_Ref
                        Case "PL"
                            denom = PLTotal / 100
                            PU = 1
                        Case "VALUE"
                            denom = 1
                            PU = 1
                        Case "ISSUEV", "ISSUEQ"
                            denom = ClassRef(i) / 100
                            If denom <= 0 Then WriteLogError "Papel s/ Quant ou Valor de Emissao", Class(i)
                        Case Else
                            denom = 1
                    End Select
                    
                    Delta = m * (ClassPL(i) - denom * x.Limite) * ClassPU(i)
                    DeltaW = m * (ClassPL(i) - denom * x.Warn) * ClassPU(i)
                    
                    If denom = 0 Then MxTest = 1 Else MxTest = ClassPL(i) / denom
                    If MxTest > RR.MaxOut Then RR.MaxOut = MxTest
                    
                    If Delta > 0 Or DeltaW > 0 Then 'se a regra foi violada, cria um registro de Elemento
                        Set Element = New CNomeValor
                        If Delta > 0 Then
                            If x.MovementRule And MainStatus = "LIVE" Then RR.Compliant = "WARN" Else RR.Compliant = "BREACH"
                            RR.Delta = RR.Delta + Delta
                            Element.Valor = Delta
                            Element.YesNo = True
                        Else 'DeltaW>0 e Delta=0
                            If RR.Compliant = "OK" Then RR.Compliant = "WARN"
                            RR.DeltaW = RR.DeltaW + DeltaW
                            Element.Valor = DeltaW
                        End If
                        
                        Element.nome = ClassPp(i)
                        
                        If denom = 0 _
                            Then Element.NomeAlt = "(**%)" _
                            Else Element.NomeAlt = "(" + FormatLimit(MxTest, x) + ")"
                                                
                        If Delta > 0 _
                            Then Element.NomeAlt = Element.NomeAlt + "x(" + FormatLimit(x.Limite, x) + ")" _
                            Else Element.NomeAlt = Element.NomeAlt + "x(" + FormatLimit(x.Warn, x) + ")"
                            
                        RR.Classes.Add Element
                    End If
                Next i 'Para cada classe
            End If 'se há alguma classe

    Else '--------------------------------------------------------------------------------------------------
        'Não tem POR: O PLRegra é a soma (dos que foram selecionados antes)
        'Não há hipótese da regra ser sobre a Issue
        Set Element = New CNomeValor
        
        PLRegra = 0
        For Each p In subportfolio
            PLRegra = PLRegra + p.Valor
            Element.nome = Element.nome + "[" + p.Papel.nome + "] "
        Next p
        
        Select Case x.Lim_Ref
            Case "PL"
                denom = PLTotal / 100
            Case "VALUE"
                denom = 1
            Case Else
                'A regra possui ISSUEV ou ISSUEQ, que na verdade são impossíveis sem o POR
                WriteLogError "Teste de regra incompatível (ISSUE s/ POR)", x.nome
        End Select
        
        Delta = m * (PLRegra - denom * x.Limite)
        DeltaW = m * (PLRegra - denom * x.Warn)
        
        If denom = 0 Then RR.MaxOut = 1 Else RR.MaxOut = PLRegra / denom
        
        If Delta > 0 Or DeltaW > 0 Then
            If Delta > 0 Then
                If x.MovementRule And MainStatus = "LIVE" Then RR.Compliant = "WARN" Else RR.Compliant = "BREACH"
                RR.Delta = Delta
                Element.Valor = Delta
                Element.YesNo = True
            Else 'DeltaW>0 e Delta=0
                RR.Compliant = "WARN"
                RR.DeltaW = DeltaW
                Element.Valor = DeltaW
            End If
            
            If denom = 0 _
                Then Element.NomeAlt = "(**%)" _
                Else Element.NomeAlt = "(" + FormatLimit(PLRegra / denom, x) + ")"
                       
            If Delta > 0 _
                Then Element.NomeAlt = Element.NomeAlt + "x(" + FormatLimit(x.Limite, x) + ")" _
                Else Element.NomeAlt = Element.NomeAlt + "x(" + FormatLimit(x.Warn, x) + ")"
            
            RR.Classes.Add Element
        End If
        
    End If
    
    Set ComputeRule = RR
    
End Function


Property Get IAmCompliantWithRule(x As CRegra, Escopo As String) As String
    Dim RR As New CRuleResult
    If Escopo = x.Escopo Or Escopo = "ALL" Or Escopo = "EXCTRL" And x.Escopo <> "CTRL" Then
        If Not x Is Nothing Then
            Set RR = ComputeRule(x)
            IAmCompliantWithRule = RR.Compliant
        End If
    Else
        IAmCompliantWithRule = "OK"
    End If
End Property


Property Get IAmCompliantWithBook(x As CBook, Escopo As String) As String
    Dim b As CRegra, s As String, h As String
    h = "OK"
    For Each b In x.c
        s = IAmCompliantWithRule(b, Escopo)
        If s = "BREACH" Then h = "BREACH"
        If s = "WARN" And h = "OK" Then h = "WARN"
    Next b
    IAmCompliantWithBook = h
End Property


Property Get IAmCompliant(Escopo As String) As String
    Dim b As CBook, s As String, h As String
    h = "OK"
    For Each b In MyBooks
        s = IAmCompliantWithBook(b, Escopo)
        If s = "BREACH" Then h = "BREACH"
        If s = "WARN" And h = "OK" Then h = "WARN"
    Next b
    IAmCompliant = h
End Property


Property Get SearchPositOn(x As String) As CPosic
    Dim p As CPosic
    For Each p In MyPosics
        If p.Papel.nome = x Then Set SearchPositOn = p
    Next p
End Property


Public Sub WriteDB()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, sb As String, x As CFundo, b As CBook
    
    If MainStatus = "LIVE" Then
        
        Set db = OpenTheDatabase(True)
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT * FROM TFUNDOS WHERE ID=" + Str(Me.ID), db, adOpenForwardOnly, adLockReadOnly)
        
        'If Me.OverrideLimit Then u = "TRUE" Else u = "FALSE"
        'If Me.LimCredReg Then u2 = "TRUE" Else u2 = "FALSE"
        
        u = IIf(Me.OverrideLimit, "1", "0")
        u2 = IIf(Me.LimCredReg, "1", "0")
        U3 = IIf(Me.Favorit_Cash, "1", "0")
        u4 = IIf(Me.Favorit_Credit, "1", "0")
        u5 = IIf(Me.Favorit_Mkt, "1", "0")
        u6 = IIf(Me.Rule_NoDayTrd, "1", "0")
        u7 = IIf(Me.Rule_NoCrssTrd, "1", "0")
        
        order = "INSERT INTO TFUNDOS (ID, NOME, CNPJ, QUALIF, IDTITULO, CONSOLIDATION, " + _
                "TIPO, PRAZORESGATE, LIQNOME, LIQMETHOD, CAIXAMANDATO, " + _
                "OVERRIDELIMITS, LIM_VAR, LIM_STRESS, LIM_EL, LIM_UL, CONCENTRACAO, TIPO409, " + _
                "CREDLIMREGULAM, DT_CREATED, DT_DELETED, DELETED, AREA, FAVORIT_CASH, FAVORIT_CREDIT, " + _
                "FAVORIT_MKT, TOLERANCIA1, TOLERANCIA2, LIM_DUR, NOMEBLOTTER, RULE_NODAYTRD, RULE_NOCRSSTRD) " + _
                "VALUES " + _
                "(" + Str(Me.ID) + ", '" + _
                Me.nome + "', '" + Me.CNPJ + "','" + Me.qualif + "', '" + Me.IDTitulo + "','" + Me.Consol + _
                "','" + Me.Tipo + "'," + Str(Me.PrazoResgate) + ", '" + Me.nomeLiq + "', '" + Me.LiqMethod + _
                "'," + Str(Me.CaixaMandato) + ", " + u + ", " + Str(Me.LIM_VaR) + ", " + Str(Me.LIM_Stress) + _
                ", " + Str(Me.LIM_EL) + ", " + Str(Me.LIM_UL) + ", " + "'" + Me.Concentracao + "','" + Me.tipo409 + _
                "'," + u2 + "," + SQLD(Me.Dt_Created) + "," + SQLBaseDate + ",0,'" + Me.area + "'," + U3 + _
                "," + u4 + "," + u5 + "," + Str(Me.Tolerancia1) + "," + Str(Me.Tolerancia2) + "," + _
                Str(Me.LIM_Dur) + ",'" + Me.nomeBlotter + "'," + u6 + "," + u7 + ")"
        
        If Not rs.EOF Then
            rs.Close
            db.Execute ("DELETE FROM TFUNDOS WHERE ID=" + Str(Me.ID))
        Else
            rs.Close
        End If
        
        db.Execute (order)
        
        db.Execute ("DELETE FROM TFUNDOBOOK WHERE FUNDO=" + Str(Me.ID))
        For Each b In MyBooks
            db.Execute ("INSERT INTO TFUNDOBOOK (FUNDO, BOOK) VALUES (" + Str(Me.ID) + ", " + Str(b.ID) + ")")
        Next b
        
        
    End If
End Sub


Public Function tempapel(ID As String) As Boolean
    Dim p As CPosic, a As Boolean
    a = False
    For Each p In Me.MyPosics
        a = a Or (p.Papel.ID = ID)
    Next
    tempapel = a
End Function


Public Sub PapelValues(nome As String, Consol As Boolean, ByRef Valor As Double, ByRef Quant As Double)
    'Esta sub opera por NOME, dada a possibilidade de 2 registros com mesmo NOME
    'É usada na maioria das telas informativas de posição consolidada
    Dim p As CPosic, a As Double, g As Collection
    Valor = 0
    Quant = 0
    If Consol Then Set g = MyPosicConsol Else Set g = MyPosics
    For Each p In g
        If p.Papel.nome = nome Then
            Valor = Valor + p.Valor
            Quant = Quant + p.Quant
        End If
    Next
End Sub


Public Function PplRecValue(pp As CPapel) As Double
    'Esta função opera por REGISTRO
    'É usada para gerar as propriedades de alocação por registro de papel
    'Só opera sober a carteira consolidada
    Dim p As CPosic, a As Double, g As Collection
    a = 0
    For Each p In MyPosics
        If p.Papel Is pp Then a = a + p.Valor
    Next
    PplRecValue = a
End Function


Public Function PplIHavePaper(pp As CPapel) As Boolean
    'Esta função opera por REGISTRO
    'Informa se existe o papel na carteira direta ou consolidada
    'Usada em Recalc
    Dim p As CPosic, g As Collection, a As Boolean
    a = False
    For Each p In MyPosics
        If p.Papel Is pp Then a = True
    Next
    If Not a Then
        For Each p In MyPosicConsol
            If p.Papel Is pp Then a = True
        Next
    End If
    PplIHavePaper = a
End Function


'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                              L   I   Q   U   I   D   E   Z
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Property Get PctCaixa() As Double
    Dim x As CPosic, a As Collection, cx As Double, ct As Double
    Set a = MyPosicConsol
    For Each x In a
        ct = ct + x.Valor
        If x.Papel.ehcaixa Then cx = cx + x.Valor
    Next x
    If ct = 0 Then PctCaixa = 0 Else PctCaixa = cx / ct
End Property

Property Get CaixaTt() As Double
    'Calcula o Caixa (para alocação)
    Dim x As CPosic, a As Collection, cx As Double
    Set a = MyPosicConsol
    cx = 0
    For Each x In a
        If x.Papel.ehcaixa Then cx = cx + x.Valor
    Next x
    CaixaTt = cx
End Property

Property Get Disp() As Double
    'Calcula o disponível D1
    Dim x As CPosic, a As Collection, cx As Double
    Set a = MyPosics
    cx = 0
    For Each x In a
        If Not x.Papel.Fundo Then
            If x.Papel.ehcaixa Then cx = cx + x.Valor
        ElseIf x.Papel.MyFundo Is Nothing Then
            WriteLogError "Fundo não encontrado", x.Papel.nome
        ElseIf x.Papel.MyFundo.PrazoResgate < 2 Then
            If x.Papel.MyFundo.area = "EXTERNO" Or x.Papel.MyFundo Is Me Then
                cx = cx + x.Valor
            Else
                'Fundo interno: consolidação
                Select Case Consol
                    Case "PROPORCIONAL"
                        cx = cx + x.Papel.MyFundo.Disp * x.Valor / x.Papel.MyFundo.PLTotal
                    Case "FULL"
                        cx = cx + x.Papel.MyFundo.Disp
                    Case "ATIVA"
                        cx = cx + 0
                End Select
            End If
        End If
    Next x
    Disp = cx
End Property


Public Sub ResetResgate()
    NResg = 0
End Sub

Public Sub InlcluiResgate(d As Date, v As Double, t As Boolean, d0 As Date)
    NResg = NResg + 1
    ResgatesV(NResg) = v
    ResgatesD(NResg) = d
    ResgatesT(NResg) = t
    ResgatesD0(NResg) = d0
End Sub

Public Sub ResetTransf()
    NTrans = 0
End Sub

Public Sub InlcluiTransf(d As Date, v As Double)
    NTrans = NTrans + 1
    TransferV(NTrans) = v
    TransferD(NTrans) = d
End Sub


Property Get CaixaMinimo() As Double
    Dim p As CPosic, a As Double
    
    If Me.Tipo = "CONS" Then
        a = 0
        For Each p In MyPosics
            If Not p.Papel.MyFundo Is Nothing Then
                a = a + p.Papel.MyFundo.CaixaMandato * p.Valor
            Else
                a = a + Me.CaixaMandato * p.Valor
            End If
        Next p
        If a = 0 Or PLTotal = 0 Then CaixaMinimo = Me.CaixaMandato Else CaixaMinimo = a / PLTotal
    Else
        CaixaMinimo = Me.CaixaMandato
    End If
End Property


Public Function liquidityAteh(d As Date, Optional method As String = "DEFAULT") As Double
    'LiquidityAteh do Fundo: apenas a soma das liquidityAteh das posições
    '
    Dim b As Collection, a As Double, x As CPosic
    Set b = MyPosicConsol
    a = 0
    If method = "DEFAULT" Then method = Me.LiqMethod
    For Each x In b
        a = a + x.liquidityAteh(d, method)
    Next x
    liquidityAteh = a
End Function

Public Function ResgatesAteh(d As Date) As Double
    Dim i As Integer, a As Double, p1 As CPosic, plt As Double, dlt As Double
    a = 0
    
    If Tipo = "CONS" Then
        'Consolidado: soma a carteira
        For Each p1 In MyPosics
            If p1.Papel.Fundo And Not p1.Papel.MyFundo Is Nothing Then
                If Consol = "FULL" Then
                    dlt = 1
                Else
                    plt = p1.Papel.MyFundo.PLTotal
                    If plt = 0 Then dlt = 1 Else dlt = p1.Valor / plt
                End If
                a = a + dlt * p1.Papel.MyFundo.ResgatesAteh(d)
            End If
        Next p1
    Else
        'Fundo normal: consulta a fila
        For i = 1 To NResg
            If ResgatesD(i) <= d Then
                If ResgatesT(i) Then
                    'Resgate total: corrige pelo CDI
                    a = a + ResgatesV(i) * (1 + RiskMgr.GenLvlDI) ^ ((ResgatesD(i) - ResgatesD0(i)) / 365.25)
                Else
                    'Resgate parcial: deixa como está
                    a = a + ResgatesV(i)
                End If
            End If
        Next i
    End If
    ResgatesAteh = a
End Function

Public Function TransfersAteh(d As Date) As Double
    Dim i As Integer, a As Double, p1 As CPosic, plt As Double, dlt As Double
    a = 0
    If Tipo = "CONS" Then
        'Consolidado: soma a carteira
        For Each p1 In MyPosics
            If p1.Papel.Fundo And Not p1.Papel.MyFundo Is Nothing Then
                If Consol = "FULL" Then
                    dlt = 1
                Else
                    plt = p1.Papel.MyFundo.PLTotal
                    If plt = 0 Then dlt = 1 Else dlt = p1.Valor / plt
                End If
                a = a + dlt * p1.Papel.MyFundo.TransfersAteh(d)
            End If
        Next p1
    Else
        'Fundo normal: consulta a fila
        For i = 1 To NTrans
            If TransferD(i) <= d Then a = a + TransferV(i)
        Next i
    End If
    TransfersAteh = a
End Function


'-------------------------------------------------------------------------------------------------------
'Ajuste de Concentração - VERSÃO I
'-------------------------------------------------------------------------------------------------------
Public Function AjusteConcentrAteh(d As Date) As Double

    Dim i As Integer, a As Double, p1 As CPosic, plt As Double, dlt As Double, PLFuturo As Double
    a = 0
    If Tipo = "CONS" Then
        'Consolidado: soma a carteira
        For Each p1 In MyPosics
            If p1.Papel.Fundo And Not p1.Papel.MyFundo Is Nothing Then
                If Consol = "FULL" Then
                    dlt = 1
                Else
                    plt = p1.Papel.MyFundo.PLTotal
                    If plt = 0 Then dlt = 1 Else dlt = p1.Valor / plt
                End If
                a = a + dlt * p1.Papel.MyFundo.AjusteConcentrAteh(d)
            End If
        Next p1
    ElseIf Tipo <> "CLOSED" And Tipo <> "EXCLUSIVO" And Tipo <> "FECHADO" Then
        'Fundo normal: verifica o PL do maior cotista e data de cotização
        If PLTotal > 0 And MaiorCotista > 0.2 * PLTotal And (d - BaseDate > PrazoResgate) Then
            v = MaiorCotista / PLTotal - 0.2
            PLFuturo = PLTotal - ResgatesAteh(d)
            a = (1 - Exp(-v * Sqr((d - BaseDate - PrazoResgate) / 365))) * (PLTotal + PLFuturo) / 2
        End If
    End If

    AjusteConcentrAteh = a
End Function

Public Function LiqNeededStressCVM() As Double
    'Liquidez CVM
    LiqNeededStressCVM = Config.GetLiqStress(tipo409, Concentracao) * PLTotal
End Function

Public Function VolResgEfet() As Double
    VolResgEfet = max(0.12, max(VolResg, min(VolPL, 0.35)))
End Function

Public Function ResgateEsperadoAteh(d As Date) As Double
    Dim PLFuturo As Double
    If (d - BaseDate) < PrazoResgate Or Tipo = "CLOSED" Then
        ResgateEsperadoAteh = 0
    Else
        PLFuturo = PLTotal - ResgatesAteh(d)
        'ResgateEsperadoAteh = (1 - Exp(-max(VolPL, 0.12) * Sqr((d - BaseDate - PrazoResgate) / 365))) * (PLTotal + PLFuturo) / 2
        ResgateEsperadoAteh = (1 - Exp(-VolResgEfet * Sqr((d - BaseDate - PrazoResgate) / 365))) * (PLTotal + PLFuturo) / 2
    End If
End Function

Public Function LiqNeededAteh(d As Date) As Double
    LiqNeededAteh = min(PLTotal, max(0, ResgatesAteh(d) - TransfersAteh(d) + ResgateEsperadoAteh(d) + AjusteConcentrAteh(d)))
End Function

Public Function LiqExResgAteh(d As Date) As Double
    LiqExResgAteh = min(PLTotal, max(0, ResgateEsperadoAteh(d) + AjusteConcentrAteh(d)))
End Function

Public Function LiqCovAteh(d As Date, Optional method As String = "DEFAULT") As Double
    a = liquidityAteh(d, method)
    If a = 0 Then LiqCovAteh = 1 Else LiqCovAteh = LiqNeededAteh(d) / a
End Function

Public Function LiquidityOK() As String
    l1 = LiqCovAteh(BaseDate + 1)
    l5 = LiqCovAteh(BaseDate + 7)
    l21 = LiqCovAteh(BaseDate + 30)
    l42 = LiqCovAteh(BaseDate + 60)
    l63 = LiqCovAteh(BaseDate + 90)
    l126 = LiqCovAteh(BaseDate + 182)
    l252 = LiqCovAteh(BaseDate + 365)

    If l1 <= 0.8 And l5 <= 0.8 And l21 <= 0.8 And l42 <= 0.8 And l63 <= 0.8 And l126 <= 0.8 And l252 <= 0.8 Then
        LiquidityOK = "OK"
    ElseIf l1 <= 1 And l5 <= 1 And l21 <= 1 And l42 <= 1 And l63 <= 1 And l126 <= 1 And l252 <= 1 Then
        LiquidityOK = "WARN"
    Else
        LiquidityOK = "BREACH"
    End If
End Function

Public Function IAmCompliantWithMarketRisk() As String
    If Me.Static_LV = "OK" And Me.Static_LS = "OK" Then
        IAmCompliantWithMarketRisk = "OK"
    ElseIf Me.Static_LV = "BREACH" Or Me.Static_LS = "BREACH" Then
        IAmCompliantWithMarketRisk = "BREACH"
    Else
        IAmCompliantWithMarketRisk = "WARN"
    End If
End Function

Public Function IAmCompliantWithCreditRisk() As String
    If Me.Static_LE = "OK" And Me.Static_LU = "OK" Then
        IAmCompliantWithCreditRisk = "OK"
    ElseIf Me.Static_LE = "BREACH" Or Me.Static_LU = "BREACH" Then
        IAmCompliantWithCreditRisk = "BREACH"
    Else
        IAmCompliantWithCreditRisk = "WARN"
    End If
End Function

Public Function IAmCompliantWithCreditIRB() As String
    If Me.Static_LE1 = "OK" And Me.Static_LU1 = "OK" Then
        IAmCompliantWithCreditIRB = "OK"
    ElseIf Me.Static_LE1 = "BREACH" Or Me.Static_LU1 = "BREACH" Then
        IAmCompliantWithCreditIRB = "BREACH"
    Else
        IAmCompliantWithCreditIRB = "WARN"
    End If
End Function


Private Function LimiteOK(qual As String) As String
    'Necessita que os Estáticos estejam fixados
    Dim L As Double, x As Double
    L = Limite(qual)
    Select Case UCase(qual)
        Case "V", "VAR"
            x = Me.StaticVar
        Case "S", "STRESS"
            x = Me.StaticStress
        Case "E", "EL"
            x = Me.StaticEL
        Case "U", "UL"
            x = Me.StaticUL
        Case "E1"
            x = Me.StaticEL1
        Case "U1"
            x = Me.StaticUL1
    End Select
    If Abs(x) > L Then
        LimiteOK = "BREACH"
    ElseIf Abs(x) > 0.8 * L And Config.WarnAt20 Then
        LimiteOK = "WARN"
    Else
        LimiteOK = "OK"
    End If
End Function

Public Function LiqStressPercentile(Optional Meses As Integer = 12) As Double
    Dim d As Date
    d = DateSerial(Year(BaseDate), Month(BaseDate) + Meses, Day(BaseDate))
    LiqStressPercentile = RiskMgr.LiqPercent(d, (liquidityAteh(d, "ADTV") - ResgatesAteh(d)) / max(1, PLTotal))
End Function


'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                                        R   I   S   C   O
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Public Function GetAllQuotasFrom(d As Date) As Collection
    Dim db As ADODB.Connection, rs As ADODB.Recordset, a As New Collection, u As CNomeValor
    
    Set db = OpenTheDatabase
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM TQUOTAS WHERE FUNDO = " + Str(Me.ID) + "AND DATA>=" + SQLD(d) + " AND DATA<=" + SQLBaseDate + " ORDER BY DATA", db, adOpenForwardOnly, adLockReadOnly)
    While Not rs.EOF
        Set u = New CNomeValor
        u.Data = rs("DATA")
        u.Valor = rs("QUOTA")
        a.Add u
        rs.MoveNext
    Wend
    Set GetAllQuotasFrom = a
    
End Function


Public Sub GetYourQuotasIn(x As Variant)
    'Procura as quotas no array "GetRows" x
    Dim u As CNomeValor, i As Integer, hi As Integer, lo As Integer, N As Integer
    '---- localiza o início do fundo
    N = UBound(x, 2)
    hi = N: lo = 0: i = (hi + lo) \ 2
    While x(1, i) <> ID And hi > lo
        If x(1, i) > ID Then hi = i - 1 Else lo = i + 1
        i = (hi + lo) \ 2
    Wend
    
    If x(1, i) = ID Then
        While x(1, i) = ID And i > 1
            i = i - 1
        Wend
        If x(1, i) <> ID Then i = i + 1
    End If
            
    '---- lê as quotas
    Set MyQuotas = New Collection
    If x(1, i) = ID Then
        While x(1, i) = ID And i < N
            Set u = New CNomeValor
            u.Data = x(0, i)
            u.Valor = x(2, i)
            MyQuotas.Add u
            i = i + 1
        Wend
        If i = N And x(0, i) = ID Then
            Set u = New CNomeValor
            u.Data = x(0, i)
            u.Valor = x(2, i)
            MyQuotas.Add u
        End If
    End If
End Sub


Private Sub ComputeRisk()
    Dim b As Collection, x As CPosic, d As Date, VaR1 As Double, Stress1 As Double, Exposure As Double, ExpImob As Double
    Dim t1 As Double, t2 As Double, t3 As Double, t4 As Double, t5 As Double, t6 As Double, t7 As Double, t8 As Double
    Dim pltot As Double, PD As Double, PD1 As Double, LGD As Double, EL As Double, EL1 As Double, L As Double
    Dim UL(2000) As Double, UL1(2000) As Double, setor(2000) As String, sectorindex As Integer, AssetCorrelation1 As Double, AssetCorrelation2 As Double
    Dim VolIPCA0 As Double, VolPre0 As Double, StressIPCA0 As Double, StressPre0 As Double
    Dim Lambda As Double, v As Double, p As Double, k As Integer, i As Integer
    Dim ProvPD As Double, LastRatYs As Double, spread As Double
    
    Set b = MyPosicConsol

    '---------------------------------CALCULA RISCO DE MERCADO
        VaR1 = 0
        Stress1 = 0
        t1 = 0: t2 = 0: t3 = 0: t4 = 0: t5 = 0: t6 = 0: t7 = 0: t8 = 0: pltot = 0
        VolIPCA0 = RiskMgr.VolIPCA(BaseDate + 365)
        VolPre0 = RiskMgr.VolPRE(BaseDate + 365)
        StressIPCA0 = RiskMgr.StressIPCA(BaseDate + 365)
        StressPre0 = RiskMgr.StressPRE(BaseDate + 365)
        
        For Each x In b
        
            If x.Papel.Tipo = "FUTUROS" Then Exposure = x.Quant Else Exposure = x.Valor
                                      
            d = x.Papel.PresumedMaturity
            
            ExpImob = x.Papel.MktEImob
                           
            t1 = t1 + Exposure * ExpImob
            t2 = t2 + Exposure * x.Papel.MktEIPCA * RiskMgr.VolIPCA(d) / VolIPCA0
            t3 = t3 + Exposure * x.Papel.MktEPre * RiskMgr.VolPRE(d) / VolPre0
            t4 = t4 + Exposure * x.Papel.MktEDolar
            t8 = t8 + Exposure * x.Papel.MktEIDA
            
            t5 = t5 + Exposure * x.Papel.MktEIPCA * RiskMgr.StressIPCA(d) / StressIPCA0
            t6 = t6 + Exposure * x.Papel.MktEPre * RiskMgr.StressPRE(d) / StressPre0
            
            If ExpImob > 0 Then
                If x.Papel.Holdings > 0 _
                    Then t7 = t7 + Abs(Exposure) ^ 2 / x.Papel.Holdings _
                    Else t7 = t7 + Abs(Exposure) ^ 2
            End If
            
            pltot = pltot + x.Valor
            
        Next x
        
        VaR1 = (Abs(t1) * RiskMgr.VolIFIX + _
                Abs(t2) * VolIPCA0 / 100 + _
                Abs(t3) * VolPre0 / 100 + _
                Abs(t4) * RiskMgr.VolDolar + _
                Abs(t8) * RiskMgr.VolIDA + _
                Sqr(t7) * RiskMgr.VolIdio) * Config.VaRConf
                           
        Stress1 = (Abs(t1) * RiskMgr.StressIFIX + _
                    Abs(t5) * StressIPCA0 / 100 + _
                    Abs(t6) * StressPre0 / 100 + _
                    Abs(t4) * RiskMgr.StressDolar + _
                    Abs(t8) * RiskMgr.StressIDA + _
                    Sqr(t7) * RiskMgr.StressIdio)
        
        If pltot > 0 Then
            StaticVar = -VaR1 / pltot
            StaticStress = -Stress1 / pltot
            StaticEImob = t1 / pltot
            StaticEInfl = t2 / pltot
            StaticEPre = t3 / pltot
            StaticEIDA = t8 / pltot
            StaticEDolar = t4 / pltot
            StaticEIdio = Sqr(t7) / pltot
        Else
            StaticVar = 0
            StaticStress = 0
            StaticEImob = 0
            StaticEInfl = 0
            StaticEPre = 0
            StaticEIDA = 0
            StaticEDolar = 0
            StaticEIdio = 0
        End If
        
        Static_LV = LimiteOK("VaR")
        Static_LS = LimiteOK("Stress")
        
    '----------------------------CALCULA VAR DA QUOTA
        k = MyQuotas.Count
        If k > 1 Then
            p = 0: v = 0: Lambda = RiskMgr.Lambda
            For i = 0 To k - 2
                If MyQuotas(k - i - 1).Valor > 0 Then v = v + Log(MyQuotas(k - i).Valor / MyQuotas(k - i - 1).Valor) ^ 2 * Lambda ^ i
                p = p + Lambda ^ i
            Next i
        End If
        If p > 0 Then StaticVarQuota = -Sqr(v / p) * 2.33
        
        
        
    '----------------------------CALCULA RISCO DE CRÉDITO
        AssetCorrelation1 = Config.CredCorrel
        AssetCorrelation2 = Config.CredCorrelIntra
        sectorindex = Props.SearchIndexByName(Config.CredGroupProperty)
        EL = 0
        TUL = 0
        N = b.Count
        For i = 1 To N
            Set x = b(i)
            v = Abs(x.Valor)
            If sectorindex <> 0 Then setor(i) = x.Papel.PropV(sectorindex)
            PD = x.Papel.AdjCredPD
            PD1 = x.Papel.IRBPD
            LGD = x.Papel.CredLGD
            EL = EL + v * PD * LGD
            EL1 = EL1 + v * PD1 * LGD
            '0.2 aqui é a volatilidade do LGD
            'PD*(1-PD) é a volatilidade^2 da PD (Bernoulli)
            'LGD*(1-LGD)/4 é a volatilidade^2 da LGD (Beta)
            UL(i) = v * Sqr(PD * LGD * (1 - LGD) / 4 + LGD ^ 2 * PD * (1 - PD))
            UL1(i) = v * Sqr(PD1 * LGD * (1 - LGD) / 4 + LGD ^ 2 * PD1 * (1 - PD1))
        Next i
        For i = 1 To N
            For j = 1 To N
                If i = j Then
                    TUL = TUL + UL(i) ^ 2
                    TUL1 = TUL1 + UL1(i) ^ 2
                ElseIf setor(i) = setor(j) Then
                    TUL = TUL + UL(i) * UL(j) * AssetCorrelation2
                    TUL1 = TUL1 + UL1(i) * UL1(j) * AssetCorrelation2
                Else
                    TUL = TUL + UL(i) * UL(j) * AssetCorrelation1
                    TUL1 = TUL1 + UL1(i) * UL1(j) * AssetCorrelation1
                End If
            Next j
        Next i
        If TUL > 0 Then TUL = Sqr(TUL)
        If TUL1 > 0 Then TUL1 = Sqr(TUL1)
        
        If PLTotal > 0 Then
            StaticEL = EL / pltot
            StaticEL1 = EL1 / pltot
            
            'CVaR de 90% : Beta(EL, UL)
            'T-stat(90%) da Beta(UL) = 0.2042 ln(UL) + 0.7755
            If TUL <= 0 Then TStatBeta = 1 Else TStatBeta = 0.2079 * Log(TUL / pltot) + 1.8721
            StaticUL = (TUL * TStatBeta) / pltot
            If TUL1 <= 0 Then TStatBeta = 1 Else TStatBeta = 0.2079 * Log(TUL1 / pltot) + 1.8721
            StaticUL1 = (TUL1 * TStatBeta) / pltot
            
        Else
            StaticEL = 0
            StaticUL = 0
            StaticEL1 = 0
            StaticUL1 = 0
        End If

        Static_LE = LimiteOK("E")
        Static_LU = LimiteOK("U")
        Static_LE1 = LimiteOK("E1")
        Static_LU1 = LimiteOK("U1")
        
        Static_Rating = RatingFromPD(StaticEL1 / 0.75)
        
    '----- Calcula Spread
        StaticFundSpread = 0
        For Each x In b
            Select Case x.Papel.Index
                Case "CDI+"
                    spread = x.Papel.Coupon
                Case "%CDI"
                    spread = (x.Papel.Coupon - 1) * RiskMgr.GenLvlDI
                Case "FIXED", "FIXO", "PRE"
                    spread = x.Papel.Coupon - RiskMgr.GenLvlDI
                Case "IPCA+", "IGPDI+", "IGPM+"
                    spread = x.Papel.Coupon - RiskMgr.GenLvlInfCupom
                Case Else
                    spread = 0
            End Select
            StaticFundSpread = StaticFundSpread + spread * x.Valor
        Next x
        If pltot > 0 Then StaticFundSpread = StaticFundSpread / pltot Else StaticFundSpread = 0
End Sub


Public Function Duration() As Double
    Duration = StaticEPre + StaticEInfl
End Function

Property Get Limite(qual As String) As Double
    If OverrideLimit Then
        Select Case Left(qual, 1)
            Case "V"
                Limite = LIM_VaR
            Case "S"
                Limite = LIM_Stress
            Case "E" ' e "E1"
                Limite = LIM_EL
            Case "U" ' "U1"
                Limite = LIM_UL
            Case "D"
                Limite = LIM_Dur
        End Select
        
    ElseIf Tipo = "EXCLUSIVO" Or Tipo = "CONS" Or qualif = "PROF" Then
        Select Case Left(qual, 1)
            Case "V"
                Limite = Config.LVP
            Case "S"
                Limite = Config.LSP
            Case "E" ' e "E1"
                Limite = Config.LEP
            Case "U" ' e "U1"
                Limite = Config.LUP
            Case "D"
                Limite = 100
        End Select
        
        
    ElseIf qualif = "QUALI" Then
        Select Case Left(qual, 1)
            Case "V"
                Limite = Config.LVQ
            Case "S"
                Limite = Config.LSQ
            Case "E" ' e "E1"
                Limite = Config.LEQ
            Case "U" ' e "U1"
                Limite = Config.LUQ
            Case "D"
                Limite = 100
        End Select
        
    Else
        Select Case Left(qual, 1)
            Case "V"
                Limite = Config.LVV
            Case "S"
                Limite = Config.LSV
            Case "E" ' e "E1"
                Limite = Config.LEV
            Case "U" ' e "U1"
                Limite = Config.LUV
            Case "D"
                Limite = 100
        End Select
    End If
End Property


Public Sub Recalc()
    'PLTotal já tem que ter sido atualizado em Consolida
    'Essa rotina coloca o risco e o caixa nas variáveis estáticas
    ComputeRisk
    StaticLiquidityOK = LiquidityOK
    StaticDisp = Me.Disp
    StaticCash = Me.CaixaTt
    StaticCashPct = Me.PctCaixa
    StaticCashFreePct = (Me.PctCaixa - Me.CaixaMinimo)
    StaticCashFree = StaticCashFreePct * PLTotal
    PTCExecuted = False
End Sub


'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                             C A R T E I R A    S I M U L A D A
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Public Function CarteiraSimulada(qual As String, Optional Trade As CTrade = Nothing, Optional C0 As Collection) As Collection
    'PD_1 - MyPosics (fechada) de D-1
    'CD_1 - MyPosicsConsol (aberta) de D-1
    '+ Trade (or Nothing)
    '
    'Essa função CRIA uma coleção com NOVOS CPosic
    
    Dim a As New Collection, x As CPosic, z As CPosic, CashBalance As Double
    
    Select Case qual
    
        Case "P0"
            'Carteira fornecida + Trade
            CashBalance = 0
            For Each x In C0
                Set z = New CPosic
                Set z.Papel = x.Papel
                z.Fundo = x.Fundo
                z.Valor0 = x.Valor
                z.Quant0 = x.Quant
                z.LiqConstraint = x.LiqConstraint
                If Not Trade Is Nothing Then
                    If Trade.MyFund Is Me And Trade.MyPaper Is x.Papel Then
                        z.Valor0 = z.Valor0 + Trade.ValFinCV
                        z.Quant0 = z.Quant0 + Trade.QuantCV
                        CashBalance = CashBalance - Trade.ValFinCV
                    End If
                End If
                a.Add z
            Next x
    
        Case "PD_1"
            'Carteira de otem + Trade
            CashBalance = 0
            For Each x In MyPosics
                Set z = New CPosic
                Set z.Papel = x.Papel
                z.Fundo = x.Fundo
                z.Valor0 = x.ValorD_1
                z.Quant0 = x.QuantD_1
                z.LiqConstraint = x.LiqConstraint
                If Not Trade Is Nothing Then
                    If Trade.MyFund Is Me And Trade.MyPaper Is x.Papel Then
                        z.Valor0 = z.Valor0 + Trade.ValFinCV
                        z.Quant0 = z.Quant0 + Trade.QuantCV
                        CashBalance = CashBalance - Trade.ValFinCV
                    End If
                End If
                a.Add z
            Next x
        
        Case "CD_1"
            'Consolidada de ontem + Trade
            CashBalance = 0
            For Each x In MyPosics
                If x.Papel.Fundo And Not x.Papel.MyFundo Is Nothing Then
                    If Not x.Papel.MyFundo Is Me Then
                        Set b1 = x.Papel.MyFundo.CarteiraSimulada(qual, Trade, C0)
                        PLDoInvestido = x.Papel.MyFundo.PLTotal
                        If PLDoInvestido > 0 Then
                            For Each y In b1
                                Set z = New CPosic
                                Set z.Papel = y.Papel
                                z.Fundo = x.Fundo
                                z.Valor0 = y.ValorD_1 * x.Valor / PLDoInvestido
                                z.Quant0 = y.QuantD_1 * x.Valor / PLDoInvestido
                                z.LiqConstraint = y.LiqConstraint
                                a.Add z
                            Next y
                        Else
                            WriteLogError "PL zerado em consolidação de carteira", x.Papel.MyFundo.nome
                        End If 'pl do investido>0
                    End If 'not me
                Else
                    'chegou na folha
                    Set z = New CPosic
                    Set z.Papel = x.Papel
                    z.Fundo = x.Fundo
                    z.Valor0 = x.ValorD_1
                    z.Quant0 = x.QuantD_1
                    x.LiqConstraint = x.LiqConstraint
                    If Not Trade Is Nothing Then
                        If Trade.MyFund Is Me And Trade.MyPaper Is x.Papel Then
                            z.Valor0 = z.Valor0 + Trade.ValFinCV
                            z.Quant0 = z.Quant0 + Trade.QuantCV
                            CashBalance = CashBalance - Trade.ValFinCV
                        End If
                    End If
                    a.Add z
                End If
            Next x
    End Select
    
    'Lança o CashBalance - Cria nova posição com papel BestCash
    If CashBalance <> 0 Then
        Set z = New CPosic
        Set z.Papel = Papeis.BestCash
        z.Valor0 = CashBalance
        z.Fundo = Me.ID
        z.Quant0 = 1
        z.LiqConstraint = 0
        a.Add z
    End If
    
    Set CarteiraSimulada = a
End Function



'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                             P r é    T r a d e    C o m p l i a n c e
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Public Function ConsolidatedTrades() As Collection
    Dim x As CPosic, a As Collection, b As Collection, u As CTrade, u1 As CTrade, jatem As Boolean
    Set a = New Collection
    For Each x In MyPosics
        If x.Papel.Fundo And Not x.Papel.MyFundo Is Nothing Then
            If Not x.Papel.MyFundo Is Me Then
                Set b = x.Papel.MyFundo.ConsolidatedTrades
                For Each u In b
                    jatem = False
                    For Each u1 In a
                        If u Is u1 Then jatem = True
                    Next u1
                    If Not jatem Then a.Add u
                Next u
            End If
        End If
    Next x
    For Each u In MyTrades
        If u.Data = BaseDate Then a.Add u
    Next u
    Set ConsolidatedTrades = a
End Function


Public Function QL(ccc As Collection) As Double
    aaa = 0
    For Each kkk In ccc
        If InStr(kkk.Papel.nome, "Light") > 0 Then aaa = aaa + kkk.Quant
    Next kkk
    QL = aaa
End Function


Public Sub PreTradeCompliance()
    Dim LTrades As Collection, u As CPreTradeCompItem, a As Integer
    Dim t As CTrade, c1 As Collection, p1 As Collection, c2 As Collection, p2 As Collection
    Dim b As Collection
    
    Set PTCNodes = New Collection
    Set LTrades = ConsolidatedTrades
    PTCNTrades = LTrades.Count
    
    If PTCNTrades = 0 Then
        'Faz Comparação de compliance da Carteira
        Set PTCNodes = ComparaCompliance(CarteiraSimulada("PD_1"), CarteiraSimulada("CD_1"), MyPosics, MyPosicConsol)
    Else
        'Faz comparação de todos os trades
        Set c1 = CarteiraSimulada("CD_1")
        Set p1 = CarteiraSimulada("PD_1")
        '---->Inserir aqui a ordenação de LTrades conforme Política
        'Percorre todos os trades
            For Each t In LTrades
                Set c2 = CarteiraSimulada("P0", t, c1)
                Set p2 = CarteiraSimulada("P0", t, p1)
                Set b = ComparaCompliance(p1, c1, p2, c2)
                For Each u In b
                    Set u.MyTrade = t
                    u.Trade = t.ID
                    PTCNodes.Add u
                Next u
                Set c1 = c2
                Set p1 = p2
            Next t
    End If
    
    PTCResult = 0
    For Each u In PTCNodes
        PTCResult = max(PTCResult, u.Result)
    Next u
    
    PTCExecuted = True
End Sub


Private Function ComparaCompliance(p1 As Collection, c1 As Collection, p2 As Collection, c2 As Collection) As Collection
    'Testa 2 carteiras, todas as regras
    
    Dim b As CBook, r As CRegra
    Dim plr1 As Double, plr2 As Double, pp1 As String, pp2 As String
    Dim RR1 As CRuleResult, RR2 As CRuleResult
    
    Dim a As New Collection
    For Each b In MyBooks
        For Each r In b.c
        
            Set u = New CPreTradeCompItem
            Set u.regra = r
            Set RR1 = New CRuleResult
            Set RR2 = New CRuleResult
            
            u.Book = b.nome
            
            If r.Aberta Then
                Set RR1 = ComputeRule(r, c1)
                Set RR2 = ComputeRule(r, c2)
            Else
                Set RR1 = ComputeRule(r, p1)
                Set RR2 = ComputeRule(r, p2)
            End If
            
            u.PLSubA = RR1.MaxOut
            u.PLSubB = RR2.MaxOut
            u.DeltaA = RR1.Delta
            u.DeltaB = RR2.Delta
            u.PapeisA = RR1.PapelDescr
            u.PapeisB = RR2.PapelDescr
            
            If RR2.Delta > 0 And RR1.Delta = 0 Then
                'Violou
                u.Result = 3
            ElseIf RR2.Delta > 0 And (RR2.Delta - RR1.Delta) > 0.0001 * PLTotal Then
                'Piorou
                u.Result = 2
            ElseIf RR2.Delta = 0 And RR1.Delta > 0 Then
                'Resolveu
                u.Result = 1
            Else
                'Nada
                u.Result = 0
            End If
            
            a.Add u
        Next r
    Next b
    Set ComparaCompliance = a
End Function



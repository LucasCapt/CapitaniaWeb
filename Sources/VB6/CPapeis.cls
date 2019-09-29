VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CPapeis"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public c As New Collection
Public akaList As New Collection

Public c_TitPublico As New Collection
Public c_Cotas As New Collection
Public c_CDB As New Collection
Public c_LF As New Collection
Public c_Debenture As New Collection
Public c_CRI As New Collection
Public c_Outros As New Collection
Public c_Acao As New Collection
Public c_Futuros As New Collection
Public c_FII As New Collection
Public c_FIDC As New Collection

Private PapelProp As Collection 'coleção usada para acelerar a leitura dos papéis

Public BestCash As CPapel


'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                            T Y P E     C O L L E C T I O N
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Property Get TypeCollection(i As Integer) As Collection
    Select Case i
        Case 1
            Set TypeCollection = c_TitPublico
        Case 2
            Set TypeCollection = c_Cotas
        Case 3
            Set TypeCollection = c_CDB
        Case 4
            Set TypeCollection = c_LF
        Case 5
            Set TypeCollection = c_Debenture
        Case 6
            Set TypeCollection = c_CRI
        Case 7
            Set TypeCollection = c_FII
        Case 8
            Set TypeCollection = c_FIDC
        Case 9
            Set TypeCollection = c_Acao
        Case 10
            Set TypeCollection = c_Futuros
        Case 11
            Set TypeCollection = c_Outros
    End Select
End Property

Property Get DisplayTypeName(i As Integer) As String
    Select Case i
        Case 1
            DisplayTypeName = "TÍTULOS PÚBLICOS"
        Case 2
            DisplayTypeName = "COTAS"
        Case 3
            DisplayTypeName = "CDB"
        Case 4
            DisplayTypeName = "LF"
        Case 5
            DisplayTypeName = "DEBÊNTURES"
        Case 6
            DisplayTypeName = "CRI"
        Case 7
            DisplayTypeName = "FII"
        Case 8
            DisplayTypeName = "FIDC"
        Case 9
            DisplayTypeName = "AÇÕES"
        Case 10
            DisplayTypeName = "FUTUROS"
        Case 11
            DisplayTypeName = "OUTROS"
    End Select
End Property

Property Get DisplayTypeTotal(i As Integer) As Double
    Dim h As Collection, p As CPapel, a As Double
    a = 0
    Set h = TypeCollection(i)
    For Each p In h
        a = a + p.PosicTotalV
    Next p
    DisplayTypeTotal = a
End Property

Property Get DisplayTypeAsset(i As Integer) As Double
    Dim h As Collection, p As CPapel, a As Double
    a = 0
    Set h = TypeCollection(i)
    For Each p In h
        a = a + p.PosicAssetV
    Next p
    DisplayTypeAsset = a
End Property


'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                      L E I T U R A    D A    B A S E
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Private Function BuscaStartPapel(x As String) As Long
    'Procura o início da série do papel na coleção sequencial PapelProp, para acelerar a leitura dos papéis
    Dim i As Long, hi As Long, lo As Long, xu As String
    xu = UCase(x)
    lo = 1
    hi = PapelProp.Count
    i = (hi + lo) \ 2
    While lo < hi And UCase(PapelProp(i).nome) <> xu
        If UCase(PapelProp(i).nome) > xu Then hi = i - 1 Else lo = i + 1
        i = (hi + lo) \ 2
    Wend
    If UCase(PapelProp(i).nome) = xu Then
        While UCase(PapelProp(i).nome) = xu And i > 1
            i = i - 1
        Wend
        i = i + 1
    Else
        i = -1
    End If
    BuscaStartPapel = i
End Function

Public Sub ReadDB(Data1 As Date)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, x As CPapel, y As CNomeValor, d As Date, i As Long, z As CProvFilterElement
    Dim td As Double, t0 As Date, ti As Integer, t0i As Date, tt1 As Double, tt2 As Double, tt3 As Double 'performance
        
    t0 = Now(): ti = 0: tt1 = 0: tt2 = 0: tt3 = 0
    Set c = New Collection
    Set db = OpenTheDatabase
    
    'Lê toda a papelprop
    t0i = Now()
    Set PapelProp = New Collection
    Set y = New CNomeValor: y.nome = "": PapelProp.Add y 'cria header
    Set rs = db.Execute("SELECT * FROM TPAPELPROP WHERE DATA<=" + SQLBaseDate + " ORDER BY PAPEL, PROPRIEDADE, DATA")
    If Not rs.EOF Then rs.MoveFirst
    While Not rs.EOF
        Set y = New CNomeValor
        y.nome = rs("PAPEL")
        y.Valor = rs("PROPRIEDADE")
        y.NomeAlt = rs("VALOR")
        PapelProp.Add y
        rs.MoveNext
    Wend
    Set y = New CNomeValor: y.nome = Chr(255): PapelProp.Add y 'cria trailer
    tt1 = tt1 + Now() - t0i
    
    
    'Lê os títulos
    Set rs = db.Execute("SELECT * FROM TPAPEL WHERE DT_CREATED<=" + SQLBaseDate + " AND NOT (DELETED AND DT_DELETED<=" + SQLBaseDate + ") ORDER BY NOME")
    If Not rs.EOF Then rs.MoveFirst
    While Not rs.EOF
        Set x = New CPapel
        x.nome = rs("Nome")
        x.ID = CritS(rs("ID"))
        x.ISIN = CritS(rs("ISIN"))
        x.CNPJ = CritS(rs("CNPJ"))
        x.Status = rs("Status")
        x.Fundo = rs("Fundo")
        x.IDFluxo = crit(rs("CashFlow_ID"))
        x.Tipo = CritS(rs("Tipo"))
        x.Class_Liq = crit(rs("Class_Liq"))
        x.Class_Rent = crit(rs("Class_Rentab"))
        x.CodCetip = crit(rs("CODCETIP"))
        x.Coupon = crit(rs("Coupon"))
        x.DayCount = crit(rs("DayCount"))
        x.Dt_Emissao = crit(rs("Data_Emissao"))
        x.Dt_Venc = crit(rs("Data_Vencto"))
        x.Duration = crit(rs("Duration"))
        x.Index = crit(rs("Index"))
        x.V_AssetValue = crit(rs("Asset_Value"))
        x.V_AssetVol = crit(rs("Asset_Vol"))
        x.V_SeniorBefore = crit(rs("Senior_Before"))
        x.Yield = crit(rs("Yield"))
        x.Dt_Created = rs("DT_CREATED")
        x.Holdings = CritN(rs("HOLDINGS"))
        x.Senior = CritS(rs("SENIOR"))
        x.NameCr = CritS(rs("NAMECR"))
        
        
        '---Lê as propriedades
            t0i = Now()
            i = BuscaStartPapel(x.ID)
            If i > 0 Then
                While PapelProp(i).nome = x.ID And i < PapelProp.Count
                    x.colocprop Int(PapelProp(i).Valor), PapelProp(i).NomeAlt
                    i = i + 1
                Wend
            End If
            tt1 = tt1 + Now() - t0i
                
                
        '---Lê o Fluxo de Caixa
            t0i = Now()
            x.ResetCFlow
            Set rs1 = db.Execute("SELECT * FROM TFLUXOS WHERE IDFLUXO = '" + x.IDFluxo + "' AND DT_CREATED<=" + SQLBaseDate + " AND NOT (DELETED AND DT_DELETED<=" + SQLBaseDate + ") ORDER BY DATA")
            x.CFFound = Not (rs1.EOF)
            While Not rs1.EOF
                x.IncluiCFlow rs1("DATA"), crit(rs1("AMORT")), crit(rs1("JUROS"))
                rs1.MoveNext
            Wend
            x.FazFluxo
            tt2 = tt2 + Now() - t0i

        
        '---Lê o ADTV
            t0i = Now()
            
            'Tenta pelo código CETIP e ID, últimos 10 dias
            Set rs1 = db.Execute("SELECT * FROM TADTV WHERE (NOME='" + x.CodCetip + "' OR NOME='" + x.ID + "') AND DATA>=" + SQLD(d - 10) + " ORDER BY DATA DESC")
            If rs1.EOF Then
                x.adtv = 0
                x.adtvClasse = 0
                x.adtvCond = 0
                x.adtvClasseCond = 0
            Else
                x.adtv = CritNN(rs1("ADTV"))
                x.adtvClasse = CritNN(rs1("ADTVCLASSE"))
                x.adtvCond = CritNN(rs1("ADTVCOND"))
                x.adtvClasseCond = CritNN(rs1("ADTVCLASSECOND"))
            End If
            
            tt3 = tt3 + Now() - t0i
                            
        c.Add x, Trim(x.ID)
             
        ti = ti + 1
        rs.MoveNext
    Wend
    
    'Lê a AKAList
    Set rs = db.Execute("SELECT * FROM TAKA WHERE DT_CREATED<=" + SQLBaseDate + " AND NOT (DELETED AND DT_DELETED<=" + SQLBaseDate + ")")
    If Not rs.EOF Then rs.MoveFirst
    Set akaList = New Collection
    While Not rs.EOF
        Set y = New CNomeValor
        y.nome = rs("FromID")
        y.NomeAlt = rs("ToID")
        akaList.Add y
        rs.MoveNext
    Wend
    
    
    
    td = (Now() - t0) * 24 * 3600
    WriteLogPerf "LE_TITULOS", ti, td
    WriteLogPerf "LE_TITULOS_PROP", ti, tt1 * 24 * 3600
    WriteLogPerf "LE_TITULOS_CFLW", ti, tt2 * 24 * 3600
    WriteLogPerf "LE_TITULOS_ADTV", ti, tt3 * 24 * 3600
    
    'Cria o BestCash
    Set BestCash = New CPapel
    BestCash.MakeMeCash
End Sub

Private Function crit(a) As Variant
    If Not IsNull(a) Then crit = a
End Function

'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                                    C R U D
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Private Function RetrieveElement(x As String) As CPapel
    Dim r As CPapel
    On Error Resume Next
    Set RetrieveElement = c(x)
    If Err.Number > 0 Then Set RetrieveElement = Nothing
    Err.Clear
End Function

Public Function search(x As String) As CPapel
    'Procura pela ID, ou na AKAList
    Dim y As CPapel, r As CPapel, h As String, z As CNomeValor
    Set r = RetrieveElement(Trim(x))
    If r Is Nothing Then
        'Procura na AKA List
        h = ""
        For Each z In akaList
            If z.nome = x Then h = z.NomeAlt
        Next z
        If h <> "" Then Set r = RetrieveElement(Trim(h))
    End If
    Set search = r
End Function


Public Function searchName(x As String) As CPapel
    Dim y As CPapel
    For Each y In c
        If UCase(y.nome) = UCase(x) Then Set searchName = y
    Next y
End Function

Public Function searchCETIP(x As String) As CPapel
    Dim y As CPapel
    For Each y In c
        If y.CodCetip = x Then Set searchCETIP = y
    Next y
End Function

Public Function searchISIN(x As String) As CPapel
    Dim y As CPapel
    For Each y In c
        If y.ISIN = x Then Set searchISIN = y
    Next y
End Function

Public Function IDdeISINNaBase(x As String) As String
    Dim db As ADODB.Connection, rs As ADODB.Recordset, y As CFundo, LastNumber As Integer
    
    
    Set db = OpenTheDatabase
    Set rs = db.Execute("SELECT * FROM TPAPEL WHERE ISIN='" + x + "' AND DT_CREATED<=" + SQLBaseDate + " AND (NOT DELETED OR DT_DELETED>=" + SQLBaseDate + ")")
    If rs.EOF Then IDdeISINNaBase = "" Else IDdeISINNaBase = CritS(rs("ID"))
    
End Function

Function IdentifierUsed(x As String) As Boolean
    'Verifica se ALGUM identificador é x
    Dim y As CPapel, a As Boolean, z As CNomeValor
    a = Not (RetrieveElement(x) Is Nothing)
    If Not a Then
        For Each y In c
            a = a Or (y.CodCetip = x) Or (y.ISIN = x) Or (UCase(y.nome) = UCase(x))
        Next y
        If Not a Then
            For Each z In akaList
                a = a Or (z.nome = x)
            Next z
        End If
    End If
    IdentifierUsed = a
End Function


Public Function Cria(x As String, Optional CreateStatus As String = "CRIADO_USER") As CPapel
    'Cria um papel com ID=x
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, p As CPapel, nome As String
    
    nome = "Unknown (" + x + ")"
    Set p = New CPapel
    p.ID = x
    p.nome = nome
    p.Fundo = False
    p.Dt_Created = BaseDate
    p.Status = CreateStatus
    Insert p, True
    
    Set Cria = p
End Function


Public Sub remove(ID As String)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset
    
    If MainStatus = "LIVE" Then
        
        Set db = OpenTheDatabase
        db.Execute ("UPDATE TPAPEL SET DELETED=TRUE, DT_DELETED=" + SQLBaseDate + " WHERE ID='" + ID + "'")
        
    End If
    j = 1
    For i = 1 To c.Count
        If c(i).ID = ID Then j = i
    Next i
    If c(j).ID = ID Then c.remove (j)
End Sub


Public Sub AKA(FromID As String, ToID As String)
    'Coloca na lista AKA e remove o velho
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset
    Dim y As New CNomeValor
    If MainStatus = "LIVE" Then
        
        Set db = OpenTheDatabase
        db.Execute ("INSERT INTO TAKA (FROMID, TOID, DT_CREATED, DT_DELETED, DELETED) VALUES ('" + FromID + "','" + ToID + "'," + SQLBaseDate + "," + SQLBaseDate + ",FALSE)")
        
    End If
    y.nome = FromID
    y.NomeAlt = ToID
    akaList.Add y, y.nome
    remove FromID
End Sub

Property Get AKAListOrderByTo() As Collection
    Dim c1 As Collection, x As CNomeValor
    Set c1 = New Collection
    For Each x In akaList
        c1.Add x
    Next x
    For i = 1 To c1.Count - 1
        For j = i + 1 To c1.Count
            If c1(j).NomeAlt < c1(i).NomeAlt Then
                Set x = c1(j)
                c1.remove j
                c1.Add x, before:=i
            End If
        Next j
    Next i
    Set AKAListOrderByTo = c1
End Property


Public Sub HighLevelCria(Optional CloneFrom As CPapel = Nothing)
    Dim xnome As String, x As CPapel
    xnome = FInput.Pergunte("Código do Papel a ser criado:")
    If xnome <> "" Then
        If search(xnome) Is Nothing Then
            Set x = Cria(xnome)
            If Not CloneFrom Is Nothing Then x.CloneFrom CloneFrom
            FTitulo.showfor x
        Else
            MsgBox ("Código já existente.")
        End If
    End If
End Sub

Public Sub Insert(Obj As CPapel, Optional UpdateIfDuplicated As Boolean = True)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, i As Integer, s1 As String, s2 As String, se As String, sv As String, dst As String, d1 As Date
    
    If MainStatus = "LIVE" Then
        
        If Obj.Fundo Then s2 = "TRUE" Else s2 = "FALSE"
        se = SQLD(Obj.Dt_Emissao)
        sv = SQLD(Obj.Dt_Venc)
        If Obj.Dt_Created <= LongTimeAgo Then
            WriteLogError "Papel sem Data de Criação Válida (corrigido).", Obj.ID
            Obj.Dt_Created = BaseDate
        End If
                
        
        Set db = OpenTheDatabase
        Set rs = db.Execute("SELECT * FROM TPAPEL WHERE ID='" + Obj.ID + "'")
        
        If rs.EOF Or UpdateIfDuplicated Then
                    
            'Coloca no Database
                db.Execute ("DELETE FROM TPAPEL WHERE ID='" + Obj.ID + "'")
                db.Execute ("INSERT INTO TPAPEL (NOME, ID, STATUS, FUNDO, CLASS_LIQ, CLASS_RENTAB, DATA_EMISSAO, DATA_VENCTO, " + _
                           "INDEX, COUPON, DAYCOUNT, SENIOR, NAMECR, HOLDINGS, ISIN, CNPJ, CODCETIP, DT_CREATED, DT_DELETED, DELETED, TIPO, CASHFLOW_ID) VALUES ('" + Obj.nome + "', '" + Obj.ID + "','" + Obj.Status + "', " + s2 + ", '" + Obj.Class_Liq + "','" + Obj.Class_Rent + "'," + _
                           se + " , " + sv + ",'" + Obj.Index + "', " + Str(Obj.Coupon) + ",'" + Obj.DayCount + "','" + Obj.Senior + "','" + Obj.NameCr + "'," + Str(Obj.Holdings) + ",'" + Obj.ISIN + "','" + Obj.CNPJ + "','" + Obj.CodCetip + "'," + SQLD(Obj.Dt_Created) + "," + SQLBaseDate + ",FALSE,'" + Obj.Tipo + "','" + Obj.IDFluxo + "')")
                           
            'Recoloca as propriedades
                For i = 1 To Props.c.Count
                
                    If Obj.PropV(i) <> "" Then
                
                        'verifica valor mais recente da propriedade
                        Set rs = db.Execute("SELECT MAX(DATA) AS D1 FROM TPAPELPROP WHERE PAPEL='" + Obj.ID + "' AND PROPRIEDADE=" + Str(Props.c(i).ID) + " AND DATA<=" + SQLBaseDate)
                        If rs.EOF Then
                            d1 = LongTimeAgo
                        ElseIf IsNull(rs("d1")) Then
                            d1 = LongTimeAgo
                        Else
                            d1 = rs("D1")
                        End If
                        Set rs = db.Execute("SELECT * FROM TPAPELPROP WHERE PAPEL='" + Obj.ID + "' AND PROPRIEDADE=" + Str(Props.c(i).ID) + " AND DATA=" + SQLD(d1))
                        
                        If rs.EOF _
                            Then vai = True _
                            Else vai = Obj.PropV(i) <> rs("VALOR") 'só coloca se valor mudou
                            
                        If vai Then
                                               
                            'certifica-se que não haverá duplicada na mesma data
                            db.Execute ("DELETE FROM TPAPELPROP WHERE PAPEL='" + Obj.ID + "' AND PROPRIEDADE=" + Str(Props.c(i).ID) + " AND DATA =" + SQLBaseDate)
                        
                            'Inlcui
                            ExecuteString = "INSERT INTO TPAPELPROP (VALOR, PAPEL, PROPRIEDADE, DATA) VALUES ('" + Obj.PropV(i) + "', '" + Obj.ID + _
                            "', " + Str(Props.c(i).ID) + "," + SQLBaseDate + ")"
                        
                            db.Execute (ExecuteString)
                        End If
                        
                    End If 'se não é branco
                Next i
            
            'Insere o papel na lista
                j = 1
                For i = 1 To c.Count
                    If c(i).ID = Obj.ID Then j = i
                Next i
                If c(j).ID = Obj.ID Then c.remove (j)
                c.Add Obj, Obj.ID
        End If
        
        
    End If 'Mainstatus=LIVE
End Sub



'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                                R E F E R E N C I A
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Public Sub FillComboWithNames(x As Object)
    Dim y As CPapel
    x.Clear
    For Each y In c
        x.AddItem y.nome
    Next y
End Sub

Public Sub FillComboWithISIN(x As Object)
    Dim y As CPapel
    x.Clear
    For Each y In c
        x.AddItem y.ISIN
    Next y
End Sub

Public Sub FillComboWithCETIP(x As Object)
    Dim y As CPapel
    x.Clear
    For Each y In c
        x.AddItem y.CodCetip
    Next y
End Sub

Public Sub FillComboWithID(x As Object)
    Dim y As CPapel, z As CNomeValor
    x.Clear
    For Each y In c
        x.AddItem y.ID
    Next y
    For Each z In akaList
        x.AddItem z.nome
    Next z
End Sub

Public Sub Linka()
    Dim x As CPapel
    For Each x In c
        x.Linka
    Next x
End Sub


Public Sub Refresh()
    'Por enquanto, só tem função para o Display
    Dim x As CPapel
    
    Set c_TitPublico = New Collection
    Set c_Cotas = New Collection
    Set c_CDB = New Collection
    Set c_LF = New Collection
    Set c_Debenture = New Collection
    Set c_CRI = New Collection
    Set c_Acao = New Collection
    Set c_Futuros = New Collection
    Set c_Outros = New Collection
    Set c_FII = New Collection
    Set c_FIDC = New Collection
    
    For Each x In c
        x.Refresh
        
        Select Case x.DisplayType
            Case 1
                c_TitPublico.Add x, x.ID
            Case 2
                c_Cotas.Add x, x.ID
            Case 3
                c_CDB.Add x, x.ID
            Case 4
                c_LF.Add x, x.ID
            Case 5
                c_Debenture.Add x, x.ID
            Case 6
                c_CRI.Add x, x.ID
            Case 7
                c_FII.Add x, x.ID
            Case 8
                c_FIDC.Add x, x.ID
            Case 9
                c_Acao.Add x, x.ID
            Case 10
                c_Futuros.Add x, x.ID
            Case 11
                c_Outros.Add x, x.ID
        End Select
        
    Next x
End Sub

Public Sub BuscaErros()
    Dim x As CPapel
    For Each x In c
    
        If x.PosicAssetV <> 0 Then 'Só para investidos pelo Asset!
        
            If x.Class_Liq <> "CRI" And InStr(x.ISIN, "CRI") > 0 Then
                WriteLogError "Warn: Classe de Liquidez CRI (??)", x.ID
            End If
                
            If x.Tipo = "DEBENTURE" And x.Class_Liq <> "DEB400" And x.Class_Liq <> "DEB476" Then _
                WriteLogError "Warn: Classe de Liquidez Debenture (??)", x.ID
                
            If (x.Tipo = "DEBENTURE" Or x.Class_Liq = "DEB400" Or x.Class_Liq = "DEB476") And Len(x.NameCr) < 2 Then _
                WriteLogError "Warn: Debênture sem Nome Crédito (??)", x.ID
                
            If x.Class_Liq = "TITPUB" And x.Tipo <> "TITPUBLICO" Then _
                WriteLogError "Warn: Classe de Liquidez Título Público (??)", x.ID
                
        End If
        
    Next x
End Sub


Public Function Maiores(N As Integer) As Collection
    'Acha as n maiores alocações
    Dim ArrVol(100) As Double, ArrPp(100) As CPapel, x As CPapel, i As Integer, j As Integer
    Set Maiores = New Collection
    For i = 1 To N: ArrVol(i) = 0: Set ArrPp(i) = Nothing: Next i
    For Each x In c
        If (x.Tipo = "DEBENTURE" Or x.Tipo = "COTAS") And Not x.ehcaixa And Not x.Fundo Then
            i = 1
            While i < N And ArrVol(i) > x.PosicAssetV
                i = i + 1
            Wend
            If i <= N Then
                For j = N To i + 1 Step -1
                    ArrVol(j) = ArrVol(j - 1)
                    Set ArrPp(j) = ArrPp(j - 1)
                Next j
                ArrVol(i) = x.PosicAssetV
                Set ArrPp(i) = x
            End If
        End If
    Next x
    For i = 1 To N
        Maiores.Add ArrPp(i)
    Next i
End Function

Public Function QuemUsaCrName(x As String) As Integer
    Dim i As Integer, u As CPapel
    i = 0
    For Each u In c
        If u.NameCr = x Then i = i + 1
    Next u
    QuemUsaCrName = i
End Function

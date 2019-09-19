VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Begin VB.Form FTemplateTitulo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Importa Título por Template"
   ClientHeight    =   10965
   ClientLeft      =   -15
   ClientTop       =   270
   ClientWidth     =   5115
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   10965
   ScaleWidth      =   5115
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command4 
      Caption         =   "Cancelar"
      Height          =   375
      Left            =   3840
      TabIndex        =   13
      Top             =   10560
      Width           =   1215
   End
   Begin VB.Frame Frame1 
      Caption         =   "Caso exista um título com mesmo ID"
      Height          =   1095
      Left            =   120
      TabIndex        =   7
      Top             =   8880
      Width           =   4935
      Begin VB.OptionButton Option2 
         Caption         =   "Substituir pelo importado"
         Height          =   255
         Left            =   120
         TabIndex        =   9
         Top             =   720
         Value           =   -1  'True
         Width           =   4095
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Manter o existente"
         Height          =   255
         Left            =   120
         TabIndex        =   8
         Top             =   360
         Width           =   4095
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   5775
      Left            =   0
      TabIndex        =   6
      Top             =   2880
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   10186
      _Version        =   393216
   End
   Begin VB.CommandButton Command3 
      Caption         =   "3. Consolidar dados"
      Height          =   375
      Left            =   0
      TabIndex        =   5
      Top             =   10080
      Width           =   5055
   End
   Begin VB.CommandButton Command2 
      Caption         =   "2. Colar Template de dados a importar (Ct-V)"
      Height          =   375
      Left            =   0
      TabIndex        =   2
      Top             =   1440
      Width           =   5055
   End
   Begin VB.CommandButton Command1 
      Caption         =   "1. Obter Modelo do Template Completo (Ct-C)"
      Height          =   375
      Left            =   0
      TabIndex        =   0
      Top             =   240
      Width           =   5055
   End
   Begin VB.Label Label8 
      BackColor       =   &H80000009&
      Height          =   375
      Left            =   0
      TabIndex        =   16
      Top             =   2520
      Width           =   375
   End
   Begin VB.Label Label7 
      BackColor       =   &H80000009&
      Caption         =   "(nome do título)"
      Height          =   375
      Left            =   480
      TabIndex        =   15
      Top             =   2520
      Width           =   3975
   End
   Begin VB.Label Label6 
      Caption         =   "ou:"
      Height          =   255
      Left            =   3480
      TabIndex        =   14
      Top             =   10560
      Width           =   255
   End
   Begin VB.Label Label5 
      Caption         =   "REVER o conteúdo antes de consolidar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   0
      TabIndex        =   12
      Top             =   1920
      Width           =   5055
   End
   Begin VB.Label Label4 
      Caption         =   "0 títulos encontrados:"
      Height          =   255
      Left            =   0
      TabIndex        =   11
      Top             =   2280
      Width           =   5055
   End
   Begin MSForms.SpinButton SpinButton1 
      Height          =   375
      Left            =   4440
      TabIndex        =   10
      Top             =   2520
      Width           =   615
      Size            =   "1085;661"
   End
   Begin VB.Label Label3 
      Caption         =   "Depois de preencher o template em Excel, dê CTRL-C em toda a área que tem seu conteúdo e clique no botão abaixo:"
      Height          =   375
      Left            =   0
      TabIndex        =   4
      Top             =   960
      Width           =   5055
   End
   Begin VB.Label Label2 
      Caption         =   "Esta função fa a importação de títulos de um template Excel."
      Height          =   255
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   5055
   End
   Begin VB.Label Label1 
      Caption         =   "Após clicar no botão acima, dê CTRL-V em uma planilha Excel"
      Height          =   255
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   5055
   End
End
Attribute VB_Name = "FTemplateTitulo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim c As New Collection

Private matriz As Variant
Private NL As Integer
Private NC As Integer

Private Const NFixed = 11  'Numero de propriedades fixas


Public Sub newshow()
    Dim p As CPropriedade, j As Integer
    ReDim matriz(1000, 252) As String
    
    'Monta Matriz do template
        matriz(1, 1) = "Titulo"
        matriz(1, 2) = "ID"
        matriz(1, 3) = "Cod.CETIP"
        matriz(1, 4) = "ISIN"
        matriz(1, 5) = "Class.Liq"
            matriz(2, 5) = "CASH": matriz(3, 5) = "CDBS": matriz(4, 5) = "TITPUB": matriz(5, 5) = "OVER": matriz(6, 5) = "EUROBOND"
            matriz(7, 5) = "CDBN": matriz(8, 5) = "CDBM": matriz(9, 5) = "LF": matriz(10, 5) = "DEB400": matriz(11, 5) = "CDBSUB"
            matriz(12, 5) = "LFSUB": matriz(13, 5) = "NOTAP": matriz(14, 5) = "FIILIST": matriz(15, 5) = "DEB400CALL": matriz(16, 5) = "DEB476"
            matriz(17, 5) = "DEB476CALL": matriz(18, 5) = "DPGE": matriz(19, 5) = "FIDC": matriz(20, 5) = "CCB": matriz(21, 5) = "CCCB"
            matriz(22, 5) = "CRI": matriz(23, 5) = "CRA": matriz(24, 5) = "CDCA": matriz(25, 5) = "CCI": matriz(26, 5) = "LETRACR"
            matriz(27, 5) = "COMPRO": matriz(28, 5) = "FIINLIST": matriz(29, 5) = "COE"
        matriz(1, 6) = "Class.Rent"
            matriz(2, 6) = "OVER": matriz(3, 6) = "ZERO": matriz(4, 6) = "MATURITY": matriz(5, 6) = "PERP"
        matriz(1, 7) = "Emissão"
        matriz(1, 8) = "Maturity"
        matriz(1, 9) = "Coupon"
        matriz(1, 10) = "DayCount"
            matriz(2, 10) = "ACT/ACT": matriz(3, 10) = "ACT/360": matriz(4, 10) = "30/360": matriz(5, 10) = "BUS/252"
        matriz(1, 11) = "Index"
            matriz(2, 11) = "CDI+": matriz(3, 11) = "%CDI": matriz(4, 11) = "IPCA+": matriz(5, 11) = "IGPM+": matriz(6, 11) = "IGPDI+": matriz(6, 12) = "FIXED": matriz(6, 13) = "SELIC": matriz(6, 14) = "IFIX"
        NC = NFixed
        NL = 29
        For Each p In Props.c
            NC = NC + 1
            matriz(1, NC) = p.nome
            For j = 1 To p.N
                matriz(j + 1, NC) = p.Valor(j)
            Next j
            NL = max(NL, p.N + 1)
        Next p
        
    'Copia de novo a linha cabeçalho
        NL = NL + 1
        For j = 1 To NC
            matriz(NL, j) = matriz(1, j)
        Next j
        
    Me.Show
End Sub

Private Sub Command1_Click()
    RotinaCopy
End Sub

Private Sub RotinaCopy()
    'Grava Template no Clipboard
    stab = Chr(9)
    scr = Chr(13)
    Clipboard.Clear
    st = ""
    For i = 1 To NL
        For j = 1 To NC
            st = st + matriz(i, j) + stab
        Next j
        st = st + scr
    Next i
    Call Clipboard.SetText(st, vbCFText)
End Sub


Private Sub Command2_Click()
    RotinaPaste
End Sub

Private Sub RotinaPaste()
    'Paste Clipboard
    Dim pp As CPapel
    L = Clipboard.GetText
    Set c = New Collection
    While L <> ""
        i = InStr(L, Chr(13))
        If i = 0 Then
            l1 = L
            L = ""
        Else
            l1 = Left(L, i - 1)
            If Left(l1, 1) = Chr(10) Then l1 = Right(l1, Len(l1) - 1)
            L = Right(L, Len(L) - i)
            If Len(L) = 1 Then L = ""
        End If
        
        If Left(l1, 6) <> "Titulo" Then 'não é linha cabeçalho
            Set pp = New CPapel
            j = 0
            a = ""
            For i = 1 To Len(l1)
                If Mid(l1, i, 1) = Chr(9) Or i = Len(l1) Then
                    j = j + 1
                    If i = Len(l1) Then a = a + Mid(l1, i, 1)
                    Select Case j
                        Case 1
                            pp.nome = a
                        Case 2
                            pp.ID = a
                        Case 3
                            pp.CodCetip = a
                        Case 4
                            pp.ISIN = a
                        Case 5
                            pp.Class_Liq = a
                        Case 6
                            pp.Class_Rent = a
                        Case 7
                            If IsDate(a) Then pp.Dt_Emissao = CDate(a)
                        Case 8
                            If IsDate(a) Then pp.Dt_Venc = CDate(a)
                        Case 9
                            If IsNumeric(a) Then pp.Coupon = Val(a)
                        Case 10
                            pp.DayCount = a
                        Case 11
                            pp.Index = a
                        Case Else
                            pp.PropV(j - NFixed) = a
                    End Select
                    a = ""
                Else
                    a = a + Mid(l1, i, 1)
                End If
            Next i
            c.Add pp
        End If
        
    Wend 'Parse o próximo papel
    
    'Coloca o 1o papel na grade
    SpinButton1.value = 1
    If c.Count > 0 Then
        ColocaNaGrade c(1)
        Label8 = "1"
    End If
    
    Label4.Caption = Str(c.Count) + " títulos encontrados:"
End Sub

Private Function critField(pp As CPapel, i As Integer) As Boolean
    Dim j As Integer, x As String
    
    If i = 5 Or i = 6 Or i = 10 Or i = 11 Or (i > NFixed And Not Props.c(max(1, i - NFixed)).ValorLivre) Then
        critField = False
        Select Case i
            Case 5
                x = pp.Class_Liq
            Case 6
                x = pp.Class_Rent
            Case 10
                x = pp.DayCount
            Case 11
                x = pp.Index
        Case Else
            x = pp.PropV(i - NFixed)
        End Select
        j = 2
        While matriz(j, i) <> ""
            If matriz(j, i) = x Then critField = True
            j = j + 1
        Wend
    Else
        critField = True
    End If
    
End Function


Private Function critPaper(pp As CPapel) As Boolean
    Dim i As Integer, a As Boolean
    a = True
    For i = 1 To NFixed + Props.c.Count
        a = a And critField(pp, i)
    Next i
    critPaper = a
End Function


Private Sub HighLightCell(i As Integer, b As Boolean)
    If i < Grid.Rows - 1 Then Grid.Row = i
    Grid.Col = 1
    If b Then cor = 0 Else cor = &HFF&
    Grid.CellForeColor = cor
End Sub


Private Sub ColocaNaGrade(pp As CPapel)
    Dim i As Integer
    Label7.Caption = pp.nome
    Grid.FormatString = "Propriedade                                 |<Valor                                                |"
    Grid.Rows = NFixed + Props.c.Count + 1
    Grid.Cols = 2
    Grid.TextMatrix(1, 0) = "*Titulo"
        Grid.TextMatrix(1, 1) = pp.nome
        
    Grid.TextMatrix(2, 0) = "*ID"
        Grid.TextMatrix(2, 1) = pp.ID
        
    Grid.TextMatrix(3, 0) = "*Cod.CETIP"
        Grid.TextMatrix(3, 1) = pp.CodCetip
        
    Grid.TextMatrix(4, 0) = "*ISIN"
        Grid.TextMatrix(4, 1) = pp.ISIN
        
    Grid.TextMatrix(5, 0) = "*Class.Liq"
        Grid.TextMatrix(5, 1) = pp.Class_Liq
        HighLightCell 5, critField(pp, 5)
        
    Grid.TextMatrix(6, 0) = "*Class.Rent"
        Grid.TextMatrix(6, 1) = pp.Class_Rent
        HighLightCell 6, critField(pp, 6)
        
    Grid.TextMatrix(7, 0) = "*Emissão"
        Grid.TextMatrix(7, 1) = Format(pp.Dt_Emissao, "dd-MMM-yyyy")
        
    Grid.TextMatrix(8, 0) = "*Maturity"
        Grid.TextMatrix(8, 1) = Format(pp.Dt_Venc, "dd-MMM-yyyy")
        
    Grid.TextMatrix(9, 0) = "*Coupon"
        Grid.TextMatrix(9, 1) = Format(pp.Coupon, "##0.000%")
                
    Grid.TextMatrix(10, 0) = "*DayCount"
        Grid.TextMatrix(10, 1) = pp.DayCount
        HighLightCell 10, critField(pp, 10)
        
    Grid.TextMatrix(11, 0) = "*Index"
        Grid.TextMatrix(11, 1) = pp.Index
        HighLightCell 11, critField(pp, 11)
        
    For i = 1 To Props.c.Count
        Grid.TextMatrix(NFixed + i, 0) = Props.c(i).nome
        Grid.TextMatrix(NFixed + i, 1) = pp.PropV(i)
        HighLightCell NFixed + i, critField(pp, NFixed + i)
        
    Next i
    Grid.Refresh
End Sub

Private Sub Command3_Click()

    'Consolida os dados importados de todos os papéis
    Dim p As CPapel, vai As Boolean, p1 As CPapel, p2 As CPapel, p3 As CPapel
    
    For Each p In c
        vai = True
        If Not critPaper(p) Then
            vai = (MsgBox("Importa o título " + p.nome + " (ID=" + p.ID + ") " + Chr(10) + Chr(13) + "com erros de validação?", vbYesNo) = vbYes)
        End If
        If vai Then
            Set p1 = Papeis.search(p.ID)
            Set p2 = Papeis.searchISIN(p.ISIN)
            Set p3 = Papeis.searchCETIP(p.CodCetip)
            If Not p2 Is Nothing And Not p2 Is p1 Then
                MsgBox ("Não pode importar título " + p.nome + " (ID=" + p.ID + ") " + Chr(10) + Chr(13) + " ISIN duplicado")
                vai = False
            End If
            If Not p3 Is Nothing And Not p3 Is p1 Then
                MsgBox ("Não pode importar título " + p.nome + " (ID=" + p.ID + ") " + Chr(10) + Chr(13) + " Cod. CETIP duplicado")
                vai = False
            End If
            If vai Then
                Papeis.Insert p, Me.Option2.value
                p.FazFluxo
            End If
        End If
    Next p
    
    Me.Hide
    
    Papeis.Linka
                
    'Reseta tudo
    FMain.Refaz
End Sub

Private Sub Command4_Click()
    Me.Hide
End Sub

Private Sub SpinButton1_Change()
    If SpinButton1.value > 0 And SpinButton1.value <= c.Count Then
        ColocaNaGrade c(SpinButton1.value)
        Label8.Caption = Str(SpinButton1.value)
    End If
End Sub


Private Sub Grid_keypress(keyascii As Integer)
    Select Case keyascii
        Case 3
            RotinaCopy
        Case 22
            RotinaPaste
    End Select
End Sub

Public Sub newrefresh()
End Sub

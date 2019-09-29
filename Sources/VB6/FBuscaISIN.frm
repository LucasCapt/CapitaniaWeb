VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FBuscaISIN 
   Caption         =   "Busca ISIN"
   ClientHeight    =   7245
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8340
   LinkTopic       =   "Form1"
   ScaleHeight     =   7245
   ScaleWidth      =   8340
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Busca"
      Height          =   375
      Left            =   5280
      TabIndex        =   3
      Top             =   0
      Width           =   855
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   600
      TabIndex        =   1
      Top             =   0
      Width           =   4695
   End
   Begin MSFlexGridLib.MSFlexGrid grid 
      Height          =   6855
      Left            =   0
      TabIndex        =   0
      Top             =   360
      Width           =   8295
      _ExtentX        =   14631
      _ExtentY        =   12091
      _Version        =   393216
      Rows            =   40
      AllowUserResizing=   1
   End
   Begin VB.Label Label1 
      Caption         =   "ISIN:"
      Height          =   255
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   615
   End
End
Attribute VB_Name = "FBuscaISIN"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private v As Variant

Public Sub showfor(Optional x As String = "")
    Grid.FormatString = "Propriedade                                     |Valor                                                                                                   "
    v = Array("Emissor", "CFI", "Descricao", "AnoEmissao", "DataEmissao", "AnoExpiracao", "DataExpiracao", "TaxaJuros", "Moedas", _
              "ValorNominal", "PrecoExercicio", "Index", "PctIndex", "DatadaAcao", "CETIP", "SELIC", "CodPais", "TipoAtivo", _
              "CodigoCategoria", "CodigoEspecie", "DataBase1", "NumeroEmissao", "NumeroSerie", "TipoEmissao", "TipoAtivoObjeto", _
              "TipoEntrega", "TipoFundo", "TipoGarantia", "TipodeJuros", "TipodeMercado", "TipoStatusIsin", "TipoVencimento", _
              "TipoAtivosInvestidos", "TipoForma", "TipoEstiloOpcao", "NumeroSerieOpcao", "CodigoFrequenciaJuros", "SituacaoISIN", _
              "DataPrimeiroPagamento")
    Grid.Rows = 39
    Grid.TextMatrix(0, 0) = "EmissorNome"
    For i = 1 To 38
        Grid.TextMatrix(i, 0) = v(i)
    Next i
    Me.Text1 = x
    Me.Show
    newrefresh
End Sub


Private Sub Command1_Click()
    newrefresh
End Sub


Public Sub newrefresh()
    'Busca ISIN
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset
    'ISIN DATABASE!
    Set db = DBEngine.Workspaces(0).OpenDatabase(Config.ISINDataBase)
    
    Set rs = db.Execute("SELECT * FROM ISIN WHERE ISIN = '" + Me.Text1 + "'")
    
    If rs.EOF Then
        For i = 1 To 38
            Grid.TextMatrix(i, 1) = "não encontrado"
        Next i
    Else
        'Procura emissor pelo código
        Set rs1 = db.Execute("SELECT * FROM EMISSORES WHERE CODIGO='" + CritS(rs("EMISSOR")) + "'")
        If rs1.EOF Then u = "(não encontrado)" Else u = CritS(rs1("Nome"))
        Grid.TextMatrix(0, 1) = u
        For i = 1 To 38
            Grid.TextMatrix(i, 1) = rs(v(i))
        Next i
    End If
End Sub


Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub


Private Sub form_resize()
    Grid.Width = max(1, Me.Width - 270)
    Grid.Height = max(1, Me.Height - 600)
End Sub

VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Begin VB.Form FTitulo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Título"
   ClientHeight    =   10755
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5910
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   10755
   ScaleWidth      =   5910
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox ICNPJ 
      Height          =   285
      Left            =   1680
      TabIndex        =   42
      Text            =   "Text1"
      Top             =   1560
      Width           =   1455
   End
   Begin VB.TextBox IName 
      Height          =   285
      Left            =   4320
      TabIndex        =   38
      Text            =   "Text1"
      Top             =   2640
      Width           =   1455
   End
   Begin VB.ComboBox ITranche 
      Height          =   315
      ItemData        =   "FTitulo.frx":0000
      Left            =   4320
      List            =   "FTitulo.frx":0010
      TabIndex        =   36
      Text            =   "Combo1"
      Top             =   3360
      Width           =   1455
   End
   Begin VB.TextBox IHolds 
      Height          =   285
      Left            =   4320
      TabIndex        =   34
      Text            =   "Text1"
      Top             =   3720
      Width           =   1455
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "FTitulo.frx":0037
      Left            =   1680
      List            =   "FTitulo.frx":0056
      TabIndex        =   32
      Top             =   1920
      Width           =   1455
   End
   Begin VB.CommandButton Command4 
      Caption         =   "OK e liberado"
      Height          =   375
      Left            =   4800
      TabIndex        =   31
      Top             =   10200
      Width           =   1095
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   1680
      TabIndex        =   27
      Text            =   "Text1"
      Top             =   1200
      Width           =   4095
   End
   Begin VB.ComboBox IDayCount 
      Height          =   315
      ItemData        =   "FTitulo.frx":00AE
      Left            =   4320
      List            =   "FTitulo.frx":00BE
      TabIndex        =   26
      Text            =   "Combo1"
      Top             =   2280
      Width           =   1455
   End
   Begin VB.TextBox Icoup 
      Height          =   285
      Left            =   1680
      TabIndex        =   23
      Text            =   "Text1"
      Top             =   3000
      Width           =   1455
   End
   Begin VB.ComboBox IIndex 
      Height          =   315
      ItemData        =   "FTitulo.frx":00E5
      Left            =   1680
      List            =   "FTitulo.frx":0107
      TabIndex        =   22
      Text            =   "Combo1"
      Top             =   3360
      Width           =   1455
   End
   Begin MSComCtl2.DTPicker IIssue 
      Height          =   255
      Left            =   4320
      TabIndex        =   18
      Top             =   1920
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   450
      _Version        =   393216
      CustomFormat    =   "dd-MMM-yyyy"
      Format          =   119603203
      CurrentDate     =   42221
   End
   Begin VB.ComboBox ISched 
      Height          =   315
      ItemData        =   "FTitulo.frx":0151
      Left            =   4320
      List            =   "FTitulo.frx":0161
      TabIndex        =   16
      Text            =   "Combo1"
      Top             =   1560
      Width           =   1455
   End
   Begin VB.ComboBox ILiq 
      Height          =   315
      ItemData        =   "FTitulo.frx":0181
      Left            =   1680
      List            =   "FTitulo.frx":01DC
      TabIndex        =   14
      Text            =   "Combo1"
      Top             =   2280
      Width           =   1455
   End
   Begin VB.TextBox ICETIP 
      Height          =   285
      Left            =   1680
      TabIndex        =   11
      Text            =   "Text1"
      Top             =   840
      Width           =   4095
   End
   Begin VB.CommandButton Command3 
      Caption         =   "-->Propr."
      Height          =   375
      Left            =   4800
      TabIndex        =   10
      Top             =   9720
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   120
      TabIndex        =   9
      Top             =   9720
      Width           =   4575
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancelar"
      Height          =   375
      Left            =   2400
      TabIndex        =   7
      Top             =   10200
      Width           =   1095
   End
   Begin VB.CheckBox Check2 
      Caption         =   "Este título é um fundo cadastrado (para abertura de carteira)"
      Height          =   195
      Left            =   120
      TabIndex        =   6
      Top             =   4200
      Width           =   5655
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   840
      TabIndex        =   4
      Text            =   "Text1"
      Top             =   480
      Width           =   4935
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   375
      Left            =   3600
      TabIndex        =   1
      Top             =   10200
      Width           =   1095
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   4815
      Left            =   0
      TabIndex        =   0
      Top             =   4800
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   8493
      _Version        =   393216
      BackColor       =   16761087
   End
   Begin MSComCtl2.DTPicker IMat 
      Height          =   255
      Left            =   1680
      TabIndex        =   20
      Top             =   2640
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   450
      _Version        =   393216
      CustomFormat    =   "dd-MMM-yyyy"
      Format          =   119603203
      CurrentDate     =   42221
   End
   Begin VB.Label Label21 
      Caption         =   "CNPJ"
      Height          =   255
      Left            =   120
      TabIndex        =   41
      Top             =   1560
      Width           =   1095
   End
   Begin VB.Label Label20 
      BackColor       =   &H00FFFFFF&
      Caption         =   "n/a"
      Height          =   255
      Left            =   4320
      TabIndex        =   40
      Top             =   3000
      Width           =   1455
   End
   Begin VB.Label Label19 
      Caption         =   "Name.Crd"
      Height          =   255
      Left            =   3480
      TabIndex        =   39
      Top             =   2640
      Width           =   735
   End
   Begin VB.Label Label18 
      Caption         =   "Tranche"
      Height          =   255
      Left            =   3480
      TabIndex        =   37
      Top             =   3360
      Width           =   855
   End
   Begin VB.Label Label17 
      Caption         =   "Imob.Hldgs"
      Height          =   255
      Left            =   3480
      TabIndex        =   35
      Top             =   3720
      Width           =   855
   End
   Begin VB.Label Label16 
      Caption         =   "Tipo"
      Height          =   255
      Left            =   120
      TabIndex        =   33
      Top             =   1920
      Width           =   1095
   End
   Begin VB.Label Label15 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Status"
      Height          =   255
      Left            =   1680
      TabIndex        =   30
      Top             =   3720
      Width           =   1455
   End
   Begin VB.Label Label14 
      Caption         =   "Status"
      Height          =   255
      Left            =   120
      TabIndex        =   29
      Top             =   3720
      Width           =   1455
   End
   Begin VB.Label Label13 
      Caption         =   "ISIN"
      Height          =   255
      Left            =   120
      TabIndex        =   28
      Top             =   1200
      Width           =   1095
   End
   Begin VB.Label Label12 
      Caption         =   "DayCount"
      Height          =   255
      Left            =   3480
      TabIndex        =   25
      Top             =   2280
      Width           =   855
   End
   Begin VB.Label Label11 
      Caption         =   "Coupon"
      Height          =   255
      Left            =   120
      TabIndex        =   24
      Top             =   3000
      Width           =   735
   End
   Begin VB.Label Label10 
      Caption         =   "Indexador"
      Height          =   255
      Left            =   120
      TabIndex        =   21
      Top             =   3360
      Width           =   1455
   End
   Begin VB.Label Label9 
      Caption         =   "Maturity"
      Height          =   255
      Left            =   120
      TabIndex        =   19
      Top             =   2640
      Width           =   735
   End
   Begin VB.Label Label8 
      Caption         =   "Emissão"
      Height          =   255
      Left            =   3480
      TabIndex        =   17
      Top             =   1920
      Width           =   735
   End
   Begin VB.Label Label7 
      Caption         =   "Schedule"
      Height          =   255
      Left            =   3480
      TabIndex        =   15
      Top             =   1560
      Width           =   855
   End
   Begin VB.Label Label6 
      Caption         =   "Classe Liquidez"
      Height          =   255
      Left            =   120
      TabIndex        =   13
      Top             =   2280
      Width           =   1095
   End
   Begin VB.Label Label5 
      Caption         =   "Código CETIP"
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   840
      Width           =   1095
   End
   Begin VB.Label Label4 
      Caption         =   "ID"
      Height          =   255
      Left            =   1320
      TabIndex        =   8
      Top             =   120
      Width           =   4455
   End
   Begin VB.Label Label3 
      Caption         =   "Propriedades"
      Height          =   255
      Left            =   0
      TabIndex        =   5
      Top             =   4560
      Width           =   5895
   End
   Begin VB.Label Label2 
      Caption         =   "Nome"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   480
      Width           =   495
   End
   Begin VB.Label Label1 
      Caption         =   "Identificador"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   1095
   End
End
Attribute VB_Name = "FTitulo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Obj As CPapel
Private Orig_EhFundo As Boolean

Public Sub showfor(x As CPapel)
    Dim i As Integer
    Set Obj = x
    Orig_EhFundo = x.Fundo
    Me.Caption = "Título: " + x.nome
    Me.Label4 = x.ID
    Me.Text2 = x.nome
    Me.Text3 = x.ISIN
    Me.Check2 = Bol2Check(x.Fundo)
    Me.ICETIP = x.CodCetip
    Me.Icoup = x.Coupon * 100
    Me.IDayCount = x.DayCount
    Me.IIndex = x.Index
    Me.IIssue = x.Dt_Emissao
    Me.ILiq = x.Class_Liq
    Me.IMat = x.Dt_Venc
    Me.ISched = x.Class_Rent
    Me.Label15 = x.Status
    Me.Combo1 = x.Tipo
    Me.IHolds = Str(x.Holdings)
    Me.ITranche = x.Senior
    Me.IName = x.NameCr
    Me.ICNPJ = x.CNPJ

    If Not x.MyCrdName Is Nothing Then Me.Label20 = x.MyCrdName.nome
    
    
    Grid.FormatString = "Propriedade                    |Valor                                                   "
    Grid.Rows = 1
    
    Set PropList = New Collection
    For i = 1 To Props.c.Count
        If Props.c(i).ValorLivre _
            Then Grid.AddItem Props.c(i).nome + " (L)" _
            Else Grid.AddItem Props.c(i).nome
        Grid.TextMatrix(i, 1) = x.PropV(i)
    Next i
    Show
End Sub

Private Sub Command1_Click()
    Consolida False
End Sub

Private Sub Command4_Click()
    Consolida True
End Sub


Private Sub Consolida(liberado As Boolean)
    Dim i As Integer, ExecuteString As String, IDISIN As String
    
    Dim s1 As String, s2 As String, cp As String
            
    IDISIN = Papeis.IDdeISINNaBase(Me.Text3)
    If IDISIN <> Obj.ID And Trim(IDISIN) <> "" And Trim(Me.Text3) <> "" Then
        MsgBox ("Já existe um título com ISIN " + Me.Text3 + " na base, com o ID " + IDISIN + ". Corrigir.")
    ElseIf Check2Bol(Me.Check2) And Fundos.searchIDTitulo(Obj.ID) Is Nothing Then
        MsgBox ("Título marcado como Fundo, mas não encontrado entre os fundos. Corrigir.")
    Else
        
        'Substitui na memória e na base de dados
        
        Obj.nome = Me.Text2
        Obj.Fundo = Check2Bol(Me.Check2)
        Obj.Class_Liq = Me.ILiq
        Obj.Class_Rent = Me.ISched
        Obj.CodCetip = Me.ICETIP
        Obj.CNPJ = Me.ICNPJ
        
        cp = Me.Icoup
        If Right(cp, 1) = "%" Then
            Obj.Coupon = Val(Left(cp, Len(cp) - 1)) / 100
        ElseIf Not IsNumeric(cp) Then
            Obj.Coupon = 0
        Else
            Obj.Coupon = Val(cp) / 100
        End If
        
        Obj.DayCount = Me.IDayCount
        Obj.Dt_Emissao = Me.IIssue
        Obj.Dt_Venc = Me.IMat
        Obj.Index = Me.IIndex
        Obj.ISIN = Me.Text3
        Obj.Tipo = Me.Combo1
        Obj.Holdings = Int(Val(Me.IHolds))
        Obj.Senior = Me.ITranche
        Obj.NameCr = Me.IName
        
        If liberado Then
            Obj.Status = "LIBERADO"
        ElseIf Obj.Status <> "LIBERADO" Then
            Obj.Status = "EDITADO"
        End If
        
        For i = 1 To Grid.Rows - 1
            Obj.PropV(i) = Grid.TextMatrix(i, 1)
        Next i
        
        Papeis.Insert Obj, True
        
        Me.Hide
        
        Obj.FazFluxo
        Papeis.Linka
        
        'se mudou prop crítica, recalcula tudo; senão recalcula em relação ao papel que foi editado:
            If Orig_EhFundo <> Obj.Fundo Then Fundos.Recalc Else Fundos.RecalcWRespectTo Obj
        
        Papeis.Refresh 'sempre depois de fundos.recalc
                
        'Refaz todos os forms
        FMain.Refaz
        
        WriteLog "EDITOU PAPEL " + Obj.ID
        
    End If 'erros
End Sub

Private Sub Command2_Click()
    Me.Hide
End Sub

Private Sub Command3_Click()
    If Grid.Row > 0 Then
        If Props.c(Grid.Row).ValorLivre Then Grid.TextMatrix(Grid.Row, 1) = Me.Text1
    End If
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 32 And Grid.Row > 0 Then
        Grid.TextMatrix(Grid.Row, 1) = Props.c(Grid.Row).succ(Grid.TextMatrix(Grid.Row, 1))
    ElseIf UCase(Chr(keyascii)) >= "A" And UCase(Chr(keyascii)) <= "Z" And Grid.Row > 0 Then
        Grid.TextMatrix(Grid.Row, 1) = Props.c(Grid.Row).FirstWithLetter(UCase(Chr(keyascii)), Grid.TextMatrix(Grid.Row, 1))
    ElseIf keyascii = 127 Or keyascii = 8 And Grid.Row > 0 Then
        Grid.TextMatrix(Grid.Row, 1) = ""
    End If
End Sub

Public Sub newrefresh()
End Sub

Private Sub IName_Change()
    Dim u As CCreditName
    Set u = CrNames.SearchCreditName(Me.IName)
    If Not u Is Nothing Then Me.Label20 = u.nome Else Me.Label20 = "n/a"
End Sub

Private Sub IName_Lostfocus()
    Dim u As CCreditName
    Set u = CrNames.SearchCreditName(Me.IName)
    If u Is Nothing Then
        Set u = CrNames.SearchCreditNameByName(Me.IName)
        If Not u Is Nothing Then
            Me.Label20 = Me.IName
            Me.IName = u.Cod
        End If
    End If
End Sub

VERSION 5.00
Begin VB.Form FEditFund 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Edita Fundo"
   ClientHeight    =   7755
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11280
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7755
   ScaleWidth      =   11280
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox Check7 
      Caption         =   "Proibido cross-trade"
      Height          =   255
      Left            =   6000
      TabIndex        =   63
      Top             =   5760
      Width           =   5175
   End
   Begin VB.CheckBox Check6 
      Caption         =   "Proibido day-trade"
      Height          =   255
      Left            =   6000
      TabIndex        =   62
      Top             =   5400
      Width           =   5175
   End
   Begin VB.TextBox Text14 
      Height          =   285
      Left            =   1320
      TabIndex        =   60
      Text            =   "Text1"
      ToolTipText     =   "Nome do fundo no Blotter"
      Top             =   1200
      Width           =   4095
   End
   Begin VB.TextBox Text13 
      Height          =   285
      Left            =   7200
      TabIndex        =   58
      Text            =   "Text1"
      Top             =   4680
      Width           =   975
   End
   Begin VB.TextBox Text12 
      Height          =   285
      Left            =   10080
      TabIndex        =   54
      Text            =   "Text1"
      Top             =   6720
      Width           =   975
   End
   Begin VB.TextBox Text11 
      Height          =   285
      Left            =   7200
      TabIndex        =   53
      Text            =   "Text1"
      Top             =   6720
      Width           =   975
   End
   Begin VB.ComboBox Combo7 
      Height          =   315
      ItemData        =   "FEditFund.frx":0000
      Left            =   1320
      List            =   "FEditFund.frx":0010
      TabIndex        =   51
      Text            =   "Combo1"
      Top             =   4320
      Width           =   3615
   End
   Begin VB.CheckBox Check5 
      Caption         =   "Reporte de Risco de Crédito"
      Height          =   255
      Left            =   120
      TabIndex        =   50
      Top             =   7080
      Width           =   4335
   End
   Begin VB.CheckBox Check4 
      Caption         =   "Reporte de Risco de Mercado"
      Height          =   255
      Left            =   120
      TabIndex        =   49
      Top             =   6720
      Width           =   3015
   End
   Begin VB.CheckBox Check3 
      Caption         =   "Reporte de Liquidez"
      Height          =   255
      Left            =   120
      TabIndex        =   47
      Top             =   6360
      Width           =   2175
   End
   Begin VB.ComboBox Combo6 
      Height          =   315
      ItemData        =   "FEditFund.frx":0031
      Left            =   1320
      List            =   "FEditFund.frx":003E
      TabIndex        =   45
      Text            =   "Combo1"
      Top             =   1920
      Width           =   3615
   End
   Begin VB.CheckBox Check2 
      Caption         =   "Este fundo tem limites de rating no regulamento"
      Height          =   255
      Left            =   6000
      TabIndex        =   44
      Top             =   5040
      Width           =   5175
   End
   Begin VB.ComboBox Combo5 
      Height          =   315
      ItemData        =   "FEditFund.frx":0057
      Left            =   1320
      List            =   "FEditFund.frx":0064
      TabIndex        =   42
      Text            =   "Combo1"
      Top             =   4680
      Width           =   3615
   End
   Begin VB.ComboBox Combo4 
      Height          =   315
      ItemData        =   "FEditFund.frx":007C
      Left            =   1320
      List            =   "FEditFund.frx":0098
      TabIndex        =   40
      Text            =   "Combo1"
      Top             =   2640
      Width           =   3615
   End
   Begin VB.TextBox Text10 
      Height          =   285
      Left            =   1320
      TabIndex        =   37
      Text            =   "Text1"
      Top             =   5400
      Width           =   975
   End
   Begin VB.TextBox Text9 
      Height          =   285
      Left            =   10080
      TabIndex        =   34
      Text            =   "Text1"
      Top             =   4320
      Width           =   975
   End
   Begin VB.TextBox Text8 
      Height          =   285
      Left            =   10080
      TabIndex        =   32
      Text            =   "Text1"
      Top             =   3960
      Width           =   975
   End
   Begin VB.TextBox Text7 
      Height          =   285
      Left            =   7200
      TabIndex        =   30
      Text            =   "Text1"
      Top             =   4320
      Width           =   975
   End
   Begin VB.TextBox Text6 
      Height          =   285
      Left            =   7200
      TabIndex        =   28
      Text            =   "Text1"
      Top             =   3960
      Width           =   975
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Este Fundo tem Limites de Risco próprios e não regidos na Política:"
      Height          =   255
      Left            =   6000
      TabIndex        =   27
      Top             =   3600
      Width           =   5175
   End
   Begin VB.ComboBox Combo3 
      Height          =   315
      ItemData        =   "FEditFund.frx":00C6
      Left            =   1320
      List            =   "FEditFund.frx":00DF
      TabIndex        =   25
      Text            =   "Combo1"
      Top             =   3000
      Width           =   3615
   End
   Begin VB.TextBox Text5 
      Height          =   285
      Left            =   1320
      TabIndex        =   24
      Text            =   "Text1"
      ToolTipText     =   "Nome do Fundo no arquivo de Fila de Resgates"
      Top             =   3960
      Width           =   4095
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   1320
      TabIndex        =   20
      Text            =   "Text1"
      Top             =   5040
      Width           =   975
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      ItemData        =   "FEditFund.frx":011C
      Left            =   1320
      List            =   "FEditFund.frx":0126
      TabIndex        =   17
      Text            =   "Combo1"
      Top             =   2280
      Width           =   3615
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "FEditFund.frx":013E
      Left            =   1320
      List            =   "FEditFund.frx":014B
      TabIndex        =   16
      Text            =   "Combo1"
      Top             =   3360
      Width           =   3615
   End
   Begin VB.CommandButton Command2 
      Caption         =   "<--"
      Height          =   375
      Left            =   8280
      TabIndex        =   14
      Top             =   2160
      Width           =   375
   End
   Begin VB.CommandButton Command1 
      Caption         =   "-->"
      Height          =   375
      Left            =   8280
      TabIndex        =   13
      Top             =   1200
      Width           =   375
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   1320
      TabIndex        =   11
      Text            =   "Text1"
      ToolTipText     =   "Nome do fundo quando figura como título na carteira"
      Top             =   1560
      Width           =   4095
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   1320
      TabIndex        =   10
      Text            =   "Text1"
      Top             =   840
      Width           =   4095
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   1320
      TabIndex        =   9
      Text            =   "Text1"
      Top             =   480
      Width           =   4095
   End
   Begin VB.CommandButton B_OK 
      Caption         =   "OK"
      Height          =   375
      Left            =   10080
      TabIndex        =   3
      Top             =   7320
      Width           =   1095
   End
   Begin VB.CommandButton B_Cancel 
      Caption         =   "Cancela"
      Height          =   375
      Left            =   8880
      TabIndex        =   2
      Top             =   7320
      Width           =   1095
   End
   Begin VB.ListBox List2 
      Height          =   1815
      Left            =   8760
      TabIndex        =   1
      Top             =   960
      Width           =   2415
   End
   Begin VB.ListBox List1 
      Height          =   1815
      Left            =   5880
      TabIndex        =   0
      Top             =   960
      Width           =   2295
   End
   Begin VB.Label Label30 
      Caption         =   "Nome Blotter"
      Height          =   255
      Left            =   120
      TabIndex        =   61
      Top             =   1200
      Width           =   975
   End
   Begin VB.Label Label28 
      Caption         =   "Duration"
      Height          =   255
      Left            =   6000
      TabIndex        =   59
      Top             =   4680
      Width           =   1095
   End
   Begin VB.Label Label31 
      Caption         =   "Tolerâncias de atraso de carteira (dias):"
      Height          =   255
      Left            =   5880
      TabIndex        =   57
      Top             =   6360
      Width           =   5295
   End
   Begin VB.Label Label27 
      Caption         =   "Tolerância Longa:"
      Height          =   255
      Left            =   8640
      TabIndex        =   56
      Top             =   6720
      Width           =   1455
   End
   Begin VB.Label Label29 
      Caption         =   "Tolerância Curta:"
      Height          =   255
      Left            =   5880
      TabIndex        =   55
      Top             =   6720
      Width           =   1335
   End
   Begin VB.Line Line5 
      X1              =   5880
      X2              =   11160
      Y1              =   6240
      Y2              =   6240
   End
   Begin VB.Label Label26 
      Caption         =   "Metodo Liquidez"
      Height          =   255
      Left            =   120
      TabIndex        =   52
      Top             =   4320
      Width           =   1215
   End
   Begin VB.Line Line3 
      X1              =   120
      X2              =   5400
      Y1              =   3840
      Y2              =   3840
   End
   Begin VB.Label Label25 
      Caption         =   "Este fundo é um favorito para:"
      Height          =   255
      Left            =   120
      TabIndex        =   48
      Top             =   6000
      Width           =   5175
   End
   Begin VB.Line Line4 
      X1              =   120
      X2              =   5400
      Y1              =   5880
      Y2              =   5880
   End
   Begin VB.Label Label24 
      Caption         =   "Área"
      Height          =   255
      Left            =   120
      TabIndex        =   46
      Top             =   1920
      Width           =   1095
   End
   Begin VB.Label Label23 
      Caption         =   "Concentração"
      Height          =   255
      Left            =   120
      TabIndex        =   43
      Top             =   4680
      Width           =   1095
   End
   Begin VB.Label Label22 
      Caption         =   "Tipo 409"
      Height          =   255
      Left            =   120
      TabIndex        =   41
      Top             =   2640
      Width           =   1095
   End
   Begin VB.Label Label21 
      Caption         =   "Regras de Compliance"
      Height          =   255
      Left            =   5880
      TabIndex        =   39
      Top             =   240
      Width           =   5175
   End
   Begin VB.Line Line2 
      X1              =   5640
      X2              =   5640
      Y1              =   120
      Y2              =   7680
   End
   Begin VB.Label Label20 
      Caption         =   "% do pl"
      Height          =   255
      Left            =   2400
      TabIndex        =   38
      Top             =   5400
      Width           =   855
   End
   Begin VB.Label Label19 
      Caption         =   "Caixa Mandato"
      Height          =   255
      Left            =   120
      TabIndex        =   36
      Top             =   5400
      Width           =   1095
   End
   Begin VB.Label Label18 
      Caption         =   "Credit-VaR"
      Height          =   255
      Left            =   8520
      TabIndex        =   35
      Top             =   4320
      Width           =   1455
   End
   Begin VB.Label Label17 
      Caption         =   "Perda Esperada EL"
      Height          =   255
      Left            =   8520
      TabIndex        =   33
      Top             =   3960
      Width           =   1455
   End
   Begin VB.Label Label16 
      Caption         =   "Stress"
      Height          =   255
      Left            =   6000
      TabIndex        =   31
      Top             =   4320
      Width           =   1095
   End
   Begin VB.Label Label15 
      Caption         =   "VaR"
      Height          =   255
      Left            =   6000
      TabIndex        =   29
      Top             =   3960
      Width           =   1095
   End
   Begin VB.Label Label14 
      Caption         =   "Limites de Risco"
      Height          =   255
      Left            =   6000
      TabIndex        =   26
      Top             =   3240
      Width           =   5175
   End
   Begin VB.Line Line1 
      X1              =   5880
      X2              =   11160
      Y1              =   3120
      Y2              =   3120
   End
   Begin VB.Label Label13 
      Caption         =   "ID Liquidez"
      Height          =   255
      Left            =   120
      TabIndex        =   23
      Top             =   3960
      Width           =   1095
   End
   Begin VB.Label Label12 
      Caption         =   "Tipo"
      Height          =   255
      Left            =   120
      TabIndex        =   22
      Top             =   3000
      Width           =   1095
   End
   Begin VB.Label Label11 
      Caption         =   "dias"
      Height          =   255
      Left            =   2400
      TabIndex        =   21
      Top             =   5040
      Width           =   495
   End
   Begin VB.Label Label10 
      Caption         =   "Prazo Resgate"
      Height          =   255
      Left            =   120
      TabIndex        =   19
      Top             =   5040
      Width           =   1095
   End
   Begin VB.Label Label8 
      Caption         =   "Consolidação"
      Height          =   255
      Left            =   120
      TabIndex        =   18
      Top             =   2280
      Width           =   1095
   End
   Begin VB.Label Label5 
      Caption         =   "Publico Alvo"
      Height          =   255
      Left            =   120
      TabIndex        =   15
      Top             =   3360
      Width           =   975
   End
   Begin VB.Label Label4 
      Caption         =   "ID Título"
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   1560
      Width           =   975
   End
   Begin VB.Label Label7 
      Caption         =   "Livros Associados ao Fundo"
      Height          =   255
      Left            =   8760
      TabIndex        =   8
      Top             =   600
      Width           =   2295
   End
   Begin VB.Label Label6 
      Caption         =   "Livros de regras Disponíveis"
      Height          =   255
      Left            =   5880
      TabIndex        =   7
      Top             =   600
      Width           =   2295
   End
   Begin VB.Label Label3 
      Caption         =   "CNPJ:"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   840
      Width           =   975
   End
   Begin VB.Label Label2 
      Caption         =   "Nome:"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   480
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "Identificador:"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   120
      Width           =   5295
   End
End
Attribute VB_Name = "FEditFund"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Obj As CFundo

Public Sub showfor(x As CFundo)
    Dim b As CBook
    
    Set Obj = x
    
    Me.Text2 = CNPJComPonto(x.CNPJ)
    Me.Text1 = x.nome
    Me.Text3 = x.IDTitulo
    Me.Combo1 = x.qualif
    Me.Combo2 = x.Consol
    Me.Combo3 = x.Tipo
    Me.Text5 = x.nomeLiq
    Me.Combo4 = x.tipo409
    Me.Combo5 = x.Concentracao
    Me.Text4 = Str(x.PrazoResgate)
    Me.Check1 = Bol2Check(x.OverrideLimit)
    Me.Text6 = Format(x.LIM_VaR * 100, "#0.0")
    Me.Text7 = Format(x.LIM_Stress * 100, "#0.0")
    Me.Text8 = Format(x.LIM_EL * 100, "#0.0")
    Me.Text9 = Format(x.LIM_UL * 100, "#0.0")
    Me.Text10 = Format(x.CaixaMandato * 100, "#0.0")
    Me.Combo6 = x.area
    Me.Check2 = Bol2Check(x.LimCredReg)
    Me.Check3 = Bol2Check(x.Favorit_Cash)
    Me.Check4 = Bol2Check(x.Favorit_Credit)
    Me.Check5 = Bol2Check(x.Favorit_Mkt)
    Me.Combo7 = x.LiqMethod
    Me.Text11 = Format(x.Tolerancia1, "##0")
    Me.Text12 = Format(x.Tolerancia2, "##0")
    Me.Text13 = Format(x.LIM_Dur, "##0.00")
    Me.Text14 = x.nomeBlotter
    Me.Check6 = Bol2Check(x.Rule_NoDayTrd)
    Me.Check7 = Bol2Check(x.Rule_NoCrssTrd)
    
    Me.Label1 = "Identificador:    " + Format(x.ID, "00")
    
    List1.Clear
    For Each b In Books.c
        If Not x.IAmAssignedToBook(b) Then List1.AddItem b.nome
    Next b
    
    List2.Clear
    For Each b In x.MyBooks
        List2.AddItem b.nome
    Next b
    
    Me.Show vbModal
End Sub


Private Sub B_Cancel_Click()
    Me.Hide
End Sub

Private Sub B_OK_Click()
    Dim b As CBook, ObjTitulo As CPapel
    
    If Me.Text1 = Obj.nome Or Fundos.searchName(Me.Text1) Is Nothing Then
        'Edita o fundo
        Obj.CNPJ = CNPJSemPonto(Me.Text2)
        Obj.nome = Me.Text1
        Obj.IDTitulo = Me.Text3
        Obj.qualif = Me.Combo1
        Obj.Consol = Me.Combo2
        Obj.nomeLiq = Me.Text5
        Obj.tipo409 = Me.Combo4
        Obj.Concentracao = Me.Combo5
        Obj.PrazoResgate = Val(Me.Text4)
        Obj.Tipo = Me.Combo3
        Obj.OverrideLimit = Check2Bol(Me.Check1)
        Obj.LIM_VaR = Val(Me.Text6) / 100
        Obj.LIM_Stress = Val(Me.Text7) / 100
        Obj.LIM_EL = Val(Me.Text8) / 100
        Obj.LIM_UL = Val(Me.Text9) / 100
        Obj.CaixaMandato = Val(Me.Text10) / 100
        Obj.LimCredReg = Check2Bol(Me.Check2)
        Obj.area = Combo6
        Obj.Favorit_Cash = Check2Bol(Me.Check3)
        Obj.Favorit_Credit = Check2Bol(Me.Check4)
        Obj.Favorit_Mkt = Check2Bol(Me.Check5)
        Obj.LiqMethod = Me.Combo7
        Obj.Tolerancia1 = Val(Me.Text11)
        Obj.Tolerancia2 = Val(Me.Text12)
        Obj.LIM_Dur = Val(Me.Text13)
        Obj.nomeBlotter = Me.Text14
        Obj.Rule_NoDayTrd = Check2Bol(Me.Check6)
        Obj.Rule_NoCrssTrd = Check2Bol(Me.Check7)
        
        
        'Coloca os books
        Obj.ClearBooks
        For i = 0 To Me.List2.ListCount - 1
            Set b = Books.search(Me.List2.List(i))
            If Not b Is Nothing Then Obj.AddNewBook b.ID
        Next i
            
        'salva
        Obj.WriteDB
        
        Me.Hide
        
        Papeis.Linka '--- tem que relinkar os papéis, pois o ID do fundo-papel pode ter mudado.
        Trades.EnderecaForFund Obj '--tem que reendereçar os trades pois o ID-blotter pode ter mudado.
        
        'Recalcula o fundo - se ele for investido de outro, recalcula toda a árvore de fundos
        Obj.Recalc
        Set ObjTitulo = Papeis.search(Obj.IDTitulo)
        If Not ObjTitulo Is Nothing Then Fundos.Recalc
                
        'refazforms
        FMain.Refaz
        
        WriteLog "EDITOU FUNDO " + Obj.nome
        
    Else
        MsgBox ("Tentativa de alterar o nome para um nome já existente. Tente outro.")
    End If
End Sub

Private Sub Command1_Click()
    Dim i As Integer
    i = List1.ListIndex
    If i > -1 Then
        List2.AddItem List1.List(i)
        List1.RemoveItem i
    End If
End Sub

Private Sub Command2_Click()
    Dim i As Integer
    i = List2.ListIndex
    If i > -1 Then
        List1.AddItem List2.List(i)
        List2.RemoveItem i
    End If
End Sub


Public Sub newrefresh()
End Sub



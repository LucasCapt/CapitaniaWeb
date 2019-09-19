VERSION 5.00
Begin VB.Form Fsimula 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Simulação de Operação"
   ClientHeight    =   3180
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5415
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3180
   ScaleWidth      =   5415
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Combo4 
      Height          =   315
      Left            =   1560
      TabIndex        =   9
      Text            =   "Combo1"
      Top             =   1560
      Width           =   3735
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   1560
      TabIndex        =   8
      Text            =   "Text1"
      Top             =   2040
      Width           =   3735
   End
   Begin VB.ComboBox Combo3 
      Height          =   315
      Left            =   1560
      TabIndex        =   7
      Text            =   "Combo1"
      Top             =   1080
      Width           =   3735
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   1560
      TabIndex        =   6
      Text            =   "Combo1"
      Top             =   600
      Width           =   3735
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   1560
      TabIndex        =   5
      Text            =   "Combo1"
      Top             =   120
      Width           =   3735
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Simular"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   3960
      TabIndex        =   4
      Top             =   2520
      Width           =   1335
   End
   Begin VB.Label Label5 
      Caption         =   "Papel Cash"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   10
      Top             =   1560
      Width           =   1455
   End
   Begin VB.Label Label4 
      Caption         =   "Valor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   3
      Top             =   2040
      Width           =   1455
   End
   Begin VB.Label Label3 
      Caption         =   "Papel Compra"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   1080
      Width           =   1455
   End
   Begin VB.Label Label2 
      Caption         =   "Vendedor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   1455
   End
   Begin VB.Label Label1 
      Caption         =   "Comprador"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1335
   End
End
Attribute VB_Name = "Fsimula"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub newshow()
    Dim f As CFundo, p As CPapel
    Combo3.Clear
    Combo4.Clear
    
    Fundos.FillComboListWithNomes Combo1
    Fundos.FillComboListWithNomes Combo2
    Combo1.AddItem ("=MERCADO=")
    Combo2.AddItem ("=MERCADO=")
    
    Combo1 = "=MERCADO="
    Combo2 = "=MERCADO="
    For Each p In Papeis.c
        Combo3.AddItem p.nome
        If p.ehcaixa Then Combo4.AddItem p.nome
    Next p
    Text1 = "0"
    Show
End Sub

Private Sub Command1_Click()
    Dim f As CFundo, fcp As CFundo, fvd As CFundo, p As CPosic, pcp As CPosic, pvd As CPosic, dif As Double, vai As Boolean
    
    EnterSimulation
    vai = True
    dif = 0
    
    'Verifica montantes a serem transferidos
        If Combo1 <> "=MERCADO=" Then
            Set fcp = Fundos.searchName(Combo1)
            Set pcp = fcp.SearchPositOn(Combo4)
            If pcp Is Nothing Then
                MsgBox ("Cash " + Combo4 + " não encontrado em " + Combo1)
                vai = False
            Else
                If pcp.Valor < Val(Text1) Then
                    dif = pcp.Valor
                    MsgBox ("Caixa disponível para compra = " + Format(dif, "###,###,##0"))
                Else
                    dif = Val(Text1)
                End If
            End If
        Else
            dif = Val(Text1) 'Comprador é o mercado. Pode vender quanto quiser
        End If
    
        If Combo2 <> "=MERCADO=" Then
            Set fvd = Fundos.searchName(Combo2)
            Set pvd = fvd.SearchPositOn(Combo3)
            If pvd Is Nothing Then
                MsgBox ("Papel " + Combo3 + " não encontrado em " + Combo2)
                vai = False
            Else
                If pvd.Valor < dif Then
                    dif = pvd.Valor
                    MsgBox ("Papel disponível para venda = " + Format(dif, "###,###,##0"))
                End If
            End If
        End If 'se vendedor não é mercado
    
    If vai Then
    
        MsgBox ("Negociando " + Format(dif, "###,###,##0") + " em ativos.")
        
        'Tira o papel e coloca o caixa no vendedor
            If Combo2 <> "=MERCADO=" Then
                If pvd.Quant <> 0 Then pvd.QuantD = pvd.QuantD - dif / (pvd.Valor / pvd.Quant)
                pvd.ValorD = pvd.ValorD - dif 'ajusta o financeiro
                Set p = fvd.SearchPositOn(Combo4) 'Procura o papel caixa
                If Not p Is Nothing Then
                    If p.Quant <> 0 Then p.QuantD = p.QuantD + div / (p.Valor / p.Quant)
                    p.ValorD = p.ValorD + dif 'ajusta o valor
                Else
                    'Cria o papel caixa
                    fvd.IncluiPosic Combo4, dif, dif, True, "AUTO_TIPO_3"
                End If
            End If
            
        'Coloca o papel e tira o caixa do comprador
            If Combo1 <> "=MERCADO=" Then
                If pcp.Quant <> 0 Then pcp.QuantD = -dif / (pcp.Valor / pcp.Quant)
                pcp.ValorD = pcp.ValorD - dif
                Set p = fcp.SearchPositOn(Combo3) 'Procura o papel a comprar
                If Not p Is Nothing Then
                    If p.Quant <> 0 Then p.QuantD = dif / (p.Valor / p.Quant)
                    p.ValorD = p.ValorD + dif
                Else
                    'Inclui o papel a comprar
                    fcp.IncluiPosic Combo3, dif, dif, True, "AUTO_TIPO_3"
                End If
            End If
            
        'Recalcula Tudo
            Fundos.Recalc
    
        'Refaz os forms
        FMain.Refaz
    
    End If
    Me.Hide
End Sub

Public Sub newrefresh()
End Sub

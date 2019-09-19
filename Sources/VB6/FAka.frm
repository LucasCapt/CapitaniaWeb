VERSION 5.00
Begin VB.Form FAka 
   Caption         =   "Incluir na Lista de Alias"
   ClientHeight    =   4935
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5295
   LinkTopic       =   "Form1"
   ScaleHeight     =   4935
   ScaleWidth      =   5295
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame1 
      BorderStyle     =   0  'None
      Height          =   2895
      Left            =   0
      TabIndex        =   5
      Top             =   1320
      Width           =   5415
      Begin VB.ComboBox Combo1 
         Height          =   315
         Left            =   360
         TabIndex        =   9
         Text            =   "Combo1"
         Top             =   600
         Width           =   4575
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   360
         TabIndex        =   8
         Text            =   "Text1"
         Top             =   2520
         Width           =   4815
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Receberá o seguinte identificador alternativo:"
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
         Left            =   0
         TabIndex        =   7
         Top             =   2160
         Width           =   5295
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Será daqui em diante identificado com o seguinte título:"
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
         Left            =   0
         TabIndex        =   6
         Top             =   240
         Width           =   5295
      End
      Begin VB.Label Label5 
         Caption         =   "E daqui por diante não terá um registro próprio"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   360
         TabIndex        =   11
         Top             =   1320
         Width           =   4215
      End
      Begin VB.Label Label6 
         Caption         =   "()"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   360
         TabIndex        =   10
         Top             =   960
         Width           =   4695
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancelar"
      Height          =   375
      Left            =   3960
      TabIndex        =   4
      Top             =   4440
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Prosseguir"
      Height          =   375
      Left            =   2640
      TabIndex        =   3
      Top             =   4440
      Width           =   1215
   End
   Begin VB.Label Label4 
      BackColor       =   &H8000000E&
      Caption         =   "Label4"
      Height          =   255
      Left            =   0
      TabIndex        =   2
      Top             =   960
      Width           =   5175
   End
   Begin VB.Label Label2 
      Caption         =   "O Título da seguinte ID:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   5175
   End
   Begin VB.Label Label1 
      Caption         =   "Use a Lista AKA quando dois ou mais IDs se referirem ao mesmo título."
      Height          =   255
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5175
   End
End
Attribute VB_Name = "FAka"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Obj As CPapel

Public Sub ShowFor(x As CPapel)
    Set Obj = x
    Label4 = x.ID
    Papeis.FillComboWithID Combo1
    Combo1 = x.ID
    Label6 = "( )"
    Me.Show
End Sub



Private Sub Combo1_lostfocus()
    Dim pp As CPapel
    Set pp = Papeis.search(Combo1)
    If Not pp Is Nothing Then Label6 = "(" + pp.nome + ")" Else Label6 = "(desconhecido)"
End Sub

Private Sub Command1_Click()
    If Option1 Then
        'É para associar a outro título
        If Label4 = Combo1 Then
            MsgBox ("Não é possível criar com o mesmo nome" + Chr(13) + "Refaça ou Cancele")
        ElseIf Papeis.search(Combo1) Is Nothing Then
            MsgBox ("Não há papel com ID " + Combo1 + Chr(13) + "Refaça ou Cancele")
        Else
            If MsgBox("Tem certeza que deseja prosseguir?", vbYesNo) = vbYes Then
                Papeis.AKA Label4, Combo1
                FMain.Refaz
            Else
                MsgBox ("Criação de AKA cancelada.")
            End If
            Me.Hide
        End If
        
    ElseIf Option2 Then
        'É para criar outro ID
        If Text1.Text = "" Then
            MsgBox ("Nome inválido." + Chr(13) + "Refaça ou Cancele")
        ElseIf Papeis.IdentifierUsed(Text1.Text) Then
            MsgBox ("Identificador já existente." + Chr(13) + "Refaça ou Cancele")
        Else
            If MsgBox("Tem certeza que deseja prosseguir?", vbYesNo) = vbYes Then
                'Cria
                Papeis.AKA Text1.Text, Label4
                FMain.Refaz
            Else
                MsgBox ("Criação de AKA cancelada.")
            End If
            Me.Hide
        End If
    End If
End Sub

Private Sub Command2_Click()
    MsgBox ("Inlcusão na AKA List cancelada")
    Me.Hide
End Sub



Public Sub NewRefresh()
End Sub

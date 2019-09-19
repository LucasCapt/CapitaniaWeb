VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Begin VB.Form FStress 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Cenários de Stress"
   ClientHeight    =   6090
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4920
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6090
   ScaleWidth      =   4920
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command6 
      Caption         =   "Exclui Cenário"
      Height          =   375
      Left            =   120
      TabIndex        =   13
      Top             =   5640
      Width           =   1455
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   120
      TabIndex        =   12
      Top             =   5040
      Width           =   4695
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Cria Cenário"
      Height          =   375
      Left            =   120
      TabIndex        =   11
      Top             =   5280
      Width           =   1455
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   960
      TabIndex        =   8
      Text            =   "Combo2"
      Top             =   4080
      Width           =   3855
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   2655
      Left            =   0
      TabIndex        =   7
      Top             =   720
      Width           =   4815
      _ExtentX        =   8493
      _ExtentY        =   4683
      _Version        =   393216
      FixedCols       =   0
      Appearance      =   0
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   0
      TabIndex        =   6
      Text            =   "Combo1"
      Top             =   0
      Width           =   4815
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   375
      Left            =   3720
      TabIndex        =   4
      Top             =   5640
      Width           =   1095
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   2640
      TabIndex        =   3
      Top             =   5640
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   120
      TabIndex        =   2
      Top             =   4080
      Width           =   855
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Inclui Choque"
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   4440
      Width           =   1455
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Exclui Choque"
      Height          =   375
      Left            =   3360
      TabIndex        =   0
      Top             =   3360
      Width           =   1455
   End
   Begin VB.Label Label3 
      Caption         =   "Título"
      Height          =   255
      Left            =   1080
      TabIndex        =   10
      Top             =   3840
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "Percentual"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   3840
      Width           =   855
   End
   Begin VB.Label Label2 
      Caption         =   "Choques desse cenário:"
      Height          =   255
      Left            =   0
      TabIndex        =   5
      Top             =   480
      Width           =   4815
   End
End
Attribute VB_Name = "FStress"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mudou As Boolean

Public Sub ShowFor()
    mudou = False
    Stress.FillComboWithNome Combo1
    Papeis.FillComboWithNames Combo2
    Grid.FormatString = "Percent  |Título                                                                     "
    If Combo1.ListCount > 0 Then Combo1 = Combo1.List(1)
    Me.Show
    newrefresh
End Sub


Public Sub newrefresh()
    Stress.FillGrid Combo1, Grid
    Me.Refresh
End Sub

Private Sub Combo1_lostfocus()
    newrefresh
End Sub

Private Sub Command1_Click()
    If mudou Then Stress.WriteDB
    Me.Hide
End Sub

Private Sub Command2_Click()
    If mudou Then Stress.ReadDB
    Me.Hide
End Sub

Private Sub Command3_Click()
    Dim u As Double
    If Text1 <> "" And Combo2 <> "" Then
        If Right(Text1, 1) = "%" Then u = Val(Left(Text1, Len(Text1) - 1)) / 100 Else u = Val(Text1)
        Stress.Inlcui Combo1, Combo2, u
        Stress.FillGrid Combo1, Grid
        mudou = True
    End If
End Sub

Private Sub Command4_Click()
    If Grid.Row > 0 Then
        Stress.Exclui Combo1, Grid.TextMatrix(Grid.Row, 1)
        Stress.FillGrid Combo1, Grid
        mudou = True
    End If
End Sub

Private Sub Command5_Click()
    Dim u As Double
    If Text1 <> "" Then
        If Combo2 <> "" And Text2 <> "" Then
            If Right(Text1, 1) = "%" Then u = Val(Left(Text1, Len(Text1) - 1)) / 100 Else u = Val(Text1)
            Stress.Inlcui Text2, Combo2, u
            Combo1.AddItem Text2
            Combo1 = Text2
            Stress.FillGrid Combo1, Grid
            mudou = True
        Else
            MsgBox ("Preencha os dados do choque para criar o cenário.")
        End If
    End If
End Sub

Private Sub Command6_Click()
    'Exclui cenário
    Stress.Deleta Combo1
    Stress.FillComboWithNome Combo1
    If Combo1.ListCount > 0 Then Combo1 = Combo1.List(1)
    mudou = True
    newrefresh
End Sub

Private Sub Grid_dblclick()
    If Grid.Row > 0 Then
        Text1 = Grid.TextMatrix(Grid.Row, 0)
        Combo2 = Grid.TextMatrix(Grid.Row, 1)
    End If
End Sub


Private Sub form_queryunload(cancel As Integer, unloadmode As Integer)
    If mudou Then Stress.ReadDB
End Sub

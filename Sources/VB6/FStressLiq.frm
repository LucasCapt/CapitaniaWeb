VERSION 5.00
Begin VB.Form FStressLiq 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Stress de Liquidez"
   ClientHeight    =   4920
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5325
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4920
   ScaleWidth      =   5325
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command3 
      Caption         =   "Remove"
      Height          =   375
      Left            =   3600
      TabIndex        =   11
      Top             =   1440
      Width           =   855
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Inclui"
      Height          =   375
      Left            =   1200
      TabIndex        =   10
      Top             =   1440
      Width           =   855
   End
   Begin VB.ListBox List1 
      Height          =   1425
      Left            =   480
      TabIndex        =   9
      Top             =   1800
      Width           =   4695
   End
   Begin VB.CommandButton Command2 
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
      Left            =   3840
      TabIndex        =   8
      Top             =   4320
      Width           =   1335
   End
   Begin VB.OptionButton Option2 
      Caption         =   "Liquidar"
      Height          =   255
      Left            =   480
      TabIndex        =   7
      Top             =   3840
      Width           =   2055
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   2400
      TabIndex        =   5
      Text            =   "12"
      Top             =   3480
      Width           =   375
   End
   Begin VB.OptionButton Option1 
      Caption         =   "Zerar pagamentos por "
      Height          =   255
      Left            =   480
      TabIndex        =   4
      Top             =   3480
      Width           =   2055
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   480
      TabIndex        =   3
      Text            =   "Combo1"
      Top             =   1080
      Width           =   4695
   End
   Begin VB.CheckBox Check2 
      Caption         =   "Afetar a liquidez dos seguintes títulos:"
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   720
      Width           =   3975
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   4200
      TabIndex        =   1
      Text            =   "2.33"
      Top             =   120
      Width           =   975
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Multiplicar a volatilidade de resgate pelo fator"
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3975
   End
   Begin VB.Line Line2 
      X1              =   0
      X2              =   5280
      Y1              =   4200
      Y2              =   4200
   End
   Begin VB.Line Line1 
      X1              =   0
      X2              =   5280
      Y1              =   600
      Y2              =   600
   End
   Begin VB.Label Label1 
      Caption         =   "meses"
      Height          =   255
      Left            =   2880
      TabIndex        =   6
      Top             =   3480
      Width           =   615
   End
End
Attribute VB_Name = "FStressLiq"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub NewShow()
    Call Papeis.FillComboWithNames(Me.Combo1)
    Me.Show
End Sub

Private Sub Command1_Click()
    List1.AddItem (Combo1)
End Sub

Private Sub Command2_Click()
    Dim p As CPapel, f As CFundo, i As Integer
    
    EnterSimulation
    
    'Escala a volatilidade dos saques
    If Check2Bol(Check1) Then
        For Each f In Fundos.c
            f.VolPL = f.VolPL * Config.VaRConf
        Next f
    End If
        
    'Altera os CashFlows
    For i = 0 To List1.ListCount
        Set p = Papeis.searchName(List1.List(i))
        If Not p Is Nothing Then
            If Check2Bol(Check2) Then
                If Option1 Then
                    'Zera cashflows
                    p.ZeraFlowsPor (Val(Me.Text2))
                ElseIf Option2 Then
                    'Liquida
                    p.Class_Liq = "CASH"
                End If
            End If
        End If
    Next i
        
    'Recalcula
        Fundos.Recalc
        
    'Refaz os forms
    FMain.Refaz
    Me.Hide
End Sub

Public Sub NewRefresh()
End Sub

Private Sub Command3_Click()
     Me.List1.RemoveItem (Me.List1.ListIndex)
End Sub

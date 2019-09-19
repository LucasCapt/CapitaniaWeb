VERSION 5.00
Begin VB.Form FInputData 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Escolha nova data"
   ClientHeight    =   1350
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4260
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1350
   ScaleWidth      =   4260
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command3 
      Caption         =   "Hoje"
      Height          =   375
      Left            =   120
      TabIndex        =   5
      Top             =   840
      Width           =   735
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   375
      Left            =   3240
      TabIndex        =   4
      Top             =   840
      Width           =   975
   End
   Begin VB.ComboBox Combo3 
      Height          =   315
      Left            =   3240
      TabIndex        =   2
      Text            =   "Combo3"
      Top             =   360
      Width           =   975
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   960
      TabIndex        =   1
      Text            =   "Combo2"
      Top             =   360
      Width           =   2175
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   120
      TabIndex        =   0
      Text            =   "Combo1"
      Top             =   360
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "dia               mes                                            ano"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   4095
   End
End
Attribute VB_Name = "FInputData"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private mes As Variant

Public Function ShowFor(x As Date, PoeHoje As Boolean) As Date
    mes = Array("Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")
    Me.Combo1.Clear
    Me.Combo2.Clear
    Me.Combo3.Clear
    Command3.Visible = PoeHoje
    For i = 1 To 31: Me.Combo1.AddItem (Str(i)): Next i
    For i = 1 To 12: Me.Combo2.AddItem (mes(i - 1)): Next i
    For i = 0 To 5: Me.Combo3.AddItem (Str(Year(Now()) - i)): Next i
    Me.Combo1 = Str(Day(x))
    Me.Combo2.ListIndex = Month(x) - 1
    Me.Combo3 = Str(Year(x))
    Me.Show vbModal
    ShowFor = DateSerial(Val(Combo3), Combo2.ListIndex + 1, Val(Combo1))
End Function

Private Sub Command1_Click()
    Me.Hide
End Sub


Private Sub Command3_Click()
    Me.Combo1 = Str(Day(Now()))
    Me.Combo2 = mes(Month(Now()) - 1)
    Me.Combo3 = Str(Year(Now()))
End Sub

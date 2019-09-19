VERSION 5.00
Begin VB.Form FInput 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Input"
   ClientHeight    =   1215
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5280
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1215
   ScaleWidth      =   5280
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   120
      TabIndex        =   4
      Text            =   "Combo1"
      Top             =   360
      Width           =   5055
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancela"
      Height          =   375
      Left            =   2880
      TabIndex        =   3
      Top             =   720
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   375
      Left            =   4080
      TabIndex        =   2
      Top             =   720
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   120
      TabIndex        =   0
      Top             =   360
      Width           =   5055
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   0
      Width           =   2655
   End
End
Attribute VB_Name = "FInput"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Function Pergunte(x As String, Optional What = "STRING", Optional default = "") As String
    Dim EhTxt As Boolean
    
    Me.Label1 = x
    Me.Text1 = ""
    Me.Combo1.Visible = False
    Me.Text1.Visible = False
    Select Case What
        Case "FUNDO", "FUNDOS"
            Me.Combo1.Visible = True
            Fundos.FillComboListWithNomes Me.Combo1
            Me.Combo1 = default
            EhTxt = False
        Case "RULEBOOK", "RULEBOOKS"
            Me.Combo1.Visible = True
            Books.FillComboListWithNomes Me.Combo1
            Me.Combo1 = default
            EhTxt = False
        Case "STRING"
            Me.Text1.Visible = True
            Me.Text1 = default
            EhTxt = True
    End Select
    Pergunte = ""
    Me.Show vbModal
    If EhTxt Then Pergunte = Me.Text1 Else Pergunte = Me.Combo1
End Function

Private Sub Command1_Click()
    Me.Hide
End Sub

Private Sub Command2_Click()
    Me.Text1 = ""
    Me.Hide
End Sub


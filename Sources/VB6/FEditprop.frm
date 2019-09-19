VERSION 5.00
Begin VB.Form FEditprop 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Edita Propriedade"
   ClientHeight    =   5280
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4365
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5280
   ScaleWidth      =   4365
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox Check1 
      Caption         =   "Valor Livre"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   4680
      Width           =   1815
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   840
      TabIndex        =   7
      Text            =   "Text2"
      Top             =   120
      Width           =   3375
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Exclui Valor"
      Height          =   375
      Left            =   2760
      TabIndex        =   5
      Top             =   3480
      Width           =   1455
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Inclui Valor"
      Height          =   375
      Left            =   120
      TabIndex        =   4
      Top             =   4200
      Width           =   1455
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   120
      TabIndex        =   3
      Text            =   "Text1"
      Top             =   3960
      Width           =   4215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   2160
      TabIndex        =   2
      Top             =   4800
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   375
      Left            =   3240
      TabIndex        =   1
      Top             =   4800
      Width           =   1095
   End
   Begin VB.ListBox List1 
      Height          =   2595
      Left            =   0
      TabIndex        =   0
      Top             =   840
      Width           =   4215
   End
   Begin VB.Label Label2 
      Caption         =   "Valores que essa propriedade pode tomar:"
      Height          =   255
      Left            =   0
      TabIndex        =   8
      Top             =   600
      Width           =   4095
   End
   Begin VB.Label Label1 
      Caption         =   "Nome"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   120
      Width           =   615
   End
End
Attribute VB_Name = "FEditprop"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Obj As CPropriedade


Public Sub showfor(x As CPropriedade)
    Dim i As Integer
    Set Obj = x
    Me.Text2 = x.nome
    Me.Text1 = ""
    Me.List1.Clear
    For i = 1 To x.N
        Me.List1.AddItem x.Valor(i)
    Next i
    Me.Check1 = Bol2Check(x.ValorLivre)
    Me.Show vbModal
End Sub


Private Sub Command1_Click()
    'OK
    Obj.nome = Me.Text2
    Obj.Clear
    For i = 0 To Me.List1.ListCount - 1
        Obj.AddNew Me.List1.List(i)
    Next i
    Obj.ValorLivre = Check2Bol(Check1)
    Obj.WriteDB
    Me.Hide
    
    FMain.Refaz
End Sub

Private Sub Command2_Click()
    Me.Hide
End Sub

Private Sub Command3_Click()
    Dim u(1000) As String, N As Integer
    If Text1 <> "" Then Me.List1.AddItem Text1
End Sub

Private Sub Command4_Click()
    'If Me.List1.ListIndex <> 0 Then Me.List1.RemoveItem (Me.List1.ListIndex)
    Me.List1.RemoveItem (Me.List1.ListIndex)
End Sub

Public Sub NewRefresh()
End Sub

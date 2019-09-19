VERSION 5.00
Begin VB.Form FEditBook 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Edita Livro de Regras"
   ClientHeight    =   5625
   ClientLeft      =   -15
   ClientTop       =   270
   ClientWidth     =   5700
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5625
   ScaleWidth      =   5700
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command2 
      Caption         =   "<--"
      Height          =   375
      Left            =   2520
      TabIndex        =   10
      Top             =   2400
      Width           =   495
   End
   Begin VB.CommandButton Command1 
      Caption         =   "-->"
      Height          =   375
      Left            =   2520
      TabIndex        =   9
      Top             =   1440
      Width           =   495
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   1080
      TabIndex        =   4
      Text            =   "Text1"
      Top             =   360
      Width           =   4575
   End
   Begin VB.ListBox List1 
      Height          =   3960
      Left            =   0
      TabIndex        =   3
      Top             =   1080
      Width           =   2535
   End
   Begin VB.ListBox List2 
      Height          =   3960
      Left            =   3000
      TabIndex        =   2
      Top             =   1080
      Width           =   2655
   End
   Begin VB.CommandButton B_Cancel 
      Caption         =   "Cancela"
      Height          =   375
      Left            =   3120
      TabIndex        =   1
      Top             =   5160
      Width           =   1095
   End
   Begin VB.CommandButton B_OK 
      Caption         =   "OK"
      Height          =   375
      Left            =   4440
      TabIndex        =   0
      Top             =   5160
      Width           =   1095
   End
   Begin VB.Label Label6 
      Caption         =   "Regras Disponíveis"
      Height          =   255
      Left            =   0
      TabIndex        =   8
      Top             =   840
      Width           =   2295
   End
   Begin VB.Label Label7 
      Caption         =   "Regras do Livro"
      Height          =   255
      Left            =   3000
      TabIndex        =   7
      Top             =   840
      Width           =   2295
   End
   Begin VB.Label Label1 
      Caption         =   "Identificador:"
      Height          =   255
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   5655
   End
   Begin VB.Label Label2 
      Caption         =   "Nome:"
      Height          =   255
      Left            =   0
      TabIndex        =   5
      Top             =   360
      Width           =   975
   End
End
Attribute VB_Name = "FEditBook"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Obj As CBook

Public Sub showfor(x As CBook)
    Dim b As CRegra
    
    Set Obj = x
        
    Me.Text1 = x.nome
    Me.Label1 = "Identificador:    " + Format(x.ID, "00")
    
    List1.Clear
    For Each b In Regras.c
        If Not x.IHaveRule(b) Then List1.AddItem b.nome
    Next b
    
    List2.Clear
    For Each b In x.c
        List2.AddItem b.nome
    Next b
    
    Me.Show vbModal
End Sub


Private Sub B_Cancel_Click()
    Me.Hide
End Sub

Private Sub B_OK_Click()
    Dim b As CRegra
        
    'Edita o livro
    Obj.nome = Me.Text1
        
    'Coloca as regras
    Obj.ClearRules
    For i = 0 To Me.List2.ListCount - 1
        Set b = Regras.searchNome(Me.List2.List(i))
        If Not b Is Nothing Then Obj.AddNewRule b.ID
    Next i
        
    'salva
    Obj.WriteDB
    Books.Recalc
    
    Me.Hide
    
    'refazforms
    FMain.Refaz
    
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


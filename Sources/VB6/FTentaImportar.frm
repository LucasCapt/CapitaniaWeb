VERSION 5.00
Begin VB.Form FTentaImportar 
   Caption         =   "Tentar Importar"
   ClientHeight    =   3900
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3600
   LinkTopic       =   "Form1"
   ScaleHeight     =   3900
   ScaleWidth      =   3600
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command4 
      Caption         =   "Não. Abra mesmo assim."
      Height          =   495
      Left            =   120
      TabIndex        =   6
      Top             =   2640
      Width           =   3375
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Tentar importar XML ANBIMA"
      Height          =   495
      Left            =   120
      TabIndex        =   5
      Top             =   1440
      Width           =   3375
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Tentar importar TXT"
      Height          =   495
      Left            =   120
      TabIndex        =   4
      Top             =   2040
      Width           =   3375
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Não. Cancelar."
      Height          =   495
      Left            =   120
      TabIndex        =   3
      Top             =   3240
      Width           =   3375
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      Caption         =   "Deseja tentar importar?"
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
      TabIndex        =   2
      Top             =   960
      Width           =   3615
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H8000000E&
      Caption         =   "Label2"
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Width           =   3375
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Nenhum fundo tem carteira para a data"
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
      TabIndex        =   0
      Top             =   0
      Width           =   3615
   End
End
Attribute VB_Name = "FTentaImportar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Resposta As String

Public Function ShowFor(d As Date) As String
    Resposta = "CANCEL"
    Label2 = Format(d, "dd-MMM-yyyy")
    Me.Show vbModal
    ShowFor = Resposta
End Function


Private Sub Command1_Click()
     Resposta = "CANCEL"
     Me.Hide
End Sub

Private Sub Command2_Click()
    Resposta = "TXT"
    Me.Hide
End Sub

Private Sub Command3_Click()
    Resposta = "XML"
    Me.Hide
End Sub

Private Sub Command4_Click()
    Resposta = "ANYWAY"
    Me.Hide
End Sub

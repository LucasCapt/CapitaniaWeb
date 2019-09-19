VERSION 5.00
Begin VB.Form FStart 
   Caption         =   "Form1"
   ClientHeight    =   570
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5400
   LinkTopic       =   "Form1"
   ScaleHeight     =   570
   ScaleWidth      =   5400
   StartUpPosition =   3  'Windows Default
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5175
   End
End
Attribute VB_Name = "FStart"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Sub Say(x As String)
    Me.Label1 = x
    Me.Refresh
End Sub

Sub newshow(x As String)
    Me.Label1 = x
    Me.Show vbModeless
End Sub

Public Sub newrefresh()
End Sub

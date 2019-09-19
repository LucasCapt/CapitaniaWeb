VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Begin VB.Form FCrpr 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Credit Profile"
   ClientHeight    =   4335
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4380
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4335
   ScaleWidth      =   4380
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   3975
      Left            =   0
      TabIndex        =   0
      Top             =   360
      Width           =   4335
      _ExtentX        =   7646
      _ExtentY        =   7011
      _Version        =   393216
      BackColor       =   12648384
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   255
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   4335
   End
End
Attribute VB_Name = "FCrpr"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Obj As CPapel

Public Sub showfor(x As CPapel)
    Set Obj = x
    Label1.Caption = x.nome
    Grid.Rows = 12
    Grid.Cols = 2
    Grid.ColWidth(0) = 2000
    Grid.ColWidth(1) = 2000
    Grid.ColAlignment(0) = 2
    Grid.ColAlignment(1) = 3
    Grid.TextMatrix(1, 0) = "Rating Externo"
    Grid.TextMatrix(2, 0) = "Agência"
    Grid.TextMatrix(3, 0) = "Última Revisão"
    Grid.TextMatrix(4, 0) = "Rating Interno"
    Grid.TextMatrix(5, 0) = "Name Código"
    Grid.TextMatrix(6, 0) = "name"
    Grid.TextMatrix(7, 0) = "Name Score"
    Grid.TextMatrix(8, 0) = "Senioridade"
    Grid.TextMatrix(9, 0) = "User Score"
    Grid.TextMatrix(10, 0) = "1YPD"
    Grid.TextMatrix(11, 0) = "LGD"
    Me.Show
    newrefresh
End Sub


Public Sub newrefresh()
    Grid.TextMatrix(1, 1) = Obj.CreditRating
    Grid.TextMatrix(4, 1) = Obj.BaseIRBRating
    Grid.TextMatrix(5, 1) = Obj.NameCr
    If Obj.MyCrdName Is Nothing _
        Then Grid.TextMatrix(6, 1) = "" _
        Else Grid.TextMatrix(6, 1) = Obj.MyCrdName.nome
    Grid.TextMatrix(7, 1) = Obj.NameCreditScore
    Grid.TextMatrix(8, 1) = Obj.Senior
    Grid.TextMatrix(9, 1) = Obj.UserCreditRating
    Grid.TextMatrix(10, 1) = Format(Obj.IRBPD, "##0.0%")
    Grid.TextMatrix(11, 1) = Format(Obj.CredLGD, "##0.0%")
End Sub


Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

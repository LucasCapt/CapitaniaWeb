VERSION 5.00
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Begin VB.Form FReport 
   Caption         =   "Risk Report"
   ClientHeight    =   10065
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   14055
   LinkTopic       =   "Form1"
   ScaleHeight     =   10065
   ScaleWidth      =   14055
   StartUpPosition =   3  'Windows Default
   Begin MSForms.TextBox Texto 
      CausesValidation=   0   'False
      Height          =   10095
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   14055
      VariousPropertyBits=   -1400879077
      ScrollBars      =   3
      Size            =   "24791;17806"
      FontName        =   "Courier New"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
   End
End
Attribute VB_Name = "FReport"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub newshow(Optional qual As String = "CTRL")
    Dim a As String
    FStart.Show
    FStart.Say "Preparando o relatório"
    Select Case qual
        Case "CTRL"
            Me.Caption = "Risk Control Report"
            Me.Texto = Messenger.Message(FStart)
        Case "GER"
            Me.Caption = "Risk Managerial Report"
            Me.Texto = Messenger.MessageGerencial(FStart)
        Case "ERR"
            Me.Caption = "Error Report"
            Me.Texto = Messenger.MessageErrors(FStart)
        Case "PTC"
            Me.Caption = "Pre-Trade Compliance"
            Me.Texto = Messenger.MessagePreTrade(FStart)
    End Select
    FStart.Hide
    Me.Show
End Sub


Private Sub form_resize()
    Me.Texto.Height = Me.Height - 350
    Me.Texto.Width = Me.Width - 230
End Sub

Public Sub newrefresh()
End Sub

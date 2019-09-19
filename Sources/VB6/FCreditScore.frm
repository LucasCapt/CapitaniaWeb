VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FCreditScore 
   Caption         =   "Credit Score"
   ClientHeight    =   9465
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10080
   LinkTopic       =   "Form1"
   ScaleHeight     =   9465
   ScaleWidth      =   10080
   StartUpPosition =   3  'Windows Default
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   9375
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   16536
      MultiRow        =   -1  'True
      Placement       =   2
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   2
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Nomes"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Títulos"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   9375
      Left            =   360
      TabIndex        =   0
      Top             =   0
      Width           =   9735
      _ExtentX        =   17171
      _ExtentY        =   16536
      _Version        =   393216
      BackColor       =   12648384
      AllowUserResizing=   1
   End
End
Attribute VB_Name = "FCreditScore"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub NewShow()
    Me.Show
    NewRefresh
End Sub

Public Sub NewRefresh()
    Dim i As Integer, u As CCreditName, pp As CPapel
    Grid.Rows = 1: Grid.Cols = 1
    Select Case TabStrip1.SelectedItem.Caption
        Case "Nomes"
            Grid.FormatString = "Setor                         |Nome                                      |^Código           |^Score        |^Score W-1     |^Eq.Rating     |^Eq.Rating W-1 |Action         "
            L = 0
            For Each u In CrNames.c
                L = L + 1
                Grid.AddItem u.Setor
                Grid.TextMatrix(L, 1) = u.nome
                Grid.TextMatrix(L, 2) = u.Cod
                Grid.TextMatrix(L, 3) = u.Score
                Grid.TextMatrix(L, 4) = u.ScoreW_1
                Grid.TextMatrix(L, 5) = u.Rating
                Grid.TextMatrix(L, 6) = u.RatingW_1
                Grid.TextMatrix(L, 7) = u.RatingAction
            Next u
        Case "Títulos"
            L = 0
            Grid.FormatString = "Papel                                               |^Interno     |Name                        |^Name Score  |^Senioridade           |^Name Based  |^Agencia     |^IRB Rating  "
            For Each pp In Papeis.c
                L = L + 1
                Grid.AddItem pp.nome
                Grid.TextMatrix(L, 1) = pp.UserCreditRating
                If pp.MyCrdName Is Nothing _
                    Then Grid.TextMatrix(L, 2) = "" _
                    Else Grid.TextMatrix(L, 2) = pp.MyCrdName.nome
                Grid.TextMatrix(L, 3) = pp.NameCreditScore
                Grid.TextMatrix(L, 4) = pp.Senior
                Grid.TextMatrix(L, 5) = pp.InternalRatingGuess2
                Grid.TextMatrix(L, 6) = pp.internalRatingGuess3
                Grid.TextMatrix(L, 7) = pp.BaseIRBRating
            Next pp
    End Select
End Sub



Private Sub form_resize()
    Grid.Height = max(1, Me.Height - 350)
    Grid.Width = max(1, Me.Width - 450)
    TabStrip1.Height = Grid.Height
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub TabStrip1_Click()
    NewRefresh
End Sub


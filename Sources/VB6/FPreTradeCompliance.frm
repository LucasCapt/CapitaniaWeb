VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FPreTradeCompliance 
   Caption         =   "Pre-Trade Compliance"
   ClientHeight    =   9015
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   15465
   LinkTopic       =   "Form1"
   ScaleHeight     =   9015
   ScaleWidth      =   15465
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "FPreTradeCompliance.frx":0000
      Left            =   1320
      List            =   "FPreTradeCompliance.frx":000A
      TabIndex        =   2
      Text            =   "Combo1"
      Top             =   0
      Width           =   1815
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   8655
      Left            =   360
      TabIndex        =   0
      Top             =   360
      Width           =   15135
      _ExtentX        =   26696
      _ExtentY        =   15266
      _Version        =   393216
      BackColor       =   12648447
      ForeColorSel    =   16777215
      AllowUserResizing=   1
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   8655
      Left            =   0
      TabIndex        =   1
      Top             =   360
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   15266
      MultiRow        =   -1  'True
      Placement       =   2
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   5
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "ASSET"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "ADV"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "TODOS"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab4 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "FAVORITOS"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab5 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "EXTERNO"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   14880
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   45
      ImageHeight     =   13
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FPreTradeCompliance.frx":001C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FPreTradeCompliance.frx":0756
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FPreTradeCompliance.frx":0E90
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FPreTradeCompliance.frx":15CA
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label Label1 
      Caption         =   "Política"
      Height          =   255
      Left            =   480
      TabIndex        =   3
      Top             =   0
      Width           =   735
   End
End
Attribute VB_Name = "FPreTradeCompliance"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Obj(1000) As Object
Private FundDetail As Collection

Public Sub newshow()
    Dim f As CFundo
    Set FundDetail = New Collection
    Grid.FormatString = "Fundo                              |#Trds|^Status Fundo |^Trade ID      |^Status Trade|<Trade                                                                                            |<Book                    |<Regra                                    |^Delta T-1 |^Delta T+0 |^Alocação T-1|^Alocação T+0|Limite              "
    Grid.MergeCells = flexMergeRestrictColumns
    Grid.MergeCol(0) = True
    Combo1.Text = "Hora"
    Me.Show
    NewRefresh2
End Sub


Public Sub NewRefresh2()
    Dim L As Integer, f As CFundo, u As CPreTradeCompItem
    t0 = Now()
    Me.MousePointer = vbHourglass
    Grid.Rows = 1
    Grid.Visible = False
    L = 0
    For Each f In Fundos.c
        If f.AtendeA(TabStrip1.SelectedItem.Caption) Then
            Grid.AddItem f.nome
            L = L + 1
            Set Obj(L) = f
            
            If Not f.PTCExecuted Then f.PreTradeCompliance
            Grid.TextMatrix(L, 1) = Str(f.PTCNTrades)
            
            If f.PTCNTrades > 0 Then
                Grid.Row = L: Grid.Col = 2: Grid.CellPictureAlignment = 3
                Set Grid.CellPicture = Me.ImageList1.ListImages(f.PTCResult + 1).Picture
                If stt < 2 Then
                    Grid.TextMatrix(L, 3) = "(todos)"
                    Grid.TextMatrix(L, 6) = "(todos)"
                    Grid.TextMatrix(L, 7) = "(todas)"
                End If
            End If
            
            If DetailThisFund(f) Then
                If f.PTCNTrades > 0 And f.PTCNodes.Count > 0 Then
                    TrID = f.PTCNodes(1).Trade
                    TrIdExtenso = f.PTCNodes(1).MyTrade.Extenso
                    stt = 0
                    For Each u In f.PTCNodes
                        stt = max(stt, u.Result)
                        If u.Result > 1 Then 'Se algum foi violação, cria uma linha para ele
                            Grid.AddItem f.nome
                            L = L + 1
                            Set Obj(L) = Nothing
                            Grid.Row = L: Grid.Col = 4: Grid.CellPictureAlignment = 3
                            Set Grid.CellPicture = Me.ImageList1.ListImages(u.Result + 1).Picture
                            Grid.TextMatrix(L, 3) = u.Trade
                            Grid.TextMatrix(L, 5) = u.MyTrade.Extenso
                            Grid.TextMatrix(L, 6) = u.Book
                            Grid.TextMatrix(L, 7) = u.regra.nome
                            Grid.TextMatrix(L, 8) = FNumkMM(u.DeltaA)
                            Grid.TextMatrix(L, 9) = FNumkMM(u.DeltaB)
                            Grid.TextMatrix(L, 10) = FormatLimit(u.PLSubA, u.regra)
                            Grid.TextMatrix(L, 11) = FormatLimit(u.PLSubB, u.regra)
                            Grid.TextMatrix(L, 12) = u.regra.LimiteExtenso
                            PintaLinha Grid, L, &HFFFFFF
                        End If
                        If u.Trade <> TrID Or u Is f.PTCNodes(f.PTCNodes.Count) Then 'mudou o trade ou chegou no último
                            If stt < 2 Then 'Se percorreu todos os testes e não violou, inclui uma linha com (todos)
                                Grid.AddItem f.nome
                                L = L + 1
                                Set Obj(L) = Nothing
                                Grid.Row = L: Grid.Col = 4: Grid.CellPictureAlignment = 3
                                Set Grid.CellPicture = Me.ImageList1.ListImages(stt + 1).Picture
                                Grid.TextMatrix(L, 3) = TrID
                                Grid.TextMatrix(L, 5) = TrIdExtenso
                                Grid.TextMatrix(L, 6) = "(todos)"
                                Grid.TextMatrix(L, 7) = "(todas)"
                                Grid.TextMatrix(L, 8) = ""
                                Grid.TextMatrix(L, 9) = ""
                                Grid.TextMatrix(L, 10) = ""
                                PintaLinha Grid, L, &HFFFFFF
                            End If
                            TrID = u.Trade
                            TrIdExtenso = u.MyTrade.Extenso
                            stt = 0
                        End If
                    Next u 'próximo PTCNode
                    
                End If 'ptcnodes.count>0
            End If 'Detail This Fund
        End If 'Atende A
    Next f
    Grid.Visible = True
    Me.MousePointer = vbDefault
End Sub


Private Function DetailThisFund(f As CFundo) As Boolean
    Dim u As CFundo
    DetailThisFund = False
    For Each u In FundDetail
        If u Is f Then DetailThisFund = True
    Next u
End Function

Private Sub RemoveThisFund(f As CFundo)
    Dim i As Integer
    For i = 1 To FundDetail.Count
        If i <= FundDetail.Count Then
            If FundDetail(i) Is f Then
                FundDetail.remove i
            End If
        End If
    Next i
End Sub


Public Sub newrefresh()
    'Recalcula
    If MsgBox("Deseja atualizar o pré-trade compliance?", vbYesNo) = vbYes Then
        Fundos.ResetPreTradeCompl
        NewRefresh2
    End If
End Sub

Private Sub Combo1_lostfocus()
    'Recalcula
    newrefresh
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub Grid_dblClick()
    If Grid.Row > 0 Then
        If Not Obj(Grid.Row) Is Nothing Then
            If DetailThisFund(Obj(Grid.Row)) Then RemoveThisFund Obj(Grid.Row) Else FundDetail.Add Obj(Grid.Row)
            NewRefresh2
        End If
    End If
End Sub

Private Sub TabStrip1_Click()
    Me.NewRefresh2
End Sub

Private Sub form_resize()
    Grid.Width = max(1, Me.Width - 450)
    Grid.Height = max(1, Me.Height - 750)
    TabStrip1.Height = Grid.Height
End Sub

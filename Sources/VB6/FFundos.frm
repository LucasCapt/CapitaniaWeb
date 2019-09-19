VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FFundos 
   Caption         =   "Fundos"
   ClientHeight    =   5880
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11145
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   5880
   ScaleWidth      =   11145
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   5895
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   10398
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
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   5895
      Left            =   360
      TabIndex        =   0
      Top             =   0
      Width           =   10815
      _ExtentX        =   19076
      _ExtentY        =   10398
      _Version        =   393216
      BackColor       =   12648447
      WordWrap        =   -1  'True
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   10320
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   14
      ImageHeight     =   14
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   10
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundos.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundos.frx":02F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundos.frx":05D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundos.frx":08D7
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundos.frx":0C29
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundos.frx":0FB2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundos.frx":133D
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundos.frx":1698
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundos.frx":1A36
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundos.frx":1D64
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FFundos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Public GridItem As New Collection

Public Sub newshow()
    Grid.FormatString = "Nome                                       |Val|^CNPJ                               |^Tipo              |^Qualif     |PL                      |Caixa     |^Liquid|^Compl |^ComplG|^EL(ext)   |^CVaR(ext) |Credit?|^EL(int)   |^CVaR(int) |IRB?   |^MVaR      |^QVaR      |^Stress    |Market?|Rating  |^Ult.Info   "
    Show
    newrefresh
End Sub

Public Sub newrefresh()
    Dim x As CFundo
    Grid.Visible = False
    Grid.Rows = 1
    L = 0
    Set GridItem = New Collection
    For Each x In Fundos.c
        If x.AtendeA(TabStrip1.SelectedItem.Caption) Then
            L = L + 1
            Grid.AddItem x.nome
            GridItem.Add x
            Grid.Row = L: Grid.Col = 1
            Grid.CellPictureAlignment = 3
            Select Case x.CarteiraUpdateStatus
                Case "ACT"
                    Set Grid.CellPicture = Me.ImageList1.ListImages(4).Picture
                Case "PRV"
                    Set Grid.CellPicture = Me.ImageList1.ListImages(10).Picture
                Case "EST"
                    Set Grid.CellPicture = Me.ImageList1.ListImages(9).Picture
                Case "INV"
                    Set Grid.CellPicture = Me.ImageList1.ListImages(5).Picture
            End Select
            
            Grid.TextMatrix(L, 2) = CNPJComPonto(x.CNPJ)
            Grid.TextMatrix(L, 3) = x.Tipo
            Grid.TextMatrix(L, 4) = x.qualif
            Grid.TextMatrix(L, 5) = Format(x.PLTotal, "#,###,###,##0")
            Grid.TextMatrix(L, 6) = Format(x.StaticCashPct, "##0%")
                    
            Grid.Row = L: Grid.Col = 7
            Grid.CellPictureAlignment = 3
            If Fundos.TypeReportsLiquidity(x.Tipo, x.area) Then
            
                Select Case x.StaticLiquidityOK
                    Case "OK"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(1).Picture
                    Case "WARN"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(2).Picture
                    Case "BREACH"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(3).Picture
                End Select
            Else
                Grid.TextMatrix(L, 7) = "-"
            End If
            
            Grid.Row = L: Grid.Col = 8
            Grid.CellPictureAlignment = 3
            Select Case x.IAmCompliant("CTRL")
                    Case "OK"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(1).Picture
                    Case "WARN"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(2).Picture
                    Case "BREACH"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(3).Picture
            End Select
            
            Grid.Row = L: Grid.Col = 9
            Grid.CellPictureAlignment = 3
            Select Case x.IAmCompliant("EXCTRL")
                    Case "OK"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(6).Picture
                    Case "WARN"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(7).Picture
                    Case "BREACH"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(8).Picture
            End Select
            
            
            '--------10
            
            Grid.TextMatrix(L, 10) = Format(x.StaticEL, "#0.0%")
            Grid.TextMatrix(L, 11) = Format(x.StaticUL, "#0.0%")
            Grid.Row = L: Grid.Col = 12
            Grid.CellPictureAlignment = 3
            
            If x.LimCredReg Then
                Grid.TextMatrix(L, 12) = "-"
            Else
                Select Case x.IAmCompliantWithCreditRisk
                    Case "OK"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(1).Picture
                    Case "WARN"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(2).Picture
                    Case "BREACH"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(3).Picture
                End Select
            End If
            Grid.TextMatrix(L, 13) = Format(x.StaticEL1, "#0.0%")
            Grid.TextMatrix(L, 14) = Format(x.StaticUL1, "#0.0%")
            Grid.Row = L: Grid.Col = 15
            Grid.CellPictureAlignment = 3
            If x.LimCredReg Then
                Grid.TextMatrix(L, 15) = "-"
            Else
                Select Case x.IAmCompliantWithCreditIRB
                    Case "OK"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(6).Picture
                    Case "WARN"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(7).Picture
                    Case "BREACH"
                        Set Grid.CellPicture = Me.ImageList1.ListImages(8).Picture
                End Select
            End If
            
            Grid.TextMatrix(L, 16) = Format(x.StaticVar, "#0.00%")
            Grid.TextMatrix(L, 17) = Format(x.StaticVarQuota, "#0.00%")
            Grid.TextMatrix(L, 18) = Format(x.StaticStress, "#0.0%")
            Grid.Row = L: Grid.Col = 19
            Grid.CellPictureAlignment = 3
            Select Case x.IAmCompliantWithMarketRisk
                Case "OK"
                    Set Grid.CellPicture = Me.ImageList1.ListImages(1).Picture
                Case "WARN"
                    Set Grid.CellPicture = Me.ImageList1.ListImages(2).Picture
                Case "BREACH"
                    Set Grid.CellPicture = Me.ImageList1.ListImages(3).Picture
            End Select
            
            Grid.TextMatrix(L, 20) = x.Static_Rating
            Grid.TextMatrix(L, 21) = Format(x.Dt_LastInfo, "dd-MMM")
            
        End If 'se é para mostrar
    Next x
    Grid.Visible = True
    Refresh
End Sub

Public Sub MENU_CRIA()
    Fundos.HighLevelCria
    FMain.Refaz
End Sub

Public Sub MENU_EDITA()
    If Grid.Row > 0 Then
        FEditFund.showfor GridItem(Grid.Row)
    End If
End Sub

Public Sub MENU_EXCLUI()
    If Grid.Row > 0 Then
        If MsgBox("Confirma a exclusão do Fundo " + Chr(13) + GridItem(Grid.Row).nome + Chr(13) + "com data final " + Format(BaseDate, "dd-mmm-yyyy"), vbYesNo) = vbYes Then
            Fundos.ExcluiFundo GridItem(Grid.Row)
            FMain.Refaz
        End If
    End If
End Sub

Public Sub MENU_LIQUIDITY()
    FLiquidityDetailed.showfor GridItem(Grid.Row).nome
End Sub

Private Sub form_resize()
    Grid.Width = max(1, Me.Width - 500)
    Grid.Height = max(1, Me.Height - 450)
    TabStrip1.Height = Grid.Height
End Sub


Public Sub Grid_dblClick()
    Dim f As CFundo, frm As Form, achou As Boolean
    Set f = Fundos.searchName(Grid.TextMatrix(Grid.Row, 0))
    Set frm = FMain.GetVisibleForm("FFundo")
    If Not frm Is Nothing Then FFundo.newshow f Else FFundo.FirstShow f
End Sub


Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub TabStrip1_Click()
    newrefresh
End Sub


'----------------------------------------------------------------------------
Private Sub Grid_MouseUp(button As Integer, Shift As Integer, x As Single, y As Single)
    If button = 2 Then PopUpMyMenu
End Sub

Private Sub grid_keyup(keycode As Integer, Shift As Integer)
    If keycode = 93 Then PopUpMyMenu
End Sub

Private Sub PopUpMyMenu()
    Me.PopupMenu FMain.mnua_Fundo
End Sub

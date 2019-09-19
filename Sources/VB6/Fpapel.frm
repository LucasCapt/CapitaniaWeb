VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Begin VB.Form Fpapel 
   Caption         =   "Títulos"
   ClientHeight    =   8220
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12570
   LinkTopic       =   "Form1"
   ScaleHeight     =   8220
   ScaleWidth      =   12570
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   7815
      Left            =   0
      TabIndex        =   0
      Top             =   360
      Width           =   12495
      _ExtentX        =   22040
      _ExtentY        =   13785
      _Version        =   393216
      BackColor       =   12648384
      ForeColor       =   0
      AllowUserResizing=   1
   End
   Begin VB.TextBox Text2 
      Height          =   375
      Left            =   9000
      TabIndex        =   10
      Top             =   0
      Width           =   1935
   End
   Begin VB.CommandButton Command1 
      Height          =   375
      Left            =   10920
      Picture         =   "Fpapel.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   0
      Width           =   495
   End
   Begin VB.CommandButton BCollapse 
      Caption         =   "Collapse"
      Height          =   375
      Left            =   5880
      TabIndex        =   7
      Top             =   0
      Width           =   735
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Text            =   "cri"
      Top             =   0
      Width           =   2655
   End
   Begin MSForms.ToggleButton TGGroup 
      Height          =   375
      Left            =   5160
      TabIndex        =   8
      Top             =   0
      Width           =   735
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      DisplayStyle    =   6
      Size            =   "1296;661"
      Value           =   "1"
      Caption         =   "Groups"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
   Begin MSForms.ToggleButton ToggleButton5 
      Height          =   375
      Left            =   4200
      TabIndex        =   6
      Top             =   0
      Width           =   615
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      DisplayStyle    =   6
      Size            =   "1085;661"
      Value           =   "0"
      Caption         =   "ASST"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
   Begin MSForms.ToggleButton ToggleButton4 
      Height          =   375
      Left            =   7680
      TabIndex        =   5
      Top             =   0
      Width           =   735
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      DisplayStyle    =   6
      Size            =   "1296;661"
      Value           =   "1"
      Caption         =   "Props."
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
   Begin MSForms.ToggleButton ToggleButton3 
      Height          =   375
      Left            =   6960
      TabIndex        =   4
      Top             =   0
      Width           =   735
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      DisplayStyle    =   6
      Size            =   "1296;661"
      Value           =   "0"
      Caption         =   "Financ."
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
   Begin MSForms.ToggleButton ToggleButton2 
      Height          =   375
      Left            =   3600
      TabIndex        =   3
      Top             =   0
      Width           =   615
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      DisplayStyle    =   6
      Size            =   "1085;661"
      Value           =   "0"
      Caption         =   "INV"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
   Begin MSForms.ToggleButton ToggleButton1 
      Height          =   375
      Left            =   2640
      TabIndex        =   2
      Top             =   0
      Width           =   615
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      DisplayStyle    =   6
      Size            =   "1085;661"
      Value           =   "0"
      Caption         =   "Filter"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
End
Attribute VB_Name = "Fpapel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Obj(5000) As CPapel
Private ShowGroup(15) As Boolean
Private LineGroup(15) As Integer
Private Filter As Boolean
Private PosicFilter As Boolean
Private AssetFilter As Boolean
Private FinancCols As Boolean
Private PropCols As Boolean


Private Group As Boolean

Sub NewShow()
    Filter = False
    ToggleButton1 = False
    PosicFilter = False
    ToggleButton2 = True
    FinancCols = False
    ToggleButton3 = False
    ToggleButton5 = False
    PropCols = True
    ToggleButton4 = True
    TGGroup = True
    Group = True
    
    newrefresh
    Show
End Sub

Property Get PointedObject() As Object
    If Grid.Row > 0 Then Set PointedObject = Obj(Grid.Row())
End Property

Private Function PodeMostrar(x As CPapel) As Boolean
    PodeMostrar = (Not Filter Or InStr(UCase(x.nome), UCase(Text1))) And _
                  (Not PosicFilter Or x.PosicTotalV <> 0) And _
                  (Not AssetFilter Or x.PosicAssetV <> 0)
End Function


Private Sub PrintDetailLine(x As CPapel, L As Integer, FinancCols As Boolean, cbase As Integer)
    Dim j As Integer
    Grid.AddItem "     " + x.nome
    Grid.TextMatrix(L, 1) = x.ID
    If FinancCols Then
        Grid.TextMatrix(L, 2) = x.CodCetip
        Grid.TextMatrix(L, 3) = x.ISIN
        Grid.TextMatrix(L, 4) = x.Status
        Grid.TextMatrix(L, 5) = x.Class_Liq
        Grid.TextMatrix(L, 6) = x.Class_Rent
        If Year(x.Dt_Emissao) < 2000 Then Grid.TextMatrix(L, 7) = "" Else Grid.TextMatrix(L, 7) = Format(x.Dt_Emissao, "dd-MMM-yy")
        If Year(x.Dt_Venc) < 2000 Then Grid.TextMatrix(L, 8) = "" Else Grid.TextMatrix(L, 8) = Format(x.Dt_Venc, "dd-MMM-yy")
        Grid.TextMatrix(L, 9) = Format(x.Duration, "##0.0")
        If x.Coupon = 0 Then Grid.TextMatrix(L, 10) = "" Else Grid.TextMatrix(L, 10) = Format(x.Coupon, "##0.00%")
        Grid.TextMatrix(L, 11) = x.DayCount
        Grid.TextMatrix(L, 12) = x.Index
        If x.CFFound Then Grid.TextMatrix(L, 13) = "X" Else Grid.TextMatrix(L, 13) = ""
        Grid.TextMatrix(L, 14) = x.Tipo
        Grid.TextMatrix(L, 15) = x.NameCreditScore
        Grid.TextMatrix(L, 16) = x.BaseIRBRating
        Grid.TextMatrix(L, 17) = Format(x.PosicTotalV / 1000000#, "##0.0")
    End If
    If PropCols Then
        For j = 1 To Props.c.Count
            Grid.TextMatrix(L, j + cbase) = x.PropV(j)
        Next j
    End If
End Sub

Public Sub newrefresh()
    Dim x As CPapel, i As Integer, j As Integer, cbase As Integer, ncols As Integer, b As Double, L As Integer
    Me.MousePointer = vbHourglass
    Grid.Rows = 1
    If FinancCols Then
        ncols = 18
        cbase = 17
    Else
        ncols = 2
        cbase = 1
    End If
    If PropCols Then ncols = ncols + Props.c.Count
    Grid.Cols = ncols
        
    Grid.TextMatrix(0, 1) = "ID"
    Grid.ColAlignment(1) = 3
    
    If FinancCols Then
        Grid.TextMatrix(0, 2) = "Cod.Cetip"
        Grid.ColAlignment(2) = 3
        Grid.TextMatrix(0, 3) = "ISIN"
        Grid.TextMatrix(0, 4) = "Status"
        Grid.TextMatrix(0, 5) = "Class.Liq"
        Grid.TextMatrix(0, 6) = "Class.Rent"
        Grid.TextMatrix(0, 7) = "Emissão"
        Grid.TextMatrix(0, 8) = "Maturity"
        Grid.TextMatrix(0, 9) = "Duration"
        Grid.TextMatrix(0, 10) = "Coupon"
        Grid.TextMatrix(0, 11) = "DayCount"
        Grid.TextMatrix(0, 12) = "Index"
        Grid.TextMatrix(0, 13) = "CashFlow"
        Grid.TextMatrix(0, 14) = "Tipo"
        Grid.TextMatrix(0, 15) = "MktCrScor"
        Grid.TextMatrix(0, 16) = "IRBRating"
        Grid.TextMatrix(0, 17) = "VTotal MM"
    End If
    If PropCols Then
        For i = 1 To Props.c.Count
            Grid.TextMatrix(0, i + cbase) = Props.c(i).nome
        Next i
    End If
    
    L = 0
    
    If Group Then
    
            For i = 1 To 11
                L = L + 1
                Set Obj(L) = Nothing
                Grid.AddItem Papeis.DisplayTypeName(i)
                If FinancCols Then
                    If AssetFilter Then b = Papeis.DisplayTypeAsset(i) Else b = Papeis.DisplayTypeTotal(i)
                    Grid.TextMatrix(L, 17) = Format(b / 1000000#, "##,##0.0")
                End If
                
                PintaLinha Grid, L, &H80FF80
                LineGroup(i) = L
                
                If ShowGroup(i) Then
                    Set h = Papeis.TypeCollection(i)
                    For Each x In h
                        If PodeMostrar(x) Then
                            L = L + 1
                            Set Obj(L) = x
                            PrintDetailLine x, L, FinancCols, cbase
                        End If 'PodeMostrar
                    Next x
                End If
                
            Next i 'Proximo grupo
            
    Else 'Não é para agrupar!
    
        For Each x In Papeis.c
            If PodeMostrar(x) Then
                L = L + 1
                Set Obj(L) = x
                PrintDetailLine x, L, FinancCols, cbase
            End If 'PodeMostrar
        Next x
    
    End If 'Group?
    
    Ajusta
    Me.MousePointer = vbDefault
End Sub


'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                           M   E   N   U   S
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Public Sub MENU_NEW()
    Papeis.HighLevelCria
End Sub

Public Sub MENU_CLONA()
    Dim x As CPapel
    If Grid.Row > 0 Then
        Set x = Obj(Grid.Row)
        Papeis.HighLevelCria x
    Else
        MsgBox ("Selecione um papel para clonar.")
    End If
End Sub

Public Sub MENU_EDITA()
    If Grid.Row > 0 Then
        If Not Obj(Grid.Row) Is Nothing Then FTitulo.showfor Obj(Grid.Row)
    End If
End Sub

Public Sub MENU_DELETE()
    'Deleta papel
    Dim f As CFundo, Go As Boolean, x As CPapel
    If Grid.Row > 0 Then
        If Not Obj(Grid.Row) Is Nothing Then
            Set x = Obj(Grid.Row)
            Go = True
            For Each f In Fundos.c
                If f.tempapel(x.ID) Then Go = False
            Next f
            If Go Then
                If MsgBox("Confirma exclusão do papel " + x.nome + " (" + x.ID + ")?", vbYesNo) = vbYes Then
                    Papeis.remove x.ID
                    FMain.Refaz
                End If
            Else
                MsgBox ("Papel existe em algum fundo. Impossível excluir.")
            End If 'Go
        End If 'is nothing
    End If 'Grid.Row>0
End Sub

Public Sub MENU_ALLOC()
    'Alocação
    If Grid.Row > 0 Then
        If Not Obj(Grid.Row) Is Nothing Then FAlloc.showfor Obj(Grid.Row)
    End If
End Sub

Public Sub MENU_HIST()
    'Histórico
    If Grid.Row > 0 Then
        If Not Obj(Grid.Row) Is Nothing Then FTituloHist.showfor Obj(Grid.Row)
    End If
End Sub

Public Sub MENU_CFLOW()
    'CashFlow
    If Grid.Row > 0 Then
        If Not Obj(Grid.Row) Is Nothing Then FCashFlow.showfor Obj(Grid.Row)
    End If
End Sub

Public Sub MENU_AKA()
    If Grid.Row > 0 Then
        If Not Obj(Grid.Row) Is Nothing Then FAka.showfor Obj(Grid.Row)
    End If
End Sub

Public Sub MENU_DELAKA()
    If Grid.Row > 0 Then
        If Not Obj(Grid.Row) Is Nothing Then FDelAka.showfor Obj(Grid.Row)
    End If
End Sub

Public Sub MENU_ISIN()
    If Grid.Row > 0 Then
        If Not Obj(Grid.Row) Is Nothing Then FBuscaISIN.showfor Obj(Grid.Row).ISIN
    End If
End Sub

Public Sub MENU_CRPR()
    If Grid.Row > 0 Then
        If Not Obj(Grid.Row) Is Nothing Then FCrpr.showfor Obj(Grid.Row)
    End If
End Sub


Private Function ProcuraRows(inicio As Integer, campo As Integer, x As String) As Integer
    Dim i As Integer, achou As Boolean, ky As String
    i = inicio
    ProcuraRows = 0
    achou = False
    While Not achou And i < Grid.Rows
        If Not Obj(i) Is Nothing Then
            Select Case campo
                Case 1
                    ky = Obj(i).ID
                Case 2
                    ky = Obj(i).ISIN
                Case 3
                    ky = Obj(i).CodCetip
            End Select
            If InStr(UCase(ky), UCase(x)) > 0 Then
                ProcuraRows = i
                achou = True
            End If
        End If
        If Not achou Then i = i + 1
    Wend
End Function


Private Sub Command1_Click()
    'Busca ID ou ISIN
    Dim achou As Boolean, i As Integer
    
    i = ProcuraRows(Grid.RowSel + 1, 1, Me.Text2)
    If i = 0 Then i = ProcuraRows(Grid.RowSel + 1, 2, Me.Text2)
    If i = 0 Then i = ProcuraRows(Grid.RowSel + 1, 3, Me.Text2)
    If i = 0 Then i = ProcuraRows(1, 1, Me.Text2)
    If i = 0 Then i = ProcuraRows(1, 2, Me.Text2)
    If i = 0 Then i = ProcuraRows(1, 3, Me.Text2)
    If i = 0 Then
        MsgBox ("Não encontrado")
    Else
        Grid.Row = i
        Grid.Col = 0
        Grid.ColSel = Grid.Cols - 1
        If Not Grid.RowIsVisible(Grid.Row) Then Grid.TopRow = max(1, Grid.Row - 3)
    End If
End Sub

'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                      R E S I Z E     E     A J U S T A
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Private Sub form_resize()
    Grid.Width = max(1, Me.Width - 250)
    Grid.Height = max(1, Me.Height - 650)
    Ajusta
End Sub


Private Sub Ajusta()
    Dim i As Integer
    c1 = Grid.Width * 0.25
    If c1 < 1500 Then c1 = 1500
    Grid.ColWidth(0) = c1
    
    c2 = (Grid.Width - c1) / (Grid.Cols - 1)
    If c2 < 700 Then c2 = 700
    For i = 1 To Grid.Cols - 1
        Grid.ColWidth(i) = c2
    Next i
End Sub


'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                       I N P U T     I N T E R F A C E
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Private Sub ToggleGroup(Optional WhatFor As String = "Toggle")
    '----Expande/ Colapsa/ Toggle uma linha de grupo
    Dim i As Integer, j As Integer, achou As Boolean
    If Grid.Row > 0 Then
        If Obj(Grid.Row) Is Nothing Then
            achou = False
            For i = 1 To 11
                If LineGroup(i) = Grid.Row Then
                    Select Case WhatFor
                        Case "Toggle"
                            ShowGroup(i) = Not (ShowGroup(i))
                        Case "Expand"
                            ShowGroup(i) = True
                        Case "Collapse"
                            ShowGroup(i) = False
                    End Select
                    achou = True
                End If
            Next i
            If achou Then newrefresh
        End If
    End If
End Sub


Private Sub Grid_dblClick()
    If Grid.Row > 0 Then
        If Not Obj(Grid.Row) Is Nothing Then
            FTitulo.showfor Obj(Grid.Row)
        Else
            ToggleGroup
        End If
    End If
End Sub

Private Sub Grid_MouseUp(button As Integer, Shift As Integer, x As Single, y As Single)
    If button = 2 Then PopUpMyMenu
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    Select Case keyascii
        Case 3
            CopyRangeToClipboard Grid
        Case 32, 13
            ToggleGroup
        Case 43
            ToggleGroup "Expand"
        Case 45
            ToggleGroup "Collapse"
    End Select
End Sub

Private Sub grid_keyup(keycode As Integer, Shift As Integer)
    If keycode = 93 Then PopUpMyMenu
End Sub

Private Sub PopUpMyMenu()
    Me.PopupMenu FMain.mnua_Papel
End Sub

Private Sub Text1_Change()
    If Filter Then newrefresh
End Sub

Private Sub TGGroup_Click()
    Group = TGGroup
    newrefresh
End Sub

Private Sub ToggleButton1_Click()
    Filter = ToggleButton1
    newrefresh
End Sub

Private Sub ToggleButton2_Click()
    PosicFilter = ToggleButton2
    newrefresh
End Sub

Private Sub ToggleButton3_Click()
    FinancCols = ToggleButton3
    newrefresh
End Sub

Private Sub ToggleButton4_Click()
    PropCols = ToggleButton4
    newrefresh
End Sub

Private Sub BCollapse_Click()
    For i = 1 To 11
        ShowGroup(i) = False
    Next i
    newrefresh
End Sub

Private Sub ToggleButton5_Click()
    AssetFilter = ToggleButton5
    newrefresh
End Sub

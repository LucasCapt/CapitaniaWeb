VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FFundo 
   Caption         =   "Fundo"
   ClientHeight    =   8865
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11490
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   8865
   ScaleWidth      =   11490
   Begin VB.CommandButton Command2 
      Caption         =   "DelCol"
      Height          =   375
      Left            =   8400
      TabIndex        =   4
      Top             =   0
      Width           =   735
   End
   Begin VB.CommandButton Command1 
      Caption         =   "AddCol"
      Height          =   375
      Left            =   7680
      TabIndex        =   3
      Top             =   0
      Width           =   735
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
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundo.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundo.frx":02F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundo.frx":05D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundo.frx":08D7
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundo.frx":0C62
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FFundo.frx":0FBD
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   4560
      TabIndex        =   2
      Text            =   "Combo1"
      Top             =   0
      Width           =   3135
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   4575
      _ExtentX        =   8070
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   5
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Carteira"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Aberta"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Regras"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab4 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Concentração"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab5 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Mov"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   8415
      Left            =   0
      TabIndex        =   0
      Top             =   360
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   14843
      _Version        =   393216
      BackColor       =   12648384
      AllowUserResizing=   1
   End
End
Attribute VB_Name = "FFundo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Obj As CFundo
Public clines As Collection

Private ColOrdena As Integer
Private ColDesc As Boolean


Public Sub FirstShow(x As CFundo)
    Dim p As CPropriedade
    Set Obj = x
    Me.Caption = Obj.nome
    Props.FillComboWithProps Combo1, True
    Combo1 = Props.c(1).nome
    ColOrdena = 2
    ColDesc = True
    newrefresh
    Show
End Sub


Public Sub newshow(x As CFundo)
    Set Obj = x
    If Obj Is Nothing Then
        Me.Caption = "???"
    Else
        Me.Caption = Obj.nome
        newrefresh
    End If
    Show
End Sub


Public Sub newrefresh()
    Dim i As Integer, b As CBook, r As CRegra, pp As CPropriedade, h As Collection, h1 As Collection, iprop As Integer
    Dim Tot1 As Double, Tot2 As Double, ppi As Integer, a1 As Double
    Dim xx As String, uu As CNomeValor
    Dim RR As CRuleResult
    Dim propIndexes(1000) As Integer
    'Dim Conc(1000) As Double, ConcPPValor(1000) As String, u As Double, us As String
    
    'determina o numero da propriedade
    iprop = Props.SearchIndexByName(Combo1)
    Set clines = New Collection
    
    For i = 1 To Config.FFundoColumnNames.Count
        propIndexes(i) = Props.SearchIndexByName(Config.FFundoColumnNames(i).nome)
    Next i
    
    Select Case TabStrip1.SelectedItem.Caption
        Case "Carteira", "Aberta"
            If TabStrip1.SelectedItem.Caption = "Carteira" Then Set h1 = Obj.MyPosics Else Set h1 = Obj.MyPosicConsol
            pl = Obj.PLTotal
            
            Grid.Cols = 1
            xx = FitString("|^" + Combo1, 27, "L") + OrdenaIdentifier(3)
            i = 0
            For Each uu In Config.FFundoColumnNames
                i = i + 1
                xx = xx + FitString("|^" + uu.nome, 27, "L") + OrdenaIdentifier(i + 3)
            Next uu
            Grid.FormatString = "Título                                               " + OrdenaIdentifier(0) + "|Valor                              " + OrdenaIdentifier(1) + "|Particip    " + OrdenaIdentifier(2) + xx
            Grid.Rows = 1
            
            tt = 0
            
            Set h = OrdenaPor(h1, ColOrdena, ColDesc)
            For i = 1 To h.Count
                Grid.AddItem (h(i).Papel.nome)
                clines.Add h(i).Papel
                a1 = h(i).Valor
                tt = tt + a1
                Grid.TextMatrix(i, 1) = Format(a1, "###,###,##0.00")
                If pl > 0 Then Grid.TextMatrix(i, 2) = Format(a1 / pl, "##0.00%") Else Grid.TextMatrix(i, 2) = "DIV/0"
                Grid.TextMatrix(i, 3) = h(i).Papel.PropV(iprop)
                For k = 1 To Config.FFundoColumnNames.Count
                    Grid.TextMatrix(i, 3 + k) = h(i).Papel.PropV(propIndexes(k))
                Next k
            Next i
            If Obj.MyPosics.Count > 0 Then
                Grid.AddItem "Diferença"
                Grid.TextMatrix(i, 1) = Format(pl - tt, "###,###,##0.00")
                If pl > 0 Then Grid.TextMatrix(i, 2) = Format(1 - tt / pl, "##0.00%") Else Grid.TextMatrix(i, 2) = "DIV/0"
                For k = 1 To Config.FFundoColumnNames.Count + 1
                    Grid.TextMatrix(i, 2 + k) = ""
                Next k
                
                Grid.AddItem "PL Total"
                Grid.TextMatrix(i + 1, 1) = Format(pl, "###,###,##0.00")
                Grid.TextMatrix(i + 1, 2) = Format(1, "##0.00%")
                For k = 1 To Config.FFundoColumnNames.Count + 1
                    Grid.TextMatrix(i, 2 + k) = ""
                Next k
            End If

        Case "Regras"
            Grid.Cols = 1
            Grid.FormatString = "Book                           |<Regra                                     |<Escopo            |Delta          |^Valor                |^Limite               |Compliance|<Papéis                                                                                                                                                 "
            Grid.Rows = 1
            L = 0
            For Each b In Obj.MyBooks
                For Each r In b.c
                    Set RR = Obj.ComputeRule(r)
                    clines.Add r
                    L = L + 1
                    Grid.AddItem (b.nome)
                    Grid.TextMatrix(L, 1) = r.nome
                    Grid.TextMatrix(L, 2) = r.Escopo
                    If RR.Compliant = "BREACH" Then Grid.TextMatrix(L, 3) = FNumkMM(RR.DeltaOut) Else Grid.TextMatrix(L, 3) = ""
                    Grid.TextMatrix(L, 4) = FormatLimit(RR.MaxOut, r)
                    If r.MaxMin = "MAX" And r.Limite = 0 _
                        Then Grid.TextMatrix(L, 5) = "proibido" _
                        Else Grid.TextMatrix(L, 5) = r.MaxMin + "  " + FormatLimit(r.Limite, r)
                    Grid.Row = L: Grid.Col = 6: Grid.CellPictureAlignment = 3
                    If r.Escopo = "CTRL" Then kk = 0 Else kk = 3
                    Select Case RR.Compliant
                        Case "OK"
                            Set Grid.CellPicture = Me.ImageList1.ListImages(1 + kk).Picture
                            Grid.TextMatrix(L, 7) = ""
                        Case "WARN"
                            Set Grid.CellPicture = Me.ImageList1.ListImages(2 + kk).Picture
                            Grid.TextMatrix(L, 7) = ClipNames(RR.PapelDescr, 100)
                        Case "BREACH"
                            Set Grid.CellPicture = Me.ImageList1.ListImages(3 + kk).Picture
                            Grid.TextMatrix(L, 7) = ClipNames(RR.PapelDescr, 100)
                    End Select
                Next r
            Next b
            
        Case "Concentração"
            Grid.Cols = 1
            Grid.FormatString = "Classe                                                    |Valor                   |Concentração        "
            Grid.Rows = 1
            
            Set h = Obj.MyConcentration(iprop)
            
            plt = Obj.PLTotal
            If plt = 0 Or Obj.Consol = "FULL" Then
                plt = 0
                For i = 1 To h.Count
                    plt = plt + h(i).Valor
                Next i
                If plt = 0 Then plt = 1
            End If
            L = 0
            Tot1 = 0
            Tot2 = 0

            'Ordena
            For i = 1 To h.Count - 1
                For j = i + 1 To h.Count
                    If h(j).Valor > h(i).Valor Then
                        u = h(i).nome
                        u1 = h(i).Valor
                        h(i).nome = h(j).nome
                        h(i).Valor = h(j).Valor
                        h(j).nome = u
                        h(j).Valor = u1
                    End If
                Next j
            Next i
           
           'Mostra
            For i = 1 To h.Count
                Grid.AddItem h(i).nome
                Grid.TextMatrix(i, 1) = Format(h(i).Valor, "###,###,##0")
                Grid.TextMatrix(i, 2) = Format(h(i).Valor / plt, "##0.00%")
                Tot1 = Tot1 + h(i).Valor
                Tot2 = Tot2 + h(i).Valor / plt
            Next i
            If Tot2 <> 1 Then
                Grid.AddItem ("(não classificados)")
                Grid.TextMatrix(i, 1) = Format(plt * (1 - Tot2), "###,###,##0")
                Grid.TextMatrix(i, 2) = Format(1 - Tot2, "##0.00%")
                i = i + 1
            End If
            
            Grid.AddItem ("(TOTAL)")
            Grid.TextMatrix(i, 1) = Format(plt, "###,###,##0")
            Grid.TextMatrix(i, 2) = Format(1, "##0.00%")
            
        Case "Mov"
            Set h = Obj.MyPosicConsol
            Grid.FormatString = "Título                                                   |Valor Carteira            |Valor Trade               |Valor Atual               |Quant Carteira            |Quant Trade               |Quant Atual               "
            Grid.Rows = 1
            For i = 1 To h.Count
                Grid.AddItem (h(i).Papel.nome)
                clines.Add h(i).Papel
                Grid.TextMatrix(i, 1) = Format(h(i).Valor0, "###,###,##0.00")
                Grid.TextMatrix(i, 2) = Format(h(i).ValorD, "###,###,##0.00")
                Grid.TextMatrix(i, 3) = Format(h(i).Valor, "###,###,##0.00")
                Grid.TextMatrix(i, 4) = Format(h(i).Quant0, "###,###,##0")
                Grid.TextMatrix(i, 5) = Format(h(i).QuantD, "###,###,##0")
                Grid.TextMatrix(i, 6) = Format(h(i).Quant, "###,###,##0")
            Next i
            
    End Select
End Sub


Private Sub Combo1_lostfocus()
    newrefresh
End Sub

Private Sub Command1_Click()
    'AddCol
    Dim achou As Boolean, u As CNomeValor
    prop2insert = Combo1
    achou = False
    For Each u In Config.FFundoColumnNames
        If u.nome = prop2insert Then achou = True
    Next u
    If Not achou Then
        Set u = New CNomeValor
        u.nome = prop2insert
        Config.FFundoColumnNames.Add u
    End If
    newrefresh
End Sub

Private Sub Command2_Click()
    'DelCol
    If (TabStrip1.SelectedItem.Caption = "Carteira" Or TabStrip1.SelectedItem.Caption = "Aberta") And Grid.Col > 3 Then
        If Config.DeleteFFundoCol(Grid.Col - 3) Then newrefresh
    End If
End Sub

Private Sub TabStrip1_Click()
    newrefresh
End Sub

Private Sub form_resize()
    If Me.Width > 50 Then Grid.Width = Me.Width - 50
    If Me.Height > 800 Then Grid.Height = Me.Height - 800
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub


Private Sub Grid_dblClick()
    Dim r As CRegra, pp As CPapel
    If Grid.MouseRow > 0 Then
        Select Case TabStrip1.SelectedItem.Caption
            Case "Regras"
                If Not clines(Grid.Row) Is Nothing Then FRegraFast.showfor clines(Grid.Row), Obj
            Case "Aberta", "Carteira", "Mov"
                If Grid.Row <= clines.Count Then
                    If Not clines(Grid.Row) Is Nothing Then FTitulo.showfor clines(Grid.Row)
                End If
        End Select
    Else
        'Ordena pela coluna
        If Grid.MouseCol = ColOrdena Then
            ColDesc = Not ColDesc
        Else
            ColOrdena = Grid.MouseCol
            ColDesc = False
        End If
        newrefresh
    End If
End Sub


Private Function OrdenaPor(x As Collection, Opor As Integer, EhDesc As Boolean) As Collection
    Dim a As New Collection, i As Integer, j As Integer, k As Integer, qual As Integer
    Dim idx(2000) As Integer
    
    For i = 1 To x.Count: idx(i) = i: Next i
    
    Select Case Opor
        Case 0
            qual = -1000
        Case 1, 2
            qual = -2000
        Case 3
            qual = Props.SearchIndexByName(Combo1)
        Case Else
            qual = Props.SearchIndexByName(Config.FFundoColumnNames(Opor - 3).nome)
    End Select
    
    If qual <> 0 Then
        For i = 1 To x.Count - 1
            For j = i + 1 To x.Count
                Select Case qual
                    Case -1000
                        troca = x(idx(j)).Papel.nome < x(idx(i)).Papel.nome
                    Case -2000
                        troca = x(idx(j)).Valor < x(idx(i)).Valor
                    Case -10
                        troca = x(idx(j)).Papel.Duration < x(idx(i)).Papel.Duration
                    Case -11
                        troca = x(idx(j)).Papel.adtv < x(idx(i)).Papel.adtv
                    Case Else
                        troca = x(idx(j)).Papel.PropV(qual) < x(idx(i)).Papel.PropV(qual)
                End Select
                If (troca And Not ColDesc) Or (Not troca And ColDesc) Then
                    k = idx(i)
                    idx(i) = idx(j)
                    idx(j) = k
                End If
            Next j
        Next i
    End If
    
    For i = 1 To x.Count
        Set u = x(idx(i))
        a.Add u
    Next i
    Set OrdenaPor = a
End Function


Private Function OrdenaIdentifier(N As Integer) As String
    If N = ColOrdena Then
        If ColDesc Then OrdenaIdentifier = "[-]" Else OrdenaIdentifier = "[+]"
    Else
        OrdenaIdentifier = "   "
    End If
End Function

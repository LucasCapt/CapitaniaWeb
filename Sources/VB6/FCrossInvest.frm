VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FCrossInvest 
   Caption         =   "Cross-Holdings (%)"
   ClientHeight    =   8100
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   13365
   LinkTopic       =   "Form1"
   MinButton       =   0   'False
   ScaleHeight     =   8100
   ScaleWidth      =   13365
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "FCrossInvest.frx":0000
      Left            =   0
      List            =   "FCrossInvest.frx":000D
      TabIndex        =   1
      Text            =   "Combo1"
      Top             =   0
      Width           =   3855
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   7695
      Left            =   360
      TabIndex        =   0
      Top             =   360
      Width           =   12975
      _ExtentX        =   22886
      _ExtentY        =   13573
      _Version        =   393216
      BackColor       =   12648447
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   7695
      Left            =   0
      TabIndex        =   2
      Top             =   360
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   13573
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
   Begin VB.Label Label1 
      Caption         =   "Linha = Investidor; Coluna = Investido"
      Height          =   375
      Left            =   3960
      TabIndex        =   3
      Top             =   0
      Width           =   2895
   End
End
Attribute VB_Name = "FCrossInvest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Colec As Collection

Public Sub NewShow()
    Grid.WordWrap = True
    Combo1 = "Valor (MM)"
    Me.Show
    NewRefresh
End Sub


Public Sub NewRefresh()
    Dim i As Integer, j As Integer
    Me.Caption = "Cross holdings (" + Me.Combo1 + ")"
    
    '----Prepara
        Set Colec = New Collection
        For Each f In Fundos.c
            If f.AtendeA(Me.TabStrip1.SelectedItem.Caption) Then Colec.Add f
        Next f
        
        Grid.Cols = Colec.Count + 1
        
        Grid.Rows = 1
        For i = 1 To Colec.Count
            Grid.AddItem Colec(i).nome
            Grid.TextMatrix(0, i) = Colec(i).nome
        Next i
        
        Grid.RowHeight(0) = 750
    
    '----Preenche
    For i = 1 To Colec.Count
        For j = 1 To Colec.Count
            a = 0
            For Each x In Colec(i).MyPosics
               If x.Papel.MyFundo Is Colec(j) Then a = a + x.Valor
            Next x
            
            printout = ""
            Select Case Me.Combo1
            
                Case "Valor (MM)"
                    If a <> 0 Then printout = Format(a / 1000000#, "##0")
                Case "% do investidor"
                
                    b = Colec(i).PLTotal
                    If a > 0 Then
                        If b > 0 Then
                            printout = Format(a / b, "##0%")
                        Else
                            printout = "?"
                        End If
                    End If
                    
                Case "% do investido"
                    b = Colec(j).PLTotal
                    If a > 0 Then
                        If b > 0 Then
                            printout = Format(a / b, "##0%")
                        Else
                            printout = "?"
                        End If
                    End If
                    
            End Select
            Grid.TextMatrix(i, j) = printout
        Next j
    Next i
    Ajusta
    Me.Refresh
End Sub

Private Sub Combo1_lostfocus()
   NewRefresh
End Sub

Private Sub form_resize()
    Grid.Width = max(1, Me.Width - 150)
    If Me.Height > 700 Then Grid.Height = Me.Height - 700
    Ajusta
End Sub

Private Sub Ajusta()
    Dim i As Integer
    c1 = Grid.Width * 0.15
    If c1 < 850 Then c1 = 850
    Grid.ColWidth(0) = c1
    
    c2 = (Grid.Width - c1 - 400) / (Grid.Cols - 1)
    If c2 < 500 Then c2 = 500
    For i = 1 To Grid.Cols - 1
        Grid.ColWidth(i) = c2
    Next i
End Sub

Private Sub TabStrip1_Click()
    NewRefresh
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FLiquidityPapel 
   Caption         =   "Liquidez Interna dos Títulos"
   ClientHeight    =   10725
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8805
   LinkTopic       =   "Form1"
   ScaleHeight     =   10725
   ScaleWidth      =   8805
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   3000
      TabIndex        =   2
      Text            =   "cri"
      Top             =   0
      Width           =   2055
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   2415
      _ExtentX        =   4260
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   3
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "CFLOW"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "ANBIMA"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Delta"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   10335
      Left            =   0
      TabIndex        =   0
      Top             =   360
      Width           =   8775
      _ExtentX        =   15478
      _ExtentY        =   18230
      _Version        =   393216
      BackColor       =   12648384
   End
   Begin MSForms.ToggleButton ToggleButton1 
      Height          =   375
      Left            =   5040
      TabIndex        =   4
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
   Begin MSForms.ToggleButton ToggleButton2 
      Height          =   375
      Left            =   5640
      TabIndex        =   3
      Top             =   0
      Width           =   975
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      DisplayStyle    =   6
      Size            =   "1720;661"
      Value           =   "0"
      Caption         =   "Investidos"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
End
Attribute VB_Name = "FLiquidityPapel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Filter As Boolean
Private PosicFilter As Boolean


Public Sub showfor()
    Dim f As CFundo, L As Integer, i As Integer
    Grid.FormatString = "Papel                                                                        |Class.Liq   |ADTV       |ADTV Class |ADTV Cond  |^1            |^5            |^21           |^42           |^63           |^126          |^252          "
    Filter = False
    ToggleButton2 = True 'Já muda posicfilter
    Me.Show
    newrefresh
End Sub

Public Sub newrefresh()
    Dim f As CPapel, L As Integer, i As Integer, a As Double
    Dias = Array(0, 1, 5, 21, 42, 63, 126, 252)
    L = 0
    Grid.Rows = 1
    For Each f In Papeis.c
        If (Not Filter Or InStr(UCase(f.nome), UCase(Text1))) And (Not PosicFilter Or f.PosicTotalV > 0) Then
            Grid.AddItem f.nome
            L = L + 1
            a1 = 0: b = 0
            Grid.TextMatrix(L, 1) = f.Class_Liq
            Grid.TextMatrix(L, 2) = FNumkMM(f.adtv)
            Grid.TextMatrix(L, 3) = FNumkMM(f.adtvClasse)
            Grid.TextMatrix(L, 4) = FNumkMM(f.adtvCond)
            
            For i = 1 To 7
                Select Case TabStrip1.SelectedItem.Caption
                    Case "CFLOW"
                        Grid.TextMatrix(L, i + 4) = Format(f.InternalLiquidityAteh(BaseDate + Dias(i) / 252 * 365, "CFLOW", 0), "##0.00")
                    Case "ANBIMA"
                        Grid.TextMatrix(L, i + 4) = Format(f.InternalLiquidityAteh(BaseDate + Dias(i) / 252 * 365, "ANBIMA", 0), "##0.00")
                    Case "Delta"
                        If i = 1 Then
                            a1 = f.InternalLiquidityAteh(BaseDate + Dias(i) / 252 * 365, "CFLOW", 0)
                            Grid.TextMatrix(L, i + 4) = Format(a1, "##0.00")
                        Else
                            b = f.InternalLiquidityAteh(BaseDate + Dias(i) / 252 * 365, "CFLOW", 0)
                            Grid.TextMatrix(L, i + 4) = Format((b - a1), "##0.00")
                            a1 = b
                        End If
                End Select
            Next i
        End If
    Next f
End Sub

Private Sub TabStrip1_Click()
    newrefresh
End Sub


Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub form_resize()
    Grid.Height = max(1, Me.Height - 750)
    Grid.Width = max(1, Me.Width - 250)
    'TabStrip1.Width = Grid.Width
End Sub


Private Sub Text1_Change()
    If Filter Then newrefresh
End Sub

Private Sub ToggleButton1_Click()
    Filter = Not (Filter)
    newrefresh
End Sub

Private Sub ToggleButton2_Click()
    PosicFilter = Not (PosicFilter)
    newrefresh
End Sub



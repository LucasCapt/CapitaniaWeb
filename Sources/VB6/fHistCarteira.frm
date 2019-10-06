VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form fHistCarteira 
   Caption         =   "Histórico de Carteira"
   ClientHeight    =   11250
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7935
   LinkTopic       =   "Form1"
   ScaleHeight     =   11250
   ScaleWidth      =   7935
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   4200
      TabIndex        =   3
      Text            =   "Combo1"
      Top             =   240
      Width           =   3615
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   480
      TabIndex        =   2
      Text            =   "Combo1"
      Top             =   240
      Width           =   3615
   End
   Begin MSComctlLib.TabStrip TabWho 
      Height          =   10575
      Left            =   0
      TabIndex        =   0
      Top             =   600
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   18653
      MultiRow        =   -1  'True
      Placement       =   2
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   2
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "30d"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "12m"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   10815
      Left            =   360
      TabIndex        =   1
      Top             =   600
      Width           =   7575
      _ExtentX        =   13361
      _ExtentY        =   19076
      _Version        =   393216
      BackColor       =   16777152
   End
   Begin VB.Label Label2 
      Caption         =   "Papel"
      Height          =   255
      Left            =   4200
      TabIndex        =   5
      Top             =   0
      Width           =   3615
   End
   Begin VB.Label Label1 
      Caption         =   "Fundo"
      Height          =   255
      Left            =   360
      TabIndex        =   4
      Top             =   0
      Width           =   3615
   End
End
Attribute VB_Name = "fHistCarteira"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Public Sub showfor()
    Fundos.FillComboListWithNomes Combo1
    Combo1.AddItem "==TODOS=="
    Papeis.FillComboWithNames Combo2
    Combo1 = Fundos.search(Config.ConcentrationFundID).nome
    newrefresh
End Sub


Public Sub newrefresh()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset
    Dim d As Date, L As Integer, dt As Date, ky As String
    Dim Fundo As CFundo
    
    
    Set Fundo = Fundos.searchName(Combo1)
        
    If Not Fundo Is Nothing Or Combo1 = "==TODOS==" Then
    
        
        Set db = OpenTheDatabase
        
        Grid.Rows = 1
        
        Select Case TabWho.SelectedItem.Caption
            Case "30d"
                d = BaseDate - 30
            Case "12m"
                d = BaseDate - 365
            Case "Tudo"
                d = LongTimeAgo
        End Select
        
            Grid.FormatString = "Data         |Fundo                                    |Papel                                      |Valor             "
            
            If Combo1 = "==TODOS==" Then u = "" Else u = "FUNDO=" + Str(Fundo.ID) + " AND"
            
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT DATA, SUM(VALOR) AS TVAL FROM QPOSICPAPEL WHERE " + _
                u + " NOME='" + Combo2 + "' AND DATA <=" + SQLBaseDate + " AND DATA>=#" + Format(d, "MM/DD/YYYY") + "# GROUP BY DATA ORDER BY DATA", db, adOpenForwardOnly, adLockReadOnly)
            
        
        If Not rs.EOF Then
            Grid.Visible = False
            rs.MoveFirst
            L = 0
            While Not rs.EOF
                Grid.AddItem Format(rs("DATA"), "dd-MMM-yy")
                L = L + 1
                Grid.TextMatrix(L, 1) = Combo1
                Grid.TextMatrix(L, 2) = Combo2
                Grid.TextMatrix(L, 3) = Format(rs("TVAL"), "###,###,##0")
                rs.MoveNext
            Wend
            Grid.Rows = L + 1
            Grid.Visible = True
        End If
        
    End If 'fundo is nothing
    Me.Show
End Sub


Private Sub Combo1_lostfocus()
    newrefresh
End Sub

Private Sub Combo2_Lostfocus()
    newrefresh
End Sub

Private Sub form_resize()
    If Me.Height > 750 And Me.Width > 100 Then
        Grid.Width = Me.Width - 450
        Grid.Height = Me.Height - 950
        TabWho.Height = Grid.Height
    End If
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub TabWho_Click()
    newrefresh
End Sub



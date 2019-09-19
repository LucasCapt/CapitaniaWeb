VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Begin VB.Form FPreTradeSimples 
   Caption         =   "Pré-Trade Compliance (Simples)"
   ClientHeight    =   5790
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11295
   LinkTopic       =   "Form1"
   ScaleHeight     =   5790
   ScaleWidth      =   11295
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   6375
      Left            =   -360
      TabIndex        =   0
      Top             =   960
      Width           =   10935
      _ExtentX        =   19288
      _ExtentY        =   11245
      _Version        =   393216
   End
End
Attribute VB_Name = "FPreTradeSimples"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Public Sub NewShow()
'    Grid.Rows = 4: Grid.Cols = 2
'    Grid.Row = 1: Grid.Col = 1: Set Grid.CellPicture = Me.ImageList1.ListImages(1).Picture
'    Grid.Row = 2: Grid.Col = 1: Set Grid.CellPicture = Me.ImageList1.ListImages(2).Picture
'    Grid.Row = 3: Grid.Col = 1: Set Grid.CellPicture = Me.ImageList1.ListImages(3).Picture
    Grid.FormatString = "Fundo                         |Regra                                  |Status        |Limite       |PL Sub D-1|Pl Sub D0 "
    Me.Show
End Sub


Public Sub NewRefresh()
    Dim f As CFundo, a As Collection, u As CNomeValor, u1 As CNomeValor, stt As Integer, L As Integer
    
    L = 0
    For Each f In Fundos.c
        If f.AtendeA(TabStrip1.SelectedItem.Caption) Then
            L = L + 1
            Grid.AddItem f.nome
            Set a = f.PreTradeCompl
            stt = 1
            For Each u In a
                stt = max(stt, u.Valor)
            Next u
            
            Grid.Row = L: Grid.Col = 2: Set Grid.CellPicture = Me.ImageList1.ListImages(stt).Picture
            
            If stt = 1 Then
                Grid.TextMatrix(L, 1) = "todas"
                Grid.TextMatrix(L, 3) = ""
                Grid.TextMatrix(L, 4) = ""
                Grid.TextMatrix(L, 5) = ""
            Else
                'Abre
                For Each u1 In a
                    Grid.AddItem f.nome
                    L = L + 1
                    Grid.TextMatrix(L, 1) = u1.nome
                    Grid.Row = L: Grid.Col = 2: Set Grid.CellPicture = Me.ImageList1.ListImages(Int(u1.Valor)).Picture
                    Grid.TextMatrix(L, 3) = ""
                    Grid.TextMatrix(L, 4) = ""
                    Grid.TextMatrix(L, 5) = ""
                Next u1
            End
        End If
    Next f
End Sub

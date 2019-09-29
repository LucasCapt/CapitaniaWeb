VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FCFPorPapel 
   Caption         =   "Cash Flow por Papel"
   ClientHeight    =   8160
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10095
   LinkTopic       =   "Form1"
   ScaleHeight     =   8160
   ScaleWidth      =   10095
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid grid 
      Height          =   8175
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   9975
      _ExtentX        =   17595
      _ExtentY        =   14420
      _Version        =   393216
      BackColor       =   16777152
   End
End
Attribute VB_Name = "FCFPorPapel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub newshow(qual As Integer)
    Dim db As ADODB.Connection, rs As ADODB.Recordset
    
    
    Set db = OpenTheDatabase
    
    Select Case qual
        Case 1
            Me.Caption = "Cash flow por papel"
            Grid.FormatString = "ID Fluxo               |Menor Data     |Maior Data      |^ID Papel            |Nome Papel                                                       "
            SelectOrder = "SELECT TFLUXOS.IDFLUXO, MIN(TFLUXOS.DATA) AS D1, MAX(TFLUXOS.DATA) AS D2, TPAPEL.ID, TPAPEL.NOME " + _
                "FROM TFLUXOS LEFT JOIN TPAPEL ON TFLUXOS.IDFLUXO = TPAPEL.CASHFLOW_ID " + _
                "GROUP BY TFLUXOS.IDFLUXO, TPAPEL.ID, TPAPEL.NOME"
        Case 2
            Me.Caption = "Propriedades por papel"
            Grid.FormatString = "ID Papel (prop)         |^ID Papel        |N propriedades|Nome Papel                                                      "
            SelectOrder = "SELECT TPAPELPROP.PAPEL, TPAPEL.ID, TPAPEL.NOME, COUNT(1) AS N " + _
                "FROM TPAPELPROP LEFT JOIN TPAPEL ON TPAPELPROP.PAPEL = TPAPEL.ID " + _
                "GROUP BY TPAPELPROP.PAPEL, TPAPEL.ID, TPAPEL.NOME"
                
        Case 3
            Me.Caption = "Posições por papel"
            Grid.FormatString = "ID Papel (posic)        |Menor Data    |Maior Data      |N posições  |^ID Papel        |Nome Papel                                                      "
            SelectOrder = "SELECT TPOSIC.PAPEL, TPAPEL.ID, COUNT(1) AS N, MIN(DATA) AS D1, MAX(DATA) AS D2, TPAPEL.NOME " + _
                "FROM TPOSIC LEFT JOIN TPAPEL ON TPOSIC.PAPEL=TPAPEL.ID " + _
                "GROUP BY TPOSIC.PAPEL, TPAPEL.ID, TPAPEL.NOME"
                
        Case 4
            Me.Caption = "Papel por posição"
            Grid.FormatString = "ID Papel (Papel)        |Menor Data    |Maior Data      |^ID Posição            |Nome Papel                                                       "
            SelectOrder = "SELECT TPAPEL.ID, MAX(TPOSIC.PAPEL) AS IDP, MIN(TPOSIC.DATA) AS D1, MAX(TPOSIC.DATA) AS D2, TPAPEL.NOME " + _
                "FROM TPAPEL LEFT JOIN TPOSIC ON TPOSIC.PAPEL=TPAPEL.ID " + _
                "GROUP BY TPAPEL.ID, TPAPEL.NOME"
                
    End Select
    
    Set rs = db.Execute(SelectOrder)
        
    
    Grid.Rows = 1
    L = 0
    
    While Not rs.EOF
        L = L + 1
        Select Case qual
            Case 1
                Grid.AddItem (rs("IDFLUXO"))
                Grid.TextMatrix(L, 1) = Format(rs("d1"), "dd-MMM-yy")
                Grid.TextMatrix(L, 2) = Format(rs("d2"), "dd-MMM-yy")
                If CritS(rs("id")) = "" Then
                    Grid.TextMatrix(L, 3) = "(órfão)"
                    Grid.TextMatrix(L, 4) = "(fuxo sem papel)"
                Else
                    Grid.TextMatrix(L, 3) = rs("id")
                    Grid.TextMatrix(L, 4) = rs("nome")
                End If
                
            Case 2
                Grid.AddItem (rs("PAPEL"))
                Grid.TextMatrix(L, 2) = Str(rs("N"))
                If CritS(rs("ID")) = "" Then
                    Grid.TextMatrix(L, 1) = "(órfão)"
                    Grid.TextMatrix(L, 3) = "(propriedade sem papel)"
                Else
                    Grid.TextMatrix(L, 1) = rs("id")
                    Grid.TextMatrix(L, 3) = rs("nome")
                End If
                
            Case 3
                Grid.AddItem (rs("PAPEL"))
                Grid.TextMatrix(L, 1) = Format(rs("d1"), "dd-MMM-yy")
                Grid.TextMatrix(L, 2) = Format(rs("d2"), "dd-MMM-yy")
                Grid.TextMatrix(L, 3) = Str(rs("N"))
                If CritS(rs("ID")) = "" Then
                    Grid.TextMatrix(L, 4) = "(órfão)"
                    Grid.TextMatrix(L, 5) = "(posição sem papel)"
                Else
                    Grid.TextMatrix(L, 4) = rs("id")
                    Grid.TextMatrix(L, 5) = rs("nome")
                End If
                
            Case 4
                Grid.AddItem (rs("ID"))
                Grid.TextMatrix(L, 4) = rs("nome")
                If CritS(rs("IDP")) = "" Then
                    Grid.TextMatrix(L, 1) = "(órfão)"
                    Grid.TextMatrix(L, 2) = "(órfão)"
                    Grid.TextMatrix(L, 3) = "(papel sem posição)"
                Else
                    Grid.TextMatrix(L, 1) = Format(rs("d1"), "dd-MMM-yy")
                    Grid.TextMatrix(L, 2) = Format(rs("d2"), "dd-MMM-yy")
                    Grid.TextMatrix(L, 3) = CritS(rs("IDP"))
                End If
                
                
        End Select
        
        rs.MoveNext
    Wend
    
    Me.Show
End Sub


Public Sub newrefresh()
End Sub


Public Sub form_resize()
    Grid.Width = max(1, Me.Width - 250)
    Grid.Height = max(1, Me.Height - 350)
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

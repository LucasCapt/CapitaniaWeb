VERSION 5.00
Object = "{65E121D4-0C60-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCHRT20.OCX"
Begin VB.Form FChart 
   Caption         =   "Gráfico"
   ClientHeight    =   9810
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   13875
   LinkTopic       =   "Form1"
   ScaleHeight     =   9810
   ScaleWidth      =   13875
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Combo5 
      Height          =   315
      ItemData        =   "FChart.frx":0000
      Left            =   12000
      List            =   "FChart.frx":000A
      TabIndex        =   9
      Text            =   "Combo1"
      Top             =   360
      Width           =   735
   End
   Begin VB.ComboBox Combo4 
      Height          =   315
      ItemData        =   "FChart.frx":0016
      Left            =   10200
      List            =   "FChart.frx":0023
      TabIndex        =   8
      Text            =   "Combo1"
      Top             =   360
      Width           =   1695
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Plotar"
      Height          =   375
      Left            =   12840
      TabIndex        =   7
      Top             =   360
      Width           =   855
   End
   Begin VB.ComboBox Combo3 
      Height          =   315
      Left            =   6840
      TabIndex        =   6
      Text            =   "Combo1"
      Top             =   360
      Width           =   3255
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   3120
      TabIndex        =   4
      Text            =   "Combo1"
      Top             =   360
      Width           =   3615
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   0
      TabIndex        =   2
      Text            =   "Combo1"
      Top             =   360
      Width           =   3015
   End
   Begin MSChart20Lib.MSChart MSChart1 
      Height          =   8895
      Left            =   0
      OleObjectBlob   =   "FChart.frx":0046
      TabIndex        =   0
      Top             =   840
      Width           =   13935
   End
   Begin VB.Label Label3 
      Caption         =   "Valor (filtro)"
      Height          =   255
      Left            =   6720
      TabIndex        =   5
      Top             =   120
      Width           =   2415
   End
   Begin VB.Label Label2 
      Caption         =   "Propriedade"
      Height          =   255
      Left            =   3120
      TabIndex        =   3
      Top             =   120
      Width           =   2895
   End
   Begin VB.Label Label1 
      Caption         =   "Fundo"
      Height          =   255
      Left            =   0
      TabIndex        =   1
      Top             =   120
      Width           =   3015
   End
End
Attribute VB_Name = "FChart"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private L_qual As String


Public Sub newshow(qual As String)
    Dim db As Database, rs As Recordset

    Label1.Visible = False: Label2.Visible = False: Label3.Visible = False
    Combo1.Visible = False: Combo2.Visible = False: Combo3.Visible = False: Combo4.Visible = False: Combo5.Visible = False
    
    L_qual = qual
    Select Case qual
        Case "COMP"
            MakeField1Padrao
            MakeField2Padrao
            MSChart1.chartType = VtChChartType2dPie
            Combo5.Visible = True: Combo5 = "$"
        Case "HCOMP"
            MakeField1Padrao
            MakeField2Padrao
            MakeField3Padrao
            MSChart1.chartType = VtChChartType2dArea
            MakeField4Padrao
            Combo5.Visible = True: Combo5 = "$"
        Case "HPOS"
            MakeField1Padrao
            MakeField4Padrao
            Label2.Visible = True: Combo2.Visible = True
            Label2 = "Papel"
            Papeis.FillComboWithNames Combo2
            Combo2 = Combo2.List(0)
            MSChart1.chartType = VtChChartType2dArea
            Combo5.Visible = True: Combo5 = "$"
        Case "PL"
            MakeField1Padrao
            MSChart1.chartType = VtChChartType2dArea
            MakeField4Padrao
        Case "TRADE"
            MakeField4Padrao
            Label1.Visible = True: Combo1.Visible = True
            Label1 = "Papel"
            
            Set db = OpenTheDatabase
            Set rs = db.OpenRecordset("SELECT DISTINCT ATIVO FROM TTRADES WHERE DATA>=#" + Format(BaseDate - 365, "MM/DD/YYYY") + "#")
            Combo1.Clear
            While Not rs.EOF
                Combo1.AddItem rs("ATIVO")
                rs.MoveNext
            Wend
            Combo1 = Combo1.List(0)
            db.Close
            MSChart1.chartType = VtChChartType2dXY
        Case "CFLOW"
            MakeField1Padrao
            MSChart1.chartType = VtChChartType2dBar
        Case "QUOTA"
            MakeField1Padrao
            MakeField4Padrao
            MSChart1.chartType = VtChChartType2dLine
        Case "RISCOCRD"
            MakeField1Padrao
            MakeField4Padrao
            MSChart1.chartType = VtChChartType2dLine
    End Select
    
    Me.Show
    newrefresh
End Sub

Private Sub MakeField1Padrao()
    Label1.Visible = True: Combo1.Visible = True
    Label1 = "Fundo"
    Fundos.FillComboListWithNomes Combo1
    Combo1 = Fundos.search(Config.ConcentrationFundID).nome
End Sub

Private Sub MakeField2Padrao()
    Label2.Visible = True: Combo2.Visible = True
    Props.FillComboWithProps Combo2, True
    Combo2 = Combo2.List(0)
End Sub

Private Sub MakeField3Padrao()
    Label3.Visible = True: Combo3.Visible = True
    Props.FillComboWithPropValues Combo2, Combo3
    Combo3 = Combo3.List(0)
End Sub

Private Sub MakeField4Padrao()
    Combo4.Visible = True
    Combo4.Clear
    Combo4.AddItem "30 dias": Combo4.AddItem "12 meses": Combo4.AddItem "5 anos": Combo4.AddItem "Tudo"
    Combo4 = "30 dias"
End Sub


Public Sub newrefresh()
    Dim f As CFundo, pp As CPapel, PR As CPropriedade, ppi As Integer
    Dim a As Collection, ds As String
    Dim db As Database, rs As Recordset, rs2 As Recordset, pp1 As CPropriedade
    
    MSChart1.Visible = False
    If L_qual <> "TRADE" Then Set f = Fundos.searchName(Me.Combo1)
    
    Select Case L_qual
        Case "COMP" '----------------------------------------------------< Composição atual (pizza) >
            ppi = Combo2PropertyPPI
            Set a = f.MyConcentration(ppi)
            MSChart1.ColumnCount = a.Count
            MSChart1.RowCount = 1
            MSChart1.Row = 1
            If a.Count > 0 Then
                For i = 1 To a.Count
                    MSChart1.Column = i
                    MSChart1.ColumnLabel = a(i).nome
                    MSChart1.Data = a(i).Valor / 1000000#
                Next i
                mm = 768 / a.Count
                If a.Count < 12 Then
                    mm = 64
                Else
                    mm = 768 / a.Count
                End If
                For i = 1 To MSChart1.Plot.SeriesCollection.Count
                    With MSChart1.Plot.SeriesCollection(i).DataPoints(-1)
                        .DataPointLabel.LocationType = VtChLabelLocationTypeOutside
                        If Combo5 = "%" Then
                            .DataPointLabel.Component = VtChLabelComponentPercent + VtChLabelComponentSeriesName
                            .DataPointLabel.PercentFormat = "  0%"
                        Else
                            .DataPointLabel.Component = VtChLabelComponentValue + VtChLabelComponentSeriesName
                            .DataPointLabel.ValueFormat = "  ##0"
                        End If
                        redgreen = max(1, i - 256 / mm) - 2 * max(0, i - 512 / mm)
                        Blue = min(i, 256 / mm) - max(0, i - 512 / mm)
                        .Brush.FillColor.Set redgreen * mm - 1, redgreen * mm - 1, Blue * mm - 1
                        If redgreen + Blue < 5 Then .EdgePen.VtColor.Set 255, 255, 255 Else .EdgePen.VtColor.Set 1, 1, 1
                    End With
                Next i
            End If
            
        Case "HCOMP" '----------------------------------------------------< Histórico de Concentração >
            ds = "#" + Format(DateField4, "MM/DD/YYYY") + "#"
            
            Set db = OpenTheDatabase
            AdjustXScale
            Select Case Combo2
                Case K_PropName1
                    Set rs = db.OpenRecordset("SELECT TPOSIC.FUNDO AS F1, TPAPEL.CLASS_LIQ AS P1, TPOSIC.DATA AS D1, SUM(TPOSIC.VALOR) AS V1 " + _
                      "FROM TPOSIC INNER JOIN TPAPEL ON (TPOSIC.PAPEL = TPAPEL.ID OR TPOSIC.PAPEL=CODCETIP and not TPAPEL.DELETED) WHERE TPAPEL.CLASS_LIQ='" + Combo3 + "' " + _
                      "AND TPOSIC.FUNDO=" + Str(f.ID) + " AND TPOSIC.DATA >=" + ds + " AND TPOSIC.DATA<=" + SQLBaseDate + " GROUP BY TPOSIC.FUNDO, TPAPEL.CLASS_LIQ, TPOSIC.DATA ORDER BY TPOSIC.DATA")
                Case K_PropName2
                    Set rs = db.OpenRecordset("SELECT TPOSIC.FUNDO AS F1, TPAPEL.CLASS_RENTAB AS P1, TPOSIC.DATA AS D1, SUM(TPOSIC.VALOR) AS V1 " + _
                      "FROM TPOSIC INNER JOIN TPAPEL ON (TPOSIC.PAPEL = TPAPEL.ID OR TPOSIC.PAPEL=CODCETIP and not TPAPEL.DELETED) WHERE TPAPEL.CLASS_RENTAB='" + Combo3 + "' " + _
                      "AND TPOSIC.FUNDO=" + Str(f.ID) + " AND TPOSIC.DATA >=" + ds + " AND TPOSIC.DATA<=" + SQLBaseDate + " GROUP BY TPOSIC.FUNDO, TPAPEL.CLASS_RENTAB, TPOSIC.DATA ORDER BY TPOSIC.DATA")
                Case K_PropName3
                      Set rs = db.OpenRecordset("SELECT TPOSIC.FUNDO AS F1, TPAPEL.INDEX AS P1, TPOSIC.DATA AS D1, SUM(TPOSIC.VALOR) AS V1 " + _
                      "FROM TPOSIC INNER JOIN TPAPEL ON (TPOSIC.PAPEL = TPAPEL.ID OR TPOSIC.PAPEL=CODCETIP and not TPAPEL.DELETED) WHERE TPAPEL.INDEX='" + Combo3 + "' " + _
                      "AND TPOSIC.FUNDO=" + Str(f.ID) + " AND TPOSIC.DATA >=" + ds + " AND TPOSIC.DATA<=" + SQLBaseDate + " GROUP BY TPOSIC.FUNDO, TPAPEL.INDEX, TPOSIC.DATA ORDER BY TPOSIC.DATA")
                Case K_PropName4
                      Set rs = db.OpenRecordset("SELECT TPOSIC.FUNDO AS F1, TPAPEL.INDEX AS P1, TPOSIC.DATA AS D1, SUM(TPOSIC.VALOR) AS V1 " + _
                      "FROM TPOSIC INNER JOIN TPAPEL ON (TPOSIC.PAPEL = TPAPEL.ID OR TPOSIC.PAPEL=CODCETIP and not TPAPEL.DELETED) WHERE TPAPEL.NOME='" + Combo3 + "' " + _
                      "AND TPOSIC.FUNDO=" + Str(f.ID) + " AND TPOSIC.DATA >=" + ds + " AND TPOSIC.DATA<=" + SQLBaseDate + " GROUP BY TPOSIC.FUNDO, TPAPEL.INDEX, TPOSIC.DATA ORDER BY TPOSIC.DATA")
                Case Else
                    'Qualquer propriedade
                    Set pp1 = Props.searchName(Combo2)
                    If Not pp1 Is Nothing Then
                        selcommand = "SELECT TPOSIC.FUNDO AS F1, QLASTPROPVALUES.VALOR AS P1, TPOSIC.DATA AS D1, SUM(TPOSIC.VALOR) AS V1 " + _
                        " FROM TPOSIC INNER JOIN QLASTPROPVALUES" + _
                        " ON TPOSIC.PAPEL = QLASTPROPVALUES.PAPEL" + _
                        " WHERE QLASTPROPVALUES.VALOR='" + Combo3 + "'" + _
                        " AND QLASTPROPVALUES.PROPRIEDADE=" + Str(pp1.ID) + _
                        " AND TPOSIC.FUNDO=" + Str(f.ID) + _
                        " AND TPOSIC.DATA >=" + ds + _
                        " AND TPOSIC.DATA<=" + SQLBaseDate + "" + _
                        " GROUP BY TPOSIC.FUNDO, QLASTPROPVALUES.VALOR, TPOSIC.DATA " + _
                        " ORDER BY TPOSIC.DATA"
                        
                        Set rs = db.OpenRecordset(selcommand)
                    End If
            End Select
            
            If Combo5 = "%" Then _
                Set rs2 = db.OpenRecordset("SELECT TPOSIC.DATA AS D1, TPOSIC.FUNDO AS F1, SUM(TPOSIC.VALOR) AS V1 " + _
                        "FROM TPOSIC WHERE TPOSIC.FUNDO=" + Str(f.ID) + " " + _
                        "AND TPOSIC.DATA >=" + ds + " AND TPOSIC.DATA<=" + SQLBaseDate + " GROUP BY TPOSIC.FUNDO, TPOSIC.DATA ORDER BY TPOSIC.DATA")
            
            CreateSingleLineChart rs, "D1", "V1", rs2, (Combo5 = "%")
            setYaxisTo
            
        Case "HPOS" '----------------------------------------------------< Histórico de Posição em Papel >
            ds = "#" + Format(DateField4, "MM/DD/YYYY") + "#"
            Set f = Fundos.searchName(Combo1)
            AdjustXScale
            If Not f Is Nothing Then
                
                Set db = OpenTheDatabase
                Set rs = db.OpenRecordset("SELECT TPOSIC.FUNDO AS F1, TPAPEL.NOME AS P1, TPOSIC.DATA AS D1, SUM(TPOSIC.VALOR) AS V1 " + _
                      "FROM TPOSIC INNER JOIN TPAPEL ON (TPOSIC.PAPEL = TPAPEL.ID or TPOSIC.PAPEL =TPAPEL.CODCETIP and not TPAPEL.DELETED) WHERE TPAPEL.NOME='" + Combo2 + "' " + _
                      "AND TPOSIC.FUNDO=" + Str(f.ID) + " AND TPOSIC.DATA >=" + ds + " AND TPOSIC.DATA<=" + SQLBaseDate + " GROUP BY TPOSIC.FUNDO, TPAPEL.NOME, TPOSIC.DATA ORDER BY TPOSIC.DATA")
                      
                If Combo5 = "%" Then _
                    Set rs2 = db.OpenRecordset("SELECT TPOSIC.DATA AS D1, TPOSIC.FUNDO AS F1, SUM(TPOSIC.VALOR) AS V1 " + _
                        "FROM TPOSIC WHERE TPOSIC.FUNDO=" + Str(f.ID) + " " + _
                        "AND TPOSIC.DATA >=" + ds + " AND TPOSIC.DATA<=" + SQLBaseDate + " GROUP BY TPOSIC.FUNDO, TPOSIC.DATA ORDER BY TPOSIC.DATA")
                    
                CreateSingleLineChart rs, "D1", "V1", rs2, (Combo5 = "%")
                setYaxisTo
                
            End If
            
        Case "PL"   '----------------------------------------------------< PL >
            ds = "#" + Format(DateField4, "MM/DD/YYYY") + "#"
            AdjustXScale
            
            Set db = OpenTheDatabase
            Set rs = db.OpenRecordset("SELECT DATA, FUNDO, SUM(VALOR) AS VALOR1 FROM TPOSIC WHERE DATA >=" + ds + " AND DATA<=" + SQLBaseDate + " AND FUNDO =" + Str(f.ID) + " GROUP BY FUNDO, DATA ORDER BY DATA")
            CreateSingleLineChart rs, "DATA", "VALOR1"
            db.Close
            
        Case "TRADE" '----------------------------------------------------< TRADES (x,y)  >
            ds = "#" + Format(DateField4, "MM/DD/YYYY") + "#"
            
            Set db = OpenTheDatabase
            Set rs = db.OpenRecordset("SELECT DATA, ATIVO, PU FROM TTRADES WHERE DATA >=" + ds + " AND DATA<=" + SQLBaseDate + " AND ATIVO ='" + Combo1 + "' ORDER BY DATA")
            If Not rs.EOF Then
                MSChart1.RowCount = rs.RecordCount
                MSChart1.ColumnCount = 2
                i = 0
                While Not rs.EOF
                    i = i + 1
                    MSChart1.Row = i
                    MSChart1.Column = 1
                    MSChart1.Data = CDbl(rs("DATA"))
                    MSChart1.Column = 2
                    MSChart1.Data = rs("PU")
                    rs.MoveNext
                Wend
            End If
            MSChart1.Plot.Axis(VtChAxisIdX).ValueScale.Maximum = CDbl(BaseDate)
            MSChart1.Plot.Axis(VtChAxisIdX).ValueScale.Minimum = CDbl(BaseDate - DateField4)
            AdjustXScale
            For Each x In MSChart1.Plot.Axis(VtChAxisIdX).Labels
                x.Format = "dd-mmm-yy"
            Next x
            MSChart1.Plot.SeriesCollection(1).DataPoints(-1).Marker.Visible = True
            MSChart1.Plot.SeriesCollection(1).ShowLine = False
            db.Close
        Case "CFLOW"
        
        Case "QUOTA"
            AdjustXScale
            ds = "#" + Format(DateField4, "MM/DD/YYYY") + "#"
            
            Set db = OpenTheDatabase
            Set rs = db.OpenRecordset("SELECT DATA, FUNDO, QUOTA FROM TQUOTAS WHERE DATA >=" + ds + " AND DATA<=" + SQLBaseDate + " AND FUNDO =" + Str(f.ID) + " ORDER BY DATA")
            CreateSingleLineChart rs, "DATA", "QUOTA"
            
        Case "RISCOCRD"
            AdjustXScale
            ds = "#" + Format(DateField4, "MM/DD/YYYY") + "#"
            
            Set db = OpenTheDatabase
            Set rs = db.OpenRecordset("SELECT DATAINFO, FUNDO, CRD_EL1 FROM THISTRISK WHERE DATAINFO >=" + ds + " AND DATAINFO<=" + SQLBaseDate + " AND FUNDO ='" + f.nome + "' ORDER BY DATAINFO")
            CreateSingleLineChart rs, "DATAINFO", "CRD_EL1"
            
    End Select
    MSChart1.Visible = True
    Me.Refresh
End Sub


Private Sub AdjustXScale()
    MSChart1.Plot.Axis(VtChAxisIdX).ValueScale.Auto = False
    MSChart1.Plot.Axis(VtChAxisIdX).CategoryScale.Auto = False
    MSChart1.Plot.Axis(VtChAxisIdX).CategoryScale.LabelTick = True
   Select Case Combo4
        Case "30 dias"
            MSChart1.Plot.Axis(VtChAxisIdX).CategoryScale.DivisionsPerTick = 1
            MSChart1.Plot.Axis(VtChAxisIdX).CategoryScale.DivisionsPerLabel = 1
        Case "12 meses"
            MSChart1.Plot.Axis(VtChAxisIdX).CategoryScale.DivisionsPerTick = 21
            MSChart1.Plot.Axis(VtChAxisIdX).CategoryScale.DivisionsPerLabel = 21
        Case "5 anos"
            MSChart1.Plot.Axis(VtChAxisIdX).CategoryScale.DivisionsPerTick = 63
            MSChart1.Plot.Axis(VtChAxisIdX).CategoryScale.DivisionsPerLabel = 63
        Case Else
            MSChart1.Plot.Axis(VtChAxisIdX).CategoryScale.DivisionsPerTick = 252
            MSChart1.Plot.Axis(VtChAxisIdX).CategoryScale.DivisionsPerLabel = 252
    End Select
End Sub

Private Function setYaxisTo()
    Dim x As Object
    If Combo5 = "%" Then fmt = "##0.0%" Else fmt = "###,###,##0"
    For Each x In MSChart1.Plot.Axis(VtChAxisIdY).Labels
        x.Format = fmt
    Next x
    For Each x In MSChart1.Plot.Axis(VtChAxisIdY2).Labels
        x.Format = fmt
    Next x
End Function

Private Function DateField4() As Date
    Select Case Combo4
        Case "30 dias"
            DateField4 = BaseDate - 30
        Case "12 meses"
            DateField4 = DateSerial(Year(BaseDate) - 1, Month(BaseDate), Day(BaseDate))
        Case "5 anos"
            DateField4 = DateSerial(Year(BaseDate) - 5, Month(BaseDate), Day(BaseDate))
        Case "Tudo"
            DateField4 = LongTimeAgo
    End Select
End Function

Private Function Combo2PropertyPPI() As Integer
    Dim p As CPropriedade
    Select Case Combo2
        Case K_PropName1
            Combo2PropertyPPI = -1
        Case K_PropName2
            Combo2PropertyPPI = -2
        Case K_PropName3
            Combo2PropertyPPI = -3
        Case K_PropName4
            Combo2PropertyPPI = -4
        Case Else
            Set p = Props.searchName(Combo2)
            If Not p Is Nothing Then Combo2PropertyPPI = Props.SearchIndex(p.ID)
    End Select
End Function

Private Sub CreateSingleLineChart(rs As Recordset, XField As String, Yfield As String, Optional rs2 As Recordset, Optional EhPercent As Boolean = False)
    If Not rs Is Nothing And Not (rs2 Is Nothing And EhPercent) Then
        If Not rs.EOF Then
            MSChart1.RowCount = rs.RecordCount
            MSChart1.ColumnCount = 1
            i = 0
            While Not rs.EOF
                i = i + 1
                MSChart1.Row = i
                MSChart1.RowLabel = rs(XField)
                
                If EhPercent Then
                    rs2.MoveFirst
                    rs2.FindFirst ("D1>=#" + Format(rs(XField), "MM/DD/YYYY") + "#")
                    pl = rs2("V1")
                    If pl = 0 Then pl = 100000000#
                    MSChart1.Data = rs(Yfield) / pl
                ElseIf L_qual = "QUOTA" Or L_qual = "RISCOCRD" Then
                    MSChart1.Data = CritNN(rs(Yfield))
                Else
                    MSChart1.Data = CritNN(rs(Yfield)) / 1000000#
                End If
                rs.MoveNext
            Wend
            MSChart1.Plot.SeriesCollection(1).DataPoints(-1).Brush.FillColor.Set 0, 0, 200
            MSChart1.Visible = True
        Else
            MSChart1.RowCount = 0
        End If
    End If
End Sub


Private Sub Combo2_Lostfocus()
    If L_qual = "HCOMP" Then MakeField3Padrao
End Sub


Private Sub Command1_Click()
    newrefresh
End Sub

Private Sub form_resize()
    MSChart1.Height = Me.Height - 1350
    MSChart1.Width = Me.Width - 200
End Sub

VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRiskParms 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Parâmetros de Risco de Mercado"
   ClientHeight    =   3390
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4365
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3390
   ScaleWidth      =   4365
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   2655
      Left            =   0
      TabIndex        =   0
      Top             =   720
      Width           =   4335
      _ExtentX        =   7646
      _ExtentY        =   4683
      _Version        =   393216
      BackColor       =   16777152
   End
   Begin VB.Label Label2 
      Caption         =   "Última Data"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   360
      Width           =   4215
   End
   Begin VB.Label Label1 
      Caption         =   "EWMA"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   0
      Width           =   4335
   End
End
Attribute VB_Name = "FRiskParms"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub newshow()
    Label1 = "EWMA Lambda = " + Format(RiskMgr.Lambda, "#0.000")
    Label2 = "Última Data = " + Format(RiskMgr.LastDate, "dd-MMM-yy")

    Grid.Rows = 10
    Grid.FormatString = "Fator de Risco                      |^Vol anual    |^Stress 1m    "
    
    Grid.TextMatrix(1, 0) = "IPCA 2Y"
    Grid.TextMatrix(1, 1) = Format(RiskMgr.VolIPCA2Y * 1589, "##0") + " bp"
    Grid.TextMatrix(1, 2) = Format(RiskMgr.StressIPCA2Y * 100, "##0.0") + " bp"
    
    Grid.TextMatrix(2, 0) = "IPCA 5Y"
    Grid.TextMatrix(2, 1) = Format(RiskMgr.VolIPCA5Y * 1589, "##0") + " bp"
    Grid.TextMatrix(2, 2) = Format(RiskMgr.StressIPCA5Y * 100, "##0") + " bp"
    
    Grid.TextMatrix(3, 0) = "IPCA 10Y"
    Grid.TextMatrix(3, 1) = Format(RiskMgr.VolIPCA10Y * 1589, "##0") + " bp"
    Grid.TextMatrix(3, 2) = Format(RiskMgr.StressIPCA10Y * 100, "##0") + " bp"
    
    Grid.TextMatrix(4, 0) = "IMA-B"
    Grid.TextMatrix(4, 1) = Format(RiskMgr.VolIMAB5 * 15.89, "##0.0%")
    Grid.TextMatrix(4, 2) = Format(RiskMgr.StressIMAB5, "##0.0%")
    
    Grid.TextMatrix(5, 0) = "IFIX"
    Grid.TextMatrix(5, 1) = Format(RiskMgr.VolIFIX * 15.89, "##0.0%")
    Grid.TextMatrix(5, 2) = Format(RiskMgr.StressIFIX, "##0.0%")
    
    Grid.TextMatrix(6, 0) = "PRE 2Y"
    Grid.TextMatrix(6, 1) = Format(RiskMgr.VolPRE2Y * 1589, "##0") + "bp"
    Grid.TextMatrix(6, 2) = Format(RiskMgr.StressPRE2Y * 100, "##0") + "bp"
    
    Grid.TextMatrix(7, 0) = "PRE 5Y"
    Grid.TextMatrix(7, 1) = Format(RiskMgr.VolPRE5Y * 1589, "##0") + "bp"
    Grid.TextMatrix(7, 2) = Format(RiskMgr.StressPRE5Y * 100, "##0") + "bp"
    
    Grid.TextMatrix(8, 0) = "DOLAR"
    Grid.TextMatrix(8, 1) = Format(RiskMgr.VolDolar * 15.89, "##0.0%")
    Grid.TextMatrix(8, 2) = Format(RiskMgr.StressDolar, "##0.0%")
    
    Grid.TextMatrix(9, 0) = "IDA"
    Grid.TextMatrix(9, 1) = Format(RiskMgr.VolIDA * 15.89, "##0.0%")
    Grid.TextMatrix(9, 2) = Format(RiskMgr.StressIDA, "##0.0%")
    
    Me.Show
End Sub


Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub


Public Sub newrefresh()
End Sub

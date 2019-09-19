VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.MDIForm FMain 
   BackColor       =   &H8000000C&
   Caption         =   "CAPITÂNIA ENQUADRAMENTO"
   ClientHeight    =   9675
   ClientLeft      =   225
   ClientTop       =   855
   ClientWidth     =   12960
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   3  'Windows Default
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   0
      Top             =   9300
      Width           =   12960
      _ExtentX        =   22860
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   7
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Alignment       =   1
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Alignment       =   1
            Bevel           =   0
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Alignment       =   1
            Bevel           =   0
            Object.Width           =   529
            MinWidth        =   529
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Alignment       =   1
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Alignment       =   1
         EndProperty
         BeginProperty Panel6 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   882
            MinWidth        =   882
         EndProperty
         BeginProperty Panel7 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   12360
      Top             =   8520
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
            Picture         =   "FMain.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FMain.frx":02F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FMain.frx":05D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FMain.frx":08D7
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FMain.frx":0C29
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FMain.frx":0FB2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FMain.frx":133D
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FMain.frx":1698
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FMain.frx":1A36
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FMain.frx":1D64
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Menu mnuHome 
      Caption         =   "Home"
      Begin VB.Menu mnuArr 
         Caption         =   "Arranja"
      End
      Begin VB.Menu mnutrac3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuReimp 
         Caption         =   "Reimporta carteira TXT"
      End
      Begin VB.Menu mnuImportXML 
         Caption         =   "Reimporta carteira XML"
      End
      Begin VB.Menu mnuImportAll 
         Caption         =   "Reimporta tudo"
      End
      Begin VB.Menu mnuRecalcula 
         Caption         =   "Recalcula"
      End
      Begin VB.Menu MNUTT5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuMudaData 
         Caption         =   "Muda Data"
      End
      Begin VB.Menu trc4 
         Caption         =   "-"
      End
      Begin VB.Menu mnuConfig 
         Caption         =   "Configuração"
      End
      Begin VB.Menu mnut5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuReportTela 
         Caption         =   "Report na Tela"
         Begin VB.Menu mnuReportScr 
            Caption         =   "Controle"
         End
         Begin VB.Menu mnuRepGTela 
            Caption         =   "Gerencial"
         End
         Begin VB.Menu mnuRepETela 
            Caption         =   "Erros"
         End
         Begin VB.Menu mnuRepPTTela 
            Caption         =   "Pre-Trade Compliance"
         End
      End
      Begin VB.Menu mnu_email 
         Caption         =   "Envia e-mail"
         Begin VB.Menu mnu_emailRC 
            Caption         =   "Para Risco & Compliance"
            Begin VB.Menu mnuMailRC 
               Caption         =   "Controle"
            End
            Begin VB.Menu mnuMailRCG 
               Caption         =   "Gerencial"
            End
         End
         Begin VB.Menu mnu_emailLista 
            Caption         =   "Para Lista"
            Begin VB.Menu mnuMailAll 
               Caption         =   "Controle"
            End
            Begin VB.Menu mnuMailAllG 
               Caption         =   "Gerencial"
            End
         End
      End
   End
   Begin VB.Menu mnuT1 
      Caption         =   "Títulos"
      Begin VB.Menu mnuTit 
         Caption         =   "Cadastro de Títulos"
         Shortcut        =   {F5}
      End
      Begin VB.Menu mnuProp 
         Caption         =   "Propriedades"
      End
      Begin VB.Menu mnuAKA 
         Caption         =   "Lista de Alias"
      End
      Begin VB.Menu mnuTitProv 
         Caption         =   "Filtro de Provisão"
      End
      Begin VB.Menu mnutrc1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAlloc 
         Caption         =   "Rel. Alocação"
      End
      Begin VB.Menu mnutrc11 
         Caption         =   "-"
      End
      Begin VB.Menu mnuPapelTemplate 
         Caption         =   "Importa Template"
      End
   End
   Begin VB.Menu mnuFundos 
      Caption         =   "Fundos"
      Begin VB.Menu mnuFundosCad 
         Caption         =   "Cadastro de Fundos"
         Shortcut        =   {F6}
      End
      Begin VB.Menu mnuFundoMerc 
         Caption         =   "Risco de Mercado"
      End
      Begin VB.Menu mnuFundoLiq 
         Caption         =   "Liquidez"
      End
      Begin VB.Menu mnuXHold 
         Caption         =   "Cross-holdings"
      End
      Begin VB.Menu mnufundoLim 
         Caption         =   "Limites"
      End
   End
   Begin VB.Menu mnutrades 
      Caption         =   "Trades"
      Begin VB.Menu mnuTradeView 
         Caption         =   "Blotter"
         Shortcut        =   {F7}
      End
      Begin VB.Menu mnuTradeReimp 
         Caption         =   "Reimporta trades"
      End
      Begin VB.Menu mnuTradeComp 
         Caption         =   "Pre-Trade compliance"
      End
   End
   Begin VB.Menu mnuRg 
      Caption         =   "Compliance"
      Begin VB.Menu mnuRegr 
         Caption         =   "Regras"
      End
      Begin VB.Menu mnuBooks 
         Caption         =   "Livros"
      End
      Begin VB.Menu MNNNT 
         Caption         =   "-"
      End
      Begin VB.Menu mnuPreTradeComp 
         Caption         =   "Pré-Trade Compliance"
      End
      Begin VB.Menu trc101 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCompHist 
         Caption         =   "Histórico"
      End
      Begin VB.Menu mnuCompBreach 
         Caption         =   "Breaches"
      End
      Begin VB.Menu mnuCompCases 
         Caption         =   "Cases"
      End
   End
   Begin VB.Menu mnut2 
      Caption         =   "Simulação"
      Begin VB.Menu mnuSimulOn 
         Caption         =   "Simula"
      End
      Begin VB.Menu mnuSimul 
         Caption         =   "Simula C/V"
      End
      Begin VB.Menu mnuSimLiq2 
         Caption         =   "Simula Liquidez"
      End
      Begin VB.Menu mnuRSt 
         Caption         =   "Restaura"
      End
   End
   Begin VB.Menu mnuRisk 
      Caption         =   "Risco"
      Begin VB.Menu mnuMktr 
         Caption         =   "Risco de Mercado - Fundos"
      End
      Begin VB.Menu mnuMktriskOpen 
         Caption         =   "Risco de Mercado - Carteira"
      End
      Begin VB.Menu mnuParms 
         Caption         =   "Parâmetros de Mercado"
      End
      Begin VB.Menu mnuStressCart 
         Caption         =   "Stress Test - Carteira"
      End
      Begin VB.Menu mnuBacktest 
         Caption         =   "Backtest"
      End
      Begin VB.Menu mnuANBIMA 
         Caption         =   "DDQ ANBIMA"
      End
      Begin VB.Menu mnut4 
         Caption         =   "-"
      End
      Begin VB.Menu mnuStressCen 
         Caption         =   "Cenários de Stress"
      End
      Begin VB.Menu mnuRStress 
         Caption         =   "Relat.Stress"
      End
      Begin VB.Menu trc5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFCreditRisk 
         Caption         =   "Risco de Credito - Carteira"
      End
      Begin VB.Menu mnuIRB2 
         Caption         =   "Risco de Crédito - Internal"
      End
      Begin VB.Menu mnuIRBReport 
         Caption         =   "IRB Credit Scoring"
      End
      Begin VB.Menu mnuRisk_NomeCrd 
         Caption         =   "Nomes de Crédito"
      End
   End
   Begin VB.Menu mnuLiq1 
      Caption         =   "Liquidez"
      Begin VB.Menu mnuLiqFundos 
         Caption         =   "Fundos"
      End
      Begin VB.Menu mnuLiqDetail 
         Caption         =   "Sumário por Fundo"
      End
      Begin VB.Menu mnuLiqMo 
         Caption         =   "Sumário Mensal por Fundo"
      End
      Begin VB.Menu mnuLiqDetDet 
         Caption         =   "Detalhado ANBIMA por Fundo"
      End
      Begin VB.Menu mnuLiqDetConst 
         Caption         =   "Detalhado CONSTR por Fundo"
      End
      Begin VB.Menu mnuLiqDetCFlow 
         Caption         =   "Detalhado CFLOW por Fundo"
      End
      Begin VB.Menu mnuLiqDetADTV 
         Caption         =   "Detalhado ADTV por Fundo"
      End
      Begin VB.Menu mnuLiqTit 
         Caption         =   "Detalhado por Título"
      End
      Begin VB.Menu mnucashReport 
         Caption         =   "Cash Report"
      End
      Begin VB.Menu mLiqStress 
         Caption         =   "Stress"
      End
      Begin VB.Menu mnutracl 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSimulLiq 
         Caption         =   "Simula Liquidez"
      End
   End
   Begin VB.Menu mnuOps 
      Caption         =   "Operacional"
      Begin VB.Menu mnuAloc 
         Caption         =   "Alocação de Ordens"
      End
   End
   Begin VB.Menu mnuAML1 
      Caption         =   "AML"
      Begin VB.Menu mnuCompAML 
         Caption         =   "Compliance de AML"
      End
      Begin VB.Menu mnuAMLTrades 
         Caption         =   "Trades"
      End
      Begin VB.Menu mnuAMLCtpt 
         Caption         =   "Contrapartes"
      End
      Begin VB.Menu mnuAMLCadCtpt 
         Caption         =   "Cadastro Ctpt"
      End
   End
   Begin VB.Menu mnuHist 
      Caption         =   "Históricos"
      Begin VB.Menu mnuh1 
         Caption         =   "Risco & Compliance"
         Begin VB.Menu mnuHPL 
            Caption         =   "PL dos fundos"
         End
         Begin VB.Menu mnuHComp 
            Caption         =   "Compliance"
         End
         Begin VB.Menu mnuHistBreaches 
            Caption         =   "Breaches"
         End
         Begin VB.Menu mnuHRisk 
            Caption         =   "Risco de Mercado"
         End
         Begin VB.Menu mnuHConc 
            Caption         =   "Concentração"
         End
         Begin VB.Menu mnuHLiq 
            Caption         =   "Risco de Liquidez"
         End
         Begin VB.Menu mnuhSLiq 
            Caption         =   "Stress de Liquidez"
         End
         Begin VB.Menu mnuHCashReport 
            Caption         =   "Cash Report"
         End
         Begin VB.Menu mnuAML 
            Caption         =   "AML"
         End
         Begin VB.Menu mnuHistAloc 
            Caption         =   "Alocação de Ordens"
         End
      End
      Begin VB.Menu mnuhh2 
         Caption         =   "Inputs"
         Begin VB.Menu mnuHResg 
            Caption         =   "Resgates"
         End
         Begin VB.Menu mnuTrans 
            Caption         =   "Transferências"
         End
         Begin VB.Menu mnuCot 
            Caption         =   "Maiores Cotistas"
         End
      End
      Begin VB.Menu mnuhh3 
         Caption         =   "Dados de Mercado"
         Begin VB.Menu mnuHSeries 
            Caption         =   "Séries de Mercado"
         End
         Begin VB.Menu mnuHistADTV 
            Caption         =   "ADTV"
         End
         Begin VB.Menu mnuScore 
            Caption         =   "Credit Score"
         End
         Begin VB.Menu mnuHistQuotas 
            Caption         =   "Quotas"
         End
      End
      Begin VB.Menu mnuhhh4 
         Caption         =   "Carteira & Trades"
         Begin VB.Menu mnuListCarteira 
            Caption         =   "Carteira"
         End
         Begin VB.Menu mnuHTrades 
            Caption         =   "Trades"
         End
         Begin VB.Menu mnuHistSource 
            Caption         =   "Fonte das Posições"
         End
      End
   End
   Begin VB.Menu mnuG 
      Caption         =   "Gráficos"
      Begin VB.Menu mnuGComp 
         Caption         =   "Composição"
      End
      Begin VB.Menu mnuGCompH 
         Caption         =   "Hist. Classes"
      End
      Begin VB.Menu mnuGPosH 
         Caption         =   "Hist. Posição"
      End
      Begin VB.Menu mnuGPL 
         Caption         =   "Hist. PL"
      End
      Begin VB.Menu mnuGTrades 
         Caption         =   "Trades"
      End
      Begin VB.Menu mnuGCF 
         Caption         =   "Cash Flow"
      End
      Begin VB.Menu mnuChartQuota 
         Caption         =   "Quota"
      End
      Begin VB.Menu mnuChartEL 
         Caption         =   "Risco de Crédito (EL)"
      End
   End
   Begin VB.Menu mnumanu 
      Caption         =   "Manutenção"
      Begin VB.Menu mnuErros 
         Caption         =   "Erros"
      End
      Begin VB.Menu tt2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuatual 
         Caption         =   "Data das Atualizações"
      End
      Begin VB.Menu mnuCFlowPp 
         Caption         =   "Cashflows--> Papel"
      End
      Begin VB.Menu mnuPropPp 
         Caption         =   "Propriedades --> Papel"
      End
      Begin VB.Menu mnuPosicPp 
         Caption         =   "Posições --> Papel"
      End
      Begin VB.Menu mnuppposic 
         Caption         =   "Papel --> Posição"
      End
      Begin VB.Menu mnuHistSource2 
         Caption         =   "Fonte das Posições"
      End
      Begin VB.Menu mnuBuscaIsin 
         Caption         =   "Busca ISIN"
      End
      Begin VB.Menu mnuPerformance 
         Caption         =   "Reporte de Performance"
      End
      Begin VB.Menu mnut44 
         Caption         =   "-"
      End
      Begin VB.Menu mnuReimpTrades60 
         Caption         =   "Reimportar trades D-60"
      End
      Begin VB.Menu MNUTT 
         Caption         =   "-"
      End
      Begin VB.Menu mnucritp 
         Caption         =   "Critica Posição"
      End
      Begin VB.Menu mnuReplicPosic 
         Caption         =   "Replica Posição"
      End
      Begin VB.Menu mnuPurgePp 
         Caption         =   "Limpar base de títulos"
      End
      Begin VB.Menu mnuManID 
         Caption         =   "Mudar ID de Título"
      End
      Begin VB.Menu mnutrc33 
         Caption         =   "-"
      End
      Begin VB.Menu mnuRotSpec 
         Caption         =   "Macro"
      End
   End
   Begin VB.Menu mnua_Fundo 
      Caption         =   "MNU_FUNDO"
      Visible         =   0   'False
      Begin VB.Menu mnua_Fundo_Novo 
         Caption         =   "Novo"
      End
      Begin VB.Menu mnua_Fundo_Edita 
         Caption         =   "Edita"
      End
      Begin VB.Menu mnua_Fundo_Exclui 
         Caption         =   "Exclui"
      End
      Begin VB.Menu mnua_Fundo_t1 
         Caption         =   "-"
      End
      Begin VB.Menu mnua_Fundo_Liquidez 
         Caption         =   "Liquidez"
      End
   End
   Begin VB.Menu mnua_Papel 
      Caption         =   "MNU_PAPEL"
      Visible         =   0   'False
      Begin VB.Menu mnua_Papel_Novo 
         Caption         =   "Novo"
      End
      Begin VB.Menu mnua_Papel_Clona 
         Caption         =   "Clona"
      End
      Begin VB.Menu mnua_Papel_Edita 
         Caption         =   "Edita"
      End
      Begin VB.Menu mnua_Papel_Exclui 
         Caption         =   "Exclui"
      End
      Begin VB.Menu mnua_Papel_t1 
         Caption         =   "-"
      End
      Begin VB.Menu mnua_Papel_Alloc 
         Caption         =   "Alocação"
      End
      Begin VB.Menu mnua_Papel_Hist 
         Caption         =   "Histórico"
      End
      Begin VB.Menu mnua_Papel_Cflow 
         Caption         =   "Cash flow"
      End
      Begin VB.Menu mnua_Papel_Alias 
         Caption         =   "Cria Alias"
      End
      Begin VB.Menu mnua_Papel_DelAlias 
         Caption         =   "Destroi Alias"
      End
      Begin VB.Menu mnua_Papel_ISIN 
         Caption         =   "ISIN"
      End
      Begin VB.Menu MNUTT3 
         Caption         =   "-"
      End
      Begin VB.Menu mnua_Papel_Crpr 
         Caption         =   "Credit Profile"
      End
   End
   Begin VB.Menu mnua_Regra 
      Caption         =   "MNU_REGRA"
      Visible         =   0   'False
      Begin VB.Menu mnua_Regra_Novo 
         Caption         =   "Nova"
      End
      Begin VB.Menu mnua_Regra_Edita 
         Caption         =   "Edita"
      End
      Begin VB.Menu mnua_Regra_Exlcui 
         Caption         =   "Exclui"
      End
      Begin VB.Menu mnua_Regra_Clona 
         Caption         =   "Clona"
      End
      Begin VB.Menu mnua_Regra_T1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuRulIncluiLivro 
         Caption         =   "Inlcui em Livro"
      End
      Begin VB.Menu mnua_Regra_NewBook 
         Caption         =   "Novo Livro"
      End
   End
   Begin VB.Menu mnua_Prop 
      Caption         =   "MNU_PROP"
      Visible         =   0   'False
      Begin VB.Menu mnua_Prop_Novo 
         Caption         =   "Nova"
      End
      Begin VB.Menu mnua_Prop_Edita 
         Caption         =   "Edita"
      End
      Begin VB.Menu mnua_Prop_Exclui 
         Caption         =   "Exclui"
      End
   End
   Begin VB.Menu mnua_Book 
      Caption         =   "MNU_BOOK"
      Visible         =   0   'False
      Begin VB.Menu mnua_Book_Novo 
         Caption         =   "Novo"
      End
      Begin VB.Menu mnua_Book_Edita 
         Caption         =   "Edita"
      End
      Begin VB.Menu mnua_Book_Exclui 
         Caption         =   "Exclui"
      End
   End
   Begin VB.Menu mnu_Prov 
      Caption         =   "MNU_PROV"
      Visible         =   0   'False
      Begin VB.Menu mnu_ProvNova 
         Caption         =   "Nova"
      End
      Begin VB.Menu mnu_ProvEdita 
         Caption         =   "Edita"
      End
      Begin VB.Menu mnu_ProvExclui 
         Caption         =   "Exclui"
      End
   End
   Begin VB.Menu mnu_crdname 
      Caption         =   "MNU_CRDNAME"
      Visible         =   0   'False
      Begin VB.Menu mnu_crdname_Novo 
         Caption         =   "Novo"
      End
      Begin VB.Menu mnu_crdname_edit 
         Caption         =   "Edita"
      End
      Begin VB.Menu mnu_crdname_delete 
         Caption         =   "Exclui"
      End
   End
End
Attribute VB_Name = "FMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub MDIForm_QueryUnload(cancel As Integer, unloadmode As Integer)
    If EhBatch Then
        cancel = False
    Else
        If MsgBox("Deseja realmente terminar?", vbYesNo + vbInformation) = vbYes Then
            cancel = False
            WriteLog ("LOGOUT")
        Else
            cancel = True
        End If
    End If
End Sub

Private Sub mLiqStress_Click()
    FLiqStress.showfor
End Sub

Private Sub mnuAKA_Click()
    FAKAList.newshow
End Sub

Private Sub mnuAlloc_Click()
    FAlloc.showfor
End Sub

Private Sub mnuAloc_Click()
    FHistoricos.showfor ("ALLOC")
End Sub

Private Sub mnuAML_Click()
    FHistoricos.showfor ("AML")
End Sub

Private Sub mnuAMLCtpt_Click()
    FHistoricos.showfor ("CTPT")
End Sub

Private Sub mnuAMLTrades_Click()
    FHistoricos.showfor ("AML")
End Sub

Private Sub mnuANBIMA_Click()
    FAnbima.newshow
End Sub

Private Sub mnuArr_Click()
    Me.Arrange (1)
End Sub

Private Sub mnuAtual_Click()
    FAtualizacs.newshow
End Sub

Private Sub mnuBacktest_Click()
    FBacktest.newshow
End Sub

Private Sub mnuBooks_Click()
    FBooks.newshow
    FBooks.ZOrder (0)
End Sub

Private Sub mnuBuscaIsin_Click()
    FBuscaISIN.showfor
End Sub

Private Sub mnucashReport_Click()
    FCashReport.newshow
End Sub

Private Sub mnuCFlowPp_Click()
    FCFPorPapel.newshow 1
End Sub

Private Sub mnuCompAML_Click()
    FHistoricos.showfor ("AML")
End Sub

Private Sub mnuCompBreach_Click()
    FHistoricos.showfor ("BREACH")
End Sub

Private Sub mnuCompCases_Click()
    FHistoricos.showfor ("CASE")
End Sub

Private Sub mnuCompHist_Click()
    FHistoricos.showfor ("COMPL")
End Sub

Private Sub mnuErros_Click()
    FHistoricos.showfor ("ERRO")
End Sub

Private Sub mnuHistQuotas_Click()
    FHistoricos.showfor ("QUOTAS")
End Sub

Private Sub mnuConfig_Click()
    FConfig.newshow
End Sub

Private Sub mnuCot_Click()
    FHistoricos.showfor ("MAIORCOT")
End Sub

Private Sub mnucritp_Click()
    Importer.CriticaPosicaoParaData BaseDate
End Sub

Private Sub mnuFCreditRisk_Click()
    FCreditRisk.newshow ("CREDITO")
End Sub

Private Sub mnuImportAll_Click()
    If User.Imports = 0 Then
        MsgBox ("Importação fora das permissões do usuário")
    Else
        FStart.Show
        FStart.Say "Reimportando tudo"
        Importer.ImportaTudo 2, True, False, FStart
        If MainStatus = "LIVE" Then
            ResetAll FStart
            FStart.Hide
            FMain.Refaz
        Else
            FStart.Hide
            ExitSimulation
        End If
    End If
End Sub

Private Sub mnuLiqDetADTV_Click()
    FCreditRisk.newshow ("LIQA")
End Sub

Private Sub mnuLiqDetCFlow_Click()
    FCreditRisk.newshow ("LIQF")
End Sub

Private Sub mnuLiqDetConst_Click()
    FCreditRisk.newshow ("LIQC")
End Sub

Private Sub mnuLiqDetDet_Click()
   FCreditRisk.newshow ("LIQ")
End Sub

Private Sub mnuPerformance_Click()
    FHistoricos.showfor ("SYSTEMPERFORMANCE")
End Sub

Private Sub mnuProvFilter_Click()
    FProvFilter.newshow
End Sub

Private Sub mnuPurgePp_Click()
    F_s_Purge.newshow
End Sub

Private Sub mnuRecalcula_Click()
    FStart.newshow ("Recalculando")
    ResetAll FStart
    FMain.Refaz
    FStart.Hide
End Sub

Private Sub mnuReplicPosic_Click()
    FReplicaPos.newshow
End Sub

Private Sub mnuRisk_NomeCrd_Click()
    FCrdNames.newshow
End Sub

Private Sub mnuStressCart_Click()
    FCreditRisk.newshow ("STRESS")
End Sub

Private Sub mnuIRB2_Click()
    FCreditRisk.newshow ("IRB")
End Sub

Private Sub mnufundoLim_Click()
    FFundLimits.newshow
End Sub

Private Sub mnuFundoLiq_Click()
    FLiquidity.showfor
End Sub

Private Sub mnuFundoMerc_Click()
    FMktRisk.newshow
End Sub

Private Sub mnuFundosCad_Click()
    FFundos.newshow
    FFundos.ZOrder (0)
End Sub

'-------------------------------------------------------------------------------------------------------------------------
' MENU CHART
'-------------------------------------------------------------------------------------------------------------------------
Private Sub mnuGCF_Click()
    FChart.newshow ("CFLOW")
End Sub

Private Sub mnuGComp_Click()
    FChart.newshow ("COMP")
End Sub

Private Sub mnuGCompH_Click()
    FChart.newshow ("HCOMP")
End Sub

Private Sub mnuGPL_Click()
    FChart.newshow ("PL")
End Sub

Private Sub mnuGPosH_Click()
    FChart.newshow ("HPOS")
End Sub

Private Sub mnuGTrades_Click()
    FChart.newshow ("TRADE")
End Sub

Private Sub mnuChartQuota_Click()
    FChart.newshow ("QUOTA")
End Sub

Private Sub mnuChartEL_Click()
    FChart.newshow ("RISCOCRD")
End Sub
'-----------------------------------------------------------------------------------------------------------------------

Private Sub mnuHCashReport_Click()
    FHistoricos.showfor ("CASHR")
End Sub

Private Sub mnuHComp_Click()
    FHistoricos.showfor ("COMPL")
End Sub

Private Sub mnuHConc_Click()
    FHistoricos.showfor ("CONCENTRA")
End Sub

Private Sub mnuHistADTV_Click()
    FHistoricos.showfor ("ADTV")
End Sub

Private Sub mnuHistAloc_Click()
    FHistoricos.showfor ("ALLOC")
End Sub

Private Sub mnuHistBreaches_Click()
    FHistoricos.showfor ("BREACH")
End Sub

Private Sub mnuHistSource_Click()
    FHistoricos.showfor ("POSSOURCE")
End Sub

Private Sub mnuHistSource2_Click()
    FHistoricos.showfor ("POSSOURCE")
End Sub

Private Sub mnuHLiq_Click()
    FHistoricos.showfor ("LIQ")
End Sub

Private Sub mnuHSLiq_Click()
    FHistoricos.showfor ("LIQSTRESS")
End Sub

Private Sub mnuHPL_Click()
    FHistoricos.showfor ("PL")
End Sub

Private Sub mnuHResg_Click()
    FHistoricos.showfor ("REDEMP")
End Sub

Private Sub mnuHRisk_Click()
    FHistoricos.showfor ("RISK")
End Sub

Private Sub mnuHSeries_Click()
    FHistoricos.showfor ("SERIES")
End Sub

Private Sub mnuHTrades_Click()
    FHistoricos.showfor ("TRADES")
End Sub

Private Sub mnuIRBReport_Click()
    FCreditScore.newshow
End Sub

Private Sub mnuRepGTela_Click()
    FReport.newshow ("GER")
End Sub

Private Sub mnuRepETela_click()
    FReport.newshow ("ERR")
End Sub

Private Sub mnuRepPTTela_Click()
    FReport.newshow ("PTC")
End Sub

Private Sub mnuScore_Click()
    FHistoricos.showfor ("SCORE")
End Sub

Private Sub mnuImportXML_Click()
    FStart.Show
    FStart.Say "Reimportando posições XML ANBIMA"
    Importer.ImportaXMLANBIMAparaData BaseDate, True
    Importer.Layt22MainParaData BaseDate
    If MainStatus = "LIVE" Then
        ResetAll FStart
        FStart.Hide
        FMain.Refaz
    Else
        FStart.Hide
        ExitSimulation
    End If
End Sub


Private Sub mnuLiqDetail_Click()
    If FFundos.Visible And FFundos.Grid.Row > 0 Then
        FLiquidityDetailed.showfor (FFundos.Grid.TextMatrix(FFundos.Grid.Row, 0))
    ElseIf Fundos.c.Count > 0 Then
        FLiquidityDetailed.showfor (Fundos.c(1).nome)
    End If
End Sub

Private Sub mnuLiqMo_Click()
    If FFundos.Visible And FFundos.Grid.Row > 0 Then
        FLiquidityDetailMo.showfor (FFundos.Grid.TextMatrix(FFundos.Grid.Row, 0))
    ElseIf Fundos.c.Count > 0 Then
        FLiquidityDetailMo.showfor (Fundos.c(1).nome)
    End If
End Sub


Private Sub mnuLiqFundos_Click()
    FLiquidity.showfor
End Sub

Private Sub mnuLiqTit_Click()
    FLiquidityPapel.showfor
End Sub

Private Sub mnuListCarteira_Click()
    fHistCarteira.showfor
End Sub

Private Sub mnuMailAll_Click()
    Dim m As String
    m = Messenger.Message
    Emailer.SendList m, "A", "RiskPointer"
End Sub

Private Sub mnuMailAllG_Click()
    Dim m As String
    m = Messenger.MessageGerencial
    Emailer.SendList m, "B", "RiskGerencial"
End Sub

Private Sub mnuMailRC_Click()
    Dim m As String
    m = Messenger.Message
    Emailer.SendForRC m, "RiskPointer"
End Sub

Private Sub mnuMailRCG_Click()
    Dim m As String
    m = Messenger.MessageGerencial
    Emailer.SendForRC m, "RiskGerencial"
End Sub

Private Sub mnuMktR_Click()
    FMktRisk.newshow
End Sub

Private Sub mnuMktriskOpen_Click()
    FCreditRisk.newshow ("MERCADO")
End Sub

Private Sub mnuMudaData_Click()
    Dim d As Date
    d = FInputData.showfor(BaseDate, True)
    If d <> BaseDate Then
        If TestaTrocaData(d) Then Refaz
    End If
End Sub

Private Sub mnuPapelTemplate_Click()
    FTemplateTitulo.newshow
End Sub

Private Sub mnuParms_Click()
    FRiskParms.newshow
End Sub

Private Sub mnuPosicPp_Click()
     FCFPorPapel.newshow 3
End Sub

Private Sub mnuppposic_Click()
    FCFPorPapel.newshow 4
End Sub

Private Sub mnuPreTradeComp_Click()
    'Pre-Trade Compliance detalhado
    FazPreTradeCompliance
End Sub


Private Sub mnuProp_Click()
    FProps.newshow
    FProps.ZOrder (0)
End Sub

Private Sub mnuPropPp_Click()
    FCFPorPapel.newshow 2
End Sub

Private Sub mnuRegr_Click()
    FRegras.newshow
    FRegras.ZOrder (0)
End Sub

Private Sub mnuReimp_Click()
    FStart.Show
    FStart.Say "Reimportando posições"
    Importer.ImportaPosicaoParaData BaseDate, True
    If MainStatus = "LIVE" Then
        ResetAll FStart
        FStart.Hide
        FMain.Refaz
    Else
        FStart.Hide
        ExitSimulation
    End If
End Sub

Private Sub mnuReimpTrades60_Click()
    FStart.Show
    Importer.ImportaTrades 2, FStart, Now() - 60
    FStart.Hide
End Sub

Private Sub mnuManID_Click()
    F_s_ChgID.newshow
End Sub

Private Sub mnuReportScr_Click()
    FReport.newshow
End Sub

Private Sub mnuRotSpec_Click()
    MMain.exceptional
End Sub

Private Sub mnuRst_Click()
    'restaura
    ExitSimulation
End Sub

Private Sub mnuRStress_Click()
    FStressResult.showfor
End Sub

Private Sub mnuSimLiq2_Click()
    FStressLiq.newshow
End Sub

Private Sub mnuSimul_Click()
    Fsimula.newshow
End Sub

Private Sub mnusimul2_Click()
    Fsimula.newshow
End Sub

Private Sub mnuSimulLiq_Click()
    FStressLiq.newshow
End Sub

Private Sub mnuSimulOn_Click()
    'Inicia Simulação
    EnterSimulation
End Sub

Private Sub mnuTitProv_Click()
    FProvFilter.newshow
End Sub

Private Sub mnuTradeComp_Click()
    FazPreTradeCompliance
End Sub

Private Sub mnuTradeReimp_Click()
    FStart.newshow "Importando trades"
    Importer.ImportaTrades 3, FStart
    MMain.ResetAll FStart
    FStart.Hide
End Sub

Private Sub mnuTradeView_Click()
    FTrades.newshow
End Sub

Private Sub mnuTrans_Click()
    FHistoricos.showfor ("TRANSFERS")
End Sub

Private Sub mnuStressCen_Click()
    FStress.showfor
End Sub

Private Sub mnuTit_Click()
    Fpapel.newshow
    Fpapel.WindowState = 2
    Fpapel.ZOrder (0)
End Sub


Public Sub FazPreTradeCompliance()
    WriteLog ("PRETRADE COMPLIANCE")
    FStart.newshow ("Executando pré-trade compliance")
    Fundos.PreTradeCompliance False, FStart
    FStart.newshow ("Reportando pré-trade compliance")
    ComReporter.Report_PreTrade
    FStart.Hide
    FPreTradeCompliance.newshow
End Sub


'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                                  I   N   T   E   R   F   A   C   E
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Public Sub Refaz()
    Dim f As CFundo, fm As Form
    Me.MousePointer = vbHourglass
    For Each fm In Forms
        If fm.Visible Then
            Select Case fm.Name
                Case "FMain"
                Case "FFundo"
                    'Pega o mesmo NOME do Obj (mas pode não ser o mesmo objeto!)
                    Set f = Fundos.searchName(FFundo.Obj.nome)
                    If f Is Nothing Then Set f = Fundos.c(1)
                    fm.newshow f
                Case Else
                    fm.newrefresh
            End Select
        End If
    Next fm
    FazStatusBar
    Me.MousePointer = vbDefault
    'FMain.ZOrder (0)
End Sub

Public Function GetVisibleForm(x As String) As Form
    Dim f1 As Form
    For Each f1 In Forms
        If f1.Name = x And f1.Visible Then Set GetVisibleForm = f1
    Next f1
End Function

Private Sub MDIForm_Unload(cancel As Integer)
    Termina
End Sub


Public Sub FazStatusBar()
    Dim fli As Date
    
    StatusBar1.Panels(1) = Format(BaseDate, "dd-MMM-yy")
    fli = Fundos.Dt_LastInfo
    StatusBar1.Panels(2) = Format(fli, "dd-MMM-yy")
    If fli > BaseDate - 3 Then
        StatusBar1.Panels(3).Picture = ImageList1.ListImages(10).Picture
    ElseIf fli > BaseDate - 7 Then
        StatusBar1.Panels(3).Picture = ImageList1.ListImages(9).Picture
    Else
        StatusBar1.Panels(3).Picture = ImageList1.ListImages(5).Picture
    End If
    If MainStatus <> "LIVE" Then StatusBar1.Panels(4) = MainStatus Else StatusBar1.Panels(4) = ""
    StatusBar1.Panels(5) = User.username
    StatusBar1.Panels(6) = NumErrors
    StatusBar1.Panels(7) = "t:" + Str(Papeis.c.Count) + " f:" + Str(Fundos.c.Count) + " r:" + Str(Regras.c.Count)
End Sub

Private Sub mnuXHold_Click()
    'Cross-Holdings
    FCrossInvest.newshow
End Sub


'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
'                           M E N U S    D O S    S U B F O R M S
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

'---------------------------------------------------------------------------------< MENU PAPEL >
Private Sub mnua_Papel_Novo_Click()
    If Fpapel.Visible Then Fpapel.MENU_NEW
End Sub

Private Sub mnua_Papel_Clona_Click()
    If Fpapel.Visible Then Fpapel.MENU_CLONA
End Sub

Private Sub mnua_Papel_Edita_Click()
    If Fpapel.Visible Then Fpapel.MENU_EDITA
End Sub

Private Sub mnua_Papel_Exclui_Click()
    If Fpapel.Visible Then Fpapel.MENU_DELETE
End Sub

Private Sub mnua_Papel_Alias_Click()
    If Fpapel.Visible Then Fpapel.MENU_AKA
End Sub

Private Sub mnua_Papel_DelAlias_Click()
    If Fpapel.Visible Then Fpapel.MENU_DELAKA
End Sub

Private Sub mnua_Papel_Alloc_Click()
    If Fpapel.Visible Then Fpapel.MENU_ALLOC
End Sub

Private Sub mnua_Papel_Cflow_Click()
    If Fpapel.Visible Then Fpapel.MENU_CFLOW
End Sub

Private Sub mnua_Papel_Hist_Click()
    If Fpapel.Visible Then Fpapel.MENU_HIST
End Sub

Private Sub mnua_Papel_ISIN_Click()
    If Fpapel.Visible Then Fpapel.MENU_ISIN
End Sub

Private Sub mnua_Papel_Crpr_Click()
    If Fpapel.Visible Then Fpapel.MENU_CRPR
End Sub


'---------------------------------------------------------------------------------< MENU FUNDOS >
Private Sub mnua_Fundo_Edita_Click()
    If FFundos.Visible Then FFundos.MENU_EDITA
End Sub

Private Sub mnua_Fundo_Exclui_Click()
    If FFundos.Visible Then FFundos.MENU_EXCLUI
End Sub

Private Sub mnua_Fundo_Liquidez_Click()
    If FFundos.Visible Then FFundos.MENU_LIQUIDITY
End Sub

Private Sub mnua_Fundo_Novo_Click()
    If FFundos.Visible Then FFundos.MENU_CRIA
End Sub


'---------------------------------------------------------------------------------< MENU REGRAS >
Private Sub mnua_Regra_Edita_Click()
    If FRegras.Visible Then FRegras.MENU_EDITA
End Sub

Private Sub mnua_Regra_Exlcui_Click()
    If FRegras.Visible Then FRegras.MENU_EXCLUI
End Sub

Private Sub mnua_Regra_Clona_Click()
    If FRegras.Visible Then FRegras.MENU_CLONA
End Sub

Private Sub mnua_Regra_NewBook_Click()
    If FRegras.Visible Then FRegras.MENU_NOVOBOOK
End Sub

Private Sub mnua_Regra_Novo_Click()
    If FRegras.Visible Then FRegras.MENU_NOVO
End Sub

Private Sub mnuRulIncluiLivro_Click()
    If FRegras.Visible Then FRegras.MENU_INCLUIEMLIVRO
End Sub



'---------------------------------------------------------------------------------< MENU PROPERTIES >
Private Sub mnua_Prop_Edita_Click()
    If FProps.Visible Then FProps.MENU_EDITA
End Sub

Private Sub mnua_Prop_Exclui_Click()
    If FProps.Visible Then FProps.MENU_EXCLUI
End Sub

Private Sub mnua_Prop_Novo_Click()
    If FProps.Visible Then FProps.MENU_NOVO
End Sub


'---------------------------------------------------------------------------------< MENU BOOKS >
Private Sub mnua_Book_Edita_Click()
    If FBooks.Visible Then FBooks.MENU_EDIT
End Sub

Private Sub mnua_Book_Exclui_Click()
    If FBooks.Visible Then FBooks.MENU_EXCLUI
End Sub

Private Sub mnua_Book_Novo_Click()
    If FBooks.Visible Then FBooks.MENU_NOVO
End Sub

Private Sub StatusBar1_PanelClick(ByVal Panel As MSComctlLib.Panel)
    Select Case Panel.Index
        Case 1
            mnuMudaData_Click
        Case 6
            FHistoricos.showfor ("ERRO")
    End Select
End Sub


'---------------------------------------------------------------------------------< MENU Credit Names >
Private Sub mnu_crdname_Novo_Click()
    FCrdNames.MENU_NOVO
End Sub

Private Sub mnu_crdname_edit_Click()
    FCrdNames.MENU_EDIT
End Sub

Private Sub mnu_crdname_delete_Click()
    FCrdNames.MENU_EXCLUI
End Sub


'---------------------------------------------------------------------------------< MENU Provisões >
Private Sub mnu_ProvEdita_Click()
    FProvFilter.Editar
End Sub

Private Sub mnu_ProvExclui_Click()
    FProvFilter.Deletar
End Sub

Private Sub mnu_ProvNova_Click()
    FProvFilter.Nova
End Sub


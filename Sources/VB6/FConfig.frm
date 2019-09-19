VERSION 5.00
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FConfig 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Configuração"
   ClientHeight    =   6345
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6525
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6345
   ScaleWidth      =   6525
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame8 
      Caption         =   "Boletas"
      Height          =   1095
      Left            =   120
      TabIndex        =   128
      Top             =   360
      Width           =   6375
      Begin VB.TextBox Text61 
         Enabled         =   0   'False
         Height          =   645
         Left            =   2040
         TabIndex        =   129
         Text            =   "Text1"
         Top             =   240
         Width           =   4095
      End
      Begin VB.Label Label1 
         Caption         =   "Nome do Arquivo"
         Height          =   255
         Left            =   600
         TabIndex        =   130
         Top             =   240
         Width           =   1455
      End
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   375
      Left            =   120
      TabIndex        =   127
      Top             =   0
      Width           =   6375
      _ExtentX        =   11245
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   8
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Carteira"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Passivo"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Limites"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab4 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "R. Mercado"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab5 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "R. Crédito"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab6 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Reporte"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab7 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "AML"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab8 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Boletas"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame7 
      Caption         =   "AML"
      Height          =   4215
      Left            =   120
      TabIndex        =   110
      Top             =   360
      Width           =   6375
      Begin VB.TextBox Text47 
         Enabled         =   0   'False
         Height          =   525
         Left            =   2040
         MultiLine       =   -1  'True
         TabIndex        =   117
         Text            =   "FConfig.frx":0000
         Top             =   360
         Width           =   4095
      End
      Begin VB.TextBox Text48 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   116
         Text            =   "Text1"
         Top             =   1560
         Width           =   4095
      End
      Begin VB.TextBox Text49 
         Enabled         =   0   'False
         Height          =   525
         Left            =   2040
         MultiLine       =   -1  'True
         TabIndex        =   115
         Text            =   "FConfig.frx":0006
         Top             =   960
         Width           =   4095
      End
      Begin VB.TextBox Text21 
         Enabled         =   0   'False
         Height          =   525
         Left            =   2040
         MultiLine       =   -1  'True
         TabIndex        =   114
         Text            =   "FConfig.frx":000C
         Top             =   1920
         Width           =   4095
      End
      Begin VB.TextBox Text22 
         Enabled         =   0   'False
         Height          =   525
         Left            =   2040
         MultiLine       =   -1  'True
         TabIndex        =   113
         Text            =   "FConfig.frx":0012
         Top             =   2520
         Width           =   4095
      End
      Begin VB.TextBox Text23 
         Enabled         =   0   'False
         Height          =   525
         Left            =   2040
         MultiLine       =   -1  'True
         TabIndex        =   112
         Text            =   "FConfig.frx":0018
         Top             =   3120
         Width           =   4095
      End
      Begin VB.TextBox Text51 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   111
         Text            =   "Text1"
         Top             =   3720
         Width           =   4095
      End
      Begin VB.Label Label51 
         Caption         =   "Database do CRM"
         Height          =   255
         Left            =   480
         TabIndex        =   124
         Top             =   360
         Width           =   1455
      End
      Begin VB.Label Label52 
         Caption         =   "Tab de Trades"
         Height          =   255
         Left            =   480
         TabIndex        =   123
         Top             =   1560
         Width           =   1455
      End
      Begin VB.Label Label53 
         Caption         =   "Nome do Arquivo de Trades RFE (.xls)"
         Height          =   495
         Left            =   480
         TabIndex        =   122
         Top             =   960
         Width           =   1455
      End
      Begin VB.Label Label22 
         Caption         =   "Prefixo dos arquivos NEG (.txt)"
         Height          =   495
         Left            =   480
         TabIndex        =   121
         Top             =   1920
         Width           =   1455
      End
      Begin VB.Label Label27 
         Caption         =   "Prefixo dos arquivos Pricing (.txt)"
         Height          =   495
         Left            =   480
         TabIndex        =   120
         Top             =   2520
         Width           =   1455
      End
      Begin VB.Label Label28 
         Caption         =   "Nome do Arquivo de FII (.xls)"
         Height          =   495
         Left            =   480
         TabIndex        =   119
         Top             =   3120
         Width           =   1455
      End
      Begin VB.Label Label29 
         Caption         =   "Tab de FII"
         Height          =   255
         Left            =   480
         TabIndex        =   118
         Top             =   3720
         Width           =   1455
      End
   End
   Begin VB.Frame Frame6 
      Caption         =   "Limites de Risco"
      Height          =   2535
      Left            =   120
      TabIndex        =   89
      Top             =   360
      Width           =   6375
      Begin VB.TextBox Text32 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   102
         Text            =   "Text1"
         Top             =   1440
         Width           =   1215
      End
      Begin VB.TextBox Text33 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   101
         Text            =   "Text1"
         Top             =   1080
         Width           =   1215
      End
      Begin VB.TextBox Text34 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   100
         Text            =   "Text1"
         Top             =   720
         Width           =   1215
      End
      Begin VB.TextBox Text35 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   99
         Text            =   "Text1"
         Top             =   1800
         Width           =   1215
      End
      Begin VB.TextBox Text36 
         Enabled         =   0   'False
         Height          =   285
         Left            =   3480
         TabIndex        =   98
         Text            =   "Text1"
         Top             =   1440
         Width           =   1215
      End
      Begin VB.TextBox Text37 
         Enabled         =   0   'False
         Height          =   285
         Left            =   3480
         TabIndex        =   97
         Text            =   "Text1"
         Top             =   1080
         Width           =   1215
      End
      Begin VB.TextBox Text38 
         Enabled         =   0   'False
         Height          =   285
         Left            =   3480
         TabIndex        =   96
         Text            =   "Text1"
         Top             =   720
         Width           =   1215
      End
      Begin VB.TextBox Text39 
         Enabled         =   0   'False
         Height          =   285
         Left            =   3480
         TabIndex        =   95
         Text            =   "Text1"
         Top             =   1800
         Width           =   1215
      End
      Begin VB.TextBox Text40 
         Enabled         =   0   'False
         Height          =   285
         Left            =   4920
         TabIndex        =   94
         Text            =   "Text1"
         Top             =   1440
         Width           =   1215
      End
      Begin VB.TextBox Text41 
         Enabled         =   0   'False
         Height          =   285
         Left            =   4920
         TabIndex        =   93
         Text            =   "Text1"
         Top             =   1080
         Width           =   1215
      End
      Begin VB.TextBox Text42 
         Enabled         =   0   'False
         Height          =   285
         Left            =   4920
         TabIndex        =   92
         Text            =   "Text1"
         Top             =   720
         Width           =   1215
      End
      Begin VB.TextBox Text43 
         Enabled         =   0   'False
         Height          =   285
         Left            =   4920
         TabIndex        =   91
         Text            =   "Text1"
         Top             =   1800
         Width           =   1215
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Warn a 80% do Limite"
         Height          =   255
         Left            =   480
         TabIndex        =   90
         Top             =   2160
         Width           =   5655
      End
      Begin VB.Label Label40 
         Caption         =   "Perda Esperada EL"
         Height          =   255
         Left            =   480
         TabIndex        =   109
         Top             =   1440
         Width           =   1455
      End
      Begin VB.Label Label41 
         Caption         =   "Stress"
         Height          =   255
         Left            =   480
         TabIndex        =   108
         Top             =   1080
         Width           =   1455
      End
      Begin VB.Label Label42 
         Caption         =   "VaR"
         Height          =   255
         Left            =   480
         TabIndex        =   107
         Top             =   720
         Width           =   1455
      End
      Begin VB.Label Label43 
         Caption         =   "Credit-VaR"
         Height          =   255
         Left            =   480
         TabIndex        =   106
         Top             =   1800
         Width           =   1455
      End
      Begin VB.Label Label44 
         Alignment       =   2  'Center
         Caption         =   "Aberto geral"
         Height          =   255
         Left            =   2040
         TabIndex        =   105
         Top             =   360
         Width           =   1215
      End
      Begin VB.Label Label45 
         Alignment       =   2  'Center
         Caption         =   "Qualificado"
         Height          =   255
         Left            =   3480
         TabIndex        =   104
         Top             =   360
         Width           =   1215
      End
      Begin VB.Label Label46 
         Alignment       =   2  'Center
         Caption         =   "Profissional"
         Height          =   255
         Left            =   4920
         TabIndex        =   103
         Top             =   360
         Width           =   1215
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Movimentação de quotistas"
      Height          =   3975
      Left            =   120
      TabIndex        =   74
      Top             =   360
      Width           =   6375
      Begin VB.TextBox Text10 
         Enabled         =   0   'False
         Height          =   525
         Left            =   2040
         MultiLine       =   -1  'True
         TabIndex        =   80
         Text            =   "FConfig.frx":001E
         Top             =   720
         Width           =   4095
      End
      Begin VB.TextBox Text11 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   79
         Text            =   "Text1"
         Top             =   1320
         Width           =   4095
      End
      Begin VB.TextBox Text12 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   78
         Text            =   "Text1"
         Top             =   1680
         Width           =   4095
      End
      Begin VB.TextBox Text18 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   77
         Text            =   "Text1"
         Top             =   2040
         Width           =   4095
      End
      Begin VB.TextBox Text19 
         Enabled         =   0   'False
         Height          =   525
         Left            =   2040
         MultiLine       =   -1  'True
         TabIndex        =   76
         Text            =   "FConfig.frx":0024
         Top             =   3000
         Width           =   4095
      End
      Begin VB.TextBox Text20 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   75
         Text            =   "Text1"
         Top             =   3600
         Width           =   4095
      End
      Begin VB.Label Label12 
         Caption         =   "Importação de dados de Resgates"
         Height          =   255
         Left            =   120
         TabIndex        =   88
         Top             =   360
         Width           =   5895
      End
      Begin VB.Label Label13 
         Caption         =   "Path do Arquivo"
         Height          =   255
         Left            =   480
         TabIndex        =   87
         Top             =   720
         Width           =   1455
      End
      Begin VB.Label Label14 
         Caption         =   "Nome do Arquivo"
         Height          =   255
         Left            =   480
         TabIndex        =   86
         Top             =   1320
         Width           =   1455
      End
      Begin VB.Label Label15 
         Caption         =   "Tab de Resgates"
         Height          =   255
         Left            =   480
         TabIndex        =   85
         Top             =   1680
         Width           =   1455
      End
      Begin VB.Label Label23 
         Caption         =   "Tab de Transfers"
         Height          =   255
         Left            =   480
         TabIndex        =   84
         Top             =   2040
         Width           =   1455
      End
      Begin VB.Label Label24 
         Caption         =   "Importação de dados de Posição de Cotistas"
         Height          =   255
         Left            =   120
         TabIndex        =   83
         Top             =   2640
         Width           =   5655
      End
      Begin VB.Label Label25 
         Caption         =   "Path do Arquivo (.xls)"
         Height          =   495
         Left            =   480
         TabIndex        =   82
         Top             =   3000
         Width           =   1455
      End
      Begin VB.Label Label26 
         Caption         =   "Nome do Arquivo"
         Height          =   255
         Left            =   480
         TabIndex        =   81
         Top             =   3600
         Width           =   1455
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Risco de Crédito"
      Height          =   4935
      Left            =   120
      TabIndex        =   47
      Top             =   360
      Width           =   6255
      Begin VB.TextBox Text75 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   150
         Text            =   "Text1"
         Top             =   1080
         Width           =   4095
      End
      Begin VB.TextBox Text74 
         Enabled         =   0   'False
         Height          =   285
         Left            =   5280
         TabIndex        =   149
         Text            =   "Text1"
         Top             =   2160
         Width           =   735
      End
      Begin VB.TextBox Text73 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2760
         TabIndex        =   148
         Text            =   "Text1"
         Top             =   2520
         Width           =   735
      End
      Begin VB.TextBox Text72 
         Enabled         =   0   'False
         Height          =   285
         Left            =   5280
         TabIndex        =   147
         Text            =   "Text1"
         Top             =   1440
         Width           =   735
      End
      Begin VB.TextBox Text71 
         Enabled         =   0   'False
         Height          =   285
         Left            =   5280
         TabIndex        =   146
         Text            =   "Text1"
         Top             =   1800
         Width           =   735
      End
      Begin VB.TextBox Text70 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2760
         TabIndex        =   145
         Text            =   "Text1"
         Top             =   1440
         Width           =   735
      End
      Begin VB.TextBox Text69 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2760
         TabIndex        =   144
         Text            =   "Text1"
         Top             =   1800
         Width           =   735
      End
      Begin VB.TextBox Text68 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2760
         TabIndex        =   143
         Text            =   "Text1"
         Top             =   2160
         Width           =   735
      End
      Begin VB.TextBox Text67 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   141
         Text            =   "Text1"
         Top             =   3240
         Width           =   1215
      End
      Begin VB.TextBox Text60 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   72
         Text            =   "Text1"
         Top             =   4320
         Width           =   4095
      End
      Begin VB.TextBox Text24 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   59
         Text            =   "Text1"
         Top             =   2160
         Width           =   735
      End
      Begin VB.TextBox Text25 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   58
         Text            =   "Text1"
         Top             =   1800
         Width           =   735
      End
      Begin VB.TextBox Text26 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   57
         Text            =   "Text1"
         Top             =   1440
         Width           =   735
      End
      Begin VB.TextBox Text27 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   56
         Text            =   "Text1"
         Top             =   360
         Width           =   4095
      End
      Begin VB.TextBox Text28 
         Enabled         =   0   'False
         Height          =   285
         Left            =   4440
         TabIndex        =   55
         Text            =   "Text1"
         Top             =   1800
         Width           =   735
      End
      Begin VB.TextBox Text29 
         Enabled         =   0   'False
         Height          =   285
         Left            =   4440
         TabIndex        =   54
         Text            =   "Text1"
         Top             =   1440
         Width           =   735
      End
      Begin VB.TextBox Text30 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   53
         Text            =   "Text1"
         Top             =   2520
         Width           =   735
      End
      Begin VB.TextBox Text31 
         Enabled         =   0   'False
         Height          =   285
         Left            =   4440
         TabIndex        =   52
         Text            =   "Text1"
         Top             =   2160
         Width           =   735
      End
      Begin VB.TextBox Text46 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   51
         Text            =   "Text1"
         Top             =   2880
         Width           =   1215
      End
      Begin VB.TextBox Text50 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   50
         Text            =   "Text1"
         Top             =   3600
         Width           =   1215
      End
      Begin VB.TextBox Text58 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   49
         Text            =   "Text1"
         Top             =   720
         Width           =   4095
      End
      Begin VB.TextBox Text59 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   48
         Text            =   "Text1"
         Top             =   3960
         Width           =   1215
      End
      Begin VB.Label Label65 
         Caption         =   "Propriedade Setor"
         Height          =   255
         Left            =   360
         TabIndex        =   151
         Top             =   1080
         Width           =   1455
      End
      Begin VB.Label Label58 
         Caption         =   "Loss correl.intra-set"
         Height          =   255
         Left            =   360
         TabIndex        =   142
         Top             =   3240
         Width           =   1575
      End
      Begin VB.Label Label64 
         Caption         =   "Tab do Credit Score (Arquivo de Séries)"
         Height          =   495
         Left            =   360
         TabIndex        =   73
         Top             =   4320
         Width           =   1455
      End
      Begin VB.Label Label31 
         Caption         =   "EDF A"
         Height          =   255
         Left            =   360
         TabIndex        =   71
         Top             =   2160
         Width           =   1455
      End
      Begin VB.Label Label32 
         Caption         =   "EDF AA"
         Height          =   255
         Left            =   360
         TabIndex        =   70
         Top             =   1800
         Width           =   1455
      End
      Begin VB.Label Label33 
         Caption         =   "EDF AAA"
         Height          =   255
         Left            =   360
         TabIndex        =   69
         Top             =   1440
         Width           =   1455
      End
      Begin VB.Label Label34 
         Caption         =   "Propriedade Rating"
         Height          =   255
         Left            =   360
         TabIndex        =   68
         Top             =   360
         Width           =   1455
      End
      Begin VB.Label Label35 
         Caption         =   "EDF B"
         Height          =   255
         Left            =   3720
         TabIndex        =   67
         Top             =   1800
         Width           =   975
      End
      Begin VB.Label Label36 
         Caption         =   "EDF BB"
         Height          =   255
         Left            =   3720
         TabIndex        =   66
         Top             =   1440
         Width           =   975
      End
      Begin VB.Label Label37 
         Caption         =   "EDF BBB"
         Height          =   255
         Left            =   360
         TabIndex        =   65
         Top             =   2520
         Width           =   975
      End
      Begin VB.Label Label38 
         Caption         =   "EDF CCC"
         Height          =   255
         Left            =   3720
         TabIndex        =   64
         Top             =   2160
         Width           =   975
      End
      Begin VB.Label Label50 
         Caption         =   "Loss correl.extra-set"
         Height          =   255
         Left            =   360
         TabIndex        =   63
         Top             =   2880
         Width           =   1575
      End
      Begin VB.Label Label54 
         Caption         =   "LGD Clean"
         Height          =   255
         Left            =   360
         TabIndex        =   62
         Top             =   3600
         Width           =   1455
      End
      Begin MSForms.Label Label62 
         Height          =   255
         Left            =   360
         TabIndex        =   61
         Top             =   720
         Width           =   1575
         Caption         =   "Prop. Rating Interno"
         Size            =   "2778;450"
         FontHeight      =   165
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
      Begin VB.Label Label63 
         Caption         =   "LGD Secured"
         Height          =   255
         Left            =   360
         TabIndex        =   60
         Top             =   3960
         Width           =   1455
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Risco de Mercado"
      Height          =   5895
      Left            =   120
      TabIndex        =   18
      Top             =   360
      Width           =   6375
      Begin VB.TextBox Text62 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   125
         Text            =   "Text1"
         Top             =   1680
         Width           =   4095
      End
      Begin VB.TextBox Text1 
         Enabled         =   0   'False
         Height          =   525
         Left            =   2040
         MultiLine       =   -1  'True
         TabIndex        =   32
         Text            =   "FConfig.frx":002A
         Top             =   360
         Width           =   4095
      End
      Begin VB.TextBox Text2 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   31
         Text            =   "Text1"
         Top             =   960
         Width           =   4095
      End
      Begin VB.TextBox Text3 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   30
         Text            =   "Text1"
         Top             =   1320
         Width           =   4095
      End
      Begin VB.TextBox Text4 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   29
         Text            =   "Text1"
         Top             =   2040
         Width           =   4095
      End
      Begin VB.TextBox Text5 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   28
         Text            =   "Text1"
         Top             =   2400
         Width           =   4095
      End
      Begin VB.TextBox Text6 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   27
         Text            =   "Text1"
         Top             =   2760
         Width           =   4095
      End
      Begin VB.TextBox Text7 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   26
         Text            =   "Text1"
         Top             =   3120
         Width           =   4095
      End
      Begin VB.TextBox Text8 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   25
         Text            =   "Text1"
         Top             =   3480
         Width           =   4095
      End
      Begin VB.TextBox Text17 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   24
         Text            =   "Text1"
         Top             =   5040
         Width           =   1095
      End
      Begin VB.TextBox Text44 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   23
         Text            =   "Text1"
         Top             =   5400
         Width           =   1095
      End
      Begin VB.TextBox Text45 
         Enabled         =   0   'False
         Height          =   285
         Left            =   5040
         TabIndex        =   22
         Text            =   "Text1"
         Top             =   5400
         Width           =   1095
      End
      Begin VB.TextBox Text52 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   21
         Text            =   "Text1"
         Top             =   3840
         Width           =   4095
      End
      Begin VB.TextBox Text53 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   20
         Text            =   "Text1"
         Top             =   4200
         Width           =   4095
      End
      Begin VB.TextBox Text54 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   19
         Text            =   "Text1"
         Top             =   4560
         Width           =   4095
      End
      Begin VB.Label Label66 
         Caption         =   "Tab das Quotas"
         Height          =   255
         Left            =   480
         TabIndex        =   126
         Top             =   1680
         Width           =   1455
      End
      Begin VB.Label Label2 
         Caption         =   "Path do Arquivo"
         Height          =   255
         Left            =   480
         TabIndex        =   46
         Top             =   360
         Width           =   1455
      End
      Begin VB.Label Label3 
         Caption         =   "Nome do Arquivo"
         Height          =   255
         Left            =   480
         TabIndex        =   45
         Top             =   960
         Width           =   1455
      End
      Begin VB.Label Label4 
         Caption         =   "Tab das Séries"
         Height          =   255
         Left            =   480
         TabIndex        =   44
         Top             =   1320
         Width           =   1455
      End
      Begin VB.Label Label5 
         Caption         =   "Índice IFIX"
         Height          =   255
         Left            =   480
         TabIndex        =   43
         Top             =   2040
         Width           =   1455
      End
      Begin VB.Label Label6 
         Caption         =   "Índice IPCA 2Y"
         Height          =   255
         Left            =   480
         TabIndex        =   42
         Top             =   2400
         Width           =   1455
      End
      Begin VB.Label Label7 
         Caption         =   "Índice IPCA 5Y"
         Height          =   255
         Left            =   480
         TabIndex        =   41
         Top             =   2760
         Width           =   1455
      End
      Begin VB.Label Label8 
         Caption         =   "Índice IPCA 10Y"
         Height          =   255
         Left            =   480
         TabIndex        =   40
         Top             =   3120
         Width           =   1455
      End
      Begin VB.Label Label9 
         Caption         =   "Índice IMA-B 5"
         Height          =   255
         Left            =   480
         TabIndex        =   39
         Top             =   3480
         Width           =   1455
      End
      Begin VB.Label Label21 
         Caption         =   "EWMA Lambda"
         Height          =   255
         Left            =   480
         TabIndex        =   38
         Top             =   5040
         Width           =   1455
      End
      Begin VB.Label Label48 
         Caption         =   "Nível do DI"
         Height          =   255
         Left            =   480
         TabIndex        =   37
         Top             =   5400
         Width           =   1455
      End
      Begin VB.Label Label49 
         Caption         =   "Nível da Inflação"
         Height          =   255
         Left            =   3600
         TabIndex        =   36
         Top             =   5400
         Width           =   1455
      End
      Begin VB.Label Label55 
         Caption         =   "Índice Pré 2Y"
         Height          =   255
         Left            =   480
         TabIndex        =   35
         Top             =   3840
         Width           =   1455
      End
      Begin VB.Label Label56 
         Caption         =   "Índice Pré 5Y"
         Height          =   255
         Left            =   480
         TabIndex        =   34
         Top             =   4200
         Width           =   1455
      End
      Begin VB.Label Label57 
         Caption         =   "Índice Dólar"
         Height          =   255
         Left            =   480
         TabIndex        =   33
         Top             =   4560
         Width           =   1455
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Reporte"
      Height          =   4695
      Left            =   120
      TabIndex        =   9
      Top             =   360
      Width           =   6375
      Begin VB.TextBox Text66 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   135
         Text            =   "Text1"
         Top             =   3720
         Width           =   4095
      End
      Begin VB.TextBox Text65 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   134
         Text            =   "Text1"
         Top             =   3360
         Width           =   4095
      End
      Begin VB.TextBox Text64 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   133
         Text            =   "Text1"
         Top             =   3000
         Width           =   4095
      End
      Begin VB.TextBox Text63 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   132
         Text            =   "Text1"
         Top             =   2640
         Width           =   4095
      End
      Begin VB.TextBox Text13 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2160
         TabIndex        =   13
         Text            =   "Text1"
         Top             =   720
         Width           =   4095
      End
      Begin VB.TextBox Text14 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2160
         TabIndex        =   12
         Text            =   "Text1"
         Top             =   1080
         Width           =   4095
      End
      Begin VB.TextBox Text15 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2160
         TabIndex        =   11
         Text            =   "Text1"
         Top             =   1440
         Width           =   4095
      End
      Begin VB.TextBox Text16 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2160
         TabIndex        =   10
         Text            =   "Text1"
         Top             =   1800
         Width           =   4095
      End
      Begin MSForms.Label Label47 
         Height          =   255
         Left            =   120
         TabIndex        =   140
         Top             =   2280
         Width           =   4695
         Caption         =   "Reporte de Stress por Cenário"
         Size            =   "8281;450"
         FontHeight      =   165
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
      Begin VB.Label Label39 
         Caption         =   "Cenário 4"
         Height          =   255
         Left            =   600
         TabIndex        =   139
         Top             =   3720
         Width           =   975
      End
      Begin VB.Label Label30 
         Caption         =   "Cenário 3"
         Height          =   255
         Left            =   600
         TabIndex        =   138
         Top             =   3360
         Width           =   975
      End
      Begin VB.Label Label16 
         Caption         =   "Cenário 2"
         Height          =   255
         Left            =   600
         TabIndex        =   137
         Top             =   3000
         Width           =   975
      End
      Begin VB.Label Label11 
         Caption         =   "Cenário 1"
         Height          =   255
         Left            =   600
         TabIndex        =   136
         Top             =   2640
         Width           =   975
      End
      Begin MSForms.Label Label10 
         Height          =   255
         Left            =   360
         TabIndex        =   131
         Top             =   360
         Width           =   4695
         Caption         =   "Reporte de Concentração"
         Size            =   "8281;450"
         FontHeight      =   165
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
      Begin VB.Label Label17 
         Caption         =   "ID do Fundo"
         Height          =   255
         Left            =   600
         TabIndex        =   17
         Top             =   720
         Width           =   1455
      End
      Begin VB.Label Label18 
         Caption         =   "Propriedade 1"
         Height          =   255
         Left            =   600
         TabIndex        =   16
         Top             =   1080
         Width           =   1455
      End
      Begin VB.Label Label19 
         Caption         =   "Propriedade 2"
         Height          =   255
         Left            =   600
         TabIndex        =   15
         Top             =   1440
         Width           =   1455
      End
      Begin VB.Label Label20 
         Caption         =   "Propriedade 3"
         Height          =   255
         Left            =   600
         TabIndex        =   14
         Top             =   1800
         Width           =   1455
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Importação de Carteira"
      Height          =   2535
      Left            =   120
      TabIndex        =   0
      Top             =   360
      Width           =   6375
      Begin VB.TextBox Text55 
         Enabled         =   0   'False
         Height          =   525
         Left            =   2160
         MultiLine       =   -1  'True
         TabIndex        =   5
         Text            =   "FConfig.frx":0030
         Top             =   960
         Width           =   4095
      End
      Begin VB.TextBox Text56 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2160
         MultiLine       =   -1  'True
         TabIndex        =   4
         Text            =   "FConfig.frx":0036
         Top             =   1560
         Width           =   4095
      End
      Begin VB.TextBox Text57 
         Enabled         =   0   'False
         Height          =   525
         Left            =   2160
         MultiLine       =   -1  'True
         TabIndex        =   3
         Text            =   "FConfig.frx":003C
         Top             =   1920
         Width           =   4095
      End
      Begin VB.TextBox Text9 
         Enabled         =   0   'False
         Height          =   525
         Left            =   2160
         MultiLine       =   -1  'True
         TabIndex        =   1
         Text            =   "FConfig.frx":0042
         Top             =   360
         Width           =   4095
      End
      Begin VB.Label Label59 
         Caption         =   "Path das Pastas XML"
         Height          =   375
         Left            =   600
         TabIndex        =   8
         Top             =   960
         Width           =   1455
      End
      Begin VB.Label Label60 
         Caption         =   "Prefixo do XML"
         Height          =   255
         Left            =   600
         TabIndex        =   7
         Top             =   1560
         Width           =   1455
      End
      Begin VB.Label Label61 
         Caption         =   "Database de ISIN"
         Height          =   255
         Left            =   600
         TabIndex        =   6
         Top             =   1920
         Width           =   1455
      End
      Begin VB.Label Label67 
         Caption         =   "Prefixo dos Arquivos (.txt)"
         Height          =   495
         Left            =   600
         TabIndex        =   2
         Top             =   360
         Width           =   1455
      End
   End
End
Attribute VB_Name = "FConfig"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub newshow()

    Me.Text1 = Config.HistFilePath
    Me.Text2 = Config.HistFileName
    Me.Text3 = Config.HistFileTab
    Me.Text4 = Config.HistfileIFIX
    Me.Text5 = Config.HistFileIPCA2Y
    Me.Text6 = Config.HistFileIPCA5Y
    Me.Text7 = Config.HistFileIPCA10Y
    Me.Text8 = Config.HistFileIMAB5
    Me.Text52 = Config.HistFilePre2Y
    Me.Text53 = Config.HistFilePre2Y
    Me.Text54 = Config.HistFileDolar
    Me.Text17 = Str(Config.EWMA)
    Me.Text60 = Config.HistFileRatingsTab
    Me.Text62 = Config.HistFileQuotaTab
        
    
    Me.Text9 = Config.PosicFilePrefix
    
    Me.Text10 = Config.RedemptionFilePath
    Me.Text11 = Config.RedemptionFileName
    Me.Text12 = Config.RedemptionFileTab
    Me.Text18 = Config.RedemptionFileTransferTab
    
    Me.Text13 = Config.ConcentrationFundID
    Me.Text14 = Config.ConcentrationProp1
    Me.Text15 = Config.ConcentrationProp2
    Me.Text16 = Config.ConcentrationProp3
    
    Me.Text19 = Config.ShareFilePath
    Me.Text20 = Config.ShareFileName
    
    Me.Text27 = Config.CreditRatingProperty
    Me.Text58 = Config.IRBRatingProperty
    Me.Text75 = Config.CredGroupProperty
    Me.Text26 = Format(Config.EDFAAA, "#0.00")
    Me.Text25 = Format(Config.EDFAA, "#0.00")
    Me.Text24 = Format(Config.EDFA, "#0.00")
    Me.Text30 = Format(Config.EDFBBB, "#0.00")
    Me.Text29 = Format(Config.EDFBB, "#0.00")
    Me.Text28 = Format(Config.EDFB, "#0.00")
    Me.Text31 = Format(Config.EDFCCC, "#0.00")
    Me.Text70 = Format(Config.EDFAAAask, "#0.00")
    Me.Text69 = Format(Config.EDFAAask, "#0.00")
    Me.Text68 = Format(Config.EDFAask, "#0.00")
    Me.Text73 = Format(Config.EDFBBBask, "#0.00")
    Me.Text72 = Format(Config.EDFBBask, "#0.00")
    Me.Text71 = Format(Config.EDFBask, "#0.00")
    Me.Text74 = Format(Config.EDFCCCask, "#0.00")
    
    Me.Text34 = Format(Config.LVV * 100, "#0.00")
    Me.Text38 = Format(Config.LVQ * 100, "#0.00")
    Me.Text42 = Format(Config.LVP * 100, "#0.00")
    
    Me.Text33 = Format(Config.LSV * 100, "#0.00")
    Me.Text37 = Format(Config.LSQ * 100, "#0.00")
    Me.Text41 = Format(Config.LSP * 100, "#0.00")
    
    Me.Text32 = Format(Config.LEV * 100, "#0.00")
    Me.Text36 = Format(Config.LEQ * 100, "#0.00")
    Me.Text40 = Format(Config.LEP * 100, "#0.00")
    
    Me.Text35 = Format(Config.LUV * 100, "#0.00")
    Me.Text39 = Format(Config.LUQ * 100, "#0.00")
    Me.Text43 = Format(Config.LUP * 100, "#0.00")
    
    Me.Check1 = Bol2Check(Config.WarnAt20)
    
    Me.Text47 = Config.CRMDataBase
    Me.Text49 = Config.RFETradeSheet
    Me.Text48 = Config.RFETradeTab
    
    Me.Text44 = Format(RiskMgr.GenLvlDI, "#0.00%")
    Me.Text45 = Format(RiskMgr.GenLvlInflation, "#0.00%")
    
    Me.Text50 = Config.CredLGD
    Me.Text59 = Config.CredLGDSec
    Me.Text46 = Config.CredCorrel
    Me.Text67 = Config.CredCorrelIntra
    
    Me.Text21 = Config.NEGSFilePrefix
    Me.Text22 = Config.PricingFilePrefix
    Me.Text23 = Config.FIIFileName
    Me.Text51 = Config.FIIFileTab
    
    Me.Text55 = Config.XMLANBIMAPath
    Me.Text56 = Config.XMLANBIMAPrefix
    Me.Text57 = Config.ISINDataBase
    
    Me.Text61 = Config.BlotterFileName
    
    Me.Text63 = Config.RStress1
    Me.Text64 = Config.RStress2
    Me.Text65 = Config.RStress3
    Me.Text66 = Config.RStress4
    
    newrefresh
    Me.Show
End Sub

Public Sub newrefresh()
    For Each x In Me.Controls
        If Left(x.Name, 5) = "Frame" Then x.Visible = False
    Next x
    Select Case TabStrip1.SelectedItem.Caption
        Case "Carteira"
            Me.Frame1.Visible = True
        Case "Reporte"
            Me.Frame2.Visible = True
        Case "R. Mercado"
            Me.Frame3.Visible = True
        Case "R. Crédito"
            Me.Frame4.Visible = True
        Case "Passivo"
            Me.Frame5.Visible = True
        Case "Limites"
            Me.Frame6.Visible = True
        Case "AML"
            Me.Frame7.Visible = True
        Case "Boletas"
            Me.Frame8.Visible = True
    End Select
    Me.Refresh
End Sub



Private Sub TabStrip1_Click()
    newrefresh
End Sub


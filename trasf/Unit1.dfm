object Form1: TForm1
  Left = 891
  Top = 309
  Anchors = []
  Caption = 'Controllo acquisti online - v 9.13'
  ClientHeight = 410
  ClientWidth = 946
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 46
    Width = 646
    Height = 13
    Caption = 
      'DataOrd...a    Fornitore               Prodotto                 ' +
      '                               MezzoPag                         ' +
      '                                  Filtro libero SQL'
  end
  object Label2: TLabel
    Left = 8
    Top = 3
    Width = 65
    Height = 13
    Caption = 'DataOrd...da'
  end
  object Label3: TLabel
    Left = 249
    Top = 20
    Width = 144
    Height = 20
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 408
    Top = 19
    Width = 81
    Height = 21
    AutoSize = False
  end
  object Label5: TLabel
    Left = 507
    Top = 18
    Width = 214
    Height = 22
    AutoSize = False
  end
  object Label6: TLabel
    Left = 731
    Top = 15
    Width = 3
    Height = 13
  end
  object Label7: TLabel
    Left = 127
    Top = 357
    Width = 347
    Height = 13
    Caption = 
      'Per inserire un dato nuovo di Fornitore o Mezzo di Pag.  PREMERE' +
      ' SHIFT'
    Color = clCaptionText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 9
    Top = 91
    Width = 929
    Height = 265
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnColExit = DBGrid1ColExit
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnKeyPress = DBGrid1KeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'DataOrd'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Prodotto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fornitore'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Prezzo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DataPag'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MezzoPag'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DataSped'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DataCons'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'delta'
        Title.Caption = 'GG Tot'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'delta2'
        Title.Caption = 'GG Sped'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Note'
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 375
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 1
    OnClick = DBNavigator1Click
  end
  object Edit1: TEdit
    Left = 9
    Top = 64
    Width = 65
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = 'gg/mm/aaaa'
  end
  object Edit2: TEdit
    Left = 80
    Top = 64
    Width = 82
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object Edit3: TEdit
    Left = 168
    Top = 64
    Width = 177
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object Edit4: TEdit
    Left = 351
    Top = 64
    Width = 90
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object Edit5: TEdit
    Left = 8
    Top = 19
    Width = 65
    Height = 21
    TabOrder = 6
    Text = '01/02/2014'
  end
  object Button1: TButton
    Left = 79
    Top = 15
    Width = 75
    Height = 25
    Caption = 'Cerca'
    TabOrder = 7
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 168
    Top = 15
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 8
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 270
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Query>Table'
    TabOrder = 9
    OnClick = Button3Click
  end
  object Edit6: TEdit
    Left = 447
    Top = 65
    Width = 426
    Height = 21
    Hint = 'es.Select * from ecomTB where Fornitore ='#39'amazon'#39
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    Text = 'select * from ecomTB'
  end
  object Button4: TButton
    Left = 672
    Top = 40
    Width = 75
    Height = 18
    Caption = 'Filtra'
    TabOrder = 11
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 753
    Top = 40
    Width = 75
    Height = 18
    Caption = 'Reset'
    TabOrder = 12
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 376
    Top = 376
    Width = 75
    Height = 33
    Caption = '  Azzera Database '
    TabOrder = 13
    WordWrap = True
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 480
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Done'
    TabOrder = 14
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 581
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Backup'
    TabOrder = 15
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 680
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Report'
    TabOrder = 16
    OnClick = Button9Click
  end
  object DBLookupComboBox: TDBLookupComboBox
    Left = 3768
    Top = 1920
    Width = 145
    Height = 21
    DataField = 'MezzoPag'
    DataSource = DataSource1
    KeyField = 'MP'
    ListSource = DataSource2
    TabOrder = 17
    Visible = False
  end
  object JvDBLookupCombo1: TJvDBLookupCombo
    Left = 432
    Top = 304
    Width = 145
    Height = 21
    DataField = 'Fornitore'
    DataSource = DataSource1
    LookupField = 'FRN'
    LookupDisplay = 'FRN'
    LookupSource = DataSource2
    TabOrder = 18
    Visible = False
    OnChange = DBGrid1ColExit
  end
  object JvDBLookupCombo2: TJvDBLookupCombo
    Left = 656
    Top = 272
    Width = 145
    Height = 21
    DataField = 'MezzoPag'
    DataSource = DataSource1
    LookupField = 'MP'
    LookupDisplay = 'MP'
    LookupSource = DataSource2
    TabOrder = 19
    Visible = False
    OnChange = DBGrid1ColExit
  end
  object Button10: TButton
    Left = 776
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Statistiche'
    TabOrder = 20
    OnClick = Button10Click
  end
  object ABSDatabase1: TABSDatabase
    CurrentVersion = '7.91 '
    DatabaseFileName = '.\ecom.ABS'
    DatabaseName = 'ecom.abs'
    Exclusive = False
    MaxConnections = 500
    MultiUser = False
    SessionName = 'Default'
    Left = 272
    Top = 200
  end
  object DataSource1: TDataSource
    DataSet = ABSTable1
    Left = 288
    Top = 136
  end
  object ABSTable1: TABSTable
    CurrentVersion = '7.91 '
    DatabaseName = 'ecom.abs'
    InMemory = False
    ReadOnly = False
    StoreDefs = True
    IndexFieldNames = 'num'
    FieldDefs = <
      item
        Name = 'num'
        DataType = ftAutoInc
      end
      item
        Name = 'DataOrd'
        Attributes = [faRequired]
        DataType = ftDate
      end
      item
        Name = 'Fornitore'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Prodotto'
        Attributes = [faRequired]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Prezzo'
        DataType = ftFloat
      end
      item
        Name = 'DataPag'
        DataType = ftDate
      end
      item
        Name = 'Note'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'MezzoPag'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DataSped'
        DataType = ftDate
      end
      item
        Name = 'DataCons'
        DataType = ftDate
      end
      item
        Name = 'delta'
        DataType = ftSmallint
      end
      item
        Name = 'delta2'
        DataType = ftSmallint
      end>
    TableName = 'ecomTB'
    Exclusive = False
    Left = 152
    Top = 152
  end
  object ABSQuery1: TABSQuery
    CurrentVersion = '7.91 '
    DatabaseName = 'ecom.abs'
    InMemory = False
    ReadOnly = False
    Left = 424
    Top = 160
  end
  object jvshfile1: TJvSHFileOperation
    SourceFiles.Strings = (
      'ecom.abs')
    DestFiles.Strings = (
      'ecom.bkp')
    Left = 560
    Top = 160
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'DataOrd=Data'
      'Fornitore=Fornitore'
      'Prodotto=Prodotto'
      'Prezzo=Prezzo')
    DataSet = ABSQuery1
    BCDToCurrency = False
    Left = 432
    Top = 232
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 568
    Top = 232
  end
  object DataSource2: TDataSource
    DataSet = ABSTable2
    Left = 224
    Top = 256
  end
  object ABSTable2: TABSTable
    CurrentVersion = '7.91 '
    DatabaseName = 'ecom.abs'
    InMemory = False
    ReadOnly = False
    TableName = 'ecom2TB'
    Exclusive = False
    Left = 128
    Top = 240
  end
  object frxReport1: TfrxReport
    Version = '4.13.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43809.476558460650000000
    ReportOptions.LastChange = 43809.476558460650000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 664
    Top = 152
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxReport2: TfrxReport
    Version = '4.13.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43809.476622951390000000
    ReportOptions.LastChange = 43809.476622951390000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 752
    Top = 176
    Datasets = <>
    Variables = <>
    Style = <>
  end
end

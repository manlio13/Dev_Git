object Form1: TForm1
  Left = 617
  Top = 540
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Boat Log'
  ClientHeight = 247
  ClientWidth = 681
  Color = clBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clCream
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 17
    Top = 8
    Width = 29
    Height = 14
    Caption = 'Data'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 33
    Width = 31
    Height = 14
    Caption = 'Dove'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 57
    Width = 74
    Height = 14
    Caption = 'Annotazioni'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 17
    Top = 146
    Width = 57
    Height = 14
    Caption = 'Posizione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 17
    Top = 179
    Width = 39
    Height = 14
    Caption = 'Meteo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 611
    Top = 209
    Width = 49
    Height = 25
    Caption = 'Esci'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clCream
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBNavigator1: TDBNavigator
    Left = 106
    Top = 204
    Width = 360
    Height = 34
    DataSource = DataSource1
    TabOrder = 1
    OnClick = DBNavigator1Click
  end
  object DBEdit1: TDBEdit
    Left = 107
    Top = 3
    Width = 121
    Height = 21
    DataField = 'Data'
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object DBEdit2: TDBEdit
    Left = 106
    Top = 30
    Width = 561
    Height = 21
    DataField = 'Dove'
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object DBEdit3: TDBEdit
    Left = 106
    Top = 144
    Width = 280
    Height = 21
    DataField = 'Posizione'
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object DBEdit4: TDBEdit
    Left = 106
    Top = 177
    Width = 559
    Height = 21
    DataField = 'Meteo'
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object DBMemo1: TDBMemo
    Left = 106
    Top = 57
    Width = 561
    Height = 77
    DataField = 'Annotazioni'
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object Button2: TButton
    Left = 470
    Top = 209
    Width = 49
    Height = 25
    Caption = 'Azzera'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clCream
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 540
    Top = 209
    Width = 49
    Height = 25
    Caption = 'Stampa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clCream
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = Button3Click
  end
  object ABSTable1: TABSTable
    CurrentVersion = '7.60 '
    DatabaseName = 'BL.ABS'
    InMemory = False
    ReadOnly = False
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'dataIndex'
        Fields = 'Data'
        Options = [ixPrimary]
      end>
    FieldDefs = <
      item
        Name = 'Data'
        Attributes = [faRequired]
        DataType = ftTimeStamp
      end
      item
        Name = 'Dove'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'Annotazioni'
        DataType = ftMemo
      end
      item
        Name = 'Posizione'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Meteo'
        DataType = ftString
        Size = 70
      end>
    TableName = 'BLT'
    Exclusive = False
    Left = 368
    Top = 248
  end
  object ABSDatabase1: TABSDatabase
    CurrentVersion = '7.60 '
    DatabaseFileName = 'BL.ABS'
    DatabaseName = 'BL.abs'
    Exclusive = False
    MaxConnections = 500
    MultiUser = False
    SessionName = 'Default'
    Left = 200
    Top = 264
  end
  object DataSource1: TDataSource
    DataSet = ABSTable1
    Left = 32
    Top = 256
  end
  object frxReport1: TfrxReport
    Version = '4.13.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42147.945117731500000000
    ReportOptions.LastChange = 42274.635860057870000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 264
    Top = 104
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      Frame.Width = 4.000000000000000000
      object PageHeader1: TfrxPageHeader
        Height = 76.000000000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo5: TfrxMemoView
          Left = 252.000000000000000000
          Top = 35.102350000000000000
          Width = 147.488250000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Libro di Bordo')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Left = 4.000000000000000000
          Top = 63.102350000000000000
          Width = 706.000000000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
          Frame.Width = 3.000000000000000000
        end
        object Date: TfrxMemoView
          Left = 408.000000000000000000
          Top = 35.102350000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = 'YYYY'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        Height = 162.173160000000000000
        Top = 154.960730000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 6.000000000000000000
          Top = 0.582560000000000000
          Width = 709.488250000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Data                Dove                                        ' +
              '                                                             Pos' +
              'izione                                                          ' +
              '     ')
          ParentFont = False
        end
        object frxDBDataset1Data: TfrxMemoView
          Left = 5.000000000000000000
          Top = 14.598330000000000000
          Width = 86.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'Data'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Memo.UTF8W = (
            '[frxDBDataset1."Data"]')
        end
        object frxDBDataset1Dove: TfrxMemoView
          Left = 95.000000000000000000
          Top = 14.598330000000000000
          Width = 384.370130000000000000
          Height = 21.897650000000000000
          ShowHint = False
          DataField = 'Dove'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Memo.UTF8W = (
            '[frxDBDataset1."Dove"]')
        end
        object frxDBDataset1Posizione: TfrxMemoView
          Left = 480.000000000000000000
          Top = 15.598330000000000000
          Width = 232.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'Posizione'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Memo.UTF8W = (
            '[frxDBDataset1."Posizione"]')
          WordWrap = False
        end
        object frxDBDataset1Meteo: TfrxMemoView
          Left = 72.000000000000000000
          Top = 40.598330000000000000
          Width = 639.370130000000000000
          Height = 21.897650000000000000
          ShowHint = False
          DataField = 'Meteo'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Memo.UTF8W = (
            '[frxDBDataset1."Meteo"]')
        end
        object Memo3: TfrxMemoView
          Left = 5.000000000000000000
          Top = 42.700680000000000000
          Width = 65.488250000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Meteo:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 8.000000000000000000
          Top = 69.700680000000000000
          Width = 16.488250000000000000
          Height = 65.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'
            'O'
            'T'
            'E')
          ParentFont = False
        end
        object frxDBDataset1Annotazioni: TfrxMemoView
          Left = 27.000000000000000000
          Top = 66.275510000000000000
          Width = 687.370130000000000000
          Height = 84.897650000000000000
          ShowHint = False
          DataField = 'Annotazioni'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Memo.UTF8W = (
            '[frxDBDataset1."Annotazioni"]')
        end
        object Line1: TfrxLineView
          Top = 64.700680000000000000
          Width = 710.000000000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Left = 5.000000000000000000
          Top = 154.700680000000000000
          Width = 704.000000000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
          Frame.Width = 3.000000000000000000
        end
      end
      object Memo2: TfrxMemoView
        Left = 152.000000000000000000
        Top = 15.000000000000000000
        Width = 331.488250000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Memo.UTF8W = (
          'SY Amarose   2GE 7397 D       MMSI  247145400')
        ParentFont = False
      end
      object Line2: TfrxLineView
        Left = 98.000000000000000000
        Top = 485.000000000000000000
        Width = 1.000000000000000000
        ShowHint = False
        Frame.Typ = [ftTop]
      end
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'Data=Data'
      'Dove=Dove'
      'Posizione=Posizione'
      'Meteo=Meteo'
      'Annotazioni=Annotazioni')
    DataSet = ABSTable1
    BCDToCurrency = False
    Left = 400
    Top = 120
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
    Left = 504
    Top = 16
  end
end

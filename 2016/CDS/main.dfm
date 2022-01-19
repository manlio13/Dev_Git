object Form1: TForm1
  Left = 222
  Top = 159
  Width = 792
  Height = 512
  Caption = 'ClientDataSet Load Behavior Demonstration'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 421
    Top = 0
    Width = 6
    Height = 466
    Cursor = crHSplit
    Align = alRight
    Beveled = True
  end
  object Panel1: TPanel
    Left = 427
    Top = 0
    Width = 357
    Height = 466
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 0
      Top = 0
      Width = 357
      Height = 30
      DataSource = DataSource2
      Align = alTop
      TabOrder = 0
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 30
      Width = 357
      Height = 436
      Align = alClient
      DataSource = DataSource2
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 421
    Height = 466
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 1
    object DBNavigator2: TDBNavigator
      Left = 0
      Top = 0
      Width = 421
      Height = 30
      DataSource = DataSource1
      Align = alTop
      TabOrder = 0
    end
    object DBGrid2: TDBGrid
      Left = 0
      Top = 30
      Width = 421
      Height = 436
      Align = alClient
      DataSource = DataSource1
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 40
    Top = 318
  end
  object DataSource2: TDataSource
    DataSet = Table1
    Left = 503
    Top = 316
  end
  object Table1: TTable
    DatabaseName = 'DBDEMOS'
    TableName = 'items.db'
    Left = 577
    Top = 316
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    AfterPost = ClientDataSet1AfterPost
    AfterDelete = ClientDataSet1AfterPost
    Left = 128
    Top = 317
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = Table1
    Constraints = True
    Left = 227
    Top = 319
  end
  object MainMenu1: TMainMenu
    Left = 151
    Top = 118
    object File1: TMenuItem
      Caption = '&File'
      object SelectTable1: TMenuItem
        Caption = 'Select New Table'
        OnClick = SelectTable1Click
      end
      object ApplyUpdates1: TMenuItem
        Caption = 'Apply Updates'
        OnClick = ApplyUpdates1Click
      end
      object CancelUpdates1: TMenuItem
        Caption = 'Cancel Updates'
        OnClick = CancelUpdates1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
      end
    end
    object ClientDataSet2: TMenuItem
      Caption = 'ClientDataSet'
      object Load1: TMenuItem
        Caption = 'Load'
        OnClick = Load1Click
      end
    end
    object View1: TMenuItem
      Caption = '&View'
      object Delta1: TMenuItem
        Caption = 'Delta'
        OnClick = Delta1Click
      end
      object TableLoading1: TMenuItem
        Caption = 'View Table Loading'
        Checked = True
        OnClick = TableLoading1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object VisitwwwDephiDevelperDayscom1: TMenuItem
        Caption = 'Visit www.DephiDevelperDays.com'
        OnClick = VisitwwwDephiDevelperDayscom1Click
      end
      object VisitwwwJensenDataSystemscom1: TMenuItem
        Caption = 'Visit www.JensenDataSystems.com'
        OnClick = VisitwwwJensenDataSystemscom1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'Paradox Tables (*.db)|*.db|dBase Tables (*.dbf)|*.dbf|Local Data' +
      'base Tables (*.db, *.dbf)|*.db;*.dbf|All Files (*.*)|*.*'
    Left = 277
    Top = 116
  end
end

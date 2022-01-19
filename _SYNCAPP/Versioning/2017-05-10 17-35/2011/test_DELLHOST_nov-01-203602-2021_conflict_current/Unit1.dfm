object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 300
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = SQLConnectionAfterConnect
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 32
    Top = 48
    Width = 417
    Height = 252
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 32
    Top = 17
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 1
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'DEVART SQLITE'
    DriverName = 'DevartSQLite'
    GetDriverFunc = 'getSQLDriverSQLite'
    LibraryName = 'dbexpsqlite.dll'
    LoginPrompt = False
    Params.Strings = (
      'BlobSize=-1'
      'DataBase='
      'DriverName=DevartSQLite'
      'ASCIIDataBase=False'
      'BusyTimeout=0'
      'EnableSharedCache=False'
      'EncryptionKey='
      'FetchAll=True'
      'UseUnicode=True')
    VendorLib = 'dbexpsqlite.dll'
    AfterConnect = SQLConnectionAfterConnect
    Left = 376
    Top = 96
  end
  object DataSource1: TDataSource
    DataSet = SimpleDataSet1
    Left = 136
    Top = 80
  end
  object SimpleDataSet1: TSimpleDataSet
    Aggregates = <>
    Connection = SQLConnection1
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 248
    Top = 80
  end
end

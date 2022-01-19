object Form1: TForm1
  Left = 327
  Top = 185
  Width = 801
  Height = 401
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 106
  TextHeight = 13
  object Label1: TLabel
    Left = 88
    Top = 248
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 88
    Top = 304
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object Button1: TButton
    Left = 0
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
  end
  object Button2: TButton
    Left = 0
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
  end
  object Button3: TButton
    Left = 0
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 2
  end
  object DBGrid1: TDBGrid
    Left = 112
    Top = 0
    Width = 657
    Height = 97
    DataSource = DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBEdit1: TDBEdit
    Left = 432
    Top = 240
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'E:\DEV\2010\test\'
    TableName = 'HD'
    TableType = ttParadox
    Left = 600
    Top = 480
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 576
    Top = 528
  end
end

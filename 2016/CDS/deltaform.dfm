object Form2: TForm2
  Left = 519
  Top = 264
  Width = 446
  Height = 267
  Caption = 'Delta'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 438
    Height = 240
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object DBNavigator3: TDBNavigator
      Left = 0
      Top = 0
      Width = 438
      Height = 30
      DataSource = DataSource1
      Align = alTop
      TabOrder = 0
    end
    object DBGrid3: TDBGrid
      Left = 0
      Top = 30
      Width = 438
      Height = 210
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
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 123
    Top = 104
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 50
    Top = 104
  end
end

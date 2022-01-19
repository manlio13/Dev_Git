object Form1: TForm1
  Left = 800
  Top = 291
  Caption = 'DATI v: 6'
  ClientHeight = 215
  ClientWidth = 186
  Color = clSkyBlue
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
    Left = 16
    Top = 8
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '   MG          KN          L/h'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '%Mot      Ore        Litri'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 16
    Top = 24
    Width = 41
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 72
    Top = 24
    Width = 41
    Height = 21
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 128
    Top = 24
    Width = 41
    Height = 21
    TabOrder = 2
  end
  object Edit4: TEdit
    Left = 65
    Top = 72
    Width = 49
    Height = 21
    TabOrder = 3
  end
  object Edit5: TEdit
    Left = 120
    Top = 72
    Width = 49
    Height = 21
    TabOrder = 4
  end
  object Button2: TButton
    Left = 120
    Top = 160
    Width = 49
    Height = 25
    Caption = 'Esci'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = Button2Click
  end
  object JvHTButton1: TJvHTButton
    Left = 17
    Top = 160
    Width = 49
    Height = 25
    Caption = 'Ripeti'
    TabOrder = 6
    OnClick = JvHTButton1Click
  end
  object Edit6: TEdit
    Left = 16
    Top = 72
    Width = 41
    Height = 21
    TabOrder = 7
  end
  object Button1: TButton
    Left = 72
    Top = 151
    Width = 41
    Height = 21
    Caption = '-0.5L/h'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 73
    Top = 178
    Width = 41
    Height = 21
    Caption = '+0.5L/h'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = Button3Click
  end
  object Edit7: TEdit
    Left = 31
    Top = 109
    Width = 123
    Height = 21
    TabOrder = 10
  end
end

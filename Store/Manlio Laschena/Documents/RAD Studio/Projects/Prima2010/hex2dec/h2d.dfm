object Form1: TForm1
  Left = 722
  Top = 194
  Width = 309
  Height = 170
  Caption = 'convertitore di cdr'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 16
    Width = 18
    Height = 13
    Caption = 'dec'
  end
  object Label2: TLabel
    Left = 13
    Top = 48
    Width = 17
    Height = 13
    Caption = 'hex'
  end
  object Label3: TLabel
    Left = 8
    Top = 126
    Width = 203
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'premettere $ ai numeri hexagesimali'
  end
  object Button1: TButton
    Left = 72
    Top = 88
    Width = 75
    Height = 25
    Caption = 'converti'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 48
    Top = 12
    Width = 221
    Height = 21
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 48
    Top = 48
    Width = 225
    Height = 21
    TabOrder = 2
  end
  object Button2: TButton
    Left = 164
    Top = 88
    Width = 75
    Height = 25
    Caption = 'reset'
    TabOrder = 3
    OnClick = Button2Click
  end
end

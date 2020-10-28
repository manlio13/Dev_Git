object Form1: TForm1
  Left = 192
  Top = 112
  Width = 795
  Height = 363
  BorderIcons = [biSystemMenu]
  Caption = 'Emulatore del registro'
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
    Left = 28
    Top = 36
    Width = 124
    Height = 13
    Caption = 'HKEY_LOCAL_MACHINE'
  end
  object Label2: TLabel
    Left = 92
    Top = 56
    Width = 61
    Height = 13
    Caption = 'SOFTWARE'
  end
  object Label3: TLabel
    Left = 388
    Top = 52
    Width = 120
    Height = 13
    Caption = 'HKEY_CLASSES_ROOT'
  end
  object Label4: TLabel
    Left = 644
    Top = 116
    Width = 42
    Height = 13
    Caption = 'cod prod'
  end
  object Label5: TLabel
    Left = 708
    Top = 168
    Width = 23
    Height = 13
    Caption = 'CDR'
  end
  object Label6: TLabel
    Left = 180
    Top = 172
    Width = 52
    Height = 13
    Caption = 'programma'
  end
  object Label7: TLabel
    Left = 180
    Top = 204
    Width = 39
    Height = 13
    Caption = 'edizione'
  end
  object Label8: TLabel
    Left = 180
    Top = 232
    Width = 50
    Height = 13
    Caption = 'cod.di reg.'
  end
  object Button1: TButton
    Left = 76
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Leggi'
    TabOrder = 0
    OnClick = Button1Click
  end
  object edit1: TEdit
    Left = 140
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edit2: TEdit
    Left = 196
    Top = 108
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edit3: TEdit
    Left = 244
    Top = 164
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object edit4: TEdit
    Left = 244
    Top = 196
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object Button2: TButton
    Left = 76
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Scrivi'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Edit5: TEdit
    Left = 244
    Top = 228
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object Edit6: TEdit
    Left = 432
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object Edit7: TEdit
    Left = 488
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 8
  end
  object Edit8: TEdit
    Left = 564
    Top = 164
    Width = 121
    Height = 21
    TabOrder = 9
  end
  object Edit9: TEdit
    Left = 564
    Top = 196
    Width = 121
    Height = 21
    TabOrder = 10
  end
  object Button3: TButton
    Left = 456
    Top = 164
    Width = 75
    Height = 25
    Caption = 'Leggi'
    TabOrder = 11
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 456
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Scrivi'
    TabOrder = 12
    OnClick = Button4Click
  end
end

object Form1: TForm1
  Left = 740
  Top = 415
  BorderIcons = [biSystemMenu]
  Caption = 'Form1'
  ClientHeight = 197
  ClientWidth = 504
  Color = clCream
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
    Left = 30
    Top = 0
    Width = 47
    Height = 13
    Caption = 'Extension'
  end
  object Label2: TLabel
    Left = 30
    Top = 45
    Width = 58
    Height = 13
    Caption = 'Source Path'
  end
  object Label3: TLabel
    Left = 30
    Top = 89
    Width = 57
    Height = 13
    Caption = 'Target Path'
  end
  object Edit1: TEdit
    Left = 30
    Top = 19
    Width = 60
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 30
    Top = 63
    Width = 417
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 446
    Top = 62
    Width = 38
    Height = 23
    Caption = '...'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit3: TEdit
    Left = 30
    Top = 108
    Width = 417
    Height = 21
    TabOrder = 3
  end
  object Button2: TButton
    Left = 446
    Top = 108
    Width = 38
    Height = 23
    Caption = '...'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 30
    Top = 152
    Width = 69
    Height = 24
    Caption = 'Exit'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 141
    Top = 152
    Width = 70
    Height = 24
    Caption = 'WriteINI'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 253
    Top = 152
    Width = 69
    Height = 24
    Caption = 'Resume'
    TabOrder = 7
    OnClick = Button5Click
  end
end

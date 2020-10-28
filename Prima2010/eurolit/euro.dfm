object EuroLit: TEuroLit
  Left = 623
  Top = 117
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'EuroLit'
  ClientHeight = 113
  ClientWidth = 184
  Color = clSkyBlue
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001002010100000000000A80100001600000028000000200000002000
    0000010004000000000040010000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00EEDD
    DDFDDFFDDFFDDDDEEEEEEEEEEEEEEEFDDFFDFDFDFDFFDDFEEEEEEEEEEEEEEEFF
    DDFDFDFDFDFFFDDEEEEEEEEEEEEEEEFFFDFDFDFDFDFFFFDEEEEEEEEEEEEEEEFD
    DDFFDDFFDDFFDDDEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE4CEE
    EEE4CE444444ECCCCCCCCCCCCCCE4CEEEEE4CE4CEEEEEEEEEEEEEEEEEEEE4CEE
    EEE4CE4CEEE99EEE999E99EEE9EE4CEEEEE4CE4CEE9EE9E9EEE9E9EE9EEE4CEE
    EEE4CE4CEEEE9EE9EEE9E9EE9EEE4CEE4EE4CE4CEEE9EEE9EEE9E9EE9EEE4CEC
    ECE4CE4CEE9EE9E9EEE9E9EE9EEE4CC4E4C4CE4CEEE99EEE999EE99E99EE4C4E
    EE44CE4CEEEEEEEEEEEEE9EE9EEE4CEEEEE4CE4CEEEEEEEEEEEEE9EE9EEE0000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 16
    Top = 22
    Width = 78
    Height = 13
    Caption = 'Da convertire'
    Color = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 18
    Top = 62
    Width = 59
    Height = 13
    Caption = 'Convertito'
    Color = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBackground
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 104
    Top = 18
    Width = 73
    Height = 22
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 104
    Top = 56
    Width = 75
    Height = 22
    TabOrder = 1
  end
  object Button1: TButton
    Left = 18
    Top = 90
    Width = 45
    Height = 15
    Caption = '&Lire ?'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 74
    Top = 90
    Width = 45
    Height = 15
    Caption = '&Euro ?'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 132
    Top = 90
    Width = 45
    Height = 15
    Caption = '&nuovo'
    TabOrder = 4
    OnClick = Button3Click
  end
end

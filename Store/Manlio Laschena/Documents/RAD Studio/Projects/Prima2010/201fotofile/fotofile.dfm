object Form1: TForm1
  Left = 447
  Top = 128
  Hint = 'MLSoft -2002- Ed.1.0'
  HelpContext = 5
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsSingle
  Caption = ' Nome a Data - Name to Date'
  ClientHeight = 168
  ClientWidth = 257
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  HelpFile = 'd2t.hlp'
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
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 71
    Width = 42
    Height = 13
    Caption = 'Directory'
  end
  object Label2: TLabel
    Left = 20
    Top = 134
    Width = 67
    Height = 13
    Caption = 'New file name'
  end
  object Label3: TLabel
    Left = 20
    Top = 113
    Width = 63
    Height = 13
    Caption = 'Creation date'
  end
  object Label4: TLabel
    Left = 20
    Top = 92
    Width = 51
    Height = 13
    Caption = 'File name :'
  end
  object Label5: TLabel
    Left = 122
    Top = 52
    Width = 3
    Height = 13
  end
  object Label6: TLabel
    Left = 20
    Top = 52
    Width = 71
    Height = 13
    Caption = 'Files to rename'
  end
  object Label7: TLabel
    Left = 80
    Top = 70
    Width = 3
    Height = 13
  end
  object Label8: TLabel
    Left = 122
    Top = 92
    Width = 3
    Height = 13
  end
  object Label9: TLabel
    Left = 104
    Top = 114
    Width = 3
    Height = 13
  end
  object Label10: TLabel
    Left = 94
    Top = 134
    Width = 3
    Height = 13
  end
  object apri: TButton
    Left = 18
    Top = 8
    Width = 197
    Height = 21
    Caption = 'Scegli la cartella - Chose directory'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = apriClick
  end
  object OpenDialog1: TOpenDialog
    Left = 188
    Top = 34
  end
end

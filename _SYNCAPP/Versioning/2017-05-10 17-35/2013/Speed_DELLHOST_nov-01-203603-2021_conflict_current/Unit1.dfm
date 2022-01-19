object Form1: TForm1
  Left = 0
  Top = 0
  Hint = 'MLSoft'
  BiDiMode = bdLeftToRight
  BorderStyle = bsDialog
  Caption = 'Speed 2'
  ClientHeight = 154
  ClientWidth = 365
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 36
    Top = 10
    Width = 303
    Height = 13
    Caption = 
      'T.Start                         TRIP                            ' +
      'ETA                  GG'
  end
  object Label2: TLabel
    Left = 36
    Top = 72
    Width = 307
    Height = 13
    Caption = 
      'Now                  Miles               MTT             TTT    ' +
      '            Speed   '
  end
  object Label3: TLabel
    Left = 305
    Top = 35
    Width = 8
    Height = 13
    Caption = '+'
  end
  object Edit1: TEdit
    Left = 16
    Top = 32
    Width = 73
    Height = 21
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 117
    Top = 32
    Width = 81
    Height = 21
    TabOrder = 1
    OnKeyPress = Edit2KeyPress
  end
  object Edit3: TEdit
    Left = 219
    Top = 32
    Width = 82
    Height = 21
    TabOrder = 2
  end
  object Edit4: TEdit
    Left = 16
    Top = 91
    Width = 65
    Height = 21
    TabOrder = 3
    OnKeyPress = Edit4KeyPress
  end
  object Edit5: TEdit
    Left = 103
    Top = 91
    Width = 42
    Height = 21
    TabOrder = 4
    OnKeyPress = Edit5KeyPress
  end
  object Edit6: TEdit
    Left = 167
    Top = 91
    Width = 42
    Height = 21
    TabOrder = 5
  end
  object Edit7: TEdit
    Left = 303
    Top = 91
    Width = 36
    Height = 21
    TabOrder = 6
    OnKeyPress = Edit7KeyPress
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 118
    Width = 113
    Height = 17
    Caption = 'Ora del sistema'
    Checked = True
    State = cbChecked
    TabOrder = 7
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 304
    Top = 118
    Width = 97
    Height = 17
    Caption = 'Media'
    Checked = True
    State = cbChecked
    TabOrder = 8
    OnClick = CheckBox2Click
  end
  object Edit8: TEdit
    Left = 319
    Top = 32
    Width = 26
    Height = 21
    TabOrder = 9
  end
  object Edit9: TEdit
    Left = 231
    Top = 91
    Width = 41
    Height = 21
    TabOrder = 10
  end
  object Button1: TButton
    Left = 167
    Top = 118
    Width = 49
    Height = 17
    Caption = 'reset'
    TabOrder = 11
    OnClick = Button1Click
  end
end

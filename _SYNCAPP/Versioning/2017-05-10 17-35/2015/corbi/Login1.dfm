object Form1: TForm1
  Left = 1150
  Top = 288
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Login'
  ClientHeight = 62
  ClientWidth = 250
  Color = clYellow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 138
    Top = 19
    Width = 103
    Height = 26
    Caption = 'Digitare la password  e premere Enter'
    WordWrap = True
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
end

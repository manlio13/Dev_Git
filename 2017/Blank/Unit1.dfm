object Form1: TForm1
  Left = 820
  Top = 498
  BorderIcons = [biSystemMenu]
  Caption = '           Inserisci la password'
  ClientHeight = 58
  ClientWidth = 197
  Color = clBtnFace
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
  object Edit1: TEdit
    Left = 32
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
end

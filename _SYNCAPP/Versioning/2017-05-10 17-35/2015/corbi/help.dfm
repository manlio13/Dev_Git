object Form7: TForm7
  Left = 420
  Top = 208
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Form7'
  ClientHeight = 130
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object mmo1: TMemo
    Left = 0
    Top = 0
    Width = 321
    Height = 129
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      '                  Procedura di iscrizione:'
      '1) Fornire il codice della Gara'
      '2) Scegliere se iscrizione Automatica o Manuale'
      '3) Se Automatica scegliere il Gruppo'
      '4) Se Manuale fornire la Disciplina'
      '5) Scegliere l'#39'Atleta')
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 269
    Top = 95
    Width = 41
    Height = 25
    Caption = 'Fatto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
end

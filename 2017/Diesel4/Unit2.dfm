object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 
    '                                                                ' +
    '                                   Log of Data Entry'
  ClientHeight = 330
  ClientWidth = 840
  Color = clYellow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 106
  TextHeight = 14
  object Label1: TLabel
    Left = 8
    Top = 289
    Width = 712
    Height = 35
    Margins.Top = 1
    Margins.Bottom = 1
    AutoSize = False
    Caption = 
      '   LtrTUp =Lt from Last TopUp ; PartFill=partial ; LFCons=rate o' +
      'f Cons Btw Topups ; HrsCalc = Hrs of LFCons calculation ; '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object DBGrid1: TDBGrid
    Left = 9
    Top = 9
    Width = 819
    Height = 276
    Color = clBtnFace
    DataSource = Form1.DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 748
    Top = 295
    Width = 80
    Height = 27
    Caption = 'close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
end

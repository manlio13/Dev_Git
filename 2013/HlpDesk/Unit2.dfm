object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Memo Editor           Ctrl+D for TimeStamp'
  ClientHeight = 310
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DBRichEdit1: TDBRichEdit
    Left = 0
    Top = 0
    Width = 545
    Height = 313
    DataField = 'More'
    DataSource = Form1.DataSource1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    HideScrollBars = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnKeyUp = DBRichEdit1KeyUP
    OnMouseUp = DBRichEdit1MouseUp
  end
end

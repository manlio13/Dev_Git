object Form1: TForm1
  Left = 192
  Top = 107
  Width = 640
  Height = 496
  Caption = 'Monitoring c:\'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 84
    Height = 13
    Caption = 'Number of events'
  end
  object Edit1: TEdit
    Left = 8
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object ListBox1: TListBox
    Left = 152
    Top = 0
    Width = 480
    Height = 469
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 2
    OnClick = Button1Click
  end
  object DirMonitor1: TDirMonitor
    Directory = 'c:\'
    WatchSubtree = True
    FilterNotification = [nfFILE_NAME, nfDIR_NAME]
    FilterAction = [faADDED, faREMOVED, faMODIFIED, faRENAMED_OLD_NAME, faRENAMED_NEW_NAME]
    OnChange = DirMonitor1Change
    Active = True
    Left = 168
    Top = 16
  end
end

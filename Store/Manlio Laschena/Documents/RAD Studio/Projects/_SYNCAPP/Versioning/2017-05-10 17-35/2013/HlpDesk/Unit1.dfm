object Form1: TForm1
  Left = 549
  Top = 463
  Hint = 'MLSoft 2013'
  HelpContext = 10
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'HelpDesk 2.3'
  ClientHeight = 355
  ClientWidth = 870
  Color = clYellow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  HelpFile = '.\helpdesk.chm'
  OldCreateOrder = False
  Position = poDesigned
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    870
    355)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 221
    Width = 61
    Height = 13
    Caption = 'filtering date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 136
    Top = 221
    Width = 63
    Height = 13
    Caption = 'filtering what'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape1: TShape
    Left = 94
    Top = 240
    Width = 14
    Height = 12
    Brush.Color = clLime
    Shape = stCircle
  end
  object Shape2: TShape
    Left = 266
    Top = 240
    Width = 14
    Height = 12
    Brush.Color = clLime
    Shape = stCircle
  end
  object Shape3: TShape
    Left = 712
    Top = 296
    Width = 9
    Height = 16
    Brush.Color = clLime
    Shape = stCircle
  end
  object Shape4: TShape
    Left = 800
    Top = 296
    Width = 25
    Height = 9
    Brush.Color = clLime
    Shape = stCircle
  end
  object Shape5: TShape
    Left = 366
    Top = 240
    Width = 14
    Height = 12
    Brush.Color = clLime
    Shape = stCircle
  end
  object Label3: TLabel
    Left = 268
    Top = 198
    Width = 109
    Height = 26
    Caption = 'Field filtering  done on AND configuration'
    WordWrap = True
  end
  object Label4: TLabel
    Left = 631
    Top = 178
    Width = 174
    Height = 13
    Caption = ' Double click to fill Status or/and Tag'
  end
  object Label5: TLabel
    Left = 409
    Top = 189
    Width = 156
    Height = 14
    Caption = 'Date ticket setting board'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Shape6: TShape
    Left = 571
    Top = 193
    Width = 25
    Height = 9
    Brush.Color = clLime
    Shape = stCircle
  end
  object Bevel1: TBevel
    Left = 385
    Top = 182
    Width = 238
    Height = 168
    Style = bsRaised
  end
  object Label6: TLabel
    Left = 187
    Top = 323
    Width = 72
    Height = 13
    Caption = ' f1 to get  Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 22
    Top = 4
    Width = 838
    Height = 168
    Hint = 'press Enter after entry'
    Anchors = []
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnKeyPress = DBGrid1KeyPress
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Filed'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'when'
        Title.Caption = 'Time'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'What'
        Width = 451
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'More'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Status'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tag'
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Num'
        Title.Caption = 'code'
        Width = 73
        Visible = True
      end>
  end
  object DBGrid3: TDBGrid
    Left = 727
    Top = 196
    Width = 90
    Height = 94
    DataSource = DataSource3
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid3DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'tag'
        Title.Caption = 'Tag'
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 186
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 2
  end
  object Button1: TButton
    Left = 633
    Top = 296
    Width = 75
    Height = 19
    Hint = 'Selected record'
    Caption = 'filter selected'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 727
    Top = 296
    Width = 75
    Height = 19
    Hint = 'Selected record'
    Caption = 'filter selected'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 285
    Top = 238
    Width = 75
    Height = 25
    Caption = 'Run Filter'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 275
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Clear Filter'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Edit1: TEdit
    Left = 7
    Top = 240
    Width = 81
    Height = 21
    TabOrder = 7
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 112
    Top = 240
    Width = 150
    Height = 21
    TabOrder = 8
    OnChange = Edit2Change
  end
  object Edit3: TEdit
    Left = 54
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 9
    Visible = False
  end
  object Edit4: TEdit
    Left = 200
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 10
    Visible = False
  end
  object Button5: TButton
    Left = 11
    Top = 280
    Width = 75
    Height = 25
    Hint = 'Selected record'
    Caption = 'Delete record'
    TabOrder = 11
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 187
    Top = 280
    Width = 75
    Height = 25
    Hint = 'With Outlook'
    Caption = 'Send email'
    TabOrder = 12
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 99
    Top = 280
    Width = 75
    Height = 25
    Hint = 'From Outlook'
    Caption = 'Contacts'
    TabOrder = 13
    OnClick = Button7Click
  end
  object DBGrid4: TDBGrid
    Left = 402
    Top = 212
    Width = 206
    Height = 94
    DataSource = DataSource4
    TabOrder = 14
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid4CellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'taskdate'
        Title.Caption = 'Date'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'todo'
        Title.Caption = 'set'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'num'
        Title.Caption = 'code'
        Width = 69
        Visible = True
      end>
  end
  object Button8: TButton
    Left = 402
    Top = 312
    Width = 39
    Height = 25
    Hint = 'Date for action'
    Caption = 'SetDate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 448
    Top = 312
    Width = 36
    Height = 25
    Hint = 'Clear Date'
    Caption = 'Reset'
    TabOrder = 16
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 491
    Top = 312
    Width = 36
    Height = 25
    Hint = 'Show all date set'
    Caption = 'Filter'
    TabOrder = 17
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 534
    Top = 312
    Width = 36
    Height = 25
    Hint = 'Reset Filter'
    Caption = 'Clear'
    TabOrder = 18
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 577
    Top = 312
    Width = 34
    Height = 25
    Hint = 'On master record'
    Caption = 'Action'
    TabOrder = 19
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 634
    Top = 324
    Width = 75
    Height = 20
    Caption = 'Delete selected'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 20
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 727
    Top = 322
    Width = 75
    Height = 20
    Caption = 'Delete selected'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 21
    OnClick = Button14Click
  end
  object Memo1: TMemo
    Left = 80
    Top = 48
    Width = 745
    Height = 50
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 22
    Visible = False
    WordWrap = False
  end
  object Button15: TButton
    Left = 11
    Top = 317
    Width = 75
    Height = 25
    Hint = 'of selected record'
    Caption = 'Report'
    TabOrder = 23
    OnClick = Button15Click
  end
  object Button16: TButton
    Left = 99
    Top = 317
    Width = 75
    Height = 25
    Hint = 'On default Printer'
    Caption = 'Print'
    TabOrder = 24
    OnClick = Button16Click
  end
  object DBGrid2: TDBGrid
    Left = 629
    Top = 196
    Width = 83
    Height = 94
    DataSource = DataSource2
    TabOrder = 25
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Status'
        Visible = True
      end>
  end
  object Button17: TButton
    Left = 275
    Top = 317
    Width = 75
    Height = 25
    Caption = 'Done'
    TabOrder = 26
    OnClick = Button17Click
  end
  object Button18: TButton
    Left = 812
    Top = 311
    Width = 48
    Height = 36
    Caption = 'Reset  All'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 27
    WordWrap = True
    OnClick = Button18Click
  end
  object ABSTable1: TABSTable
    CurrentVersion = '7.30 '
    DatabaseName = 'HelpDesk'
    InMemory = False
    ReadOnly = False
    BeforeInsert = ABSTable1BeforeInsert
    AfterInsert = ABSTable1AfterInsert
    BeforePost = ABSTable1BeforePost
    AfterPost = ABSTable1AfterPost
    BeforeDelete = ABSTable1BeforeDelete
    AfterDelete = ABSTable1AfterDelete
    OnNewRecord = ABSTable1NewRecord
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'indice01'
        Fields = 'Filed;What'
        Options = [ixPrimary]
      end>
    IndexName = 'indice01'
    FieldDefs = <
      item
        Name = 'Filed'
        Attributes = [faRequired]
        DataType = ftTimeStamp
      end
      item
        Name = 'when'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'What'
        Attributes = [faRequired]
        DataType = ftString
        Size = 70
      end
      item
        Name = 'More'
        DataType = ftMemo
      end
      item
        Name = 'Status'
        Attributes = [faRequired]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Tag'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Num'
        DataType = ftLargeint
      end>
    TableName = 'HD1'
    Exclusive = False
    Left = 544
    Top = 104
  end
  object ABSTable2: TABSTable
    CurrentVersion = '7.30 '
    DatabaseName = 'HelpDesk'
    InMemory = False
    ReadOnly = False
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'indice02'
        Fields = 'Status'
        Options = [ixPrimary]
      end>
    IndexName = 'indice02'
    FieldDefs = <
      item
        Name = 'Status'
        Attributes = [faRequired]
        DataType = ftString
        Size = 15
      end>
    TableName = 'How'
    Exclusive = False
    Left = 600
    Top = 104
  end
  object ABSDatabase1: TABSDatabase
    CurrentVersion = '7.30 '
    DatabaseFileName = 'ABSDatabase1'
    DatabaseName = 'HelpDesk'
    Exclusive = False
    MaxConnections = 500
    MultiUser = False
    SessionName = 'Default'
    Left = 544
    Top = 56
  end
  object ABSTable3: TABSTable
    CurrentVersion = '7.30 '
    DatabaseName = 'HelpDesk'
    InMemory = False
    ReadOnly = False
    StoreDefs = True
    IndexName = 'indice03'
    FieldDefs = <
      item
        Name = 'tag'
        DataType = ftString
        Size = 15
      end>
    TableName = 'tag1'
    Exclusive = False
    Left = 656
    Top = 104
  end
  object DataSource1: TDataSource
    DataSet = ABSTable1
    Left = 376
    Top = 80
  end
  object DataSource2: TDataSource
    DataSet = ABSTable2
    Left = 440
    Top = 80
  end
  object DataSource3: TDataSource
    DataSet = ABSTable3
    Left = 488
    Top = 80
  end
  object ABSTable4: TABSTable
    CurrentVersion = '7.30 '
    DatabaseName = 'HelpDesk'
    InMemory = False
    ReadOnly = False
    StoreDefs = True
    IndexName = 'indice04'
    FieldDefs = <
      item
        Name = 'taskdate'
        DataType = ftDate
      end
      item
        Name = 'todo'
        DataType = ftBoolean
      end
      item
        Name = 'num'
        DataType = ftInteger
      end>
    TableName = 'ticket'
    Exclusive = False
    Left = 648
    Top = 64
  end
  object DataSource4: TDataSource
    DataSet = ABSTable4
    Left = 480
    Top = 120
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 736
    Top = 128
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer2Timer
    Left = 728
    Top = 83
  end
  object PrintDialog1: TPrintDialog
    Left = 288
    Top = 56
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 328
    Top = 56
  end
end

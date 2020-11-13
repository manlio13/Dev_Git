object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Anagrafica Atleti'
  ClientHeight = 351
  ClientWidth = 890
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 248
    Width = 57
    Height = 14
    AutoSize = False
    Caption = '   Nome'
    Color = clCream
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 240
    Top = 248
    Width = 81
    Height = 14
    AutoSize = False
    Caption = '   Cognome'
    Color = clCream
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label3: TLabel
    Left = 416
    Top = 270
    Width = 329
    Height = 43
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'La ricerca con i campi:  NOME e/o COGNOME,   pu'#242' essere effettua' +
      'ta  anche  inserendo,  per  ognuno'#13#10' di  essi,  solo una o  pi'#249' ' +
      ' lettere consecutive'
    Color = clAqua
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    WordWrap = True
  end
  object Button1: TButton
    Left = 781
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Esci'
    TabOrder = 0
    OnClick = Button1Click
  end
  object dbgrd1: TDBGrid
    Left = 7
    Top = 8
    Width = 873
    Height = 225
    DataSource = ds1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODATL'
        ReadOnly = True
        Width = 43
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COGNOME'
        Width = 105
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_NASCITA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TLF'
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VIA_N'
        Width = 205
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CITTA'#39
        Width = 138
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAP'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NAZIONE'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT'
        Width = 26
        Visible = True
      end>
  end
  object dbnvgr1: TDBNavigator
    Left = 472
    Top = 239
    Width = 240
    Height = 25
    DataSource = ds1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = dbnvgr1Click
  end
  object Button2: TButton
    Left = 32
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Cerca'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 113
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Annulla'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 194
    Top = 304
    Width = 120
    Height = 25
    Caption = 'Mostra/Stampa'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Edit1: TEdit
    Left = 32
    Top = 264
    Width = 153
    Height = 21
    TabOrder = 6
  end
  object Edit2: TEdit
    Left = 200
    Top = 264
    Width = 195
    Height = 21
    TabOrder = 7
  end
  object Button5: TButton
    Left = 320
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Azzera'
    TabOrder = 8
    OnClick = Button5Click
  end
  object ABSQuery1: TABSQuery
    CurrentVersion = '7.60 '
    DatabaseName = 'corbi.abs'
    InMemory = False
    ReadOnly = False
    Left = 784
    Top = 240
  end
  object ds1: TDataSource
    DataSet = Form2.ABSTable2
    OnDataChange = ds1DataChange
    Left = 720
    Top = 160
  end
end

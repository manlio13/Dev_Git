object Form10: TForm10
  Left = 980
  Top = 21
  BorderIcons = []
  Caption = 'Inserimento Dati Mancanti'
  ClientHeight = 158
  ClientWidth = 329
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 19
    Top = 82
    Width = 285
    Height = 32
    Caption = 
      'Inserire il dato nella casella (Si/No x Manl)       e cliccare s' +
      'ul pulsante corrispondente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 19
    Top = 10
    Width = 289
    Height = 39
    AutoSize = False
    Caption = 
      'Da utilizzare per l'#39'inserimento dei dati mancanti relativi alla ' +
      'Categoria o al Numero di Pettorale o al numero di Posizione.    ' +
      'Pu'#242' essere inserito un dato per volta.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Edit1: TEdit
    Left = 128
    Top = 55
    Width = 49
    Height = 21
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 120
    Width = 41
    Height = 25
    Caption = 'CAT'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 73
    Top = 120
    Width = 41
    Height = 25
    Caption = 'PET'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 138
    Top = 120
    Width = 41
    Height = 25
    Caption = 'POS'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 267
    Top = 120
    Width = 41
    Height = 25
    Caption = 'Esci'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 202
    Top = 120
    Width = 41
    Height = 25
    Caption = 'MANL'
    TabOrder = 5
    OnClick = Button5Click
  end
end

object Form2: TForm2
  Left = 0
  Top = 0
  Hint = 'MLSoft 2020'
  Caption = 'Grid'
  ClientHeight = 215
  ClientWidth = 766
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 101
  TextHeight = 14
  object DBNavigator1: TDBNavigator
    Left = 266
    Top = 172
    Width = 250
    Height = 27
    DataSource = Form1.DataSource1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 766
    Height = 156
    DataSource = Form1.DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Title'
        Width = 361
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Author'
        Width = 232
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Column'
        Width = 43
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Row'
        Width = 39
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 550
    Top = 172
    Width = 81
    Height = 27
    Caption = 'Done'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Lucida Sans'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 661
    Top = 172
    Width = 81
    Height = 27
    Caption = 'Exit'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Lucida Sans'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 24
    Top = 172
    Width = 80
    Height = 27
    Caption = 'Edit'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Lucida Sans'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button3Click
  end
end

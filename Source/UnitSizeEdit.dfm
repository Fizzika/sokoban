object FormSizeEdit: TFormSizeEdit
  Left = 866
  Top = 271
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1099#1073#1086#1088' '#1088#1072#1079#1084#1077#1088#1072
  ClientHeight = 140
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object LabelWidth: TLabel
    Left = 32
    Top = 32
    Width = 66
    Height = 20
    Caption = #1064#1080#1088#1080#1085#1072': '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelHeight: TLabel
    Left = 32
    Top = 72
    Width = 65
    Height = 20
    Caption = #1042#1099#1089#1086#1090#1072': '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object EditWidth: TEdit
    Left = 136
    Top = 24
    Width = 121
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = EditHeightChange
    OnKeyPress = EditKeyPress
  end
  object EditHeight: TEdit
    Left = 136
    Top = 64
    Width = 121
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = EditHeightChange
    OnKeyPress = EditKeyPress
  end
  object ButtonOK: TButton
    Left = 112
    Top = 104
    Width = 75
    Height = 25
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = ButtonOKClick
  end
end

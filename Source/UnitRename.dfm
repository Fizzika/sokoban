object FormRename: TFormRename
  Left = 737
  Top = 528
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Edit'
  ClientHeight = 87
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object EditName: TEdit
    Left = 40
    Top = 8
    Width = 169
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = EditNameChange
    OnKeyPress = EditNameKeyPress
  end
  object ButtonOK: TButton
    Left = 56
    Top = 48
    Width = 137
    Height = 25
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = ButtonOKClick
  end
end

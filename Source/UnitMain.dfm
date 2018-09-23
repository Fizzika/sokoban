object FormGame: TFormGame
  Left = 304
  Top = 125
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 887
  ClientWidth = 1214
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  OnPaint = FormPaint
  PixelsPerInch = 120
  TextHeight = 16
  object DrawSoko: TDrawGrid
    Left = 0
    Top = 0
    Width = 1873
    Height = 953
    BorderStyle = bsNone
    Ctl3D = True
    DefaultRowHeight = 64
    DefaultDrawing = False
    Enabled = False
    FixedCols = 0
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine]
    ParentCtl3D = False
    TabOrder = 0
  end
  object MainMenu: TMainMenu
    Left = 680
    object NGame: TMenuItem
      Caption = #1048#1075#1088#1072
      object NLoad: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
        OnClick = NLoadClick
      end
      object NExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076' [Q]'
        OnClick = NExitClick
      end
    end
    object NDo: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1077
      object NCancelMove: TMenuItem
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1093#1086#1076' [U]'
        OnClick = NCancelMoveClick
      end
      object N3: TMenuItem
        Caption = #1055#1077#1088#1077#1079#1072#1087#1091#1089#1090#1080#1090#1100' '#1091#1088#1086#1074#1085#1100' [R]'
      end
    end
    object NHelp: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
    end
  end
end

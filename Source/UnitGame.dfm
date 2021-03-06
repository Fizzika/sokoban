object FormGame: TFormGame
  Left = 478
  Top = 203
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 545
  ClientWidth = 1078
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
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
    Color = clBtnFace
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
      object NExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076' [Q]'
        OnClick = NExitClick
      end
      object NPause: TMenuItem
        Caption = #1055#1072#1091#1079#1072' [P]'
        OnClick = NPauseClick
      end
    end
    object NDo: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1077
      object NCancelMove: TMenuItem
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1093#1086#1076' [U]'
        OnClick = NCancelMoveClick
      end
      object NGameRestart: TMenuItem
        Caption = #1055#1077#1088#1077#1079#1072#1087#1091#1089#1090#1080#1090#1100' '#1091#1088#1086#1074#1085#1100' [R]'
        OnClick = NGameRestartClick
      end
    end
    object NHelp: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
    end
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 720
  end
end

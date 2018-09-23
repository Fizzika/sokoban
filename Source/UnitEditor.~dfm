object FormEditor: TFormEditor
  Left = 455
  Top = 238
  BorderStyle = bsSingle
  Caption = 'Level Editor'
  ClientHeight = 603
  ClientWidth = 1287
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 120
  TextHeight = 16
  object GridEdit: TDrawGrid
    Left = 0
    Top = 0
    Width = 921
    Height = 577
    BorderStyle = bsNone
    Color = clBtnFace
    ColCount = 8
    DefaultRowHeight = 64
    FixedCols = 0
    RowCount = 8
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    TabOrder = 0
    OnDrawCell = GridEditDrawCell
    OnKeyDown = GridEditKeyDown
  end
  object MainMenu: TMainMenu
    Left = 1256
    object NFile: TMenuItem
      Caption = 'File'
      object NLoad: TMenuItem
        Caption = 'Load level'
        OnClick = NLoadClick
      end
      object NSave: TMenuItem
        Caption = 'Save level'
        OnClick = NSaveClick
      end
    end
    object NNewLevel: TMenuItem
      Caption = 'New level'
      OnClick = NNewLevelClick
    end
  end
  object Timer: TTimer
    Interval = 500
    OnTimer = TimerTimer
    Left = 1256
    Top = 48
  end
end

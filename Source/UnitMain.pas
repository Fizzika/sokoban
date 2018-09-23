unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Menus, UnitSoko, StdCtrls, Buttons;

type
   // TODO: Name of level in the top
  TFormGame = class(TForm)
    MainMenu: TMainMenu;
    NGame: TMenuItem;
    NLoad: TMenuItem;
    DrawSoko: TDrawGrid;
    NHelp: TMenuItem;
    NDo: TMenuItem;
    NCancelMove: TMenuItem;
    N3: TMenuItem;
    NExit: TMenuItem;
    procedure NLoadClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RestoreMove;
    procedure NExitClick(Sender: TObject);
    procedure NCancelMoveClick(Sender: TObject);
    procedure DrawCaption;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure WMMoving(var Msg: TWMMoving); message WM_MOVING;
  end;

var
  FormGame: TFormGame;
  Map: TMap;
  IsMapLoaded: Boolean;
  X,Y: Integer; // Позиции игрока
  PoolCount: Integer; //Кол-во лунок
  Steps, Pushes: Integer;
  MoveStack: TMoveStackClass;
  //LevelName: string;

implementation

{$R *.dfm}

procedure TFormGame.NLoadClick(Sender: TObject);
var
   Path: string;
begin
   if GetInPath(Path, Self) then
   begin
      if GetMapInFile(Path, Map) then
      begin
         MakeBorder(Map, DrawSoko, FormGame);
         DrawGrid(DrawSoko, Map);
         GetVariables(Map, X, Y, PoolCount);
         IsMapLoaded := True;
         Steps := 0;
         Pushes := 0;
         DrawCaption;
      end;
   end;
end;

procedure TFormGame.FormActivate(Sender: TObject);
begin
   IsMapLoaded := False;
   Steps := 0;
   Pushes := 0;
end;

procedure DrawOrPool(aGrid: TDrawGrid; x,y: Integer);
{В зависимости от состояния игрока ставит на его пред. поле лунку или дорогу}
begin
   if Map[y,x] = CPlayerChar then
   begin
      Map[y,x] := CDrawChar;
      DrawCell(aGrid, x, y, CDrawPath);
   end
   else
   begin
      Map[y,x] := CPoolChar;
      DrawCell(aGrid, x, y, CPoolPath);
   end;
end;

procedure TFormGame.RestoreMove;
var
   Move: TMove;
   Path: string;
begin
   if MoveStack.pHead <> nil then
   begin
      Move := MoveStack.Pop;
      if MoveStack.pHead = nil then
         NCancelMove.Enabled := False;
      x := x - ord(Move.PlayerDX);
      y := y - ord(Move.PlayerDY);
      Map[y,x] := Move.Char1;
      Map[y + Ord(Move.PlayerDY), x + ord(Move.PlayerDX)] := Move.Char2;
      Map[y+2*Ord(Move.PlayerDY), x+2*Ord(Move.PlayerDX)] := Move.Char3;
      DrawPlayer(DrawSoko, x, y, Move.PlayerDX, Move.PlayerDY);
      Path := GetPathFromChar(Move.Char2);
      DrawCell(DrawSoko, x + ord(Move.PlayerDX), y + Ord(Move.PlayerDY), Path);
      Path := GetPathFromChar(Move.Char3);
      DrawCell(DrawSoko, x + 2*ord(Move.PlayerDX), y + 2*Ord(Move.PlayerDY), Path);
      if Move.IsPushedBox then
      begin
         Dec(Pushes);
         Dec(PoolCount, Move.PoolChange);
      end;
      Dec(Steps);
      DrawCaption;
   end;
end;

procedure TFormGame.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   dx: TDxMove;
   dy: TDyMove;
   Move: TMove;
begin
   if IsMapLoaded and InitilizeInput(Key, dx, dy) then
   begin
      if (Map[y+Ord(dy), x+Ord(dx)] = CDrawChar) or  // Переход на дорогу
         (Map[y+Ord(dy), x+Ord(dx)] = CPoolChar) then // Переход на лунку
      begin
         // Test features
         with Move do
         begin
            PlayerDX := dx;
            PlayerDY := dy;
            Char1 := Map[y,x];
            Char2 := Map[y + Ord(dy), x + ord(dx)];
            Char3 := Map[y+2*Ord(dy), x+2*Ord(dx)];
            IsPushedBox := False;
            PoolChange := 0;
         end;
         MoveStack.Push(Move);
         NCancelMove.Enabled := True;
         // End Test feature
         if (Map[y+Ord(dy), x+Ord(dx)] = CDrawChar) then //Перешли на дорогу
            Map[y+Ord(dy), x+Ord(dx)] := CPlayerChar
         else //Перешли на лунку
            Map[y+Ord(dy), x+Ord(dx)] := CPlayerInPoolChar;
         DrawOrPool(DrawSoko, x, y);
         x := x + Ord(dx);
         y := y + Ord(dy);
         Inc(Steps);
         //DrawCell(DrawSoko, x, y, CPlayerPath);
         DrawPlayer(DrawSoko, x, y, dx, dy);
      end
      else if ((Map[y+Ord(dy), x+Ord(dx)] = CBoxChar) or
      (Map[y+Ord(dy), x+Ord(dx)] = CBoxInPoolChar)) and
      ((Map[y+2*Ord(dy), x+2*Ord(dx)] = CDrawChar) or
      (Map[y+2*Ord(dy), x+2*Ord(dx)] = CPoolChar)) then // Двигаем коробку
      begin
         // Test features
         with Move do
         begin
            PlayerDX := dx;
            PlayerDY := dy;
            Char1 := Map[y,x];
            Char2 := Map[y + Ord(dy), x + ord(dx)];
            Char3 := Map[y+2*Ord(dy), x+2*Ord(dx)];
            IsPushedBox := True;
            PoolChange := 0;
         end;
         // End Test feature
         if (Map[y+2*Ord(dy), x+2*Ord(dx)] = CDrawChar) then // на дорогу
         begin
            Map[y+2*Ord(dy), x+2*Ord(dx)] := CBoxChar;
            DrawCell(DrawSoko, x + 2*Ord(dx), y + 2*Ord(dy), CBoxPath);
         end;
         if (Map[y+2*Ord(dy), x+2*Ord(dx)] = CPoolChar) then //на лунку
         begin
            Map[y+2*Ord(dy), x+2*Ord(dx)] := CBoxInPoolChar;
            DrawCell(DrawSoko, x + 2*Ord(dx), y + 2*Ord(dy), CBoxInPoolPath);
         end;
         DrawOrPool(DrawSoko, x, y); // вместо игрока ставим лунку или дорогу
         if (Map[y+Ord(dy), x+Ord(dx)] = CBoxChar) then
            Map[y+Ord(dy), x+Ord(dx)] := CPlayerChar
         else // На место коробки ставим игрока
            Map[y+Ord(dy), x+Ord(dx)] := CPlayerInPoolChar;
         //DrawCell(DrawSoko, x + Ord(dx), y + Ord(dy), CPlayerPath);
         DrawPlayer(DrawSoko, x + Ord(dx), y + Ord(dy), dx, dy);
         // Увеличиваем счёт задвинутых коробок
         if (Map[y+Ord(dy), x+Ord(dx)] = CPlayerChar) and
            (Map[y+2*Ord(dy), x+2*Ord(dx)] = CBoxInPoolChar) then
            begin
               Dec(PoolCount);
               Move.PoolChange := -1;
            end;
         // Уменьшаем счёт задвинутых коробок
         if (Map[y+Ord(dy), x+Ord(dx)] = CPlayerInPoolChar) and
            (Map[y+2*Ord(dy), x+2*Ord(dx)] = CBoxChar) then
            begin
               Inc(PoolCount);
               Move.PoolChange := 1;
            end;
         MoveStack.Push(Move);
         NCancelMove.Enabled := True;
         x := x + Ord(dx);
         y := y + Ord(dy);
         Inc(Steps);
         Inc(Pushes);
         // Проверка на победу
         if PoolCount = 0 then
            MessageBox(Handle, PChar('Победа! Шагов - '  + IntToStr(Steps)), '', MB_OK);
      end;
      DrawCaption;
   end
   else if IsMapLoaded then
   begin
      case Key of
         Ord('U'):
         begin
            RestoreMove;
         end;
         Ord('Q'):
            FormGame.Close;
      end;
   end;
end;

procedure TFormGame.FormPaint(Sender: TObject);
begin
   DrawGrid(DrawSoko, Map);  // Draw not correct, fix it!!!
   // FIXIT - v1 - Kostyl
end;

procedure TFormGame.DrawCaption;
begin
   FormGame.Caption := 'Шагов: ' + IntToStr(Steps) + ' Перестановок: ' +
      IntToStr(Pushes);
end;

procedure TFormGame.WMMoving(var Msg: TWMMoving);
var
  workArea: TRect;
begin
  workArea := Screen.WorkareaRect;
  with Msg.DragRect^ do
  begin
    if Left < workArea.Left then
      OffsetRect(Msg.DragRect^, workArea.Left-Left, 0) ;
    if Top < workArea.Top then
      OffsetRect(Msg.DragRect^, 0, workArea.Top-Top) ;
    if Right > workArea.Right then
      OffsetRect(Msg.DragRect^, workArea.Right-Right, 0) ;
    if Bottom > workArea.Bottom then
      OffsetRect(Msg.DragRect^, 0, workArea.Bottom-Bottom) ;
  end;
  inherited;
end;

procedure TFormGame.FormCreate(Sender: TObject);
begin
   MoveStack := TMoveStackClass.Create(CStackSize);
   NCancelMove.Enabled := False;
end;

procedure TFormGame.FormDestroy(Sender: TObject);
begin
   FreeAndNil(MoveStack);
end;

procedure TFormGame.NExitClick(Sender: TObject);
begin
   FormGame.Close;
end;

procedure TFormGame.NCancelMoveClick(Sender: TObject);
begin
   RestoreMove;
end;

end.

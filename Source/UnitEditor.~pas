unit UnitEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, UnitSoko, ExtCtrls, UnitSizeEdit, UnitGame;

type
  TFormEditor = class(TForm)
    MainMenu: TMainMenu;
    NFile: TMenuItem;
    NLoad: TMenuItem;
    NSave: TMenuItem;
    NNewLevel: TMenuItem;
    GridEdit: TDrawGrid;
    Timer: TTimer;
    procedure NLoadClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure GridEditDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure TimerTimer(Sender: TObject);
    procedure NewField(aColCount, aRowCount: Integer);
    procedure MakeMove(aChar: Char);
    procedure TransformController(aKey: Word; IsUpper: Boolean);
    procedure NextMove;
    procedure TransformBorderChar(aFrom, aTo: Char);
    procedure DeleteCol(aCol: Integer);
    procedure DeleteRow(aRow: Integer);
    procedure InsertCol(aCol: Integer);
    procedure InsertRow(aRow: Integer);
    procedure TestLevel;
    procedure NNewLevelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEditor: TFormEditor;

implementation

uses Types, UnitMenu;

{$R *.dfm}

type
   TMode = (mdOverwrite, mdInsert);

var
   Map: TMap;
   IsMapLoaded: Boolean;
   IsCoursourVisible: Boolean;
   Mode: TMode;
   PathSave: string;

const
   CDefRows = 8;
   CDefCols = 8;

function SaveMap(aPath: string): Boolean;
var
   OutFile: TextFile;
   i: Integer;
begin
   AssignFile(OutFile, aPath);
   Rewrite(OutFile);
   for i := 0 to High(Map) do
   begin
      Writeln(OutFile, Map[i]);
   end;
   Close(OutFile);
end;

procedure TFormEditor.TransformBorderChar(aFrom, aTo: Char);
var
   i,j: Integer;
begin
   for i := 1 to Length(Map[0]) do
   begin
      j := 0;
      while (j <= High(Map)) and (Map[j,i] = aFrom) do
      begin
         Map[j,i] := aTo;
         DrawCell(GridEdit, i, j, aTO);
         Inc(j);
      end;
      j := High(Map);
      while (j >= 0) and (Map[j,i] = aFrom) do
      begin
         Map[j,i] := aTo;
         DrawCell(GridEdit, i, j, aTo);
         Dec(j);
      end;
   end;
   for i := 0 to High(Map) do
   begin
      j := 1;
      while (j <= Length(Map[i])) and (Map[i,j] = aFrom) do
      begin
         Map[i,j] := aTo;
         DrawCell(GridEdit, j, i, aTO);
         Inc(j);
      end;
      j := Length(Map[i]);
      while (j >= 1) and (Map[i,j] = aFrom) do
      begin
         Map[i,j] := aTo;
         DrawCell(GridEdit, j, i, aTo);
         Dec(j);
      end;
   end;
end;

procedure AddNullChar(aMap: TMap);
var
   i,j: Integer;
   MaxLength: Integer;
begin
   MaxLength := Length(Map[0]);
   for i := 1 to High(Map) do
      if Length(Map[i]) > MaxLength then
         MaxLength := Length(Map[i]);
   for i := 0 to High(Map) do
      for j := Length(Map[i]) to MaxLength - 1 do
         Insert(CNullChar, Map[i], j + 1);
end;

procedure TFormEditor.NLoadClick(Sender: TObject);
var
   Path: string;
begin
   if GetInPath(Path, Self) then
   begin
      if GetMapInFile(Path, Map) then
      begin
         MakeBorder(Map, GridEdit, FormEditor);
         AddNullChar(Map);
      end
      else
         MessageBox(Handle, 'Уровень некорректен, загрузка невозможна!',
            'Ошибка', MB_OK + MB_ICONERROR);
   end
   else
      MessageBox(Handle, 'Уровень не загружен!',
         'Внимание!', MB_OK + MB_ICONWARNING);
end;

procedure TFormEditor.FormPaint(Sender: TObject);
begin
   if not IsMapLoaded then
   begin
      Map := nil;
      NewField(CDefCols, CDefRows + 2);
      Mode := mdOverwrite;
      IsMapLoaded := True;
   end;
end;

procedure TFormEditor.GridEditDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   if (ACol = GridEdit.Col) and (ARow = GridEdit.Row) then
   begin
      if Mode = mdOverwrite then
         GridEdit.Canvas.Brush.Color := clGreen
      else
         GridEdit.Canvas.Brush.Color := clRed;
      GridEdit.Canvas.FillRect(Rect);
   end
   else
   begin
      DrawCell(GridEdit, ACol + 1, ARow, Map[ARow, ACol + 1]);
   end;
end;

procedure TFormEditor.TimerTimer(Sender: TObject);
begin
   with GridEdit do
   begin
      if IsCoursourVisible then
      begin
         if Mode = mdOverwrite then
            Canvas.Brush.Color := clGreen
         else
            Canvas.Brush.Color := clRed;
         Canvas.FillRect(CellRect(Col, Row));
      end
      else
         DrawCell(GridEdit, Col + 1, Row, Map[Row, Col + 1]);
   end;
   IsCoursourVisible := not IsCoursourVisible;
end;

procedure TFormEditor.NewField(aColCount, aRowCount: Integer);
var
   i,j: Integer;
begin
    if GetPropSize(Screen.WorkAreaWidth div aColCount,
      Screen.WorkAreaHeight div aRowCount) then
    begin
      SetLength(Map, aRowCount);
      for i := 0 to High(Map) do
      begin
         Map[i] := '';
         for j := 1 to aColCount do
            Insert(CDrawChar, Map[i], j);
      end;
    end
    else
       MessageBox(Handle, 'Ошибка! Слишком большой размер уровня!', 'Error',
         MB_OK + MB_ICONERROR);
   MakeBorder(Map, GridEdit, FormEditor);
end;

procedure TFormEditor.NNewLevelClick(Sender: TObject);
begin
   FormSizeEdit := TFormSizeEdit.Create(Self);
   FormSizeEdit.EditHeight.Text := IntToStr(Length(Map));
   FormSizeEdit.EditWidth.Text := IntToStr(Length(Map[0]));
   FormSizeEdit.ShowModal;
end;

procedure TFormEditor.FormCreate(Sender: TObject);
begin
   IsMapLoaded := False;
   PathSave := '';
end;

procedure TFormEditor.GridEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = Ord('Q') then
      FormEditor.Close;
   if Mode = MdInsert then
   begin
      TransformController(Key, ssShift in Shift);
   end;
   with GridEdit do
   begin
      case Key of
         Ord('H'):
            if Col > 0 then
               Col := Col - 1;
         Ord('L'):
            if Col < ColCount - 1 then
               Col := Col + 1;
         Ord('J'):
            if Row < RowCount - 1 then
               Row := Row + 1;
         Ord('K'):
            if Row > 0 then
               Row := Row - 1;
         Ord('B'):
            if ssShift in Shift then
               MakeMove(CBoxInPoolChar)
            else
               MakeMove(CBoxChar);
         Ord('P'):
            if ssShift in Shift then
               MakeMove(CPlayerInPoolChar)
            else
               MakeMove(CPlayerChar);
         Ord('G'):
            if ssShift in Shift then
               TransformBorderChar(CNullChar, CDrawChar)
            else
               MakeMove(CDrawChar);
         Ord('O'):
            MakeMove(CPoolChar);
         Ord('W'):
            MakeMove(CWallChar);
         Ord('N'):
            if ssShift in Shift then
               TransformBorderChar(CDrawChar, CNullChar)
            else
               MakeMove(CNullChar);
         Ord('M'), Ord('I'):
            if Mode = mdOverWrite then
               Mode := mdInsert
            else
               Mode := mdOverWrite;
         Ord('E'):
            TestLevel;
      end;
   end;
end;

procedure TFormEditor.MakeMove(aChar: Char);
begin
   with GridEdit do
   begin
      if Mode = mdOverWrite then
      begin
         Map[Row, Col + 1] := aChar;
         DrawCell(GridEdit, Col + 1, Row, Map[Row, Col + 1]);
      end
   end;
end;

procedure TFormEditor.NextMove;
begin
   with GridEdit do
   begin
      if Col < ColCount - 1 then
         Col := Col + 1
      else if Row < RowCount - 1 then
      begin
         Row := Row + 1;
         Col := 0;
      end;
   end;
end;

procedure TFormEditor.DeleteCol(aCol: Integer);
var
   i: Integer;
begin
   for i := 0 to High(Map) do
      Delete(Map[i], aCol + 1, 1);
   MakeBorder(Map, GridEdit, FormEditor);
end;

procedure TFormEditor.DeleteRow(aRow: Integer);
var
   i: Integer;
   NewMap: TMap;
begin
   SetLength(NewMap, Length(Map) - 1);
   for i := 0 to aRow - 1 do
      NewMap[i] := Map[i];
   for i := aRow + 1 to High(Map) do
      NewMap[i-1] := Map[i];
   Map := Copy(NewMap);
   MakeBorder(Map, GridEdit, FormEditor);
end;

procedure TFormEditor.InsertCol(aCol: Integer);
var
   i: Integer;
begin
   for i := 0 to High(Map) do
      Insert(CDrawChar, Map[i], aCol + 1);
   MakeBorder(Map, GridEdit, FormEditor);
end;

procedure TFormEditor.InsertRow(aRow: Integer);
var
   i: Integer;
   NewMap: TMap;
begin
   SetLength(NewMap, Length(Map) + 1);
   for i := 0 to aRow - 1 do
      NewMap[i] := Map[i];
   for i := 0 to Length(Map[0]) - 1 do
      Insert(CDrawChar, NewMap[aRow], i + 1);
   for i := aRow to High(Map) do
      NewMap[i + 1] := Map[i];
   Map := Copy(NewMap);
   MakeBorder(Map, GridEdit, FormEditor);
end;

procedure TFormEditor.TransformController(aKey: Word; IsUpper: Boolean);
begin
   if IsUpper then
   begin
      case aKey of
         ord('W'):
            InsertRow(0);
         ord('S'):
            InsertRow(GridEdit.RowCount);
         ord('A'):
            InsertCol(0);
         Ord('D'):
            InsertCol(GridEdit.ColCount);
         Ord('X'):
            DeleteCol(GridEdit.Col);
      end;
   end
   else
   begin
      with GridEdit do
      begin
         case aKey of
            ord('W'):
               InsertRow(Row);
            ord('S'):
               InsertRow(Row + 1);
            ord('A'):
               InsertCol(Col);
            Ord('D'):
               InsertCol(Col + 1);
            Ord('X'):
               DeleteRow(GridEdit.Row);
         end;
      end;
   end;
end;

procedure TFormEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   FormMenu.Show;
end;

function GetOutPath(var aPath: string; aParrent: TComponent): Boolean;
var
   saveFile: TSaveDialog;
begin
   saveFile := TSaveDialog.Create(aParrent);
   saveFile.Filter := 'Уровни sokoban (*.skb)|*.skb';
   if saveFile.Execute then
   begin
      aPath := saveFile.FileName;
      Result := True;
   end
   else
      Result := False;
   saveFile.Destroy;
end;

procedure TFormEditor.NSaveClick(Sender: TObject);
var
   Path: string;
   i: Integer;
   Ext: string;
begin
   if GetOutPath(Path, Self) then
   begin
      SaveMap(Path);
      PathSave := Path;
      Ext := ExtractFileExt(PathSave);
      Delete(PathSave, Pos(Ext, PathSave), Length(Ext));
   end
   else
      MessageBox(Handle, 'Файл не выбран', 'Внимание!', MB_OK + MB_ICONWARNING);
end;


procedure TFormEditor.TestLevel;
begin
   if PathSave <> '' then
   begin
      SaveMap(PathSave + '.skb');
      UnitGame.Path := PathSave;
      LevelName := 'DEBUG';
      FormGame := TFormGame.Create(Self);
      FormGame.ShowModal;
   end
   else
      MessageBox(Handle, 'Сначала сохраните файл!','Ошибка', MB_OK + MB_ICONERROR);
end;

end.

unit UnitMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, UnitGame, StdCtrls, ExtCtrls, Grids, UnitSoko, Menus,
  UnitRename, UnitEditor;

type
  TFormMenu = class(TForm)
    ButtonGame: TImage;
    ButtonLevelEditor: TImage;
    ButtonExit: TImage;
    PanelLevelSelest: TPanel;
    ButtonStart: TImage;
    ButtonReturn: TImage;
    ButtonLvlRename: TImage;
    ButtonCatRename: TImage;
    ButtonCatAdd: TImage;
    ButtonLvlAdd: TImage;
    ButtonCatDelete: TImage;
    ButtonLvlDelete: TImage;
    ButtonEdit: TImage;
    ListDir: TListBox;
    GridLevels: TStringGrid;
    Label1: TLabel;
    procedure ButtonGameClick(Sender: TObject);
    procedure ButtonReturnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LoadDirectories;
    procedure LoadLevels;
    procedure ListDirClick(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonLvlDeleteClick(Sender: TObject);
    procedure ButtonLvlRenameClick(Sender: TObject);
    procedure ButtonCatRenameClick(Sender: TObject);
    procedure ButtonCatDeleteClick(Sender: TObject);
    procedure ButtonCatAddClick(Sender: TObject);
    procedure ButtonLvlAddClick(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure ButtonLevelEditorClick(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMenu: TFormMenu;
  NameRename: string;

implementation

{$R *.dfm}

uses
   ShellAPI;

const
   CDefLevelPath = 'Levels/';

procedure TFormMenu.LoadDirectories;
var
   SearchRec: TSearchRec;
   Count: Integer;
begin
   ListDir.Items.Clear;
   Count := 0;
   if FindFirst(CDefLevelPath + '*', faDirectory, SearchRec) = 0 then
   begin
      repeat
         if (SearchRec.Attr = faDirectory) and (SearchRec.Name <> '.') and
            (SearchRec.Name <> '..') then
            begin
               ListDir.Items.Add(SearchRec.Name);
               Inc(Count);
            end;
      until FindNext(SearchRec) <> 0;
   end;
   if Count < 2 then
   begin
      ButtonCatDelete.Visible := False;
   end
   else
   begin
      ButtonCatDelete.Visible := True;
   end;
   FindClose(SearchRec);
end;

function DelDir(dir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_DELETE;
    fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
    pFrom  := PChar(dir + #0);
  end;
  Result := (0 = ShFileOperation(fos));
end;

procedure TFormMenu.LoadLevels;
var
   SearchRec: TSearchRec;
   Count: Integer;
   Name: string;
   RecordPath: string;
   Rec: TRecord;
   i: Integer;
begin
   Count := 0;
   SetCurrentDir(ExtractFilePath(Application.ExeName));
   if FindFirst(CDefLevelPath + ListDir.Items[ListDir.ItemIndex] + '/*.skb',
      faAnyFile, SearchRec) = 0 then
   begin
      repeat
         Inc(Count);
         GridLevels.RowCount := Count + 1;
         Name := Copy(SearchRec.Name, 0, Pos('.', SearchRec.Name) - 1);
         GridLevels.Cells[0, Count] := Name;
         RecordPath := CDefLevelPath + ListDir.Items[ListDir.ItemIndex] + '/' +
            Name + '.rec';
         if FileExists(RecordPath) and GetRecord(RecordPath, Rec) then
         begin
            GridLevels.Cells[1, Count] := IntToStr(Rec.Moves);
            GridLevels.Cells[2, Count] := IntToStr(Rec.Pushes);
            GridLevels.Cells[3, Count] := Rec.Time;
         end
         else
         begin
            GridLevels.Cells[1, Count] := 'UNDEF';
            GridLevels.Cells[2, Count] := 'UNDEF';
            GridLevels.Cells[3, Count] := 'UNDEF';
         end;
      until FindNext(SearchRec) <> 0;
   end;
   if Count = 0 then
   begin
      for i := 0 to 3 do
         GridLevels.Cells[i,1] := '';
      GridLevels.RowCount := 2;
      ButtonStart.Visible := False;
      ButtonLvlDelete.Visible := False;
      ButtonLvlRename.Visible := False;
   end
   else
   begin
      ButtonStart.Visible := True;
      ButtonLvlDelete.Visible := True;
      ButtonLvlRename.Visible := True;
   end;
   FindClose(SearchRec);
end;

procedure TFormMenu.ButtonGameClick(Sender: TObject);
begin
   PanelLevelSelest.Visible := true;
   ListDir.Items.Clear;
   LoadDirectories;
   ListDir.ItemIndex := 0;
   LoadLevels;
end;

procedure TFormMenu.ButtonReturnClick(Sender: TObject);
begin
   PanelLevelSelest.Visible := False;
end;

procedure TFormMenu.FormCreate(Sender: TObject);
begin
   GridLevels.Cells[0,0] := 'Level Name:';
   GridLevels.Cells[1,0] := 'STEPS:';
   GridLevels.Cells[2,0] := 'PUSHES';
   GridLevels.Cells[3,0] := 'TIME:';
   FormMenu.Left := (Screen.WorkAreaWidth - FormMenu.Width) div 2;
   FormMenu.Top := (Screen.WorkAreaHeight - FormMenu.Height) div 2;
end;

procedure TFormMenu.ListDirClick(Sender: TObject);
begin
   LoadLevels;
end;

procedure TFormMenu.ButtonStartClick(Sender: TObject);
begin
   Path := CDefLevelPath + '/' + ListDir.Items[ListDir.ItemIndex] + '/' +
      GridLevels.Cells[0, GridLevels.Selection.Bottom];
   LevelName := ListDir.Items[ListDir.ItemIndex] + '/' +
      GridLevels.Cells[0, GridLevels.Selection.Bottom];
   FormGame := TFormGame.Create(Self);
   FormGame.ShowModal;
   //PanelLevelSelest.Visible := False;
   //FormMenu.Hide;
end;

function DeleteLvl(const aPath: string): Boolean;
begin
   try
     DeleteFile(aPath + '.skb');
     if FileExists(aPath + '.rec') then
        DeleteFile(aPath + '.rec');
     Result := True;
   except
      Result := False;
   end;
end;


procedure TFormMenu.ButtonLvlDeleteClick(Sender: TObject);
var
   Path: string;
begin
   Path := CDefLevelPath + ListDir.Items[ListDir.ItemIndex] + '/' +
      GridLevels.Cells[0, GridLevels.Selection.Bottom];
   if DeleteLvl(Path) then
      LoadLevels;
end;

procedure TFormMenu.ButtonLvlRenameClick(Sender: TObject);
var
   DirPath: string;
begin
   DirPath := CDefLevelPath + '/' + ListDir.Items[ListDir.ItemIndex] + '/';
   OldName := GridLevels.Cells[0, GridLevels.Selection.Bottom];
   FormRename := TFormRename.Create(Self);
   FormRename.ShowModal;
   if not RenameFile(DirPath + OldName + '.skb', DirPath + NameRename + '.skb') then
      MessageBox(Handle, 'Некорректное имя!', 'Ошибка', MB_OK + MB_ICONERROR);
   if FileExists(DirPath + OldName + '.rec') then
      RenameFile(DirPath + OldName + '.rec', DirPath + NameRename + '.rec');
   LoadLevels;
end;

procedure TFormMenu.ButtonCatRenameClick(Sender: TObject);
var
   DirPath: string;
begin
   DirPath := CDefLevelPath + '/';
   OldName := ListDir.Items[ListDir.ItemIndex];
   FormRename := TFormRename.Create(Self);
   FormRename.ShowModal;
   if not RenameFile(DirPath + OldName, DirPath + NameRename) then
      MessageBox(Handle, 'Некорректное имя!', 'Ошибка', MB_OK + MB_ICONERROR);
   LoadDirectories;
   ListDir.ItemIndex := 0;
   LoadLevels;
end;

procedure TFormMenu.ButtonCatDeleteClick(Sender: TObject);
begin
   DelDir(CDefLevelPath + '/' + ListDir.Items[ListDir.ItemIndex]);
   LoadDirectories;
   ListDir.ItemIndex := 0;
   LoadLevels;
end;

procedure TFormMenu.ButtonCatAddClick(Sender: TObject);
begin
   OldName := '';
   FormRename := TFormRename.Create(Self);
   FormRename.ButtonOK.Enabled := False;
   FormRename.ShowModal;
   if NameRename <> '' then
      try
         MkDir(CDefLevelPath + '/' + NameRename);
      except
         MessageBox(Handle, 'Некорректное имя!', 'Ошибка', MB_OK + MB_ICONERROR);
      end;
   LoadDirectories;
   ListDir.ItemIndex := 0;
   LoadLevels;
end;

procedure TFormMenu.ButtonLvlAddClick(Sender: TObject);
var
   Path: string;
begin
   if GetInPath(Path, Self) then
   begin
      OldName := '';
      FormRename := TFormRename.Create(Self);
      FormRename.ButtonOK.Enabled := False;
      FormRename.ShowModal;
      SetCurrentDir(ExtractFilePath(Application.ExeName));
      if NameRename <> '' then
         CopyFile(PChar(Path), PChar(CDefLevelPath {+ '/'} + ListDir.Items[ListDir.ItemIndex] + '/' +
            NameRename + '.skb'), True);
      LoadLevels;
   end;
end;

procedure TFormMenu.ButtonExitClick(Sender: TObject);
begin
   FormMenu.Close;
end;

procedure TFormMenu.ButtonLevelEditorClick(Sender: TObject);
begin
   FormEditor := TFormEditor.Create(Self);
   FormEditor.Show;
   FormMenu.Hide;
end;

procedure TFormMenu.ButtonEditClick(Sender: TObject);
begin
   //
   if ListDir.Height < 370 then
   begin
      ListDir.Height := 430;
      GridLevels.Height := 430;
   end
   else
   begin
      ListDir.Height := 329;
      GridLevels.Height := 329;
   end;
end;

end
.

unit UnitRename;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormRename = class(TForm)
    EditName: TEdit;
    ButtonOK: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EditNameKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonOKClick(Sender: TObject);
    procedure EditNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRename: TFormRename;
  OldName: string;
  NewName: string;

implementation

{$R *.dfm}

uses
   UnitMenu;

procedure TFormRename.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TFormRename.FormCreate(Sender: TObject);
begin
   EditName.Text := OldName;
   NameRename := OldName;
end;

procedure TFormRename.EditNameKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) and ButtonOK.Enabled then
   begin
      NameRename := EditName.Text;
      FormRename.Close;
   end
end;

procedure TFormRename.ButtonOKClick(Sender: TObject);
begin
   NameRename := EditName.Text;
   FormRename.Close;
end;

procedure TFormRename.EditNameChange(Sender: TObject);
begin
   if EditName.Text <> '' then
      ButtonOK.Enabled := True
   else
      ButtonOk.Enabled := False;
end;

end.

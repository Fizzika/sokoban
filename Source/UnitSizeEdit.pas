unit UnitSizeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormSizeEdit = class(TForm)
    LabelWidth: TLabel;
    LabelHeight: TLabel;
    EditWidth: TEdit;
    EditHeight: TEdit;
    ButtonOK: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonOKClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure EditHeightChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSizeEdit: TFormSizeEdit;

implementation

{$R *.dfm}

uses
   UnitEditor;

procedure GetWordInput(var aKey: Char; aText: string);
const
   CMaxLength = 2;
begin
   if not (aKey in ['0'..'9', #8, #13]) then
      aKey := #0;
   if (Length(aText) > CMaxLength - 1) and (aKey <> #8) then
      aKey := #0;
end;

procedure TFormSizeEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TFormSizeEdit.ButtonOKClick(Sender: TObject);
begin
   FormEditor.NewField(StrToInt(EditWidth.Text), StrToInt(EditHeight.Text));
   FormSizeEdit.Close;
end;

procedure TFormSizeEdit.EditKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) and ButtonOK.Enabled then
   begin
      FormEditor.NewField(StrToInt(EditWidth.Text), StrToInt(EditHeight.Text));
      FormSizeEdit.Close
   end
   else
      GetWordInput(Key, TEdit(Sender).Text);
end;

procedure TFormSizeEdit.EditHeightChange(Sender: TObject);
begin
   if (EditWidth.Text <> '') and (EditHeight.Text <> '') then
      ButtonOk.Enabled := True
   else
      ButtonOK.Enabled := False;
end;

end.

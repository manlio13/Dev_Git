unit Unit1;     //  23/03/2013

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ABSMain;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    ABSTable1: TABSTable;
    ABSDatabase1: TABSDatabase;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  cod :integer;
  st : string;
  v:variant;
implementation

{$R *.dfm}


procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then   //verifica che non siano inserite lettere
    begin
      try  cod:=strtoInt(Edit1.Text);
        except on EConvertError do
          begin
      Showmessage('Not an Integer Value');
      exit;
          end;
      end;
  st:=edit1.Text;
  v:=ABSTable1.lookup('mid',st,'mid;country');
  if (not VarIsNull(v)) then     //verifica che il MID esista in elenco
      edit2.Text:=VarToStr(v[1]) else
      begin
   showmessage( 'M I D not found !');
   exit;
      end;
  end;



end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
ABSTable1.Close;
ABSDatabase1.Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
ABSDatabase1.DatabaseFileName:=ExtractFilePath(Application.ExeName)+'MID.ABS';
ABSTable1.TableName:='midTB';
ABSDatabase1.Open;
ABSTable1.Open;
end;


end.

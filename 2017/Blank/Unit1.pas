unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,System.DateUtils;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
    dir,pwstr,ora:string;
    n:integer;
implementation

{$R *.dfm}



procedure TForm1.FormCreate(Sender: TObject);
begin
   dir:=GetCurrentDir+'\';
   pwstr:='';




end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
      if Key=#13 then  // all'atto dell'entry della pw
    begin
       pwstr:=Edit1.Text;
       ora:=TimeToStr(now);
       trY
        n:=  SecondsBetween(StrToTime(ora),StrToTime(pwstr));
       if n>60 then

          Edit1.Text:='accesso negato' else
          Edit1.Text:='ACCETTATO';
         except on E: Exception do
          Edit1.Text:='accesso negato'
       end;

      // ShowMessage(IntToStr(n));

    end;
end;

end.

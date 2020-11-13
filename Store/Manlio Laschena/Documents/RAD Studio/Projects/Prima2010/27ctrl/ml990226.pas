unit ml990226;//  programma per calcolare i numeri corrispondenti alle stringhe

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  n,muser,mapp,mver,mio,cdr:integer;
  nome: string='Manlio';
implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);

     //calcola
begin
 for n:=1 to length(edit1.text) do
  muser:=muser+ord(edit1.text[n]);

for n:=1 to length(edit2.text) do
 mapp:=mapp+ord(edit2.text[n]);

mver:=strtoint(edit3.text);

for n:=1 to length(nome) do
mio:=mio+ord(nome[n]);
cdr:=(muser+mapp+mver+mio)*191135;

 label1.caption:=inttostr(cdr);


end;

procedure TForm1.Button2Click(Sender: TObject);
begin
edit1.text:='';
edit2.text:='';
edit3.text:='';
muser:=0;
mapp:=0;
mver:=0;
cdr:=0;
label1.caption:='';
end;

end.

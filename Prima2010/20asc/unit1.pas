unit Unit1;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    combo1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   F:textfile;
   n,m,k:real;
   ar:array[1..5,1..2]of real;
   p,q:integer;
implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
n:=1.2;
m:=3.4;
assignfile (F,'.\prova.txt');
rewrite(F);
write(F,n:5:2,m:5:2);
closeFile(F);
 {mostra come si puo' scrivere fissando il formato}
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
k:=n*m ;
assignfile (F,'.\prova.txt');
rewrite(F);    {prova di calcolo}
write(F,k:5:2);
closeFile(F);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
assignfile (F,'.\prova.txt');
reset(F);  {vale anche per file scritto con editor}
read(F,n,m);
k:=m-n;
rewrite(F);
write(F,k:5:2);
closeFile(F);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
assignfile (F,'.\prova.txt');
reset(F);
for p:=1 to 5 do
    begin
    read(F,n,m);
    for q:=1 to 2 do
    if q=1 then
    ar[p,q]:=n
    else
    ar[p,q]:=m;

    end;

closeFile(F);
for p:=1 to 5 do
    combo1.items.add(floattostr(ar[p,1]));




end;

end.

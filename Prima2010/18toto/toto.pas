unit toto;

interface

uses
  Windows, Classes, Sysutils,Controls, Forms,  StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;


    procedure FormActivate(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  tg : array[0..7] of integer;
  m,k,kk: integer;
implementation

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
 label TT;
  var
  n:integer;

begin
 TT:
 randomize;
  label1.caption:='';
  n:=0;
  repeat
 m:=random(30);
 tg[n]:=m;
 n:=n+1;
 if m=0 then
 goto TT;
   until n=8;

   for k:= 0 to 7  do
   begin
   for kk:=(k+1) to 7 do
   begin
   if tg[k]=tg[kk] then
   goto TT;
   end;
   end;
   for n:=0 to 7 do
   label1.caption:=label1.caption+' '+inttostr(tg[n]);

 end;


end.

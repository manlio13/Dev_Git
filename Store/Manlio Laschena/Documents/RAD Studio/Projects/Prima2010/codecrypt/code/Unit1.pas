unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edit5: TEdit;
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  dummy,vol:int64;
implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
carry:real;
crypt:longint;
k,ks,subn:smallint;
sub,scrypt:string;
newstr:array[1..9] of string;
begin
dummy:=strtoint64(edit2.text);
vol:=strtoint64(edit1.text);  //ipotesi numeri ricevuti dal sistema
carry:=dummy+vol;

while carry>999999999 do
   begin
   carry:=carry/10;
   carry:=int(carry);
   end;

 edit3.text:=floattostr(carry);
 //routine di cryptazione del CDR per invio email
 scrypt:=floattostr(carry);
 ks:=length(scrypt);
 for k:=1 to ks do
        begin
  sub:=copy(scrypt,k,1);
  subn:=strtoint(sub)-k;
  if subn<0 then
  subn:=strtoint(sub)+10-k;
  newstr[k]:=copy(inttostr(subn),1,1);
        end;
  scrypt:='';
  for k:=1 to ks do
  scrypt:=scrypt+newstr[k];//ricostruzione dello scrypt
  edit4.text:=scrypt;//codice da spedire via email
  crypt:=strtoint(scrypt);
 //routine per ottenere il cdr dal crypt
   for k:=1 to ks do
        begin
  sub:=copy(scrypt,k,1);
  subn:=strtoint(sub)+k;
  if subn>9 then
  subn:=strtoint(sub)-10+k;
  newstr[k]:=copy(inttostr(subn),1,1);
        end;
  scrypt:='';
  for k:=1 to ks do
  scrypt:=scrypt+newstr[k];//ricostruzione dello scrypt
  edit5.text:=scrypt;


end;




end.

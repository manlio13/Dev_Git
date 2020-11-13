unit vol;
//per ottenere il num.di serie ed il nome del drive di ROOT
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1:TForm1;
  implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
s:array[0..255]of char;
m,f:string;
n:Dword;
k,kk:smallint;
tot :integer;
begin
tot:=0;
f:='';
GetVolumeInformation(Pchar(nil),s,sizeof(s),@n,
Dword(nil^),Dword(nil^),nil,0);
messagedlg('Num.di Serie : '+inttostr(n),MtInformation,[MbOK],0);
messagedlg('Nome : '+s,MtInformation,[MbOK],0);
m:=inttostr(n);
//Routine per determinare la somma (SM) dovuta alle cifre di un numero
 For k :=1 to length(m) do
 tot:=tot+strtoint(m[k]);
 //riduzione del numero di volume a SM più le prime cifre fino al max di 6
 k:=6-length(inttostr(tot));
 for kk:=1 to k do
 f:=f+m[kk];
 f:=inttostr(tot)+f;
 messagedlg(f,MtInformation,[mbOK],0);
 end;

end.
 
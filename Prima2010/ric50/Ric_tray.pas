unit Ric_tray;
 //il codice di prodotto di Ricorda 5.0 - 5.9 è <10>
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, CoolTrayIcon,About, ExtCtrls, StdCtrls,Registry;

type
  TForm1 = class(TForm)
    CoolTrayIcon1: TCoolTrayIcon;
    PopRicorda: TPopupMenu;
    Apri1: TMenuItem;
    Exit1: TMenuItem;
    About1: TMenuItem;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    DisattivaRicorda1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Exit1Click(Sender: TObject);
begin
close;
Free;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
Form2.visible:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
CDR,IDL: string[16];
currTS:string[10];
s:array[0..255]of char;
m,nvol:string;
n:Dword;
k,kk:smallint;
tot :integer;
mioReg: TRegistry;
ml:TstringList;
cavtroia:int64;
const CP :string[2]='10'; //<-- questo dato va corretto con il codice prodotto
begin
form1.Visible:=true;
tot:=0;
n:=0;
nvol:='';
//legge il TimeStamp
currTS:=formatdatetime('ddmmyyhhmm',now);
//legge il nvol
GetVolumeInformation(Pchar(nil),s,sizeof(s),@n,
Dword(nil^),Dword(nil^),nil,0);
m:=inttostr(n);
//Routine per determinare la somma (SM) dovuta alle cifre di un numero
 For k :=1 to length(m) do
 tot:=tot+strtoint(m[k]);
 //riduzione del numero di volume a SM più le prime cifre fino al max di 6
 k:=6-length(inttostr(tot));
 for kk:=1 to k do
 nvol:=nvol+m[kk];

 //f = nvol standardizzato
 nvol:=inttostr(tot)+nvol;

 //CDR rappresenta i 16 caratteri del dummy vale a dire il CDR
 CDR:=currTS + nvol;

 //legge InDateLog
 mioreg:=Tregistry.Create;
 ml:=TstringList.Create;
 mioreg.RootKey:=HKEY_CLASSES_ROOT;
        if mioreg.KeyExists('\InDateLog') then
        begin
        mioreg.OpenKey('\InDatelog',false);
         mioreg.GetValueNames(ml);
         for k:=0 to ml.Count-1 do
        if ml.strings[k]=CP then
        begin
        mioreg.readbinaryData(CP,cavtroia,sizeof(cavtroia));
 IDL:=inttostr(cavtroia);
      messagedlg(cdr + ' ? '+idl,mtWarning,mbOKCancel,0);
        end;
        end else
        begin
         messagedlg('nessun dato crypto',MtWarning,[MbOK],1);
         mioreg.free;
         end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
Form1.Visible:=false;
end;
end.

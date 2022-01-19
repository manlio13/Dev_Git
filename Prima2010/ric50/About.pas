unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  jclSysInfo, StdCtrls, ExtCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Dpower: TImage;
    Image2: TImage;
    mlico: TImage;
    regframe: TBevel;
    Label7: TLabel;
    Reguser: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Button2: TButton;
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
implementation

{$R *.DFM}

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=cafree;
end;

procedure TForm2.FormShow(Sender: TObject);
//il Type TwindowsVersion è dichiarato in JCL
 const
numinfo =11;
definizioni:array[1..numinfo]of string =
 ('CompanyName','FileDescription','FileVersion','InternalName','LegalCopyright',
'LegalTradeMarks','OriginalFilename','ProductName','ProductVersion','Comments'
 ,'Status');
  var
 risposta: TwindowsVersion;
  m,n,lanid,cod: integer;
  hnd,lung: Dword;
  codstr,lanidstr,codice: string;
  Buf,Valore: PChar;
 begin
  risposta:= GetWindowsVersion;
 case risposta of
 wvUnknown   : label1.caption:='Versione del SO non definita';
 wvWin95     : label1.caption:='Windows 95';
 wvWin95OSR2 : label1.caption:='Windows 95 OSR 2';
 wvWin98     : label1.Caption:='Windows 98';
 wvWin98SE   : label1.Caption:='Windows 98 Second Edition';
 wvWinME     : label1.Caption:='Windows Millenium';
 wvWin2000   : label1.Caption:='Windows 2000';
 wvWinNT3    : label1.Caption:='Windows NT 3.x';
 wvWinNT4    : label1.Caption:='Windows NT 4.0';
 else
 messagedlg('Attenzione errore di Sistema',mtError,[mbOK],0);
 end;
 m:= round(GetFreePhysicalMemory()/1000000);
 label2.caption:=('Memoria disponibile  '+ inttostr(m) +' MB Ram');

 //ricava la versione di Ricorda
  if fileexists('Ricorda.exe') then
 n:=GetFileVersionInfoSize(PChar('Ricorda.exe'),hnd)else
 begin
 messagedlg('Attenzione manca il file.',mtError,[mbOK],0);
 application.Terminate;
 end;
 if n>0 then
 begin
 cod:=GetACP();             //API per ottenere il codepage usato
 lanid:=GetUserDefaultLangID();  //API per ottenere l'ID della lingua usata
    codstr:=intToHex(cod,4);
    lanidstr:=intToHex(lanid,4);
  codice:=lanidstr+codstr;
 Buf:=AllocMem(n); //definisce la dimensione del Buffer

 GetFileVersionInfo(PChar('Ricorda.exe'),0,n,Buf);
     //attenzione ai codici 0410 =italiano 04E4=codepage
     if VerQueryValue(Buf,PChar('StringFileInfo\'+codice+'\'+Definizioni[3]),
     Pointer(Valore),lung)then
     label3.caption:=('Versione'+' :'+Valore);
     FreeMem(Buf,n);
  reguser.text:=GetRegisteredOwner();
 end;

end;

procedure TForm2.Button1Click(Sender: TObject);
begin
close;
end;




procedure TForm2.Button2Click(Sender: TObject);
begin
memo1.Clear;
memo1.lines.Add(Reguser.Text);
memo1.lines.Add(edit2.text);
memo1.lines.Add(edit3.text);
memo1.SelectAll;
memo1.CopyToClipboard;
end;

end.

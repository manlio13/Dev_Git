unit ml981014;
//programma per la lettura dei dati di versione (ricompilato D5) ed 2.0
interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;

    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public

    { Public declarations }
  end;
 
 const
numinfo =11;
definizioni:array[1..numinfo]of string =
 ('CompanyName','FileDescription','FileVersion','InternalName','LegalCopyright',
'LegalTradeMarks','OriginalFilename','ProductName','ProductVersion','Comments'
 ,'Status');
var
  Form1: TForm1;
  S,dato,codice,codstr,lanidstr  :string;
n,cod,lanid :integer;
Buf :PChar;
Valore :PChar;
d1,dd:TdateTime;
hnd,lung:Dword;
implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
 var
i:integer;
FS1:TFileStream;
begin
       //zona codice per definire le variabili da cercare
  with opendialog1 do
 if execute then
 try
 FS1:=Tfilestream.Create(Filename,fmOpenRead);
  s:=filename;
  finally
 FS1.Free;
  end;
 //S:=inputbox('Acquisizione del nomefile','desidero i dati di versione di : ','');
 n:=GetFileVersionInfoSize(PChar(S),hnd);
 if n>0 then
 begin
 cod:=GetACP();             //API per ottenere il codepage usato
 lanid:=GetUserDefaultLangID();  //API per ottenere l'ID della lingua usata
    codstr:=intToHex(cod,4);
    lanidstr:=intToHex(lanid,4);
  codice:=lanidstr+codstr;
  // showmessage(codice); //mostra il codice
 Buf:=AllocMem(n); //definisce la dimensione del Buffer
 Memo1.Lines.Add('La dimensione dei dati è '+IntToStr(n));
 GetFileVersionInfo(PChar(S),0,n,Buf);
     for i:=1 to numinfo do //attenzione ai codici 0410 =italiano 04E4=codepage
     if VerQueryValue(Buf,PChar('StringFileInfo\'+codice+'\'+Definizioni[i]),
     Pointer(Valore),lung)then
     Memo1.Lines.Add(Definizioni[i]+' :'+Valore);
     FreeMem(Buf,n);

 end else
     Memo1.Lines.Add('Non trovo i  dati sulla versione');

end;

procedure TForm1.Button1Click(Sender: TObject);
begin    //per estrarre solo la versione del file

 n:=GetFileVersionInfoSize(PChar(S),hnd);
 if n>0 then
 begin
 Buf:=AllocMem(n); //definisce la dimensione del Buffer
  GetFileVersionInfo(PChar(S),0,n,Buf);

     if VerQueryValue(Buf,PChar('StringFileInfo\'+codice+'\'+Definizioni[3]),
     Pointer(Valore),lung)then
     label1.caption:=Valore else
     label1.caption:='errore di codici';
     FreeMem(Buf,n);

 end else //se non esiste il dato di versione
     label1.caption:='Non trovo il numero di versione';

end;

procedure TForm1.Button2Click(Sender: TObject);

begin   //estrazione del numero di edizione
dato:=copy(valore,1,1);
 label1.caption:=dato;
 //

end;

end.





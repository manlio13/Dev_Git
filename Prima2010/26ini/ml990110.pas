// ini01 per costruire il codice data+edizione per il registro
unit ml990110;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,Registry;

type

  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button1: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
         { Private declarations }
  public
      { Public declarations }
  end;
 miorecord=record
       giorno:tdatetime;
       edizione:integer;
       end; 
var
  Form1: TForm1;
 //zona versione
  oggi : Tdatetime;
  p:longint;
  nomefile,codhex,langidhex,codice,verhex,verdatahex: string;
  n,langid,cod,lung: integer;
  buf,valore,buf2:Pchar;
 //zona registro
  esiste:Boolean;
  mioreg:Tregistry;
implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
    oggi:=date;// cattura la data del giorno
     p:=strtoint(floattostr(oggi));
     label1.caption:=floattostr(oggi);//intero decimale
     label2.caption:=inttohex(p,8); //hexagesimale
     label3.caption:=datetostr(oggi);//data
 //cerca la versione del file
 nomefile:='.\Ricorda.exe'; //NOME DEL FILE DI CUI SI VUOLE LA VERSIONE
 n:=GetFileVersionInfoSize(PChar(nomefile),n);//dimensione di tutti i dati
                                              // di versione
 if n>0 then
 begin
    cod:=GetACP();             //API per ottenere il codepage usato
    langid:=GetUserDefaultLangID();  //API per ottenere l'ID della lingua usata
    codhex:=intToHex(cod,4);
    langidhex:=intToHex(langid,4);
    codice:=langidhex+codhex; //ha costruito un elemento della query
    buf:=AllocMem(n); //definisce la dimensione del Buffer
    GetFileVersionInfo(PChar(nomefile),0,n,Buf);

     if VerQueryValue(Buf,PChar('StringFileInfo\'+codice+'\FileVersion'),
     Pointer(Valore),lung)then
       begin
     label4.caption:=Valore;
     label5.caption:=copy(valore,1,1);  // numero della versione
     verhex:=inttohex(strtoint(copy(valore,1,1)),2);
     label6.caption:=verhex;
     verdatahex:=verhex+inttohex(p,8);//codice versione + data
     label7.caption:=verdatahex;
       end else   //valore della versione, completo
     label4.caption:='errore';
     FreeMem(Buf,n);

 end else //se non esiste il dato di versione
     label4.caption:='Non trovo';

end;

procedure TForm1.Button1Click(Sender: TObject);
var
mioreginfo:Tregdatainfo;
s: Pchar;
cavtroia:miorecord;
ss:string;
ln:integer;
begin
mioreg:=TRegistry.Create; //inizializza il mioreg
 mioreg.RootKey:=HKEY_LOCAL_MACHINE;    //attenzione cerca solo la chiave
if not mioreg.keyexists('\System\CurrentControlSet\Control\InstalledFiles')then
 showmessage('Non c''e''la chiave nel registro') else
                  begin
 showmessage('c''e'' la chiave nel registro'); //è indispensabile aprire
                                               //con openkey
 mioreg.openkey('\System\CurrentControlSet\Control\InstalledFiles',false);
 if mioreg.ValueExists('win$#$.sys')then
  //if mioreg.ValueExists('temp')then
     begin //datatype è formato da regdata e datasize

     mioreginfo.regdata:=mioreg.GetDataType('win$#$.sys');//valore di esempio
     // mioreginfo.regdata:=mioreg.GetDataType('temp');
     label10.caption:=inttostr(mioreginfo.datasize);//fornisce sempre 7862740
      case mioreginfo.regdata of
     rdunknown:label8.caption:='unknown';
     rdstring:label8.caption:='string';
     rdexpandstring:label8.caption:='expanded string';
     rdinteger:label8.caption:='integer';
     rdBinary:label8.caption:='binary';//cosi' so che il dato è binario
      end;
     label9.caption:=inttostr(mioreg.getdatasize('win$#$.sys'));
     //label9.caption:=inttostr(mioreg.getdatasize('temp'));
     showmessage('fornito size,tipo e size2');
     end else
         begin
     showmessage('non trovo il tipo di dato');
     exit;
         end;
   cavtroia.giorno:=strtodate('01/01/98');
   cavtroia.edizione:=4;
   label9.caption:='scrivo '+datetostr(cavtroia.giorno);
   label10.caption:='ed. '+inttostr(cavtroia.edizione);
  //showmessage('vado a scrivere il record');
  // showmessage('vado a leggere il record');
    //ln:=1234;
    //s:=Pchar(inttostr(ln));
   try

   mioreg.openkey('\System\CurrentControlSet\Control\InstalledFiles',false);
   //la funzione read restituisce il numero di caratteri non il buffer s
   mioreg.writebinarydata('win$#$.sys',cavtroia,sizeof(cavtroia));
   //label9.caption:='leggo '+datetostr(cavtroia.giorno);

   // mioreg.readbinarydata('temp',ln,sizeof(ln));

   //label9.caption:='leggo '+inttostr(ln);
   finally
  mioreg.free;
   end;
                   end;
end;

end.




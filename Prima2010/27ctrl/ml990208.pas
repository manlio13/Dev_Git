unit ml990208;
//programma ctrlini.exe per leggere e scrivere i dati su PDP
// e sul registro hidden (R2)
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry;
type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
 miorecord=record
                 giorno:TdateTime;
                 edizione:integer;
 end;
var
  Form1: TForm1;
  cod,langid,n,lung,edr :integer; //edr: edizione da registrare
  nomefile,codhex,langidhex,codice,s1,hfile :string;
  buf,valore:PChar;
  mioreg:Tregistry;
  cavtroia:miorecord;
  fs: string;
  F:File;
  esiste,risp:boolean;
  li:longint;//indirizzo hex del dummy
  fl,s2:string[8];
implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
prima,fhandle:integer;
begin
//DETERMINA LA VERSIONE
     //quì va indicato il nome del PDP,di R2 e l'indirizzo di scrittura
     nomefile:=inputbox('Inserisci il PDP','il file è ','Ricorda.exe');
     hfile:=inputbox('Inserisci R2 ','il valore del Registro e ','win$#$.sys');
li:=strtoint(inputbox('Inserisci l''indirizzo di scrittura','il valore Hex e ',
'$45DD8'));
     try
     if not fileexists(nomefile) then
     raise EInOutError.create('manca file');
     cod:=GetACP();
     langid:=GetUserDefaultLangID();
     codhex:=inttohex(cod,4);
     langidhex:=inttohex(langid,4);
     codice:=langidhex+codhex;

     n:=GetFileVersionInfoSize(PChar(nomefile),n);
     buf:=AllocMem(n);
     GetFileVersionInfo(Pchar(nomefile),0,n,Buf);
     if VerQueryValue(Buf,Pchar('StringFileInfo\'+codice+'\FileVersion'),
     Pointer(Valore),lung)then
     edr:=strtoint(copy(Valore,1,1));
     showmessage('l''edizione del PDP è :  '+inttostr(edr));
//cerca la chiave R2 nel registro, se non dovesse esistere la crea
   mioreg:=Tregistry.Create;
   mioreg.rootkey:=HKEY_LOCAL_MACHINE;
   mioreg.openkey('\System\CurrentControlSet\Control\InstalledFiles',true);
//se c'e' il valore ne legge il record per controllare l'edizione
   if mioreg.valueExists(hfile) then
      begin
      mioreg.ReadBinaryData(hfile,cavtroia,sizeof(cavtroia));
      showmessage('sul registro l''edizione è :  '+inttostr(cavtroia.edizione));
      showmessage('sul registro la data è :'+datetostr(cavtroia.giorno));
      end else
      showmessage('non c''è il dato sul registro');

//scrive sul registro R2 data ed edizione
if messagedlg('vuoi scrivere sul registro?',mtconfirmation,[mbYes,mbNo],0)=mrYes
then begin
s1:=inputbox('scrivi sul reg','l''edizione è: ',inttostr(cavtroia.edizione));
cavtroia.edizione:=strtoint(s1);
s2:=inputbox('scrivi sul registro','la data è. ',datetostr(cavtroia.giorno));
cavtroia.giorno:=strtodate(s2);
      mioreg.WriteBinaryData(hfile,cavtroia,sizeof(cavtroia));
     end;
 //legge dal PDP la data dummy
         {$I-}
         AssignFile(F,nomefile);
         Reset(F,1);
         {$I+}
         esiste:=IOResult=0;
         fl:=fs;
           //ATTENZIONE li E' L'INDIRIZZO SUL PDP
          Seek(F,li);
         Blockread(F,fl,sizeof(fl));
         showmessage('sul file la data dummy è: '+fl);
         CloseFile(F);

//scrive sul PDP la data di inizio uso
 Fhandle:=Fileopen('Ricorda.exe',0);  //cattura gli attributi di prima
 prima:=FileGetDate(Fhandle);
 FileClose(Fhandle);

         {$I-}
         AssignFile(F,nomefile);
         Reset(F,1);
         {$I+}
         esiste:=IOResult=0;
 risp:= inputQuery('scrivi sul file','la data è (8 chr):  ',fs);
         if risp then
         begin
         fl:=fs;
         Seek(F,li);
         BlockWrite(F,fl,sizeof(fl));
         CloseFile(F);
 Fhandle:=Fileopen('Ricorda.exe',$0002);  //ricopia gli attributi di prima
 FileSetDate(Fhandle,prima);
 FileClose(Fhandle);
         end;
     except
     on ERegistryException do
     begin
      mioreg.deletevalue(hfile);
      showmessage('Si è verificato un errore imprevisto,'+
      ' occorre ripetere l''installazione');
      FreeMem(Buf,n);
     Application.destroy;
     end;
     on exception do
        begin
     showmessage('Si è verificato un errore imprevisto,'+
      ' occorre ripetere l''installazione');
     FreeMem(Buf,n);
     Application.destroy;
        end;
     end;
     FreeMem(Buf,n);
     Application.terminate;


end;



end.
// lasc@iol.it Milano 8.2.99


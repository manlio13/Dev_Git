unit ml040399;   //reg.exe per ricorda 32 ed.3.1 (ricompilata d5)

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs,
  StdCtrls,Registry, ExtCtrls, Buttons, SakMsg, SakSMTP;
 const
 io:string ='Manlio';
resourcestring
stessadir  ='Reg.exe va posto nella stessa directory di Ricorda ?';
errinstall ='Ricorda non è stato installato regolarmente, vuoi continuare?';
memo11     ='Verifica i dati sopra riportati o inseriscili.';
memo12     ='Se devi procedere a richiedere il codice di registrazione,puoi farlo:';
memo13     ='1- cliccando su COPIA, potrai poi incollare i dati su un testo da inviare a <mlsoft@iol.it>';
memo14     ='2- cliccando su MAILTO che prepara un messaggio e lo invia tramite il tuo collegamento internet.';
memo15     ='Se sei invece già in possesso del codice, dopo averlo inserito, clicca su REGISTRA.';
digitato1  ='<nome>@tin.it';
invito1    ='Digita il tuo indirizzo email';
invito2    ='Rispondere a :';
digitato2  ='mail.tin.it';
invito3    ='Il server che spedisce la posta';
invito4    ='Digita il nome del tuo server SMTP : ';
inviata    ='Grazie,la sua richiesta di registrazione è stata inviata.';
err1       ='Errore ';
noncomp    ='Questa versione di Ricorda non è compatibile con Reg.exe.';
noregcod   ='Manca il codice di registrazione.';
regcoderr  ='Codice di registrazione errato.';
err2       ='Errore imprevisto.Reinstalla Ricorda.';
regok      ='Complimenti, la registrazione è avvenuta correttamente.';
type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Memo1: TMemo;
    Label5: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo2: TMemo;
    SakSMTP1: TSakSMTP;
    SakMsg1: TSakMsg;
    BitBtn1: TBitBtn;
    Label6: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SakSMTP1AfterSend(Sender: TObject);
    procedure SakSMTP1Error(Sender: TObject; Error: Integer; Msg: String);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
   private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  mioreg:Tregistry;
nome,App,edstr:string;
n,m,ed,inst:integer;
vercdr,cdr:longint;
implementation

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);

begin
If messagedlg(stessadir,mtWarning,[mbYes,mbCancel],0)=mrCancel
then Application.terminate;
     inst:=0;
     mioreg:=Tregistry.create;
     mioreg.rootkey:=HKEY_LOCAL_MACHINE;//Attenzione aggiornare l'edizione
     if mioreg.KeyExists('\SOFTWARE\mlsoft\ricorda32\3.0.1.0') then
     begin
  mioreg.OpenKey('\SOFTWARE\mlsoft\ricorda32\3.0.1.0',false);
        if mioreg.valueexists('Name')then
        begin
           if mioreg.ReadString('Name')<>''then
           nome:=mioreg.ReadString('Name')else nome:=''
        end else
                begin
                nome:='';
                inst:=1;
                end;
        if mioreg.valueexists('AppName')then
        begin
           if mioreg.ReadString('AppName')<>''then
           App:=mioreg.ReadString('AppName')else App:=''
        end else
                begin
                App:='';
                inst:=1;
                end;
        if mioreg.valueexists('Edition')then
        begin
        if mioreg.readstring('Edition')<>'' then
        edstr:=mioreg.readstring('Edition')
        else Edstr:=''
        end else
                begin
                Edstr:='';
                inst:=1;
                end;
        if mioreg.valueexists('RegNo')then
        begin
        if mioreg.readinteger('RegNo')<>0 then
        cdr:=mioreg.readinteger('RegNo')
        else cdr:=0
        end else
                begin
                cdr:=0;
                inst:=1;
                end;
      edit1.text:=nome;        //riporta nella finestra i dati
      edit2.text:=App;         //letti nel registro
      edit3.text:=Edstr;
      edit4.text:=inttostr(cdr);
     end else
      begin
if messagedlg(errinstall,mtWarning,[mbYes,mbNo],0)=mrNO
then Halt;
mioreg.rootkey:=HKEY_Local_Machine;
mioreg.OpenKey('\system\CurrentControlSet\Control',false);
nome:=mioreg.ReadString('Current User');
edit1.text:=nome;
      end;
      if inst=1 then
                    begin
if messagedlg(errinstall,
mtWarning,[mbYes,mbNo],0)=mrNO then Halt;
mioreg.rootkey:=HKEY_Local_Machine;
mioreg.OpenKey('\system\CurrentControlSet\Control',false);
nome:=mioreg.ReadString('Current User');
edit1.text:=nome;
inst:=0;
                    end;
      memo1.clear;

memo1.lines[0]:=(memo11);
memo1.Lines.Add(memo12);
memo1.Lines.add(memo13);
memo1.lines.add(memo14);
memo1.Lines.add(memo15);


end;

procedure TForm1.Button1Click(Sender: TObject);  //copia
begin
memo2.clear;
memo2.lines.add(edit1.text);
memo2.lines.add(edit2.text);
memo2.lines.add(edit3.text);
memo2.lines.add(edit4.text);
memo2.selectall;
memo2.copytoclipboard;

end;

procedure TForm1.Button2Click(Sender: TObject);  //mailto
var
digitato: string;
scelta: boolean;
begin
 digitato:=digitato1;
 scelta:=inputquery(invito1,invito2,digitato);
 if scelta then
 sakMsg1.replyto:=digitato
 else exit;

 sakMsg1.from:=sakMsg1.replyto;

 digitato:=digitato2;
 scelta:=inputquery(invito3,invito4,digitato);
 if scelta then
 sakSMTP1.host:=digitato else exit;

memo2.clear;
memo2.lines.add(edit1.text);
memo2.lines.add(edit2.text);
memo2.lines.add(edit3.text);
memo2.lines.add(edit4.text);

sakMsg1.Text.Assign(Memo2.lines);
sakSMTP1.connect;
if not SakSMTP1.SMTPError then
begin
     SakSMTP1.SendMessage(SakMsg1);
     SakSMTP1.Quit;
end;
end;

procedure TForm1.SakSMTP1AfterSend(Sender: TObject);
begin
messagedlg(inviata,mtInformation,[mbOK],0);
end;

procedure TForm1.SakSMTP1Error(Sender: TObject; Error: Integer;
  Msg: String);
begin
 messagedlg(err1+ inttostr(error) +' '+ msg,
mtError,[mbOK],0);
  halt;
end;

procedure TForm1.Button3Click(Sender: TObject); //registra
var
 F:File;
 fl:string[8];
 codhex,codice,s,langidhex,val: string ;
ll,li:longint;
esiste:boolean;
prima,fhandle,cod,langid,n,edr,nn:integer;
buf:Pchar;
hnd:Dword;
valore:pointer;
begin
//calcolo del CDR
      nome:=edit1.text;
      App:=edit2.text;
      Edstr:=edit3.text;

 //estrazione edizione
  s:='Ricorda.exe';
  cod:=GetACP();             //API per ottenere il codepage usato
  langid:=GetUserDefaultLangID();  //API per ottenere l'ID della lingua usata
  codhex:=intToHex(cod,4);
  langidhex:=intToHex(langid,4);
  codice:=langidhex+codhex;
  n:=GetFileVersionInfoSize(PChar(s),hnd);
  Buf:=AllocMem(n); //definisce la dimensione del Buffer
  GetFileVersionInfo(PChar(s),hnd,n,Buf);
VerQueryValue(Buf,PChar('\StringFileInfo\'+codice+'\FileVersion'),Valore,hnd);
     val:=Pchar(valore);
     edr:=strtoint(copy(val,1,1));
     FreeMem(Buf,n);
 if edr<>strtoint(edstr)then
 begin
 showmessage(noncomp);
 application.terminate;
 end;
  vercdr:=0;
  for nn:=1 to length(nome) do    //UserName
  vercdr:=vercdr+ord(nome[nn]);
  for nn:=1 to length(App) do //Ricorda
  vercdr:=vercdr+ord(App[nn]);
   for nn:=1 to length(io) do // Manlio
  vercdr:=vercdr+ord(io[nn]);
  vercdr:=(vercdr+strtoint(edstr))*191135; //versione x 191135
  ll:=strtoint(edit4.text);//copia di nuovo il cdr
      if edit4.Text='' then
      begin
      messagedlg(noregcod,mterror,[mbok],0);
      exit;
      end else
      if vercdr<>ll then
      begin
messagedlg(regcoderr,mterror,[mbok],0);
exit;
      end else
      begin
   try         //al cambio di edizione occorre correggere
 if mioreg.KeyExists('\SOFTWARE\mlsoft\ricorda32\3.0.1.0') then
    begin
 mioreg.writeInteger('RegNo',ll);
 mioreg.free;
 Fhandle:=Fileopen('Ricorda.exe',0);  //cattura gli attributi di prima
 prima:=FileGetDate(Fhandle);
 FileClose(Fhandle);
         {$I-}
         AssignFile(F,'Ricorda.exe');
         Reset(F,1);
          {$I+}
         esiste:=IOResult=0;
         li:=$45DD8;    //att.indirizzo di scrittura
         fl:='02/02/02'; //codice di registrazione
         Seek(F,li);
         BlockWrite(F,fl,sizeof(fl));
         CloseFile(F);
 Fhandle:=Fileopen('Ricorda.exe',$0002);  //ricopia gli attributi di prima
 FileSetDate(Fhandle,prima);
 FileClose(Fhandle);
    end
 else raise eRegistryException.create('mancareg');
   except
 messagedlg(err2,Mterror,[mbOK],0);
 halt;
   end;
   Showmessage(regok);
   Application.terminate;
      end;
end;
procedure TForm1.BitBtn1Click(Sender: TObject);
begin
Application.HelpFile:= 'reg.hlp';
Application.HelpCommand(HELP_CONTENTS,0);
end;



end.

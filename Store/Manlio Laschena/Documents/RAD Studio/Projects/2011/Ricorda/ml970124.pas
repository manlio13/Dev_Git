{PROGRAMMA DI GESTIONE DELLE SCADENZE Ricorda 4.00  M.L. 2000  lasc@iol.it}
unit Ml970124;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Spin, Grids, Calendar,Printers,
  Unit2,Registry,shellapi;
type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    memlog: TButton;
    lista: TButton;
    cancella: TButton;
    Label5: TLabel;
    BitcercaD: TBitBtn;
    BitcercaE: TBitBtn;
    modifica: TButton;
    pulisci: TButton;
    ListBox1: TListBox;
    Timer1: TTimer;
    Cal: TCalendar;
    SpinButton1: TSpinButton;
    SpinButton2: TSpinButton;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    RadioBP: TRadioButton;
    RadioBS: TRadioButton;
    memorizza: TBitBtn;
    Timer2: TTimer;
    Bitprn: TBitBtn;
    PrintDialog1: TPrintDialog;
    Bithelp: TBitBtn;
    BF1: TButton;
    BF2: TButton;
    BF3: TButton;
    BF4: TButton;
    Label8: TLabel;
    RadioBM: TRadioButton;
    Label9: TLabel;
    Bitscad: TBitBtn;
    Bevel1: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    BitBtn1: TBitBtn;
    SpeedButton1: TSpeedButton;
    Bevel2: TBevel;
    Timer3: TTimer;
    Timer4: TTimer;
    SpeedButton2: TSpeedButton;
    procedure verifica(Sender: TObject);
    procedure memorizzaClick(Sender: TObject);
    procedure ordinamento(Sender: TObject);
    procedure CreaFClick(Sender: TObject);
    procedure listaClick(Sender: TObject);
    procedure cancellaClick(Sender: TObject);
    procedure BitcercaEClick(Sender: TObject);
    procedure BitcercaDClick(Sender: TObject);
    procedure aggiorna(Sender: TObject);
    procedure modificaClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CalChange(Sender: TObject);
    procedure ricxdata(sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton2DownClick(Sender: TObject);
    procedure SpinButton2UpClick(Sender: TObject);
    procedure pulisciClick(Sender: TObject);
    procedure RadioBPClick(Sender: TObject);
    procedure RadioBSClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitprnClick(Sender: TObject);
    procedure BithelpClick(Sender: TObject);
    procedure BF1Click(Sender: TObject);
    procedure BF2Click(Sender: TObject);
    procedure BF3Click(Sender: TObject);
    procedure BF4Click(Sender: TObject);
    procedure RadioBMClick(Sender: TObject);
    procedure BitscadClick(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure pulisciKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure memlogClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

  end;
  type                { ogni record occupa 92 bytes}
    Timpegno= record
        giorno: TdateTime;
        evento:string[80];
        tipo:string[2];
        end;
var
  Form1: TForm1;
  mioreg:Tregistry;
  dato,prec,seg,rimp,logrec :Timpegno;
  num :array[0..999] of integer;
  F: File of Timpegno;
  FS:File of Timpegno;//store dei record listati
  FK:File of Timpegno;//backup file
  numdato,kk,p,b,a,canc,errore,finale,cntr,RN:integer;
  //numdato serve per localizzare il dato da cancellare o modificare
  //nomem serve per escludere l'uso di memlog in alcuni casi
  nomem:smallint;
  din,dfin,dcal,dummy1:Tdatetime;
  etichetta,nf,nfk:string;
  dummy:string[8];
  dmy:int64;
  n1:longint;
  carry:real;
const
F1='.\ricorda1.dat';
F2='.\ricorda2.dat';
F3='.\ricorda3.dat';
F4='.\ricorda4.dat';
F1k='.\ricorda1.dak';
F2k='.\ricorda2.dak';
F3k='.\ricorda3.dak';
F4k='.\ricorda4.dak';

  implementation

{$R *.DFM}
procedure TForm1.FormCreate(Sender: TObject);
var
 giorni,manca:double;
begin
     dmy:=strtoint64('12345678901'); //stringa per poterla trovare nell'exe
     nomem:=1;
 mioreg:=Tregistry.create;
     mioreg.rootkey:=HKEY_LOCAL_MACHINE;
     mioreg.OpenKey('\SOFTWARE\mlsoft\ricorda32',false);
     if mioreg.ValueExists('RegNo') then
        begin
        RN:=mioreg.ReadInteger('RegNo');
//verifica una globale
     if RN=19111935 then
     if fileexists('.\ricorda1.dat') then
exit else
     begin
     nF:=F1;
     creaFClick(nil);
     exit;
     end;
//controlla il cdr
GetVolumeInformation(Pchar(nil),nil,0,@n1,
Dword(nil^),Dword(nil^),nil,0);
 carry:=dmy+n1;    //combina il nvol con il dummy
 messagedlg('ecco :'+floattostr(carry),mtInformation,[MbOK],0);
while carry>999999999 do
   begin
   carry:=carry/10;
   carry:=int(carry);
   end;
if RN=carry then   //verifica la registrazione
if fileexists('.\ricorda1.dat') then
exit else
     begin
     nF:=F1;
     creaFClick(nil);
     exit;
     end;

//fine del controllo
        end;
//



//-----------------------------------------------
nomem:=1;
  // dummy=02/02/02 se registrato, 03 se extra con pw globale,01 se nuovo.
DateSeparator:='/'; //per prevenire che con un diverso separatore fallisca
shortDateFormat:='dd/mm/yyyy';//per compatibilità Y2K
dummy1 :=strtodate('02/01/01');  //la protezione della data
 //ATTENZIONE 02/02/02 VA SOSTITUITO CON 01 ecc PER LA COMPILAZIONE FINALE
dummy:='03/03/03';//qui' c'e' la DATA-REGISTRAZIONE che inimlsw modifica
 if (dummy1-strtodate(dummy)=1)then //se è vergine
              begin
              showmessage('Ricorda va installato eseguendo RicXXX.exe.');
              halt;
              end;
  if (strtodate(dummy)-dummy1>1000)then //se ha una qualche data
    begin
   giorni:=date()-strtoDate(dummy);
   manca:=30-giorni;
   showmessage('Ricorda usato '+floattostr(giorni)+' giorni,valido '+
    floattostr(manca)+' giorni');
   if manca<=0 then
      begin
   showmessage('Il periodo di prova è terminato.');
   application.terminate;
      end else
if fileexists('.\ricorda1.dat') then
exit else
     begin
     nF:=F1;
     creaFClick(nil);
     exit;
     end;
    end;
  if dummy='03/03/03'then //se ha una pw globale
if fileexists('.\ricorda1.dat') then
   begin
exit;
   end else
     begin
     nF:=F1;
     creaFClick(nil);
     exit;
     end;

  if (strtodate(dummy)-dummy1=396)then //se dummy è 02/02/02
    begin
    verifica(nil); // controlla il registro
    if fileexists('.\ricorda1.dat') then
    begin
    exit;
    end else
     begin
     nF:=F1;
     creaFClick(nil);//se non c'e' ricorda1 lo ricrea
     exit;
     end;
    end else //se non è 02/02/02, nè una data reale, alla fine dei controlli
    // c'e' qualcosa di non previsto
    begin
    showmessage('Errore inatteso, reinstallare o mailto: MLsoft@iol.it');
    halt;
    end;
end;
procedure TForm1.FormActivate(Sender: TObject);
begin
{$I-}
 AssignFile(FS,'log.dat');
 if fileexists('log.dat') then
 begin
       Reset(FS);
       if filesize(FS)=0 then
       bitbtn1.font.color:=clgreen else
       bitbtn1.font.color:=clred;
       //non chiude FS per poterlo utilizzare in seguito
 end  else
                begin
 bitbtn1.font.color:=clgreen;
 Rewrite(FS);
 showmessage('E'' stato creato il log degli eventi trascorsi.');
 //non chiude FS per utilizzarlo in seguito
                end;
  {$I+}
 timer3.enabled:=true;
 errore:=IOResult;
 nf:=F1;
 label8.caption:='attivo : ricorda 1';
 timer2.enabled:=not(timer2.enabled);
 if fileexists('.\ricorda1.dat')=false then
 exit;
 aggiorna(nil); //ti mostra tutti gli impegni già scaduti e aggiorn./cancellati
 bitscadclick(nil); //ti mostra le prossime scadenze
 end;
procedure TForm1.aggiorna(Sender: TObject);
 label 1,2;              //nb. gestisce solo gli scaduti
var
i,n,temp,ecc,ii :integer;
d:TdateTime;
aa,g,m,ar,mr: word;
begin
       canc:=0;
       pulisciclick(nil);
       {$I-}
       AssignFile(F,nf);
       Reset(F);
       if filesize(F)=0 then
       begin
       CloseFile(F);
       exit;
       end;
       {$I+}
       errore:=IOResult;
      // for i:=0 to 999 do
      // num[i]:=0;    //reset del contatore dei dati
       a:=0;
       i:=0;
       temp:=0;
   //crea il file di backup Ricorda(nf).dak
   if nf=F1 then nfk:=F1k
   else if nf=F2 then nfk:=F2k
   else if nf=F3 then nfk:=F3k
   else if nf=F4 then nfk:=F3k; //così è stato definito nfk
   {$I-}
   AssignFile(FK,nfk);
   rewrite(FK);
   for ii:=0 to filesize(F)-1 do
   begin          //copia il file dat nel file dak
   seek(F,ii);
   read(F,dato);
   seek(FK,Filesize(FK));
   write(FK,dato);
   end;
   closefile(FK);
   {$I+}
   errore:=IOResult;
    seek(F,0);   //occorre riportare il file all'inizio dopo la copia di bckup
        {$I-}     //che l'ha portato alla fine
       While not Eof(F) do
          begin
          seek(F,i);
          read(F,dato);
          d:= dato.giorno;
          if (d<date)and (dato.tipo='P') then
                   begin
               listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento);
              //numdato:=filepos(F)-1;
              logrec:=dato;  //pone in logrec il dato per memorizzarlo
              Seek(FS,Filesize(FS)); //su log.dat
              write(FS,logrec);
              bitbtn1.font.Color:=clred;
               //num[a]:=i;   // conta il dato trovato e così negli altri casi
               //a:=a+1;
              decodedate(date,aa,m,g); {rif a date come spiegato avanti}
              decodedate(d,ar,mr,g);//per il giorno si usa una sola variabile
                                     //    quella reale
              2: //label per il ritorno in caso di bisestile
              ecc:=0;
              try
              d:=encodedate(aa,mr,g);
              if d<date then
              d:= encodedate(aa+1,mr,g);
              except
              on EConvertError do
                begin
              g:=g-1;{per gestire il fine mese variabile}
              ecc:=1;//effettua un loop per verificare che l'errore sia corretto
                end;// es. il caso che si passi dal 29.2 al 28.2 è pluriloops
              end;
              if ecc=1 then goto 2;
              dato.giorno:=d;
              seek(F,i);   {att.occorre sempre porre seek prima di write}
              write(F,dato);
              canc:=1;
                   end;
           if (d<date)and (dato.tipo='M') then
                   begin
              listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento);
              //numdato:=filepos(F)-1;
              logrec:=dato;  //pone in logrec il dato per memorizzarlo
              Seek(FS,Filesize(FS)); //su log.dat
              write(FS,logrec);
              bitbtn1.font.Color:=clred;
              //num[a]:=i;
              //a:=a+1;
              decodedate(date,aa,m,g);//rif a date per aggiornare anche i molto
                                       //vecchi
              decodedate(d,ar,mr,g);
              1:      //label per il ritorno in caso di errore per la verifica
              ecc:=0;
              try
              d:= encodedate(aa,mr,g);
              if d<date then          {potrebbe essere solo l'anno antecedente}
              d:=encodedate(aa,m,g);
              if d<date then       {potrebbe essere ancora nel corrente mese}
                 begin
              if m=12 then
                    begin        {per gestire gli eventi mensili di dicembre}
                    m:=0;
                    aa:=aa+1;
                    end;
              d:=encodedate(aa,m+1,g);
                 end;
              dato.giorno:=d;
              except
              on EConvertError do
                begin
              g:=g-1;{per gestire il fine mese variabile}
              ecc:=1;//effettua un loop per verificare che l'errore sia corretto
                end;// es. il caso che si passi dal 31.1 al 28.2 è pluriloops
              end;
              if ecc=1 then goto 1;

              seek(F,i);   {att.occorre sempre porre seek prima di write}
              write(F,dato);
              canc:=1;
                   end
                   else
            if (d<date)and(dato.tipo='S')then
                  begin
                 //num[a]:=i; //incrementa il contatore
                 //a:=a+1;
                 temp:=1;
      listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento+'#'+dato.tipo);
       //numdato:=filepos(F)-1;
       logrec:=dato;  //pone in logrec il dato per memorizzarlo
       Seek(FS,Filesize(FS)); //su log.dat
       write(FS,logrec);
       bitbtn1.font.Color:=clred;
            for n:=filepos(F) to filesize(F)-1 do
   {att.filepos si e' gia' incrementato di un posto}
                  begin
    seek(F,n);   {per cancellare devo sovrascrivere con il successivo}
    read(F,dato);
    seek(F,n-1);
    write(F,dato);
                  end;
    seek(F,filesize(F)-1);
    truncate(F); {poi devo tagliare via l'ultimo che e' doppio}
    closeFile(F); // è risultato necessario resettare il file quando se ne
    Reset(F);//altera la dimensione. I contatori sono sballati
    i:=i-1;
                  end;
 i:=i+1;  {incrementa il contatore della ricerca}
          end;
 label9.caption:='Att. questi impegni periodici sono trascorsi';
 if temp>0 then
 messagedlgPos('Gli impegni saltuari(S) sono stati cancellati',
 mtwarning,[mbOK],0,10,100);
 if canc=1 then
 messagedlgPos('Uno o più impegni periodici risultano trascorsi.',mtwarning,
                    [mbOK,mbHelp],1,10,100);
 closeFile(F);
 {$I+}
            errore:=IOResult;

 ordinamento(nil);

end;
procedure Tform1.ordinamento(Sender: TObject);
var
v,v1:integer;
begin
{$I-}
AssignFile(F,nf);
Reset(F);

for v:=0 to (Filesize(F)-2) do
      begin
      p:=v;    {memorizza l'indirizzo in esame}
      seek(F,v);
      read(F,prec);
      rimp:=prec;     {isola in rimp il dato in esame}

                 for v1:=v+1 to Filesize(F)-1 do //cerca uno precedente a partire
                                                //dal successivo
                     begin
                     seek(F,v1);
                     read(F,seg);
                     if seg.giorno<prec.giorno then
                        begin
                        p:=v1;
                        prec:=seg; {se lo trova lo nomina prec per lo scambio}
                        end;
                     end;
                          if v<>p then {qui' avviene lo scambio}
                            begin
                            seek(F,v);
                            write(F,prec);//pone il minore in assoluto al posto
                                          //del record in esame a
                            seek(F,p);
                            write(F,rimp);//pone il rec. in esame al posto
                                          // dell'ultimo trovato
                            end;
      end;
closeFile(F);
{$I+}
errore:=IOResult;
end;

procedure TForm1.memorizzaClick(Sender: TObject);

begin
label11.caption:='';
label9.caption:='';
if (edit1.text='')or(edit2.text='')or(edit3.text='')then
                                                        begin
messagedlg('manca un dato',mtWarning,[mbOK],0);
exit;
                                                        end
else
    begin

dato.giorno:=dcal;      {entry diretto per evitare l'errore delle date >2000}
dato.evento:=edit2.text;{che accadrebbe se l'entry avvenisse con una stringa}
dato.tipo:=edit3.text;  {shortdateformat es. 31.12.00 }
{$I-}
AssignFile(F,nf);
Reset(F);
{$I+}
errore:=IOResult;
Seek(F,Filesize(F));
write(F,dato);
dato.giorno:=0;
dato.evento:='';
dato.tipo:='';
pulisciclick(nil);
messagedlg('Il dato e''stato registrato.',mtINformation,[mbOK],0);
closeFile(F);
ordinamento(nil);
    end;
 end;

procedure TForm1.CreaFClick(Sender: TObject);
 {verifica l'esistenza di un file e lo crea se manca}
var
esiste: boolean;
begin
label9.caption:='';
{$I-}
AssignFile(F,nf);
Reset(F);
{$I+}
esiste:=IOResult=0;
if esiste then
messagedlg('Ricorda.dat già esiste.',mtInformation,[mbOK],0)
          else
          begin
        //  {$I-}
        try
          AssignFile(F,nf);
          rewrite(F);
        except
         // {$I+}
        //  errore:=IOResult;
  messagedlg('Errore di sistema nel creare il file dati',mtError,[mbOK],0);
  halt;
         end;
          messagedlg('RicordaX.dat e'' stato creato.',mtInformation,[mbOK],0);
          end;
closeFile(F);
end;

procedure TForm1.listaClick(Sender: TObject); {scroll}
var
k:integer;
begin
pulisciclick(nil);
label9.caption:='Att. gli impegni periodici sono con data attualizzata';
{$I-}
AssignFile(F,nf);
Reset(F);
{$I+}
errore:=IOResult;
listbox1.clear;
for k:=0 to filesize(F)-1 do
    begin
Seek(F,k);
Read(F,dato);
listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento);
    end;
closeFile(F);
end;

procedure TForm1.cancellaClick(Sender: TObject);
var
i:integer;
begin
label11.caption:='';
label9.caption:='';
 if (edit1.text='')or(edit2.text='')  then
                   begin
 messagedlg('Non vi è nulla da cancellare !',mtwarning,[mbOK],0);
 pulisciclick(nil);
 exit;
                   end;
 if messagedlg('Vuoi cancellare questo dato ?',mtconfirmation,[mbYes,mbNo],0)
= mrYes then
  begin
  {$I-}
AssignFile(F,nf);
Reset(F);
  {$I+}
  errore:=IOResult;
for i:=numdato+1 to filesize(F)-1 do
                  begin
    seek(F,i);   {per cancellare devo sovrascrivere con il successivo}
    read(F,dato);
    seek(F,i-1);
    write(F,dato);
                  end;
    seek(F,filesize(F)-1);
    truncate(F); {poi devo tagliare via l'ultimo che e' doppio}
    closeFile(F);
    pulisciclick(nil);
  end
  else
if IOresult<>0 then
messagedlg('Non ho accesso ai dati !',mtError,[mbOK],0);
pulisciclick(nil);
end;

procedure TForm1.BitcercaEClick(Sender: TObject);
var
s:string;
i,n:integer;
begin
nomem:=0; //per consentire il memlog
label9.caption:='';
  pulisciclick(nil);
  s:=inputbox('Ricerca','Digita il testo da ricercare','');
  {$I-}
  AssignFile(F,nf);
  Reset(F);
  {$I+}
  errore:=IOResult;
   for i:=0 to 999 do
   num[i]:=0;  //reset del contatore di dati
   a:=0;
       for i:=0 to filesize(F)-1 do
          begin
          seek(F,i);
          read(F,dato);
          n:= pos(s,dato.evento); //cerca nel dato il testo s
          if n>0 then
                 begin
       listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento);
       num[a]:=i;   //conta i dati controllati
       a:=a+1;
if messagedlg('Vuoi cercare il dato successivo ?',mtConfirmation,[mbYES,mbNO],0)
   = mrNO then
          begin
          finale:=a-1;
          closeFile(F);
          exit;
          end;
                 end;
    end;
    messagedlg('Ricerca nulla',mtinformation,[mbOK],0);
    closeFile(F);
    finale:=a-1;
end;

procedure TForm1.BitcercaDClick(Sender: TObject);
     begin
  label9.caption:='';
  kk:=0;
  messagedlg('clicca sul giorno di inizio ricerca',mtconfirmation,[mbOK],0);
  kk:=1
     end;

procedure Tform1.Ricxdata(Sender:TObject);
var
d:Tdatetime;
i:integer;
                   begin
  nomem:=0;
  pulisciclick(nil);
  {$I-}
  AssignFile(F,nf);
  Reset(F);
  {$I+}
  errore:=IOResult;
  for i:=0 to 999 do
  num[i]:=0;  //reset del contatore dei dati
  a:=0;
      for i:=0 to filesize(F)-1 do
          begin
          seek(F,i);
          read(F,dato);
          d:= dato.giorno;
          if (d>=din) and (d<=dfin) then
             begin
       listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento);

       num[a]:=i; //conta i dati trovati
       a:=a+1;
             end;
          end;
  if listbox1.items.count>0 then
  begin
  messagedlg('Esamina la lista',mtinformation,[mbOK],0);
  cntr:=1;
  finale:=a-1;
  end                    else
  messagedlg('Ricerca nulla',mtinformation,[mbOK],0);
                   closeFile(F);
                   end;


procedure TForm1.modificaClick(Sender: TObject);
begin
label11.caption:='';
label9.caption:='';
        If (edit1.text='') or (edit2.text='') then
        begin
    messagedlg('non c''è nulla da modificare',mtwarning,[mbOK],0);
    exit;
        end;
       {$I-}
       AssignFile(F,nf);
       reset(F);
       {$I+}
       errore:=IOResult;
       dato.giorno:=dcal;
       dato.evento:=edit2.text;
       dato.tipo:=edit3.text;

       seek(F,numdato);
       write(F,dato);
       pulisciclick(nil);
       messagedlg('Il dato e'' stato modificato.',mtInformation,[mbOK],0);
closeFile(F);
ordinamento(nil);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
label4.caption:=intTostr(cal.year);
label6.caption:=intTostr(cal.month);
label7.caption:=timetostr(time);
end;

procedure TForm1.CalChange(Sender: TObject);//una variazione del calendario
begin                  //equivale ad un qualsiasi entry di data
label9.caption:='';
RadioBSClick(nil);
     if (kk=0)then
edit1.text:=datetostr(cal.calendardate); //sul display
dcal:=cal.calendardate;    // nel dato reale
edit2.setfocus;
if kk=1 then
begin
 din:=cal.calendardate;
 kk:=2;
 messagedlg('clicca sul giorno di fine ricerca',mtconfirmation,[mbOK],0);
 end
 else
     if kk=2 then
 begin
 dfin:=cal.calendardate;
 kk:=0;
if messagedlg('Ricerca da '+datetostr(din)+' a '+datetostr(dfin),mtconfirmation,
[mbyes,mbno],0)=mrNo then exit;
 ricxdata(nil);
 end;
end;

procedure TForm1.SpinButton1DownClick(Sender: TObject);
begin
cal.prevyear;
label4.caption:=inttostr(cal.year);
end;

procedure TForm1.SpinButton1UpClick(Sender: TObject);
begin
cal.nextyear;
label4.caption:=inttostr(cal.year);
end;

procedure TForm1.SpinButton2DownClick(Sender: TObject);
begin
cal.prevmonth;
label6.caption:=inttostr(cal.month);
end;

procedure TForm1.SpinButton2UpClick(Sender: TObject);
begin
cal.nextmonth;
label6.caption:=inttostr(cal.month);
end;

procedure TForm1.pulisciClick(Sender: TObject);
begin

   label9.caption:='';
   listbox1.clear;
   edit1.text:='';
   edit2.text:='';
   label11.caption:='';//posizionato dopo la variazione di Edit2
   edit3.text:='';
  RadioBP.checked:=false;  {occorre per consentire al radioB di resettarsi}
  RadioBM.checked:=false;
  RadioBS.checked:=false;
end;

procedure TForm1.RadioBPClick(Sender: TObject);
begin
 Edit3.text:='P';
 RadioBP.checked:=true;
 RadioBS.checked:=false;
 RadioBM.checked:=false;
end;
procedure TForm1.RadioBMClick(Sender: TObject);
begin
 Edit3.text:='M';
 RadioBS.checked:=false;
 RadioBP.checked:=false;
end;

procedure TForm1.RadioBSClick(Sender: TObject);
begin
edit3.text:='S';
RadioBP.checked:=false;
RadioBM.checked:=false;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
   etichetta:= label5.caption;
   label5.caption:=copy(etichetta,2,length(etichetta)-1)
   +copy(etichetta,1,1);
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
var nn:integer;     //se doppio click al dato nella list box
begin
 {$I-}
 AssignFile(F,nf); {apro il file e lo chiudo al di fuori dei loops}
 Reset(F);
 {$I+}
 errore:=IOResult;
   for nn:=0 to 999 do
    begin
 if listbox1.selected[nn] then
                          begin
                           seek(F,nn);
                           read(F,dato);
                           edit1.text:=datetostr(dato.giorno);
                           dcal:=dato.giorno;
                           edit2.text:=dato.evento;
                           edit3.text:=dato.tipo;
                           numdato:=nn;
                             {per localizzare il dato nel caso di modifica}
                             //o di cancellazione. quì num passa il # a numdato
                           break;
                          end;
    end;
closeFile(F);
end;



{stampa }
procedure TForm1.BitprnClick(Sender: TObject);
 var
  PrintFile: TextFile;
  ln: Integer;
  nome:string;
begin
   if listbox1.items.count=0 then
   begin
   messagedlg('Non c''è nulla da stampare',mtwarning,[mbOK],0);
   exit;
   end;
   if PrintDialog1.Execute then
      begin
     mioreg:=Tregistry.create;
     mioreg.rootkey:=HKEY_LOCAL_MACHINE;//Attenzione aggiornare l'edizione
     if mioreg.KeyExists('\SOFTWARE\mlsoft\ricorda32\3.0.1.0') then
        begin
     mioreg.OpenKey('\SOFTWARE\mlsoft\ricorda32\3.0.1.0',false);
        if mioreg.valueexists('Name') then
              nome:=mioreg.ReadString('Name');
        end;
    AssignPrn(PrintFile);
    Rewrite (PrintFile);
writeln(Printfile,'Stampa lista Ricorda32 al  '+datetostr(date)+' per '+nome);
writeln(PrintFile,' data  |  evento');
writeln(Printfile,' ');
      for ln:= 0 to listbox1.items.Count - 1 do
      Writeln (PrintFile, listbox1.items[ln]);
      System.CloseFile (PrintFile);
       end;

end;

procedure TForm1.BithelpClick(Sender: TObject);
begin
Application.HelpFile:= '.\ricorda.hlp';
Application.HelpCommand(HELP_FINDER,0); //per la versione 4.0 di winhelp
end;

procedure TForm1.BF1Click(Sender: TObject);
begin
   nf:=F1;
   label8.caption:='attivo : ricorda 1';
   creafclick(nil);
   aggiorna(nil);
   bitscadclick(nil);
end;
procedure TForm1.BF2Click(Sender: TObject);
begin
   nf:=F2;
   label8.caption:='attivo : ricorda 2';
   creafclick(nil);
   aggiorna(nil);
   bitscadclick(nil);
end;

procedure TForm1.BF3Click(Sender: TObject);
begin
   nf:=F3;
   label8.caption:='attivo : ricorda 3';
   creafclick(nil);
   aggiorna(nil);
   bitscadclick(nil);
end;

procedure TForm1.BF4Click(Sender: TObject);
begin
   nf:=F4;
   label8.caption:='attivo : ricorda 4';
   creafclick(nil);
   aggiorna(nil);
   bitscadclick(nil);
end;

procedure TForm1.BitscadClick(Sender: Tobject);
var
q:integer;
rif:Tdatetime;
begin
  pulisciclick(nil);
  q:=0;
  {$I-}
  AssignFile(F,nf);
  Reset(F);
  if filesize(F)=0 then
                   begin
   shoWmessage('Non vi sono eventi registrati.');
   closefile(F);
   exit;
                   end;
  {$I+}
  errore:=IOResult;
  seek(F,0);
  read(F,dato);
  listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento);
  rif:=dato.giorno;
while not Eof(F) do
	begin
q:=q+1;
seek(F,q);
read(F,dato);
if dato.giorno=rif then
begin
listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento);
end else
    begin
break;
    end;

	end;
   closeFile(F);
   messagedlgPos('Attenzione, in scadenza',mtinformation,[mbOK],0,10,100);
end;

procedure TForm1.Edit1Click(Sender: TObject);
begin
messagedlg('Immettere la data con un doppio click sul calendario',mtinformation
,[mbOK],0);
end;



//per rivelare la data dummy
procedure TForm1.pulisciKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if(shift=[ssAlt])and(key=VK_SPACE)then
showmessage('dummy è '+dummy);
end;



procedure TForm1.Edit2Exit(Sender: TObject);
begin
  label11.caption:='Fissa se periodico, mensile o saltuario   -->';
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
closefile(FS);
end;

procedure TForm1.BitBtn1Click(Sender: TObject);//LOG
var
logform:Tform2;
begin
 logform:=Tform2.Create(self);
 logform.showmodal;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
close;
end;

procedure TForm1.verifica(Sender: Tobject); //se 02/02/02 verifica il registro
var
nome,AppName,io:string;
n:integer;
vercdr,cdr:longint;
begin
     cdr:=0;
     mioreg:=Tregistry.create;
     mioreg.rootkey:=HKEY_LOCAL_MACHINE;//Attenzione aggiornare l'edizione
     //per adattare il path del registro
     if mioreg.KeyExists('\SOFTWARE\mlsoft\ricorda32\3.0.1.0') then
        begin
  mioreg.OpenKey('\SOFTWARE\mlsoft\ricorda32\3.0.1.0',false);
        if mioreg.valueexists('Name')and mioreg.valueexists('RegNo') then
           try
        nome:=mioreg.ReadString('Name');
        cdr:=mioreg.readinteger('RegNo');
           except
              //se mancano i dati sul registro
messagedlg('Dati di registrazione corrotti, occorre rilanciare Reg.exe',
           mtError,[mbOK],0);
           mioreg.free;
           halt;
               end;
        end else
               begin  //se manca la chiave sul registro
messagedlg('Dati di installazione mancanti, reinstallare Ricorda',
           mtError,[mbOK],0);
           mioreg.free;
           halt;
               end;
  io:='Manlio';
  AppName:='Ricorda';
  vercdr:=0;
  for n:=1 to length(nome) do    //UserName
  vercdr:=vercdr+ord(nome[n]);
  for n:=1 to length(AppName) do //ricorda
  vercdr:=vercdr+ord(AppName[n]);
   for n:=1 to length(io) do // Manlio
  vercdr:=vercdr+ord(io[n]);
  vercdr:=(vercdr+3)*191135; //versione x 191135
  if vercdr<>cdr then
  begin
messagedlg('Dati di registrazione corrotti, occorre rilanciare Reg.exe',
           mtError,[mbOK],0);
           mioreg.free;
           halt;
  end;
mioreg.free;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
 bitbtn1.caption:='Log';
end;

procedure TForm1.Timer4Timer(Sender: TObject);
begin
bitbtn1.caption:='';
end;

procedure TForm1.memlogClick(Sender: TObject);
var
kr,kw:integer;
begin
 //lavori in corso  nb finale  è 0 se non viene lanciata una lista o ricerca
if listbox1.items.count=0 then
begin
showmessage('Non c''è nulla da memorizzare');
exit;
end;
if nomem=1 then
        begin
showmessage('Operazione non consentita');
exit;
        end;
  kw:=Filesize(FS); //si posiziona su FS
   {$I-}
  AssignFile(F,nf);
  Reset(F);
   {$I+}
        for kr:=0 to finale do
        begin
                  seek(F,num[kr]);
                  read(F,dato);
                  seek(FS,kw);
                  write(FS,dato);
                  bitbtn1.font.Color:=clred;
                  kw:=kw+1;
        end;
closeFile(F);
finale:=0;
pulisciclick(nil);
nomem:=1;//per ripristinare la condizione di default per memlog
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
cal.usecurrentdate:=true;
end;

end.



//{Ricorda 4.00.48 sorgente	5.10.2000 }

















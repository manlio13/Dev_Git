{PROGRAMMA DI GESTIONE DELLE SCADENZE Ricorda 3.0  M.L. 1998  lasc@iol.it}
unit Ml970124;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Spin, Grids, Calendar,Printers;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CreaF: TButton;
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
    procedure RadioBSKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
  dato,prec,seg,rimp :Timpegno;
  num :array[0..999] of integer;
  F: File of Timpegno;
  numdato,kk,p,b,a,k,canc :integer;
  din,dfin,dcal:Tdatetime;
  etichetta,nf:string;
const
F1='.\ricorda1.dat';
F2='.\ricorda2.dat';
F3='.\ricorda3.dat';
F4='.\ricorda4.dat';

  implementation

{$R *.DFM}

procedure TForm1.memorizzaClick(Sender: TObject);

begin
label9.caption:='';
if (edit1.text='')or(edit2.text='')or(edit3.text='')then
                                                        begin
messagedlg('manca dato',mtWarning,[mbOK],0);
exit;
                                                        end
else
    begin
dato.giorno:=0;
dato.evento:='';
dato.tipo:='';
k:=0;
 while k=0 do
 begin
dato.giorno:=dcal;      {entry diretto per evitare l'errore delle date >2000}
dato.evento:=edit2.text;{che accadrebbe se l'entry avvenisse con una stringa}
dato.tipo:=edit3.text;  {shortdateformat es. 31.12.00 }
if (dato.tipo<>'P')and(dato.tipo<>'S')and(dato.tipo<>'M')then
              begin
   messagedlg('Inserisci P o M(periodico) o S (saltuario)',mterror,[mbOK],0);
   exit;
              end
                                     else
              begin
k:=1;
dato.tipo:=edit3.text;
AssignFile(F,nf);
Reset(F);
Seek(F,Filesize(F));
write(F,dato);
dato.giorno:=0;
dato.evento:='';
dato.tipo:='';
pulisciclick(nil);
messagedlg('Il dato e''stato registrato.',mtINformation,[mbOK],0);
              end;
 end;
 k:=0;
closeFile(F);
ordinamento(nil);
    end;
 end;
procedure Tform1.ordinamento(Sender: TObject);
var
v,v1:integer;
begin
AssignFile(F,nf);
Reset(F);
for v:=0 to (Filesize(F)-2) do
      begin
      p:=v;    {memorizza l'indirizzo in esame}
      seek(F,v);
      read(F,prec);
      rimp:=prec;     {isola in rimp il dato in esame}

                 for v1:=v+1 to Filesize(F)-1 do {cerca uno precedente a partire
                                                dal successivo}
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
                            write(F,prec);{pone il minore in assoluto al posto
                                          del record in esame a}
                            seek(F,p);
                            write(F,rimp);{pone il rec. in esame al posto
                                           dell'ultimo trovato}
                            end;
      end;
closeFile(F);
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
          AssignFile(F,nf);
          rewrite(F);
          messagedlg('RicordaX.dat e'' stato creato.',mtInformation,[mbOK],0);
          end;
closeFile(F);
end;

procedure TForm1.listaClick(Sender: TObject); {scroll}
var
k:integer;
begin
k:=0;
pulisciclick(nil);
label9.caption:='Att. gli impegni periodici sono con data attualizzata';
AssignFile(F,nf);
Reset(F);
listbox1.clear;
for k:=0 to 999 do
num[k]:=0;
for k:=0 to filesize(F)-1 do
    begin
Seek(F,k);
Read(F,dato);
listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento);
num[k]:=k;
    end;
closeFile(F);
end;

procedure TForm1.cancellaClick(Sender: TObject);
var
i:integer;
begin
label9.caption:='';
 if (edit1.text='') then
                   begin
 messagedlg('Non vi è nulla da cancellare !',mtwarning,[mbOK],0);
 exit;
                   end;
 if messagedlg('Vuoi cancellare questo dato ?',mtconfirmation,[mbYes,mbNo],0)
= mrYes then
  begin
AssignFile(F,nf);
Reset(F);
for i:=numdato+1 to filesize(F)-1 do
                  begin
    seek(F,i);   {per cancellare devo sovrascrivere con il successivo}
    read(F,dato);
    seek(F,i-1);
    write(F,dato);
                  end;
    seek(F,filesize(F)-1);
    truncate(F); {poi devo tagliare via l'ultimo che e' doppio}
    pulisciclick(nil);
  end
  else
if IOresult<>0 then
messagedlg('Non ho accesso ai dati !',mtError,[mbOK],0);
closeFile(F); 
end;

procedure TForm1.BitcercaEClick(Sender: TObject);
var
s:string;
i,n:integer;
begin
label9.caption:='';  
  pulisciclick(nil);
  s:=inputbox('Ricerca','Digita il testo da ricercare','');
  AssignFile(F,nf);
  Reset(F);
   for i:=0 to 999 do
   num[i]:=0;
   a:=0;
       for i:=0 to filesize(F)-1 do
          begin
          seek(F,i);
          read(F,dato);
          n:= pos(s,dato.evento);
          if n>0 then
                 begin
       listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento);
       edit1.text:=dateTostr(dato.giorno);
       edit2.text:=dato.evento;
       edit3.text:=dato.tipo;
       num[a]:=i;
       a:=a+1;
if messagedlg('Vuoi cercare il dato successivo ?',mtConfirmation,[mbYES,mbNO],0)
   = mrNO then
          begin
          numdato:=filepos(F)-1;
          exit;
          end;
                  end;
    end;
    messagedlg('Ricerca nulla',mtinformation,[mbOK],0);
    closeFile(F);
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
  pulisciclick(nil);
  AssignFile(F,nf);
  Reset(F);
  for i:=0 to 999 do
  num[i]:=0;
  a:=0;
      for i:=0 to filesize(F)-1 do
          begin
          seek(F,i);
          read(F,dato);
          d:= dato.giorno;
          if (d>=din) and (d<=dfin) then
             begin
       listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento);
        num[a]:=i;
        a:=a+1;
             end; 
          end;
  if listbox1.items.count>0 then
  messagedlg('Esamina la lista',mtinformation,[mbOK],0)
                      else
  messagedlg('Ricerca nulla',mtinformation,[mbOK],0);
                   closeFile(F);
                   end;

procedure TForm1.aggiorna(Sender: TObject);

var
i,n,temp :integer;
d:TdateTime;
aa,g,m,ar,mr: word;
errore:integer;

begin
       canc:=0;
       pulisciclick(nil);
       AssignFile(F,nf);
       Reset(F);
       for i:=0 to 999 do
       num[i]:=0;
       a:=0;
       i:=0;
       temp:=0;
        {$I-}
       While not Eof(F) do
          begin
          seek(F,i);
          read(F,dato);
          d:= dato.giorno;
          if (d<date)and (dato.tipo='P') then
                   begin
               listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento);
               num[a]:=i;
               a:=a+1;
              decodedate(date,aa,m,g); {rif a date come spiegato avanti}
              decodedate(d,ar,mr,g);{per il giorno si usa una sola variabile
                                         quella reale}
              d:=encodedate(aa,mr,g);
              if d<date then
              d:= encodedate(aa+1,mr,g);
              dato.giorno:=d;
              seek(F,i);   {att.occorre sempre porre seek prima di write}
              write(F,dato);
              canc:=1;
                   end;
           if (d<date)and (dato.tipo='M') then
                   begin
              listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento);
              num[a]:=i;
              a:=a+1;
              decodedate(date,aa,m,g); {rif a date per aggiornare anche i molto
                                       vecchi}
              decodedate(d,ar,mr,g);

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
              on EConvertError do g:=g-1; {per gestire il fine mese variabile}
              end;

              seek(F,i);   {att.occorre sempre porre seek prima di write}
              write(F,dato);
              canc:=1;
                   end
                   else
            if (d<date)and(dato.tipo='S')then
                  begin
                 num[a]:=i;
                 a:=a+1;
                 temp:=1;
      listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento+'#'+dato.tipo);
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
    i:=i-1;
                  end;
 i:=i+1;  {incrementa il contatore}
          end;
 label9.caption:='Att. questi impegni periodici sono trascorsi';
 if temp>0 then
 messagedlgPos('Gli impegni saltuari(S) sono stati cancellati',
 mtwarning,[mbOK],0,10,100);
 if canc=1 then
 messagedlgPos('Uno o più impegni periodici risultano trascorsi.',mtwarning,
                    [mbOK,mbHelp],1,10,100);
 {$I+}
            errore:=IOResult;
 closeFile(F);
 ordinamento(nil);
end;

procedure TForm1.modificaClick(Sender: TObject);
begin
label9.caption:='';  
        If edit1.text='' then
        begin
    messagedlg('non c''è nulla da modificare',mtwarning,[mbOK],0);
    exit;
        end; 
       AssignFile(F,nf);
       dato.giorno:=dcal;
       dato.evento:=edit2.text;
       dato.tipo:=edit3.text;
       reset(F);
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

procedure TForm1.CalChange(Sender: TObject);
begin
label9.caption:='';
RadioBPClick(nil);
     if (kk=0)and (k=0) then
edit1.text:=datetostr(cal.calendardate);
dcal:=cal.calendardate;
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
 end
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
   edit3.text:='';
  RadioBP.checked:=false;  {occorre per consentire al radioB di resettarsi}
  RadioBM.checked:=false;
  RadioBS.checked:=false;
end;

procedure TForm1.RadioBPClick(Sender: TObject);
begin
 Edit3.text:='P';
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
var nn:integer;
begin
 AssignFile(F,nf); {apro il file e lo chiudo al di fuori dei loops}
 Reset(F);
 for nn:=0 to 999 do
    begin
 if listbox1.selected[nn] then
                          begin
     if pos('#S',listbox1.items[nn])>0 then
     begin
     messagedlg('Gli eventi saltuari scaduti(S) sono stati cancellati',
     mtwarning,[mbOK],0);
     break;
     end;                      seek(F,num[nn]);
                           read(F,dato);
                           edit1.text:=datetostr(dato.giorno);
                           edit2.text:=dato.evento;
                           edit3.text:=dato.tipo;
                           numdato:=num[nn];
                             {per localizzare il dato nel caso di modifica}
                           break;
                          end;
    end;
closeFile(F);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
 nf:=F1;
 label8.caption:='attivo : ricorda 1';
 timer2.enabled:=not(timer2.enabled);
 aggiorna(nil);
 bitscadclick(nil);
end;

{stampa }
procedure TForm1.BitprnClick(Sender: TObject);
 var
  PrintFile: TextFile;
  ln: Integer;
begin
   if listbox1.items.count=0 then
   begin
   messagedlg('Non c''è nulla da stampare',mtwarning,[mbOK],0);
   exit;
   end;
   if PrintDialog1.Execute then
      begin
    AssignPrn(PrintFile);
    Rewrite (PrintFile);
      for ln:= 0 to listbox1.items.Count - 1 do
      Writeln (PrintFile, listbox1.items[ln]);
      System.CloseFile (PrintFile);
       end;
end;

procedure TForm1.BithelpClick(Sender: TObject);
begin
Application.HelpFile:= '.\ricorda.hlp';
Application.HelpCommand(HELP_CONTENTS,0);
end;

procedure TForm1.BF1Click(Sender: TObject);
begin
   nf:=F1;
   label8.caption:='attivo : ricorda 1';
   aggiorna(nil);
   bitscadclick(nil);
end;
procedure TForm1.BF2Click(Sender: TObject);
begin
   nf:=F2;
   label8.caption:='attivo : ricorda 2';
   aggiorna(nil);
   bitscadclick(nil);
end;

procedure TForm1.BF3Click(Sender: TObject);
begin
   nf:=F3;
   label8.caption:='attivo : ricorda 3';
   aggiorna(nil);
   bitscadclick(nil);
end;

procedure TForm1.BF4Click(Sender: TObject);
begin
   nf:=F4;
   label8.caption:='attivo : ricorda 4';
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
  AssignFile(F,nf);
  Reset(F);
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
listbox1.items.add(datetostr(dato.giorno)+' - '+dato.evento)
else
break;
	end;
   messagedlgPos('Attenzione, in scadenza',mtinformation,[mbOK],0,10,100);
end;

procedure TForm1.Edit1Click(Sender: TObject);
begin
messagedlg('Immettere la data con un doppio click sul calendario',mtinformation
,[mbOK],0);
end;

procedure TForm1.RadioBSKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var cd:integer;
begin
 cd:=cal.tag;
 if (shift=[ssAlt])and(key=VK_SPACE)then
 messagedlg('il codice è '+inttostr(cd),mtinformation,[mbOK],0);                                        
end;
end.



{Ricorda 3.0 sorgente	14.7.98 }
















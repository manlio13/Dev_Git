unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, checklst,Registry,Printers;

type
  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    Cklstbox1: TCheckListBox;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    PrintDialog1: TPrintDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
 uses ml970124;
{$R *.DFM}

procedure TForm2.BitBtn1Click(Sender: TObject);

var
s,a,dim,m,n,ultimo,ultimoa,primo:integer;
ck :array[0..49] of integer;
 begin //chiusura del form
 a:=0;
   //routine per cancellare record discontinui
 ultimo:=Filesize(FS)-1;
      if ultimo>=49 then
      begin
     showmessage('Non possono essere mostrati più di 50 eventi');
     ultimo :=49;
      end;
 if ultimo>=0 then //altrimenti fa il primo (-1) che non esiste
 for s:=0 to ultimo do
     if cklstbox1.checked[s] then
        begin
     ck[a]:=s;  // si crea un array che conserva gli indici dei checked
     a:=a+1;    // nel file originale
        end;
     ultimoa:=a-1;

     dim:=0;
     for m:=0 to ultimoa do
       begin
       primo:=ck[m]-dim;// il valore originale del ck[m] viene diminuito ogni
       ultimo:=Filesize(FS)-1; //volta che troncando il file si accorcia di 1
          for n:=primo to ultimo-1 do //uno in meno per non uscire dall'eof
            begin                     // infatti si legge l'n+1
            seek(FS,n+1);
            read(FS,logrec);
            seek(FS,n);
            write(FS,logrec);
            end;
         seek(FS,ultimo);
         truncate(FS);
         dim:=dim+1 //quì aumenta l'entità della diminuzione dell'indice array
       end;
  if filesize(FS)=0 then
  Form1.bitbtn1.font.color:=clgreen;
  end;

procedure TForm2.FormActivate(Sender: TObject);

var
n,max:integer;

begin
reset(FS);
 cklstbox1.Clear;
 if filesize(FS)>=50 then
    begin
 showmessage('Non possono essere mostrati più di 50 eventi');
 max:=49;
  end else
 max:=filesize(FS)-1;
 for n:=0 to max do
     begin
     seek(FS,n);
     Read(FS,logrec);
cklstbox1.items.add(datetostr(logrec.giorno)+'-'+logrec.evento+'-'+logrec.tipo);
     end;

end;

procedure TForm2.SpeedButton1Click(Sender: TObject); //stampa
 var
  PrintFile: TextFile;
  ln: Integer;
  mioreg:Tregistry;
  nome:string;
 begin
   if cklstbox1.items.count=0 then
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
writeln(Printfile,'Stampa lista log Ricorda32 al  '+datetostr(date)+' per '+nome);
writeln(Printfile,' ');
      for ln:= 0 to cklstbox1.items.Count - 1 do
      Writeln (PrintFile, cklstbox1.items[ln]);
      System.CloseFile (PrintFile);
       end;
end;

end.

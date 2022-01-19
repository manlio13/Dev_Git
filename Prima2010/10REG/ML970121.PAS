unit Ml970121;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,Inifiles, StdCtrls;

type
  TForm1 = class(TForm)
    memo1: TMemo;
    Button1: TButton;

    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
   inifile:Tinifile;
  end;

var
  Form1: TForm1;
  in1,user,in2 :string;
  dat1,reg1: integer;
const
 utente='Manlio Laschena';    {sostituire con il nome da registrare}
implementation

{$R *.DFM}

procedure TForm1.FormShow(Sender: TObject);
begin
  memo1.text:='';
  memo1.lines.add('Hai attivato la procedura per la registrazione');
  memo1.lines.add('della tua copia di Agenda.');
  memo1.lines.add('Segui le istruzioni che ti verranno via via date.');
  memo1.lines.add('In particolare, ti verra''chiesto di fornire il');
  memo1.lines.add('Nome e Cognome dell''utente da registrare. E'' un');
  memo1.lines.add('dato indispensabile per l''esecuzione della routine.');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 in2:=inputbox('Fornisci la directory di Agenda','Es.c:\agenda','');
 try
  inifile:=Tinifile.Create(in2+'\agenda.ini');

   dat1:=Inifile.ReadInteger('Dati','Dat',0);
   user:=Inifile.ReadString('Utente','Nominativo','');

       if (dat1=0)or (user='') then
          begin
messagedlg('La directory e'' errata o il file di configurazione e'' corrotto.',mtWarning,[mbOK],0);
application.terminate;
          end;
   in1:=inputbox('Inserisci i dati dell'' utente','Nome e Cognome','');
        if (user<>in1) or (utente<>in1) then
           begin
messagedlg('L''utente da registrare non corrisponde ai dati forniti.',mterror,[mbOK],0);
application.terminate;
           end
           else
       begin
    reg1:=dat1+640;
    inifile.writestring('Dati','Reg','$'+intToHex(reg1,9));
    messagedlg('La registrazione e'' stata eseguita.',mtinformation,[mbOK],0);
    application.terminate;
       end

 except
 messagedlg('Non riesco ad aprire il file di configurazione Agenda.ini',mtwarning, [mbok],0);
 application.terminate;
 end;
end;

end.

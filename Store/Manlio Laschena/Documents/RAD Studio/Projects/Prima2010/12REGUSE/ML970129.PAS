unit Ml970129;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,inifiles, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  type
      treg=record
      pw:integer;
      reg:integer;
      cfg:longint;
      dat:integer;
      user:string;
  end;

var
  Form1: TForm1;
  IniFile: TIniFile;
  reg1,pw1,dat1:integer;
  cfg1:longint;
  user1:string;
  dato:treg;
  F:file of treg;
implementation

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
begin
  IniFile := TIniFile.Create ('.\agenda.ini');

       pw1:=Inifile.ReadInteger('Utente','Password',0);
       reg1:=Inifile.ReadInteger('Dati','Reg',0);
       cfg1:=Inifile.ReadInteger('Dati','Cfg',0);
       dat1:=Inifile.ReadInteger('Dati','Dat',0);
       user1:=Inifile.ReadString('Utente','Nominativo','');

       with dato do
       begin
       pw:=pw1;
       reg:=reg1;
       cfg:=cfg1;
       dat:=dat1;
       user:=user1;
       end;

       AssignFile(F,'.\registra.dat');
       rewrite(F);
       write(F,dato);
       memo1.text:='';
       memo1.lines.add('Se hai copiato questo file nella directory');
       memo1.lines.add('di Agenda.exe e l''hai eseguito, hai creato');
       memo1.lines.add('il file REGISTRA.DAT.');
       memo1.lines.add('Invialo, come attachment, via Internet');
       memo1.lines.add('all''indirizzo:< lasc@iol.it >, fornendo ');
       memo1.lines.add('un recapito per ricevere il codice di');
       memo1.lines.add('registrazione.');



end;

end.

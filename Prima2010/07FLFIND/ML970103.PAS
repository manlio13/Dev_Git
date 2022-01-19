unit Ml970103;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    function Esistefile(NomeFile:string): Boolean;
  end;

var
  Form1: TForm1;
  F1 :File of longint;
  s1,s2,rs:string;
  nomedir: string;
  n1,r1:longint;
  unadata:TdateTime;
implementation

{$R *.DFM}


procedure TForm1.Button1Click(Sender: TObject);
begin


s1:=inputbox('digita','Drive es. C:','');
 nomedir:=s1+'\WINDOWS\WIN$#$.SYS';
 assignFile(F1,nomedir);
      if Esistefile(nomedir) then
       begin
 reset(f1);
 read(F1,r1);
 label1.caption:=datetostr(filedateTodatetime(r1));
       end
       else

       label1.caption:='manca WIN$#$.SYS !';


end;

{Programma per verificare l'esistenza di un file}

function Tform1.Esistefile(NomeFile: String): Boolean;
{ Questa funzione Booleana restituisce true se il file esite e False
  se non esiste. Se esiste , chiude il file. }
 var
  F: file of longint;
begin
  {$I-}
  AssignFile(F, NomeFile);

  Reset(F);
  CloseFile(F);
  {$I+}
  Esistefile := (IOResult = 0) and (NomeFile <> '');
end;






procedure TForm1.Button2Click(Sender: TObject);
begin

 Unadata:=strtodate(inputbox('digita','Data',''));
 n1:=DateTimetoFiledate(unadata);
 s1:=inputbox('digita','Drive es. C:','');
 nomedir:=s1+'\WINDOWS\WIN$#$.SYS';
 assignFile(F1,nomedir);
{att.se il file gia' esiste lo cancella e lo ricrea}
 rewrite(F1);
write(F1,n1);
{occorre usare reset, altrimenti non si puo' leggere}
reset(F1);
{NB la procedura Read puo' essere adoperata solo per i text files}
read(F1,n1);
label1.caption:=inttostr(n1);
closeFile(F1);

 end;


end.

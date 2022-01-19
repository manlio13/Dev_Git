{programma per lanciare un eseguibile all'orario voluto}
{Al_tempo.exe 1.0 beta M.Laschena 1997 }
unit Ml051097;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  nome,inora :string;
  denom :array[0..127] of char;
  n1 :Pchar;
  lunghezza,n :integer;
  ora :tdatetime;
  vero,vero2 :boolean;
  ora1,min1,sec1,msec1,ora2,min2,sec2,msec2 :word;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  TimeSeparator := ':';
  nome := 'c:\temp\miofile.exe';
  inora :='16:35';
  vero := inputquery('Programma da lanciare','digita Path e File',nome);
  if fileexists(nome)= false then
   begin
   messageDlg('Non trovo il file '+nome, mtwarning,[mbOK],0);
   exit;
   end;
  if vero then
 vero2:= inputquery('Ora del lancio','digita l''ora e i minuti (24ore)',inora);
 if vero2 then
    begin
    label1.visible:=true; {N.b.visibile al termine della procedura}
    exit;
    end
 else
     begin
 messagedlg('manca un dato !',mtwarning,[mbOK],0);
 application.terminate;
     end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   try
getmem(n1,128);
ora:=strtotime(inora);
lunghezza:=length(nome);
move(nome[1],denom[0],lunghezza);
denom[lunghezza]:=#0;
strPcopy(n1,denom);
decodetime(ora,ora1,min1,sec1,msec1);{occorre limitare ad ore e minuti per
rendere possibile il sincronismo}
label1.caption:='In attesa del lancio';
   except
   on Econverterror do
   messagedlg('Errore di digitazione dati !',mterror,[mbOK],0);
   end;
   repeat
decodetime(time,ora2,min2,sec2,msec2);
Application.ProcessMessages;{per consentire la chiamata ad altre procedure}
   until (ora1=ora2) and (min1=min2); {per rendere possibile fissare un tempo
   dopo la mezzanotte e prima dell'ora presente}

winexec(n1,SW_SHOWMAXIMIZED);
Application.terminate;
 end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Application.HelpFile:= '.\Al_tempo.hlp';
Application.HelpCommand(HELP_CONTENTS,0);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
halt(1);
end;

end.

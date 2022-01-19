{ programma di verifica della password di accesso}
unit Unit1;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,inifiles,unit2, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    procedure Formshow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    inifile: Tinifile;
  end;

var
  Form1: TForm1;
  conta,pw1,reg1,dat1,pass:integer;
  cfg1:longint;
  user:string[80];
implementation

{$R *.DFM}

procedure TForm1.Formshow(Sender: TObject);
begin
 IniFile := TIniFile.Create ('.\agenda.ini');
        pw1:=Inifile.ReadInteger('Utente','Password',0);

        if pw1<>640 then   {640 dovrebbe essere il valore di default}
   begin
            if pw1=0 then   {corrotto l'ini}
        begin
            passworddlg.enabled:=false;
            messagedlg('corrotto',mterror,[mbOK,mbHelp],0);
            Application.terminate; {altrimenti la chiusura è irregolare}
        end
        else
        begin   {chiede e verifica la password}

         for conta:=1 to 2 do
         begin
         passworddlg.showmodal;
          pass:=strtoint(passworddlg.password.text);{nota rif. all'altra unit}
         if (pass-640)<>pw1 then
                          begin
         messagedlg('password non esatta',mtwarning,[mbOK],0);
         passworddlg.password.text:='';
                          end
         else
         break;  {o è soddisfatta o non lo è stato per due volte}
         end;
         if (pass-640)<>pw1 then  {lo verifica per la terza volta}
                        begin
            messagedlg('errore fatale',mterror,[mbOK,mbHelp],0);
            Application.terminate;
                        end;
        end

   end;



       reg1:=Inifile.ReadInteger('Dati','Reg',0);
       cfg1:=Inifile.ReadInteger('Dati','Cfg',0);
       dat1:=Inifile.ReadInteger('Dati','Dat',0);
       user:=Inifile.ReadString('Utente','Nominativo','');

       end;

end.

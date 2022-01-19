program Project1;

uses
  Dialogs,
  Windows,
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}
const
  TentaLancio ='CodeCall.Net Mutex';

resourcestring
  DUPLICATE_MSG = 'Il programma è stato già lanciato';
var
 vMutex: THandle;

begin
  vMutex:=CreateMutex(nil,True,TentaLancio);
  if GetLastError = ERROR_ALREADY_EXISTS  then
     begin
       MessageDlg(DUPLICATE_MSG,mtError,[mbOK],0);
       Exit;
     end;
  try
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
  finally
    CloseHandle(vMutex);
  end;
end.

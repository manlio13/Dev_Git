program SingleInstance;

uses
  Windows,
  Forms,
  Dialogs,
  Main_SingleInstance in 'Main_SingleInstance.pas' {Form1};

{$R *.res}

const
  MutexName        = 'CodeCall.Net Mutex';
resourcestring
  DUPLICATE_MSG    = 'Another instance of this program is already running. This one will shutdown';
var
  vMutex: THandle;
begin
  // try to create our mutex
  vMutex := CreateMutex(nil, True, MutexName);

  // check if the previous line caused error and the error is ERROR_ALREADY_EXISTS
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    // show the duplication message
    MessageDlg(DUPLICATE_MSG, mtError, [mbOk], 0);
    Exit;  // terminates the program
  end;
  try
    Application.Initialize;
    Application.CreateForm(TForm1, Form1);
    Application.Run;
  finally
    // release the mutex
    CloseHandle(vMutex);
  end;
end.

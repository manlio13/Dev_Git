program totpw301;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'totpw301';
  Application.CreateForm(TForm1, Form1);
  Application.ShowMainForm:=false; //porre prima di run
  Application.Run;
end.

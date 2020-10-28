program regemu;

uses
  Forms,
  regunit in 'regunit.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'regemu';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

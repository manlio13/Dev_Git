program datafile;

uses
  Forms,
  ml990403 in 'ml990403.pas' {Form1};

{$E exe}

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'datafile';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

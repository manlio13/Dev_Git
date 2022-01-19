program legexe2;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'legexe2';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

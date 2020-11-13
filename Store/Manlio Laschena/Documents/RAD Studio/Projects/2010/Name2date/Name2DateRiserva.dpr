program Name2DateRiserva;

uses
  Forms,
  Fotofile in 'Fotofile.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Name2Date';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

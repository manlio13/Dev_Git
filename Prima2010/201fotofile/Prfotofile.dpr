program Prfotofile;

uses
  Forms,
  fotofile in 'fotofile.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Fotorinomina';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

program LibCat;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'LibCat';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

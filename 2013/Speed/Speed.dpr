program Speed;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$E exe}

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Speed';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

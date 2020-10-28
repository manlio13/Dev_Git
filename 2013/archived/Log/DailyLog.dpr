program DailyLog;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$E exe}

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Project1';
  Application.CreateForm(TForm1, Form1);
  Application.HelpFile:='log.chm';
  Application.Run;
end.

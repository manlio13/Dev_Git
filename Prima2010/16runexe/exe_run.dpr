program Exe_run;

uses
  Forms,
  Ml051097 in 'ML051097.PAS' {Form1};

{$R *.RES}

begin
  Application.Title := 'Al_tempo';
  Application.HelpFile := 'Al_tempo.hlp';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

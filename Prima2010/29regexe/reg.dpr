program reg;

{%ToDo 'reg.todo'}

uses
  Forms,
  ml040399 in 'ml040399.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'reg.exe';
  Application.HelpFile := 'reg.hlp';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

program Manlio15;

uses
  Forms,
  ml970124 in 'ml970124.pas' {Form1};

{$R *.RES}

begin
  Application.Title := 'ricorda';
  Application.Title := 'ricorda32';
  Application.HelpFile := '.\ricorda.hlp';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

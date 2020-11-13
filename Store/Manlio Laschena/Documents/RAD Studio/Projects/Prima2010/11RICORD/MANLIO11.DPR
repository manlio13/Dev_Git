program Manlio11;

uses
  Forms,
  Ml970124 in 'ML970124.PAS' {Form1};

{$R *.RES}

begin
  Application.Title := 'ricorda';
  Application.HelpFile := '.\ricorda.hlp';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

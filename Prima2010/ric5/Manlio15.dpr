program Manlio15;

{%ToDo 'Manlio15.todo'}

uses
  Forms,
  ml970124 in 'ml970124.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2};

{$R *.RES}

begin
  Application.Title := 'ricorda32';
  Application.Title := 'ricorda';
  Application.HelpFile := '.\ricorda.hlp';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

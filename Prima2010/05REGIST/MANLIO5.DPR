program Manlio5;

uses
  Forms,
  Ml961226 in 'ML961226.PAS' {Form1};

{$R *.RES}

begin

  Application.Title := 'Registro';
  Application.HelpFile := '.\registro.hlp';
  Application.CreateForm(TForm1, Form1);
  Application.Run;


end.

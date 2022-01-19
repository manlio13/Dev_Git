program Manlio3;

uses
  Forms,
  Ml970131 in 'ML970131.PAS' {Form1};

{$R *.RES}

begin
  Application.Title := 'calend';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

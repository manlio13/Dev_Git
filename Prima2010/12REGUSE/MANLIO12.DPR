program Manlio12;

uses
  Forms,
  Ml970129 in 'ML970129.PAS' {Form1};

{$R *.RES}

begin
  Application.Title := 'usereg';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

program Manlio13;

uses
  Forms,
  Ml970130 in 'ML970130.PAS' {Form1};

{$R *.RES}

begin
  Application.Title := 'leggouser';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

program Ml970208;

uses
  Forms,
  Manlio14 in 'MANLIO14.PAS' {Form1};

{$R *.RES}

begin
  Application.Title := 'mialist';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

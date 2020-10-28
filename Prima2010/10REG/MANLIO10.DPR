program Manlio10;

uses
  Forms,
  Ml970121 in 'ML970121.PAS' {Form1};

{$R *.RES}

begin
  Application.Title := 'reg';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

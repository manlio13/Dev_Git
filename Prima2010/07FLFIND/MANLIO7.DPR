program Manlio7;

uses
  Forms,
  Ml970103 in 'ML970103.PAS' {Form1};

{$R *.RES}

begin
  Application.Title := 'winwrite';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

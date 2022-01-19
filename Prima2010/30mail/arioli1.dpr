program Arioli1;

uses
  Forms,
  Arioli in 'ARIOLI.PAS' {Form1};

{$R *.RES}

begin
  Application.Title := 'arioli';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

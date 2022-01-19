program Tappeto;

uses
  Forms,
  Ml080698 in 'ML080698.PAS' {Form1};

{$R *.RES}

begin
  Application.Title := 'tappeto';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

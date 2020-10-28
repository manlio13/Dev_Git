program calcstr;

uses
  Forms,
  ml990226 in 'ml990226.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

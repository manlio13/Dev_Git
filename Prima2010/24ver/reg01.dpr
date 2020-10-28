program reg01;

uses
  Forms,
  ml981014 in 'ml981014.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'vertool';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

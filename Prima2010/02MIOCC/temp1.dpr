program temp1;

uses
  Forms,
  temp in 'temp.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'temp';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

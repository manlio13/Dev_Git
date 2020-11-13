program Project1;

uses
  Forms,
  ml190698 in 'ml190698.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'CAPLOCATOR';
  Application.CreateForm(TForm1, Form1);
  
  Application.Run;
end.

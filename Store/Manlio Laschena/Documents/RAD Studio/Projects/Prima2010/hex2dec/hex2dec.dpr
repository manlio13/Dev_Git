program hex2dec;

uses
  Forms,
  h2d in 'h2d.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

program inimarca;

uses
  Forms,
  ml990110 in 'ml990110.pas' {Form1};

{$E exe}

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'ini';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

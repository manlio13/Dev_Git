program ctrlini;

uses
  Forms,
  ml990208 in 'ml990208.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'ctrlini';
  Application.CreateForm(TForm1, Form1);
  Application.ShowMainForm :=false;
  Application.Run;
end.

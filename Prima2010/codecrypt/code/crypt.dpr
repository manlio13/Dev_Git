program crypt;

uses
  Forms,
  Unit1 in '..\..\codecrypt\code\Unit1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

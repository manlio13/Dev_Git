program Ric50;

uses
  Forms,
  Ric_tray in '..\Ric50\Ric_tray.pas' {Form1},
  About in '..\Ric50\About.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Ricorda 50';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.ShowMainForm:=false; //in questo modo si rende veramente
  //invisibile il form1, che deve anche avere visible :=false
  Application.Run;
end.

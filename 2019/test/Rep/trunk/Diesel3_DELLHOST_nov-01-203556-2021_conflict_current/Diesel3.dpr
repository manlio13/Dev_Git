program Diesel3;
{$WEAKLINKRTTI ON} //per eliminare RTTI e ridurre size
uses
  Forms,
  Unit1 in '..\Diesel2\Unit1.pas' {Form1},
  Unit2 in '..\Diesel2\Unit2.pas' {Form2},
  Unit3 in '..\Diesel2\Unit3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Diesel';
  Application.HelpFile:='Diesel.chm';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.

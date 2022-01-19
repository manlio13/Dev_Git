program Name2Date;

uses
  Forms,D6OnHelpFix in 'D6OnHelpFix.pas',
  Fotofile in 'Fotofile.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.HelpFile := 'C:\utenti\Manlio Laschena\DEV\2010\Name2date\n2d.hlp';
  Application.Title := 'Name2Date';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

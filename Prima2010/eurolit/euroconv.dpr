program euroconv;

uses
  Forms,
  euro in 'euro.pas' {EuroLit};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'eurolit';
  Application.CreateForm(TEuroLit, EuroLit);
  Application.Run;
end.

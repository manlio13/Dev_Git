program vcard;

uses
  Forms,
  vcmain in 'vcmain.pas' {vCardForm},
  vcabout in 'vcabout.pas' {AboutBox};

{$R *.RES}

begin
  Application.CreateForm(TvCardForm, vCardForm);
  Application.Run;
end.

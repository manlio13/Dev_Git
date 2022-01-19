program Manlio1;

uses
  Forms,
  Ml960417 in 'ML960417.PAS' {Maschera},
  Unit1 in 'UNIT1.PAS' {PasswordDlg};

{$R *.RES}

  begin
 

  Application.Title := 'agenda';
  Application.HelpFile := '.\AGENDA.HLP';
  PasswordDlg:=TpasswordDlg.Create(Application);
  Application.CreateForm(TMaschera, Maschera);
  
  Application.Run;

  end.

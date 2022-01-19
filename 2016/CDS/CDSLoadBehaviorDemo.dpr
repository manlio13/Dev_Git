(* CDSLoadBehaviorDemo (c) 2002 Cary Jensen, Jensen Data Systems, Inc.
 *
 * This project demonstrates the interaction between the ClientDataSet
 * and DataSetProvider components.
 *
 * This project is provided for demonstration purposes only
 *
 * No guarantees or warrantees are expressed or implied concerning
 * the applicability of techniques or code included in this example.
 * If you wish to use techniques or code included in this example,
 * it is your responsibility to test and certify any code or
 * techniques design adopted as a result of this project.
 *
 * For information on consulting or training services, please visit
 * http://www.JensenDataSystems.com.
 *
 * Delphi Developer Days - Information-packed Delphi (TM) seminars
 * by Cary Jensen. Visit www.DelphiDeveloperDays.com for dates and locations.
 * 
 *)
program CDSLoadBehaviorDemo;

uses
  Forms,
  main in 'main.pas' {Form1},
  deltaform in 'deltaform.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CDSLoadBehaviorExample';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

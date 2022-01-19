program euroconvTest;

uses

 TestFramework,
 GUITestRunner,
  EuroTest in 'EuroTest.pas';

{$R *.res}

begin
  GUITestRunner.Runtest(RegisteredTests);
end.

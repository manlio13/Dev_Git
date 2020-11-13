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
unit deltaform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DBCtrls, ExtCtrls, DB, DBClient;

type
  TForm2 = class(TForm)
    Panel3: TPanel;
    DBNavigator3: TDBNavigator;
    DBGrid3: TDBGrid;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.

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
unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Provider, StdCtrls, ExtCtrls, DBClient, DB, DBTables,
  Grids, DBGrids, DBCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Panel2: TPanel;
    DBNavigator2: TDBNavigator;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    Table1: TTable;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    Splitter1: TSplitter;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    SelectTable1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    View1: TMenuItem;
    Delta1: TMenuItem;
    TableLoading1: TMenuItem;
    OpenDialog1: TOpenDialog;
    ApplyUpdates1: TMenuItem;
    ClientDataSet2: TMenuItem;
    Load1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    CancelUpdates1: TMenuItem;
    N2: TMenuItem;
    VisitwwwDephiDevelperDayscom1: TMenuItem;
    VisitwwwJensenDataSystemscom1: TMenuItem;
    procedure ApplyUpdates1Click(Sender: TObject);
    procedure ClientDataSet1AfterPost(DataSet: TDataSet);
    procedure TableLoading1Click(Sender: TObject);
    procedure SelectTable1Click(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure Delta1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure CancelUpdates1Click(Sender: TObject);
    procedure VisitwwwDephiDevelperDayscom1Click(Sender: TObject);
    procedure VisitwwwJensenDataSystemscom1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses deltaform, shellapi;

{$R *.dfm}

procedure TForm1.ApplyUpdates1Click(Sender: TObject);
begin
ClientDataSet1.ApplyUpdates(-1);
end;

procedure TForm1.ClientDataSet1AfterPost(DataSet: TDataSet);
begin
if (form2 <> nil) then
begin
  if ClientDataSet1.ChangeCount = 0  then
    Form2.ClientDataSet1.EmptyDataSet
  else
    Form2.ClientDataSet1.Data := ClientDataSet1.Delta;
end;
end;

procedure TForm1.TableLoading1Click(Sender: TObject);
begin
if TableLoading1.Checked then
begin
  Table1.DisableControls;
  TableLoading1.Checked := False;
end
else
begin
  Table1.EnableControls;
  TableLoading1.Checked := True;
end;
end;

procedure TForm1.SelectTable1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    if Table1.Active then
      Table1.Close;
    Table1.TableName := OpenDialog1.FileName;
  end;
end;

procedure TForm1.Load1Click(Sender: TObject);
begin
if ClientDataSet1.Active then
begin
  Load1.Caption := 'Load';
  ClientDataSet1.Close;
end
else
begin
  Load1.Caption := 'Close';
  ClientDataSet1.Open;
end;
end;

procedure TForm1.Delta1Click(Sender: TObject);
begin
if not Self.ClientDataSet1.Active then
  begin
    ShowMessage('ClientDataSet is not active');
    Exit;
  end;
if Self.ClientDataSet1.ChangeCount = 0 then
  begin
    ShowMessage('Delta is empty');
    Exit;
  end;

  with TForm2.Create(nil) do
  begin
    ClientDataSet1.Data := Self.ClientDataSet1.Delta;
    ShowModal;
    Release;
  end;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
ShowMessage('CDSLoadBehaviorDemo (c) 2002 Cary Jensen, Jensen Data Systems, Inc. '
  + #10#13 + ''
  + #10#13 + 'Demonstration of the behavior of ClientDataSets and DataSetProviders.'
  + #10#13 + 'This project is provided for demonstration purposes only.'
  + #10#13 + ''
  + #10#13 + 'Visit http://www.JensenDataSystems.com for information about training and consulting services.');

end;

procedure TForm1.CancelUpdates1Click(Sender: TObject);
begin
ClientDataSet1.CancelUpdates;
end;

procedure TForm1.VisitwwwDephiDevelperDayscom1Click(Sender: TObject);
begin
ShellExecute(Application.Handle, 'open',
 'http://www.DelphiDeveloperDays.com', nil, nil, SW_SHOW);
end;

procedure TForm1.VisitwwwJensenDataSystemscom1Click(Sender: TObject);
begin
ShellExecute(Application.Handle, 'open',
 'http://www.JensenDataSystems.com', nil, nil, SW_SHOW);
end;

end.

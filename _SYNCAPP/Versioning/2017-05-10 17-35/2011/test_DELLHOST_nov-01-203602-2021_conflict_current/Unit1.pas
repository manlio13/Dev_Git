unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXDevartSQLite, FMTBcd, Grids, DBGrids, DB, SqlExpr, DBClient,
  Provider, SimpleDS, ExtCtrls, DBCtrls;

type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    DBGrid1: TDBGrid;
    SimpleDataSet1: TSimpleDataSet;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure SQLConnectionAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure TForm1.FormCreate(Sender: TObject);
begin
  SimpleDataSet1.DataSet.GetMetadata:=True;
end;

procedure TForm1.SQLConnectionAfterConnect(Sender: TObject);

begin
SQLConnection1.DriverName:='DevartSQLite';
SQLConnection1.GetDriverFunc:='getSQLDriverSQLite';
SQLConnection1.LibraryName:='dbexpsqlite40.dll';
SQLConnection1.VendorLib:='sqlite3.dll';
SQLConnection1.Params.Values['Database']:='DataNav.s3db';
SQLConnection1.Open;
simpleDataSet1.Dataset.CommandText:='Select * From Dati';
SimpleDataSet1.Open;

 end;

end.

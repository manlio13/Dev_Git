unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Grids, DBGrids, DB, DBTables;

type
  TForm1 = class(TForm)
    Table1: TTable
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Table1: TTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
 
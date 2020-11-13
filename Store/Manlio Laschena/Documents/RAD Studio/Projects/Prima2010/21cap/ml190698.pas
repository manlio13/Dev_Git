unit ml190698;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, Buttons, DBTables, Mask, ExtCtrls;

type
  TForm1 = class(TForm)
    Table1Codice: TStringField;
    Table1Nome: TStringField;
    Table1Prov: TStringField;
    Table1CAP: TStringField;
    ScrollBox: TScrollBox;
    Label1: TLabel;
    EditCodice: TDBEdit;
    Label2: TLabel;
    EditNome: TDBEdit;
    Label3: TLabel;
    EditProv: TDBEdit;
    Label4: TLabel;
    EditCAP: TDBEdit;
    DBNavigator: TDBNavigator;
    Panel1: TPanel;
    Panel2: TPanel;
    Table1: TTable;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Table1.Open;
   
end;


procedure TForm1.Edit1Change(Sender: TObject);
var
k:string;
opzioni:TlocateOptions;
begin
k:='Nome';
opzioni:=[locaseinsensitive,lopartialKey];
table1.locate(k,edit1.text,opzioni);
end;
procedure TForm1.FormActivate(Sender: TObject);
begin
edit1.setfocus;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
application.terminate;
end;

end.

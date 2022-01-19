unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Data.DB, ABSMain, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask,System.UITypes,
  frxClass, frxExportPDF, frxDBSet;

type
  TForm1 = class(TForm)
    ABSDatabase1: TABSDatabase;
    ABSTable1: TABSTable;
    DataSource1: TDataSource;
    Button1: TButton;
    DBNavigator1: TDBNavigator;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button2: TButton;
    Button3: TButton;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
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
    ABSDatabase1.DatabaseFileName:=ExtractFilePath(Application.ExeName)+'BL.ABS';
    ABSDatabase1.Open;
    ABSTable1.TableName:='BLT'; //non usare la forma XXX.ABS ma solo XXX
    ABSTable1.Open;
    ABSTable1.Last;
    ABSTable1.Edit;
    DataSource1.DataSet.Edit;
end;

procedure TForm1.Button1Click(Sender: TObject);     //esci
begin
    ABSTable1.Close;
    Application.Terminate;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     If MessageDlg('Vuoi Azzerare il Log ?',mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrNo  then
       Exit else
       begin
         ABSTable1.Close;
         ABSTable1.EmptyTable;
       end;

end;


procedure TForm1.Button3Click(Sender: TObject);
begin
   frxReport1.ShowReport;
end;

procedure TForm1.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  If  (Button = nbInsert) then    //se inserisce un nuovo record
         ABSTable1.Append;
         DBEdit1.EditText;

end;

end.

unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Types, Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls,Vcl.DBCtrls,Data.DB, ABSMain, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
uses
Unit1;

procedure TForm2.Button1Click(Sender: TObject);  //Done
begin
  Form1.Edit1.Text:='';
  Form1.Edit2.Text:='';
  Form1.Edit3.Text:='';
  Form1.Edit4.Text:='';
   Form1.Visible:=True;
   Form2.Visible:=False;
end;

procedure TForm2.Button2Click(Sender: TObject);   //Exit
begin
  Form1.Button5.click  ;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  // il DBGrid si utilizza solo con i risultati del query SQL

   Form1.DataSource1.DataSet:=Form1.ABSQuery1;

end;

procedure TForm2.Button3Click(Sender: TObject);       //Edit
var
successo:Boolean;
begin
   ricorda:=Form1.ABSQuery1.FieldByName('Num').AsInteger;
   //showmessage (IntToStr(ricorda));
  // SearchOptions := [loPartialKey];
  //   LocateSuccess := CustTable.Locate('Company', 'Professional Divers, Ltd.', SearchOptions);
  Form1.DataSource1.DataSet:=Form1.ABSTable1;
  successo:=Form1.ABSTable1.Locate('Num',ricorda,[loPartialKey]);
  if successo =True then
    ShowMessage('Make your edit using local navigator')else
    begin
    Showmessage('unpredictable error , Search again pls');
    Exit;
    end;
end;

end.

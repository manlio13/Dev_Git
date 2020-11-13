unit AnaDspl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ABSMain, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, frxClass, frxDBSet,System.UITypes,
  frxExportPDF;

type
  TForm4 = class(TForm)
    dbgrd4: TDBGrid;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    dbnvgr4: TDBNavigator;
    ds4: TDataSource;
    ABSQuery4: TABSQuery;
    frxReport4: TfrxReport;
    frxDBDataset4: TfrxDBDataset;
    frxPDFExport4: TfrxPDFExport;
    Label2: TLabel;
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure dbnvgr4Click(Sender: TObject; Button: TNavigateBtn);
    procedure dbgrd4ColExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  DsplFlg:Boolean=True;    // il crea lo cambia a False
  inserisco4:Boolean=False;
  CanClose:Boolean=True;
  filtro:string;
implementation
  uses
  Console1;
{$R *.dfm}
 {$D+}
procedure TForm4.FormCreate(Sender: TObject);
begin
   Form2.ABSTable4.TableName:='AnaDspl';
   Form2.ABSTable4.Open;
   FormatDateTime('nn:ss,zzz',Form2.ABSTable4.FieldByName('TMAX').asDateTime) ;
   //TDateTimeField(Form2.ABSTable4.FieldByName('TMAX')).DisplayFormat:='nn:ss,zzz';
   DsplFlg:=False;
   ds4.DataSet:=Form2.ABSTable4;//aggiunto per evitare circular DataLink error
   Form2.ABSTable4.Edit;
end;


procedure TForm4.Button1Click(Sender: TObject);  //Cerca

begin
      ds4.DataSet:=ABSQuery4;
     if Edit1.Text<>'' then
     begin
      filtro:='DESCR LIKE '+ QuotedStr('%'+Edit1.Text+'%');
       //effettua il query
         with ABSQuery4 do
          begin
           close;
           SQL.text := 'select * from AnaDspl where '+filtro; //Attenzione agli spazi prima e dopo gli apici
           ExecSql;
           open;
          end;
     end else
        begin
          ShowMessage('Nessun elemento di ricerca inserito');
          Exit;
        end;
end;


procedure TForm4.Button2Click(Sender: TObject);    //Annulla la ricerca
begin
     Edit1.Text:='';
     ds4.DataSet:=Form2.ABSTable4;
end;

procedure TForm4.Button3Click(Sender: TObject);    //Stampa
begin
       frxReport4.ShowReport;    //??
      if MessageDlg('Vuoi stamparlo ?' , mtconfirmation, [mbYes,mbNo], 0,mbNo) = mrNo
       then  Exit else
         frxReport4.Print;
end;

procedure TForm4.Button4Click(Sender: TObject);    //Azzera la tabella
begin
     if MessageDlg('Stai per azzerare l''intera Anagrafe delle Discipline. Vuoi continuare ?',
          mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
          begin
            Form2.ABSTable4.Close;
            Form2.ABSTable4.EmptyTable;
            ShowMessage('Tutta l''anagrafe è stata cancellata !');
          end;
end;

procedure TForm4.Button5Click(Sender: TObject);   //Esci
begin
    if inserisco4=True then  //se ha inserito un record
     begin
       FormCloseQuery(Self,canclose);
     end
     else
     begin
       Form2.ABSTable1.Open;
       Form2.ABSTable1.Last;
       if Form2.ABSTable1.FieldByName('Password').AsString<>'' then
       Form2.ABSTable1.Insert;
       Form2.ABSTable1.Edit;
       Form2.ABSTable1.FieldByName('OUT').AsDateTime:=NOW;
       Form2.ABSTable1.Post;
       Form2.ABSTable1.Close;
      Form2.ABSTable4.Close;
      Form4.Close;   // NB chiama il can close
      DsplFlg:=True;  //per consentire di monitorizzare che Form3 è closed
      Form2.Visible:=True;
      Form4.Release;
     end;
end;

procedure TForm4.dbgrd4ColExit(Sender: TObject);
begin
  FormatDateTime('nn:ss,zzz',Form2.ABSTable4.FieldByName('TMAX').asDateTime) ;
  //TDateTimeField(Form2.ABSTable4.FieldByName('TMAX')).DisplayFormat:='nn:ss,zzz';
end;

procedure TForm4.dbnvgr4Click(Sender: TObject; Button: TNavigateBtn);
begin                     // azioni del DBNavigator
   case button of
    nbInsert:    //se inserisce un nuovo record
     begin
       Form2.ABSTable4.Last;
       Form2.ABSTable4.Append;
       inserisco4:=True; //inserisce il flag nel nuovo record
       dbgrd4.SetFocus;
       DBGrd4.SelectedField := Form2.ABSTable4.FieldByName('DESCR');
     end ;

    nbPost:  //se lo carica nella tabella
    begin
       inserisco4:=False ;
       FormatDateTime('nn:ss,zzz',Form2.ABSTable4.FieldByName('TMAX').asDateTime) ;
       //TDateTimeField(Form2.ABSTable4.FieldByName('TMAX')).DisplayFormat:='nn:ss,zzz';
    end;

  end;
end;

procedure TForm4.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin                         // Chiusura del Form 4 DSPL
  if inserisco4=True then
  if MessageDlg('Hai un dato da salvare ?' , mtconfirmation, [mbYes,mbNo], 0) = mrYes
    then
      begin
         CanClose:=False;
         Exit;
      end
    else
       begin
        CanClose:=True;
          if inserisco4=True then
          inserisco4:=False;
          Button5Click(Self);
       end;
end;
end.

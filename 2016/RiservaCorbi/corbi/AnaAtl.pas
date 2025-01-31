unit AnaAtl;   // Unit� per il carico dell'anagrafe atleti

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ABSMain, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCGrids, Vcl.ExtCtrls, Vcl.DBCtrls,System.UITypes,
  frxClass, frxDBSet,System.Types;

type
  TForm3 = class(TForm)
    Button1: TButton;
    ABSQuery1: TABSQuery;
    dbgrd1: TDBGrid;
    dbnvgr1: TDBNavigator;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button5: TButton;
    ds1: TDataSource;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure dbnvgr1Click(Sender: TObject; Button: TNavigateBtn);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ds1DataChange(Sender: TObject; Field: TField);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  atlflg:Boolean=True; // Quando � True il form3 � closed
  filtro:string; // per SQL
  inserisco:Boolean=False;//flag per inserimento dati;
  canclose:Boolean=True;
implementation
  uses
  Console1;
{$R *.dfm}
 {$D+}
procedure TForm3.FormCreate(Sender: TObject);
begin     //ricordarsi di assegnare una datasource al Navigator
  // Form2.ABSTable2.TableName:='AnaAtl';
   Form2.ABSTable2.Open;
   atlflg:=False;
   ds1.DataSet:=Form2.ABSTable2;//aggiunto per evitare circular DataLink error
   Form2.ABSTable2.Edit;
   Form2.ABSTable1.Open;
   Form2.ABSTable1.INSERT;
   Form2.ABSTable1.FieldByName('IN').AsDateTime:= NOW;
   Form2.ABSTable1.FieldByName('what').AsString:='Accesso alla Anagrafica Atleti';
   Form2.ABSTable1.FieldByName('OUT').AsString:='';
   Form2.ABSTable1.Post;
   Form2.ABSTable1.Close;
end;

//Intercetto DBNavigator
procedure TForm3.dbnvgr1Click(Sender: TObject; Button: TNavigateBtn);

begin    //per selezionare il primo campo

  case button of
    nbInsert:    //se inserisce un nuovo record
     begin
       Form2.ABSTable2.Last;
       Form2.ABSTable2.Append;
       inserisco:=True; //inserisce il flag nel nuovo record
       dbgrd1.SetFocus;
       DBGrd1.SelectedField := Form2.ABSTable2.FieldByName('NOME');
     end ;

    nbPost:     //se lo carica nella tabella
       inserisco:=False ;
  end;
end;

        procedure TForm3.ds1DataChange(Sender: TObject; Field: TField);
begin

end;

// per monitorare il form close quando si � aggiunto un record
procedure TForm3.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if inserisco=True then
    if MessageDlg('Hai un dato da salvare ?' , mtconfirmation, [mbYes,mbNo], 0) = mrYes
    then
          begin
           CanClose:=False;
           Exit;
          end
    else
       begin
        CanClose:=True;
          if inserisco=True then
          inserisco:=False;
          Button1Click(Self);
       end;
    if CanClose=False then
    CanClose:=True;
end;


procedure TForm3.Button1Click(Sender: TObject); // Esci

begin
   if inserisco=True then  //se ha inserito un record
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
      Form2.ABSTable2.Close;
      Form3.Close;   // NB chiama il can close
      atlflg:=True;  //per consentire di monitorizzare che Form3 � closed
      Form2.Visible:=True;
      Form3.Release;
     end;
end;

procedure TForm3.Button2Click(Sender: TObject);   //cerca
label
vai;
var
chi:array[1..2]of shortint;
i:ShortInt;
begin
     ds1.DataSet:=ABSQuery1;
    i:=0;          //determina se nome o/e cognome � in ricerca
     if edit1.text<>'' then
      begin
       i:=i+1;
       chi[i]:=1;
      end;
     if edit2.Text<>'' then
      begin
       i:=i+1;
       chi[i]:=2;
      end;
        if chi[2]>0 then  //elabora i query
      begin
       filtro:='NOME LIKE '+ QuotedStr('%'+Edit1.Text+'%')+' AND COGNOME LIKE '
       +quotedStr('%'+edit2.text+'%');
       goto vai;
      end;
       if chi[1]>0 then
      begin
       if (edit1.Text<>'')  then
        filtro:= 'NOME LIKE '+quotedstr('%'+Edit1.Text+'%');
       if (edit2.Text<>'')  then
        filtro:='COGNOME LIKE '+QuotedStr('%'+Edit2.Text+'%');
        goto vai;
      end;
  vai :
      //effettua il query
         with ABSQuery1 do
     begin
       close;
       if i>0 then
       begin
        SQL.Text := 'select * from AnaAtl where '+filtro; //Attenzione agli spazi prima e dopo gli apici
        ExecSql;
       end else
        begin
          ShowMessage('Nessun elemento di ricerca inserito');
          Exit;
        end;
       Open;
     end;
 end;

procedure TForm3.Button3Click(Sender: TObject); //Resetta la ricerca
begin
     Edit1.Text:='';
     Edit2.Text:='';
     ds1.DataSet:=Form2.ABSTable2;
end;

        //STAMPA
        procedure TForm3.Button4Click(Sender: TObject);
begin
      Form2.frxReport1.ShowReport;
      if MessageDlg('Vuoi stamparlo ?' , mtconfirmation, [mbYes,mbNo], 0,mbNo) = mrNo
       then  Exit else
         Form2.frxReport1.Print;
end;

//AZZERA il database Atleti
procedure TForm3.Button5Click(Sender: TObject);
begin
        if MessageDlg('Stai per azzerare l''intera Anagrafe degli atleti. Vuoi continuare ?',
          mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
          begin
            Form2.ABSTable2.Close;
            Form2.ABSTable2.EmptyTable;
            ShowMessage('Tutta l''anagrafe � stata cancellata !');
          end;

end;


end.

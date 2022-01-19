unit Unit1;        //03/05/2018 finale vers. 7.0  > WorksLog
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Grids,DBGrids,DB,ABSmain,ComCtrls,ExtCtrls,Buttons, DBCtrls,
  Mask,HTMLHelpViewer,System.UITypes, Datasnap.DBClient,printers,JvSHFileOperation,JvBaseDlg,
  frxClass, frxExportPDF, frxDBSet;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    LabeledEdit1: TLabeledEdit;
    Button1: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button2: TButton;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    ABSTable1: TABSTable;
    ABSTable2: TABSTable;
    ABSDatabase1: TABSDatabase;
    DataSource1: TDataSource;
    RadioGroup1: TRadioGroup;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Button4: TButton;
    Button5: TButton;
    PrintDialog1: TPrintDialog;
    Label3: TLabel;
    Button6: TButton;
    Button7: TButton;
    jvshfile1: TJvSHFileOperation;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    Button8: TButton;
    ABSQuery1: TABSQuery;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject); //lookup
    Procedure FilterUp(var filtro: string);
    procedure Button2Click(Sender: TObject); //clear
    procedure ABSTable1AfterInsert(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ABSTable1AfterPost(DataSet: TDataSet);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject); //del.rec.
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure DBNavigator1BeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  chi:array[1..5]of smallint;
  conta:smallint;
  filtro: string;
  flag:boolean;
implementation

{$R *.dfm}


procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);  //controllo di uscita
begin
  if Flag=true then
  begin
    if MessageDlg('    Any record to post ?'+#13#10+'Yes to post, No to exit', mtconfirmation, [mbYes,mbNo], 0) = mrNo then
      begin
        ABSTable1.Close;
        ABSDatabase1.Close;
        ABSTable2.close;
        CanClose:= True
      end else
     CanClose:= False;
  end;
       end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Application.HelpFile:='log.chm';
ABSDatabase1.DatabaseFilename:= ExtractFilePath(Application.ExeName)+'DailyLog.ABS';
ABSDatabase1.Open;
ABSTable1.TableName:='dlog';
ABSTable2.TableName:='TagTB';
ABSTable1.Open;
ABSTable2.Open;
FormatSettings.ShortDateFormat:='dd/mm/yyyy'; //per definire il formato di un campo dbgrid
             {Attenzione per poter avere il formato data senza problemi occorre
             che ci sia coerenza tra il formato indicato in form create e quello
             indicato in control panel regional settings}

end;

procedure TForm1.ABSTable1AfterInsert(DataSet: TDataSet); //per evitare che un record inserito e non postato sia perso
 var
 forma :string;
begin
  flag:=true;
  DateTimeToString(forma,'t',time);  // 't' = shortTimeFormat
  ABSTable1.FieldByName('when').AsString:=forma;
  if RadioButton3.Checked=True then ABSTable1.FieldByName('type').AsString:='Maintenance';
  if RadioButton4.Checked=True then ABSTable1.FieldByName('type').AsString:='Installation';
  if RadioButton5.Checked=True then ABSTable1.FieldByName('type').AsString:='Repair';
end;

procedure TForm1.ABSTable1AfterPost(DataSet: TDataSet); //carica il tag nella tabella tag
var                           //carica il record nella tabella 1
st:string;                    //se il tag � di pi� parole cancella ed esce
s1,s2,s3:string;
begin
RadioButton3.Checked:=True;
s1:=ABSTable1.FieldByName('location').AsString;
s2:=ABSTable1.FieldByName('who').AsString;
s3:=ABSTable1.FieldByName('type').AsString;
      if (pos(' ',s1)>0) OR(pos(' ',s2)>0)OR(pos(' ',s3)>0) then
      begin
      showmessage(' Tag fields must contain only one word. Redo !');
      ABSTable1.Delete;
      ABSTable1.Refresh;
      ABSTable1.First;
      exit;
      end;
flag:=false;
st:=ABSTable1.FieldByName('location').AsString;
if ABSTable2.Locate('tag1',st,[loCaseInsensitive])= false then
 begin
   ABSTable2.insert;
   ABSTable2.FieldByName('tag1').AsString:=st;
   ABSTable2.Post;
 end;
ABSTable1.First;
end;

procedure TForm1.Button1Click(Sender: TObject);   //filtra
var
i:smallint;
begin
 conta :=0;
 for i := 1 to 5 do
 chi[i]:=0;
 if edit1.Text <>'' then
 begin
 conta:=conta+1;
 chi[conta]:=1;
 end;
 if edit2.Text <>'' then       //ricerca da effettuare nel campo what
 begin
 conta:=conta+1;
 chi[conta]:=2;
 end;
 if edit3.Text <>'' then
 begin
 conta:=conta+1;
 chi[conta]:=3;
 end;
 if edit4.Text <>'' then
 begin
 conta:=conta+1;
 chi[conta]:=4;
 end;
 if edit5.Text <>'' then
 begin
 conta:=conta+1;
 chi[conta]:=5;
 end;
      case conta of
        0 : showmessage('Error ! No filter entered.');

        1..2 : FilterUP (filtro);

        3..5: begin
              showmessage ('Error ! Max two filters at a time: redo !');
              for i:= 1 to 5 do
              chi[i]:=0;

              edit1.text:='';
              edit2.Text:='';
              edit3.Text:='';
              edit4.Text:='';
              edit5.Text:='';
           end;
          end;
end;

 procedure TForm1.Button2Click(Sender: TObject);   //cancella la finestra di filtraggio
 var
 i: smallint;
begin
    ABSTable1.Filtered:=False;
    filtro:='';
    radiobutton1.Checked:=true;
    for i := 1 to 5 do
         chi[i]:=0;

     edit1.text:='';
     edit2.Text:='';
     edit3.Text:='';
     edit4.Text:='';
     edit5.Text:='';

end;

procedure TForm1.Button3Click(Sender: TObject);    //delete record
begin
     if MessageDlg('Delete this record ? ',mtConfirmation, mbYesNo,0)=mrYes then
     ABSTable1.Delete;
     ABSTable1.Refresh;
     ABSTable1.First;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   if Dialogs.MessageDlg('You are going to EMPTY the whole Entry data, continue ?',
    mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrNo then
    exit else
    ABSTable1.Close;
    ABSTable2.Close;
    ABSDatabase1.Close;
    ABSTable1.EmptyTable;
    ABSTable2.EmptyTable;
end;

procedure TForm1.Button5Click(Sender: TObject);  //stampa la dbgrid
var
  J,numgrid,pn: Integer;
  grd : array of array of string;
  f:TextFile;
begin                        //seleziona tutti i record in DBGrid
                             J:=0;
                             numgrid:=0;
                             SetLength (grd,numgrid,2);
                             DBGrid1.SelectedRows.Clear;
                             
                             with DBGrid1.DataSource.DataSet do
                                 begin
                                 DisableControls;
                                 First;
                                    try
                                     while not EOF do
                                      begin
                                       DBGrid1.SelectedRows.CurrentRowSelected := True;
                                       J:=J+1;
                                       Next;
                                      end;
                                    finally
                                     EnableControls;
                                    end;
                                  numgrid:=J;   //determina la lunghezza della DBGrid
                                 end;
          //carica l'array con i valori dei record;
                                 SetLength (grd,numgrid,2);
                   with DBGrid1.DataSource.DataSet do
          begin
                          first;
            for J := 0 to numgrid-1 do
            begin
               grd[J,1]:=DBGrid1.Columns.Grid.Fields[2].Text; //copia il what
               grd[J,2]:=DBGrid1.Columns.Grid.Fields[0].Text+'   '+
                         DBGrid1.Columns.Grid.Fields[1].Text+'   '+
                         DBGrid1.Columns.Grid.Fields[3].Text+'   '+
                         DBGrid1.Columns.Grid.Fields[4].Text+'   '+
                         DBGrid1.Columns.Grid.Fields[5].Text; //copia il resto
             //        showmessage(grd[J,1]+#10+grd[J,2]);
                          next;
            end;
                          first;
          end;
          //processo di stampa
          if PrintDialog1.Execute then
          begin
             AssignPrn(f);
             Rewrite(f);
             //Header
             writeln(f,'                                              Work list printed on '
             +Datetostr(Now)+'  Show: what / when-how.');

             for pn := 0 to numgrid-1 do
                    begin
                      writeln(f,grd[pn,1]);
                      writeln(f,grd[pn,2]);
                    end;
          end else exit;
          closeFile(f);
          grd:=nil;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
    ABSTable1.close;
    ABSTable2.close;
    ABSDatabase1.Close;
    Form1.release;
    application.Terminate;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin   //pu� capitare che dia errore in attesa di espressione booleana: compilare prima in debug e poi release

      if MessageDlg('Confermi di voler effettuare il backup del DataBase ?',mtconfirmation, [mbYes,mbNo],0) = mrYes then
       begin
         ABSDatabase1.Close;
         jvshfile1.Execute;
         ABSDatabase1.Open;
         ABSTable1.Open;
        //  Ricordarsi di mettere in event OnClose -> Button10 e in Object explorer del componente JvHSFile1 il nome del database
       end else Exit;   //in source e in "destFile" il nome del bckup
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  //occorre ordinare il database prima del rapporto         ISTRUZIONI
   with ABSQuery1 do                                   //inserire il modulo TABSQuery
   begin                                               // cambiare in frsDBDataset1 il DataSet in ABSQuery1
      Close;                                           //scrivere queste righe di codice
      SQL.Text:='select * from dlog ORDER BY Filed ASC';
      ExecSQL;
   end;
frxReport1.ShowReport;
end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);   //per colorare le celle
begin
          if (ABSTable1.FieldByName('type').AsString='Repair') and
          (Column.FieldName= 'type')
           then
          DBGrid1.Canvas.Brush.Color:=clRed;
          if (ABSTable1.FieldByName('type').AsString='Installation') and
          (Column.FieldName= 'type')
           then
          DBGrid1.Canvas.Brush.Color:=clLime;
          if (ABSTable1.FieldByName('type').AsString='Maintenance') and
          (Column.FieldName= 'type')
           then
          DBGrid1.Canvas.Brush.Color:=clYellow;
          DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TForm1.DBGrid2DblClick(Sender: TObject); //copia il tag nella tabella primaria
var
st2 :string;
begin
   st2:= ABSTable2.FieldByName('tag1').AsString;
   ABSTable1.FieldByName('location').AsString:=st2;
end;


procedure TForm1.DBNavigator1BeforeAction(Sender: TObject;
  Button: TNavigateBtn);
  var
    scelta:string;
begin
    if (Button = nbInsert) then
       begin
            if radiobutton3.Checked=True then scelta:='Maintenance' else
            if radiobutton4.Checked=True then scelta := 'Installation' else
            scelta := 'Repair';
       DBgrid1.DataSource.DataSet.First;
    if MessageDlg('Do you confirm Work Type is '+scelta+' ?',mtConfirmation, mbYesNo,0)=mrNo then
          begin
          showmessage(' Check type of action first !');
          SysUtils.Abort; //cancel the insert action
          exit;
          end;
       end;
    if (Button = nbEdit) then
        begin
          ABSTable1.Edit;
          if RadioButton3.Checked=True then ABSTable1.FieldByName('type').AsString:='Maintenance';
          if RadioButton4.Checked=True then ABSTable1.FieldByName('type').AsString:='Installation';
          if RadioButton5.Checked=True then ABSTable1.FieldByName('type').AsString:='Repair';
        end;

end;

Procedure TForm1.FilterUp(var filtro :string);  //filtra
    begin
    filtro:='';
     if chi[2]>0 then
       begin
         case chi[2] of
           2: filtro:='what LIKE '+QuotedStr('%'+(edit2.Text)+'%');    //uso LIKE '%XXX%' per assicurare la ricerca nella stringa
           3: filtro:='location ='+QuotedStr(edit3.Text);
           4: filtro:='who = '+QuotedStr(edit4.Text);
           5: filtro:='type = '+QuotedStr(edit5.Text);
         end;
                        if radiobutton1.Checked=true then
                              begin
         case chi[1] of
           1: filtro:=filtro+' AND filed = '+QuotedStr(edit1.Text);
           2: filtro:=filtro+' AND what LIKE '+QuotedStr('%'+(edit2.Text)+'%');
           3: filtro:=filtro+' AND location = '+QuotedStr(edit3.Text);
           4: filtro:=filtro+' AND who = '+QuotedStr(edit4.Text);
           5: filtro:=filtro+' AND type = '+QuotedStr(edit5.Text);
         end;
                              end else
                              begin
         case chi[1] of
           1: filtro:=filtro+' OR filed = '+QuotedStr(edit1.Text);
           2: filtro:=filtro+' OR what LIKE '+QuotedStr('%'+(edit2.Text)+'%');
           3: filtro:=filtro+' OR location = '+QuotedStr(edit3.Text);
           4: filtro:=filtro+' OR who = '+QuotedStr(edit4.Text);
           5: filtro:=filtro+' OR type = '+QuotedStr(edit5.Text);
         end;
                              end;

       end else
         case chi[1] of
           1: filtro:='filed = ' +QuotedStr(edit1.Text);
           2: filtro:='what LIKE '+QuotedStr('%'+(edit2.Text)+'%');
           3: filtro:='location = '+QuotedStr(edit3.Text);
           4: filtro:='who = '+QuotedStr(edit4.Text);
           5: filtro:='type = '+QuotedStr(edit5.Text);
         end;

      ABSTable1.FilterOptions := [foCaseInsensitive];
      ABSTable1.Filter := filtro;
      ABSTable1.Filtered:=True;
      ABSTable1.First;
    end;

end.

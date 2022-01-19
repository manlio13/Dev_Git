unit Ml961226;
 {Registro 1.0 Sistema di catalogazione -codice-argomento- 26.12.96 M.Laschena}
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes,Dialogs, Controls,Graphics,
  StdCtrls, Forms, DBCtrls, DB, DBTables, Mask, ExtCtrls, Buttons, Grids,
  DBGrids;

type
  TForm1 = class(TForm)
    ScrollBox: TScrollBox;
    Label1: TLabel;
    EditCod: TDBEdit;
    Label2: TLabel;
    EditArgomento: TDBEdit;
    DBNavigator: TDBNavigator;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Query1: TQuery;
    Label3: TLabel;
    edit1: TEdit;
    BitBtn1: TBitBtn;
    updatequery: TQuery;
    GroupBox1: TGroupBox;
    Baggiungi: TButton;
    Bcancella: TButton;
    aggiungi: TQuery;
    Cancella: TQuery;
    modifica: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    edit2: TEdit;
    Edit3: TEdit;
    help: TButton;
    Label6: TLabel;
    Timer1: TTimer;
    procedure BaggiungiClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure modificaClick(Sender: TObject);
    procedure timer1timer(Sender: TObject);
    procedure BcancellaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure helpClick(Sender: TObject);
    procedure EditCodClick(Sender: TObject);
    procedure EditArgomentoClick(Sender: TObject);
  private

  public
   nuovihint:TstringList;
  end;

var

  Form1: TForm1;
  etichetta:string;
implementation

{$R *.DFM}
procedure TForm1.FormCreate(Sender: TObject);
begin
nuovihint :=TstringList.Create;
                     with nuovihint do
                     begin
                     Add('Primo record');
                     Add('Record precedente');
                     Add('Record Seguente');
                     Add('Ultimo record');

                     end;
           DBNavigator.Hints := nuovihint;
           DBNavigator.ShowHint := True;
          timer1.Enabled:=not(timer1.enabled);

end;
  procedure Tform1.Timer1Timer(Sender:Tobject);
   begin
         etichetta := Form1.Caption;

Form1.caption:=copy(etichetta,length(etichetta),1)
          +copy(etichetta,1,(length(etichetta)-1));

   end;




 procedure TForm1.BitBtn1Click(Sender: TObject);
var
s : string;
begin
if edit1.text <> '' then
   begin
                try

   with query1 do
        begin
  edit2.text:='';
  edit3.text:='';

CLOSE;
SQL.CLEAR;
SQL.ADD('SELECT * FROM di where Argomento like :ricerca');
s:='%'+edit1.text+'%';
prepare;
params[0].asstring :=s;
open;
                   if editcod.text='' then
     messagedlg('Non trovo corrispondenze.',mtinformation,[mbOK],0);

        end;

                 except

   on e : EDatabaseError do
   messageDlg(e.message,mtError,[mbOK],0);
                 end;

   end
                     else
           begin
           editcod.text:='';
           editargomento.text:='';
           end;
end;

procedure TForm1.modificaClick(Sender: TObject);
     begin
 if (edit2.text='') and (edit3.text='') then
  begin
  edit2.text:=EditCod.text;
  edit3.text:=EditArgomento.text;
  end
  else
            try
            
            updateQuery.prepare;
            updateQuery.Params[0].AsString:=edit2.text;
            updateQuery.Params[1].Asstring:=edit3.text;
            updateQuery.Params[2].AsString:=edit2.text;
            updateQuery.ExecSQL;
            query1.close;
            query1.open;
            
            refresh;
            edit2.text:='';
            edit3.text:='';
            except
                 on e : EDatabaseError do
   messageDlg(e.message,mtError,[mbOK],0);
            end;
     end;

procedure TForm1.BaggiungiClick(Sender: TObject);
begin
           try
       if (edit2.text<>'') and (edit3.text<>'') then
          with aggiungi do
               begin
          close;
          prepare;
          Params[0].AsString:=edit2.text;
          Params[1].Asstring:=edit3.text;
          execSQL;
          query1.close;
          query1.open;
               end

          else
   messagedlg('occorre inserire un codice ed un argomento',mtWarning,[mbOK],0);
          finally
          edit2.text:='';
          edit3.text:='';
          end;
end;

procedure TForm1.BcancellaClick(Sender: TObject);
var
 c:string;
 a:string;
begin
c:=query1.fields[0].Asstring;
a:=query1.fields[1].Asstring;
if messagedlg(Format('Cancella "%s" - "%s" ?',[c,a]),mtConfirmation,mbOKCancel,0)=mrOK then
   begin
        try
        with cancella do
              begin
              prepare;
              params[0].asstring:=c;
              params[1].asstring:=a;
              execSQL;
              end;
        query1.close;
        query1.open;
        except
        on e : EDatabaseError do
        messageDlg(e.message,mtError,[mbOK],0);
        end;

   end;
end;



procedure TForm1.helpClick(Sender: TObject);
begin
 Application.helpfile:='.\registro.hlp';
 Application.HelpCommand(HELP_CONTENTS,0);
end;

procedure TForm1.EditCodClick(Sender: TObject);
begin
 messagedlg('Non si scrive in quest''area',mtWarning,[mbOK],0);
end;

procedure TForm1.EditArgomentoClick(Sender: TObject);
begin
messagedlg('Non si scrive in quest''area',mtWarning,[mbOK],0);
end;

end.


unit Unit3;

interface

uses
  Windows,Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, Grids, Wwdbigrd, Wwdbgrid,
  Db, DBTables, Wwtable, Wwdatsrc, DBCGrids, ExtCtrls, DBCtrls, Buttons;

type
  TForm3 = class(TForm)
    wwDataSource1: TwwDataSource;
    wwTable1: TwwTable;
    DBCtrlGrid1: TDBCtrlGrid;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwDBComboBox1: TwwDBComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBNavigator1: TDBNavigator;
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure SpeedButton1Click(Sender: TObject);
    procedure wwDBEdit1focus(Sender: TObject);
    procedure wwDBEdit2Exit(Sender: TObject);
    procedure wwDBComboBox1Exit(Sender: TObject);
    procedure wwDBEdit3Exit(Sender: TObject);
    procedure wwDBEdit1Enter(Sender: TObject);
    procedure wwDBEdit2Enter(Sender: TObject);
    procedure wwDBEdit3Enter(Sender: TObject);
    procedure wwDBComboBox1Enter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
  procedure ShowHint(Sender:TObject);
    { Public declarations }
  end;

var
  Form3: TForm3;
  fl: string;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm3.FormShow(Sender: TObject);
var
cau: string;
begin
     {showscrollbar(dbctrlgrid1.handle,SB_VERT,false); non funzia }
     fl:='';
     Application.OnHint:=ShowHint;
     try
     wwTable1.open; {costruisce la lista delle causali}
     wwTable1.edit;
     wwTable1.first;
     except
     Messagedlg(e_not_db,mtError,[mbOK,mbHelp],1);
     Application.terminate;
     end;
     While not wwTable1.EOF do
           begin
           cau:=wwTable1.FieldByName('Caus').AsString;
           with wwDBComboBox1 do
           if(cau<>'')and(items.indexof(cau)<0) then
           items.add(cau);
           wwTable1.next;
           end;
           wwTable1.last;
                         if cor='no' then  {se non in modalità edit}
                         begin
           wwTable1.append;{aggiunge un record vuoto}
           wwTable1.FieldbyName('Cod').asString:='M';
                         end;
     wwdbedit1.setfocus;

end;

procedure TForm3.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
 if Button=nbinsert then   {la procedura "passa" il parametro "Button" al
                           quale agganciare l'if }
 wwTable1.FieldbyName('Cod').asString:='M';
end;

procedure TForm3.SpeedButton1Click(Sender: TObject);  {exit}
begin
if wwtable1.FieldByName('Importo').asinteger=0 then
begin
fl:='no';
wwtable1.delete;
end;
wwtable1.edit;
wwtable1.Post;
Form1.label1.caption:='';
application.processmessages;{per consentire la scrittura della label prima
                                   dell'attivazione della funzione del menù}
wwtable1.close;
form3.close;
end;

procedure TForm3.wwDBEdit1focus (Sender: TObject);
begin
{if (wwtable1.FieldbyName('DATA').asstring='')and (fl='') then {dbedit è un
 vettore, occorre  riferirsi al suo contenuto se si desidera controllarne
 il valore}{
 begin
messagedlg('Digitare il dato.',mtError,[mbOK],0);
 wwdbedit1.setfocus;
end
else
 }

end;

procedure TForm3.wwDBEdit2Exit(Sender: TObject);
begin
{ if (wwtable1.FieldbyName('Importo').asstring='') and (fl='') then
 {dbedit è un vettore, occorre riferirsi al suo contenuto se si desidera
 controllarne il valore}
{begin
messagedlg('Digitare il dato.',mtError,[mbOK],0);
 wwdbedit2.setfocus;
end
else
 }

end;

procedure TForm3.wwDBComboBox1Exit(Sender: TObject);
begin
 {if (wwtable1.FieldbyName('Caus').asstring='')and (fl='')then {dbedit è un vettore,
  occorre riferirsi al suo contenuto se si desidera controllarne il valore}
{begin
messagedlg('Digitare il dato.',mtError,[mbOK],0);
 wwdbcombobox1.setfocus;
end
else
  }

end;

procedure Tform3.ShowHint(Sender:TObject);
          begin
          Panel1.Caption:= '  '+Application.Hint;
          end;

procedure TForm3.wwDBEdit3Exit(Sender: TObject);
begin
    panel1.caption:='   '+'Click su + per nuovo record.';
end;

procedure TForm3.wwDBEdit1Enter(Sender: TObject);
begin
  panel1.caption:='  '+wwdbedit1.hint;
end;

procedure TForm3.wwDBEdit2Enter(Sender: TObject);
begin
  panel1.caption:='  '+wwdbedit2.hint;
end;

procedure TForm3.wwDBEdit3Enter(Sender: TObject);
begin
   panel1.caption:='  '+wwdbedit3.hint;
end;

procedure TForm3.wwDBComboBox1Enter(Sender: TObject);
begin
   panel1.caption:='  '+wwdbcomboBox1.hint;
end;

procedure TForm3.FormKeyPress(Sender: TObject; var Key: Char);
begin
if (key=char(13)) then
DBCtrlGrid1.dokey(gknexttab);

end;

end.

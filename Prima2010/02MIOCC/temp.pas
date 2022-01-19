unit temp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Db, DBTables, Grids,DBCtrls, ExtCtrls,DBCGrids;
  {DBCgridE è la versione per leggere il tasto enter}
type
  TForm1 = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    DBCtrlGrid1: TDBCtrlGrid;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    procedure Formcreate(Sender: TObject);


  private
    { Procedure CMDialogkey(var Msg:TWMkey);message CM_DIALOGKEY;
   } { Private declarations }
  public

    { Public declarations }
  end;

   var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Formcreate(Sender: TObject);
begin

DBedit1.setfocus;
end;
{Procedure TForm1.CMDialogKey(var Msg: TWMKEY);
begin
     if Msg.CharCode=VK_RETURN then
     Msg.CharCode:=VK_TAB;
     inherited;
     activecontrol.setfocus;

end; }

end.

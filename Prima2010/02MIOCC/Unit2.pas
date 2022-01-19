unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, Grids, Wwdbigrd, Wwdbgrid, Db, DBTables, Wwtable,
  Wwdatsrc, StdCtrls, Mask, wwdbedit, Buttons;

type
  TForm2 = class(TForm)
    wwDataSource1: TwwDataSource;
    wwTable1: TwwTable;
    wwDBGrid1: TwwDBGrid;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    
    { Public declarations }
  end;

var
  Form2: TForm2;
   totE,totM: real;
implementation
 uses Unit1;
{$R *.DFM}

procedure TForm2.FormShow(Sender: TObject);
begin
wwTable1.open;
wwTable1.first;
totE:=0;
totM:=0;
     While not wwTable1.EOF do
           begin
           if wwtable1.Fieldbyname('cod').asString ='E' then
           totE:=totE+wwTable1.Fieldbyname('importo').asInteger;
           totM:=totM+wwTable1.Fieldbyname('importo').asInteger;
           wwtable1.Next;
           end;
 wwTable1.last;
 label1.caption:=format('Saldo Conto Banca : %.0n',[totE]);
 label2.caption:=format('Saldo mio                : %.0n',[totM]);
end;

procedure TForm2.SpeedButton1Click(Sender: TObject); {exit}
begin
 Form1.label1.caption:='';
application.processmessages;{per consentire la scrittura della label prima
                                   dell'attivazione della funzione del menù}
wwtable1.close;{ si può usare close se all'apertura multipla si provvede sempre
 ad avere il dataset aperto}
form2.close; {close e non release per non rilasciare lo spazio in memoria}
end;

end.

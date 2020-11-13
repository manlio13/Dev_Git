unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Wwtable, Wwdatsrc, Menus,unit2,unit3, ExtCtrls, StdCtrls,
  DBCtrls, Grids, Wwdbigrd, Wwdbgrid, Buttons;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    corrente1: TMenuItem;
    leggi1: TMenuItem;
    carica1: TMenuItem;
    banca1: TMenuItem;
    leggi2: TMenuItem;
    carica2: TMenuItem;
    controlli1: TMenuItem;
    quadra1: TMenuItem;
    gestione1: TMenuItem;
    statistiche1: TMenuItem;
    servizio1: TMenuItem;
    causali1: TMenuItem;
    inserisci1: TMenuItem;
    Label1: TLabel;
    correggi1: TMenuItem;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    wwDBGrid1: TwwDBGrid;
    DBNavigator1: TDBNavigator;
    wwDataSource1: TwwDataSource;
    wwTable1: TwwTable;

    procedure leggi1Click(Sender: TObject);
    procedure inserisci1Click(Sender: TObject);
    procedure correggi1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  cor :string;
const
e_not_db='Non riesco ad aprire il file conto.db.';
attesa='L''attivazione del menù può richiedere tempo.';
implementation

{$R *.DFM}

procedure TForm1.leggi1Click(Sender: TObject);
begin

  label1.caption:= attesa;
  application.processmessages;{per consentire la scrittura della label prima
                                   dell'attivazione della funzione del menù}
  form2.show;

end;

procedure TForm1.inserisci1Click(Sender: TObject);
begin
cor:='no';
label1.caption:= attesa;
application.processmessages;{per consentire la scrittura della label prima
                                   dell'attivazione della funzione del menù}
form3.show;
end;

procedure TForm1.correggi1Click(Sender: TObject);
begin
cor:='si';
label1.caption:= attesa;
application.processmessages;{per consentire la scrittura della label prima
                                   dell'attivazione della funzione del menù}
form3.show;
end;

end.

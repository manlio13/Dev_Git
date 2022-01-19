unit ml980726;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Db, DBTables, StdCtrls, Aligrid, Buttons;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    Table2: TTable;
    DataSource2: TDataSource;
    StringGrid1: TStringAlignGrid;
    PrinterSetupDialog1: TPrinterSetupDialog;
    stampa: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure stampaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  subtot : array[1..30,1..12]of integer;
  cau : array[1..30] of string; {max num. di causali 30}
  n1,tot :integer;
  din,dfin,dd :Tdatetime;
  in1:string;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
 var
 k,kk,lastcau,co,ri:integer;
 aa,mm,gg :word;

begin
    in1:=inputbox('digita l''anno (es.1998)','Esamina i dati del .. ','1998');
    n1 := strtoint(in1);
    din :=encodedate(n1,1,1);
    dfin:=encodedate(n1,12,31);
    for k:=1 to 30 do      {AZZERA LE CAUSALI}
    cau[k]:='';
    for k:=1 to 31 do      {AZZERA I SUBTOTALI}
        begin
        for kk:=1 to 14 do
        subtot[k,kk]:=0;
        end;
    k:=1;
    table2.active:=true;
     table2.first;
     while not table2.eof do   {carica le causali}
     begin
     cau[k]:=table2.Fieldbyname('caus').asString;  {non essendo stato
                 dichiarato il campo CAUS occorre passare per Fieldbyname}
     table2.next;
     k:=k+1;
     end;           {ha finito di caricare le causali da table2 su cau[] }
     table2.active:=false;
      lastcau:=k-1;
      { inizia a costruire i totali}
      with table1 do
      begin      {impone il filtro di data}
     active:=true;
     filter :='([DATA]>='''+datetostr(din)+''')AND([DATA]<='''+
                                                 DatetoStr(dfin)+''')';
     filtered:=true;

     first;  {VA AL PRIMO RECORD}
      end;       {fine filtro e posizionamento}
     {scanning del conto e costruzione dei totali per causale per mese}
     for k:=1 to lastcau do  {scan delle causali}
                   begin
     while not table1.eof do
           begin
     if cau[k]= table1.FieldbyName('CAUS').asString then
     begin
          dd:=table1.FieldbyName('DATA').asDateTime;   {preleva la data}
          decodeDate(dd,aa,mm,gg);     {la decodifica per avere il mese}
          subtot[k,mm]:=subtot[k,mm]+table1.FieldValues['IMPORTO'];{l'importo}
          {costruisce la matrice causale,mese = importo cumulativo}
          table1.next;   {avanza}
     end
     else
     table1.next;
            end;
            table1.First;
                   end;   {fine scanning causali e subtotali}
      with stringGrid1 do
      begin
         cells[0,0]:='Caus';
         cells[1,0]:='Gen';
         cells[2,0]:='Feb';
         cells[3,0]:='Mar';
         cells[4,0]:='Apr';
         cells[5,0]:='Mag';
         cells[6,0]:='Giu';
         cells[7,0]:='Lug';
         cells[8,0]:='Ago';
         cells[9,0]:='Set';
         cells[10,0]:='Ott';
         cells[11,0]:='Nov';
         cells[12,0]:='Dic';
         cells[13,0]:='Tot';
         cells[13,31]:='ML@1998';
      end;                     {scritto il titolo orizzontale}
      With stringGrid1 do
   begin
      tot:=0;
      for k:=1 to 30 do    {cella(colonna,riga)}
      cells[0,k]:=cau[k];
      cells[0,rowcount-1]:='Tot'; {scritto il titolo verticale}
      stringGrid1.fixcolorcol[13]:=clAqua;
      stringGrid1.fixcolorrow[31]:=clAqua;
      stringGrid1.colorcol[13]:=clltgray;
      stringGrid1.colorrow[31]:=clltgray;
      stringGrid1.fixaligncol[0]:=alCenter;
      stringGrid1.fixalignrow[0]:=alCenter;
      stringGrid1.ColorCell[13,31]:=clAqua;
      for ri:=1 to rowcount-2 do   {scrive la matrice causali-mese}
        begin
          for co:=1 to colcount-2 do
          begin
          cells[co,ri]:=inttostr(subtot[ri,co]);
          tot:=tot+subtot[ri,co];
          end;
          cells[colcount-1,ri]:=inttostr(tot); {totale annuo}
          tot:=0;
        end;
       for co:=1 to 12 do
           begin
       for ri:=1 to 30 do
           tot:=tot+subtot[ri,co];
           cells[co,rowcount-1]:=inttostr(tot); {totale mensile}
           tot:=0;
           end;

   end;
end;

procedure TForm1.stampaClick(Sender: TObject);
begin
  printersetupdialog1.execute;
  print;
end;

end.
{ sorgente sezione programma sul conto corrente che realizza la
   tabella di riepilogo. 6.8.98 }

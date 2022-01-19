unit Classifiche;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
  Vcl.Grids,System.DateUtils,Data.DB, Vcl.DBGrids, Vcl.DBCtrls, Vcl.ExtCtrls,
  ABSMain, frxClass, frxDBSet,Datasnap.DBClient, Datasnap.Provider,Vcl.HtmlHelpViewer;

type
  TForm8 = class(TForm)
    Esci: TButton;
    DBGrid8: TDBGrid;
    DataSource8: TDataSource;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    ListBox8: TListBox;
    Button4: TButton;
    Button6: TButton;
    Shape1: TShape;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Button7: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    ComboBox1: TComboBox;
    Label6: TLabel;
    ABSQuery80: TABSQuery;
    DataSourceQry: TDataSource;
    ABSTable15: TABSTable;
    ABSQuery85: TABSQuery;
    frxReport8: TfrxReport;
    frxDBDataset85: TfrxDBDataset;
    ABSQuery83: TABSQuery;
    ABSTable16: TABSTable;
    DataSourceQry2: TDataSource;
    ABSTable18: TABSTable;
    frxReport8D: TfrxReport;
    frxDBDataset8D: TfrxDBDataset;
    frxReport16: TfrxReport;
    frxDBDataset16: TfrxDBDataset;
    frxReport16T: TfrxReport;
    frxDBDataset16T: TfrxDBDataset;
    frxReport16T2: TfrxReport;
    frxDBDataset16t2: TfrxDBDataset;
    ABSQueryRep: TABSQuery;
    ABSTable19: TABSTable;
    ABSTable16R:TABSTable;
    frxReportTot: TfrxReport;
    frxDBDatasetTot: TfrxDBDataset;
    Bevel1: TBevel;
    frxReportR: TfrxReport;
    frxDBDatasetR: TfrxDBDataset;
    ABSQueryR: TABSQuery;
    procedure FormCreate(Sender: TObject);
    procedure EsciClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid8CellClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Calcola(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;                               //ArGare Gare selezionate
  ClassFlg:Boolean=True;                       //ArDspl  Discipline selezionate
  ArGare,ArDspl,ArCat:array of Integer;//ArCat  Categorie selezionate
  SelGare:Boolean=False;
  SelDspl:Boolean=False;
  ClassDp:Boolean=False;
  i,idx,mom,momd,MaxIdxGare,MaxIdxDspl,MaxIdxCat:Integer;
implementation
uses
Console1 ;
{$R *.dfm}
{$D+}
procedure TForm8.FormCreate(Sender: TObject);
begin
  ClassFlg:=False;
 // Form2.ABSTable3.TableName:='SelezioneGare';
  Form2.ABSTable3.Open;
  Form2.ABSTable3.Edit;
 // Form2.ABSTable3D.TableName:='SelezioneDSPL';
  Form2.ABSTable3D.Open;
  Form2.ABSTable3D.Edit;
  ABSTable15.TableName:='Classifica';
  ABSTable15.Open;
  ABSTable15.Edit;
  ABSTable16R.TableName:='R16R';
  ABSTable16R.Open;
  Form2.ABSTable1.Open;   //registra su Servizio
  Form2.ABSTable1.INSERT;
  Form2.ABSTable1.FieldByName('IN').AsDateTime:= NOW;
  Form2.ABSTable1.FieldByName('what').AsString:='Accesso alle Classifiche';
  Form2.ABSTable1.FieldByName('OUT').AsString:='';
  Form2.ABSTable1.Post;
  Form2.ABSTable1.Close;
  Form2.ABSTable6.Open;
  Form2.ABSTable8.Open;
  if ABSTable15.RecordCount>0 then
   begin
     TDateTimeField(Form8.ABSTable15.FieldByName('TAME1')).DisplayFormat:='nn:ss,zzz';
     TDateTimeField(Form8.ABSTable15.FieldByName('TBME2')).DisplayFormat:='nn:ss,zzz';
     TDateTimeField(Form8.ABSTable15.FieldByName('PEN')).DisplayFormat:='nn:ss,zzz';
   end;
  ABSTable16.TableName:='Ranking';
  ABSTable18.TableName:='Temp8';
  Form2.ABSTable5.Open;
  Form2.ABSTable4.Open;
  SetLength(ArGare,20);
  SetLength(ArDspl,20);
  SetLength(ArCat,10);
  ABSTable19.TableName:='totale';
  Shape1.Brush.Color := clRed;
  Shape2.Brush.Color := clRed;
  Shape3.Brush.Color := clRed;
  RadioButton1.Color:= clRed;
  RadioButton2.Color:= clRed;
  RadioButton3.Color:= clRed;
end;

procedure TForm8.Button1Click(Sender: TObject);  //Seleziona le gare
begin
     DataSource8.DataSet:=Form2.ABSTable5;        //display gare su dbgrid
     DBGrid8.DataSource:=DataSource8;
     DBGrid8.Width:=376;
     DBGrid8.Columns[0].Width:=44;
     DBGrid8.Columns[1].Width:=64;
     DBGrid8.Columns[2].Width:=228;
     SelGare:=True;
     SelDspl:=False;
     SetLength(ArGare,0);
     SetLength(ArGare,20);
     Shape1.Brush.Color := clRed;
end;

procedure TForm8.DBGrid8CellClick(Column: TColumn);  //Inserisci-Scegli
begin
    ListBox8.Items.Add(DBGrid8.Fields[0].AsString);
    Self.ActiveControl:=nil;
end;

procedure TForm8.Button2Click(Sender: TObject);    //Rimuovere
begin
    if ListBox8.Items.Count > 0 then  //verifica che  non c'è  selezionato
      begin
          if ListBox8.Itemindex =-1 then
           begin
            ShowMessage('Nessun elemento selezionato');
            Exit;
           end;
      end;
   ListBox8.DeleteSelected;
end;

procedure TForm8.Button3Click(Sender: TObject);    //Salva i valori negli array
var
k:ShortInt;
kk:Integer;
begin
    for i := ListBox8.Items.Count - 1 downto 0 do  //toglie gli spazi vuoti
     begin
      if (Trim(ListBox8.Items[i]) = '') then
         ListBox8.Items.Delete(i);
     end;

 if MessageDlg('Confermi gli elementi scelti ?',mtconfirmation,[mbYes,mbNo], 0)
  = mrNo then
       begin
          if SelGare=True then         // verifica la scelta
            begin
              SetLength(ArGare,0);
              SetLength(ArGare,20);
              Shape1.Brush.Color := clRed;
            end;
          if SelDspl=True then
            begin
              SetLength(ArDspl,0);
              SetLength(ArDspl,20);
              Shape2.Brush.Color := clRed;
            end;
          ListBox8.Clear;
          Exit;
       end;

    if SelGare=True then                        //Salva le Gare scelte nell'ARRAY
      begin
         for k := 0 to ListBox8.Items.Count-1 do
           begin
             kk:= StrToInt(ListBox8.Items[k]); // NOTA BENE gli array non consentono
             ArGare[k]:= kk;                   // di elimare il passaggio tramite kk
           end;

           for i := 0 to High(ArGare) do //sistema per verificare se l'array è vuoto
       if ArGare[i]=0 then         // va al primo vuoto e segna l'indice precedente
        begin
          mom := i-1;
          MaxIdxGare:=mom;
          Break;
        end;
       if mom=-1 then
        begin
         ShowMessage('Non vi sono elementi da salvare ! - ripeti');
         Exit;
        end else                                        //reinizializza
             begin
               ShowMessage(' Dati salvati');
               Shape1.Brush.Color := clLime;
             end ;

          for k := ListBox8.Items.Count - 1 downto 0 do   //resetta la listBox
           ListBox8.Items.Delete(k);
           SelGare:=False;
      end;

    if SelDspl=True then                     // memorizza le discipline
      begin
         for k := 0 to ListBox8.Items.Count-1 do
           begin
             kk:= StrToInt(ListBox8.Items[k]); // NOTA BENE gli array non consentono
             ArDspl[k]:= kk;                   // di elimare il passaggio tramite kk
           end;

           for i := 0 to High(ArDspl) do    //Questo è l'unico sistema per verificare
       if ArDspl[i]=0 then                // se l'array è vuoto
        begin
          mom := i-1;
          MaxIdxDspl:=mom;
          Break;
        end;
       if mom=-1 then
        begin
         ShowMessage('Non vi sono elementi da salvare ! - ripeti');
         Exit;
        end else                                        //reinizializza
             begin
               ShowMessage(' Dati salvati');
               Shape2.Brush.Color := clLime;
             end ;
         for k := ListBox8.Items.Count - 1 downto 0 do   //resetta la listBox
           ListBox8.Items.Delete(k);
           SelDspl:=False;
      end;

end;

procedure TForm8.Button4Click(Sender: TObject);      //Seleziona le discipline
var
k:ShortInt;
begin
    for k := ListBox8.Items.Count - 1 downto 0 do   //resetta la listBox
           ListBox8.Items.Delete(k);        //nel caso fosse inserita una gara
           SelGare:=False;
    DataSource8.DataSet:=Form2.ABSTable4;        //display gare su dbgrid
     DBGrid8.DataSource:=DataSource8;
     DBGrid8.Width:=376;
     DBGrid8.Columns[0].Width:=44;
     DBGrid8.Columns[1].Width:=241;
     DBGrid8.Columns[2].Width:=50;
     Shape2.Brush.Color := clRed;
     SelDspl:=True;
     SelGare:=False;
     SetLength(ArDspl,0);
     SetLength(ArDspl,20);
     for i := 0 to High(ArGare) do   //Controlla che le gare siano state indicate
      if ArGare[i]=0 then
        begin
          mom := i-1; //mom = all'ultimo elemento dell'array memorizzato
          Break;
        end;
      if mom=-1 then
        begin
          Shape1.Brush.Color := clRed;
          ShowMessage('Scegli prima una o più gare'+#13+'   e salva');
          DBGrid8.DataSource.DataSet.Close;       //svuota la dbgrid
          DBGrid8.Refresh;
          Exit;
        end;

end;

procedure TForm8.Button6Click(Sender: TObject);      // CLASSIFICARE  PER GARE
var
garesi,dsplsi,trovato:Boolean;
QryStr:string;
Cgara,Cdspl,qtrl:Integer;
begin

    Form2.ABSTable3.Close;
    Form2.ABSTable3.EmptyTable;  //resetta la tabella gare selezionate
    Form2.ABSTable3.Open;
    for i := 0 to High(ArGare) do
      if ArGare[i]=0 then
        begin
          mom := i-1; //mom = all'ultimo elemento dell'array memorizzato
          Break;
        end;
      if mom=-1 then
        begin
          ShowMessage('Non vi sono elementi memorizzati ! - ripeti');
          Shape1.Brush.Color := clRed;
          Exit;
        end;
    for i:= 0 to mom do     //crea la tabella 3
      begin
       idx:=ArGare[i];   //Trasferisce i dati dall'Array alla Tabella
       Form2.ABSTable3.Insert;
       Form2.ABSTable3.FieldByName('Codice').AsInteger:=idx;
       garesi:=Form2.ABSTable5.Locate('CODGA',idx,[]);
       Form2.ABSTable3.FieldByName('Descrizione').AsString:=
                   Form2.ABSTable5.FieldByName('LUOGO').AsString;
       Form2.ABSTable3.Post;
      end;

     if comboBox1.ItemIndex=-1 then     //verifica Categoria
        begin
           ShowMessage('Devi scegliere una Categoria');
           Exit;
        end else
     begin
       if MessageDlg('Confermi di effettuare la classifica per la Categoria '+comboBox1.Text+'  ?',
         mtconfirmation, [mbYes,mbNo], 0) = mrNo then
          begin
           Shape3.Brush.Color := clRed;
           Exit ;
           end ;
        Shape3.Brush.Color := clLime;
     end;
    //Verifica esistenza Gruppo
    if (RadioButton2.Checked=False)and (RadioButton1.Checked=False) and (RadioButton3.Checked=False ) then
      begin
       ShowMessage('Devi scegliere un GRUPPO');
       Exit;
      end;
                 //DataSource8 è associato alla tabella Gare Selezionate
     DataSource8.DataSet:=Form2.ABSTable3;        //display gare su dbgrid
     DBGrid8.DataSource:=DataSource8;
     DBGrid8.Width:=376;
     DBGrid8.Columns[0].Width:=44;
     DBGrid8.Columns[1].Width:=291;
     if MessageDlg('Confermi di effettuare la classifica come selezionato?',
      mtconfirmation, [mbYes,mbNo], 0) = mrNo then
      begin
        Form2.ABSTable3.Close;
        Form2.ABSTable3.EmptyTable;
        Shape1.Brush.Color := clRed;
        SetLength(ArGare,0); //azzera l'array delle Gare non confermando la scelta
        SetLength(ArGare,20);
        Exit;
      end;
    
         //GRUPPO BASE
     if RadioButton1.Checked=True then
        if MessageDlg('Confermi di effettuare la classifica sul Gruppo Base ?',
           mtconfirmation, [mbYes,mbNo], 0) = mrNo then
        begin
          ShowMessage('Cambia il Gruppo');
          Exit;
        end else
        begin   //converte l'array delle gare in string per il Query
           if Form2.ABSTable6.RecordCount=0 then
               begin
                 ShowMessage('Attenzione il Gruppo scelto non contiene discipline !');
                 Exit;
               end;
               QryStr:='(';
             for i := 0 to MaxIdxGare-1 do
               QryStr:=QryStr+IntToStr(ArGare[i])+',';
               QryStr:=QryStr+IntToStr(ArGare[MaxIdxGare]);
               QryStr:=QryStr+')';

            with ABSQuery80 do     //Estrae dal Base le discipline gruppo Base
              begin                //per tutte le gare indicate e estrae le
                Close;             // coppie di valori n.gara e n.disciplina
                SQL.Text:='Select * from Base where CODGA IN '+QryStr; //dall'ARRAY
                ExecSQL;
                Open;
              end;
             if ABSQuery80.RecordCount=0 then
               begin
                 ShowMessage('Attenzione il Gruppo scelto non contiene discipline !');
                 Exit;
               end;
               //Fase di raccolta record da classificare in T15 Classifica
           if ABSTable15.RecordCount>0 then    //Azzero la tabella Classifica
            begin                             // preesistente per non causare
              ABSTable15.Close;               // problemi di indice unique
              ABSTable15.EmptyTable;
              ABSTable15.Open;
            end;
           ABSTable15.First; //era "last" ?
           ABSQuery80.First; //ABSQuery80 è una tabella con gare e discipline
           qtrl:=ABSQuery80.RecordCount;
           while not ABSQuery80.EOF do            // selezionate
             begin
              Cgara:=ABSQuery80.FieldByName('CODGA').AsInteger;
              Cdspl:=ABSQuery80.FieldByName('CODDSPL').AsInteger;
                with ABSQuery85 do     //Estrae dalle Gare le discipline da classif
                 begin   //Costruisce Classifica con tutti i record gare e discipline
                  Close; //selezionate e gli Atleti che le hanno in comune
                  SQL.Text:='INSERT INTO Classifica SELECT * From Gara where CODGA='
                  +QuotedStr(IntToStr(Cgara))+' AND CODDSPL='+QuotedStr(IntToStr(Cdspl))
                  + 'AND CAT ='+ quotedstr(comboBox1.text);
                  ExecSQL;
                 end;
               qtrl:=qtrl-1;
               ABSQuery80.Next;
             end;
          ComboBox1.ItemIndex:=-1;
          if qtrl>0 then ShowMessage('ABSQuery80 errore eof');

            with ABSQuery85 do
              begin
                Close;
                SQL.Text:='Select * from Classifica  Order By "COGNOME","CODDSPL"';
                ExecSQL;
                Open;
              end;
            ABSTable15.Close;   //30/04/15 18:06 devo cancellare per poter sostituire
            ABSTable15.EmptyTable; //con i dati sortati e senza problemi di indice
            ABSTable15.Open;
            ABSTable15.Last;
            ABSQuery85.First;
            qtrl:=ABSQuery85.RecordCount;
            while not ABSQuery85.EOF do  //copia il query ordinato nella Tabella 15
              begin
                ABSTable15.Insert;
                ABSTable15.FieldByName('NMR').AsInteger:=
                              ABSQuery85.FieldByName('NMR').AsInteger;
                ABSTable15.FieldByName('CODGA').AsInteger:=
                              ABSQuery85.FieldByName('CODGA').AsInteger;
                ABSTable15.FieldByName('CODDSPL').AsInteger:=
                              ABSQuery85.FieldByName('CODDSPL').AsInteger;
                ABSTable15.FieldByName('CODATL').AsInteger:=
                              ABSQuery85.FieldByName('CODATL').AsInteger;
                ABSTable15.FieldByName('COGNOME').AsString:=
                              ABSQuery85.FieldByName('COGNOME').AsString;
                ABSTable15.FieldByName('NMPET').AsInteger:=
                              ABSQuery85.FieldByName('NMPET').AsInteger;
                ABSTable15.FieldByName('NMPOS').AsInteger:=
                              ABSQuery85.FieldByName('NMPOS').AsInteger;
                ABSTable15.FieldByName('TAME1').AsDateTime:=
                              ABSQuery85.FieldByName('TAME1').AsDateTime;
                ABSTable15.FieldByName('TBME2').AsDateTime:=
                              ABSQuery85.FieldByName('TBME2').AsDateTime;
                ABSTable15.FieldByName('DQ').AsBoolean:=
                              ABSQuery85.FieldByName('DQ').AsBoolean;
                ABSTable15.FieldByName('PEN').AsDateTime:=
                              ABSQuery85.FieldByName('PEN').AsDateTime;
                ABSTable15.FieldByName('MANL').AsBoolean:=
                              ABSQuery85.FieldByName('MANL').AsBoolean;
                ABSTable15.FieldByName('CAT').AsInteger:=
                              ABSQuery85.FieldByName('CAT').AsInteger;
                qtrl:=qtrl-1;
                ABSTable15.Post;
                ABSQuery85.Next;
              end;
           if qtrl>0 then ShowMessage('ABSQuery85 errore eof');
          
          if MessageDlg('Desideri esaminare un rapporto dei Dati Base per la Classifica ?'
           ,mtconfirmation, [mbYes,mbNo], 0) = mrYes then
            begin
              frxReport8.ShowReport;   //dati da ABSTable15 (Classifica)
                 if MessageDlg('Confermi i dati a base della classifica? '+#13+
                  'In caso negativo ESCI e correggi le scelte fatte.',
                   mtconfirmation, [mbYes,mbNo], 0) = mrNO then
                   begin
                     ABSTable15.Close;
                     ABSTable15.EmptyTable;
                     Exit;
                   end;
            end;

           RadioButton1.Color:= clLime;
           Calcola(Self);
           Exit;
        end;

        //GRUPPO A
      if RadioButton2.Checked=True then
          if MessageDlg('Confermi di effettuare la classifica sul Gruppo A ?',
            mtconfirmation, [mbYes,mbNo], 0) = mrNo then
        begin
          ShowMessage('Cambia il Gruppo');
          Exit;
        end else
        begin   //converte l'array delle gare in string per il Query
            if Form2.ABSTable8.RecordCount=0 then
               begin
                 ShowMessage('Attenzione il Gruppo scelto non contiene discipline !');
                 Exit;
               end;
               QryStr:='(';
             for i := 0 to MaxIdxGare-1 do
               QryStr:=QryStr+IntToStr(ArGare[i])+',';
               QryStr:=QryStr+IntToStr(ArGare[MaxIdxGare]);
               QryStr:=QryStr+')';

            with ABSQuery80 do     //Estrae dal Base le discipline gruppo A
              begin                //per tutte le gare indicate e estrae le
                Close;             // coppie di valori n.gara e n.disciplina
                SQL.Text:='Select * from GRPA where CODGA IN '+QryStr; //dall'ARRAY
                ExecSQL;
                Open;
              end;  //Fase di raccolta record da classificare in T15 Classifica
           if ABSQuery80.RecordCount=0 then
               begin
                 ShowMessage('Attenzione il Gruppo scelto non contiene discipline !');
                 Exit;
               end;

           if ABSTable15.RecordCount>0 then    //Azzero la tabella Classifica
            begin                             // preesistente per non causare
              ABSTable15.Close;               // problemi di indice unique
              ABSTable15.EmptyTable;
              ABSTable15.Open;
            end;
           ABSTable15.Last;
           ABSQuery80.First; //ABSQuery80 è una tabella con gare e discipline
           qtrl:=ABSQuery80.RecordCount;
           while not ABSQuery80.EOF do            // selezionate
             begin
              Cgara:=ABSQuery80.FieldByName('CODGA').AsInteger;
              Cdspl:=ABSQuery80.FieldByName('CODDSPL').AsInteger;
                with ABSQuery85 do     //Estrae dalle Gare le discipline da classif
                 begin   //Costruisce Classifica con tutti i record gare e discipline
                  Close; //selezionate e gli Atleti che le hanno in comune
                  SQL.Text:='INSERT INTO Classifica SELECT * From Gara where CODGA='
                  +QuotedStr(IntToStr(Cgara))+' AND CODDSPL='+QuotedStr(IntToStr(Cdspl))
                  + 'AND CAT ='+ quotedstr(comboBox1.text);
                  ExecSQL;
                 end;
               qtrl:=qtrl-1;
               ABSQuery80.Next;
             end;
          ComboBox1.ItemIndex:=-1;
          if qtrl>0 then ShowMessage('ABSQuery80 errore eof');

            with ABSQuery85 do
              begin
                Close;
                SQL.Text:='Select * from Classifica  Order By "COGNOME","CODDSPL"';
                ExecSQL;
                Open;
              end;
            ABSTable15.Close;   //30/04/15 18:06 devo cancellare per poter sostituire
            ABSTable15.EmptyTable; //con i dati sortati e senza problemi di indice
            ABSTable15.Open;
            ABSTable15.Last;
            ABSQuery85.First;
            qtrl:=ABSQuery85.RecordCount;
            while not ABSQuery85.EOF do  //copia il query ordinato nella Tabella 15
              begin
                ABSTable15.Insert;
                ABSTable15.FieldByName('NMR').AsInteger:=
                              ABSQuery85.FieldByName('NMR').AsInteger;
                ABSTable15.FieldByName('CODGA').AsInteger:=
                              ABSQuery85.FieldByName('CODGA').AsInteger;
                ABSTable15.FieldByName('CODDSPL').AsInteger:=
                              ABSQuery85.FieldByName('CODDSPL').AsInteger;
                ABSTable15.FieldByName('CODATL').AsInteger:=
                              ABSQuery85.FieldByName('CODATL').AsInteger;
                ABSTable15.FieldByName('COGNOME').AsString:=
                              ABSQuery85.FieldByName('COGNOME').AsString;
                ABSTable15.FieldByName('NMPET').AsInteger:=
                              ABSQuery85.FieldByName('NMPET').AsInteger;
                ABSTable15.FieldByName('NMPOS').AsInteger:=
                              ABSQuery85.FieldByName('NMPOS').AsInteger;
                ABSTable15.FieldByName('TAME1').AsDateTime:=
                              ABSQuery85.FieldByName('TAME1').AsDateTime;
                ABSTable15.FieldByName('TBME2').AsDateTime:=
                              ABSQuery85.FieldByName('TBME2').AsDateTime;
                ABSTable15.FieldByName('DQ').AsBoolean:=
                              ABSQuery85.FieldByName('DQ').AsBoolean;
                ABSTable15.FieldByName('PEN').AsDateTime:=
                              ABSQuery85.FieldByName('PEN').AsDateTime;
                ABSTable15.FieldByName('MANL').AsBoolean:=
                              ABSQuery85.FieldByName('MANL').AsBoolean;
                ABSTable15.FieldByName('CAT').AsInteger:=
                              ABSQuery85.FieldByName('CAT').AsInteger;
                qtrl:=qtrl-1;
                ABSTable15.Post;
                ABSQuery85.Next;
              end;
           if qtrl>0 then ShowMessage('ABSQuery85 errore eof');
           
          if MessageDlg('Desideri esaminare un rapporto dei Dati Base per la Classifica ?'
           ,mtconfirmation, [mbYes,mbNo], 0) = mrYes then
            begin
              frxReport8.ShowReport;
                 if MessageDlg('Confermi i dati a base della classifica? '+#13+
                  'In caso negativo ESCI e correggi le scelte fatte.',
                   mtconfirmation, [mbYes,mbNo], 0) = mrNO then
                   begin
                     ABSTable15.Close;
                     ABSTable15.EmptyTable;
                     Exit;
                   end;
            end;

           RadioButton2.Color:= clLime;
           Calcola(Self);
           Exit;
        end;


        //GRUPPO B
     if RadioButton3.Checked=True then
        if MessageDlg('Confermi di effettuare la classifica sul Gruppo B ?',
      mtconfirmation, [mbYes,mbNo], 0) = mrNo then
        begin
          ShowMessage('Cambia il Gruppo');
          Exit;
        end else
        begin   //converte l'array delle gare in string per il Query
            Form2.ABSTable9.Open;
            if Form2.ABSTable9.RecordCount=0 then
               begin
                 ShowMessage('Attenzione il Gruppo scelto non contiene discipline !');
                 Exit;
               end;
               QryStr:='(';
             for i := 0 to MaxIdxGare-1 do
               QryStr:=QryStr+IntToStr(ArGare[i])+',';
               QryStr:=QryStr+IntToStr(ArGare[MaxIdxGare]);
               QryStr:=QryStr+')';

            with ABSQuery80 do     //Estrae dal Base le discipline gruppo B
              begin                //per tutte le gare indicate e estrae le
                Close;             // coppie di valori n.gara e n.disciplina
                SQL.Text:='Select * from GRPB where CODGA IN '+QryStr; //dall'ARRAY
                ExecSQL;
                Open;
              end;  //Fase di raccolta record da classificare in T15 Classifica
           if ABSQuery80.RecordCount=0 then
               begin
                 ShowMessage('Attenzione il Gruppo scelto non contiene discipline !');
                 Exit;
               end;

           if ABSTable15.RecordCount>0 then    //Azzero la tabella Classifica
            begin                             // preesistente per non causare
              ABSTable15.Close;               // problemi di indice unique
              ABSTable15.EmptyTable;
              ABSTable15.Open;
            end;
           ABSTable15.Last;
           ABSQuery80.First; //ABSQuery80 è una tabella con gare e discipline
           qtrl:=ABSQuery80.RecordCount;
           while not ABSQuery80.EOF do            // selezionate
             begin
              Cgara:=ABSQuery80.FieldByName('CODGA').AsInteger;
              Cdspl:=ABSQuery80.FieldByName('CODDSPL').AsInteger;
                with ABSQuery85 do     //Estrae dalle Gare le discipline da classif
                 begin   //Costruisce Classifica con tutti i record gare e discipline
                  Close; //selezionate e gli Atleti che le hanno in comune
                  SQL.Text:='INSERT INTO Classifica SELECT * From Gara where CODGA='
                  +QuotedStr(IntToStr(Cgara))+' AND CODDSPL='+QuotedStr(IntToStr(Cdspl))
                  + 'AND CAT ='+ quotedstr(comboBox1.text);
                  ExecSQL;
                 end;
               qtrl:=qtrl-1;
               ABSQuery80.Next;
             end;
          ComboBox1.ItemIndex:=-1;
          if qtrl>0 then ShowMessage('ABSQuery80 errore eof');

            with ABSQuery85 do
              begin
                Close;
                SQL.Text:='Select * from Classifica  Order By "COGNOME","CODDSPL"';
                ExecSQL;
                Open;
              end;
            ABSTable15.Close;   //30/04/15 18:06 devo cancellare per poter sostituire
            ABSTable15.EmptyTable; //con i dati sortati e senza problemi di indice
            ABSTable15.Open;
            ABSTable15.Last;
            ABSQuery85.First;
            qtrl:=ABSQuery85.RecordCount;
            while not ABSQuery85.EOF do  //copia il query ordinato nella Tabella 15
              begin
                ABSTable15.Insert;
                ABSTable15.FieldByName('NMR').AsInteger:=
                              ABSQuery85.FieldByName('NMR').AsInteger;
                ABSTable15.FieldByName('CODGA').AsInteger:=
                              ABSQuery85.FieldByName('CODGA').AsInteger;
                ABSTable15.FieldByName('CODDSPL').AsInteger:=
                              ABSQuery85.FieldByName('CODDSPL').AsInteger;
                ABSTable15.FieldByName('CODATL').AsInteger:=
                              ABSQuery85.FieldByName('CODATL').AsInteger;
                ABSTable15.FieldByName('COGNOME').AsString:=
                              ABSQuery85.FieldByName('COGNOME').AsString;
                ABSTable15.FieldByName('NMPET').AsInteger:=
                              ABSQuery85.FieldByName('NMPET').AsInteger;
                ABSTable15.FieldByName('NMPOS').AsInteger:=
                              ABSQuery85.FieldByName('NMPOS').AsInteger;
                ABSTable15.FieldByName('TAME1').AsDateTime:=
                              ABSQuery85.FieldByName('TAME1').AsDateTime;
                ABSTable15.FieldByName('TBME2').AsDateTime:=
                              ABSQuery85.FieldByName('TBME2').AsDateTime;
                ABSTable15.FieldByName('DQ').AsBoolean:=
                              ABSQuery85.FieldByName('DQ').AsBoolean;
                ABSTable15.FieldByName('PEN').AsDateTime:=
                              ABSQuery85.FieldByName('PEN').AsDateTime;
                ABSTable15.FieldByName('MANL').AsBoolean:=
                              ABSQuery85.FieldByName('MANL').AsBoolean;
                ABSTable15.FieldByName('CAT').AsInteger:=
                              ABSQuery85.FieldByName('CAT').AsInteger;
                qtrl:=qtrl-1;
                ABSTable15.Post;
                ABSQuery85.Next;
              end;
           if qtrl>0 then ShowMessage('ABSQuery85 errore eof');
           
          if MessageDlg('Desideri esaminare un rapporto dei Dati Base per la Classifica ?'
           ,mtconfirmation, [mbYes,mbNo], 0) = mrYes then
            begin
              frxReport8.ShowReport;
                 if MessageDlg('Confermi i dati a base della classifica? '+#13+
                  'In caso negativo ESCI e correggi le scelte fatte.',
                   mtconfirmation, [mbYes,mbNo], 0) = mrNO then
                   begin
                     ABSTable15.Close;
                     ABSTable15.EmptyTable;
                     Exit;
                   end;
            end;

           RadioButton3.Color:= clLime;
           Calcola(Self);
           Exit;
      end;
end;

procedure TForm8.Button7Click(Sender: TObject); //Classifica per discipline
 var
 dsplsi,garesi,trovato:Boolean;
 qtrl,qtrl2,cgara,cdspl:Integer;
begin                //Individua prima le Gare
    ClassDp:=True;
    Form2.ABSTable3.Close;
    Form2.ABSTable3.EmptyTable;  //resetta la tabella gare selezionate
    Form2.ABSTable3.Open;        // e carica la Tabella con le Gare scelte per
    for i := 0 to High(ArGare) do //la ricerca per discipline
      if ArGare[i]=0 then
        begin
          mom := i-1; //mom = all'ultimo elemento dell'array memorizzato
          Break;
        end;
      if mom=-1 then
        begin
          ShowMessage('Non vi sono elementi memorizzati ! - ripeti');
          Shape1.Brush.Color := clRed;
          Exit;
        end;
    for i:= 0 to mom do     //crea la tabella 3
      begin
       idx:=ArGare[i];   //Trasferisce i dati dall'Array alla Tabella
       Form2.ABSTable3.Insert;
       Form2.ABSTable3.FieldByName('Codice').AsInteger:=idx;
       garesi:=Form2.ABSTable5.Locate('CODGA',idx,[]);
       Form2.ABSTable3.FieldByName('Descrizione').AsString:=
                   Form2.ABSTable5.FieldByName('LUOGO').AsString;
       Form2.ABSTable3.Post;
      end;


    Form2.ABSTable3D.Close;
    Form2.ABSTable3D.EmptyTable;  //resetta la tabella discipline selezionate
    Form2.ABSTable3D.Open;
    for i := 0 to High(ArDspl) do
      if ArDspl[i]=0 then
        begin
          momd := i-1; //momd = all'ultimo elemento dell'array memorizzato
          Break;
        end;
      if momd=-1 then
        begin
          ShowMessage('Non vi sono elementi memorizzati ! - ripeti');
          Exit;
        end;
    for i:= 0 to momd do     //crea la tabella 3D
      begin
       idx:=ArDspl[i];   //Trasferisce i dati dall'Array alla Tabella
       Form2.ABSTable3D.Insert;
       Form2.ABSTable3D.FieldByName('CODDSPL').AsInteger:=idx;
       dsplsi:=Form2.ABSTable4.Locate('CODDSPL',idx,[]);
       Form2.ABSTable3D.FieldByName('DESCR').AsString:=
                   Form2.ABSTable4.FieldByName('DESCR').AsString;
       Form2.ABSTable3D.FieldByName('TMAX').AsDateTime:=
                   Form2.ABSTable4.FieldByName('TMAX').AsDateTime;
       Form2.ABSTable3D.Post;
      end;
                //Datasource8 è ora associato alle discipline scelte
     DataSource8.DataSet:=Form2.ABSTable3D;        //display gare su dbgrid
     DBGrid8.DataSource:=DataSource8;
     DBGrid8.Width:=376;
     DBGrid8.Columns[0].Width:=44;
     DBGrid8.Columns[1].Width:=291;
     if MessageDlg('Confermi di effettuare la classifica su questi elementi ?',
      mtconfirmation, [mbYes,mbNo], 0) = mrNo then
      begin
        Form2.ABSTable3D.Close;
        Form2.ABSTable3D.EmptyTable;
        Shape1.Brush.Color := clRed;
        SetLength(ArDspl,0); //azzera l'array delle Discipline non confermando la scelta
        SetLength(ArDspl,20);
        Exit;
      end;
       if comboBox1.ItemIndex=-1 then
        begin
           ShowMessage('Devi scegliere una Categoria');
           Exit;
        end else
     begin
       if MessageDlg('Confermi di effettuare la classifica per la Categoria '+comboBox1.Text+'  ?',
         mtconfirmation, [mbYes,mbNo], 0) = mrNo then
          begin
           Shape3.Brush.Color := clRed;
           Exit ;
           end ;
        Shape3.Brush.Color := clLime;
     end;
              //inizia a raccogliere i record da classificare                                                              //lavori in corso

          if ABSTable15.RecordCount>0 then    //Azzero la tabella Classifica
            begin                             // preesistente per non causare
              ABSTable15.Close;               // problemi di indice unique
              ABSTable15.EmptyTable;
              ABSTable15.Open;
            end;
           ABSTable15.Last;
           Form2.ABSTable3.First;       //Form2.ABSTable3 è una tabella con gare
           qtrl:=Form2.ABSTable3.RecordCount;
  while not Form2.ABSTable3.EOF do    //per ogni gara selezionata
    begin
      Cgara:=Form2.ABSTable3.FieldByName('Codice').AsInteger;
        qtrl2:=Form2.ABSTable3D.RecordCount;
        Form2.ABSTable3D.First;
        while not Form2.ABSTable3D.EOF do  //per ogni disciplina selezionata
          begin
            Cdspl:=Form2.ABSTable3D.FieldByName('CODDSPL').AsInteger;
                with ABSQuery85 do     //Estrae dalle Gare le discipline da classif
                 begin   //Costruisce Classifica con tutti i record gare e discipline
                  Close; //selezionate e gli Atleti che le hanno in comune
                  SQL.Text:='INSERT INTO Classifica SELECT * From Gara where CODGA='
                  +QuotedStr(IntToStr(Cgara))+' AND CODDSPL='+QuotedStr(IntToStr(Cdspl))
                  + 'AND CAT ='+ quotedstr(comboBox1.text);
                  ExecSQL;
                 end;

           qtrl2:=qtrl2-1;
           Form2.ABSTable3D.Next
          end;
      if qtrl2>0 then ShowMessage('ABSTable3D errore eof');
      qtrl:=qtrl-1;
      Form2.ABSTable3.Next;
    end;
      ComboBox1.ItemIndex:=-1;
      if qtrl>0 then ShowMessage('ABSTable3 errore eof');

     with ABSQuery85 do
              begin
                Close;
                SQL.Text:='Select * from Classifica  Order By "COGNOME","CODDSPL"';
                ExecSQL;
                Open;
              end;
            ABSTable15.Close;   //30/04/15 18:06 devo cancellare per poter sostituire
            ABSTable15.EmptyTable; //con i dati sortati e senza problemi di indice
            ABSTable15.Open;
            ABSTable15.Last;
            ABSQuery85.First;
            qtrl:=ABSQuery85.RecordCount;
            while not ABSQuery85.EOF do  //copia il query ordinato nella Tabella 15
              begin
                ABSTable15.Insert;
                ABSTable15.FieldByName('NMR').AsInteger:=
                              ABSQuery85.FieldByName('NMR').AsInteger;
                ABSTable15.FieldByName('CODGA').AsInteger:=
                              ABSQuery85.FieldByName('CODGA').AsInteger;
                ABSTable15.FieldByName('CODDSPL').AsInteger:=
                              ABSQuery85.FieldByName('CODDSPL').AsInteger;
                ABSTable15.FieldByName('CODATL').AsInteger:=
                              ABSQuery85.FieldByName('CODATL').AsInteger;
                ABSTable15.FieldByName('COGNOME').AsString:=
                              ABSQuery85.FieldByName('COGNOME').AsString;
                ABSTable15.FieldByName('NMPET').AsInteger:=
                              ABSQuery85.FieldByName('NMPET').AsInteger;
                ABSTable15.FieldByName('NMPOS').AsInteger:=
                              ABSQuery85.FieldByName('NMPOS').AsInteger;
                ABSTable15.FieldByName('TAME1').AsDateTime:=
                              ABSQuery85.FieldByName('TAME1').AsDateTime;
                ABSTable15.FieldByName('TBME2').AsDateTime:=
                              ABSQuery85.FieldByName('TBME2').AsDateTime;
                ABSTable15.FieldByName('DQ').AsBoolean:=
                              ABSQuery85.FieldByName('DQ').AsBoolean;
                ABSTable15.FieldByName('PEN').AsDateTime:=
                              ABSQuery85.FieldByName('PEN').AsDateTime;
                ABSTable15.FieldByName('MANL').AsBoolean:=
                              ABSQuery85.FieldByName('MANL').AsBoolean;
                ABSTable15.FieldByName('CAT').AsInteger:=
                              ABSQuery85.FieldByName('CAT').AsInteger;
                qtrl:=qtrl-1;
                ABSTable15.Post;
                ABSQuery85.Next;
              end;
           if qtrl>0 then ShowMessage('ABSQuery85 errore eof');

          if MessageDlg('Desideri esaminare un rapporto dei Dati Base per la Classifica ?'
           ,mtconfirmation, [mbYes,mbNo], 0) = mrYes then
            begin
              frxReport8.ShowReport;
                 if MessageDlg('Confermi i dati a base della classifica? '+#13+
                  'In caso negativo ESCI e correggi le scelte fatte.',
                   mtconfirmation, [mbYes,mbNo], 0) = mrNO then
                   begin
                     ABSTable15.Close;
                     ABSTable15.EmptyTable;
                     Exit;
                   end;
            end;

        Calcola(Self);
           Exit;
end;

procedure TForm8.Calcola(Sender: TObject);   // C A L C O L A
var
t1,t2,p1,tmx,tmcn:TDateTime;
h1,m1,s1,z1,h2,m2,s2,z2,h3,m3,s3,z3:Word;
sql,esclusioni,trovato,ATLsi:Boolean;
esclusi:TStringList;
ca,dp,ga,qtrl,ct,i,imax,temp2,tt,tt2:Integer;
dacancA:array of smallInt;
dacancD:array of smallInt;
dacancG:array of smallInt;
cgn:string;
RnkMax,rn,CODATL16:Integer;             //Fase segnalazione atleti in difetto
begin
 trovato:=False;
 SetLength(dacancA,0);
 SetLength(dacancA,300);
 SetLength(dacancD,0);
 SetLength(dacancD,300);
 SetLength(dacancG,0);
 SetLength(dacancG,300);
 esclusi:=TStringList.Create;//NOTA BENE L'ESCLUSIONE VALE SOLO NEL RUN IN CORSO
 ABSTable16.Close;
 ABSTable16.EmptyTable;
 ABSTable15.Open;
 ABSTable15.Edit;
 ABSTable15.Last;   //per ottenere un conteggio corretto ???!!!
 ABSTable15.First;
 qtrl:=ABSTable15.RecordCount;
 i:=1;
 esclusioni:=False;

     //analizza i dati di classifica raccolti in T15 ed evidenzia i problemi
   while not ABSTable15.Eof do  //memorizzazione e correzione
     begin
       t1:=TimeOf(ABSTable15.FieldByName('TAME1').AsDateTime);
       t2:=TimeOf(ABSTable15.FieldByName('TBME2').AsDateTime);
       sql:=ABSTable15.FieldByName('DQ').AsBoolean;
       ct:=ABSTable15.FieldByName('CAT').AsInteger;
       ca:= ABSTable15.FieldByName('CODATL').AsInteger; //memorizza i record
       cgn:=ABSTable15.FieldByName('COGNOME').AsString;
       dp:= ABSTable15.FieldByName('CODDSPL').AsInteger;
       ga:=ABSTable15.FieldByName('CODGA').AsInteger;
       if ct=0 then
         begin
           ShowMessage('Attenzione l''Atleta '+cgn+' codice '+IntToStr(ca)+' gara '
           +IntToStr(ga)+' disciplina '+IntToStr(dp)+#13+#13+
           ' non ha la categoria. Correggi');
           Exit;
         end;
       if ((t1=0) and (t2=0))or(sql=True) then   //Individue le ragioni
         begin
           esclusi.Add('Gara '+Inttostr(ga)+' codice: '+intToStr(ca)+'  '+cgn+
           ' Disc. '+intTostr(dp));
           dacancA[i]:=ca;   //memorizza i dati da-completare;
           dacancD[i]:=dp;
           dacancG[i]:=ga;
           i:=i+1;
           esclusioni:=True;
         end;
       qtrl:=qtrl-1;
       imax:=i;

       ABSTable15.Next;
     end;
  if qtrl>0 then ShowMessage('ABSTable15 errore eof');

   if (esclusi.Count<50) and (esclusi.Count>0) then
        ShowMessage(' Atleti con dati mancanti' +#13+#13+ esclusi.Text+#13+#13+
         ' Dati salvati su Mancanti.txt') else
      begin
         if esclusi.count>0 then
         ShowMessage('Lista Atleti con dati mancanti, salvata in "Mancanti.txt".');
      end;
    esclusi.SaveToFile('.\Mancanti.txt');
    esclusi.Clear;
                  //Calcolo dei tempi  usa SelezioneGare T3 e classifiche T15
    Form2.ABSTable3.Open;
    Form2.ABSTable3.First;
    while not Form2.ABSTable3.eof do   //Quì inizia il giro delle gare scelte
     begin
      ga:=Form2.ABSTable3.FieldByName('Codice').AsInteger;
       ABSTable18.Close;       //azzera la T18 per ricevere i dati della nuova gara
       ABSTable18.EmptyTable;
       // DataSourceQry.DataSet:=ABSQuery85;
         with ABSQuery85 do //seleziona tutte le discipline della gara scelta
           begin
            Close;    //quì nasce la ABSTable18 con tutte le discipline di una gara
            SQL.Text:='INSERT INTO Temp8 Select * from Classifica where CODGA = '
            + QuotedStr(IntToStr(ga))+' Order By "CODDSPL"';
            ExecSQL;
            //Open;
           end;   //creata la Temp8 = le discipline della gara
                          //Crea le discipline da classificare per la gara scelta

     if ClassDp=False then
       Begin
          with ABSQuery80 do
           begin
            Close;
            if RadioButton1.Checked=True then
               SQL.Text:= 'Select CODDSPL from Base where CODGA = '
                + QuotedStr(IntToStr(ga))+' Order By "CODDSPL"';
            if RadioButton2.Checked=True then
               SQL.Text:= 'Select CODDSPL from GRPA where CODGA = '
                + QuotedStr(IntToStr(ga))+' Order By "CODDSPL"';
            if RadioButton3.Checked=True then
               SQL.Text:= 'Select CODDSPL from GRPB where CODGA = '
               + QuotedStr(IntToStr(ga))+' Order By "CODDSPL"';
            ExecSQL;
             Open;
           end;
       end else
       begin
          with ABSQuery80 do  //per il caso della classifica per discipline
           begin
             Close;
             SQL.Text:= 'Select distinct CODDSPL from Classifica where CODGA = '
             + QuotedStr(IntToStr(ga))+' Order By "CODDSPL"';
             ExecSQL;
             Open;
           end;
        end;

        ABSTable18.Open;
        TDateTimeField(Form8.ABSTable18.FieldByName('TAME1')).DisplayFormat:='nn:ss,zzz';
        TDateTimeField(Form8.ABSTable18.FieldByName('TBME2')).DisplayFormat:='nn:ss,zzz';
        TDateTimeField(Form8.ABSTable18.FieldByName('PEN')).DisplayFormat:='nn:ss,zzz';

         //  T18 tutte le dspl di una gara

        ABSQuery80.First;  //  Tutte le dspl del gruppo scelto
       while not ABSQuery80.eof do
       begin
           dp:=ABSQuery80.FieldByName('CODDSPL').AsInteger;
            with ABSQuery83 do                           //Tutte le discipline
            begin
              Close;  //la ABSTable18 fornisce i dati per la disciplina
              SQL.Text:='Select * from Temp8 where CODDSPL = '+ QuotedStr(IntToStr(dp))+
               ' Order By "CODATL"';
              ExecSQL;
              Open;
            end;  //Creata Query83 = i record di una disciplina per volta
             //quì ci sono tutti i record relativi ad una gara su una disciplina
             //con i tempi di ciascun Atleta e si può valutare il vincitore
            //ATTENZIONE PUO' CAPITARE CHE NESSUN ATLETA è ISCRITTO
            if ABSQuery83.RecordCount=0 then
              begin
                ShowMessage('Attenzione nessun atleta iscritto alla disciplina '+IntToStr(dp)+#13+
                'nella Gara : '+inttostr(ga));
                ABSQuery80.Next;
                Continue;
              end;

            ABSTable16.Close;
            ABSTable16.EmptyTable;
            ABSTable16.Open;        //definisce i formati dei tempi
              TDateTimeField(Form8.ABSTable16.FieldByName('TAME1')).
                                              DisplayFormat:='nn:ss,zzz';
              TDateTimeField(Form8.ABSTable16.FieldByName('TBME2')).
                                              DisplayFormat:='nn:ss,zzz';
              TDateTimeField(Form8.ABSTable16.FieldByName('PEN')).
                                              DisplayFormat:='nn:ss,zzz';
              TDateTimeField(Form8.ABSTable16.FieldByName('TMC')).
                                              DisplayFormat:='nn:ss,zzz';
            ABSQuery83.Last;  //CREA LA T16 DOVE SI ASSEGNANO I TEMPI e i DQ
            ABSQuery83.First;
            qtrl:=ABSQuery83.RecordCount;
            while not ABSQuery83.EOF do  //query ordinato nella Tabella 16 Una Gara
              begin
                ABSTable16.Insert;
                ABSTable16.FieldByName('NMR').AsInteger:=
                  ABSQuery83.FieldByName('NMR').AsInteger;       //  Una disciplna
                ABSTable16.FieldByName('CODGA').AsInteger:=
                  ABSQuery83.FieldByName('CODGA').AsInteger;
                ABSTable16.FieldByName('CODDSPL').AsInteger:=
                  ABSQuery83.FieldByName('CODDSPL').AsInteger;
                ABSTable16.FieldByName('CODATL').AsInteger:=
                  ABSQuery83.FieldByName('CODATL').AsInteger;
                ABSTable16.FieldByName('COGNOME').AsString:=
                  ABSQuery83.FieldByName('COGNOME').AsString;
                ABSTable16.FieldByName('NMPET').AsInteger:=
                  ABSQuery83.FieldByName('NMPET').AsInteger;
                ABSTable16.FieldByName('NMPOS').AsInteger:=
                  ABSQuery83.FieldByName('NMPOS').AsInteger;
                ABSTable16.FieldByName('TAME1').AsDateTime:=
                  ABSQuery83.FieldByName('TAME1').AsDateTime;
                ABSTable16.FieldByName('TBME2').AsDateTime:=
                  ABSQuery83.FieldByName('TBME2').AsDateTime;
                ABSTable16.FieldByName('DQ').AsBoolean:=
                  ABSQuery83.FieldByName('DQ').AsBoolean;
                ABSTable16.FieldByName('PEN').AsDateTime:=
                  ABSQuery83.FieldByName('PEN').AsDateTime;
                ABSTable16.FieldByName('MANL').AsBoolean:=
                  ABSQuery83.FieldByName('MANL').AsBoolean;
                ABSTable16.FieldByName('CAT').AsInteger:=
                  ABSQuery83.FieldByName('CAT').AsInteger;
                qtrl:=qtrl-1;
                ABSTable16.Post;
                ABSQuery83.Next;
              end;
           if qtrl>0 then ShowMessage('ABSQuery83_2 errore eof');


             RnkMax:=ABSTable16.RecordCount;
             rn:=RnkMax;

              ABSTable16.First;
                               //ricava TMAX  e il cod. disciplina
                dp:= ABSTable16.FieldByName('CODDSPL').AsInteger;
                 trovato:=Form2.ABSTable4.Locate('CODDSPL',dp,[]);
           TDateTimeField(Form2.ABSTable4.FieldByName('TMAX')).
                                              DisplayFormat:='nn:ss,zzz';
          if trovato =True then tmx:=Form2.ABSTable4.FieldByName('TMAX').AsDateTime
                else
                  begin
                   ShowMessage('ERRORE, Disciplina o TMAX non trovato - ca:'+inttostr(ca)+' dp : '+inttostr(dp));
                   Exit;
                  end;
              while not ABSTable16.eof do //scorre tutti i record e inserisce il tempo medio
               begin
                ABSTable16.Edit;
                t1:=ABSTable16.FieldByName('TAME1').AsDateTime;
                t2:=ABSTable16.FieldByName('TBME2').AsDateTime;
                p1:=ABSTable16.FieldByName('PEN').AsDateTime;
                sql:=ABSTable16.FieldByName('DQ').AsBoolean;
                ca:= ABSTable16.FieldByName('CODATL').AsInteger;
                // controlla proprietà dei tempi
                DecodeTime(t1,h1,m1,s1,z1);
                DecodeTime(t2,h2,m2,s2,z2);
                if (h1<>0) or (h2<>0) then
                  begin
                    ShowMessage('Impossibile classificare: presenti valori'+
                    ' incompatibili per l''Atleta : '+ inttostr(ca));
                    Exit;
                  end;
                                   //tempo medio
                if ((t1=0)and(t2<>0)) then
                  begin
                   ABSTable16.FieldByName('TMC').AsDateTime:= (t2+p1);
                   TDateTimeField(Form8.ABSTable16.FieldByName('TMC')).DisplayFormat:='nn:ss,zzz';
                  end;

                if ((t1<>0)and(t2=0)) then
                  begin
                     ABSTable16.FieldByName('TMC').AsDateTime:= (t1+p1);
                     TDateTimeField(Form8.ABSTable16.FieldByName('TMC')).DisplayFormat:='nn:ss,zzz';
                  end;

                     // inserisce il valore medio calcolato
                if ((t1<>0)and(t2<>0))then
                  begin
                    tmcn:= (((t1+t2)/2)+p1);
                    ABSTable16.FieldByName('TMC').AsDateTime:= tmcn;
                    TDateTimeField(Form8.ABSTable16.FieldByName('TMC')).DisplayFormat:='nn:ss,zzz';
                  end;
                ABSTable16.Post;
                ABSTable16.Next;  //nuovo atleta
               end;

                                                //Assegnazione Del Ranking
               with ABSQuery85 do
            begin                //Ordina per tempi crescenti
              Close;
              SQL.Text:='Select * from Ranking Order By "TMC"';
              ExecSQL;
              Open
            end;

            ABSTable16.Close;
            ABSTable16.EmptyTable;
            ABSTable16.Open;
            ABSTable16.Edit;
            ABSQuery85.Last;
            ABSQuery85.First;
            qtrl:=ABSQuery85.RecordCount;
            while not ABSQuery85.EOF do
              begin                              //Ordinata per tempi crescenti
                ABSTable16.Insert;
                ABSTable16.FieldByName('NMR').AsInteger:=
                  ABSQuery85.FieldByName('NMR').AsInteger;
                ABSTable16.FieldByName('CODGA').AsInteger:=
                  ABSQuery85.FieldByName('CODGA').AsInteger;
                ABSTable16.FieldByName('CODDSPL').AsInteger:=
                  ABSQuery85.FieldByName('CODDSPL').AsInteger;
                ABSTable16.FieldByName('CODATL').AsInteger:=
                  ABSQuery85.FieldByName('CODATL').AsInteger;
                ABSTable16.FieldByName('COGNOME').AsString:=
                  ABSQuery85.FieldByName('COGNOME').AsString;
                ABSTable16.FieldByName('NMPET').AsInteger:=
                  ABSQuery85.FieldByName('NMPET').AsInteger;
                ABSTable16.FieldByName('NMPOS').AsInteger:=
                  ABSQuery85.FieldByName('NMPOS').AsInteger;
                ABSTable16.FieldByName('TAME1').AsDateTime:=
                  ABSQuery85.FieldByName('TAME1').AsDateTime;
                ABSTable16.FieldByName('TBME2').AsDateTime:=
                  ABSQuery85.FieldByName('TBME2').AsDateTime;
                ABSTable16.FieldByName('DQ').AsBoolean:=
                  ABSQuery85.FieldByName('DQ').AsBoolean;
                ABSTable16.FieldByName('PEN').AsDateTime:=
                  ABSQuery85.FieldByName('PEN').AsDateTime;
                ABSTable16.FieldByName('MANL').AsBoolean:=
                  ABSQuery85.FieldByName('MANL').AsBoolean;
                ABSTable16.FieldByName('CAT').AsInteger:=
                  ABSQuery85.FieldByName('CAT').AsInteger;
                ABSTable16.FieldByName('TMC').AsDateTime:=
                  ABSQuery85.FieldByName('TMC').AsDateTime;
                qtrl:=qtrl-1;
                ABSTable16.Post;
                ABSQuery85.Next;
              end;
               ABSTable16.First;       //Essendo ordinata per Tempi decrescenti
            while not ABSTable16.eof do //scorre tutti i record per DQ da TMAX
               begin
                 ABSTable16.Edit;
                 tmcn:=ABSTable16.FieldByName('TMC').AsDateTime;
                 ca:=ABSTable16.FieldByName('CODATL').AsInteger ;
                 t1:=ABSTable16.FieldByName('TAME1').AsDateTime;
                 t2:=ABSTable16.FieldByName('TBME2').AsDateTime;
                  if ((t1=0)and(t2=0))or(tmcn>tmx) then   //Assegna direttamente DQ
                 begin                                    // e ranking alla T16
                   ABSTable16.FieldByName('DQ').AsBoolean:=True;
                   ABSTable16.FieldByName('RNK').AsInteger:=0;
                   ABSTable16.FieldByName('TMC').AsDateTime:=tmx;
                 end else
                   begin
                     ABSTable16.FieldByName('RNK').AsInteger :=rn;
                    rn:=rn-1;
                   end;
                ABSTable16.Post;
                ABSTable16.Next;
               end;
           if qtrl>0 then ShowMessage('ABSQuery85/16 errore eof');

                             //Ordinata per Ranking decrescenti
               with ABSQuery85 do
            begin
              Close;
              SQL.Text:='Select * from Ranking Order By "RNK" desc';
              ExecSQL;          //Ordina la Tabella 16 Ranking
              Open
            end;

              ABSTable16.Close;
            ABSTable16.EmptyTable;
            ABSTable16.Open;
            ABSTable16.Edit;
            ABSQuery85.Last;
            ABSQuery85.First;
            qtrl:=ABSQuery85.RecordCount;
            while not ABSQuery85.EOF do
              begin
                ABSTable16.Insert;
                ABSTable16.FieldByName('NMR').AsInteger:=
                  ABSQuery85.FieldByName('NMR').AsInteger;
                ABSTable16.FieldByName('CODGA').AsInteger:=
                  ABSQuery85.FieldByName('CODGA').AsInteger;
                ABSTable16.FieldByName('CODDSPL').AsInteger:=
                  ABSQuery85.FieldByName('CODDSPL').AsInteger;
                ABSTable16.FieldByName('CODATL').AsInteger:=
                  ABSQuery85.FieldByName('CODATL').AsInteger;
                ABSTable16.FieldByName('COGNOME').AsString:=
                  ABSQuery85.FieldByName('COGNOME').AsString;
                ABSTable16.FieldByName('NMPET').AsInteger:=
                  ABSQuery85.FieldByName('NMPET').AsInteger;
                ABSTable16.FieldByName('NMPOS').AsInteger:=
                  ABSQuery85.FieldByName('NMPOS').AsInteger;
                ABSTable16.FieldByName('TAME1').AsDateTime:=
                  ABSQuery85.FieldByName('TAME1').AsDateTime;
                ABSTable16.FieldByName('TBME2').AsDateTime:=
                  ABSQuery85.FieldByName('TBME2').AsDateTime;
                ABSTable16.FieldByName('DQ').AsBoolean:=
                  ABSQuery85.FieldByName('DQ').AsBoolean;
                ABSTable16.FieldByName('PEN').AsDateTime:=
                  ABSQuery85.FieldByName('PEN').AsDateTime;
                ABSTable16.FieldByName('MANL').AsBoolean:=
                  ABSQuery85.FieldByName('MANL').AsBoolean;
                ABSTable16.FieldByName('CAT').AsInteger:=
                  ABSQuery85.FieldByName('CAT').AsInteger;
                ABSTable16.FieldByName('TMC').AsDateTime:=
                  ABSQuery85.FieldByName('TMC').AsDateTime;
                ABSTable16.FieldByName('RNK').AsInteger:=
                  ABSQuery85.FieldByName('RNK').AsInteger;
                ABSTable16.FieldByName('TMC').AsDateTime:=
                  ABSQuery85.FieldByName('TMC').AsDateTime;

                qtrl:=qtrl-1;
                ABSTable16.Post;
                ABSQuery85.Next;
              end;

                 //  Aggiungo il nome e nazione
        ABSTable16.First;
         while not ABSTable16.EOF do
         begin
          CODATL16:=ABSTable16.FieldByName('CODATL').AsInteger;
          Form2.ABSTable2.Open;
          ATLsi:=Form2.ABSTable2.Locate('CODATL',CODATL16,[] );
          if ATLsi=False then       //si blocca sul record con pari codice DSPL
            begin
             ShowMessage('Errore Atleta non trovato nell''Anagrafica');
             Exit;
            end;
          ABSTable16.Edit;
          ABSTable16.FieldByName('NOME').AsString:=Form2.ABSTable2.FieldByName('NOME').AsString;
          ABSTable16.FieldByName('NAZIONE').AsString:=Form2.ABSTable2.FieldByName('NAZIONE').AsString;
          ABSTable16.Post;
          ABSTable16.NEXT
         end;
         // Added by Manlio Laschena 17/05/2015 13:05:35 ci sono i DATI dei punti
                         //TRASCRIZIONE su T16T  STORICO

        // Form2.ABSTable16T.TableName:='T16T';
         Form2.ABSTable16T.Open;
           ABSTable16.First;
         while not ABSTable16.EOF do
          begin
                //Raccolta dati di codice
           ca:=ABSTable16.FieldByName('CODATL').AsInteger;
           ga:=ABSTable16.FieldByName('CODGA').AsInteger;
           dp:=ABSTable16.FieldByName('CODDSPL').AsInteger;
           trovato:=Form2.ABSTable16T.Locate('CODATL;CODGA;CODDSPL',VarArrayOf([intTostr(ca),IntToStr(ga),IntToStr(dp)]),[]);
            if trovato=False then  Form2.ABSTable16T.Insert;
            Form2.ABSTable16T.Edit;
             Form2.ABSTable16T.FieldByName('CODATL').AsInteger:=ca;
             Form2.ABSTable16T.FieldByName('CODGA').AsInteger:=ga;
             Form2.ABSTable16T.FieldByName('CODDSPL').AsInteger:=dp;
             Form2.ABSTable16T.FieldByName('COGNOME').AsString:=ABSTable16.FieldByName('COGNOME').AsString;
             Form2.ABSTable16T.FieldByName('NOME').AsString:=ABSTable16.FieldByName('NOME').AsString;
             Form2.ABSTable16T.FieldByName('NAZIONE').AsString:=ABSTable16.FieldByName('NAZIONE').AsString;
             Form2.ABSTable16T.FieldByName('TMC').AsDateTime:=ABSTable16.FieldByName('TMC').AsDateTime;
             TDateTimeField(Form2.ABSTable16T.FieldByName('TMC')).DisplayFormat:='nn:ss,zzz';
             Form2.ABSTable16T.FieldByName('RNK').AsInteger:=ABSTable16.FieldByName('RNK').AsInteger;
             Form2.ABSTable16T.FieldByName('DQ').AsBoolean:=ABSTable16.FieldByName('DQ').AsBoolean;
             Form2.ABSTable16T.FieldByName('CAT').AsInteger:=ABSTable16.FieldByName('CAT').AsInteger;
            //Aggiunge dati mancanti
            trovato:=Form2.ABSTable4.Locate('CODDSPL',dp,[]); //Descrizione
            if trovato=True then
             Form2.ABSTable16T.FieldByName('DESCR').AsString:= Form2.ABSTable4.FieldByName('DESCR').AsString else
             begin
             ShowMessage('Errore Disciplina non trovata nell''Anagrafica @T16T');
             Exit;
             end;
            trovato:=Form2.ABSTable5.Locate('CODGA',ga,[]); //Data Gara
            if trovato=True then
             Form2.ABSTable16T.FieldByName('DATAGA').AsDateTime:= Form2.ABSTable5.FieldByName('DATA').AsDateTime else
             begin
             ShowMessage('Errore Gara non trovata nell''Anagrafica @T16T');
             Exit;
             end;

           Form2.ABSTable16T.Post;
           ABSTable16.Next;
          end;
          //determina il punteggio totale per atleta

         if MessageDlg('Desideri esaminare la Classifica della Disciplina   '+
          QuotedStr(IntToStr(dp))+#13+'Gara : '+QuotedStr(IntToStr(ga))+'  ?',mtconfirmation, [mbYes,mbNo], 0) = mrYes then
             begin
               frxReport16.Variables['max']:= quotedstr(TimeToStr(tmx));
               frxReport16.ShowReport;   //Classifiche per singole discipline
             end;      //Dati da ABSTable16 (Ranking)
          ABSTable16R.Close;        //Resetta la R16R prima di caricarla da Ranking
          ABSTable16R.EmptyTable;
           with ABSQueryR do
          begin
           Close;
           SQL.Text:= 'INSERT INTO R16R SELECT * FROM Ranking';
           ExecSQL;
          end;
        ABSQuery80.Next;  //Altra disciplina
       end;
           //quì finisce le discipline della Gara
         if MessageDlg('Desideri esaminare i risultati complessivi per le discipline selezionate  '+
           'della Gara : '+QuotedStr(IntToStr(ga))+' ?',mtconfirmation, [mbYes,mbNo], 0) = mrYes then
         frxReportR.ShowReport;



      Form2.ABSTable3.Next;//adesso inserisce una nuova gara
     end;


     if (ClassDp=False) then
    begin
      if MessageDlg('Desideri esaminare la Classifica Riepilogativa '+
        'della Gara : '+QuotedStr(IntToStr(ga))+#13+' per tutte le discipline praticate ?',mtconfirmation, [mbYes,mbNo], 0) = mrYes then
       begin
          with ABSQueryRep do
          begin
           Close;
           SQL.Text:='Select * from T16T Where CODGA = '+ QuotedStr(IntToStr(ga))+' Order by CODDSPL, RNK desc';
           ExecSQL;
           Open;
          end;

               frxReport16T.ShowReport;   //Classifica riepilogativa gara
          with ABSQuery85 do      //Dati da QueryRep
          begin
           Close;  //tabelle con nome numerico devono iniziare con una lettera
           SQL.Text:='Select CODATL,COGNOME,DATAGA, sum(RNK) AS TOTRNK from T16T Where CODGA = '+
           QuotedStr(IntToStr(ga))+' Group By CODATL,COGNOME,DATAGA Order by TOTRNK desc';
           ExecSQL;
           Open
          end;
               frxReport16T2.ShowReport;  // Classifica riepilogativa punteggio
       end;         //Dati da Query85 >> 16T (T16T)
    end;


    if ClassDp=False then
     begin

        if MessageDlg('Desideri esaminare Il Punteggio complessivo raggiunto '+#13
           +' per le Gare selezionate ?'+#13+
           'NB. Non cambia per una sola Gara',mtconfirmation, [mbYes,mbNo], 0) = mrYes then
        begin
         ABSTable19.Open;
         ABSTable19.Edit;
         ABSTable19.First;
          Form2.ABSTable3.First;
          while not Form2.ABSTable3.Eof do
           begin           //Colleziona i dati di tutte le gare scelte
            ga:=Form2.ABSTable3.FieldByName('codice').AsInteger;
               with ABSQueryRep do
             begin
               Close;
               SQL.Text:='Select CODATL,COGNOME, NOME,NAZIONE, SUM(RNK) AS TOTRNK from T16T Where CODGA = '
               + QuotedStr(IntToStr(ga))+'AND  CAT ='+QuotedStr(IntToStr(ct))+' Group By CODATL,COGNOME,NOME,NAZIONE ';
               ExecSQL;
               Open;
             end;
              ABSQueryRep.First;
             while not ABSQueryRep.eof do
              begin
                temp2:=ABSQueryRep.FieldByName('CODATL').AsInteger;
                trovato:=ABSTable19.Locate('CODATL',temp2,[]);
                  if trovato=False then
                    ABSTable19.Insert;
                ABSTable19.Edit;
                ABSTable19.FieldByName('CODATL').AsInteger:=ABSQueryRep.FieldByName('CODATL').AsInteger;
                ABSTable19.FieldByName('COGNOME').AsString:=ABSQueryRep.FieldByName('COGNOME').AsString;
                ABSTable19.FieldByName('NOME').AsString:=ABSQueryRep.FieldByName('NOME').AsString;
                ABSTable19.FieldByName('NAZIONE').AsString:=ABSQueryRep.FieldByName('NAZIONE').AsString;
                tt:= ABSQueryRep.FieldByName('TOTRNK').AsInteger;
                tt2:=ABSTable19.FieldByName('RNK').AsInteger;
                ABSTable19.FieldByName('RNK').AsInteger:=tt+tt2;
                ABSTable19.Post;
                ABSQueryRep.Next;
              end;
            Form2.ABSTable3.Next;
           end;
               with ABSQueryRep do
             begin
               Close;
               SQL.Text:= 'Select * from totale Order by RNK desc';
               ExecSQL;
               Open;
             end;

             frxReportTot.ShowReport;
                       //dati da QueryRep >> Totale T19
        end;
    end;

       ClassDp:=False;
       RadioButton1.Color:= clRed;
       RadioButton2.Color:= clRed;
       RadioButton3.Color:= clRed;
       Shape1.Brush.Color := clRed; //Azzera e resetta la scelta Gare nell'Array
       SetLength(ArGare,0);
       SetLength(ArGare,20);
       Shape2.Brush.Color := clRed; //Azzera e resetta la scelta Discipline nell'Array
       SetLength(ArDspl,0);
       SetLength(ArDspl,20);
       Shape3.Brush.Color:= clRed;
       ComboBox1.ItemIndex:=-1;
       ABSTable19.Close;
       ABSTable19.EmptyTable;
       ABSTable18.Close;
       ABSTable18.EmptyTable;

end;

procedure TForm8.EsciClick(Sender: TObject);    //Esci
begin
      Form2.ABSTable1.Open;
       Form2.ABSTable1.Last;
       if Form2.ABSTable1.FieldByName('Password').AsString<>'' then
       Form2.ABSTable1.Insert;
       Form2.ABSTable1.Edit;
       Form2.ABSTable1.FieldByName('OUT').AsDateTime:=NOW;
       Form2.ABSTable1.Post;
       Form2.ABSTable1.Close;
      Form8.Close;   // NB chiama il can close
      ClassFlg:=True;  //per consentire di monitorizzare che Form8 è closed
      Form2.Visible:=True;
      SetLength(ArGare,0);
      SetLength(ArDspl,0);
      SetLength(ArCat,0);
      Form2.ABSTable3.Close;
      Form2.ABSTable3.EmptyTable; //resetta la tabella SelezioneGare
      Form2.ABSTable3D.Close;
      Form2.ABSTable3D.EmptyTable; //resetta la tabella SelezioneDSPL
      ABSQuery85.Close;
      ABSTable15.Close; //per consentire lo svuotamento messo su ObjInsp Exclusive=True
      ABSTable15.EmptyTable;  //resetta la tabella  Classifica
      ABSTable16R.Close;
      Form2.ABSTable4.Close;
      Form2.ABSTable2.Close;
      Form2.ABSTable5.Close;
      Form2.ABSTable6.Close;
      Form2.ABSTable8.Close;
      Form2.ABSTable9.Close;
end;
end.

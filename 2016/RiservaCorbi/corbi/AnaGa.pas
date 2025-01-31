unit AnaGa;             //Anagrafica Gare   11/04/2015

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,System.UITypes,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, ABSMain, frxClass, frxDBSet,
  frxExportPDF;

type
  TForm5 = class(TForm)
    dbgrd51: TDBGrid;
    ds51: TDataSource;
    dbgrd52: TDBGrid;
    ds52: TDataSource;
    Button1: TButton;
    dbnvgr51: TDBNavigator;
    dbgrd55: TDBGrid;
    ds55: TDataSource;
    dbnvgr55: TDBNavigator;
    cbb55: TComboBox;
    ABSQuery6: TABSQuery;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Label4: TLabel;
    Button3: TButton;
    Button4: TButton;
    shp1: TShape;
    Label5: TLabel;
    Label6: TLabel;
    Edit3: TEdit;
    Button5: TButton;
    Button6: TButton;
    frxReport51: TfrxReport;
    frxDBDataset51: TfrxDBDataset;
    Button7: TButton;
    frxPDFExport51: TfrxPDFExport;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    shp2: TShape;
    Label7: TLabel;
    frxReport5: TfrxReport;
    frxDBDatasetBA: TfrxDBDataset;
    frxDBDatasetGA: TfrxDBDataset;
    frxDBDatasetGB: TfrxDBDataset;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbb55Change(Sender: TObject);
    procedure dbgrd52MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbnvgr51Click(Sender: TObject; Button: TNavigateBtn);
    procedure dbgrd55MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Pulizia (Sender: TObject);
    procedure dbgrd51CellClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Edit3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;
  AnaGAFlg:Boolean=True;
  inserisco5:Boolean=False;
  CanClose:Boolean=True;
  filtro,sg,tabl,garastr,giornostr:string;
  tabella:TDataset;

implementation
uses
Console1;

{$R *.dfm}
 {$D+}
procedure TForm5.FormCreate(Sender: TObject);   //Crea il Form5
begin
  //Form2.ABSTable5.TableName:='AnaGa';
   Form2.ABSTable5.Open;
   Form2.ABSTable5.Edit;
  // Form2.ABSTable6.TableName:='Base';
   Form2.ABSTable6.Open;
   Form2.ABSTable6.Edit;
   AnaGaFlg:=False;
   ds51.DataSet:=Form2.ABSTable5;//aggiunto per evitare circular DataLink error
   ds52.DataSet:=Form2.ABSTable4;
  // Form2.ABSTable4.TableName:='AnaDspl';
   Form2.ABSTable4.Open;
   Form2.ABSTable4.Edit;
  //Form2.ABSTable8.TableName:='GRPA';
   Form2.ABSTable8.Open;
   Form2.ABSTable8.Edit;
  //Form2.ABSTable9.TableName:='GRPB';
   Form2.ABSTable9.Open;
   Form2.ABSTable9.Edit;
   shp1.Brush.Color:=clOlive;  //per colorare la shape
   shp2.Brush.Color:=clRed;  //per colorare la shape
  Form2.ABSTable1.Open;   //registra su Servizio
  Form2.ABSTable1.INSERT;
  Form2.ABSTable1.FieldByName('IN').AsDateTime:= NOW;
  Form2.ABSTable1.FieldByName('what').AsString:='Accesso all''Anagrafica Gare';
  Form2.ABSTable1.FieldByName('OUT').AsString:='';
  Form2.ABSTable1.Post;
  Form2.ABSTable1.Close;
  TDateTimeField(Form2.ABSTable4.FieldByName('TMAX')).
                                              DisplayFormat:='nn:ss,zzz';
end;



procedure TForm5.Button1Click(Sender: TObject); //Esci
begin
    if inserisco5=True then  //se ha inserito un record
     begin
       FormCloseQuery(Self,canclose);
     end
     else
     begin
      //Form5.Pulizia(Self);     //occorre verificare se i db sono gi� chiusi
      Form2.ABSTable1.Open;
      Form2.ABSTable1.Last;
       if Form2.ABSTable1.FieldByName('Password').AsString<>'' then
       Form2.ABSTable1.Insert;
      Form2.ABSTable1.Edit;
      Form2.ABSTable1.FieldByName('OUT').AsDateTime:=NOW;
      Form2.ABSTable1.Post;
      Form2.ABSTable1.Close;
      Form2.ABSTable4.Close;
      Form2.ABSTable5.Close;
      Form5.Close;   // NB chiama il can close
      AnaGAFlg:=True;  //per consentire di monitorizzare che Form5 � closed
      Form2.ABSTable6.Close;
      Form2.ABSTable8.Close;
      Form2.ABSTable9.Close;
      Form2.ABSTable10.Close;
      Form2.ABSTable10.EmptyTable;
      Form2.ABSTable11.Close;
      Form2.ABSTable11.EmptyTable;
      Form2.ABSTable12.Close;
      Form2.ABSTable12.EmptyTable;
      Form2.Visible:=True;
     end;
end;

procedure TForm5.Button2Click(Sender: TObject);  //CERCA
label
vai;
var
chi:array[1..2]of shortint;
i:ShortInt;
begin
     ds51.DataSet:=ABSQuery6;
    i:=0;          //determina se data e/o luogo � in ricerca
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
       filtro:='DATA LIKE '+ QuotedStr('%'+Edit1.Text+'%')+' AND LUOGO LIKE '
       +quotedStr('%'+edit2.text+'%');
       goto vai;
      end;
       if chi[1]>0 then
      begin
       if (edit1.Text<>'')  then
        filtro:= 'DATA LIKE '+quotedstr('%'+Edit1.Text+'%');
       if (edit2.Text<>'')  then
        filtro:='LUOGO LIKE '+QuotedStr('%'+Edit2.Text+'%');
        goto vai;
      end;
  vai :
      //effettua il query
         with ABSQuery6 do
     begin
       close;
       if i>0 then
       begin
        SQL.Text := 'select * from AnaGA where '+filtro; //Attenzione agli spazi prima e dopo gli apici
        ExecSql;
       end else
        begin
          ShowMessage('Nessun elemento di ricerca inserito');
          Exit;
        end;
       Open;
     end;
end;

 procedure TForm5.Button3Click(Sender: TObject);    //Annulla
begin
     Edit1.Text:='';
     Edit2.Text:='';
     ds51.DataSet:=Form2.ABSTable5;
end;


procedure TForm5.Button4Click(Sender: TObject);   //AZZERA
begin
   if MessageDlg('Stai per azzerare l''intera Anagrafe delle Gare. Vuoi continuare ?',
          mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
          begin
            Form2.ABSTable5.Close;
            Form2.ABSTable5.EmptyTable;
            ShowMessage('Tutta l''anagrafe � stata cancellata !');
          end;
end;


procedure TForm5.cbb55Change(Sender: TObject);// Seleziona un dato della Combobox
begin             //effettuando una scelta viene definita la Table attiva
    if cbb55.Text='Base' then
       begin
         tabella:=Form2.ABSTable6;
         tabl:='Base';
         ds55.DataSet:=tabella;
         ShowMessage('Crea la Tabella Discipline Base'+#13+
         'Clicca sul LUOGO della Gara'+#13 +'per inserire il suo codice.'); // Tab 6
       end;
    if cbb55.Text='GruppoA' then
       begin
         tabella:=Form2.ABSTable8;
         tabl:='GRPA';
         ds55.DataSet := tabella;
         ShowMessage('Crea la Tabella Discipline Gruppo A ');//Tab 8
       end;
    if cbb55.Text='GruppoB' then
       begin
         tabella:=Form2.ABSTable9;
         tabl:='GRPB';
         ds55.DataSet := tabella;  //in questo modo mostra gli accoppiamenti gia esistenti
         ShowMessage('Crea la Tabella Discipline Gruppo B '); //Tab 9
       end;
end;

       //Accoppiamento GARA - DISCIPLIN
        // Inserimento codice Gara
procedure TForm5.dbgrd51CellClick(Column: TColumn);
Var
 CoGaSi:Boolean;
begin
   Self.ActiveControl := nil;    //per togliere eventuali focus precedenti
  if cbb55.ItemIndex>-1 then
    begin
       sg:= Form2.ABSTable5.FieldByName('CODGA').AsString;
       //verifica l'esistenza di un precedente accoppiamento per quella Gara
       ds55.DataSet:=ABSQuery6;    //nella tabella degli accoppiamenti (TA)
         with ABSQuery6 do
          begin
           Close;  //inserire una variabile nel query
           SQL.Text := 'Select * from '+tabl+' where CODGA = '+ QuotedStr(sg);
           ExecSql;
           Open;
           end;
       if ABSQuery6.RecordCount>0 then  //nel caso ci sia g� la GARA nella tabella
          if MessageDlg('Hai gi� elaborato questa Gara '+#13+'Vuoi aggiungere discipline ?',
            mtconfirmation, [mbYes,mbNo], 0) = mrNo then
            begin
              if MessageDlg('Vuoi Rifarla del tutto ?',mtconfirmation, [mbYes,mbNo], 0) = mrYes then
               begin
                 Form2.ABSTable6.Edit;
                 with Form2.ABSTable6 do // nel Query c'� gi� l'elenco degli accoppiamenti di quella Gara
                 begin
                   First;
                  while(not Eof)do
                  begin             //seleziona e cancella
                   CoGaSi:= Form2.ABSTable6.Locate('CODGA',sg,[]);
                   if CoGaSi=True then Delete;
                   Next;
                  end;
                 end;
               end;
               ds55.DataSet:= tabella;
               Exit;
            end;     //showmessage con posizione
      ShowMessagePos('Questi sono gli accoppiamenti gi� inseriti',650,250);

      ds55.DataSet:= tabella;  //ritorna al dataset primario
      if MessageDlg('Codice Gara = '+sg+' ?', mtconfirmation, [mbYes,mbNo], 0) = mrYes then
      begin
        tabella.Insert;
        tabella.FieldByName('CODGA').AsInteger:=strToInt(sg);
        tabella.Post;
        showmessage('Clicca sulla DESCRIZIONE della disciplina da accoppiare');
      end else
        begin
          sg:='';
          Exit ;
        end;
    end
  else
    if inserisco5=False then
       ShowMessage('Effettua prima una scelta di Gruppo');
end;

procedure TForm5.dbgrd52MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);  //Accoppiamento GARA - DISCIPLINE
  var                                  //Inserimento codice DISCIPLINE
  s:string;
begin
   if cbb55.ItemIndex>-1 then
     begin
       if sg='' then
        begin             //per definire su quale gara iserire le DSPL
          showmessage('Clicca prima sul luogo della GARA');
          Exit;
        end;
         s:= Form2.ABSTable4.FieldByName('CODDSPL').AsString;
         if MessageDlg('Codice Disciplina = '+s+' ?' , mtconfirmation,
          [mbYes,mbNo], 0) = mrYes then
          begin
          //verifica che non sia gi� inserito
           ds55.DataSet:=ABSQuery6;
               with ABSQuery6 do
               begin
                 Close;  //inserire una variabile nel query
                 SQL.Text := 'Select * from '+tabl+' where CODGA = '+ QuotedStr(sg)+
                 ' and  CODDSPL = '+ QuotedStr(s);
                 ExecSql;
                 Open;
               end;
                 if ABSQuery6.RecordCount>0 then  //caso in cui c'� gi� la DSPL in TA
                    begin
                      ShowMessage('ERRORE - Questa disciplina � gi� inserita');
                      ds55.DataSet:=tabella; //riporta il dbgrid a leggere i valori
                      s:='';
                      Exit;
                    end;
           ds55.DataSet:=tabella;
           tabella.Edit;
           tabella.FieldByName('CODDSPL').AsInteger:=strToInt(s);
           tabella.Post;
           s:='';
                if MessageDlg('Vuoi inserire altre Discipline'+#13+'nella stessa Gara ?' ,
                mtconfirmation, [mbYes,mbNo], 0) = mrYes then
                  begin
                     tabella.Insert;
                     tabella.FieldByName('CODGA').AsInteger:=strToInt(sg);
                     tabella.Post;
                     showmessage('Clicca sulla DESCRIZIONE della disciplina da accoppiare');
                  end else
                    begin
                     sg:=''; //azzera il codice gara precedente
                     s:='';
                     ds55.DataSet:=tabella;
                     Exit;
                    end;
         end
         else Exit;

     end
  else ShowMessage('Effettua prima una scelta di tabella');
end;

procedure TForm5.dbgrd55MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);     //verifica la scelta
begin
    if cbb55.ItemIndex=-1 then
    ShowMessage('Effettua prima una scelta di tabella');
end;

procedure TForm5.dbnvgr51Click(Sender: TObject; Button: TNavigateBtn);
begin                    //intercetta il dbnavigator
     case button of
       nbInsert:    //se inserisce un nuovo record
      begin
       Form2.ABSTable5.Last;
       Form2.ABSTable5.Append;
       inserisco5:=True; //inserisce il flag nel nuovo record
       dbgrd51.SetFocus;
       DBGrd51.SelectedField := Form2.ABSTable5.FieldByName('DATA');
      end ;
       nbPost:
      begin   //se lo carica nella tabella
       inserisco5:=False ;
      end;
       nbDelete: //se cancella il record - serve anche per evitare di entrare in Query
      begin
       inserisco5:=False;
      end;
     end;
end;


procedure TForm5.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin                                //Chiusura del Form5 Gara
    if inserisco5=True then
  if MessageDlg('Hai un dato da salvare ?' , mtconfirmation, [mbYes,mbNo], 0) = mrYes
    then
      begin
         CanClose:=False;
         Exit;
      end
    else
       begin
        CanClose:=True;
          if inserisco5=True then //conferma il Falso di inserisco5
          inserisco5:=False;
          Button1Click(Self);
       end;
end;



procedure TForm5.Edit3Click(Sender: TObject); //Acquisisce la gara per il report
begin                 // ripristina le tabelle
     Edit3.Text:='';
     Form2.ABSTable10.Close;
     Form2.ABSTable10.EmptyTable;
     Form2.ABSTable11.Close;
     Form2.ABSTable11.EmptyTable;
     Form2.ABSTable12.Close;
     Form2.ABSTable12.EmptyTable;
    // Form2.ABSTable10.TableName:='repBase';
     Form2.ABSTable10.Open;
     Form2.ABSTable10.Edit;
   //  Form2.ABSTable11.TableName:='repGRPA';
     Form2.ABSTable11.Open;
     Form2.ABSTable11.Edit;
   //  Form2.ABSTable12.TableName:='repGRPB';
     Form2.ABSTable12.Open;
     Form2.ABSTable12.Edit;

end;
procedure TForm5.Button5Click(Sender: TObject);    //prepara il report
 label
  GA,GB,FINE;
  var
  codgasi,dsplsi:Boolean;
  codgan,DSPLn:Integer;
  DSPLstr:string;
begin      //Riempire le 3 tabelle
    if Edit3.Text='' then
      begin
         ShowMessage('Devi inserire il codice della Gara');
         Exit;
      end else  //il codice GARA � presente
      begin     // Verifica l'esistenza della Gara negli accoppiamenti Base etc.

          codgasi:= Form2.ABSTable5.Locate('CODGA',Edit3.text,[]);
          if codgasi=False then
             begin
               ShowMessage('Questo codice Gara � inesistente ');
               Exit;
             end else
             begin          //Trovata la gara ed il giorno di esecuzione
               codgan:=StrToInt(Edit3.Text);
               garastr:= Form2.ABSTable5.FieldByName('LUOGO').AsString;
               giornostr := Form2.ABSTable5.FieldByName('DATA').AsString;
             end;

                            //trovare le discipline della BASE
        if Form2.ABSTable10.RecordCount>0 then  //la tabella Base � gia piena
         begin
           if MessageDlg('Il report delle discipline Base � gi� fatto. Vuoi rifarlo?' ,
                mtconfirmation, [mbYes,mbNo], 0) = mrYes then
              begin
                Form2.ABSTable10.EmptyTable;
              end else goto GA;
         end;
          Form2.ABSTable6.DisableControls;
          try
            Form2.ABSTable6.First;
            while not Form2.ABSTable6.Eof do
             begin   //per ogni codga ricavare il cod dspl e memorizzare la DESCR nella Tabella
                if codgan=Form2.ABSTable6.FieldByName('CODGA').AsInteger then
                 begin  //se il codice gara corrisponde
                   DSPLn:=Form2.ABSTable6.FieldByName('CODDSPL').AsInteger;//memorizza la disciplina
                   dsplsi:=Form2.ABSTable4.Locate('CODDSPL',DSPLn,[]);//cerca la disciplina sull'anagrafica
                     if dsplsi=True then //quando la trova
                       begin
                         DSPLstr:= Form2.ABSTable4.FieldByName('DESCR').AsString;//memorizza la descrizione
                         Form2.ABSTable10.Insert;  //la registra sulla tabella del report
                         Form2.ABSTable10.FieldByName('CODDSPL').AsInteger:=DSPLn;
                         Form2.ABSTable10.FieldByName('DESCR').AsString:=DSPLstr;
                         Form2.ABSTable10.FieldByName('TMAX').AsDateTime:=Form2.ABSTable4.FieldByName('TMAX').AsDateTime;
                         Form2.ABSTable10.Post;
                       end;
                 end;
              Form2.ABSTable6.Next;
             end;
          finally
            Form2.ABSTable6.EnableControls;
            ShowMessage('Registrate le discipline Base');
          end;

          GA :
                    //trovare le discipline del GruppoA
        if Form2.ABSTable11.RecordCount>0 then  //� vuota la tabella GRPA ?
         begin
           if MessageDlg('Il report delle discipline Gruppo A � gi� fatto. Vuoi rifarlo?' ,
                mtconfirmation, [mbYes,mbNo], 0) = mrYes then
              begin
                Form2.ABSTable11.EmptyTable;
              end else goto GB;
         end;

        Form2.ABSTable8.DisableControls;
        try
          Form2.ABSTable8.First;
          while not Form2.ABSTable8.Eof do
           begin   //per ogni codga ricavare il cod dspl e memorizzare la DESCR nella Tabella
               if codgan=Form2.ABSTable8.FieldByName('CODGA').AsInteger then
                 begin  //se il codice gara corrisponde
                   DSPLn:=Form2.ABSTable8.FieldByName('CODDSPL').AsInteger;//memorizza la disciplina
                   dsplsi:=Form2.ABSTable4.Locate('CODDSPL',DSPLn,[]);//cerca la disciplina sull'anagrafica
                     if dsplsi=True then //quando la trova
                       begin
                         DSPLstr:= Form2.ABSTable4.FieldByName('DESCR').AsString;//memorizza la descrizione
                         Form2.ABSTable11.Insert;  //la registra sulla tabella del report
                         Form2.ABSTable11.FieldByName('CODDSPL').AsInteger:=DSPLn;
                         Form2.ABSTable11.FieldByName('DESCR').AsString:=DSPLstr;
                         Form2.ABSTable11.FieldByName('TMAX').AsDateTime:=Form2.ABSTable4.FieldByName('TMAX').AsDateTime;
                         Form2.ABSTable11.Post;
                       end;
                 end;
            Form2.ABSTable8.Next;
           end;
        finally
          Form2.ABSTable8.EnableControls;
          ShowMessage('Registrate le discipline Gruppo A');
        end;

          GB :

        if Form2.ABSTable12.RecordCount>0 then  //� vuota la tabella Base ?
         begin
           if MessageDlg('Il report delle discipline Gruppo B � gi� fatto. Vuoi rifarlo?' ,
                mtconfirmation, [mbYes,mbNo], 0) = mrYes then
              begin
                Form2.ABSTable12.EmptyTable;
              end else goto FINE;
         end;

        Form2.ABSTable9.DisableControls;
        try
          Form2.ABSTable9.First;
          while not Form2.ABSTable9.Eof do
           begin   //per ogni codga ricavare il cod dspl e memorizzare la DESCR nella Tabella
               if codgan=Form2.ABSTable9.FieldByName('CODGA').AsInteger then
                 begin  //se il codice gara corrisponde
                   DSPLn:=Form2.ABSTable9.FieldByName('CODDSPL').AsInteger;//memorizza la disciplina
                   dsplsi:=Form2.ABSTable4.Locate('CODDSPL',DSPLn,[]);//cerca la disciplina sull'anagrafica
                     if dsplsi=True then //quando la trova
                       begin
                         DSPLstr:= Form2.ABSTable4.FieldByName('DESCR').AsString;//memorizza la descrizione
                         Form2.ABSTable12.Insert;  //la registra sulla tabella del report
                         Form2.ABSTable12.FieldByName('CODDSPL').AsInteger:=DSPLn;
                         Form2.ABSTable12.FieldByName('DESCR').AsString:=DSPLstr;
                         Form2.ABSTable12.FieldByName('TMAX').AsDateTime:=Form2.ABSTable4.FieldByName('TMAX').AsDateTime;
                         Form2.ABSTable12.Post;
                       end;
                 end;
            Form2.ABSTable9.Next;
           end;
        finally
          Form2.ABSTable9.EnableControls;
          ShowMessage('Registrate le discipline Gruppo B');
        end;

          FINE :
      end;
      // Presentare il report   Nota bene come si passano le variabili
      Form5.frxReport5.Variables['mia1'] := QuotedStr(giornostr);
      Form5.frxReport5.Variables['mia2'] := QuotedStr(garastr);
     // Form5.frxPDFExport51.FileName:='Accoppiamenti';
      Form5.frxReport5.ShowReport;
      Edit3.Text:='';
end;

procedure TForm5.Button6Click(Sender: TObject);
begin
      Form5.frxReport5.Print;
end;

                            // ELENCA o STAMPA L'anagrafe Gare
             procedure TForm5.Button7Click(Sender: TObject);
begin
     Form5.frxReport51.ShowReport;
      if MessageDlg('Vuoi stamparlo ?' , mtconfirmation, [mbYes,mbNo], 0,mbNo) = mrNo
       then  Exit else
         Form5.frxReport51.Print;
end;

procedure TForm5.Button8Click(Sender: TObject);  //Azzera gruppo Base
begin
  if MessageDlg('Stai per azzerare l''intera Anagrafe del Gruppo Base. Vuoi continuare ?',
          mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
          begin
            Form2.ABSTable6.Close;
            Form2.ABSTable6.EmptyTable;
            ShowMessage('Tutta l''anagrafe � stata cancellata !');
          end;
end;

procedure TForm5.Button9Click(Sender: TObject);   // Azzera gruppo A
begin
   if MessageDlg('Stai per azzerare l''intera Anagrafe del Gruppo A. Vuoi continuare ?',
          mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
          begin
            Form2.ABSTable8.Close;
            Form2.ABSTable8.EmptyTable;
            ShowMessage('Tutta l''anagrafe � stata cancellata !');
          end;
end;

procedure TForm5.Button10Click(Sender: TObject);    //Azzera gruppo B
begin
  if MessageDlg('Stai per azzerare l''intera Anagrafe del Gruppo B. Vuoi continuare ?',
          mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
          begin
            Form2.ABSTable9.Close;
            Form2.ABSTable9.EmptyTable;
            ShowMessage('Tutta l''anagrafe � stata cancellata !');
          end;
end;

//Pulizia dei record vuoti
procedure TForm5.Pulizia(Sender:TObject);  //Quando crei una Procedura premetti il Form
var
trovato,rimosso:Boolean ;
begin
    trovato:=False;
    rimosso:=False;
   trovato:=Form2.ABSTable6.Locate('CODDSPL',null,[]);  //senza LocateOptions
   if trovato=True then
    begin
      Form2.ABSTable6.Delete;
      rimosso:=True;
      trovato:=False;
    end;
   trovato:=Form2.ABSTable6.Locate('CODGA',null,[]);  //senza LocateOptions
   if trovato=True then
    begin
      Form2.ABSTable6.Delete;
      rimosso:=True;
      trovato:=False;
    end;

   trovato:=Form2.ABSTable8.Locate('CODDSPL',null,[]);  //senza LocateOptions
   if trovato=True then
    begin
      Form2.ABSTable8.Delete;
      rimosso:=True;
      trovato:=False;
    end;
    trovato:=Form2.ABSTable8.Locate('CODGA',null,[]);  //senza LocateOptions
   if trovato=True then
    begin
      Form2.ABSTable8.Delete;
      rimosso:=True;
      trovato:=False;
    end;

    trovato:=Form2.ABSTable9.Locate('CODDSPL',null,[]);  //senza LocateOptions
   if trovato=True then
    begin
      Form2.ABSTable9.Delete;
      rimosso:=True;
      trovato:=False;
    end;
     trovato:=Form2.ABSTable9.Locate('CODGA',null,[]);  //senza LocateOptions
   if trovato=True then
    begin
      Form2.ABSTable9.Delete;
      rimosso:=True;
      trovato:=False;
    end;
   if rimosso=True then
      begin
         ShowMessage('Rimosso ogni record incompleto' );
         rimosso:=False;
      end;
end;
end.


unit Gara;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB, ABSMain, Vcl.ComCtrls,
  Vcl.Imaging.jpeg, Vcl.Buttons, frxClass, frxDBSet, frxExportPDF,
  Datasnap.Provider, Datasnap.DBClient;

type
  TForm6 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    dbgrd72: TDBGrid;
    dbnvgr7: TDBNavigator;
    ds7: TDataSource;
    ds72: TDataSource;
    AbsQuery72: TABSQuery;
    cbb72: TComboBox;
    Label7: TLabel;
    Timer1: TTimer;
    Label8: TLabel;
    shp1: TShape;
    Label9: TLabel;
    dbgrd7: TDBGrid;
    dbgrd74: TDBGrid;
    ds74: TDataSource;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    ABSQuery7: TABSQuery;
    Button5: TButton;
    ABSQuery74: TABSQuery;
    img2: TImage;
    cbb74: TComboBox;
    Label2: TLabel;
    rb1: TRadioButton;
    rb2: TRadioButton;
    btn1: TBitBtn;
    img3: TImage;
    Label3: TLabel;
    Label4: TLabel;
    frxdbdtst13: TfrxDBDataset;
    ABSQuery73: TABSQuery;
    ABSTable13: TABSTable;
    ds13: TDataSource;
    frxrprt7: TfrxReport;
    frxPDFExport7: TfrxPDFExport;
    Button6: TButton;
    Edit3: TEdit;
    Button7: TButton;
    ABSTable14: TABSTable;
    Button8: TButton;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Button9: TButton;
    img1: TImage;
    Edit4: TEdit;
    Label10: TLabel;
    Button10: TButton;
    frxReport14: TfrxReport;
    frxDBDataset14: TfrxDBDataset;
    ABSQueryDUP: TABSQuery;
    ABSQueryDUP2: TABSQuery;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgrd72CellClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure dbnvgr7Click(Sender: TObject; Button: TNavigateBtn);
    procedure cbb72Select(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button5Click(Sender: TObject);
    procedure cbb74Change(Sender: TObject);
    procedure rb2Click(Sender: TObject);
    procedure rb1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ABSTable14BeforeInsert(DataSet: TDataSet);
    procedure ABSTable14BeforeDelete(DataSet: TDataSet);
    procedure Button9Click(Sender: TObject);
    procedure dbgrd7CellClick(Column: TColumn);
    procedure GetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure Button10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
          //NOTA BENE l'entry del codice gara non triggera alcun evento
var
  Form6: TForm6;
  GaFlg:Boolean =True;
  inserisco7:Boolean=False;
  ATL:Integer;
  scelta:Boolean=False; // se si sceglie con la combobox > True
  filtGa:Boolean=False;   // idem se filtra Gara
  CanClose:Boolean=True;
  LastGa:SmallInt;
  numgara:Integer;
  tempo:string;
  rab1,rab2:Boolean;
implementation
  uses
  Console1,aiuto,Tempi ;
{$R *.dfm}
 {$D+}
procedure TForm6.FormCreate(Sender: TObject);  //Crea il form
begin
  // Form2.ABSTable7.TableName:='Gara';
   Form2.ABSTable7.Open;                            //FORMATTARE CAMPI DBGRID
   TDateTimeField(Form2.ABSTable7.FieldByName('TAME1')).DisplayFormat:='nn:ss,zzz';
   TDateTimeField(Form2.ABSTable7.FieldByName('TBME2')).DisplayFormat:='nn:ss,zzz';
   TDateTimeField(Form2.ABSTable7.FieldByName('PEN')).DisplayFormat:='nn:ss,zzz';
   TBooleanField(Form2.ABSTable7.FieldByName('DQ')).DisplayValues:='Yes;No';
   ABSTable14.TableName:='Corrente';
   ABSTable14.Open;
   ABSTable13.TableName:=('Maestra');
   TDateTimeField(ABSTable14.FieldByName('TAME1')).DisplayFormat:='nn:ss,zzz';
   TDateTimeField(ABSTable14.FieldByName('TBME2')).DisplayFormat:='nn:ss,zzz';
   TDateTimeField(ABSTable14.FieldByName('PEN')).DisplayFormat:='nn:ss,zzz';
   TBooleanField(ABSTable14.FieldByName('DQ')).DisplayValues:='Yes;No';
   GaFlg:=False;
   ds7.DataSet:=Form2.ABSTable7;//aggiunto per evitare circular DataLink error
   Form2.ABSTable7.Edit;
   Form2.ABSTable4.Open;
   Form2.ABSTable1.Open;
   Form2.ABSTable1.INSERT;
   Form2.ABSTable1.FieldByName('IN').AsDateTime:= NOW;
   Form2.ABSTable1.FieldByName('what').AsString:='Accesso alle Iscrizioni';
   Form2.ABSTable1.FieldByName('OUT').AsString:='';
   Form2.ABSTable1.Post;
   Form2.ABSTable1.Close;
   cbb74.Text:='Scegli';
   if rb1.Checked=True then
       begin
         Edit2.Visible:=False;
         Label1.Visible:=False;
       end;
   Form2.ABSTable5.TableName:='AnaGa';
   Form2.ABSTable5.Open;
   Form2.ABSTable5.Last;
   LastGa:=Form2.ABSTable5.FieldByName('CODGA').AsInteger ;
   Label4.Caption:=IntToStr(LastGa);
   Button2.Click;   //Refresh
   Button5.Click;
   ATL:=0;
end;

 procedure TForm6.GetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if ABSTable14.FieldByName('DQ').AsBoolean then
    Text := 'Yes'
  else
    Text := 'No';

end;



procedure TForm6.rb1Click(Sender: TObject); //AUTOMATICA
begin
    Edit2.Visible:=False;   //toglie  edit2
    Label1.Visible:=False;
    cbb74.Visible:=True;
    Label2.Visible:=True;
end;

procedure TForm6.rb2Click(Sender: TObject); // MANUALE
begin
   if Edit1.Text='' then
   begin
     ShowMessage('Inserisci il Codice della Gara ');
     rb1.Checked:=True;
     Exit;
   end;
   cbb74.Visible:=False;
   Label2.Visible:=False;
   Edit2.Visible:=True;
   Label1.Visible:=True;
   ds74.DataSet:=Form2.ABSTable4;
end;

procedure TForm6.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if inserisco7=True then
  if MessageDlg('Hai un dato da salvare ?' , mtconfirmation, [mbYes,mbNo], 0) = mrYes
    then
      begin
         CanClose:=False;
         Exit;
      end
    else
       begin
        CanClose:=True;
          if inserisco7=True then //conferma il Falso di inserisco5
          inserisco7:=False;
          Button1Click(Self);
       end;
end;


procedure TForm6.Timer1Timer(Sender: TObject);   //Flashing
begin
  if Edit1.Text='' then
    begin
        if label8.Font.Color = clRed then
        label8.Font.Color :=  clNavy
      else
      label8.Font.color := clRed;
    end else Label8.Visible:=False;
  if Edit2.Text='' then
    begin
        if label1.Font.Color = clRed then
        label1.Font.Color :=  clNavy
      else
      label1.Font.color := clRed;
    end else Label1.Visible:=False;
    //condizioni per garantire che label2 sia invisibile, altrimenti il colore vince
  if ((cbb74.ItemIndex=0) or (cbb74.Text='Scegli'))and (cbb74.Visible=True) then
    begin
        if label2.Font.Color = clRed then
        label2.Font.Color :=  clNavy
      else
      label2.Font.color := clRed;
      Label2.Visible:=True;
    end else Label2.Visible:=False;

end;

procedure TForm6.ABSTable14BeforeDelete(DataSet: TDataSet);
begin
   if ds7.DataSet=ABSTable14 then
    begin
     ShowMessage('Prima di rimuovere un record premi "Refresh" '+#13+
     'ed identifica il record con il suo codice');
     Abort;
     Exit;
    end;
end;

procedure TForm6.ABSTable14BeforeInsert(DataSet: TDataSet);
begin
   if ds7.DataSet=ABSTable14 then
    begin
     ShowMessage('Per inserire nuovi record premi "Refresh" '+#13+
     'o esegui l''inserimento automatico');
      Abort;
      Exit;
    end;
end;

procedure TForm6.btn1Click(Sender: TObject);
begin
 // Form7.Create(self);
  Form7.Show;
end;

procedure TForm6.Button1Click(Sender: TObject);   //Esci

begin

    if filtGa =True then
    if MessageDlg('Devi sincronizzare la tabella delle iscrizioni ?'
   , mtconfirmation, [mbYes,mbNo], 0) = mrYes then Exit;
   filtGa:=False;
   if inserisco7=True then  //se ha inserito un record
     begin
       FormCloseQuery(Self,canclose);
     end
     else
     begin
      Form2.ABSTable7.Close;
      Form6.Close;   // NB chiama il can close
      GaFlg:=True;  //per consentire di monitorizzare che Form6 è closed
      Form2.Visible:=True;
      Edit1.Text:=''; //rimuove il codice della gara
      Edit2.Text:='';   //  ''            della DSPL
      Form2.ABSTable10.Close; //Chiude non cancella
      Form2.ABSTable11.Close;
      Form2.ABSTable12.Close;
      Form6.ABSTable13.Close;
      Form6.ABSTable13.EmptyTable;
      Form6.ABSTable14.Close;
      Form6.ABSTable14.EmptyTable;
      Form2.ABSTable2.Close;
      Form2.ABSTable4.Close;
      Form2.ABSTable5.Close;
      Form2.ABSTable6.Close;
      Form2.ABSTable8.Close;
      Form2.ABSTable9.Close;

      Form2.ABSTable1.Open;
      Form2.ABSTable1.Last;
       if Form2.ABSTable1.FieldByName('Password').AsString<>'' then
       Form2.ABSTable1.Insert;
      Form2.ABSTable1.Edit;
      Form2.ABSTable1.FieldByName('OUT').AsDateTime:=NOW;
      Form2.ABSTable1.Post;
      Form2.ABSTable1.Close;
     end;

end;

procedure TForm6.Button2Click(Sender: TObject);    //Refresh dbgrid Atleti
begin
     ds72.DataSet:=AbsQuery72;
     with AbsQuery72 do
      begin
        Close;  //inserisce una variabile nel query
        SQL.Text := 'Select * from AnaAtl';
        ExecSql;
        Open;
      end;
end;

procedure TForm6.Button3Click(Sender: TObject);   //Rapporto
var
CODGAn:Integer;
DSPLsi,ATLsi:Boolean;
CODDSPL13,CODATL13:Integer;
begin
    Form2.ABSTable4.Open;
    //Form2.ABSTable4.Edit;
    Form2.ABSTable2.Open;
    //Form2.ABSTable2.Edit;
    CODGAn:=StrToInt(inputBox('Rapporto Iscrizioni','Inserire il codice della Gara',Edit1.Text));
    ds7.DataSet :=  ABSQuery7; //Costruisce una tabella SQL
         with ABSQuery7 do
           begin
              Close;    //porto su DBGRID solo la gara scelta con tutti gli iscritti
              SQL.Text := 'Select * from Gara where CODGA = '+QuotedStr(IntToStr(CODGAn))+ ' ORDER BY CODATL Asc, CODDSPL Asc';
              ExecSql;
              Open;       //Estrae i dati di iscrizione solo per una gara
              First;
               // La ricostruisce da cleaned
              Form6.ABSTable13.Close;
              Form6.ABSTable13.EmptyTable;
              Form6.ABSTable13.Open;
              TBooleanField(ABSTable13.FieldByName('DQ')).DisplayValues:='Yes;No';
              TDateTimeField(ABSTable13.FieldByName('TAME1')).DisplayFormat:='nn:ss,zzz';
              TDateTimeField(ABSTable13.FieldByName('TBME2')).DisplayFormat:='nn:ss,zzz';
              TDateTimeField(ABSTable13.FieldByName('PEN')).DisplayFormat:='nn:ss,zzz';
              Form6.ABSTable13.Edit;                // Crea Tabella Master per il report = Maestra
               while (not Eof) do  //sempre sotto ABSQuery7
               begin                                  // copia il Query in una Table
                 Form6.ABSTable13.Insert;
                 Form6.ABSTable13.FieldByName('CODGA').AsInteger:=ABSQuery7.FieldByName('CODGA').AsInteger;
                 Form6.ABSTable13.FieldByName('CODDSPL').AsInteger:=ABSQuery7.FieldByName('CODDSPL').AsInteger;
                 Form6.ABSTable13.FieldByName('CODATL').AsInteger:=ABSQuery7.FieldByName('CODATL').AsInteger;
                 Form6.ABSTable13.FieldByName('COGNOME').AsString:=ABSQuery7.FieldByName('COGNOME').AsString;
                 Form6.ABSTable13.FieldByName('NMPET').AsInteger:=ABSQuery7.FieldByName('NMPET').AsInteger;
                 Form6.ABSTable13.FieldByName('NMPOS').AsInteger:=ABSQuery7.FieldByName('NMPOS').AsInteger;
                 Form6.ABSTable13.FieldByName('TAME1').AsDateTime:=ABSQuery7.FieldByName('TAME1').AsDateTime;
                 Form6.ABSTable13.FieldByName('TBME2').AsDateTime:=ABSQuery7.FieldByName('TBME2').AsDateTime;
                 Form6.ABSTable13.FieldByName('DQ').AsBoolean:=ABSQuery7.FieldByName('DQ').AsBoolean;
                 Form6.ABSTable13.FieldByName('PEN').AsDateTime:=ABSQuery7.FieldByName('PEN').AsDateTime;
                 Form6.ABSTable13.FieldByName('MANL').AsBoolean:=ABSQuery7.FieldByName('MANL').AsBoolean;
                 Form6.ABSTable13.FieldByName('CAT').AsInteger:=ABSQuery7.FieldByName('CAT').AsInteger;
                 Form6.ABSTable13.Post;
                 ABSQuery7.Next;
               end;

           end;       //aggiungo i campi DESCR e TMAX
     ABSTable13.First;
     while not ABSTable13.EOF do
       begin
         CODDSPL13:=ABSTable13.FieldByName('CODDSPL').AsInteger;
         DSPLsi:=Form2.ABSTable4.Locate('CODDSPL',CODDSPL13,[] );//si blocca sul record con pari codice DSPL
         if DSPLsi=False then ShowMessage('Valore non trovato');  //NB nel locate il valore da ricercare è variant (non stringa)
         ABSTable13.Edit;
         ABSTable13.FieldByName('DESCR').AsString:=Form2.ABSTable4.FieldByName('DESCR').AsString;
         ABSTable13.FieldByName('TMAX').AsDateTime:=Form2.ABSTable4.FieldByName('TMAX').AsDateTime;
         ABSTable13.Post;
         ABSTable13.NEXT
       end;
       //  Aggiungo il nome e nazione e il telefono
      ABSTable13.First;
     while not ABSTable13.EOF do
       begin
         CODATL13:=ABSTable13.FieldByName('CODATL').AsInteger;
         ATLsi:=Form2.ABSTable2.Locate('CODATL',CODATL13,[] );//si blocca sul record con pari codice DSPL
         if ATLsi=False then ShowMessage('Valore non trovato');                              // NB nel locate il valore da ricercare è variant (non stringa)
         ABSTable13.Edit;
         ABSTable13.FieldByName('NOME').AsString:=Form2.ABSTable2.FieldByName('NOME').AsString;
         ABSTable13.FieldByName('NAZIONE').AsString:=Form2.ABSTable2.FieldByName('NAZIONE').AsString;
         ABSTable13.FieldByName('TLF').AsString:=Form2.ABSTable2.FieldByName('TLF').AsString;
         ABSTable13.Post;
         ABSTable13.NEXT
       end;
     Form6.frxrprt7.ShowReport;
end;

procedure TForm6.Button4Click(Sender: TObject);  //Stampa Report
begin
    Form6.frxrprt7.Print;
end;

procedure TForm6.Button5Click(Sender: TObject);  //Refresh tabella iscrizioni
begin
     dbgrd7.Columns[0].FieldName:='NMREC'; //applicare il campo relativo al cambio di Dataset
     Label6.Caption:='Dati relativi a tutte le Gare';
     ds7.DataSet:=Form2.ABSTable7;
end;

procedure TForm6.Button6Click(Sender: TObject);      // Filtro una gara      LAVORI IN CORSO CODICE DA RIVEDERE
var
quanti,btscelta  :Integer;
cosa:TStringList;
ca,cd,ga:Integer;
begin
   if Edit3.Text='' then
   begin
     ShowMessage('Inserisci il codice della Gara nella casella a destra !');
     Exit;
   end;
    Form6.ABSTable14.TableName:=('Corrente');
    Form6.ABSTable14.Open;
    Form6.ABSTable14.Edit;
    quanti:=ABSTable14.RecordCount;
    filtGa:=True;
    if quanti>0  then  //Continua solo se non esiste già il buffer
      begin
        numgara:=ABSTable14.FieldByName('CODGA').AsInteger;
         if numgara<> StrToInt(Edit3.Text) then  //numero gara residente DIVERSO dal richiesto
           begin
               if MessageDlg('La tabella contiene dati per una Gara diversa '+#13#10+
               'e con codice : '+ IntToStr(numgara)+'  Desideri cancellarli ?', mtconfirmation,
               [mbYes,mbNo], 0) = mrYes then
                 begin
                   Button7Click(self);
                   Edit3.Text:='';
                   Exit;
                 end else
                  begin    //Gara diversa da quella richiesta non cancellata
                     ShowMessage('Puoi esaminare una gara per volta, ripeti la scelta !');
                     Edit3.Text:='';
                     Exit;
                  end;
            end else
           begin
             btscelta := MessageDlg('La Tabella per la Gara n. '+IntToStr(numgara)+' ha '+IntToStr(quanti)+
             '  dati.'+#13+' Vuoi usarla(Yes) o cancellarla(No) o rinunciare(Cancel) ? ',mtCustom,
                              [mbYes,mbNo,mbCancel], 0);
             if btscelta = mrYes    then     //usa il precedente buffer e continua
              begin
               dbgrd7.Columns[0].FieldName:='NM'; //applicare il campo relativo al cambio di Dataset
               ds7.DataSet:=ABSTable14;
               Label6.Caption:='Dati relativi ad una Gara';
               ShowMessage('E'' possibile effettuare modifiche');
               Edit3.Text:='';   //Punto in cui si è scelta la GARA da Aggiornare
               Exit;
              end;
             if btscelta = mrNo    then    // cancella il buffer per rifarlo
              begin
                Button7Click(Self);
                Edit3.Text:='';
                exit;
              end;
            if btscelta = mrCancel then    //esce dalla procedura
              begin
               Edit3.Text:='';
               Exit;
              end;
           end;
      end;

    dbgrd7.Columns[0].FieldName:='NM'; //applicare il campo relativo al cambio di Dataset
    ds7.DataSet :=  ABSQuery7; //Costruisce una tabella SQL
         with ABSQuery7 do
           begin
              Close;    //porto su DBGRID solo la gara scelta con tutti gli iscritti
              SQL.Text := 'Select * from Gara where CODGA = '+QuotedStr(Edit3.Text)+ ' ORDER BY CODATL Asc, CODDSPL Asc';
              ExecSql;
              Open;       //Estrae i dati di iscrizione solo per una gara
              First;
               while (not Eof) do  //sempre sotto ABSQuery7
               begin                                  // copia il Query in una Table  14 Buffer gara corrente
                 Form6.ABSTable14.Insert;
                 Form6.ABSTable14.FieldByName('NM').AsInteger:=ABSQuery7.FieldByName('NMREC').AsInteger;
                 Form6.ABSTable14.FieldByName('CODGA').AsInteger:=ABSQuery7.FieldByName('CODGA').AsInteger;
                 Form6.ABSTable14.FieldByName('CODDSPL').AsInteger:=ABSQuery7.FieldByName('CODDSPL').AsInteger;
                 Form6.ABSTable14.FieldByName('CODATL').AsInteger:=ABSQuery7.FieldByName('CODATL').AsInteger;
                 Form6.ABSTable14.FieldByName('COGNOME').AsString:=ABSQuery7.FieldByName('COGNOME').AsString;
                 Form6.ABSTable14.FieldByName('NMPET').AsInteger:=ABSQuery7.FieldByName('NMPET').AsInteger;
                 Form6.ABSTable14.FieldByName('NMPOS').AsInteger:=ABSQuery7.FieldByName('NMPOS').AsInteger;
                 Form6.ABSTable14.FieldByName('TAME1').AsDateTime:=ABSQuery7.FieldByName('TAME1').AsDateTime;
                 Form6.ABSTable14.FieldByName('TBME2').AsDateTime:=ABSQuery7.FieldByName('TBME2').AsDateTime;
                 Form6.ABSTable14.FieldByName('DQ').AsBoolean:=ABSQuery7.FieldByName('DQ').AsBoolean;
                 Form6.ABSTable14.FieldByName('PEN').AsDateTime:=ABSQuery7.FieldByName('PEN').AsDateTime;
                 Form6.ABSTable14.FieldByName('MANL').AsBoolean:=ABSQuery7.FieldByName('MANL').AsBoolean;
                 Form6.ABSTable14.FieldByName('CAT').AsInteger:=ABSQuery7.FieldByName('CAT').AsInteger;
                 Form6.ABSTable14.Post;
                 ABSQuery7.Next;
               end;
           end;
   Label6.Caption:='Dati relativi ad una Gara';
   ds7.DataSet:=ABSTable14;                      //MOSTRA LA TABELLA GARA CORRENTE
    //Controllo presenza dati essenziali
       cosa:=TStringList.Create;
       cosa.Clear;
         ABSTable14.First;
        while not ABSTable14.Eof do
          begin
           if ABSTable14.FieldByName('CAT').AsInteger=0 then
             begin
               ga:=ABSTable14.FieldByName('CODGA').AsInteger;
               ca:=ABSTable14.FieldByName('CODATL').AsInteger;
               cd:=ABSTable14.FieldByName('CODDSPL').AsInteger;
               cosa.Add('Gara : '+IntToStr(ga)+' Codice Atl. : '+inttostr(ca)+'- Disciplina: '+inttoStr(cd)+'> Categoria');
             end;
           if ABSTable14.FieldByName('NMPET').AsInteger=0 then
             begin
               ga:=ABSTable14.FieldByName('CODGA').AsInteger;
               ca:=ABSTable14.FieldByName('CODATL').AsInteger;
               cd:=ABSTable14.FieldByName('CODDSPL').AsInteger;
               cosa.Add('Gara : '+IntToStr(ga)+'Codice Atl. : '+inttostr(ca)+'- Disciplina: '+inttoStr(cd)+'> Pettorale');
             end;
           if ABSTable14.FieldByName('NMPOS').AsInteger=0 then
             begin
               ga:=ABSTable14.FieldByName('CODGA').AsInteger;
               ca:=ABSTable14.FieldByName('CODATL').AsInteger;
               cd:=ABSTable14.FieldByName('CODDSPL').AsInteger;
               cosa.Add('Gara : '+IntToStr(ga)+'Codice Atl. : '+inttostr(ca)+'- Disciplina: '+inttoStr(cd)+'> Posizione');
             end;
           ABSTable14.Next;
          end;
       if cosa.Count>0 then
          begin
            cosa.SaveToFile('.\mancanti.txt');
            if (cosa.Count<50)then
            ShowMessage('Codici Atleti con dati mancanti-Annotarli ' +#13+#13+ cosa.Text+#13+
            ' Dati salvati in "mancanti.txt"') else
            ShowMessage('La lista degli Atleti con dati mancanti è salvata in "Mancanti.txt".');

             //Correzione DATI Mancanti
            if MessageDlg('Desideri fornire ora i dati mancanti essenziali ?'+#13+#13
             + 'Ricorda di caricare il dato e sincronizzare',mtconfirmation, [mbYes,mbNo], 0) = mrYes then
            begin
             ds7.DataSet:=ABSQuery7;
             with ABSQuery7  do
              begin
               Close;
               SQL.Text := 'Select * from Corrente where CAT = '+QuotedStr(IntToStr(0)) ;
               ExecSql;
               Open;
              end;
            end;
           end;

   ShowMessage('E'' possibile effettuare modifiche');
   Edit3.Text:='';
   cosa.Clear;
end;


procedure TForm6.Button7Click(Sender: TObject);    // Resetta la tabella della Gara corrente
begin
     if MessageDlg('Stai per azzerare i dati memorizzati nel Buffer. Vuoi continuare ?',
          mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
          begin
            ABSTable14.Close;
            ABSTable14.EmptyTable;
            ShowMessage('Tutti i dati di iscrizione contenuti nel buffer sono stati cancellati,'
            +#13+' i dati sincronizzati sono presenti nel Database');
          end;
     ds7.DataSet:=Form2.ABSTable7;
end;

procedure TForm6.Button8Click(Sender: TObject);    //Sincronizza buffer con Gara
var
doppio:Boolean;
cerco:integer;
begin
   if filtGa=False then
    begin
     ShowMessage('Non c''è nulla da sincronizzare.');
     Exit;
    end;
   if MessageDlg('Confermi di voler aggiornare i Dati Base ?', mtconfirmation,
      [mbYes,mbNo], 0) = mrNo then Exit;

   Form2.ABSTable7.Open;
   ABSTable14.Open;
   ABSTable14.First;
   ABSTable14.Edit;
    while not ABSTable14.eof do
     begin
       cerco:=ABSTable14.FieldByName('NM').AsInteger;
       doppio:=Form2.ABSTable7.Locate('NMREC',cerco,[]);
       if doppio=True then
         begin  //record preesistente da aggiornare
           Form2.ABSTable7.Edit;
           Form2.ABSTable7.FieldByName('NMPET').AsInteger:=ABSTable14.FieldByName('NMPET').AsInteger;
           Form2.ABSTable7.FieldByName('NMPOS').AsInteger:=ABSTable14.FieldByName('NMPOS').AsInteger;
           Form2.ABSTable7.FieldByName('TAME1').AsDateTime:=ABSTable14.FieldByName('TAME1').AsDateTime;
           Form2.ABSTable7.FieldByName('TBME2').AsDateTime:=ABSTable14.FieldByName('TBME2').AsDateTime;
           Form2.ABSTable7.FieldByName('DQ').AsBoolean:=ABSTable14.FieldByName('DQ').AsBoolean;
           Form2.ABSTable7.FieldByName('PEN').AsDateTime:=ABSTable14.FieldByName('PEN').AsDateTime;
           Form2.ABSTable7.FieldByName('MANL').AsBoolean:=ABSTable14.FieldByName('MANL').AsBoolean;
           Form2.ABSTable7.FieldByName('CAT').AsInteger:=ABSTable14.FieldByName('CAT').AsInteger;
           Form2.ABSTable7.Post;
         end else
          begin
            ShowMessage('ERRORE ! Il record con il codice '+IntToStr(cerco)+
            ' non esiste nella Tabella Gare Generale.');
          end;
       ABSTable14.Next;
     end;
      ShowMessage('La tabella Gare Generale è stata aggiornata.'+#13+
          'Puoi cliccare "Azzera" per cancellare il buffer.');
end;

procedure TForm6.Button9Click(Sender: TObject);
begin
    if filtGa=False then
      begin
        ShowMessage('Non c''è alcuna Gara selezionata');
        Exit;
      end;
    Form9.Show;
end;


procedure TForm6.Button10Click(Sender: TObject);  //Rapporto iscritti
begin
    if Edit3.Text='' then
   begin
     ShowMessage('Inserisci il codice della Gara nella casella a destra !');
     Exit;
   end;

   frxReport14.ShowReport;

end;

//Inserimento atleti nella gara cliccando su un Atleta
procedure TForm6.dbgrd72CellClick(Column: TColumn);
var
Nom,Cogn:string;
volte:smallInt;
Sorge:TABSTable;
RecT2:Boolean;
trovato:Boolean;
n:Integer;
begin
   if Edit1.Text<>'' then
   begin
     // o usa la Tab2=ATL o Query2 = ATL da cognome
     Form2.ABSTable2.Open;
    if scelta=False then
      begin
       ATL:= dbgrd72.Fields[0].AsInteger;//CODATL dal campo 0 della tabella di cui ho cliccato una colonna
      end else ATL:=AbsQuery72.FieldByName('CODATL').AsInteger; //prende ATL dalla scelta

      if Form2.ABSTable2.RecordCount >0 then
         RecT2:=Form2.ABSTable2.Locate('CODATL',ATL,[]) else
           begin
             ShowMessage('La tabella degli Atleti è vuota.');
             Exit;
           end;
      if RecT2=False then
        begin
          ShowMessage('Errore Imprevisto: l''Atleta non esiste nel DataBase - Controlla');
          Exit;
        end;
      Cogn:= Form2.ABSTable2.FieldByName('COGNOME').AsString;
      Nom:= Form2.ABSTable2.FieldByName('NOME').AsString;

      if rb1.Checked=True then //automatica
        begin
           if MessageDlg('Confermi l''iscrizione automatica ?',
              mtconfirmation, [mbYes,mbNo], 0) = mrYes then
                begin
                   if cbb74.ItemIndex=-1 then  //Att. cbb.Text='xx' funge dopo una scelta
                     begin
                      ShowMessage('Scegli il Gruppo di iscrizione');
                      Exit;
                     end;
                end;
      //SCELTA AUTOMATICA dopo la scelta della Gara e del Gruppo
          if MessageDlg('Confermi l''iscrizione AUTOMATICA di '+Nom+ ' '+ Cogn+
             ' alle discipline del gruppo '+cbb74.Text,
             mtconfirmation, [mbYes,mbNo], 0) = mrNo then
           begin
             Button2.Click;
             Exit;
           end else
           begin
             if cbb74.Text='Base' then
              begin
                Sorge:=Form2.ABSTable10;
                Sorge.Open;
              end;

             if cbb74.Text='GruppoA' then
              begin
                Sorge:=Form2.ABSTable11;
                Sorge.Open;
              end;

             if cbb74.Text='GruppoB' then
              begin
                Sorge:=Form2.ABSTable12;
                Sorge.Open;
              end;
               //CONTROLLO CATEGORIA
              if Edit4.Text='' then
                begin
                  ShowMessage(' Inserisci la Categoria');
                  Exit;
                end;
             //Verifica se esiste già l'iscrizione
               Sorge.First;
             while not Sorge.Eof do
              begin
                n:=Sorge.FieldByName('CODDSPL').AsInteger;
                trovato:=Form2.ABSTable7.Locate('CODGA;CODDSPL;CODATL',VarArrayOf([Edit1.Text,IntToStr(n),IntToStr(ATL)]),[]);
                if trovato=True then
                  begin
                   ShowMessage('ATTENZIONE ! - Questo Atleta risulta già iscritto '
                   +#13+'ad una o più gare del Gruppo. Non è consentita l''iscrizione automatica');
                   Exit;
                  end;
               Sorge.Next;
              end;

             //Carica il nuovo record
               Sorge.First;
               while not Sorge.EOF do  // Modo corretto di loop EOF
             begin
              Form2.ABSTable7.Insert;
              Form2.ABSTable7.FieldByName('CODGA').AsInteger:=StrToInt(Edit1.Text);
              Form2.ABSTable7.FieldByName('CODDSPL').AsInteger:=Sorge.FieldByName('CODDSPL').AsInteger;
              Form2.ABSTable7.FieldByName('CODATL').AsInteger:= ATL;
              Form2.ABSTable7.FieldByName('COGNOME').AsString:=Cogn;
              Form2.ABSTable7.FieldByName('NMPET').AsInteger:=0;
              Form2.ABSTable7.FieldByName('NMPOS').AsInteger:=0;
              Form2.ABSTable7.FieldByName('TAME1').AsDateTime:=StrToTime('00:00:00');
              Form2.ABSTable7.FieldByName('TBME2').AsDateTime:=StrToTime('00:00:00');
              Form2.ABSTable7.FieldByName('DQ').AsBoolean:=False;
              Form2.ABSTable7.FieldByName('PEN').AsDateTime:=StrToTime('00:00:00,000');
              Form2.ABSTable7.FieldByName('MANL').AsBoolean:=False;
              Form2.ABSTable7.FieldByName('CAT').AsInteger:=StrToInt(Edit4.Text);
              Form2.ABSTable7.Post;
               Sorge.Next;
             end;
             Button5.Click;
           end;                   //Iscrizione automatica terminata
        end;

       //SCELTA MANUALE

       if (rb2.Checked=True) and (Edit2.Text<>'') then   //verifica se già inserito
         begin
             ds7.DataSet:=ABSQuery7;
             with AbsQuery7 do
           begin
             Close;  //cerca i doppioni
             SQL.Text := 'Select * from Gara where CODATL = '+ QuotedStr(IntToStr(ATL))+
             ' AND CODDSPL = '+QuotedStr(Edit2.Text);
             ExecSql;
             Open;
             volte:=AbsQuery7.RecordCount;
               if volte>0 then
                 begin
                   ShowMessage(Nom+' '+Cogn+' è già iscritto '+IntToStr(volte)+' volte a questa disciplina');
                   Button5.Click;
                   Form2.ABSTable2.First;
                   Exit;
                 end;
           end;
            if Edit4.Text='' then
                begin
                  ShowMessage(' Inserisci la Categoria');
                  Exit;
                end;
            if MessageDlg('Confermi l''iscrizione di '+Nom+ ' '+ Cogn,
               mtconfirmation, [mbYes,mbNo], 0) = mrYes then
              begin
                Form2.ABSTable7.Insert;
                Form2.ABSTable7.FieldByName('CODATL').AsInteger:=ATL;
                Form2.ABSTable7.FieldByName('CODGA').AsInteger:= StrToInt(Edit1.Text);
                Form2.ABSTable7.FieldByName('CODDSPL').AsInteger:=StrToInt(Edit2.Text);
                Form2.ABSTable7.FieldByName('COGNOME').AsString:= Cogn;
                Form2.ABSTable7.FieldByName('NMPET').AsInteger:=0;
                Form2.ABSTable7.FieldByName('NMPOS').AsInteger:=0;
                Form2.ABSTable7.FieldByName('TAME1').AsDateTime:=StrToTime('00:00:00');
                Form2.ABSTable7.FieldByName('TBME2').AsDateTime:=StrToTime('00:00:00');
                Form2.ABSTable7.FieldByName('DQ').AsBoolean:=False;
                Form2.ABSTable7.FieldByName('PEN').AsDateTime:=StrToTime('00:00:00,000');
                Form2.ABSTable7.FieldByName('MANL').AsBoolean:=False;
                Form2.ABSTable7.FieldByName('CAT').AsInteger:=StrToInt(Edit4.Text);
                Form2.ABSTable7.Post;
                Button5.Click;          //per ripristinare l'evento si ds72
                Form2.ABSTable2.First;
                inserisco7:=False;
              end else Exit;
         end else
                if rb2.Checked=True then
                begin
                  ShowMessage('Iscrizione manuale, indica prima il codice disciplina ');
                  Button2.Click;
                   exit;
                end;
   end else
         begin
             ShowMessage('Inserisci il Codice della Gara.');
             Exit;
          end;
end;

                 //INSERISCE I Tempi(da unit Tempi)
procedure TForm6.dbgrd7CellClick(Column: TColumn);
begin
   if inserisco7=True then Exit;

   if tempo='' then
     begin
       ShowMessage('Il valore da inserire è nullo');
       Exit;
     end;
   ABSTable14.Edit;
   TDateTimeField(ABSTable14.FieldByName('TAME1')).DisplayFormat:='nn:ss,zzz';
   TDateTimeField(ABSTable14.FieldByName('TBME2')).DisplayFormat:='nn:ss,zzz';
   if (rab1 = True) then
    begin
      if ABSTable14.FieldByName('TAME1').AsDateTime<>0 then
         if MessageDlg('Esiste già un dato, vuoi sostituirlo ?',
            mtconfirmation, [mbYes,mbNo], 0,mbNo) = mrNo then Exit;
      ABSTable14.FieldByName('TAME1').AsDateTime:=StrToTime(tempo);
    end;
   if (rab2 = True) then
    begin
      if ABSTable14.FieldByName('TAME1').AsDateTime<>0 then
         if MessageDlg('Esiste già un dato, vuoi sostituirlo ?',
            mtconfirmation, [mbYes,mbNo], 0,mbNo) = mrNo then Exit;
      ABSTable14.FieldByName('TBME2').AsDateTime:=StrToTime(tempo);
    end;
   ABSTable14.Post;
   tempo:='';
    //trucco per poter fire l'onclick sulla stessa riga due volte
   Form6.dbgrd7.SelectedField:=ABSTable14.FieldByName('NM');
end;


// Ricerca per cognome

         // seleziona una lettera dalla combobox per poi inserire l'atleta
procedure TForm6.cbb72Select(Sender: TObject);
var
c:string;
begin
   if Edit1.Text<>'' then
  begin
         c:=cbb72.Items[cbb72.ItemIndex]; //estrae la scelta dalla combobox
         scelta:=True; //scelta fatta per cognome
         ds72.DataSet:=AbsQuery72;
    with AbsQuery72 do
      begin
        Close;  //inserisce una variabile nel query selezionandola per primo carattere
        SQL.Text := 'Select * from AnaAtl where substring(COGNOME,1,1) = '+ QuotedStr(c);
        ExecSql;
        Open;
        cbb72.ItemIndex:=-1;
     end;
  end else
        begin
             cbb72.ItemIndex:=-1;   //riporta la combobox all'inizio
             ShowMessage('Inserisci il Codice della Gara');
             Exit;
        end;
end;

procedure TForm6.cbb74Change(Sender: TObject);  //SCEGLIE IL GRUPPO
var //realizza per ogni gruppo scelto una tabella delle DSPL per quella gara
dsplSi:Boolean;
DSPLn:Integer;
baseSi:Boolean;
begin
   Form2.ABSTable6.Open;
   Form2.ABSTable10.TableName:='repBase';
   Form2.ABSTable10.Open;
   Form2.ABSTable10.Edit;
   Form2.ABSTable11.TableName:='repGRPA';
   Form2.ABSTable11.Open;
   Form2.ABSTable11.Edit;
   Form2.ABSTable12.TableName:='repGRPB';
   Form2.ABSTable12.Open;
   Form2.ABSTable12.Edit;
  if Edit1.Text<>'' then
   begin
      if cbb74.Text='Base' then    // GRUPPO BASE
    begin
         if Form2.ABSTable6.RecordCount>0 then //Controlla se per la Gara scelta l'accoppiamento di Base
          begin                                // esiste già
              baseSi:= Form2.ABSTable6.Locate('CODGA',strToInt(Edit1.Text),[]); //Verifica l'esistenza
              if baseSi=True then              //del codice della Gara negli accoppiamenti di Base
                begin
                  if MessageDlg('Il Gruppo delle discipline Base di questa Gara'+#13+
                  'è già stato creato.  Vuoi rifarlo ?', mtconfirmation, [mbYes,mbNo], 0,mbNo) = mrYes then
                    begin
                      ShowMessage('Esci dalla Sezione Gara Corrente e lancia Anagrafica Gare'+#13+
                      'per rifare gli accoppiamenti Gruppo Base');
                      Exit;
                    end;
                end else
                begin
                    ShowMessage('Esci dalla Sezione Gara Corrente e lancia Anagrafica Gare'+#13+
                      'per definire gli accoppiamenti Gruppo Base');
                    Exit;
                end;
                  
          end;
         Form2.ABSTable10.Close;
         Form2.ABSTable10.EmptyTable;
         ds74.DataSet :=  ABSQuery74; //Costruisce una tabella SQL isolando solo le discipline
         with ABSQuery74 do           // del Gruppo Base di quella Gara
       begin
              Close;  //estrae le discipline relative alla gara ed al Gruppo Base
              SQL.Text := 'Select * from Base where CODGA = '+QuotedStr(edit1.Text);
              ExecSql;
              Open;   //la Tabella è formata da tutti i codici disciplina della Base
              First;
              Form2.ABSTable10.Open;
              Form2.ABSTable10.Edit;
              Form2.ABSTable4.Open;
              while(not Eof)do  //Crea le tabelle complete delle discipline per quel Gruppo
           begin
              DSPLn:=dbgrd74.Columns[0].Field.AsInteger; //preleva il cod della DSPL
              dsplSi:= Form2.ABSTable4.Locate('CODDSPL',DSPLn,[]); // usa il cod per localizzare il record di ABS/4
               if dsplSi=True then
                 begin
                  Form2.ABSTable10.Insert;     //Costruisce la tabella completa delle discipline
                  Form2.ABSTable10.FieldByName('CODDSPL').AsInteger:=Form2.ABSTable4.FieldByName('CODDSPL').AsInteger;
                  Form2.ABSTable10.FieldByName('DESCR').AsString:=Form2.ABSTable4.FieldByName('DESCR').AsString;
                  Form2.ABSTable10.FieldByName('TMAX').AsDateTime:=Form2.ABSTable4.FieldByName('TMAX').AsDateTime;
                  Form2.ABSTable10.Post
                 end else
                      begin
                        ShowMessage('Attenzione ! Manca questo Codice dalla Tabella delle Discipline : '
                        + IntToStr(DSPLn));
                        Exit;
                      end;
              Next;
           end;

         ds74.DataSet:=Form2.ABSTable10;
       end;

         ShowMessage('La tabella mostra le discipline del Gruppo Base'+#13+
         ' per la Gara indicata.');
    end;

      if cbb74.Text='GruppoA' then
    begin
         Form2.ABSTable8.Open;
         if Form2.ABSTable8.RecordCount>0 then //Controlla se per la Gara scelta l'accoppiamento di GruppoA
          begin                                // esiste già
              baseSi:= Form2.ABSTable8.Locate('CODGA',strToInt(Edit1.Text),[]); //Verifica l'esistenza
              if baseSi=True then        //del codice della Gara negli accoppiamenti di Base
                begin
                   if MessageDlg('Il Gruppo A delle discipline di questa Gara'+#13+
                  'è già stato creato.  Vuoi rifarlo ?', mtconfirmation, [mbYes,mbNo], 0,mbNo) = mrYes then
                    begin
                      ShowMessage('Esci dalla Sezione Gara Corrente e lancia Anagrafica Gare'+#13+
                      'per rifare gli accoppiamenti del Gruppo A');
                      Exit;
                    end;
                end else
                begin
                   ShowMessage('Esci dalla Sezione Gara Corrente e lancia Anagrafica Gare'+#13+
                      'per definire gli accoppiamenti Gruppo A');
                    Exit;
                end;
                  
          end;
         Form2.ABSTable11.Close;
         Form2.ABSTable11.EmptyTable;
         ds74.DataSet :=  ABSQuery74; //Costruisce una tabella SQL isolando solo le discipline
         with ABSQuery74 do           // del Gruppo A di quella Gara
       begin
              Close;  //estrae le discipline relative alla gara ed al Gruppo A
              SQL.Text := 'Select * from GRPA where CODGA = '+QuotedStr(edit1.Text);
              ExecSql;
              Open;   //la Tabella è formata da tutti i codici disciplina della Base
              First;
              Form2.ABSTable11.Open;
              Form2.ABSTable11.Edit;
              while(not Eof)do  //Crea le tabelle complete delle discipline per quel Gruppo
           begin
              DSPLn:=dbgrd74.Columns[0].Field.AsInteger; //preleva il cod della DSPL
              dsplSi:= Form2.ABSTable4.Locate('CODDSPL',DSPLn,[]); // usa il cod per localizzare il record di ABS/4
               if dsplSi=True then
                 begin
                  Form2.ABSTable11.Insert;     //Costruisce la tabella completa delle discipline
                  Form2.ABSTable11.FieldByName('CODDSPL').AsInteger:=Form2.ABSTable4.FieldByName('CODDSPL').AsInteger;
                  Form2.ABSTable11.FieldByName('DESCR').AsString:=Form2.ABSTable4.FieldByName('DESCR').AsString;
                  Form2.ABSTable11.FieldByName('TMAX').AsDateTime:=Form2.ABSTable4.FieldByName('TMAX').AsDateTime;
                  Form2.ABSTable11.Post
                 end else
                      begin
                        ShowMessage('Attenzione ! Manca questo Codice dalla Tabella delle Discipline : '
                        + IntToStr(DSPLn));
                        Exit;
                      end;
              Next;
           end;

         ds74.DataSet:=Form2.ABSTable11;
       end;

         ShowMessage('La tabella mostra le discipline del Gruppo A');
    end;

      if cbb74.Text='GruppoB' then
    begin
            Form2.ABSTable9.Open;
         if Form2.ABSTable9.RecordCount>0 then //Controlla se per la Gara scelta l'accoppiamento di Gruppo B
          begin                                // esiste già
              baseSi:= Form2.ABSTable9.Locate('CODGA',strToInt(Edit1.Text),[]); //Verifica l'esistenza
              if baseSi=True then     //del codice della Gara negli accoppiamenti di Base
                begin
                   if MessageDlg('Il Gruppo B delle discipline di questa Gara'+#13+
                  'è già stato creato.  Vuoi rifarlo ?', mtconfirmation, [mbYes,mbNo], 0,mbNo) = mrYes then
                    begin
                       ShowMessage('Esci dalla Sezione Gara Corrente e lancia Anagrafica Gare'+#13+
                      'per rifare gli accoppiamenti del Gruppo B');
                       Exit ;
                    end;
                end else
                begin
                   ShowMessage('Esci dalla Sezione Gara Corrente e lancia Anagrafica Gare'+#13+
                      'per definire gli accoppiamenti del Gruppo B');
                    Exit ;
                end;
          end;
         Form2.ABSTable12.Close;
         Form2.ABSTable12.EmptyTable;
         ds74.DataSet :=  ABSQuery74; //Costruisce una tabella SQL isolando solo le discipline
         with ABSQuery74 do           // del Gruppo B di quella Gara
           begin
              Close;  //estrae le discipline relative alla gara ed al Gruppo B
              SQL.Text := 'Select * from GRPB where CODGA = '+QuotedStr(edit1.Text);
              ExecSql;
              Open;   //la Tabella è formata da tutti i codici disciplina della Base
              First;
              Form2.ABSTable12.Open;
              Form2.ABSTable12.Edit;
              while(not Eof)do  //Crea le tabelle complete delle discipline per quel Gruppo
           begin
              DSPLn:=dbgrd74.Columns[0].Field.AsInteger; //preleva il cod della DSPL
              dsplSi:= Form2.ABSTable4.Locate('CODDSPL',DSPLn,[]); // usa il cod per localizzare il record di ABS/4
               if dsplSi=True then
                 begin
                  Form2.ABSTable12.Insert;     //Costruisce la tabella completa delle discipline
                  Form2.ABSTable12.FieldByName('CODDSPL').AsInteger:=Form2.ABSTable4.FieldByName('CODDSPL').AsInteger;
                  Form2.ABSTable12.FieldByName('DESCR').AsString:=Form2.ABSTable4.FieldByName('DESCR').AsString;
                  Form2.ABSTable12.FieldByName('TMAX').AsDateTime:=Form2.ABSTable4.FieldByName('TMAX').AsDateTime;
                  Form2.ABSTable12.Post
                 end else
                      begin
                        ShowMessage('Attenzione ! Manca questo Codice dalla Tabella delle Discipline : '
                        + IntToStr(DSPLn));
                        Exit;
                      end;
              Next;
           end;

         ds74.DataSet:=Form2.ABSTable12;
       end;
         ShowMessage('La tabella mostra le discipline del Gruppo B');
    end;
  end else
    begin
       ShowMessage('Inserisci il Codice della Gara ');
       cbb74.ItemIndex:=0;
       Exit;
    end;;
end;                                    //NAVIGATORE iscrizioni

procedure TForm6.dbnvgr7Click(Sender: TObject; Button: TNavigateBtn);
begin
      case button of
       nbInsert:    //se inserisce un nuovo record
      begin
       if (Edit1.Text='') OR (Edit2.Text='') then
        begin
          ShowMessage('Inserisci il Codice della Gara e/o della Disciplina');
          Exit;
        end;
       Form2.ABSTable7.Last;
       Form2.ABSTable7.Append;
       inserisco7:=True; //inserisce il flag nel nuovo record
       dbgrd7.SetFocus;
       DBGrd7.SelectedField := Form2.ABSTable7.FieldByName('CODATL');
      end;
       nbPost:
      begin   //se lo carica nella tabella
       inserisco7:=False ;
      end;
       nbDelete: //se cancella il record - serve anche per evitare di entrare in Query
      begin
       inserisco7:=False;
      end;
       nbEdit:
       inserisco7:=True;
     end;
end;

procedure TForm6.Edit1Change(Sender: TObject);
begin
   if rb1.Checked = True then
       cbb74.ItemIndex:=0;
end;

end.


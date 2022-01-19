unit Unit1;     //HELPDESK versione 2.3.3.33 prerelease

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ABSMain, DB, ExtCtrls, DBCtrls,Unit2, StdCtrls, Mask,
  ShellApi,ComObj,clipbrd,Printers,Vcl.HtmlHelpViewer,System.UITypes;

type
  TForm1 = class(TForm)
    ABSTable1: TABSTable;
    ABSTable2: TABSTable;
    ABSDatabase1: TABSDatabase;
    DBGrid1: TDBGrid;
    DBGrid3: TDBGrid;
    ABSTable3: TABSTable;
    DBNavigator1: TDBNavigator;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Button3: TButton;
    Shape5: TShape;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label3: TLabel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    ABSTable4: TABSTable;
    DBGrid4: TDBGrid;
    DataSource4: TDataSource;
    Button8: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Button9: TButton;
    Shape6: TShape;
    Timer1: TTimer;
    Timer2: TTimer;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Bevel1: TBevel;
    Button13: TButton;
    Button14: TButton;
    Memo1: TMemo;
    Button15: TButton;
    PrintDialog1: TPrintDialog;
    Button16: TButton;
    FontDialog1: TFontDialog;
    Label6: TLabel;
    DBGrid2: TDBGrid;
    Button17: TButton;
    Button18: TButton;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ABSTable1AfterInsert(DataSet: TDataSet);
    procedure ABSTable1AfterPost(DataSet: TDataSet);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid3DblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure DBGrid4CellClick(Column: TColumn);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure ABSTable1BeforeInsert(DataSet: TDataSet);
    procedure ABSTable1BeforeDelete(DataSet: TDataSet);
    procedure ABSTable1AfterDelete(DataSet: TDataSet);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure ABSTable1BeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ABSTable1NewRecord(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form1: TForm1;
  Form2 :TForm2;
  Flag,Flag1:Boolean;
  filtro:String;
  chi:array[1..4] of string;
  numB:LargeInt=0;
  MemoOut:TextFile;
  STRList:TstringList;
  numeratore :largeint;
  test:string;      //da eliminare
  colorata,salvato:boolean;

implementation

{$R *.dfm}
procedure TForm1.FormCreate(Sender: TObject);  //INIZIO
     var
     giorno:TDateTime;
     numTB4:largeInt;
begin
Application.HelpFile:='helpdesk.chm';
ABSDatabase1.DatabaseFileName:=ExtractFilePath(Application.ExeName)+'HelpDesk.ABS';
ABSDatabase1.Open;
ABSTable1.TableName:='HD1';
ABSTable2.TableName:='How';
ABSTable3.TableName:='Tag1';
ABSTable4.TableName:='Ticket';
ABSTable1.Open;
ABSTable2.Open;
ABSTable3.Open;
ABSTable4.Open;
Flag:=False;     //indica con True un record immesso e non postato
Flag1:=False;    //indica con True che nel Memo c'è del testo selezionato
colorata:=False;
salvato:=False;
//carica il numeratore
       if (ABSTable1.RecordCount=0) then
        numeratore:=0 else
            begin
if ABSTable1.FindLast=True then
numeratore:=ABSTable1.FieldByName('Num').AsLargeInt else
showmessage(' Error on record code');
            end;

//verifica di ticket per confermare il blinking
if ABSTable4.Locate('todo',True,[loCaseInsensitive])=True then
          begin
           Timer1.Enabled:=True;
           shape6.Brush.Color:=clRed;
          end;
//verifica dell'esistenza di uno o più ticket per la data odierna
       giorno :=now;
       ABSTable4.Filter:='todo=True'+' AND '+'taskdate <= '+ quotedStr(datetostr(giorno));
       ABSTable4.Filtered:=True;
       if ABSTable4.isEmpty = False then
       showmessage('Attention: ticket for today or expired !') else
       ABSTable4.Filtered:=False;

//controllo numeratore
      If  ABSTable1.RecordCount <> ABSTable4.RecordCount then
         begin
                ABSTable4.First;
                while not ABSTAble4.Eof do
                begin
                  numTB4:=ABSTable4.FieldByName('Num').AsLargeInt;
                      if ABSTable1.Locate('num',numTB4,[loCaseInsensitive])=False then
                      ABSTAble4.Delete;
                  ABSTable4.Next;
                end;
         end;


end;
      //messo edit in form.show per evitare l'eccezione non essendo ancora il form creato
     // portato il focus di nuovo al primo campo per consentire eventuali modifiche di data
procedure TForm1.FormShow(Sender: TObject);
begin
      ABSTable1.Edit;
      DBGrid1.SetFocus;
      DBGrid1.SelectedField := ABSTable1.FieldByName('Filed');
end;

//triggera il flag
procedure TForm1.ABSTable1AfterDelete(Dataset: TDataSet);
begin
    if ABSTable4.Locate('num',numB,[])= false then
    begin
    showmessage('Error: linked code number on ticket table MISSING ');
    end else
    ABSTable4.Delete;
    Salvato:=False;
end;
          //inserisce il tempo
procedure TForm1.ABSTable1AfterInsert(DataSet: TDataSet);
var
forma :string;
begin
        Flag:=True;
        Salvato:=False;
        DateTimeToString(forma,'t',time);
        ABSTable1.FieldByName('when').AsString:=forma;
end;
                                            //controlla il post
procedure TForm1.ABSTable1AfterPost(DataSet: TDataSet);
var                           //carica il record nella tabella 1

s1,s2:string;
numA:LargeInt;
begin
s1:=ABSTable1.FieldByName('Status').AsString;
s2:=ABSTable1.FieldByName('Tag').AsString;
      if (pos(' ',s1)>0) OR(pos(' ',s2)>0) then
      begin           //se il tag è di più parole cancella ed esce
      showmessage(' Tag fields must contain only one word and no spacing. Redo !');
      ABSTable1.Delete;
      ABSTable1.Refresh;
      if flag1=False then    //non c'è del testo selezionato
      ABSTable1.First;
      exit;
      end;
        flag:=false;     //resetta il flag avendo postato il record

      if ABSTable2.Locate('Status',s1,[loCaseInsensitive])= false then
       begin        //copia Status e tag nelle table secondarie se unici
         ABSTable2.insert;
         ABSTable2.FieldByName('Status').AsString:=s1;
         ABSTable2.Post;
         ABSTable2.First;
       end;
       if ABSTable3.Locate('tag',s2,[loCaseInsensitive])= false then
       begin        //copia Status e tag nelle table secondarie se unici
         ABSTable3.insert;
         ABSTable3.FieldByName('tag').AsString:=s2;
         ABSTable3.Post;
         ABSTable3.First;
       end;
        //creare il record su Ticket se non già esistente
        numA:= ABSTable1.FieldByName('Num').AsLargeInt;
        if ABSTable4.Locate('num',numA,[])=False then
                   begin
        ABSTable4.Insert;
        ABSTable4.FieldByName('num').AsLargeInt:=numA;
        ABSTable4.Post;
                   end;
          if Flag1=False then
          ABSTable1.First;
        salvato:=True;
        showmessage('Record posted');
end;


procedure TForm1.ABSTable1BeforeDelete(DataSet: TDataSet);
begin
     numB:=ABSTable1.FieldByName('Num').AsLargeInt;
end;
                               //setta il numeratore
procedure TForm1.ABSTable1BeforeInsert(DataSet: TDataSet);
begin
        if ABSTable1.RecordCount=0 then
        numeratore:=0 else
                    begin
        if ABSTable1.FindLast=True then
        numeratore:=ABSTable1.FieldByName('Num').AsLargeInt else
        showmessage(' Error on record code, please check');
                    end;
        ABSTable1.First;
end;
                          //  assegna il Num , con il numeratore
procedure TForm1.ABSTable1BeforePost(DataSet: TDataSet);
begin
        if ABSTable1.FieldByName('num').AsString='' then
                 begin
        numeratore := numeratore+1;
        ABSTable1.FieldByName('Num').AsLargeInt:=numeratore;
         if ABSTable4.Locate('num',numeratore,[])=False then
                   begin
        ABSTable4.Insert;
        ABSTable4.FieldByName('num').AsLargeInt:=numeratore;
        ABSTable4.Post;
                   end else
                        begin
        showmessage('Error: duplicate code on ticket board, check !')
                        end;
                 end;
end;
                           // al nuovo record mette il fuoco al what
procedure TForm1.ABSTable1NewRecord(DataSet: TDataSet);
begin
   DBGrid1.SetFocus;
   DBGrid1.SelectedField := ABSTable1.FieldByName('What');
end;

procedure TForm1.Button1Click(Sender: TObject);  //filtro status
begin
     edit3.Text:=ABSTable2.FieldByName('Status').AsString;
     Shape3.Brush.Color := clRed;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
      edit4.Text:=ABSTable3.FieldByName('tag').AsString;
      Shape4.Brush.Color := clRed;
end;

procedure TForm1.Button3Click(Sender: TObject); //Run FILTER
var
conta:smallint;

begin
    if (edit1.Text ='')AND(edit2.Text='')AND(edit3.Text='')AND(edit4.Text='') then
     begin
       showmessage('No filter has been set, redo');
       exit;
     end;

    Shape5.Brush.Color := clRed;
    conta:=0;
    if edit1.Text<>'' then
      begin
      conta:=conta+1;
      chi[conta]:=  'Filed = '+QuotedStr(edit1.Text);
      end;

    if edit2.Text<>'' then
      begin
      conta:=conta+1;
      chi[conta]:=  'What LIKE ' + QuotedStr('%'+ (edit2.Text)+'%');
      end;

    if edit3.Text<>'' then
      begin
      conta:=conta+1;
      chi[conta]:=  'Status ='+QuotedStr(edit3.Text);
      end;

    if edit4.Text<>'' then
      begin
      conta:=conta+1;
      chi[conta]:=  'Tag ='+QuotedStr(edit4.Text);
      end;
    { a questo punto ho conta da 1 a 4  a seconda nel numero di campi da filtrare
    e l'array di stringhe corrispondenti}

    case conta of
      1: filtro:= chi[1];
      2: filtro:= chi[1] +' AND '+ chi[2];
      3: filtro:= chi[1] +' AND '+ chi[2] +' AND '+ chi[3];
      4: filtro:= chi[1] +' AND '+ chi[2] +' AND '+ chi[3] +' AND '+ chi[4];
    end;

            ABSTable1.FilterOptions:= [foCaseInsensitive];
            ABSTable1.Filter:=filtro;
            ABSTable1.Filtered:=True;

end;

procedure TForm1.Button4Click(Sender: TObject); //clear filter
var
i:smallint;

begin
     edit1.Text:='';
     edit2.Text:='';
     edit3.Text:='';
     edit4.Text:='';
     Shape1.Brush.Color := clLime;
     Shape2.Brush.Color := clLime;
     Shape3.Brush.Color := clLime;
     Shape4.Brush.Color := clLime;
     Shape5.Brush.Color := clLime;
     for i := 1 to 4 do
       chi[i]:='';
     ABSTable1.Filtered:= False;
     filtro:='';

end;

procedure TForm1.Button5Click(Sender: TObject);  //Delete record
begin
  if MessageDlg('Delete selected record ?',mtConfirmation,mbYesNo,0)=mrYes then
        begin
  ABSTable1.Delete;
  ABSTable1.Refresh;
  ABSTable1.First;
  Flag:=False;
  Flag1:=False;
        end;
end;

procedure TForm1.Button6Click(Sender: TObject);  //invio email con testo selezionato

 var
   strEmail, strSubject, strBody, Param: string;
   cnt,kk:smallint;
 begin
  if Flag1=False then
  begin
    showmessage('No memo text selected to send by email, pls redo.');
    exit;
  end;
   strbody:='';
   cnt:=STRList.Count-1;
   strEmail := 'user@host.com';
   strSubject := 'Your Subject';
   for kk := 0 to cnt do
   strbody := strbody +STRList[kk]+'%0D%0A';
  Param := 'mailto:' + strEmail + '?subject=' + strSubject +
          '&Body=' + strBody;

    ShellExecute(Form1.Handle, 'open', PChar(Param), nil, nil, SW_SHOWNORMAL);
    ABSTable1.Edit;
    Unit2.Form2.DBRichEdit1.Text:= Unit2.Form2.DBRichEdit1.Text+ sLineBreak+'## Email sent ##-:'+ DateTimeToStr(now);
    ABSTable1.post;
    Flag1:=False;     //disattiva Flag1 n.b. è attivato nella sua funzione quando
    strlist.Free;                  //c'è del testo selezionato    }
    ABSTable1.first;
 end;



procedure TForm1.Button7Click(Sender: TObject);  //Contacts
var
  application: OleVariant;
  dialog: OleVariant;
  i: Integer;
  recipients: String;
  recipient: OleVariant;
begin
     application := createOleObject( 'Outlook.Application' );

  // Obtain the dialog
  dialog := application.session.getSelectNamesDialog;

  // Only show the a single 'add' field, multiselect
  dialog.setDefaultDisplayMode( 6 ); // 6 = olDefaultDelegates

  // Display the dialog
  dialog.display;

  // Display selection
  recipients := '';
  for i := 1 to dialog.recipients.count do    //crea una 'dialog'
  begin
      recipient := dialog.recipients.item( i );

      recipients := recipients + recipient.name + #13#10;
      Clipboard.AsText:=recipients;
  end;

  showMessage( recipients+ #13#10+ 'Saved on clipboard' );
end;

procedure TForm1.Button8Click(Sender: TObject);  //Set ticket date

begin
           if ABSTable4.FieldByName('taskdate').AsString='' then
                begin
            showmessage('Selected field has no ticket date, redo');
            exit;
                end;
           ABSTable4.Edit;
           ABSTable4.FieldByName('todo').AsBoolean:=True;
           ABSTable4.Post;
           Timer1.Enabled:=True;
           shape6.Brush.Color:=clRed;
           //Timer1Timer(nil);
end;
procedure TForm1.Timer1Timer(Sender: TObject);
begin
       shape6.Brush.Color:=clLime;
        Timer2.Enabled:=True;
        Timer1.Enabled:=False;
end;
procedure TForm1.Timer2Timer(Sender: TObject);
begin
       shape6.Brush.Color:=clRed;
       Timer1.Enabled:=True;
       Timer2.Enabled:=False;
end;
procedure TForm1.Button9Click(Sender: TObject); //Reset ticket date

var
   giorno:TdateTime;
begin
           if ABSTable4.FieldByName('todo').AsBoolean=False then
             begin
               showmessage('No ticket to reset on selected, redo');
               exit;
             end;
              ABSTable4.Edit;
              ABSTable4.FieldByName('taskdate').AsString:='';
              ABSTable4.FieldByName('todo').AsBoolean:=False;
                   if ABSTable4.filtered=True then
                             ABSTable4.Filtered:=False;

                   if ABSTable4.Locate('todo',True,[loCaseInsensitive])=False then
                                  begin       //se non ci sono altri record set
                             shape6.Brush.Color:=clLime;
                             Timer1.Enabled:=False;
                             Timer2.Enabled:=False;
                                  end;
                   if colorata=True then colorata:=False ;

            //verifica dell'esistenza di uno o più ticket per la data odierna
       giorno :=now;
       ABSTable4.Filter:='todo=True'+' AND '+'taskdate <= '+ quotedStr(datetostr(giorno));
       ABSTable4.Filtered:=True;
       if ABSTable4.isEmpty = False then
       showmessage('Attention: ticket for today or expired !') else
       ABSTable4.Filtered:=False;

end;
                                          //Filter Table4 mostra tutte le date

procedure TForm1.Button10Click(Sender: TObject);
begin
            ABSTable4.FilterOptions:= [foCaseInsensitive];
            ABSTable4.Filter:='todo=True';
            ABSTable4.Filtered:=True;
end;

procedure TForm1.Button11Click(Sender: TObject); //Clear Table4 filter
var
                giorno:TDateTime;
begin
            ABSTable4.Filtered:= False;
            if colorata=True then colorata:=False ;

       //verifica dell'esistenza di uno o più ticket per la data odierna
       giorno :=now;
       ABSTable4.Filter:='todo=True'+' AND '+'taskdate <= '+ quotedStr(datetostr(giorno));
       ABSTable4.Filtered:=True;
       if ABSTable4.isEmpty = False then
       showmessage('Attention: ticket for today or expired !') else
       ABSTable4.Filtered:=False;
end;

  //Action : Filter on main grid the record for ticket followup

procedure TForm1.Button12Click(Sender: TObject);

var
codice:integer;

begin
       if ABSTable4.FieldByName('todo').AsBoolean=False then
             begin
               showmessage('No ticket set on selected record, redo');
               exit;
             end;
       //filtra il record per successive azioni
       codice:=ABSTable4.FieldByName('num').AsInteger;
       ABSTable1.Filter:='num ='+ quotedstr(inttostr(codice));
       ABSTable1.Filtered:=True;

       colorata:=True;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
        if MessageDlg('Delete selected record ?',mtConfirmation,mbYesNo,0)=mrYes then
             begin
             ABSTable2.Delete;
             ABSTable2.Refresh;
             ABSTable2.First;
             end;
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
          if MessageDlg('Delete selected record ?',mtConfirmation,mbYesNo,0)=mrYes then
              begin
              ABSTable3.Delete;
              ABSTable3.Refresh;
              ABSTable3.First;
              end;
end;

procedure TForm1.Button15Click(Sender: TObject);    //Report
var
testo,testo1:string;
begin
     memo1.Text:='';
     testo:= ABSTable1.FieldByName('what').AsString;
     memo1.SelStart:=0;
     memo1.Text:='  Report issued on '+ datetimetostr(Now);
     memo1.Lines.Add('  #Status : '+ABSTable1.FieldByName('Status').AsString);
     memo1.Lines.Add('  #Tag     : '+ABSTable1.FieldByName('Tag').AsString );
     memo1.Lines.Add('  # WHAT');
     memo1.Lines.Add(testo);
     memo1.lines.Add('  # FOLLOW UP');
     testo1:= ABSTable1.FieldByName('More').AsString;
     memo1.Lines.add(testo1);
     memo1.SelectAll;
     memo1.CopyToClipboard;
     showmessage('A text report, for selected record, has been copied to the Clipboard.');
     exit;
end;


procedure TForm1.Button16Click(Sender: TObject);        //Print
  Var
  printdialog:TprintDialog;
  ka:integer;
begin
  printdialog := TPrintDialog.Create(Form1);
              if printdialog.execute then
              begin
     AssignPrn(MemoOut);
     Rewrite(MemoOut);
     Printer.Canvas.Font:=Memo1.Font;
     Printer.Canvas.TextOut(20,20,'Page width= '+intToStr(Printer.PageWidth));
     Printer.Canvas.TextOut(20,150,'Page eight = '+intToStr(Printer.PageHeight));
     for ka := 0 to Memo1.Lines.count-1 do
       writeLn(MemoOut,Memo1.Lines[ka]);
     CloseFile(MemoOut);
              end;
end;

procedure TForm1.Button17Click(Sender: TObject);   //Done
begin
if ((ABSTable1.FieldByName('Tag').AsString<>'') OR (ABSTable1.FieldByName('What').AsString<>''))AND(salvato=False)then
  begin
        if MessageDlg('  Any record to post ?'+#13#10+'Yes to post, No to exit',
        mtconfirmation, [mbYes,mbNo], 0) = mrNo then
      begin
      if ((ABSTable1.FieldByName('Tag').AsString='') OR (ABSTable1.FieldByName('What').AsString='')) then
                 begin
        ABSTable1.Delete;
        salvato:=False;
        Flag:=False;
        Application.Terminate;
                 end else
                 begin
                 Flag:=False;
                 Halt;
                 end;
      end else
        if (ABSTable1.FieldByName('Tag').AsString='') OR (ABSTable1.FieldByName('What').AsString='')then
         begin
            showmessage('Record data to be completed !');
            exit;
         end;
        if (ABSTable1.FieldByName('Tag').AsString<>'') AND (ABSTable1.FieldByName('What').AsString<>'')then
            ABSTable1.Post;
  end else
  if (salvato=True)or (ABSTable1.RecordCount=0) then Application.Terminate;


end;

procedure TForm1.Button18Click(Sender: TObject);     //Reset All
begin
         if MessageDlg('You are about to clear ALL records, confirm ?',
         mtConfirmation,mbYesNo,0)=mrYes then
              begin
      ABSDatabase1.Close;
      ABSTable1.EmptyTable;
      ABSTable2.EmptyTable;
      ABSTable3.EmptyTable;
      ABSTable4.EmptyTable;
              end;
      ABSDatabase1.Open;
      ABSTable1.TableName:='HD1';
      ABSTable2.TableName:='How';
      ABSTable3.TableName:='Tag1';
      ABSTable4.TableName:='Ticket';
      ABSTable1.Open;
      ABSTable2.Open;
      ABSTable3.Open;
      ABSTable4.Open;
      Flag:=False;     //indica con True un record immesso e non postato
      Flag1:=False;    //indica con True che nel Memo c'è del testo selezionato
      colorata:=False;
      numeratore:=0;
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);  //per porre in edit mode

begin
        ABSTable1.Edit;
        Flag:=True;       // attiva Flag
       if colorata=True then
         begin
        colorata:=False ;
        ABSTable1.Filtered:=False;
         end;
end;

  //colorare una riga del DBGrid
procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    if colorata=True then
    DBGrid1.Canvas.Brush.Color:=clAqua;
    DBGrid1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

//all'inserzione del Tag posta il record
procedure TForm1.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
         if key=#13 then
              begin
                if (ABSTable1.FieldByName('Tag').AsString<>'') AND (ABSTable1.FieldByName('What').AsString<>'')then
                   begin
                ABSTable1.Post;
                   end else
                   begin
                showmessage('Record data to be completed !');
                if ABSTable1.FieldByName('Tag').AsString<>'' then
                           begin
                           DBGrid1.SetFocus;
                           DBGrid1.SelectedField := ABSTable1.FieldByName('What');
                           end else
                                begin
                               DBGrid1.SetFocus;
                               DBGrid1.SelectedField := ABSTable1.FieldByName('Tag');
                                end;
                   end;
              end;

end;

//chiama il campo memo
procedure TForm1.DBGrid1TitleClick(Column: TColumn);

  {per poter indirizzare il controllo DBmemo (nel ns caso DBRichEdit) in modo corretto
  al campo della Table relativa è importante definire le due proprietà:
  #DataField - dove si deve digitare il nome del campo memo, senza apici ne
  virgolette. Es. More
  #DataSource - dove si deve digitare il nome del DataSource relativo alla table
  che contiene il campo memo. Se questo DataSource è in un diverso Form, indicarlo.
  Es. Form1.DataSource1  }

begin
      if (Column.fieldname = 'More') then
   begin
        with TForm2.Create(Application) do
        try
        DBRichEdit1.Text:= ABSTable1.FieldByName('More').AsString;
        ABSTable1.Edit;
        DBRichEdit1.Lines.Add(#13#10+'**'+ DateTimeToStr(now)+#13#10); //posiziona il prompt dopo le linee già scritte
        ShowModal;
        ABSTable1.FieldByName('More').AsString := DBRichEdit1.text;
        finally
        ABSTable1.Post;
        Free;
        end;

        if colorata=True then colorata:=False ;
        ABSTable1.Filtered:=False;

   end;
end;

procedure TForm1.DBGrid2DblClick(Sender: TObject); //per inserire uno status noto
var
st2 :string;
begin
   st2:= ABSTable2.FieldByName('Status').AsString;
   ABSTable1.Edit;
   ABSTable1.FieldByName('Status').AsString:=st2;
end;

procedure TForm1.DBGrid3DblClick(Sender: TObject); //per inserire un tag noto
var
st2 :string;
begin
   st2:= ABSTable3.FieldByName('tag').AsString;
   ABSTable1.Edit;
   ABSTable1.FieldByName('tag').AsString:=st2;
end;
procedure TForm1.DBGrid4CellClick(Column: TColumn); //per mettere in edit mode
begin
   ABSTable4.Edit;
end;

//LED rossi
procedure TForm1.Edit1Change(Sender: TObject);
begin
   Shape1.Brush.Color := clRed;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
   Shape2.Brush.Color := clRed;
end;
                              //pulizia pre chiusura
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
Var
numT1,numT2: largeInt;
begin
   if ABSTable1.RecordCount>0 then
                              begin
   AbsTable1.DisableControls;
      try              //mette num in T4 i mancanti e presenti in T1
  AbsTable1.First; { Go to first record, which sets Eof False }
      while not AbsTable1.Eof do { Cycle until Eof is True }
             begin
   numT1:= ABSTable1.FieldByName('Num').AsLargeInt;
  if ABSTable4.Locate('num',numT1,[])=False then
                  begin
  ABSTable4.Insert;
  ABSTable4.FieldByName('num').AsLargeInt:=numT1;
  ABSTable4.Post;
                  end;
    AbsTable1.Next; { Eof False on success; Eof True when Next fails on last record }
              end;
      finally
  AbsTable1.EnableControls;
      end;

    AbsTable4.DisableControls;
      try               //cancella in T4 gli esuberi
    AbsTable4.First; { Go to first record, which sets Eof False }
      while not AbsTable4.Eof do { Cycle until Eof is True }
             begin
    numT2:= ABSTable4.FieldByName('num').AsLargeInt;
  if ABSTable1.Locate('Num',numT2,[])=False then
                  begin
    ABSTable4.Delete;
                  end;
    AbsTable4.Next; { Eof False on success; Eof True when Next fails on last record }
              end;
      finally
    AbsTable4.EnableControls;
        ABSTable1.Close;        //chiusure
        ABSDatabase1.Close;
        ABSTable2.close;
        ABSTable3.Close;
        ABSTable4.Close;
        memo1.Free;
        Clipboard.Clear;
      end;
                              end;
end;
                       //controllo del post
procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if ((ABSTable1.FieldByName('Tag').AsString<>'') OR (ABSTable1.FieldByName('What').AsString<>''))AND(salvato=False)then
  begin
        if MessageDlg('  Any record to post ?'+#13#10+'Yes to post, No to exit',
        mtconfirmation, [mbYes,mbNo], 0) = mrNo then
      begin
      if ((ABSTable1.FieldByName('Tag').AsString='') OR (ABSTable1.FieldByName('What').AsString='')) then
                 begin
        ABSTable1.Delete;
        salvato:=False;
        CanClose:= True;
        Flag:=False;
        Exit;
                 end else
                 begin
                 Flag:=False;
                 Halt;
                 //Application.Terminate;
                 end;
      end else
        if (ABSTable1.FieldByName('Tag').AsString='') OR (ABSTable1.FieldByName('What').AsString='')then
         begin
            showmessage('Record data to be completed !');
             CanClose:= False;
             exit;
         end;
        if (ABSTable1.FieldByName('Tag').AsString<>'') AND (ABSTable1.FieldByName('What').AsString<>'')then
            ABSTable1.Post;
  end;
end;
end.

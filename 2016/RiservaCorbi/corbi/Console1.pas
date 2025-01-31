unit Console1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,Data.DB,ABSMain, frxClass,
  frxDBSet,System.Types, JvBaseDlg, JvSHFileOperation, frxExportPDF,
  Vcl.ExtCtrls,System.UITypes, Vcl.Imaging.jpeg,Vcl.HtmlHelpViewer,Winapi.ShellAPI,
  Vcl.Buttons;

type
  TForm2 = class(TForm)
    Esci: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ABSDatabase1: TABSDatabase;
    ABSTable1: TABSTable;
    ABSTable3: TABSTable;
    ABSTable3D: TABSTable;
    frxDBDataset1: TfrxDBDataset;
    ABSTable2: TABSTable;
    ABSTable4: TABSTable;
    ABSTable5: TABSTable;
    ABSTable6: TABSTable;
    ABSTable9: TABSTable;
    ABSTable7: TABSTable;
    ABSTable8: TABSTable;
    ABSTable12: TABSTable;
    ABSTable10: TABSTable;
    ABSTable11: TABSTable;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    frxPDFExport1: TfrxPDFExport;
    ABSTable16T: TABSTable;
    Button8: TButton;
    Button9: TButton;
    ABSQuery2: TABSQuery;
    frxReport2: TfrxReport;
    frxDBDataset2: TfrxDBDataset;
    Button10: TButton;
    Button11: TButton;
    frxReportLog: TfrxReport;
    frxDBDatasetLog: TfrxDBDataset;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    JvSHFile1: TJvSHFileOperation;
    frxReport1: TfrxReport;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure EsciClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure JVSHFile1Show(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);


  private
    { Private declarations }
  public
     function GetAppVersionStr: string;
   { Public declarations }
  end;

var
  Form2: TForm2;
  consflg:Boolean=True;   // quando � True Form2 � closed
  Log1,versione:string;
  riparato:Boolean;
  KBHook: HHook;
  function KeyboardHookProc(Code: Integer; WordParam: Word; LongParam: LongInt): LongInt; stdcall;
implementation
 uses      //per utilizzare il form3 e Form4 ecc
  AnaAtl,Login1,AnaDspl,AnaGa,Gara,Classifiche,aiuto;

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  ABSDatabase1.DatabaseFileName:=ExtractFilePath(Application.ExeName)+'corbi.ABS';
  Application.HelpFile := ExtractFilePath(Application.ExeName) + 'Corbi.chm';
  ABSDatabase1.Open;
  ABSTable1.TableName:='Servizio';
  ABSTable1.Open;
  ABSTable1.Edit;
  //registra su Servizio
  Form2.ABSTable1.INSERT;
  Form2.ABSTable1.FieldByName('IN').AsDateTime:= NOW;
  Form2.ABSTable1.FieldByName('what').AsString:='Accesso alla Consolle';
  Form2.ABSTable1.FieldByName('OUT').AsString:='';
  Form2.ABSTable1.Post;
  Form2.ABSTable1.Close;
  Form2.ABSTable6.TableName:='Base';
  Form2.ABSTable4.TableName:='AnaDspl';
  Form2.ABSTable8.TableName:='GRPA';
  Form2.ABSTable9.TableName:='GRPB';
  Form2.ABSTable5.TableName:='AnaGa';
  Form2.ABSTable7.TableName:='Gara';
  Form2.ABSTable2.TableName:='AnaAtl';
  Form2.ABSTable3.TableName:='SelezioneGare';
  Form2.ABSTable3D.TableName:='SelezioneDSPL';
  Form2.ABSTable10.TableName:='repBase';
  Form2.ABSTable11.TableName:='repGRPA';
  Form2.ABSTable12.TableName:='repGRPB';
  Form2.ABSTable16T.TableName:='T16T';
  Form2.Visible:=False;
  consflg:=False;
  KBHook:=SetWindowsHookEx(WH_KEYBOARD,@KeyboardHookProc,HInstance,GetCurrentThreadId());
  GetAppVersionStr;
  caption:=caption + '  - ver: '+versione;
end;

function KeyboardHookProc(Code: Integer; WordParam: Word; LongParam: LongInt) : LongInt;
begin           //per chiamre l'help da F1

    if WordParam=VK_F1 then
      ShellExecute(0, nil,PChar('Corbi.chm'), nil, nil, SW_SHOWNormal)
    else
     Result:=0; //necessaria per sbloccare l'intercettazione per tasti diversi da F1
end;

function TForm2.GetAppVersionStr: string;
var
Exe: string;
Size, Handle: DWORD;
Buffer: TBytes;
FixedPtr: PVSFixedFileInfo;
begin
  Exe := ParamStr(0);
  Size := GetFileVersionInfoSize(PChar(Exe), Handle);
   if Size = 0 then
    RaiseLastOSError;
    SetLength(Buffer, Size);
   if not GetFileVersionInfo(PChar(Exe), Handle, Size, Buffer) then
    RaiseLastOSError;
   if not VerQueryValue(Buffer, '\', Pointer(FixedPtr), Size) then
    RaiseLastOSError;
 Result := Format('%d.%d.%d.%d',
  [LongRec(FixedPtr.dwFileVersionMS).Hi, //major
   LongRec(FixedPtr.dwFileVersionMS).Lo, //minor
   LongRec(FixedPtr.dwFileVersionLS).Hi, //release
   LongRec(FixedPtr.dwFileVersionLS).Lo]); //build
 versione:= Result;
end;


procedure TForm2.JVSHFile1Show(Sender: TObject);
begin
    ShowMessage('Effettuato il backup del Database');
end;


procedure TForm2.Button1Click(Sender: TObject);  //Anagrafica atleti
begin                 //Form2 =Consolle
      if Form2.visible=True then
      Form2.Visible:=False;
      if atlflg=False then
       begin
         Form3:= TForm3.Create(Self);
         Form3.show ;
       end
       else      //essendo atlflg True occorre ri-creare il Form3 prima di poterlo
      begin     // rendere visibile se si ripete il click
       Form3:= TForm3.Create(Self);
       Form3.Visible:=True;
       atlflg:=False;
      end;
end;

procedure TForm2.Button2Click(Sender: TObject); //Anagrafiva discipline
begin
      if Form2.visible=True then
      Form2.Visible:=False;
      if Dsplflg=False then
       begin
         Form4:= TForm4.Create(Self);
         Form4.show ;
       end
      else      //essendo atlflg True occorre ri-creare il Form3 prima di poterlo
      begin     // rendere visibile se si ripete il click
       Form4:= TForm4.Create(Self);
       Form4.Visible:=True;
      end;
end;

procedure TForm2.Button3Click(Sender: TObject); //Anagrafica Gare
begin
     if Form2.visible=True then
      Form2.Visible:=False;
      if AnaGAFlg=False then
       begin
         Form5:= TForm5.Create(Self);
         Form5.show;
       end
      else      //essendo AnaGAFlg True occorre ri-creare il Form5 prima di poterlo
      begin     // rendere visibile se si ripete il click
       Form5:= TForm5.Create(Self);
       Form5.Visible:=True;
      end;
end;

procedure TForm2.Button4Click(Sender: TObject); // Gara Corrente Iscrizioni
begin
     if Form2.visible=True then
      Form2.Visible:=False;
      if GAFlg=False then
       begin
        Form6:= TForm6.Create(Self);
        Form6.show ;
       end
      else    //essendo GAFlg True (cio� Form chiuso) occorre ri-creare il Form6
      begin   //prima di poterlo rendere visibile se si ripete il click
       Form6:= TForm6.Create(Self);
       Form6.Visible:=True;
      end;
end;

procedure TForm2.Button5Click(Sender: TObject);    // Backup
begin
   if MessageDlg('Confermi di voler effettuare il backup del DataBase ?',
             mtconfirmation, [mbYes,mbNo], 0) = mrYes then
     begin
         ABSDatabase1.Close;
         JVSHFile1.Execute;
       //  JVSHFile1.OnClose(Self);
         Form2.ABSTable1.Open;
         Form2.ABSTable1.Last;
         if Form2.ABSTable1.FieldByName('Password').AsString<>'' then
         Form2.ABSTable1.Insert;
         Form2.ABSTable1.Edit;
         Form2.ABSTable1.FieldByName('IN').AsDateTime:=NOW;
         Form2.ABSTable1.FieldByName('what').AsString:='Effettuato Backup';
         Form2.ABSTable1.Post;
         Form2.ABSTable1.Close;
     end else Exit;


end;

procedure TForm2.Button6Click(Sender: TObject);   // Ripara
 Var
 result:string;
begin
     Form2.ABSDatabase1.Close;
     result:= ABSDatabase1.RepairDatabase;
     if result = '' then
     ShowMessage('Il Database � stato verificato ')else
     ShowMessage('Il Database � corrotto - Usa il backup');

end;

procedure TForm2.Button7Click(Sender: TObject);    //Classifiche
begin
  if Form2.visible=True then
      Form2.Visible:=False;
      if ClassFlg=False then
       begin
         Form8:= TForm8.Create(Self);
         Form8.show ;
       end
       else      //essendo ClassFlg True occorre ri-creare il Form8 prima di poterlo
       begin     // rendere visibile se si ripete il click
         Form8:= TForm8.Create(Self);
         Form8.Visible:=True;
       end;
end;

procedure TForm2.Button8Click(Sender: TObject);    //Azzera Storico
begin
      if MessageDlg('Stai per azzerare l''intero Storico delle Classifiche. Vuoi continuare ?',
          mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
          begin
            Form2.ABSTable16T.Close;
            Form2.ABSTable16T.EmptyTable;
            ShowMessage('Tutta lo Storico � stato cancellato !');
            Form2.ABSTable1.Open;
            Form2.ABSTable1.Last;
            Form2.ABSTable1.Insert;
            Form2.ABSTable1.Edit;
            Form2.ABSTable1.FieldByName('IN').AsDateTime:=NOW;
            Form2.ABSTable1.FieldByName('what').AsString:='Cancellato lo Storico delle Classifiche';
            Form2.ABSTable1.Post;
            Form2.ABSTable1.Close;
          end;

end;

procedure TForm2.Button9Click(Sender: TObject);   //Complessivo
var
ca1,ca2 : Integer;
d1,d2:TDateTime;
trovato:Boolean;
begin
   ABSTable16T.Open;
   if MessageDlg('Desideri ottenere il punteggio storico per Atleta ?'
   +#13+'Dovrai fornire i codici della prima ed ultima Gara da conteggiare',
          mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrNo then Exit;
   ca1:=StrToInt(InputBox('Codice Gara iniziale','Inserisci la prima',''));
      if ca1<>0 then
   ca2:=StrToInt(InputBox('Codice Gara finale','Inserisci l''ultima',''));
   trovato:=ABSTable16T.Locate('CODGA',ca1,[]);
   if trovato=True then
    d1:=ABSTable16T.FieldByName('DATAGA').AsDateTime else
      begin
        ShowMessage('Gara codice '+inttostr(ca1)+' non esiste.');
        Exit;
      end;
   trovato:=ABSTable16T.Locate('CODGA',ca2,[]);
   if trovato=True then
    d2:=ABSTable16T.FieldByName('DATAGA').AsDateTime else
      begin
        ShowMessage('La Gara con codice '+inttostr(ca2)+' non contiene dati di classifiche.');
        Exit;
      end;
      if (ca2=0) or (ca1=0)then
     begin
       ShowMessage('Nessun dato inserito');
       Exit;
     end;
    Form8.ABSTable19.Close;
    Form8.ABSTable19.EmptyTable;
    Form8.ABSTable19.Open;
    with ABSQuery2 do
       begin
         Close;
         SQL.Text:='INSERT INTO totale(CODATL,COGNOME,NOME,NAZIONE,RNK) SELECT CODATL,COGNOME,NOME,NAZIONE,SUM(RNK) AS RNK ' +
         ' FROM T16T where CODGA BETWEEN '+QuotedStr(IntToStr(ca1))+' AND '+QuotedStr(IntToStr(ca2))+' GROUP BY'+
         ' CODATL,COGNOME,NOME,NAZIONE ORDER BY RNK desc';
         ExecSQL;
         //Open;
       end;
        frxReport2.Variables['ini']:= quotedstr(DateToStr(d1));
       frxReport2.Variables['fin']:= quotedstr(DateToStr(d2));
       frxReport2.ShowReport;
       ABSTable16T.Close;
       Form8.ABSTable19.Close;
       Form8.ABSTable19.EmptyTable;

end;

procedure TForm2.Button10Click(Sender: TObject);
var
s:string;
begin                  //per mascherare i caratteri premetter #31

    s:=InputBox('Richiesta PW',#31'Inserisci PW dell''Amministratore','');
    if s<>'Corbi77' then Exit;
    frxReportLog.ShowReport;
end;

procedure TForm2.Button11Click(Sender: TObject); //Cancella il log
var
s:string;
n:Integer;
begin
   s:=InputBox('Richiesta PW',#31'Inserisci PW dell''Amministratore','');
   Form2.ABSTable1.Open;
   Form2.ABSTable1.Edit;
    if s<>'Corbi77' then Exit;
    n:=Form2.ABSTable1.RecordCount;
    if MessageDlg('Il LOG ha '+IntToStr(n)+' records, vuoi cancellarlo ? '
    ,mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrNo then
     Exit;
    Form2.ABSTable1.First;
   while not Form2.ABSTable1.Eof do
     begin
       if Form2.ABSTable1.FieldByName('Password').AsString<>'' then
       Form2.ABSTable1.Next else
       Form2.ABSTable1.Delete;  //NB il delete causa gi� un next
     end;
    Form2.ABSTable1.Close;
end;

procedure TForm2.EsciClick(Sender: TObject);    //Esci
begin
 Form2.ABSTable1.Open;
 Form2.ABSTable1.Last;
 Form2.ABSTable1.Insert;
 Form2.ABSTable1.Edit;
 Form2.ABSTable1.FieldByName('OUT').AsDateTime:=NOW;
 Form2.ABSTable1.FieldByName('what').AsString:='Chiusura della Sessione';
 Form2.ABSTable1.Post;
 Form2.ABSTable1.Close;
 ABSDataBase1.Close;
 Form2.release;
 consflg:=True;
 Application.Terminate;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);  //RESET del Database
begin
  if MessageDlg('Stai per azzerare l''intero Database. Vuoi continuare ?',
          mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes then
    begin
     if MessageDlg('Questa operazione non � ripristinabile, '+#13+
     'Tutti gli archivi verranno cancellati !'+#13+' Vuoi continuare ?',
          mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes then
          begin
           Form2.ABSTable1.Close;
           Form2.ABSTable1.EmptyTable;
           Form2.ABSTable2.Close;
           Form2.ABSTable2.EmptyTable;
           Form2.ABSTable3.Close;
           Form2.ABSTable3.EmptyTable;
           Form2.ABSTable4.Close;
           Form2.ABSTable4.EmptyTable;
           Form2.ABSTable5.Close;
           Form2.ABSTable5.EmptyTable;
           Form2.ABSTable6.Close;
           Form2.ABSTable6.EmptyTable;
           Form2.ABSTable7.Close;
           Form2.ABSTable7.EmptyTable;
           Form2.ABSTable8.Close;
           Form2.ABSTable8.EmptyTable;
           Form2.ABSTable9.Close;
           Form2.ABSTable9.EmptyTable;
           Form2.ABSTable10.Close;
           Form2.ABSTable10.EmptyTable;
           Form2.ABSTable11.Close;
           Form2.ABSTable11.EmptyTable;
           Form2.ABSTable12.Close;
           Form2.ABSTable12.EmptyTable;
           Form6.ABSTable13.Close;
           Form6.ABSTable13.EmptyTable;
           Form6.ABSTable14.Close;
           Form6.ABSTable14.EmptyTable;
           Form8.ABSTable16.Close;
           Form8.ABSTable16.EmptyTable;
           Form8.ABSTable18.Close;
           Form8.ABSTable18.EmptyTable;
           Form2.ABSTable16T.Close;
           Form2.ABSTable16T.EmptyTable;
           Form8.ABSTable16R.Close;
           Form8.ABSTable16R.EmptyTable;
           Form8.ABSTable18.Close;
           Form8.ABSTable18.EmptyTable;
           Form8.ABSTable19.Close;
           Form8.ABSTable19.EmptyTable;
           Form2.ABSTable3D.Close;
           Form2.ABSTable3D.EmptyTable;
           ShowMessage('Tutti gli archivi sono stati azzerati.');
          end else Exit;

    end else Exit;

end;

end.

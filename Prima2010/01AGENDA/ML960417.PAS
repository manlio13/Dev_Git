{Agenda 2.0 - by Manlio Laschena. 5.1.97 Milano lasc@iol.it}
unit Ml960417;
interface
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBTables, Mask, ExtCtrls, Buttons, Dialogs,
  inifiles, Grids, DBGrids,unit1;
type
  TMaschera = class(TForm)
    DBNavigator: TDBNavigator;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Table1: TTable;
    Label18: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Edit1: TEdit;
    Query1: TQuery;
    ScrollBox: TScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    EditCognome: TDBEdit;
    EditNome: TDBEdit;
    EditVia: TDBEdit;
    EditCitt: TDBEdit;
    EditCap: TDBEdit;
    EditTitolo: TDBEdit;
    EditAzienda: TDBEdit;
    EditTelefono: TDBEdit;
    EditTelefono2: TDBEdit;
    EditTelefono3: TDBEdit;
    EditFax: TDBEdit;
    EditCodice2: TDBEdit;
    EditCodice3: TDBEdit;
    EditNote: TDBEdit;
    EditEntry: TDBEdit;
    GroupBox1: TGroupBox;
    Edit2: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SpeedButton3: TSpeedButton;
    DBComboBox1: TDBComboBox;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    ONTOP: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    pwbtn: TBitBtn;
   
    procedure SpeedButton3Click(Sender: TObject);
    procedure Formshow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure edit2enter(Sender: TObject);
    procedure DBNavigatorClick(Sender: TObject; Button: TNavigateBtn);
    procedure EditEntryKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RadioButton2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pass(var reg1,dat1: integer;var cfg1:longint;var user: string);
    procedure BitBtn1Click(Sender: TObject);
    procedure ONTOPClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure verypass(Sender: TObject);
    procedure pwbtnClick(Sender: TObject);
  private

  public
   IniFile: TIniFile;
   nuovihint: TstringList;
   Function windrive(windir :string):string;
   Function EsisteWinF(NomeFile: String): longint;

  end;

var
  Maschera: TMaschera;
  Status: Integer;
  user: string[80];
  nomeFile: string;
  reg1,dat1,pw1,conta,passi: integer;
  inWinF,p,cfg1: longint;
  F2:File of longint;
const
fatale ='E''stata diagnosticata un''operazione illecita.';
corrotto='Il file di configurazione appare corrotto.';
scaduto='Spiacente,il periodo d''uso per il prodotto non registrato è scaduto.';
scade='Attenzione,il periodo d''uso del prodotto non registrato è in scadenza.';
boh='Si è verificata una condizione non prevista, forse dovuta ad un''operazione illecita.';
implementation

{$R *.DFM}

procedure TMaschera.Formshow(Sender: TObject);
 var
 cd: string;

begin

       IniFile := TIniFile.Create ('.\agenda.ini');

       pw1:=Inifile.ReadInteger('Utente','Password',0);
       reg1:=Inifile.ReadInteger('Dati','Reg',0);
       cfg1:=Inifile.ReadInteger('Dati','Cfg',0);
       dat1:=Inifile.ReadInteger('Dati','Dat',0);
       user:=Inifile.ReadString('Utente','Nominativo','');
       Table1.Tablename :=inifile.readstring('Database','TableName','agenda.db');
       Table1.DatabaseName := inifile.readstring('Database','Directory','.\');
       Query1.DatabaseName:= Table1.DataBaseName;

  Status := IniFile.ReadInteger ('Maschera','Status',1);
        if Status <= 1 then
        begin
    status:=1;
    Top := IniFile.ReadInteger ('Maschera','Top', Top);
    Left := IniFile.ReadInteger ('Maschera','Left', Left);
    Width := IniFile.ReadInteger ('Maschera','Width', Width);
    Height := IniFile.ReadInteger ('Maschera','Height', Height);
        end;
    case Status of
      2: WindowState := wsMinimized;
      3: WindowState := wsMaximized;
    end;


  verypass(nil);
  pass(reg1,dat1,cfg1,user);
      timer1.enabled:=true;
    try
  Table1.Open; {riempie la combo box dei tipi di categoria esistenti}
              Table1.First;
              While not Table1.EOF do
              begin
              cd:=Table1.FieldByName('Cod1').AsString;
              with DBCombobox1 do
              if (cd<>'')and(Items.Indexof(cd)<0) then
              items.add(cd);
              Table1.next
              end;
              Table1.First;
    except
  MessageDlg ('Non riesco ad accedere al file Agenda.db', mtError,[mbOK,mbhelp],2);
  application.terminate;
    end;
 DataSource1.Dataset := Maschera.Table1;
                     begin
                     nuovihint :=TstringList.Create;
                     with nuovihint do
                     begin
                     Add('Primo record');
                     Add('Record precedente');
                     Add('Record Seguente');
                     Add('Ultimo record');
                     Add('Inserisci record');
                     Add('Elimina record');
                     Add('Modifica record');
                     Add('Salva record');
                     Add('Annulla la modifica');
                     Add('Aggiorna i dati');
                     end;
                     DBNavigator.Hints := nuovihint;
                     DBNavigator.ShowHint := True;
                     end;

   end;

 procedure TMaschera.RadioButton2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  c: integer;
begin
 if(shift=[ssAlt]) and (key = VK_SPACE) then
    begin
    c:=ScrollBox.tag;
    messagedlg('il codice è '+IntToStr(c),mtInformation,[mbOK],0);
    end
    else
    c :=0;
end;
procedure TMaschera.EditEntryKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (shift=[ssAlt]) and (key = VK_RETURN) then
 Table1.FieldByName('Entry').AsDateTime:=date;
end;
procedure TMaschera.SpeedButton3Click(Sender: TObject);
begin
Application.HelpFile:= '.\agenda.hlp';
Application.HelpCommand(HELP_CONTENTS,0);
end;

procedure TMaschera.SpeedButton1Click(Sender: TObject);
begin
Table1.SetKey;
Table1.FieldbyName('Cognome').AsString:= Edit1.text;
Table1.KeyFieldCount := 1;
if not Table1.GotoKey then
MessageDlg ('Cognome inesistente', mtInformation , [mbOK] , 0)

end;
 procedure TMaschera.SpeedButton2Click(Sender: TObject);
begin
Table1.SetKey;
Table1.FieldbyName('Cognome').AsString:= Edit1.text;
Table1.KeyFieldCount := 1;
Table1.GotoNearest;
end;
procedure TMaschera.RadioButton2Click(Sender: TObject);
   Begin
   DataSource1.Dataset := Maschera.Table1
   end;
procedure TMaschera.RadioButton1Click(Sender: TObject);
begin
   DataSource1.Dataset := Maschera.Query1;
   Query1.Active := false;
   if (Edit2.Text <>'' )then
   begin
   Query1.Sql.Clear;
   Query1.Sql.Add('select * from Agenda where ' +Edit2.Text);
   Query1.Active := True;
   RadioButton1.Enabled :=false;
   end;

end;
procedure TMaschera.Edit2Change(Sender: TObject);
begin
   RadioButton1.Enabled := Edit2.Text <> '';
   Edit2.color := clyellow;
end;
procedure TMaschera.Edit2enter(Sender: TObject);
begin
   if edit2.text<>'' then

   RadioButton1.enabled :=false;
   RadioButton2.Checked :=true;
   Edit2.color := clwindow;
end;
procedure TMaschera.DBNavigatorClick(Sender: TObject;
  Button: TNavigateBtn);
begin
  EditCognome.setfocus;
end;
procedure TMaschera.FormClose(Sender: TObject; var Action: TCloseAction);
var
Status: Integer;
  begin
  hide;  {per evitare che nella chiusura ci sia un flash del form}
    case WindowState of
      wsNormal: begin
        IniFile.WriteInteger ('Maschera','Top', Top);
        IniFile.WriteInteger ('Maschera','Left', Left);
        IniFile.WriteInteger ('Maschera','Width', Width);
        IniFile.WriteInteger ('Maschera','Height', Height);
        Status := 1;
                end;
      wsMaximized: Status := 3;
      wsMinimized: Status := 2;
    end;
    
      IniFile.WriteInteger ('Maschera','Status', Status);

      IniFile.WriteString ('Database','TableName',table1.tablename);
      IniFile.WriteString ('Database','Directory',Table1.DatabaseName);

  end;
  {procedura di verifica dell'utente}
   procedure Tmaschera.pass(var reg1,dat1: integer;var cfg1:longint;var user:string);
   var
   m,n,cnt: integer;
   k,l,d: longint;
   drv:string;
   nome: string[80];
   oggi,inidata:TdateTime;
   anno,mese,giorno: word;
begin
 try
   case reg1 of

    0:
     begin
        messagedlg(corrotto,mterror,[mbok,mbhelp],2);
        application.terminate;
     end;

   else
     begin
     {VERGINE o mancante di uno dei tre codici}
                          oggi:=date;
        if (dat1=0) or (cfg1=0) or (user='') then
          begin
                          
     {FORZA IL NOME}
                          for cnt:=1 to 3 do
                         begin
                          nome:=inputbox('Fornisci i dati dell''utente','Nome e Cognome','');
                          if nome<>'' then
                             break;
                         end;
                          if nome='' then
                         begin
                          messagedlg(fatale,mterror,[mbok,mbHelp],2);
                          application.terminate;
                         end;
     {se manca l'user scrive sull'INI il nome}
                         if user='' then
                          begin
                          IniFile.writestring('Utente','Nominativo',nome);
     {acquisisce l'user}  user:=nome;
                          end;
           end;
     {codifica l'user per il dat}
                          m:=0;
                           for n:=1 to length(user) do
                          m:= m+ord(user[n]);
                          m:=m+scrollbox.tag;
     {se non c'e' Dat lo scrive}
        if dat1=0 then
                          begin
                          IniFile.writestring('Dati','Dat','$'+inttohex(m,9));
     {acquisisce dat1}    dat1:=m;
                          end
                  else
     {se non corrisponde Dat}
                         if dat1<>m then
                           begin
                           messagedlg(corrotto,mterror,[mbok,mbhelp],2);
                           application.terminate;
                           end;
     {se non c'e' cfg lo scrive}
        if cfg1=0 then
                         begin
                          k:=DateTimetoFileDate(oggi)-539033600;
                          k:=k+m;
                          IniFile.writeString('Dati','Cfg','$'+intTohex(k,9));
     {acquisisce cfg1}    cfg1:=k;
                          end
                  else
                          begin
                          d:=cfg1+539033600-dat1;
                          inidata:= FileDatetoDateTime(d);
    { VERIFICA SCADUTO}

                 if  (reg1-m=640) then  {reg=nome +640 + CM}
                      exit;
                 if reg1=160 then
                   begin

    if ((oggi-inidata>30) or (oggi<inidata)) then
                               begin
                                 messagedlg(scaduto,mtWarning,[mbOK,mbhelp],1);
                                 
                                 application.terminate;
                               end
         else

    {VERIFICA IN SCADENZA}
    if(oggi-inidata>=28) then
                               begin
                             messagedlg(scade,mtWarning,[mbOK,mbhelp],1);
                             exit;
                               end
                   end

                 else
                      begin
                      messagedlg(corrotto,mterror,[mbok,mbhelp],2);
                      application.terminate;
                      end;
    end;


  end;
       {CONTROLLA WIN$#$ }
           {fornisce la lettera del drive che contiene windows, senza ":"}
     drv:= windrive('WINDOWS');
     nomefile:=drv+':\WINDOWS\WIN$#$.SYS';
            {inwinF fornisce il contenuto di WIN$#$.SYS o 0, se non esiste.}
     inWinF:=esisteWinF(nomefile);
        if inWinF=0 then      {se inWinF =0}
         begin

                oggi:=date;
                k:=DateTimetoFileDate(oggi);
                assignfile(F2,nomeFile);
                rewrite(F2);
                write(F2,k);
                FileSetAttr(nomefile,(02+04));
                closeFile(F2);
         end
         else
        {se inWinF>0  }

            if ((cfg1-dat1+539033600)>inwinF) then
               begin
     {scrive con inWinF  Cfg se questo manca o lo sostituisce se successivo}
             k:=dat1+inWinF-539033600;
             IniFile.writeString('Dati','Cfg','$'+intTohex(k,9));
               end ;


         end;

 except
      messagedlg(boh,mterror,[mbok,mbhelp],1);
      application.terminate;
 end; 
 end;

{ crea l'etichetta indirizzo su clipboard}
Procedure TMaschera.BitBtn1Click(Sender: TObject);
var
t,n,c,a,v,ct,cp :string;

begin

 t:=EditTitolo.text;
 n:=EditNome.text;
 c:=EditCognome.text;
 a:=EditAzienda.text;
 v:=EditVia.text;
 ct:=EditCitt.text;
 cp:=EditCap.text;
 memo1.text:='';
 memo1.lines.add(t);
 memo1.lines.add(n+' '+c);
 memo1.lines.add(a);
 memo1.lines.add(v);
 memo1.lines.add(cp+'  '+ct);
 memo1.selectall;
 memo1.copytoclipboard;

 messagedlg('Un''etichetta di questo indirizzo è stata copiata sugli Appunti di Windows.',mtinformation,[mbOK],0);
end;

{ricerca del drive di windows}
Function Tmaschera.windrive(windir :String):string;
         var
         dove:string ;
         risulta,dr : integer;
         ricerca:Tsearchrec;
         begin
              try
                   for dr:=0 to 7 do
                        begin
                        dove:=CHR(67+dr)+':\*.*';

                        risulta:=FindFirst(dove,$10,ricerca);
                  if ricerca.name='WINDOWS' then
                  begin
                  windrive:=CHR(67+dr);
                  exit;
                  end;

              while risulta=0 do
                    begin
                    risulta:=FindNext(ricerca);
                  if ricerca.name='WINDOWS' then
                  begin
                  windrive:=CHR(67+dr);
                  exit;
                  end;

                    end;
                    FindClose(ricerca);
                        end;
        except
        messagedlg('Mi spiace, ma il programma non funziona su questo PC!',
            mtwarning,[mbok,mbHelp],2);

        end;
end;

procedure TMaschera.ONTOPClick(Sender: TObject);
          begin
          maschera.formstyle:=fsStayonTop;
end;

function TMaschera.EsisteWinF(NomeFile: String): longint;
{ Questa funzione restituisce, se il file esiste,il suo contenuto.
  Se esiste , chiude il file. }
             var
             F:File of longint;{typed file}
             I:integer;
             datoWF :longint;
             begin
             {$I-}
              datoWF:=0;
              AssignFile(F, NomeFile);

              Reset(F);
              Read(F,datoWF);
              CloseFile(F);

              {$I+}
              Result:= datoWF;
              I:=IOResult; {con questa chiamata di errore
                           viene resettata la variabile IOResult che altrimenti
                           nel caso di assenza del file, con la direttiva $I+
                           attivata, farebbe arrestare il run alla successiva
                           chiamata di interfaccia file}
       end;

procedure Tmaschera.verypass(Sender: TObject);
begin
    {PASSWORD SYSTEM}
   try

        if pw1<>640 then   {640=280H dovrebbe essere il valore di default}
   begin
            if pw1=0 then   {corrotto l'ini}
        begin
            passworddlg.enabled:=false;
            messagedlg(corrotto,mterror,[mbOK,mbHelp],2);
            Application.terminate; {altrimenti la chiusura è irregolare}
        end
        else
        begin   {chiede e verifica la password}

         for conta:=1 to 2 do
         begin
         passworddlg.showmodal;
         passi:=strtoint(passworddlg.password.text);{rif all'unit1}
         if (passi+640)<>pw1 then
                          begin
         messagedlg('password errata',mtwarning,[mbOK,mbHelp],3);
         passworddlg.password.text:='';
                          end
         else
         break;  {o è soddisfatta o non lo è stato per due volte}
         end;
         if (passi+640)<>pw1 then  {lo verifica per la terza volta}
                        begin
            
            messagedlg(fatale,mterror,[mbOK,mbHelp],2);
            
            application.terminate;
            
                        end;
        end
   end;
{FINE PASSWORD SYSTEM}

   except
    on e:exception do
    begin
     messagedlg(fatale,mterror,[mbOK,mbHelp],2);
     Application.terminate;
    end;

   end;

end;

procedure TMaschera.Timer1Timer(Sender: TObject);
const
etichetta='  L  a    t  u  a      A  g  e  n  d  a';
begin
  Maschera.caption:=etichetta;
end;

  procedure TMaschera.Timer2Timer(Sender: TObject);
begin
  Maschera.caption:='';
end;

 procedure TMaschera.pwbtnClick(Sender: TObject);
 var
 pw2:integer;
 spass:string;
begin
 spass:=inputbox('Agenda - Protezione dei dati','Digita una password numerica','');
 pw2:=strtoint(spass);
 spass:=inputbox('Agenda - Protezione dei dati','Ridigita la password numerica','');
    if pw2=strtoint(spass) then
    begin
     IniFile.writestring('Utente','Password','$'+inttohex((pw2+640),9));
     messagedlg('Password inserita, attento a ricordartela !',mtinformation,[mbOK,mbHelp],3);
    end
    else
    begin
    messagedlg('Password non inserita',mtwarning,[mbOK,mbHelp],3);
    IniFile.writestring('Utente','Password','$'+inttohex(640,9));
    end;
end;

end.

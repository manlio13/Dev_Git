unit Login1;   //19/01/2016

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,System.UITypes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,Data.DB,ABSMain,System.Types;
type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public

    //class function Execute: Boolean;
  end;

var
  Form1: TForm1;
  dir,pwstr,cnvstr,pwtemp:string;        //pwstr è la password in ingresso: cnvstr è la pw convertita
  nuovapw: Boolean = false;
  cicla:boolean = False;
  // ATTENZIONE VALORE INSERITO AL DEPLOY DEL PROGRAMMA è identico alla pw del Database
  Jolly:string='Corbi77';  //PW dell'amministratore usata anche in Console1
implementation
    uses
    Console1 ;
{$R *.dfm}
 {$D+}
procedure TForm1.FormCreate(Sender: TObject);   //preliminare login
begin   //verifica se c'è il db
  dir:=GetCurrentDir+'\';
  pwstr:='';
  cnvstr:='';
  pwtemp:='';
  if FileExists(dir+'corbi.ABS')=False then  //se non c'è il database
    begin
      MessageDlg('ATTENZIONE - File Dati corrotto o inesistente'+#13+' Il programma verrà chiuso ', mtError,[mbOK],0 );
      Application.Terminate;
    end else
      begin             // se c'è il database
       Form2.ABSTable1.TableName:='Servizio';
       Form2.ABSTable1.Open;
       Form2.ABSTable1.First;
       Form2.ABSTable1.Edit;
       if (Form2.ABSTable1.FieldByName('Password').IsNull) then  //se non c'è la pw  CREARE LA PW
        begin
          ShowMessage('Assegnate una password: max 8 caratteri ');
          nuovapw:=True; //flag per nuova pw
          form1.Visible:=True;
        end
       else form1.Visible:=True;  //  continua se c'è la pw con la routine di riconoscimento
      end;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);    // carico login
var
n,L:integer;
p:Char;
riconosce:string;
begin
   if Key=#13 then  // all'atto dell'entry della pw
    begin
       pwstr:=Edit1.Text;     // pwstr è la password attualmente digitata
       if pwstr=Jolly then    //Procedura per ripristinare la pw
        begin
         ShowMessage('ATTENZIONE - Ripristino password '+#13+'Il programma verrà chiuso, rilancialo e'+#13
         +'Digita una nuova password');
         Form2.ABSTable1.First;  //Attenzione sembra che porre xx.first dopo edit tolga dalla condizione di edit
         Form2.ABSTable1.Edit;
         Form2.ABSTable1.FieldByName('password').AsString:='';  //cancella la vecchia password per ripristinarla
         Form2.ABSTable1.Post;
         Application.Terminate;
        end;
       L:= Length(pwstr);
       if L=0 then
         begin
           ShowMessage('Attenzione - Non è stata inserita alcuna password');
           Exit;
         end;
       if L>8 then  //verifica la lunghezza massima
        begin
          ShowMessage('Numero di caratteri superiore ad 8, ripeti');
          Edit1.Text:='';
          Exit;
        end;
       if (nuovapw=True) and (cicla=False)then  // Se è nuova password
        begin
         cnvstr:='';
         pwtemp:=pwstr;  //si pone la pw nella memoria temporanea
         Edit1.Text:='';      //verifica pw
         ShowMessage('Conferma la password inserita');
         cicla:=True;
         Exit;
        end;
       if (nuovapw=True) and (cicla=True) then  //sempre la nuova nel secondo ciclo
         begin
            if pwtemp=pwstr then
            begin
              for n := 1 to L do    //procedura di cryptaggio
              begin
               p:= chr(ord(pwstr[n])+(L+1-n));
               cnvstr:=cnvstr + p;
              end;
             Form2.ABSTable1.Open;
             if Form2.ABSTable1.RecordCount=0 then
             Form2.ABSTable1.Insert else
             Form2.ABSTable1.First;
             Form2.ABSTable1.Edit;
             Form2.ABSTable1.FieldByName('password').AsString:=cnvstr;
             Form2.ABSTable1.Post;
             Form2.ABSTable1.Close;
             form1.Visible:=False;
             cicla:=False;
             pwtemp:='';
             pwstr:='';
             nuovapw:=False;
             ShowMessage('La password è stata regolarmente registrata'+#13+'Memorizzala in luogo sicuro');
             Form1.Visible:=False;
             Form1.Close;
             Form2.Visible:=True;
            end else
             begin
               MessageDlg('ATTENZIONE - I due inserimenti non coincidono'+#13+'Ripeti con attenzione', mtError,[mbOK],0 );
               Edit1.Text:='';
               cicla:=False;
               pwtemp:='';
               pwstr:='';
               Exit;
             end;
         end
       else           //la pw non è nuova quindi PROCEDURA DI RICONOSCIMENTO
           begin
               for n := 1 to L do    //procedura di cryptaggio
              begin
               p:= chr(ord(pwstr[n])+(L+1-n));
               cnvstr:=cnvstr + p;
              end;
              Form2.ABSTable1.Open;
              Form2.ABSTable1.First;
              riconosce:=Form2.ABSTable1.FieldByName('password').AsString;
              if cnvstr=riconosce then
                begin
                  ShowMessage('Accesso consentito') ;          // ACCESSO
                  Form2.ABSTable1.Open;
                  Form2.ABSTable1.INSERT;
                  Form2.ABSTable1.FieldByName('IN').AsDateTime:= NOW;
                  Form2.ABSTable1.FieldByName('what').AsString:='Accesso alla Consolle';
                  Form2.ABSTable1.FieldByName('OUT').AsString:='';
                  Form2.ABSTable1.Post;
                  Form2.ABSTable1.Close;
                  Form1.Visible:=False ;
                  Form1.Close;
                  Form2.Visible:=True;
                end
              else   //La password inserita è sbagliata
               begin
                if cicla=True then  //ha sbagliato per la seconda volta
                  begin
                    if  MessageDlg('Password errata ! Vuoi ripristinarla ?',
                       mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
                      begin
                       ShowMessage('Digita la password originale di registrazione');
                       Edit1.Text:='';
                       Exit;
                      end else Application.terminate;
                  end
                else
                 begin
                  MessageDlg('ATTENZIONE - Accesso negato', mtError,[mbOK],0 );
                  pwstr:='';
                  cnvstr:='';
                  edit1.text:='';
                  cicla:=True ;
                  Exit;
                 end;
               end;

           end;
    end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=caFree;
end;

end.


unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ABSMain, Data.DB,
   System.Types, system.UITypes, frxClass, frxDBSet, frxExportPDF;

type
  TForm1 = class(TForm)
    label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    ABSTable1: TABSTable;
    ABSDatabase1: TABSDatabase;
    ABSQuery1: TABSQuery;
    label2: TLabel;
    Label3: TLabel;
    chk1: TCheckBox;
    chk2: TCheckBox;
    Button2: TButton;
    Button3: TButton;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure inserimento(Sender:TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure finale(Sender:TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  nl,k,n,nn,i,p:Integer;
  lista:Boolean=False;
  s:string;
implementation
{$R *.dfm}



procedure TForm1.FormCreate(Sender: TObject);
begin
  nl:=0;
  k:=0;
  n:=0;
  nn:=0;
  i:=0;
  p:=1;
  label2.Visible:=False;
  Label3.Visible:=False;
  chk1.Visible:=False;
  chk2.Visible:=False;
  Button3.Visible:=False;
  Button2.Visible:=False;
  ABSDatabase1.DatabaseFileName:=ExtractFilePath(Application.ExeName)+'scaler.abs';
  ABSDatabase1.Open;
  ABSTable1.TableName:='scaler';
  ABSTable1.Open;
  ABSTable1.Edit;
  inserimento(Self);

end;


procedure TForm1.inserimento(Sender: TObject);
begin
if nl=0 then
   begin
     Edit1.Width:=40;
     label1.Caption:=' Fornisci il numero massimo di elementi nella lista.';
     Exit;
   end else
   if (lista=false) and (nl>0) then
       begin

            k:=k+1;
            begin
                if k=nl+1 then
               begin
                lista:=True;
                Button1.Visible:=False;
                Edit1.Visible:=False;
                Button2.Visible:=True;
                ShowMessage('fine inserimento lista - clickare su valutazione');
                Exit;
               end;

              Edit1.width:=350;
              Edit1.SetFocus;
              label1.Caption:='Inserisci l''elemento n: '+intToStr(k)+' della lista';
              Exit;
            end;


       end

end;



procedure TForm1.Button1Click(Sender: TObject);  //Invio
begin
     if Edit1.Text = ''then
      begin
         ShowMessage('Nulla da acquisire');
         Exit;
      end else
      if nl=0 then
      begin
         nl:=StrToInt(Edit1.Text);
         label1.Caption:='';
         Edit1.Text:='';
         inserimento(Self);
      end else
         if (lista = false)and (Edit1.Text <>'') then
            begin
              ABSTable1.Insert;
              ABSTable1.FieldByName('cosa').AsString:=Edit1.text;
              ABSTable1.Post;
              Edit1.Text:='';
              label1.Caption:='';
              inserimento(self);
            end;
end;

 { Il criterio � di uscire dal loop ma memorizzare gli indici con variabili globali.
  Quindi con un bottore rilanciare, dopo aver effettuata una operazione sul form,
  il loop, ma usando ora gli indici memorizzati.
  In tal modo il loop non ricomincia da capo, ma continua da dove era arrivato}

procedure TForm1.Button2Click(Sender: TObject); //Valutazione

begin
  label1.Caption:='Apporre un check sull''elemento prioritario tra i due e clicca su scegli';
  label2.Visible:=True;
  Label3.Visible:=True;
  chk1.Visible:=True;
  chk2.Visible:=True;
  Button2.Visible:=False;
  Button3.Visible:=True;
  ABSTable1.first;

         if (nl-p=1) then
              begin
               ShowMessage('Termine della valutazione');
                label2.Caption:='';
                label3.Caption:='';
                chk1.Checked:=False;
                chk2.Checked:=False;
                finale(self);
                 if MessageDlg(' Vuoi terminare questa analisi ?',mtConfirmation,[mbYes,mbNo],0,mbYes)=mrYes then
                   begin
                     ABSTable1.Close;
                     ABSTable1.EmptyTable;
                     Exit;
                   end else finale(self);


              end                         //variabili tutte a 0, p = 1

         else if (nl-p)=i then //verifica fine gruppo
              begin
                nn:=p;
                i:=1;
                p:=p+1;
                n:=n+1;
              end else i:=i+1;


         ABSTable1.MoveBy(n);
         label2.Caption:=ABSTable1.FieldByName('cosa').AsString;
         ABSTable1.First;
              ABSTable1.MoveBy(nn+1);
              label3.Caption:=ABSTable1.FieldByName('cosa').AsString;
              nn:=nn+1;

end;

procedure TForm1.Button3Click(Sender: TObject); // scegli
begin

    if chk1.Checked=True then
      begin
        ABSTable1.Locate('cosa',label2.caption,[]);
        ABSTable1.Edit;
        ABSTable1.FieldByName('punti').AsInteger:= ABSTable1.FieldByName('punti').AsInteger+1;
      end else
        begin
         ABSTable1.Locate('cosa',label3.caption,[]);
         ABSTable1.Edit;
         ABSTable1.FieldByName('punti').AsInteger:= ABSTable1.FieldByName('punti').AsInteger+1;
        end;
    label2.Caption:='';
    label3.Caption:='';
    chk1.Checked:=False;
    chk2.Checked:=False;
    Button2Click(Self);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
if MessageDlg(' Vuoi effettuare un reset ?',mtConfirmation,[mbYes,mbNo],0,mbYes)=mrYes then
                   begin
                     ABSTable1.Close;
                     ABSTable1.EmptyTable;
                     ABSTable1.Open;
                     ABSTable1.Edit;
                     Exit;
                   end else Exit;
end;

Procedure TForm1.finale(Sender: TObject);
begin
   with ABSQuery1 do
     begin
       SQL.Text:='Select * from scaler Order by "punti" desc';
       ExecSQL;
       Open;
     end;
     ABSTable1.Close;
     ABSTable1.EmptyTable;
     ABSTable1.Open;
     ABSQuery1.First;
     while not ABSQuery1.EOF do
     begin
       ABSTable1.Insert;
       ABSTable1.FieldByName('cosa').AsString:=ABSQuery1.FieldByName('cosa').AsString;
       ABSTable1.FieldByName('punti').AsInteger:=ABSQuery1.FieldByName('punti').AsInteger;
       ABSTable1.Post;
       ABSQuery1.Next;
     end;
     frxReport1.ShowReport;



end;

end.

unit Mancanti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm10 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label2: TLabel;
    Button5: TButton;
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;
  mncti:Boolean = False;

implementation

{$R *.dfm}
 uses
 Gara;
procedure TForm10.Button1Click(Sender: TObject);   //Categoria
begin
  Gara.mncat:=False;
  if Edit1.Text='' then
   begin
     Application.MessageBox('Non cè un dato da trasferire.', 'Attenzione',
       MB_OK + MB_ICONWARNING);
     Exit;
   end else
   begin
     if MessageDlg('Il Sistema non controlla la congruità del dato. ' + #13#10 +
       '   Vuoi inserire la Categoria ?',  mtConfirmation, [mbYes, mbNo], 0)=MrYes then
       begin
         Gara.mncat:=True;
         Gara.mancante:=StrToInt(edit1.Text);
         ShowMessage(' Clicca sul Cognome dell''atleta interessato.')
       end else
         Exit;
   end;
end;


procedure TForm10.Button2Click(Sender: TObject);  //Pettorale
begin
  Gara.mnpet:=False;
  if Edit1.Text='' then
   begin
     Application.MessageBox('Non cè un dato da trasferire.', 'Attenzione',
       MB_OK + MB_ICONWARNING);
     Exit;
   end else
   begin
     if MessageDlg('Il Sistema non controlla la congruità del dato. ' + #13#10 +
       '   Vuoi inserire il numero di Pettorale ?',  mtConfirmation, [mbYes, mbNo], 0)=MrYes then
       begin
         Gara.mnpet:=True;
         Gara.mancante:=StrToInt(edit1.Text);
         ShowMessage(' Clicca sul Cognome dell''atleta interessato.')
       end else
         Exit;
   end;
end;



procedure TForm10.Button3Click(Sender: TObject);   //Posizione
begin
  Gara.mnpos:=False;
  if Edit1.Text='' then
   begin
     Application.MessageBox('Non cè un dato da trasferire.', 'Attenzione',
       MB_OK + MB_ICONWARNING);
     Exit;
   end else
   begin
     if MessageDlg('Il Sistema non controlla la congruità del dato. ' + #13#10 +
       '   Vuoi inserire il numero di Posizione ?',  mtConfirmation, [mbYes, mbNo], 0)=MrYes then
       begin
         Gara.mnpos:=True;
         Gara.mancante:=StrToInt(edit1.Text);
         ShowMessage(' Clicca sul Cognome dell''atleta interessato.')
       end else
         Exit;
   end;
end;

procedure TForm10.Button4Click(Sender: TObject); //Esci
begin
  Form6.checkbox2.checked:=False;
  Form10.Hide;
end;

procedure TForm10.Button5Click(Sender: TObject);      //MANLEVA
begin
   Gara.mnmanl:=False;
  if Edit1.Text='' then
   begin
     Application.MessageBox('Non cè un dato da trasferire.', 'Attenzione',
       MB_OK + MB_ICONWARNING);
     Exit;
   end else
   begin
     if MessageDlg('Il Sistema non controlla la congruità del dato. ' + #13#10 +
       '   Vuoi modificare la Manleva ?',  mtConfirmation, [mbYes, mbNo], 0)=MrYes then
       begin
         if Edit1.Text='Si' then
            begin
              Gara.manleva:=True ;
              Gara.mnmanl:=True;
            end else
             if Edit1.Text='No' then
                begin
                 Gara.manleva:=False;
                 Gara.mnmanl:=True;
                end else
                 begin
                  Gara.manleva:=False;
                  Gara.mnmanl:=False;
                  ShowMessage(' Errore di inserimento (Si/No)') ;
                  Exit;
                  end;
         ShowMessage(' Clicca sul Cognome dell''atleta interessato.')
       end else
         Exit;
   end;
end;

end.

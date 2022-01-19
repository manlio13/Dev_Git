unit Tempi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,System.UITypes;

type
  TForm9 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Button3: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}
{$D+}
uses
Gara;
procedure TForm9.Button1Click(Sender: TObject);  //ACCETTA
begin
     inserisco7:=False;  //altrimenti se proviene da un precedente inserimento non consente
     if (Edit1.Text='') and (Edit2.Text ='') then  // 0 min 0 sec 0 ms
       begin
         ShowMessage('Nulla da accettare');
           if MessageDlg('Vuoi Uscire ?',
              mtconfirmation, [mbYes,mbNo], 0) = mrYes then
             begin
               hide;
               Exit;
             end
       end;
     if (Edit2.Text<>'') and (Length(Edit2.Text)<6) then
        begin
          ShowMessage('I secondi devono avere il formato YY,ZZZ');
          Exit;
        end;

     Gara.rab1:=False;  //i rab 1 o 2 sono flag se TempoA o B
     Gara.rab2:=False;  // rab3 = penalità
     Gara.rab3:=False;
     if (Edit1.Text<>'') and (Edit2.Text='') then  // 1 min 0 sec
       begin
         Edit3.Text:='';
         Edit3.Text:='00:'+Edit1.Text+':00,000';
        // Edit1.Text:='';
        // Edit2.Text:='';

       end;
     if (Edit1.Text='') and (Edit2.Text<>'') then  // 0 min 1 sec
       begin
         Edit3.Text:='';
         Edit3.Text:= '00:00:'+Edit2.Text;
         //Edit1.Text:='';
         //Edit2.Text:='';
       end;
     if (Edit1.Text<>'') and (Edit2.Text<>'') then  // 1 min 1 sec
       begin
         Edit3.Text:='';
         Edit3.Text:='00:'+Edit1.Text+':'+Edit2.Text;
         //Edit1.Text:='';
         //Edit2.Text:='';
       end;

    Gara.tempo:=Edit3.Text;
    if RadioButton1.Checked=True then
      Gara.rab1:=True;
    if RadioButton2.Checked=True then
      Gara.rab2:=True;
    if RadioButton3.Checked=True then
      Gara.rab3:=True;
   // RadioButton1.Checked:=True;
    if Edit3.Text<>'' then  //se c'è un tempo da caricare
    ShowMessage(' Clicca sul Cognome dell''atleta interessato.') else
      begin
        Application.MessageBox('Errore non previsto', 'Attenzione',
          MB_OK + MB_ICONWARNING);
        exit;
      end;


end;

procedure TForm9.Button3Click(Sender: TObject);   // Esci
begin
  Form9.hide;
end;

procedure TForm9.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) AND (length(edit2.text)<6) then
   showmessage('Il formato deve essere YY,ZZZ ');
end;

end.



{Programma per determinare il valore totale dei codici ASCII sommati di una
  data e di una stringa}
unit Coddata;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button6: TButton;
    Edit1: TEdit;
    Button4: TButton;
    Button5: TButton;
    Label1: TLabel;
    Button7: TButton;
    Button8: TButton;
    Edit2: TEdit;
    Button9: TButton;
    Button10: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  str,s :string[80];

  p,r: longint;
  n,m: integer;
  oggi,unadata,i: TdateTime;
  anno,mese,giorno : word;
  k,c,d,e: integer;
implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
{il valore della base 1.1.96 è 539033600}
begin
oggi := date;

messagedlg(' oggi è '+Datetostr(date),mtInformation,[mbok],0);
p:=dateTimetoFileDate(oggi)-539033600;
messagedlg('conv(oggi) rettificato è '+inttostr(p),mtInformation,[mbok],0);

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  m:=0;
  str:=inputbox('Digita','Nome e Cognome','');
  for n:=1 to length(str) do
m:= m+ord(str[n]);{per effettuare la valorizzazione è necessario l'array di 80}

  messagedlg('Il valore del nome è '+inttostr(m),mtinformation,[mbok],0);

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 oggi := date;

messagedlg('oggi hex è '+inttohex(p,9) ,mtInformation,[mbok],0);

end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 m:=0;
  for n:=1 to length(str) do
  m:= m+ord(str[n]);

  messagedlg('Il valore del nome hex è '+inttohex(m,9),mtinformation,[mbok],0);

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
d:= m+strtoint(edit1.text);
 messagedlg('Il valore del nome+cod hex è '+inttohex(d,9),mtinformation,[mbok],0);

end;

procedure TForm1.Button5Click(Sender: TObject);{determina il CFG}
begin
e:=strtoint(edit1.text);
r:= (m+e+datetimetofiledate(strtoDate(edit2.text))-539033600);
messagedlg('Il valore del nome+cod+oggi(rett) hex è '+inttohex(r,9),mtinformation,[mbok],0);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
p:=640+strtoint(edit1.text);
messagedlg('Il valore del pass dec. è '+inttostr(p),mtinformation,[mbok],0);
messagedlg('Il valore del pass hex è '+inttohex(p,9),mtinformation,[mbok],0);

end;

procedure TForm1.Button7Click(Sender: TObject);
{640 è oilnam decimale. pass = oilnam +cod}
begin
 r:=640+m+strtoint(edit1.text);
messagedlg('Il valore di REG hex è '+inttohex(r,9),mtinformation,[mbok],0);
end;
                                                      
procedure TForm1.Button9Click(Sender: TObject);
begin
unadata:=strToDate(edit2.text);

messagedlg('la data rett.è '+inttostr(datetimetoFileDate(unadata)-539033600),mtInformation,[mbok],0);
messagedlg('la data hex è '+inttohex((datetimetoFileDate(unadata)-539033600),9),mtInformation,[mbok],0);
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
i:=FileDatetoDateTime(strtoint(edit2.Text)+539033600);
messagedlg('la data è '+datetostr(i),mtInformation,[mbok],0);
end;

end.

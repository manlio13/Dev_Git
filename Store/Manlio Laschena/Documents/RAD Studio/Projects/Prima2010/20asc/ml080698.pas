unit Ml080698;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Combo1: TComboBox;
    Combo2: TComboBox;
    Combo3: TComboBox;
    Combo4: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    GroupBox2: TGroupBox;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    GroupBox3: TGroupBox;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    Edit1: TEdit;
    Label8: TLabel;
    Button1: TButton;
    Label9: TLabel;
    Edit2: TEdit;
    GroupBox4: TGroupBox;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    Label10: TLabel;
    Edit3: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Button2: TButton;
    Button3: TButton;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure RadioButton7Click(Sender: TObject);
    procedure RadioButton8Click(Sender: TObject);
    procedure Combo1Change(Sender: TObject);
    procedure Combo2Change(Sender: TObject);
    procedure Combo3Change(Sender: TObject);
    procedure Combo4Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioButton10Click(Sender: TObject);
    procedure RadioButton9Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  F1,F2,F3,F4:textfile;
   n,m,k,k1,k2,k3,k4,k5,k6,k7,V,PP,HO,ps,ui,uf:real;
   temp:array[1..21,1..2]of real;
   Peso:array[1..58,1..2]of real;
   Umin:array[1..20,1..2]of real;
   umfin:array[1..14,1..2]of real;
   A,H,NN,Z:longint;
   p,q:integer;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
 k:=3.3; {mono percorso}
 label3.caption:='Prelevo i dati dai files .dat';
 {primo file Temperatura}
 assignfile (F1,'.\temp.dat');
 reset(F1);
for p:=1 to 21 do
    begin
    read(F1,n,m);
    for q:=1 to 2 do
    if q=1 then
    temp[p,q]:=n
    else
    temp[p,q]:=m;
    end;
    closeFile(F1);
for p:=1 to 21 do
    combo1.items.add(floattostr(temp[p,1]));

  {secondo file Peso}

    assignfile (F2,'.\Peso.dat');
    reset(F2);
for p:=1 to 58 do
    begin
    read(F2,n,m);
    for q:=1 to 2 do
    if q=1 then
    Peso[p,q]:=n
    else
    Peso[p,q]:=m;
    end;
    closeFile(F2);
for p:=1 to 58 do
    Combo2.items.add(floattostr(Peso[p,1]));

  {terzo file Umin}

    assignfile (F3,'.\Umin.dat');
    reset(F3);
for p:=1 to 20 do
    begin
    read(F3,n,m);
    for q:=1 to 2 do
    if q=1 then
    Umin[p,q]:=n
    else
    Umin[p,q]:=m;
    end;
    closeFile(F3);
for p:=1 to 20 do
    Combo3.items.add(floattostr(Umin[p,1]));

  {quarto file umfin }

    assignfile (F4,'.\Umfin.dat');
    reset(F4);
for p:=1 to 14 do
    begin
    read(F4,n,m);
    for q:=1 to 2 do
    if q=1 then
    Umfin[p,q]:=n
    else
    Umfin[p,q]:=m;
    end;
    closeFile(F4);
for p:=1 to 14 do
    Combo4.items.add(floattostr(Umfin[p,1]));

 label3.caption:='I dati sono disponibili: effettuare le selezioni';

end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin                {poliestere-acrilico-nylon}
k5:=1.4;
RadioButton2.checked:=false;
RadioButton3.checked:=false;
RadioButton4.checked:=false;
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
   begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end
else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin                      {lana}
k5:=1.3;
RadioButton1.checked:=false;
RadioButton3.checked:=false;
RadioButton4.checked:=false;
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
 begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end
else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin                      {cotone}
k5:=1.0;
RadioButton1.checked:=false;
RadioButton2.checked:=false;
RadioButton4.checked:=false;
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end

else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

procedure TForm1.RadioButton4Click(Sender: TObject);
begin                      {viscosa-seta}
k5:=0.8;
RadioButton1.checked:=false;
RadioButton2.checked:=false;
RadioButton3.checked:=false;
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end

else
label3.caption:=' Tutti i dati sono stati forniti ';
end;


procedure TForm1.RadioButton5Click(Sender: TObject);
begin                      {maglia}
k6:=1;
RadioButton6.checked:=false;
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end

else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

procedure TForm1.RadioButton6Click(Sender: TObject);
begin                       {trama-ordito}
k6:=0.9;
RadioButton5.checked:=false;
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end

else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

procedure TForm1.RadioButton7Click(Sender: TObject);
begin                            {tubolare}

{RadioButton8.checked:=false;}
k7:=1;
A:=2;
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end

else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

procedure TForm1.RadioButton8Click(Sender: TObject);
begin                           {aperto}
k7:=1.7;
A:=1;
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end

else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

procedure TForm1.Combo1Change(Sender: TObject);
begin         {temperatura}
k2:=temp[combo1.itemindex+1,2];
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end

else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

procedure TForm1.Combo2Change(Sender: TObject);
begin         {peso}
k1:=Peso[combo2.itemindex+1,2];
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end

else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

procedure TForm1.Combo3Change(Sender: TObject);
begin         { umidità iniziale}
k3:=umin[combo3.itemindex+1,2];
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end

else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

procedure TForm1.Combo4Change(Sender: TObject);
begin         {umidità finale}
k4:=umfin[combo4.itemindex+1,2];
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end

else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
if edit1.text=''then     {larghezza pezza}
 H:=0 else
H:=strtoint(edit1.text);
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end

else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
if edit2.text='' then    {num. di pezze}
NN:=0 else
NN:=strtoint(edit2.text);
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
begin
      label3.caption:='  Attenzione manca uno o più dati !';
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
   end

else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin          {velocita'}
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
begin
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
messagedlg('mancano uno o più dati',mtInformation,[mbOK],0);
exit;
end;
label11.visible:=true;
V:=k*k1*k2*k3*k4*k5*k6*k7*Z;
label12.caption:=formatfloat('0.00',V) + ' m/min'


end;



procedure TForm1.RadioButton10Click(Sender: TObject);
begin
k:=6;        {doppio percorso}
end;

procedure TForm1.RadioButton9Click(Sender: TObject);
begin
k:=3.3;       {mono percorso}
end;

procedure TForm1.Button2Click(Sender: TObject);
begin        {asciugato}
 if label3.caption<>' Tutti i dati sono stati forniti 'then
begin
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
messagedlg('mancano uno o più dati',mtInformation,[mbOK],0);
exit;
end;
V:=k*k1*k2*k3*k4*k5*k6*k7*Z;
ps:=Peso[combo2.itemindex+1,1];
label13.visible:=true;
PP:=NN*H*A*60*v*ps/100000;
label14.caption:=formatfloat('0.00',PP) + ' Kg/h';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin     {evaporato}

  if label3.caption<>' Tutti i dati sono stati forniti 'then
begin
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
messagedlg('mancano uno o più dati',mtInformation,[mbOK],0);
exit;
end;
V:=k*k1*k2*k3*k4*k5*k6*k7*Z;
ps:=Peso[combo2.itemindex+1,1];
PP:=NN*H*A*60*v*ps/100000;
ui:=umin[combo3.itemindex+1,1];
uf:=umfin[combo4.itemindex+1,1];
label15.visible:=true;
HO:=PP*(ui-uf)/(100+uf);
label16.caption:=formatfloat('0.00',HO) + ' Kg/h';

end;

procedure TForm1.Edit3Change(Sender: TObject); {zone}
begin
if edit3.text='' then    {num. di zone}
Z:=0 else
Z:=strtoint(edit3.text);
if k1*k2*k3*k4*k5*k6*k7*H*NN*Z=0 then
      begin
      label12.caption:='';
      label14.caption:='';
      label16.caption:='';
label3.caption:='  Attenzione manca uno o più dati !';
       end
else
label3.caption:=' Tutti i dati sono stati forniti ';
end;

end.

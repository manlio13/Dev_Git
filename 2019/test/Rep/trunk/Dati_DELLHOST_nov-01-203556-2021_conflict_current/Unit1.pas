unit Unit1;                  //versione 6

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExControls, JvColorBox,
  JvColorButton, Vcl.Buttons, JvExButtons, JvButtons;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Label2: TLabel;
    Button2: TButton;
    JvHTButton1: TJvHTButton;
    Edit6: TEdit;
    Button1: TButton;
    Button3: TButton;
    Edit7: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure JvHTButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  Form1: TForm1;
  salta:Boolean=False;
  mg,kn,lh,L,q:double;
   H,h1,h2,ore:TDateTime;
  hour,min,hour1,min1:Word;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);// stesso message -0.5 L/h
var
lhmeno:Double;
begin
  mg:=StrToFloat(Edit1.text);
  kn:=StrToFloat(Edit2.Text);
  lhmeno:=lh-0.5;
  lh:=lhmeno;
  q:=StrToFloat(Edit6.text)/100;
  H:=mg/kn;
  hour:=Trunc(H);
  min:=Round(Frac(H)*60);

  Edit4.Text:=TimeToStr(EncodeTime(hour, min, 0, 0));
  L:=lhmeno*(H*q);
  Edit5.Text:=FormatFloat('#.##',L);
  Edit3.Text:=FloatToStr(lhmeno);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TForm1.Button3Click(Sender: TObject); // stesso ma +0,5 L/h
Var
lhpiu:Double;
begin
  mg:=StrToFloat(Edit1.text);
  kn:=StrToFloat(Edit2.Text);
  lhpiu:=lh+0.5;
  lh:=lhpiu;
  q:=(StrToFloat(Edit6.text))/100;
  H:=mg/kn;
  hour:=Trunc(H);
  min:=Round(Frac(H)*60);

  Edit4.Text:=TimeToStr(EncodeTime(hour, min, 0, 0));
  L:=lhpiu*(H*q);
  Edit5.Text:=FormatFloat('#.##',L);
  Edit3.Text:=FloatToStr(lhpiu);

end;

procedure TForm1.FormCreate(Sender: TObject);

  begin

     Form1.Visible:=True;
     if salta=False then
     begin
       if MessageDlg('Inserisci i dati MG-KN-LH',
       mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrNo then Application.Terminate;
      Edit1.text:=inputbox('Dati','Miglia da percorrere','');
      Edit2.Text:=InputBox('Dati','Velocit� in nodi','6');
      Edit3.Text:=InputBox('Dati','Consumo in litri all''ora','3');
      Edit6.Text:=InputBox('Dati','% uso del motore >0,X ','80');
     end;

     if MessageDlg('Pronto ?',
     mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
         begin
            mg:=StrToFloat(Edit1.text);
            kn:=StrToFloat(Edit2.Text);
            lh:=StrToFloat(Edit3.text);
            q:=StrToFloat(Edit6.text)/100;
            H:=mg/kn;
            hour:=Trunc(H);
            min:=Round(Frac(H)*60);
            Edit4.Text:=TimeToStr(EncodeTime(hour, min, 0, 0));
            L:=lh*(H*q);
            Edit5.Text:=FormatFloat('#.##',L);
            h1:=H*0.9;
            h2:=H*1.1;
            hour:=Trunc(h1);
            min:=Round(Frac(h1)*60);
            hour1:=Trunc(h2);
            min1:=Round(Frac(h2)*60);
            Edit7.Text:='da '+TimeToStr(EncodeTime(hour, min, 0, 0))+' a '+
            TimeToStr(EncodeTime(hour1, min1, 0, 0));
          end else Exit;


   end;


procedure TForm1.JvHTButton1Click(Sender: TObject);  //Ripeti

  var
   value1,value2,value3,value4:string;

  begin
    Edit1.text:='';
    Edit2.text:='';
    Edit3.text:='';
    Edit4.text:='';
    Edit5.text:='';
    Edit6.text:='';
    Edit7.text:='';
    salta:=True;
   if inputquery('Dati bis','Miglia da percorrere',value1)=True then
   Edit1.Text:=value1;
   if inputquery('Dati bis','Velocit� in nodi',value2)=True then
   Edit2.Text:=value2;
    if inputquery('Dati bis','Consumo in litri all''ora',value3)=True then
   Edit3.Text:=value3;
   if inputquery('Dati bis','% uso del motore es:80 ',value4)=True then
   Edit6.Text:=value4;
    FormCreate(Self);
  end;

end.

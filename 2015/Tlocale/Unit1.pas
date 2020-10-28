unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,System.DateUtils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FormStr:TFormatSettings;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
             Label1.Caption:=' Prove di estrazione formati di default Windows 7';
             Label1.Visible:= True;
end;

procedure TForm1.Button1Click(Sender: TObject);
  var
  Loc01,Loc02,Loc03:string;
  miodato:TDateTime;
  H,M,S,MM:Word;
begin
 Loc01:=InputBox('Inserisci LCID','=','1040');  //default italia
 GetLocaleFormatSettings(StrToInt(Loc01), FormStr);
 ListBox1.AddItem(CurrToStrF(1234.5678, ffCurrency, 4, FormStr),nil);
 ListBox1.AddItem(DateTimeToStr(Now,FormStr),nil);
 Loc02:=FormStr.LongTimeFormat;
 //FormStr.LongTimeFormat := 'hh nn ss.zzz';
 //ListBox1.AddItem(DateTimeToStr(Now,FormStr),nil);
 ListBox1.AddItem(Loc02,nil);
 ListBox1.AddItem(FormatDateTime('tt', Now),nil);
  miodato:=Now;
  System.SysUtils.DecodeTime(miodato,H,M,S,MM);
  Loc03:=IntToStr(H)+':'+IntToStr(M)+':'+IntToStr(S)+'.'+IntToStr(MM);
  ListBox1.AddItem(Loc03,nil);
end;

    procedure TForm1.Button2Click(Sender: TObject);    //Esci
begin
    Application.Terminate;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   ListBox1.Clear;
end;

end.

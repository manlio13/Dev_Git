unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,iniFiles,DateUtils;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  procedure WMNCHitTest(var Msg: TWMNCHitTest) ; //per emulare mouseclick su form
  message WM_NCHitTest;       // al click sulla barra menù
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  myini:Tinifile;
  fusoN:Integer;
  fuso0:integer ;
  dir:string;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin   //gestione dell'ini file che contiene i fusi orari di riferimento
      dir:=GetCurrentDir+'\';
      if FileExists(dir+'fuso.ini')=True then
      begin
        myini:=TIniFile.Create(dir+'fuso.ini');
        fusoN:=StrToInt( myini.ReadString('dato','fuso',''));
        fuso0:=StrToInt(myini.ReadString('dato','locale',''));
      end else //il file ini non esiste
        begin
          myini:=TIniFile.Create(dir+'fuso.ini');
          fusoN:= StrToInt(inputBox('Inserisci il fuso orario desiderato+/-','GMT +/-','-5'));
          myini.WriteString('dato','fuso',IntToStr(fusoN));
          fuso0:= StrToInt(inputBox('Inserisci il fuso orario del Sistema +/-','GMT +/-','+1'));
          myini.WriteString('dato','locale',IntToStr(fuso0));
        end;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin                 //per uscire Ctrl+C
    if Key = ^C then
    begin
      Application.Terminate;
    end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
  var        //settaggio dell'orario da esporre
 k:Integer;
 ora: TDateTime;
begin
     k:=(fusoN-fuso0);
     k:=k*60;
     ora:=Time;
     ora:=incminute(Time,k); //togli/aggiungi minuti
     Label1.Caption := TimeToStr(ora);
end;

procedure TForm1.WMNCHitTest(var Msg: TWMNCHitTest) ;
begin
    inherited;                     // crea l'emulazione della "caption/menubar"
    if Msg.Result = htClient then  // che manca, per poter effettuare un drag.
     Msg.Result := htCaption;
end;
end.

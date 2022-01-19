unit ml990403;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    leggi: TButton;
    OpenDialog1: TOpenDialog;
    scrivi: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    procedure leggiClick(Sender: TObject);
    procedure scriviClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
implementation

{$R *.DFM}
//per leggere le date-tempo
function FileTimeToStr(FT:TfileTime):String;
const DTFmt='dd/mm/yyyy hh.mm.ss';
var
LocalFT:TFileTime;
IDT    :Integer;
begin
FileTimeToLocalFileTime(FT,LocalFT);
FileTimeToDosDateTime(LocalFT,LongRec(IDT).Hi,LongRec(IDT).Lo);
DateTimeToString(Result,DTFmt,FileDateToDateTime(IDT));//procedura
end;
procedure TForm1.leggiClick(Sender: TObject);
const MsgFileNoCorrect='Errore di lettura. File: %s';
var
FS1:TFileStream;
FT1,FT2,FT3: TFileTime;
begin
with OpenDialog1 do
if execute then

 try
FS1:=TFileStream.Create(FileName,fmOpenRead);
label1.caption:=filename;
   try
GetFileTime(FS1.Handle,@FT1,@FT2,@FT3);
   Edit1.text:=FileTimeToStr(FT1);//creazione
   Edit2.text:=FileTimeToStr(FT2);//ultimo accesso
   Edit3.text:=FileTimeToStr(FT3);//ultima modifica
   finally
   FS1.Free;
   end;
 Except
      MessageDlg(Format(MsgFileNoCorrect,[FileName]),mtError,[mbOK],0);
 end;
end;

//per scrivere le date-tempo
function StrToFileTime(Cap:String):TfileTime;
var
DT:TdateTime;
DDT:Integer;
LocalSFT:TfileTime;
begin
DT:=StrToDateTime(Cap);
DDT:=DateTimetoFileDate(DT);
DosDateTimeToFileTime(longRec(DDT).Hi,LongRec(DDT).Lo,LocalSFT);
LocalFileTimetoFileTime(LocalSFT,result);//att.la funzione esce su 'result',
//quindi se non dichiaro che result è = ad una variabile,non posso usarla in
//luogo di result.Era sbagliato usare SFT !
end;
procedure TForm1.scriviClick(Sender: TObject);
const MsgFileNoCorrect='Errore di scrittura. File: %s';
var
FS2:Tfilestream;
SFT1,SFT2,SFT3:TfileTime;
begin
with OpenDialog1 do
if execute then

try
FS2:=TfileStream.Create(FileName,fmOpenWrite);
label1.caption:=filename;
   try
SFT1:=StrToFileTime(Edit1.text);
SFT2:=StrToFileTime(Edit2.text);
SFT3:=StrToFileTime(Edit3.text);
SetFileTime(FS2.handle,@SFT1,@SFT2,@SFT3);
    finally
    FS2.Free;
    end;
except
MessageDlg(Format(MsgFileNoCorrect,[FileName]),mtError,[mbOK],0);
end;
end;

end.

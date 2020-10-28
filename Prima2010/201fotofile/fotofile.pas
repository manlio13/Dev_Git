unit fotofile;
 //Programma per convertire il nomefile in yymmddhhmmss.jpg dai dati di creazione del file stesso
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    apri: TButton;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure apriClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
//Funzione occorrente per leggere le date-tempo.Dato l'FT (fileTime) ottiene la stringa
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

procedure TForm1.apriClick(Sender: TObject);
  const MsgFileNoCorrect='Error on - file: %s';
  var
  FS1:TFileStream;
  nomi,datatempo :Array[1..100] of string;
  s,est,lb1,lb2,lb3: string;
  indice,fa :integer;
  sr:TsearchRec;
begin
fa:=0;
 with OpenDialog1 do
  if execute then
  try
   FS1:=TFileStream.Create(FileName,fmOpenRead);
   lb1:=ExtractFilePath(OpenDialog1.FileName); //Ottiene la dir sulla quale operare
   est:=extractFileExt(OpenDialog1.FileName);
   if findfirst(lb1+'*.*',fa,sr)= 0 then
    begin //raccoglie dalla directory i nomi ed i tempi dei file e li pone in due array
      indice:=1;

      repeat
      label5.caption:=inttostr(indice);
      nomi[indice]:=sr.name ;
      lb3:=nomi[indice]; //file in lettura
      with sr.FindData do //metodo per accedere a FindData ed ottenere i dati di un file da findfirst
      s:=FiletimeToStr(ftcreationTime);//datatempo di creazione del file in lettura
      datatempo[indice]:=copy(s,9,2)+copy(s,4,2)+copy(s,1,2)+copy(s,12,2)+copy(s,15,2)+copy(s,18,2);
      lb2:=datatempo[indice]+est; //nuovo nome ottenuto dalla datatempo di creazione
      indice:=indice+1;
      if indice=101 then
      begin
      messagedlg('Too many files. Maximum 100 files',MtError,[mbOK],0);
      break;
      end;
     until
      FindNext(sr) <> 0;

    FindClose(sr);
    FS1.Free
    end
   else
     MessageDlg('Directory error',mtError,[mbOK],0);
  Except
     MessageDlg(Format(MsgFileNoCorrect,[FileName]),mtError,[mbOK],0);
  end;
  label7.Caption:= lb1;
  label8.Caption:= lb3;
  label9.Caption:= s;
  label10.Caption:=lb2;
  if messagedlg('Rinomino tutti i file  - All files will be renamed',MTConfirmation,[mbYes,mbNo],0)=mrNo
  then
   Application.Terminate
  else
  begin
    indice:=1;

    repeat
    label5.Caption:='Renamed '+inttostr(indice);
     try
    if FileExists(lb1+datatempo[indice]+est)then
      begin // poichè il time stamp può essere reso identico dalla imprecisione accertata di findfirst
      //Borland rispetto a FindFirst Win, si prevedono fino a tre timestamp identici.
       if FileExists(lb1+datatempo[indice]+'b'+est)then
       renamefile(lb1+nomi[indice],lb1+datatempo[indice]+'c'+est)
       else
       renamefile(lb1+nomi[indice],lb1+datatempo[indice]+'b'+est);
     end else
    renamefile(lb1+nomi[indice],lb1+datatempo[indice]+est);
    indice:=indice+1;
     except
    messagedlg('Files not renamed '+nomi[indice],mtError,[mbOK],0);
     end;
    until
    nomi[indice]='';
  end;
end;
end.


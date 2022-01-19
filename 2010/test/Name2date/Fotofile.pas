  unit Fotofile;
//Programma per convertire il nome file in yymmddhhmmss.jpg dai dati di creazione del file stesso
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls ;

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
         Button1: TButton;
    Button2: TButton;
    
         Procedure apriclick(Sender: TObject);
         Procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
    //Funzione occorrente per leggere le Date-Tempo. Dato l'FT (filetime) ottiene la stringa

  function FileTimeToStr(FT:TFileTime):String;
           const DTFmt='dd/mm/yyyy hh.mm.ss';
           var
           LocalFT:TFileTime;
           IDT    :Integer;
  begin
    FileTimeToLocalFileTime(FT,LocalFT);
    FileTimeToDosDateTime(LocalFT,LongRec(IDT).Hi,LongRec(IDT).Lo);
    DateTimeToString(Result,DTFmt,FileDateToDateTime(IDT)); //funzione
  end;

  Procedure TForm1.apriClick(Sender: TObject);
           const MsgFileNoCorrect='Error on - file:%s';
           var
           FS1:TFileStream;
           nomi,datatempo :Array[1..500]of string;
           quanti: Array[1..500]of integer;
           s,est,lb1,lb2,lb3: string;
           indice,fa,x,y,k,maxind :integer;
           sr :TSearchRec;
    begin
       fa:=0;
    with OpenDialog1 do
    if execute then
  try
       FS1:= TFileStream.Create(FileName,fmOpenRead);
       lb1:=ExtractFilePath(OpenDialog1.FileName);//Ottiene la Dir sulla quale operare
       est:=ExtractFileExt(OpenDialog1.FileName);
       if findfirst(lb1+'*.*',fa,sr)=0 then
    begin  //raccoglie dalla cartella i nomi ed i tempi dei files e li pone nelle due array "nomi" e "datatempo"
       indice:=1;
    repeat
       label5.caption:=inttostr(indice);
       nomi[indice]:=sr.name;
       lb3:=nomi[indice];  //file in fase di lettura
    with sr.FindData do  //metodo per accedere a FindData ed ottenere i dati di un file da FindFirst
       s:=FileTimeToStr(ftCreationTime); // datatempo di creazione del file in lettura ottenuta con chiamata alla Funzione precedente
       datatempo[indice]:= copy(s,9,2)+copy(s,4,2)+copy(s,1,2)+copy(s,12,2)+copy(s,15,2)+copy(s,18,2);
       lb2:=datatempo[indice]+est; //NUOVO NOME
       indice:=indice+1;
                        if indice=501 then
                        begin
                        messagedlg('Too many files. Maximum 500 files',MTError,[mbOK],0);
                        break;
                        end;
    until
       FindNext(sr)<>0;
       maxind:=indice-1;
       FindClose(sr);
       FS1.Free
    end else
        Messagedlg('Directory Error',mtError,[mbOK],0);
  except
        Messagedlg(Format(MsgFileNoCorrect,[FileName]),mtError,[mbOK],0);
  end;
        label7.Caption:=lb1;
        label8.Caption:=lb3;
        label9.Caption:=s;
        label10.Caption:=lb2;

    if messagedlg('All files will be renamed',MTConfirmation,[mbYes,mbNo],0)=mrNo
    then
        begin
        Application.Terminate;
        exit;
        end
    else
        for x:=1 to 500 do // ricerca i doppioni e costruisce l'array "quanti"
            quanti[x]:=0;
            for x:=1 to maxind do
            begin
                 if quanti[x]>0 then  //se il file è stato già esaminato
                 continue;
                 k:=0;
                 for y:=x+1 to maxind do
                 begin
                      if quanti[y]>0 then   //se il file è già stato esaminato
                      continue;
                      if datatempo[x]=datatempo[y] then
                      begin
                           k:=k+1;
                           quanti[y]:=k;
                      end;
                 end;
            end;
        try                   //nomina
        for indice:=1 to maxind do
            if quanti[indice]=0 then
            renamefile(lb1+nomi[indice],lb1+datatempo[indice]+est)
            else
            renamefile(lb1+nomi[indice],lb1+datatempo[indice]+'_'+inttostr(quanti[indice])+est);
        except
            messagedlg('Files not renamed' + nomi[indice],mtError,[mbOK],0);
            indice:=0;
        end;
        label5.caption:='Renamed '+inttostr(indice-1);
    end;
    Procedure TForm1.Button1Click(Sender: TObject);
    begin
    application.Terminate;
    end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    Application.HelpFile:='C:\utenti\Manlio Laschena\dev\2010\Name2Date\n2d.chm';
    Application.HelpCommand(HELP_FINDER,0);
end;

end.

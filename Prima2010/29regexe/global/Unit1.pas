unit Unit1;  //totpw301.exe chiave totale per Ricorda 3.01.10

interface

uses
  Windows, SysUtils, Classes,Controls, Forms,Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
fhandle,prima:integer;
F:file;
fl:string[8];
li:longint;
esiste:boolean;
begin
Fhandle:=Fileopen('Ricorda.exe',0);  //cattura gli attributi di prima
 prima:=FileGetDate(Fhandle);
 FileClose(Fhandle);
         {$I-}
         AssignFile(F,'Ricorda.exe');
         Reset(F,1);
          {$I+}
         esiste:=IOResult=0;
         li:=$45DD8   ;    //att.indirizzo di scrittura
         fl:='03/03/03'; //codice di registrazione
         Seek(F,li);
         BlockWrite(F,fl,sizeof(fl));
         CloseFile(F);
 Fhandle:=Fileopen('Ricorda.exe',$0002);  //ricopia gli attributi di prima
 FileSetDate(Fhandle,prima);
 FileClose(Fhandle);
 ShowMessage('La sua copia di Ricorda è stata registrata.');
 Application.terminate;
end;

end.





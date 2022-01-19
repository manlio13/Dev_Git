unit Ml970103;
{PROGRAMMA PER RICERCARE UNA DIRECTORY ED IL SUO DRIVE DI APPARTENENZA
 CON LA CONDIZIONE CHE LA DIRECTORY SIA DI PRIMO LIVELLO ie non subdirectory}
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
 result,k: integer;
  ricerca: Tsearchrec;
  dove,cosa:string;
implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  {cosa:='WINDOWS';}
cosa:=inputbox('digita','cosa cercare','');  

                   for k:=0 to 7 do
                   begin
  dove:=CHR(67+k)+':\*.*';
  {inputbox('digita','dove cercare','');}
   label1.caption:='';
   label2.caption:='';
 result:=FindFirst(dove,$10,ricerca);
                  if ricerca.name=cosa then
                  begin
                  Label1.Caption := ricerca.Name;
                  label2.Caption:=copy(dove,1,3);
                  exit;
                  end;
 try
 while result=0 do
 begin
 result:=FindNext(ricerca);
                  if ricerca.name=cosa then
                  begin
                  Label1.Caption := ricerca.Name;
                  label2.Caption:=copy(dove,1,3);
                  exit;
                  end;

  end;
 FindClose(ricerca);
 except
 messagedlg('problemi!',mtwarning,[mbok],0);
 end;
end;

                   end;

end.

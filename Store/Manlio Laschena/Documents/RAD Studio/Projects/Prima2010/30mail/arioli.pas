unit Arioli;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Edit3: TEdit;
    Memo1: TMemo;
    Label5: TLabel;
    Label6: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
f:textFile;
s:string;
n,k:integer;
begin
n:=0;
s:=combobox1.text+edit3.text+'.txt';
AssignFile(f,s);
Rewrite(f);
writeln(f,'email emessa il  '+datetostr(date)+' alle '+Timetostr(time));
writeln(f,'-------');
writeln(f,'inviare a : '+edit1.text);
writeln(f,'mittente  : '+edit2.text);
writeln(f,' ------  segue testo ------');
n:= memo1.lines.count ;
for k:=0 to n do
writeln(f,memo1.lines[k]);
writeln(f,' ------  fine testo -------');
if edit4.text<>'' then
writeln(f,'Attenzione allegare i files: '+edit4.text);
closefile(f);
showmessage('OK consegnare il dischetto al centralino.');

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Application.terminate;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
if activecontrol<>memo1 then
if key=#13 then
begin
key:=#0;
Perform(Wm_NextDlgCtl,0,0);
end;
end;

end.

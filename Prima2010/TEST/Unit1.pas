unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,shellapi;

type
  TForm1 = class(TForm)
    Button1: TButton;

    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  
var
  Form1: TForm1;
  p,pp:Pchar;
ss, s:string;
  hnd :Hicon;
implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);

begin
icon:=Application.icon;
hnd:=icon.handle;
s:='About Ricorda32# Italia - Milano - mlsoft';
ss:='Ricorda32  versione 3.01';
p:=Pchar(s);
//font.size:=24;
pp:=Pchar(ss);
shellabout(0,p,pp,hnd);
end;

end.

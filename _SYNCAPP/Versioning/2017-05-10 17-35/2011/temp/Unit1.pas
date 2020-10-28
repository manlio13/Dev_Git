unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
 data:tdatetime ;
 s:string;
 n:double;
 k,kk,p,pp:integer;
implementation


{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
s:=edit1.Text;
data:=strtodatetime(s);
 edit1.Text:='';
 n:=frac(data)*24;
 edit1.Text:=  floattostr(n);

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
s:=edit1.Text;
k:=length(s);
kk:=pos(':',s);
if kk>0 then
begin
 edit2.Text:='';
 edit2.Text:=copy(s,1,kk-1);
 p:=strtoint(edit2.Text);
 n:=p/24;
pp:=trunc(n);
 edit1.Text:=inttostr(pp);
 edit3.Text:=copy(s,kk+1,k);
 p:=p-(pp*24);
 edit4.Text:=inttostr(p);
end else
 begin
p:=strtoint(edit1.Text);
 n:=p/24;
pp:=trunc(n);
 edit1.Text:=inttostr(pp);

 end;


end;

end.

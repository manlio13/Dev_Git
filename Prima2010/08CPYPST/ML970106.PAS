unit Ml970106;
{ routine per portare sulla clipboard un memo}
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    memo1: TMemo;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a,b,c,d :string;

implementation

{$R *.DFM}


procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 a:='Dott.';
 b:='Pippo';
 c:='Franco';
 d:='Valle della Loira 23';
 memo1.text:='';
 memo1.lines.add(a);
 memo1.lines.add(b+' '+c);
 memo1.lines.add(d);
 memo1.selectall;  {è indispensabile selezionare per poterlo copiare
                   sulla clipboard}
 memo1.copytoclipboard;
end;

end.

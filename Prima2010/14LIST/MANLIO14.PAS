unit Manlio14;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Edit1: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  s:string;

  const
  p='pippo';
implementation

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
begin
listbox1.items.add(p);
listbox1.items.add('caio');
listbox1.items.add('sempronio');




end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
var k:integer;
begin
for k:=0 to (listbox1.items.count-1) do
 if listbox1.selected[k] then
edit1.text:=listbox1.items[k];
end;

end.

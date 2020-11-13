unit euro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TEuroLit = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EuroLit: TEuroLit;

implementation

{$R *.dfm}

procedure TEuroLit.Button1Click(Sender: TObject);
begin
  Edit2.Text:= FormatFloat('### ### ###',(strtoFloat(Edit1.Text)*1936.27))
end;

procedure TEuroLit.Button2Click(Sender: TObject);
begin
  Edit2.Text:= FormatFloat('# ###.##',(strtofloat(Edit1.Text)/1936.27))
end;

procedure TEuroLit.Button3Click(Sender: TObject);
begin
edit2.Text:='' ;
edit1.Text:='' ;
edit1.setfocus; 
end;

end.

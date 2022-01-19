unit Ml970130;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  type
      treg=record
      pw:integer;
      reg:integer;
      cfg:longint;
      dat:integer;
      user:string;
  end;


var
  Form1: TForm1;
  reg1,pw1,dat1:integer;
  cfg1:longint;
  user1:string;
  dato:treg;
  F:file of treg;

implementation

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
begin

 AssignFile(F,'.\REGISTRA.DAT');
 reset(F);
 read(F,dato);
 

       edit1.text:=inttostr(dato.pw);
       edit2.text:=intTostr(dato.reg);
       edit3.text:=inttostr(dato.cfg);
       edit4.text:=inttostr(dato.dat);
       edit5.text:=dato.user;

 closefile(F);


end;

end.

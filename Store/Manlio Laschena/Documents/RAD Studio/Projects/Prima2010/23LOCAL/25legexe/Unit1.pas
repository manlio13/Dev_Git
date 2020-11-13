unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
    F :File;
         nf:string;
         fl :string[8]; //e' indispensabile dare un num.dicar.eguale nell'exe
         nr :integer;
         li :longint;
         d,delta:TdateTime;
         esiste:boolean;
implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
label1.caption:='il form esiste'
end;




procedure TForm1.Button1Click(Sender: TObject);
begin
 Begin
              nf :='c:\fls\dev\24reg\reg01.exe';
              li:= $30358;
          // for li:=$2EE50 to $2EE58 do
       begin
              //Result:=False;
              {$I-}
              AssignFile(F,nf);
              Reset(F,1);
              {$I+}
              esiste:=IOResult=0;

              Try
                 Seek(F,li);
                 BlockRead(F,fl,sizeof(fl),nr);

              Finally
                     CloseFile(F)
               End;
               showmessage('leggo  '+fl);
               d:=strtodate(fl);
               delta:=date()-d;
     end;
          end;
end;

procedure TForm1.Button2Click(Sender: TObject);// scrivo registrato
var
 fl2:string[8];
begin
              nf :='c:\fls\dev\24reg\reg01.exe';
              AssignFile(F,nf);
              Reset(F,1);
              {$I+}
              esiste:=IOResult=0;
               fl2:='02/02/02';
              Try
                 Seek(F,li);
                 BlockWrite(F,fl2,sizeof(fl2));

              Finally
                     CloseFile(F)
               End;
               showmessage('leggo  '+fl2)
end;

procedure TForm1.Button3Click(Sender: TObject);

var
 fl2:string[8];
begin
              nf :='c:\fls\dev\24reg\reg01.exe';
              AssignFile(F,nf);
              Reset(F,1);
              {$I+}
              esiste:=IOResult=0;
               fl2:=datetostr(date);
              Try
                 Seek(F,li);
                 BlockWrite(F,fl2,sizeof(fl2));

              Finally
                     CloseFile(F)
               End;
               showmessage('leggo  '+fl2)
end;



end.

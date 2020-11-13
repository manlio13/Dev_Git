unit Ml970131;
{prove sul componente Tcalendar}
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Grids, Calendar, StdCtrls, Spin, ExtCtrls;

type
  TForm1 = class(TForm)
    Calendar1: TCalendar;
    SpinButton1: TSpinButton;
    SpinButton2: TSpinButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    procedure Calendar1Click(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton2DownClick(Sender: TObject);
    procedure SpinButton2UpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   g:tdatetime;
   s:string;
implementation

{$R *.DFM}

procedure TForm1.Calendar1Click(Sender: TObject);
begin
{att.the on event must be 'on change' otherwise
 the date collected is related to the day before}
 s:= datetostr(calendar1.calendardate);
 label3.caption:=s;
 label4.caption:=timetostr(time);
 label1.caption:=inttostr(calendar1.year);
 label2.caption:=inttostr(calendar1.month);
end;

procedure TForm1.SpinButton1DownClick(Sender: TObject);
begin
Calendar1.prevyear;
 label1.caption:=inttostr(calendar1.year);
end;

procedure TForm1.SpinButton1UpClick(Sender: TObject);
begin
  Calendar1.nextyear;
 label1.caption:=inttostr(calendar1.year);
end;

procedure TForm1.SpinButton2DownClick(Sender: TObject);
begin
 Calendar1.prevmonth;
 label2.caption:=inttostr(calendar1.month);
end;

procedure TForm1.SpinButton2UpClick(Sender: TObject);
begin
 Calendar1.nextmonth;
 label2.caption:=inttostr(calendar1.month);
end;

end.

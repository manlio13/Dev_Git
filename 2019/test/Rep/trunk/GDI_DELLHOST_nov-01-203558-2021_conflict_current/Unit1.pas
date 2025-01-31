unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure DrawLines(Sender:TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  const NUM_LINES = 20;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 // initialise the random
  // number generator
  Randomize;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     DrawLines(Self);
end;

procedure TForm1.DrawLines;
var
  i: Integer;
begin
  for i := 0 to NUM_LINES - 1 do
  begin
    Canvas.Pen.Color :=
         RGB(Random(256),
             Random(256),
             Random(256)
             );
    Canvas.LineTo
       (Random(ClientWidth),
        Random(ClientHeight));
  end;

end;

 procedure TForm1.Button2Click(Sender: TObject);         //Clear
begin
   with Form1 do
     PatBlt(Canvas.Handle, 0, 0, ClientWidth, ClientHeight,WHITENESS);
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
   Canvas.Brush.Color:=clRed; //parte dal centro di un'area bianca e la riempie di rosso fino al cambio di colore (bordo)
   Canvas.FloodFill(ClientWidth div 2, ClientHeight div 2,clWhite,fsSurface);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   FormMouseMove(Self,ssShift, 0, 0);
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  { first call FillRect to paint the surface of the form.
  this removes any previously drawn lines (and anything else!) }
  Canvas.FillRect(ClientRect);
  Canvas.MoveTo(0, 0);
  Canvas.LineTo(X, Y);
end;
end.

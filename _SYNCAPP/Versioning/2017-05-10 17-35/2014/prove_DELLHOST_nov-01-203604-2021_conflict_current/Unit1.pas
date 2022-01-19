unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,JPEG,extCtrls,System.Types;

type
  TForm1 = class(TForm)
    image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
{    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1DblClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
                                            }
  private
   // FDragging: Boolean;
    //FFrom: TPoint;
    FOrgImgBounds: TRect;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  image1.Picture.LoadFromFile('C:\Temp\pic.jpg');
  //image1.Stretch := True;
  image1.Height := Round(image1.Width * image1.Picture.Height / image1.Picture.Width);
  FOrgImgBounds := image1.BoundsRect;

end;
{
procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     if FDragging then
    image1.SetBounds(X - FFrom.X, Y - FFrom.Y, image1.Width, image1.Height);
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image1.Enabled := True;
  FDragging := False;
end;
 }
procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
const
  ZoomFactor: array[Boolean] of Single = (0.9, 1.1);
var
  R: TRect;
begin
   MousePos := image1.ScreenToClient(MousePos);
  with image1, MousePos do
    if PtInRect(ClientRect, MousePos) and ((WheelDelta > 0) and
      (Height < Self.ClientHeight) and (Width < Self.ClientWidth)) or
      ((WheelDelta < 0) and (Height > 20) and (Width > 20)) then
    begin
      R := BoundsRect;
      R.Left := Left + X - Round(ZoomFactor[WheelDelta > 0] * X);
      R.Top := Top + Y - Round(ZoomFactor[WheelDelta > 0] * Y);
      R.Right := R.Left + Round(ZoomFactor[WheelDelta > 0] * Width);
      R.Bottom := R.Top + Round(ZoomFactor[WheelDelta > 0] * Height);
      BoundsRect := R;
      Handled := True;
    end;
end;
       {
procedure TForm1.Image1DblClick(Sender: TObject);
begin
   image1.BoundsRect := FOrgImgBounds;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if not (ssDouble in Shift) then
  begin
    FDragging := True;
    image1.Enabled := False;
    FFrom := Point(X, Y);
    MouseCapture := True;
  end;

end;
        }
end.

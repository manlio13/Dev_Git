unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    pnlMain: TPanel;
    btnCancel: TButton;
    btnContinue: TButton;
    PrinteLetters: TButton;
    Label1: TLabel;
    procedure PrinteLettersClick(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  lContinue,lCancel:Boolean;
implementation

{$R *.dfm}

procedure TForm1.btnCancelClick(Sender: TObject);
begin
    lCancel:=True;
end;

procedure TForm1.btnContinueClick(Sender: TObject);
begin
    lContinue:=True;
end;

procedure TForm1.PrinteLettersClick(Sender: TObject);
begin
   pnlMain.Enabled:=False;
   lContinue:=False;
   Label1.BringToFront;
   Label1.Enabled:=True;
   while not lContinue and not lCancel do
       Application.ProcessMessages;
       Label1.Enabled :=False;
       Label1.SendToBack;
   if lContinue then
   begin
     Label1.Enabled:=True;
   end;
   pnlMain.Enabled:=False;
end;

end.

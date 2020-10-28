unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Vcl.HtmlHelpViewer,Winapi.ShellAPI;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   KBHook: HHook; {this intercepts keyboard input}
                  {callback's declaration}
  function KeyboardHookProc(Code: Integer; WordParam: Word; LongParam: LongInt): LongInt; stdcall;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
   {Set the keyboard hook so we  can intercept keyboard input}
   KBHook:=SetWindowsHookEx(WH_KEYBOARD,{callback >} @KeyboardHookProc,HInstance,GetCurrentThreadId());
end;
function KeyboardHookProc(Code: Integer; WordParam: Word; LongParam: LongInt) : LongInt;
begin

    if WordParam=VK_F1 then
    ShellExecute(0, nil,PChar('Corbi.chm'), nil, nil, SW_SHOWNormal);

  { case WordParam of
      VK_F1 :
        begin
         // ShowMessage('intercettato');
          ShellExecute(0, nil,PChar('Corbi.chm'), nil, nil, SW_SHOWNormal);

        end;

   end;}
   //Result:=0;

     {To prevent Windows from passing the keystrokes
      to the target window, the Result value must
      be a nonzero value.}
    Exit;
end;

end.

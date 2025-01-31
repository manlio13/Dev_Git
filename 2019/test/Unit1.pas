unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvBaseDlg, JvSHFileOperation,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    JvSHFileOperation1: TJvSHFileOperation;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  version:string;

  function GetAppVersionStr: string;


implementation

{$R *.dfm}
 {$X+}
procedure TForm1.Button1Click(Sender: TObject);
   var
   percorso :TStringList;
   InStr: string;
begin
       GetAppVersionStr;
       percorso:=TStringList.Create ;
      InStr := InputBox('Percorso','Inserisci il percorso ','');
      percorso.Add(InStr);
      // percorso.Add('manlio1.txt');
       JvSHFileOperation1.DestFiles :=percorso;
       JvSHFileOperation1.Execute;

end;
function GetAppVersionStr: string;
var
  Exe: string;
  Size, Handle: DWORD;
  Buffer: TBytes;
  FixedPtr: PVSFixedFileInfo;
begin
  Exe := ParamStr(0);
  Size := GetFileVersionInfoSize(PChar(Exe), Handle);
  if Size = 0 then
    RaiseLastOSError;
  SetLength(Buffer, Size);
  if not GetFileVersionInfo(PChar(Exe), Handle, Size, Buffer) then
    RaiseLastOSError;
  if not VerQueryValue(Buffer, '\', Pointer(FixedPtr), Size) then
    RaiseLastOSError;
  Result := Format('%d.%d.%d.%d',
    [LongRec(FixedPtr.dwFileVersionMS).Hi,  //major
     LongRec(FixedPtr.dwFileVersionMS).Lo,  //minor
     LongRec(FixedPtr.dwFileVersionLS).Hi,  //release
     LongRec(FixedPtr.dwFileVersionLS).Lo]); //build
     version:=Result;
     ShowMessage(version);
end;


end.

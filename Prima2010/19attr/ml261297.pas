unit Ml261297; //modifica attributi di un file

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Button2: TButton;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   Fhandle:integer;
   fls:string;
   dataora :TDatetime;
   data,ora :string;
implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
 if edit1.text='' then
 messagedlg('inserisci il nomefile con path',mtinformation,[mbOK],0)
 else
 begin
 fls:= edit1.text;
       if  fileexists(fls)=false then
       begin
       messagedlg('non trovo il file '+fls,mtWarning,[mbOK],0);
       exit;
        end
       else
       begin
       Fhandle:=FileOpen(fls,0);
       dataora:=FileDateToDateTime(FileGetDate(FHandle));
       edit2.text:=datetimetostr(FileDateToDateTime(FileGetDate(FHandle)));

       end;
 end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  filesetdate(FHandle,datetimetofiledate(strtodatetime(edit2.text)));
  fileclose(Fhandle);
end;

end.

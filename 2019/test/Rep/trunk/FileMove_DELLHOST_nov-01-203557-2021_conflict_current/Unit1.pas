unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles,fileCtrl,System.UITypes;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
     Procedure FormCreate(Sender:TObject);
     Procedure WriteIni(Sender:TObject);
     Procedure Button1Click(Sender:TObject);
     Procedure Button3Click(Sender:TObject);
     Procedure Button2Click(Sender:TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  myIni: TiniFile;
  dir:string;
  phase :integer =0;
implementation

{$R *.dfm}

    Procedure Tform1.FormCreate(Sender:TObject);
  var
  sourceP,TargetP,extP,SS,TT,err : string;
  sr: TsearchRec;
  cnt: Integer;
  s,t: Pchar;
  RETURN: Boolean;
   label
   again;
  begin
  if phase=0 then
  dir:=GetCurrentDir+'\';
  if fileexists(dir+'filemove.ini')=false then
    begin //se non esiste crea il file ini
    phase:=phase+1;
    Again:
    Form1.Visible:=true;
    SetWindowPos(Handle,  HWND_TOPMOST,  left,   0,   0,   0,   SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE); //on top
    label1.visible:=true;
    label1.Caption := 'File extension ';
    Edit1.Visible :=True;
    Edit1.SetFocus;
    label2.Visible:=true;
    label2.Caption := 'Source Path';
    Edit2.Visible :=True;
    button1.Visible:=True;
    label3.Visible:=True;
    label3.Caption := 'Target Path';
    Edit3.Visible :=True;
    Button3.Visible:=True;
    button2.Visible:=True;
    end else
      begin
      if Dialogs.MessageDlg('Confirm last settings ?',
      mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrNo then
        begin
         if Dialogs.MessageDlg('Confirm to delete actual settings ?',
           mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
           begin
              DeleteFile( dir+'filemove.ini');
              goto Again;
           end else
           goto again;
        end else
          begin     //legge i dati dal file ini
          myIni:=Tinifile.Create(dir+'filemove.ini');
          extP:=MyIni.ReadString('extension','ext','');
          sourceP:=MyIni.ReadString('paths','source','C:\');
          sourceP:=sourceP+'\';
          targetP:=MyIni.ReadString('paths','target','');
          targetP:=targetP+'\';
          cnt:=0;
          if findfirst(sourceP+'*.'+extP,faAnyFile,sr)=0 then
            begin
            repeat
            cnt:=cnt+1;
            SS:=sourceP+sr.Name+#0; //inizio conversione in Pchar per uso
                                //in una API call
            s:=@SS[1];
            TT:=targetP+sr.Name+#0;
            t:=@TT[1];
            return:=Movefile(s,t);  //API
            err:=syserrormessage(getlasterror);
            if return= False then
              begin
              showmessage('Run Error : '+err);
              Break;
              end;
            until Findnext(sr)<>0;
            FindClose(sr);
            Form1.Visible:=True;
            label2.Visible:=True;
            Label2.Caption:=inttostr(cnt)+'  files moved';
            Button4.Visible:=True
            end else
            label1.Visible:=true;
            Label1.Caption:='No Files with extension  '+extP;
            button4.visible:=True;
          end;
        end;
      end;
Procedure TForm1.WriteIni(Sender: TObject);
begin
  myini:=Tinifile.Create(dir+'filemove.ini');
  myini.WriteString('extension','ext',edit1.text);
  myini.WriteString('paths','source',edit2.text);
  myini.WriteString('paths','target',edit3.text);
  myini.Free;
  label1.Visible:=False;
  edit1.Visible:=False;
  label2.Visible:=False;
  edit2.Visible:=False;
  label3.Visible:=False;
  edit3.Visible:=False;
  Button1.Visible:=False;
  Button2.Visible:=False;
  Button3.Visible:=False;
  Button4.Visible:=False;
  Form1.Visible:=False;
  formcreate(Sender);   //per riportare il processo all'inizio dopo la
  //scrittura del ini file
end;

Procedure TForm1.Button1Click(Sender:TObject);
var
Dir2: string;
begin
Dir2:='C:\';
if selectdirectory(Dir2,[sdAllowCreate, sdPerformCreate, sdPrompt],0) then
edit2.Text:=Dir2
else
ShowMessage('You did not select a folder');
end;
Procedure TForm1.Button3Click(Sender:TObject);
var
Dir3: string;
begin
Dir3:='C:\';
if selectdirectory(Dir3,[sdAllowCreate, sdPerformCreate, sdPrompt],0) then
edit3.Text:=Dir3
else
ShowMessage('You did not select a folder');
end;
procedure TForm1.Button4Click(Sender: TObject);
begin
Form1.Close;
Application.Terminate;
end;

Procedure TForm1.Button2Click(Sender:TObject);
begin
WriteIni(Sender);
end;

end.

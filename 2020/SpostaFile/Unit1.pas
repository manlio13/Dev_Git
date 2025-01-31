unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Dialogs, Vcl.StdCtrls,System.IniFiles, Vcl.FileCtrl, System.UITypes;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Edit3: TEdit;
    Label3: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    Procedure WriteIni(Sender:TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Sposta(Sender:TObject);
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
  Vai:Boolean=False;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);

label
  Again;

begin
  Button5.Visible:=False;
  if phase=0 then
    dir:=GetCurrentDir+'\';
   myIni:=TIniFile.Create(dir+'SpostaFile.ini'); // crea l'oggetto inifile
                          //altrimenti provoca un accesserror  per mancanza di definizione dell'oggetto
    if fileexists(dir+'SpostaFile.ini')=false then
    begin //se non esiste da la possibilitÓ di creare il file ini
    phase:=phase+1;
    Again:
    Form1.Visible:=true;
      // SetWindowPos(Handle,  HWND_TOPMOST,  left,   0,   0,   0,   SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE); //on top
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
    Button3.Visible:=visible;
    button2.Visible:=True;
     showmessage('Fill the form and then click on "writeIni"');
    end else
       //  myIni:=Tinifile.Create(dir+'SpostaFile.ini');

          if ( (MyIni.ReadString('extension','ext','')='') OR
              (MyIni.ReadString('paths','source','')='') OR
              (MyIni.ReadString('paths','target','')=''))then
      begin

          Edit1.Text:=MyIni.ReadString('extension','ext','');
          Edit2.Text:=MyIni.ReadString('paths','source','C:\');
          Edit3.text:=MyIni.ReadString('paths','target','');

        showmessage('Make corrections.');
        goto Again;
      end else
      if Dialogs.MessageDlg('Change last used settings ?',      //Vuoi cambiare ?
      mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then

      begin
          Edit1.Text:=MyIni.ReadString('extension','ext','');
          Edit2.Text:=MyIni.ReadString('paths','source','C:\');
          Edit3.text:=MyIni.ReadString('paths','target','');
          Button5.Visible:=True;

      end else Sposta(Self);
 end;

  procedure TForm1.Sposta(Sender: TObject);
      var
        sourceP,TargetP,extP,SS,TT,err : string;
        sr: TsearchRec;
        cnt: Integer;
        s,t: Pchar;
        RETURN: Boolean;
          begin
          myIni:=Tinifile.Create(dir+'SpostaFile.ini');
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
             Edit1.Visible:=False;
             Edit2.Visible:=False;
             Edit3.Visible:=False;
             Label1.Visible:=False;
             Label3.Visible:=False;
             label2.Visible:=True;
             Label2.Caption:=inttostr(cnt)+'  files moved';
             Button1.Visible:=False;
             Button2.Visible:=False;
             Button4.Visible:=False;
            end else
              begin
                Edit1.Visible:=False;
                Edit2.Visible:=False;
                Edit3.Visible:=False;
                Label1.Visible:=False;
                Label3.Visible:=False;
                label2.Visible:=True;
                Button1.Visible:=False;
                Button2.Visible:=False;
                Button4.Visible:=False;
                Button3.Visible:=True;
                label2.Visible:=true;
                Label2.Caption:='No Files with extension  '+extP;
                button5.visible:=False;
              end;
        end;


  procedure TForm1.Button1Click(Sender: TObject);         //sorgente
  var
  Dir2: string;
  begin
  Dir2:='C:\';
  if selectdirectory(Dir2,[sdAllowCreate, sdPerformCreate, sdPrompt],0) then
  edit2.Text:=Dir2
  else
  ShowMessage('You did not select a folder');
  end;


procedure TForm1.Button2Click(Sender: TObject);       //destinazione
  var
  Dir3:string;
begin
  Dir3:='C:\';
  if selectdirectory(Dir3,[sdAllowCreate, sdPerformCreate, sdPrompt],0) then
  edit3.Text:=Dir3
  else
  ShowMessage('You did not select a folder');

end;

procedure TForm1.Button3Click(Sender: TObject);     // EXIT
  begin
    Form1.Close;
    Application.Terminate;
  end;

  procedure TForm1.Button4Click(Sender: TObject);     //writeINI
  begin
    Form1.WriteIni(Sender);
  end;

  procedure TForm1.Button5Click(Sender: TObject);      //sposta
begin
   Button5.Visible:=False;
   Form1.Sposta(Sender);
end;

Procedure TForm1.WriteIni(Sender: TObject);          //writeINI la procedura
begin
  myini:=Tinifile.Create(dir+'SpostaFile.ini');
  myini.WriteString('extension','ext',edit1.text);
  myini.WriteString('paths','source',edit2.text);
  myini.WriteString('paths','target',edit3.text);
    myini.Free;
  Form1.Sposta(Sender);   //per eseguire il processo dopo la
                           //la modifica dell'INI
 end;


 end.

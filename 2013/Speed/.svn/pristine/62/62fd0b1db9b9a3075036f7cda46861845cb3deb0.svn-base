unit Unit1;               //release 2.0.2.9

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,iniFiles,dateutils;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit8: TEdit;
    Label3: TLabel;
    Edit9: TEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox2Click(Sender: TObject);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  dir:string;
  MyIni:Tinifile;
  sta,tim,eta,beg:Ttime;
  tri,mil,mtt:integer;
  sp,dtim,ttt,calc,test:double;
  rst:boolean=false;


implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
nn:integer;
begin
  dir:=GetCurrentDir+'\';
   if fileexists(dir+'speed.ini')=True then
      begin
         MyIni := TIniFile.Create(dir+'speed.ini');    //legge il file ini
         sta:=0;
         tri:=0;
         mil:=0;
         Form1.Show;
          if MyIni.Readstring('data','start','')<>'' then   //Orario partenza
             begin
             sta:=strtoTime(MyIni.Readstring('data','start',''));
             edit1.Text:=TimeToStr(sta);
             end else
             begin
             showmessage('Inserisci l''orario di partenza');
             edit1.SetFocus;
             exit;
             end;
          if MyIni.Readstring('data','trip','')<>'' then   // TRIP
             begin
             tri:=strtoint(MyIni.Readstring('data','trip',''));
             edit2.Text:=IntToStr(tri);
             end else
             begin
             showmessage('Digita il valore trip');
             edit2.SetFocus;
             exit;
             end;
          if MyIni.Readstring('data','miles','')<>'' then  // Miglia percorse
             begin
             mil:=strtoInt(MyIni.Readstring('data','miles',''));
             Edit5.Text:=IntToStr(mil);
             mtt:=tri-mil;                            // Miglia mancanti
             Edit6.Text:=IntToStr(mtt);
             end else
             begin
             showmessage('Inserisci le miglia percorse');
             edit5.SetFocus;
             exit;
             end;
      end else
          begin
          showmessage('Manca il file di inizializzazione');
          exit;
          end;

  if checkbox1.Checked=true then
          begin
          edit4.Text:= TimeToStr(now);
          tim:=StrToTime(edit4.Text);           //tempo attuale
          end else
                if tim=0 then
          checkbox1click(Application);

 //Dati calcolati

  if (checkbox2.Checked=true) AND (tim>sta) then            //Velocità media
          begin
          dtim:=((tim-sta)*86400)/3600;        //tempo in ore
          sp:=mil/dtim;     //velocita in nodi
  if sp<=3 then
           if  messagedlg('La velocità risulta uguale o minore a 3 miglia orarie, Vuoi continuare?',mtConfirmation,[mbYes,mbNO],0,mbYes)= mrNO then
                   begin
            Button1Click(Application);
            exit;
                   end;

          if sp<=0 then
                begin
                  checkbox2.Checked:=False;
                  showmessage('Inserisci una velocità stimata');
                  edit7.SetFocus;
                  exit;
                end;
          edit7.Text:= FloatToStrF(sp,ffNumber,2,2);
          end else
                begin
                  if sp=0 then
                       begin
                  checkbox2.checked:=false;
                  showmessage('Inserisci una velocità stimata');
                  edit7.SetFocus;
                  exit;
                       end;
                end;

          ttt:= mtt/sp;
          edit9.Text:= FloatToStrF(ttt,ffNumber,2,1);
          calc:= ttt*3600/86400;
          edit8.Text:=inttostr(trunc(ttt/24));
              if mil>0 then
          eta:=tim+calc else                              //ETA se già percorso delle miglia
          eta:=sta+calc;
          edit3.Text:=TimetoStr(eta);

          beg:=strtoTime('00:00:00');
          test:= ((eta-beg)*86400/3600);
          if test>24 then
          begin
          nn:= trunc(test/24);           //  aggiunge i giorni  eventuali
          edit8.Text:= inttostr(nn);
          end;
end;



procedure TForm1.CheckBox2Click(Sender: TObject);  //velocità inserita

begin
                          if rst=false then
                          begin
      if checkbox2.Checked=false then
             begin
     showmessage('Digita la velocità');
     edit7.Text:='';
     edit7.SetFocus;
             end else
             begin
             dtim:=((tim-sta)*86400)/3600;
             sp:=mil/dtim;
             edit7.Text:= FloatToStrF(sp,ffNumber,2,2);
             end;
                          end;

end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);  //Data entry
var
ora,ora2:Ttime;

begin
     if key=#13 then                                         //Orario partenza
              begin
              //verifica data inserita
              if checkbox1.Checked=true then
                begin
                    ora := now;
                    ora2:=strtotime(edit1.text);
                  if compareTime(ora,ora2)<0 then
                       if messagedlg('Orario di partenza successivo l''attuale. Confermi?',mtConfirmation,[mbYes,mbNO],0,mbYes)= mrNO then
                            begin
                        edit1.Text:='';
                        checkbox1.Checked:=false;
                        exit;
                            end;
                  //showmessage('Attenzione Orario di partenza antecedente l''attuale');
                end;
             MyIni.WriteString('data','start',edit1.text);
             showmessage('Registrato !');
             self.ActiveControl:=nil;
             FormCreate(Application);
              end;
end;


procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
    if key=#13 then                                        //TRIP
              begin
             MyIni.WriteString('data','trip',edit2.text);
             showmessage('Registrato !');
             self.ActiveControl:=nil;
             FormCreate(Application);
              end;
end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
    if key=#13 then                                 //ora attuale
              begin
             tim:=StrToTime(edit4.Text);
             edit4.Text:=TimeToStr(tim);
             showmessage('Registrato !');
             self.ActiveControl:=nil;
             FormCreate(Application);
              end;
end;


procedure TForm1.Edit5KeyPress(Sender: TObject; var Key: Char);
begin                                                  //miglia percorse
    if key=#13 then
              begin
             MyIni.WriteString('data','miles',edit5.text);
             showmessage('Registrato !');
             self.ActiveControl:=nil;
             FormCreate(Application);
              end;
end;

procedure TForm1.Edit7KeyPress(Sender: TObject; var Key: Char);

begin
     if key=#13 then
              begin
             sp:=StrToFloat(edit7.Text);
             showmessage('Registrato !');
             self.ActiveControl:=nil;
             FormCreate(Application);
              end;
end;



procedure TForm1.Button1Click(Sender: TObject);

begin
        rst:=true;
        MyIni.WriteString('data','start','');
        MyIni.WriteString('data','trip','');
        MyIni.WriteString('data','miles','');
        Edit1.Text:='';
        Edit2.Text:='';
        Edit3.Text:='';
        Edit4.Text:='';
        Edit5.Text:='';
        Edit6.Text:='';
        Edit7.Text:='';
        sp:=0;
        Edit8.Text:='';
        Edit9.Text:='';
        checkbox1.Checked:=true;
        checkbox2.Checked:=true;
        FormCreate(application);
end;

procedure TForm1.CheckBox1Click(Sender: TObject);    // ora manuale-sistema
begin
                              if rst=false then
                              begin
     if checkbox1.Checked=false then
             begin
     showmessage('Digita l''orario attuale');
     edit4.SetFocus;
     exit;
             end else
     edit4.Text:= TimeToStr(now);
                              end;
end;

end.



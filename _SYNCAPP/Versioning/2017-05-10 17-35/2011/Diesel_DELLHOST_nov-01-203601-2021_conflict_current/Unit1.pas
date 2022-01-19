unit Unit1;   //completato il 12 febbraio 2012 corretto  7 ott.12

interface
{$WARNINGS ON}
{$HINTS ON}
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,iniFiles,fileCtrl,ExtCtrls,HTMLHelpViewer;

type
  TForm1 = class(TForm)
    PB: TProgressBar;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Button2: TButton;
    Edit4: TEdit;
    Label4: TLabel;
    Button3: TButton;
    Label5: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label6: TLabel;
    Button4: TButton;
    Label7: TLabel;
    Edit7: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Edit8: TEdit;
    Button5: TButton;
    Label10: TLabel;
    Bevel1: TBevel;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Label11: TLabel;
    RadioButton7: TRadioButton;
    Label15: TLabel;
    Label16: TLabel;
    Edit9: TEdit;
    Edit10: TEdit;
    Label17: TLabel;
    Edit11: TEdit;
    Label18: TLabel;
    Edit12: TEdit;
    Label19: TLabel;
    Button6: TButton;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Button1: TButton;
    Bevel2: TBevel;
    Edit13: TEdit;
    Label23: TLabel;
    Button7: TButton;
    Label12: TLabel;
    procedure PBcomputing(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure RadioButton5Click(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure RadioButton7Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Button4Click(Sender: TObject);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Button6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button7Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  sp,cn,rt,trp,H,tk,atk,rtc,rng,brnd,tempo: double;
  pos:integer;
  dir:string;
  myini:TiniFile;
  rb,rp: smallint;
  flag1,SPD,CNS,RTE,TNK,TNKAC: boolean;

const
  PBM_SETBKCOLOR = 8193;            // Attenzione queste dichiarazioni
  PBM_SETBARCOLOR = (WM_USER+9);     //  sono MOLTO IMPORTANTI
implementation
{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);

begin
     Application.HelpFile:='Diesel.chm';
     brnd:=0;
     tempo:=0;
     rb:=0;       //coefficiente + - =
     SPD:=False;
     CNS:=False;
     RTE:=False;
     TNK:=False;
     TNKAC:=False;
     flag1:=False;
     dir:=GetCurrentDir+'\';
     radiobutton7.Checked:=True;
      if fileexists(dir+'diesel.ini')=True then
      begin
         MyIni := TIniFile.Create(dir+'diesel.ini') ;
       //legge il file ini e proietta i dati sulla finestra
          if MyIni.Readstring('settings','speed','')<>'' then    //velocità
            begin
               sp:=strtofloat(MyIni.Readstring('settings','speed',''));
               SPD:=True;
            end;

          if MyIni.Readstring('settings','consump','')<>'' then  //consumo
            begin
               cn:=strtofloat(MyIni.Readstring('settings','consump',''));
               CNS:=True;
            end;

          if MyIni.Readstring('settings','rate','')<>'' then    //aliquota
            begin
               rt:=strtofloat(MyIni.Readstring('settings','rate',''));
               RTE:=True;
            end;

          if MyIni.Readstring('resource','tank','')<>'' then     //serbatoio
            begin
               tk:=strtofloat(MyIni.Readstring('resource','tank',''));
               TNK:=True;
            end;

          if MyIni.Readstring('resource','actual','')<>'' then    //attuale
            begin
               atk:=strtofloat(MyIni.Readstring('resource','actual',''));
               TNKAC:=True;
            end;
           //scrive i dati sul form

          edit9.Text:=myini.ReadString('data','range','');    //stored data
          edit11.Text:=myini.ReadString('data','trip','');    // stored data
          edit10.Text:=myini.ReadString('data','filling','');  //stored data
          edit12.Text:=MyIni.ReadString('data','hours',''); //stored data
          edit13.Text:=Myini.ReadString('data','burned',''); //stored data
          edit1.text:=floattostr(sp);
          edit2.text:=floattostr(cn);
          edit3.text:=floattostr(rt);
          edit7.text:=floattostr(tk);
          edit8.text:=floattostr(atk);

          if (SPD and CNS and RTE and TNK and TNKAC) = False then
          button1click(Sender) else
          begin
            showmessage('Settings OK. Use Fuel Control');
            PBcomputing(Sender);
          end;

      end else
        begin
          MyIni := TIniFile.Create(dir+'diesel.ini') ;
          myini.WriteString('data','burned',FormatFloat(',0',0));
          showmessage('Please entry settings data, press ENTER each done to continue');
        end;


end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then    //inserimento velocità std
    begin

       if TryStrToFloat(edit1.Text,sp)=False then  //controllo del float
         begin
         ShowMessage('Please check your input details!');
         exit;
         end;

   myini.WriteString('settings','speed',edit1.Text);
   sp:=strtofloat(edit1.Text); //crea la variabile
   SPD:=True;
   SendMessage(edit1.Handle, WM_KILLFOCUS,0,0); //toglie il prompt
   self.ActiveControl:=nil;
   button1click(Sender);
    end;

end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then  //inserimento consumo std
     begin

      if TryStrToFloat(edit2.Text,cn)=False then
        begin
        ShowMessage('Please check your input details!');
        exit;
        end;

   myini.WriteString('settings','consump',edit2.Text);
   cn:=strtofloat(edit2.Text); //crea la variabile
   CNS:=True;
   SendMessage(edit2.Handle, WM_KILLFOCUS,0,0); //toglie il prompt
   self.ActiveControl:=nil;
   button1click(Sender);
    end;

end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then    //inserimento aliquota di variazione std
     begin

      if TryStrToFloat(edit3.Text,rt)=False then
        begin
        ShowMessage('Please check your input details!');
        exit;
        end;

   myini.WriteString('settings','rate',edit3.Text);
   rt:=strtofloat(edit3.Text); //crea la variabile
   RTE:=True;
   SendMessage(edit3.Handle, WM_KILLFOCUS,0,0); //toglie il prompt
   self.ActiveControl:=nil;
   button1click(Sender);
    end;

end;

// Inserimento litri del serbatoio al pieno
procedure TForm1.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    begin

      if TryStrToFloat(edit7.Text,tk)=False then
        begin
        ShowMessage('Please check your input details!');
        exit;
        end;

   myini.WriteString('resource','tank',edit7.Text);
   tk:=strtofloat(edit7.Text); //crea la variabile
   TNK:=True;
   SendMessage(edit7.Handle, WM_KILLFOCUS,0,0); //toglie il prompt
   self.ActiveControl:=nil;
   button1click(Sender);
   end;
end;


procedure TForm1.Button5Click(Sender: TObject); //Reset serb.attuale
begin
   if Dialogs.MessageDlg('You are going to change the actual tank data, continue ?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
    close;

  edit8.Text:='';
  showmessage('Pls enter total actual tank liters');
  edit8.SetFocus;
end;

//reset del serb.attuale
procedure TForm1.Edit8KeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
    begin
   if strtofloat(edit8.Text)>tk then
    begin
    showmessage('Attention ! Tank overflow ! Enter correct data');
    edit8.text:='';
    edit8.setfocus;
    exit;
    end;
   myini.WriteString('resource','actual',edit8.Text);
   TNKAC:=True;
   SendMessage(edit8.Handle, WM_KILLFOCUS,0,0); //toglie il prompt
   PBcomputing(sender);
    end;

end;
procedure TForm1.Button1Click(Sender: TObject);
begin
//Controlla i dati di setting
        if SPD=False then
        begin
        showmessage('Settings incomplete. Please enter estimated Standard Cruising Speed');
        edit1.SetFocus;
        exit;
        end;

        if CNS=False then
        begin
        showmessage('Settings incomplete. Please enter estimated Standard Fuel Consumption');
        edit2.SetFocus;
        exit;
        end;

        if RTE=False then
        begin
        showmessage('Settings incomplete. Please enter variation rate');
        edit3.SetFocus;
        exit;
        end;

        if TNK=False then
        begin
        showmessage('Settings incomplete. Please enter Maximum Tank Capacity');
        edit7.SetFocus;
        exit;
        end;

        if TNKAC=False then
        begin
        showmessage('First time settings incomplete. Please Set estimated Actual Tank');
        edit8.SetFocus;
        exit;
        end;

        PBcomputing(Sender);
        showmessage('Settings OK - Fuel Control ready !');
end;

//carico o scarico gasolio
procedure TForm1.Button2Click(Sender: TObject);
  begin
   if Dialogs.MessageDlg('You are going to modify the actual tank data, continue ?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
    exit;
     edit4.Text:='';
    showmessage('Enter total liters supplied ( use minus "-" to subtract)');
     edit4.SetFocus;
  end;

  // entry  miglia percorse  a motore
procedure TForm1.Button3Click(Sender: TObject);
begin
if flag1=True then
      if Dialogs.MessageDlg('Recently you already used this function, continue ?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
      exit;
  begin
    if Dialogs.MessageDlg('You are going to modify the actual tank data, continue ?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
    exit;
     edit5.Text:='';
     showmessage('Enter miles motored (last trip data)');
     edit5.SetFocus;
  end;

end;
procedure TForm1.Button4Click(Sender: TObject);
begin                 //  entra le ore di motore
    if flag1=True then
      if Dialogs.MessageDlg('Recently you already used this function, continue ?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
      exit;
      begin
       if Dialogs.MessageDlg('You are going to modify the actual tank data, continue ?',
       mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
       exit;
       edit6.Text:='';
       showmessage('Enter hours motored (last trip data)');
       edit6.SetFocus;
      end;
end;


procedure TForm1.PBcomputing(Sender: TObject); // calcolo della ProgressBar
begin
    RadioButton5.Checked:=False;  //resetta i fattori di correzione
    RadioButton6.Checked:=False;
 //   RadioButton7.Checked:=False;
    atk:=strtofloat(MyIni.Readstring('resource','actual',''));
    pos:=round(100*atk/tk);
    if atk<=tk*0.10 then
     begin
    SendMessage(PB.Handle, PBM_SETBKCOLOR, 0, clyellow);//colore background
    SendMessage(PB.handle, PBM_SETBARCOLOR, 0,clRed) ; //colore di foreground
    Label10.Caption:='Alarm';
     end else
      if atk<=tk*0.20 then
     begin
    SendMessage(PB.Handle, PBM_SETBKCOLOR, 0, clyellow);
    SendMessage(PB.handle, PBM_SETBARCOLOR, 0,clGreen) ;
    Label10.Caption:='Caution';
     end else
      begin
        SendMessage(PB.Handle, PBM_SETBKCOLOR, 0, claqua);
        SendMessage(PB.handle, PBM_SETBARCOLOR, 0,clGreen) ;
        Label10.Caption:='Safe';
      end;
    PB.position :=pos;
    rng:=atk*sp/cn;    //scrive il range
    myini.WriteString('data','range',formatfloat('#',rng));
    edit9.Text:=myini.ReadString('data','range','');  //stored data

end;

 //inserimento coefficiente peggiorativo
procedure TForm1.RadioButton5Click(Sender: TObject);
begin
   rb:=1;
end;
 //inserimento coefficiente migliorativo
procedure TForm1.RadioButton6Click(Sender: TObject);
begin
   rb:=2;
end;
  //valutazione a standard
procedure TForm1.RadioButton7Click(Sender: TObject);
begin
     rb:=0;
end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
begin  //rifornimento carburante
   if key=#13 then
    begin

      if TryStrToFloat(edit4.Text,atk)=False then
        begin
        ShowMessage('Please check your input details!');
        exit;
        end;

   if MyIni.Readstring('resource','actual','')='' then    //attuale
            atk:=0 else
   atk:=strtofloat(MyIni.Readstring('resource','actual',''));

   atk:= atk+strtofloat(edit4.Text);
   if atk>tk then
    begin
    showmessage('Attention ! Tank overflow ! Enter correct data');
    edit4.text:='';
    edit4.setfocus;
    exit;
    end;
   myini.WriteString('data','filling',edit4.Text);  //stored data
  // Scrive il dato del carburante rimasto
   myini.WriteString('resource','actual',floattostr(atk));
   edit8.text:=floattostr(atk);
   rng:=atk*sp/cn;
   myini.WriteString('data','range',formatfloat('#',rng));
   edit9.Text:=myini.ReadString('data','range','');  //stored data
   edit10.Text:=myini.ReadString('data','filling','');  //stored data
   edit4.Text:='';
   SendMessage(edit4.Handle, WM_KILLFOCUS,0,0); //toglie il prompt
   self.ActiveControl:=nil;
   PBcomputing(Sender);
    end;
end;




// entry trip- calcolo consumo da miglia percorse
// sp velocità
// rb coefficiente 1 2 0  :  + - =
//trp trip
//rt variazione
//rtc variazione calcolata
//cn consumo in l/H
//cnm consumo in L/m

procedure TForm1.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then  //inserimento miglia percorse
    begin
   flag1:=True;
   myini.WriteString('data','trip',edit5.Text);
   SendMessage(edit5.Handle, WM_KILLFOCUS,0,0); //toglie il prompt
   self.ActiveControl:=nil;
    //calcolo del nuovo atk
    trp:=strtofloat(MyIni.Readstring('data','trip',''));//legge il trip
    edit11.Text:=formatfloat('#.#',trp);
    if rb=1 then    //peggiorativo
        begin
      rtc:=(rt/100)+1;
      brnd:= trp*cn*rtc/sp;
      atk:=atk- brnd;
        end else       //migliorativo
    if rb=2 then
          begin
      rtc:=(rt/100)+1;
      brnd:= (trp*cn/sp)/rtc;
      atk:=atk- brnd;
          end else
            begin
    brnd:= trp*(cn/sp);
    atk:=atk - brnd;
            end;
    // Scrive il dato del carburante rimasto
    myini.WriteString('resource','actual', formatfloat('#.#',atk));
    edit8.Text:=formatfloat('#.#',atk);
    PBcomputing(sender);
    edit5.text:='';
    rng:=atk*sp/cn;
   tempo:=strtofloat(myini.ReadString('data','burned','')); //stored used diesel
   tempo:=tempo + brnd;
   myini.WriteString('data','burned',formatfloat('#.#',tempo));
   myini.WriteString('data','range',formatfloat('#',rng));
   edit9.Text:=myini.ReadString('data','range','');  // stored data
   edit13.text:=formatfloat('#.#',tempo);
   brnd:=0;
   tempo:=0;
   radiobutton7.Checked:=True;
    end;
end;

procedure TForm1.Edit6KeyPress(Sender: TObject; var Key: Char);
  var
  s:double;
  k,kk:integer;

begin
   if key=#13 then  //inserimento ore di motore
    begin
    //conversione testo-decimale time entry

     kk:=length(edit6.Text);
     k:=Ansipos(':',edit6.text);
      if k=0 then
      begin
      showmessage('Wrong time format !');
      edit6.Text:='';
      exit;
      end;
     H:=strtoFloat(copy(edit6.Text,1,k-1));
    s:=strtoFloat(copy(edit6.Text,k+1,kk));
    H:=H+s/60;
     //fine conversione

   flag1:=True;
   myini.WriteString('data','hours',edit6.Text);
   edit12.Text:=MyIni.ReadString('data','hours',''); //stored data
   SendMessage(edit6.Handle, WM_KILLFOCUS,0,0); //toglie il prompt
   self.ActiveControl:=nil;

    //calcolo del nuovo atk

    if rb=1 then    //peggiorativo
    begin
      rtc:=(rt/100)+1;
      brnd:= H*cn*rtc;
      atk:=atk-brnd;
    end else       //migliorativo
    if rb=2 then
    begin
      rtc:=(rt/100)+1;
      brnd:= (H*cn)/rtc;
      atk:=atk- brnd;
    end else
    begin
    brnd:= H*cn;
    atk:=atk - brnd;
    end;
     // Scrive il dato del carburante rimasto
    myini.WriteString('resource','actual', formatfloat('#.#',atk));
    edit8.Text:=formatfloat('#.#',atk);                                    ;
    PBcomputing(sender);
    edit6.text:='';
    rng:=atk*sp/cn;
    tempo:=strtofloat(myini.ReadString('data','burned','')); //stored used diesel
    tempo:=tempo+brnd;
    myini.WriteString('data','burned',formatFloat('#.#',tempo));
    myini.WriteString('data','range',formatfloat('#',rng));
    edit9.Text:=myini.ReadString('data','range','');  //stored data
    brnd:=0;
    tempo:=0;
    radiobutton7.Checked:=True;
     end;
end;
 procedure TForm1.Button6Click(Sender: TObject);
begin
    MyIni.free;
    Form1.release;
    application.Terminate;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  myini.WriteString('data','burned',FormatFloat(',0',0));
  edit13.Text:=Myini.ReadString('data','burned',''); //stored data
end;

end.



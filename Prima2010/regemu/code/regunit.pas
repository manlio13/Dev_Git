//programma per emulare il registro mlsoft ottobre 2000 build 5

unit regunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,registry;

type
  TForm1 = class(TForm)
    Button1: TButton;
    edit2: TEdit;
    edit1: TEdit;
    edit3: TEdit;
    edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label3: TLabel;
    Button3: TButton;
    Button4: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  miorecord=record
        giorno:TDateTime;
        edizione:integer;
        end;
var
  Form1: TForm1;
  mioreg:Tregistry;
  ml:TstringList;
  n:smallint;
  cavtroia:miorecord;
implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);

begin
edit1.text:='';
edit2.text:='';
edit3.text:='';
edit4.text:='';
edit5.text:='';
mioreg:=Tregistry.Create;
ml:=TstringList.Create;
mioreg.RootKey:=HKEY_LOCAL_MACHINE;
if mioreg.KeyExists('\software\mlsoft')then
        begin
        edit1.text:='mlsoft';
        mioreg.OpenKey('\software\mlsoft',false);
        try
        mioreg.GetkeyNames(ml);
        edit2.text:=ml.Strings[0];
        mioreg.openkey('\software\mlsoft\'+edit2.text,false);
        edit3.text:=mioreg.readstring('AppName');
        edit4.text:=inttostr(mioreg.Readinteger('Edition'));
        edit5.text:=inttostr(mioreg.Readinteger('RegNo'));
        except
        showmessage('la chiave mlsoft non ha subkey o valori');
        end;
        end else
        messagedlg('mlsoft non è registrato',MtWarning,[MbOK],1);
         mioreg.free;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if (edit1.text<>'' )and (edit2.text<>'')and (edit3.text<>'')and
(edit4.text<>'')then

        begin
mioreg:=Tregistry.Create;
mioreg.RootKey:=HKEY_LOCAL_MACHINE;
mioreg.openkey('\software',false);
mioreg.CreateKey(edit1.text);
mioreg.openkey(edit1.text,false);
mioreg.createkey(edit2.text);
mioreg.OpenKey(edit2.text,false);
mioreg.WriteString('AppName',edit3.text);
mioreg.WriteInteger('Edition',strtoint(edit4.text));
if edit5.text='' then
edit5.text:='0';
mioreg.WriteInteger('RegNo',strtoint(edit5.text));
        end else
        showmessage('manca un dato');
mioreg.closekey;
mioreg.free;
end;


procedure TForm1.Button3Click(Sender: TObject);  //leggi
begin
edit6.text:='';
edit7.text:='';
edit8.text:='';
edit9.text:='';
 mioreg:=Tregistry.Create;
 ml:=TstringList.Create;
 mioreg.RootKey:=HKEY_CLASSES_ROOT;
 if mioreg.KeyExists('\InDateLog') then
        begin
        edit6.text:='InDateLog';
        mioreg.OpenKey('\InDatelog',false);
        mioreg.GetValueNames(ml);
        edit7.text:=ml.Strings[0];
        mioreg.readbinaryData(edit7.text,cavtroia,sizeof(cavtroia));
        edit8.text:=datetostr(cavtroia.giorno);
        edit9.text:=inttostr(cavtroia.edizione);
        end else
         messagedlg('nessun dato crypto',MtWarning,[MbOK],1);
         mioreg.free;
end;

procedure TForm1.Button4Click(Sender: TObject);  //scrivi

var
cavtroia:int64;

begin

 cavtroia:=strtoint64(edit8.Text);
 if (edit6.text<>'' )and (edit7.text<>'')and (edit8.text<>'')
 then

        begin
mioreg:=Tregistry.Create;
mioreg.RootKey:=HKEY_CLASSES_ROOT;
mioreg.CreateKey(edit6.text);
mioreg.openkey(edit6.text,true);
mioreg.WriteBinaryData(edit7.text,cavtroia,sizeof(cavtroia));
        end else
        showmessage('manca un dato');
mioreg.closekey;
mioreg.free;
end;

end.

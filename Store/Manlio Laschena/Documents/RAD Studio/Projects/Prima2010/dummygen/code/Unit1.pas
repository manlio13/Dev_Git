
//per determinare il dummy costituito da edizione+data+ora di registrazione
                                    // e minuti
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   ed:smallint;
   dmy:extended;
implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
ed:=3;//esempio di num. di versione ottenuto a monte
edit1.text:=inttostr(ed)+formatdatetime('ddmmyyhhmm',now);
dmy:=strtocurr(edit1.text);
 messagedlg('vale : '+currtostr(dmy),mtinformation,[mbOK],0);



 end;

end.

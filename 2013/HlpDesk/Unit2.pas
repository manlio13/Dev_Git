unit Unit2;        //HELPDESK versione 2.3.1.6 prerelease

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ComCtrls;

type
  TForm2 = class(TForm)
    DBRichEdit1: TDBRichEdit;
    procedure DBRichEdit1KeyUP(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBRichEdit1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
   selection:string ;
implementation
uses
Unit1;

{$R *.dfm}

          //Ctrl+D per inserire timestamp in campo memo - usare keyUp per due tasti
procedure TForm2.DBRichEdit1KeyUP(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
if ((ssCtrl in Shift) AND (key=68)) then
begin
   Form1.ABSTable1.Edit;
   DBRichEdit1.Text:=DBRichEdit1.Text +sLineBreak+sLineBreak+ DateTimeToStr(now);
   DBRichEdit1.Lines.Add(''); //posiziona il prompt dopo la data
   Form1.ABSTable1.FieldByName('More').AsString := DBRichEdit1.text ;
end

end;
                   //selezione testo da campo Memo
procedure TForm2.DBRichEdit1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
  if DBRichEdit1.SelText<>'' then
      begin
        STRList:=TStringList.create;
        STRList.Text:=DBRichEdit1.SelText;
        Flag1:=True;
        Form1.ABSTable1.FieldByName('More').AsString:=DBRichEdit1.Text;
      end else
          begin
      showmessage('No selected text. Redo');
      exit;
          end;
end;


end.

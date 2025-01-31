unit Unit1;         // Cesto      v.3   2017

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, ABSMain,JPeg,System.UITypes,System.types,
  JvBaseDlg, JvSHFileOperation;

type
  TForm1 = class(TForm)
    ABSTable1: TABSTable;
    ABSDatabase1: TABSDatabase;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBMemo1: TDBMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    DataSource1: TDataSource;
    Image1: TImage;
    OpenJPG: TOpenDialog;
    Edit1: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    ABSQuery1: TABSQuery;
    Label2: TLabel;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Label3: TLabel;
    Button9: TButton;
    jvshfile1: TJvSHFileOperation;
    Button10: TButton;
    lbl1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ABSTable1AfterScroll(DataSet: TDataSet);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DBMemo1Exit(Sender: TObject);
    procedure ABSQuery1AfterScroll(DataSet: TDataSet);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure DBMemo1Enter(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1DblClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseEnter(Sender: TObject);
    procedure ABSTable1AfterPost(DataSet: TDataSet);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);

  private
    { Private declarations }
        FOrgImgBounds: TRect;
        FFrom:Tpoint;
        FDragging:Boolean;
       // procedure CMDialogKey(var AMessage: TCMDialogKey); message CM_DIALOGKEY;
  public
    { Public declarations }
      function GetAppVersionStr: string;
  end;

var
  Form1: TForm1;
  JpegPhoto: TJpegImage;
  BlobStream : Tstream;
  FileStream : TFileStream;
  filtro,versione:string;
  nr:integer;
  inizio:TDatetime;
  rs:string;
  modifica:boolean=False;
implementation

{$R *.dfm}
procedure TForm1.FormCreate(Sender: TObject);
begin
ABSDatabase1.DatabaseFilename:= ExtractFilePath(Application.ExeName)+'cesto.ABS';
ABSDatabase1.Open;
ABSTable1.TableName:='data';  //NON USARE PAROLE RISERVATE
ABSTable1.Open;
Edit2.Text:=DateToStr(Now);
ABSTable1.Last;
nr:=ABSTable1.recno;
Form1.Caption:= Form1.Caption + ' :   numero di articoli : '+ IntToStr(nr);
   AbsTable1.First; { Go to first record, which sets Eof False }
   inizio:= ABSTable1.FieldByName('datelog').AsDateTime;
   Edit1.Text:= DateTimeToStr(inizio);
   //DBGrid1.DataSource.DataSet.FieldByName('Note').Visible:=False;

  //per avere il display da SQL e non da Table
        DataSource1.DataSet:=ABSQuery1;
        with ABSQuery1 do
     begin
       close;
       SQL.text := 'select * from data ORDER by datelog asc';
       ExecSql;
       open;
       label2.Caption:='Query mode';
       Button3.Caption:='Table';
     end;
    if (NOT ABSQuery1.FieldByName('view').IsNull) then
       begin
        BlobStream:=ABSQuery1.CreateBlobStream(ABSQuery1.FieldByName('view'),bmread);
        JpegPhoto := TJPEGImage.Create;
          try
            JpegPhoto.LoadFromStream(BlobStream);
            Image1.Picture.Assign(JpegPhoto);
            Image1.Visible:=True;
          finally
            JpegPhoto.Free;
            BlobStream.Free;
          end;
       end else
        Image1.Visible:= False;
  //per la rotella
  Image1.Height := Round((image1.Width)*(image1.Height)/(image1.Width));
  FOrgImgBounds := image1.BoundsRect;
  DoubleBuffered:=True;
  Image1.proportional:=True;

  GetAppVersionStr;
  caption:=caption + '  - ver: '+versione;

end;

function TForm1.GetAppVersionStr: string;
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
[LongRec(FixedPtr.dwFileVersionMS).Hi, //major
LongRec(FixedPtr.dwFileVersionMS).Lo, //minor
LongRec(FixedPtr.dwFileVersionLS).Hi, //release
LongRec(FixedPtr.dwFileVersionLS).Lo]); //build
versione:= Result;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      Image1.Enabled := True;
      FDragging := False;
end;

procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
      const
  ZoomFactor: array[Boolean] of Single = (0.9, 1.1);
      var
  R: TRect;

begin
       MousePos := image1.ScreenToClient(MousePos);
  with image1, MousePos do
    if PtInRect(ClientRect, MousePos) and ((WheelDelta > 0) and
      (Height < Self.ClientHeight) and (Width < Self.ClientWidth)) or
      ((WheelDelta < 0) and (Height > 20) and (Width > 20)) then
    begin
      R := BoundsRect;
      R.Left := Left + X - Round(ZoomFactor[WheelDelta > 0] * X);
      R.Top := Top + Y - Round(ZoomFactor[WheelDelta > 0] * Y);
      R.Right := R.Left + Round(ZoomFactor[WheelDelta > 0] * Width);
      R.Bottom := R.Top + Round(ZoomFactor[WheelDelta > 0] * Height);
      BoundsRect := R;
      Handled := True;
    end;
end;

procedure TForm1.Image1DblClick(Sender: TObject);
begin

     Form1.ClientHeight:=360;
     Form1.ClientWidth:=1055;
     Image1.BoundsRect := FOrgImgBounds;
     DataSource1.DataSet:=ABSQuery1;
           with ABSQuery1 do
     begin
       close;
       SQL.text := 'select * from data ORDER by datelog desc';
       ExecSql;
       open;
       label2.Caption:='Query mode';
       Button3.Caption:='Table';
     end;
    if (NOT ABSQuery1.FieldByName('view').IsNull) then
       begin
        BlobStream:=ABSQuery1.CreateBlobStream(ABSQuery1.FieldByName('view'),bmread);
        JpegPhoto := TJPEGImage.Create;
          try
            JpegPhoto.LoadFromStream(BlobStream);
            Image1.Picture.Assign(JpegPhoto);
            Image1.Visible:=True;
          finally
            JpegPhoto.Free;
            BlobStream.Free;
          end;
       end else
        Image1.Visible:= False;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      if not (ssDouble in Shift) then
  begin
    FDragging := True;
    Image1.Enabled := False;
    FFrom := Point(X, Y);
    MouseCapture := True;
  end;

end;

procedure TForm1.Image1MouseEnter(Sender: TObject);
begin
     DBMemo1.SetFocus;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if FDragging then
    Image1.SetBounds(X - FFrom.X, Y - FFrom.Y, Image1.Width, Image1.Height)
    else exit;
end;

procedure TForm1.ABSQuery1AfterScroll(DataSet: TDataSet);  //per linkare la foto al query
begin
     if (NOT ABSQuery1.FieldByName('view').IsNull) then
       begin
        BlobStream:=ABSQuery1.CreateBlobStream(ABSQuery1.FieldByName('view'),bmread);
        JpegPhoto := TJPEGImage.Create;
          try
            JpegPhoto.LoadFromStream(BlobStream);
            Image1.Picture.Assign(JpegPhoto);
            Image1.Visible:=True;
          finally
            JpegPhoto.Free;
            BlobStream.Free;
          end;
       end else
       begin
        Image1.Visible:= False;
        Exit;
       end;
end;

procedure TForm1.ABSTable1AfterPost(DataSet: TDataSet);
begin
     DataSource1.DataSet:=ABSQuery1;
           with ABSQuery1 do
     begin
       close;
       SQL.text := 'select * from data ORDER by datelog desc';
       ExecSql;
       open;
       label2.Caption:='Query mode';
       Button3.Caption:='Table';
     end;
    if (NOT ABSQuery1.FieldByName('view').IsNull) then
       begin
        BlobStream:=ABSQuery1.CreateBlobStream(ABSQuery1.FieldByName('view'),bmread);
        JpegPhoto := TJPEGImage.Create;
          try
            JpegPhoto.LoadFromStream(BlobStream);
            Image1.Picture.Assign(JpegPhoto);
            Image1.Visible:=True;
          finally
            JpegPhoto.Free;
            BlobStream.Free;
          end;
       end else
       begin
        Image1.Visible:= False;
        Exit;
       end;

end;

procedure TForm1.ABSTable1AfterScroll(DataSet: TDataSet);   //per linkare la foto alla table
begin
    if (NOT ABSTable1.FieldByName('view').IsNull) then
       begin
        BlobStream:=ABSTable1.CreateBlobStream(ABSTable1.FieldByName('view'),bmread);
        JpegPhoto := TJPEGImage.Create;
          try
            JpegPhoto.LoadFromStream(BlobStream);
            Image1.Picture.Assign(JpegPhoto);
            Image1.Visible:=True;
          finally
            JpegPhoto.Free;
            BlobStream.Free;

          end;
       end else
     begin
       Image1.Visible:= False;
       Exit;
     end;

end;

procedure TForm1.Button10Click(Sender: TObject);
begin
      if MessageDlg('Confermi di voler effettuare il backup del DataBase ?',
             mtconfirmation, [mbYes,mbNo], 0) = mrYes then
     begin
         ABSDatabase1.Close;
         JVSHFile1.Execute;
         ABSDatabase1.Open;
         ABSTable1.Open;
       //  Ricordarsi di mettere in event OnClose -> Button10 e in Object explorer del componente JvHSFile1 il nome del database
      end else Exit;   //in source e in "destFile" il nome del bckup
end;

procedure TForm1.Button1Click(Sender: TObject);  //filtra
label vai;
var
 datafiltro:string;
 chi: array[1..2] of smallint;
  i: Integer;
begin
     i:=0;
            if edit3.text<>'' then
              begin
                i:=i+1;
                chi[i]:=3;
              end;
            if edit4.Text<>'' then
            begin
            i:=i+1;
            chi[i]:=4;
            end;
     if chi[2]>0 then
        begin
         filtro:='What LIKE '+ QuotedStr('%'+(Edit3.Text)+'%')+' AND  keyword ='+quotedStr(edit4.text);
         goto vai;
        end;

      if chi[1]>0 then
        begin
          if (edit4.Text<>'')  then
              filtro:=' keyword = '+QuotedStr(Edit4.Text);
          if (edit3.Text<>'')  then
              filtro:=' what LIKE '+quotedStr('%'+edit3.text+'%');
          goto vai;
        end;

     vai:

     DataSource1.DataSet:=ABSQuery1;
     with ABSQuery1 do
     begin
       close;
       if i=0 then
       SQL.text := 'select * from data ORDER by datelog desc' else
       SQL.text := 'select * from data where'+filtro;
       ExecSql;
       open;
        //preleva l'immagine dallo stream
       if (NOT ABSQuery1.FieldByName('view').IsNull) then
       begin
        BlobStream:=ABSQuery1.CreateBlobStream(ABSQuery1.FieldByName('view'),bmread);
        JpegPhoto := TJPEGImage.Create;
          try
            JpegPhoto.LoadFromStream(BlobStream);
            Image1.Picture.Assign(JpegPhoto);
            Image1.Visible:=True;
          finally
            JpegPhoto.Free;
            BlobStream.Free;
          end;
       end else
        Image1.Visible:= False;
     end;
     datafiltro:= 'datelog <='+ quotedStr(edit2.Text)+'AND datelog >='+quotedStr(Edit1.Text);
     ABSQuery1.FilterOptions := [foCaseInsensitive];
     ABSQuery1.Filter := datafiltro;                                           //datafiltro;
     ABSQuery1.Filtered:=True;
     label2.Caption:='Query mode';
     Button3.Caption:='Table';
end;


procedure TForm1.Button2Click(Sender: TObject);  //Carica la photo
begin
        DataSource1.DataSet:=ABSTable1;
        ABSQuery1.Close;
        label2.Caption:='Table mode';
        Button3.Caption:='Query';
    if OpenJPG.Execute then
    begin
      ABSTable1.Edit;
      try
        BlobStream:=ABSTable1.CreateBlobStream(ABSTable1.FieldByName('view'),bmWrite);
        FileStream:=TFileStream.Create(OpenJPG.FileName, fmOpenRead or fmShareDenyNone);
        BlobStream.CopyFrom(FileStream,Filestream.Size);
        FileStream.Free;
        BlobStream.Free;
        if MessageDlg('Is the photo OK to be stored ?', mtconfirmation, [mbYes,mbNo], 0) = mrYes then
        ABSTable1.Post else exit;
        ABSTable1AfterScroll(ABSTable1);
      except
        ABSTable1.Cancel;
      end;
      label2.Caption:='Table mode';
      Button3.Caption:='Query';
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);        //Table
begin
              if Button3.Caption='Table' then
                  begin
                    DataSource1.DataSet:=ABSTable1;
                    ABSQuery1.Close;
                    ABSTable1.edit;
                    ABSTable1.First;
                    label2.Caption:='Table mode';
                    Button3.Caption:='Query';
                  end else
                  begin
                    Button1.Click;
                    Button3.Caption:='Table';
                    Label2.Caption:='Query mode';
                  end;
              
end;

procedure TForm1.Button4Click(Sender: TObject); //Reset
begin
        if DataSource1.DataSet=ABSTable1 then
        begin
         showmessage('Nothing to reset: Table mode');
         exit;
        end;
        Edit1.Text:=DateTimeToStr(inizio);
        Edit2.text:=DateToStr(Now);
        Edit3.text:='';
        Edit4.text:='';
        Button1.Click;
end;

procedure TForm1.Button5Click(Sender: TObject);   //  remove photo
begin
       ABSQuery1.Close;
       DataSource1.DataSet:=ABSTable1;
       label2.Caption:='Table mode';
       Button3.Caption:='Query';
       if ABSTable1.FieldValues['view']=null then
                  begin
                   showmessage('There is no JPG to remove.');
                   exit;
                  end;
    if MessageDlg('Do you confirm to remove the photo ?', mtconfirmation, [mbYes,mbNo], 0) = mrYes
        then
         begin

             with ABSTable1 do
                begin
                  Edit;
                  FieldValues['view'] := '';
                  Post;
                end;
                if (NOT ABSTable1.FieldByName('view').IsNull) then
                 begin
                  BlobStream:=ABSTable1.CreateBlobStream(ABSTable1.FieldByName('view'),bmread);
                  JpegPhoto := TJPEGImage.Create;
                    try
                      JpegPhoto.LoadFromStream(BlobStream);
                      Image1.Picture.Assign(JpegPhoto);
                      Image1.Visible:=True;
                    finally
                      JpegPhoto.Free;
                      BlobStream.Free;
                    end;
                 end else
                  Image1.Visible:= False;
         end else exit;
end;

procedure TForm1.Button6Click(Sender: TObject);   //Done
begin
    DataSource1.DataSet:=ABSTable1;
    ABSQuery1.Close;
    ABSTable1.edit;
    ABSTable1.close;
    ABSDatabase1.Close;
    Form1.release;
    application.Terminate;
end;

procedure TForm1.Button7Click(Sender: TObject);    // remuove tutto
begin
      if messageDlg('Do you really want to reset all ?',mtConfirmation,mbYesNo,0)=mrNo then
      exit else
      if messageDlg('You are going to erase all data. NO to cancel !',mtConfirmation,mbYesNo,0)=mrNo then
      exit else
      ABSTable1.Close;
      ABSTable1.EmptyTable;
         with ABSQuery1 do
     begin
       close;
       SQL.text := 'select * from data ORDER by datelog desc';
       ExecSql;
       open;
       label2.Caption:='Query mode';
       Button3.Caption:='Table';
     end;
       ABSQuery1.Close;
       ABSDatabase1.Open;
       ABSTable1.Open;
end;

procedure TForm1.Button8Click(Sender: TObject);  //Save JPG
var
  FileStream: TFileStream;
  BlobStream: TStream;
begin
   if (savedialog1.Execute) then
    begin
      FileStream := TFileStream.Create(savedialog1.FileName,fmCreate);
      BlobStream := ABSQuery1.CreateBlobStream(ABSQuery1.FieldByName('view'),bmRead);
      FileStream.CopyFrom(BlobStream,BlobStream.Size-BlobStream.Position);
      BlobStream.Free;
      FileStream.Free;
    end;

end;

procedure TForm1.Button9Click(Sender: TObject);   //New record
begin
  if Button3.Caption= 'Table' then
   begin
    Button3.click ;
   end;
    ABSTable1.Append;
    DBGrid1.SetFocus;
    DBGrid1.SelectedField := ABSTable1.FieldByName('What');
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);    //EDIT
//var    //per catturare il valore della cella cliccata riferirsi al dataset
//key:Word;
begin
          rs:=dbGrid1.DataSource.DataSet.FieldByName('what').AsString; //prima di qualsiasi altra azione
          dataSource1.DataSet:=ABSTable1;
          ABSTable1.Edit;
          modifica:=True;
          DataSource1.DataSet.Locate('what',rs,[loCaseInsensitive]);
          nr:=ABSTable1.RecNo;
          Button3.Caption:='Query';
          Label2.Caption:='Table mode';
end;


procedure TForm1.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Key=VK_TAB then
     begin
             if DBGrid1.SelectedIndex=2 then
          begin
            DBGrid1.Options := DBGrid1.Options - [dgEditing];  //per non far aggiungere un altra riga
            if modifica=True then
              begin                 //per ricollocarsi sul record iniziale
                DataSource1.DataSet.First;
                ABSTable1.MoveBy(nr-1);
                nr:=ABSTable1.RecNo;
                DBGrid1.SelectedRows.CurrentRowSelected:=True;
              end;
           SelectNext(ActiveControl as TWinControl,True,True);    // per avanzare di un tabStop
              nr:=ABSTable1.RecNo;
             modifica:=False;
          end;

     end;
end;

procedure TForm1.DBMemo1Enter(Sender: TObject);   //aggiungere un record e posizionare l'entry column
begin
              DataSource1.DataSet:=ABSTable1;
              ABSQuery1.Close;
              ABSTable1.edit;
              label2.Caption:='Table mode';
              Button3.Caption:='Query';
end;

procedure TForm1.DBMemo1Exit(Sender: TObject);  //salva in automatico  se c'� il record
var
mem1 :string;
begin

    mem1:= Form1.Caption;
  if ABSTable1.FieldByName('what').asString<>'' then
      begin
       ABSTable1.Edit;
       ABSTable1.Post;
       Form1.Caption:= Form1.Caption +
       '                                                           Record posted';
       sleep(1500);
      end;
     Form1.Caption:= mem1;
end;

procedure TForm1.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
   if (Button = nbInsert) then
   Button9Click(Self);
end;

{procedure TForm1.CMDialogKey(var AMessage:TCMDialogKey);
begin
    if DBGrid1.SelectedField.FieldNo=2 then
   if AMessage.CharCode=VK_TAB then
       AMessage.Result:=1 else inherited;
end;}

end.


program Corbi;

uses
  Vcl.Forms,
  Console1 in 'Console1.pas' {Form2},
  Login1 in 'Login1.pas' {Form1},
  AnaAtl in 'AnaAtl.pas' {Form3},
  Vcl.Themes,
  Vcl.Styles,
  AnaDspl in 'AnaDspl.pas' {Form4},
  AnaGa in 'AnaGa.pas' {Form5},
  Gara in 'Gara.pas' {Form6},
  aiuto in 'aiuto.pas' {Form7},
  Classifiche in 'Classifiche.pas' {Form8},
  Tempi in 'Tempi.pas' {Form9},
  Dialogs,
  Windows,
  System.UITypes,
  Mancanti in 'Mancanti.pas' {Form10};

//no2
{$R *.res}
  const
   TentaLancio='CodeCall.Net Mutex';  //no2
  resourcestring                      //no2
   DUPLICATE_MSG='Il programma è stato già lanciato. Non consente duplicati'; //no2
  var                          //no2
   vMutex :THandle;           //no2
{$D+}
begin                                   //codice per evitare doppia instanza
  vMutex :=CreateMutex(nil,True,TentaLancio);     //no2
   if GetLastError = ERROR_ALREADY_EXISTS then    //no2
      begin                                        //no2
        MessageDlg(DUPLICATE_MSG,mtError,[mbOK],0);//no2
        Exit;                                      //no2
      end;                                         //no2
    try                                            //no2
     Application.Initialize;
     Application.MainFormOnTaskbar := True;
    // Application.Title := 'Corbi';
     //Application.HelpFile := '.\corbi.chm';
     Application.CreateForm(TForm2, Form2);
     Application.CreateForm(TForm1, Form1);
     Application.CreateForm(TForm7, Form7);
     Application.CreateForm(TForm9, Form9);
     Application.CreateForm(TForm10, Form10);
     Application.CreateForm(TForm8, Form8);
     Application.CreateForm(TForm6, Form6);
     Application.CreateForm(TForm3, Form3);
     Application.CreateForm(TForm4, Form4);
     Application.CreateForm(TForm5, Form5);

     //posporre a Form2 che contiene il database
     Application.ShowMainForm := False;
     Application.Run;
     Application.NormalizeAllTopMosts ;
    finally                                        //no2
      CloseHandle(vMutex);                         //no2
    end;                                           //no2
end.

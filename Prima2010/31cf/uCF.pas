unit uCF;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Db, dbtables;

  // Questa E' la funzione d'interfaccia che deve essese chiamata
  Function GetCF(Cognome,Nome,Sesso,Stato,Comune : string; Dnascita:TdateTime; Sender:TComponent; AliasName:string; var CF : string ): Boolean;
  Function ControllaPiva(PI:string):boolean;

implementation

uses
   uTestCF;


const
     CONSONANTE = 0;
     VOCALE     = 1;
     ArrayMesi : array[1..12] of char = ('A','B','C','D','E','H','L','M','P','R','S','T');
     Controllo : array[0..25] of char = ('A','B','C','D','E','F','G','H','I','J','K','L',
                                         'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
     Carattere : array[1..36] of char = ('A','B','C','D','E','F','G','H','I','J','K',
                                         'L','M','N','O','P','Q','R','S','T','U','V',
                                         'W','X','Y','Z','0','1','2','3','4','5','6',
                                         '7','8','9');
     ArrayPari : array[1..36] of Integer = (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,
                                            18,19,20,21,22,23,24,25,0,1,2,3,4,5,6,7,8,9);

     ArrayDisPari : array[1..36] of Integer = (1,0,5,7,9,13,15,17,19,21,2,4,18,20,11,3,6,8,
                                            12,14,16,10,22,25,24,23,1,0,5,7,9,13,15,17,19,21);
var
   CF: string;

   Procedure CountLetters( S:string; var cc,cv: integer );
var
   i: Integer;
begin
     cc := 0;
     cv := 0;
     for i:=1 to Length(S) do
     begin
          if not (S[i] in ['A','E','I','O','U']) then Inc(cc) else Inc(cv);
     end;
end;

Function PeekLetters( S:string; Position, Tipo: Integer): string;
var
   i, CpC,CpV: Integer;
begin
     CpC :=0; // Contatore ordinale consonanti
     CpV :=0; // Contatore ordinale Vocali
     Result:= '?';
     for i:=1 to Length(S) do
     begin
          if not (S[i] in ['A','E','I','O','U']) then Inc(CpC) else Inc(CpV);
          if ((Tipo = CONSONANTE) and (CpC = Position)) or
                   ((Tipo = VOCALE) and (CpV = Position)) then
          begin
               Result := S[i];
               Break;
          end;
     end;
end;


Function GetPosition( car: string):Integer;
var
   i : Integer;
begin
     result:=0;
     for i:= 1 to 36 do
     begin
          if Carattere[i] = car then
          begin
               result:=i;
               break;
          end;
     end;
end;


Function SetControllo(CF: string):String;
var
   Pari, Dispari, i, car : Integer;
begin
     Pari := 0;
     Dispari := 0;
     for i:=1 to Length(CF) do
     begin
          if (i mod 2) = 1 then Inc(DisPari,ArrayDispari[ GetPosition(CF[i]) ]) else
                                Inc(Pari,ArrayPari[ GetPosition(CF[i]) ]);
     end;
     // vengono sommati i counters e presso il modulo 26
     car := (Pari+Dispari) mod 26;
     result := Controllo[car];
end;


Function Normalizza(S: string):String;
var
   i : Integer;
   O : string;
begin
     O:='';
     for i:=1 to length(S) do
     begin
         if uppercase(S)[i] in ['A'..'Z'] then O := O + S[i];
     end;
     result := O;
end;

Function GetCF(Cognome,Nome,Sesso,Stato,Comune : string; Dnascita:TdateTime; Sender:TComponent; AliasName:string; var CF : string ): Boolean;
var
   Consonanti, Vocali : Integer;
   Anno,Mese,Giorno : word;
   lookTable : TQuery;
   myQuery,Codice : string;
begin
     Result := False;

     // Controllo Cognome
     if Trim(Cognome) = '' then
     begin
          ShowMessage('COGNOME NON VALIDO');
          Exit;
     end;
     Cognome:= Normalizza(Cognome);

     // Controllo Nome
     if Trim(Nome) = '' then
     begin
          ShowMessage('NOME NON VALIDO');
          Exit;
     end;
     Nome   := Normalizza(Nome);

     // Controllo Sesso
     if (Trim(Sesso) = '') or ((Sesso <> 'F') and (Sesso <> 'M')) then
     begin
          ShowMessage('SESSO NON VALIDO (M/F)');
          Exit;
     end;

     // Controllo dello Stato di nascita
     if Trim(Stato) = '' then
     begin
          ShowMessage('STATO NON VALIDO');
          Exit;
     end;

     if Pos( Stato, 'ITALIA') <> 0 then
     begin
          // Controllo del Comune di nascita
           if Trim(Comune) = '' then
           begin
                ShowMessage('COMUNE NON VALIDO');
                Exit;
           end;
     end;
     //*********************************************
     // Analisi del numero di consonanti del cognome
     //*********************************************
     // 3+ -> 1°, 2° e 3°
     // 2  -> 1°, 2° + 1° vocale
     // 1 + 2 vocali -> 1° + 1° vocale + 2° vocale
     // 1 + 1 vocale -> 1° + vocale + 'X'
     // 2 vocali -> 1° vocale+ 2° vocale + 'X'

     CountLetters(Cognome,Consonanti,vocali);

     if (Consonanti >= 3) then CF:=CF+PeekLetters(Cognome,1,CONSONANTE)+
                                      PeekLetters(Cognome,2,CONSONANTE)+
                                      PeekLetters(Cognome,3,CONSONANTE);

     if (Consonanti = 2)  then CF:=CF+PeekLetters(Cognome,1,CONSONANTE)+
                                      PeekLetters(Cognome,2,CONSONANTE)+
                                      PeekLetters(Cognome,1,VOCALE);

     if (Consonanti = 1) and ( Vocali = 2 ) then
                               CF:=CF+PeekLetters(Cognome,1,CONSONANTE)+
                                      PeekLetters(Cognome,1,VOCALE)+
                                      PeekLetters(Cognome,2,VOCALE);

     if (Consonanti = 1) and ( Vocali = 1 ) then
                               CF:=CF+PeekLetters(Cognome,1,CONSONANTE)+
                                      PeekLetters(Cognome,1,VOCALE)+ 'X';

     if (Consonanti = 0) and ( Vocali = 2 ) then
                               CF:=CF+PeekLetters(Cognome,1,VOCALE)+
                                      PeekLetters(Cognome,2,VOCALE)+ 'X';

     //*********************************************
     // Analisi del numero di consonanti del nome
     //*********************************************
     // 4+ -> 1°, 3° e 4°
     // 3 -> 1°, 2° e 3°
     // 2  -> 1°, 2° + 1° vocale
     // 1 + 2 vocali -> 1° + 1° vocale + 2° vocale
     // 1 + 1 vocale -> 1° + vocale + 'X'
     // 2 vocali -> 1° vocale+ 2° vocale + 'X'

     CountLetters(Nome,Consonanti,vocali);

     if (Consonanti >= 4) then CF:=CF+PeekLetters(Nome,1,CONSONANTE)+
                                      PeekLetters(Nome,3,CONSONANTE)+
                                      PeekLetters(Nome,4,CONSONANTE);

     if (Consonanti = 3)  then CF:=CF+PeekLetters(Nome,1,CONSONANTE)+
                                      PeekLetters(Nome,2,CONSONANTE)+
                                      PeekLetters(Nome,3,CONSONANTE);

     if (Consonanti = 2)  then CF:=CF+PeekLetters(Nome,1,CONSONANTE)+
                                      PeekLetters(Nome,2,CONSONANTE)+
                                      PeekLetters(Nome,1,VOCALE);

     if (Consonanti = 1) and ( Vocali = 2 ) then
                               CF:=CF+PeekLetters(Nome,1,CONSONANTE)+
                                      PeekLetters(Nome,1,VOCALE)+
                                      PeekLetters(Nome,2,VOCALE);

     if (Consonanti = 1) and ( Vocali = 1 ) then
                               CF:=CF+PeekLetters(Nome,1,CONSONANTE)+
                                      PeekLetters(Nome,1,VOCALE)+ 'X';

     if (Consonanti = 0) and ( Vocali = 2 ) then
                               CF:=CF+PeekLetters(Nome,1,VOCALE)+
                                      PeekLetters(Nome,2,VOCALE)+ 'X';

     try
        DecodeDate(Dnascita,Anno,Mese,Giorno);
     except
           ShowMessage('DATA DI NASCITA NON VALIDA (GG/MM/AAAA)');
           Exit;
     end;

     // Data di nascita
     if Sesso = 'F' then Giorno := Giorno+ 40;
     CF := CF+ IntToStr(Anno mod 100)+ArrayMesi[Mese]+Format('%2.2d',[Giorno]);

     // Ricerca codici stato/comune
     if Pos( Stato, 'ITALIA') <> 0 then
     begin
          // Nato in Italia, ricerco il comune
          myQuery:=Format('SELECT nazionale AS Ris FROM cfItalia WHERE comune = ''%s''',[Comune]);
     end
     else
     begin
          // Nato All'estero, ricerco la nazione
          myQuery:=Format('SELECT codice AS Ris FROM cfEsteri WHERE denominaz = ''%s''',[Stato]);
     end;

     Codice := '';
     LookTable := TQuery.Create(Sender);
     LookTable.DatabaseName:= AliasName;
     LookTable.SQL.Add(myQuery);
     try
        try
           LookTable.Open;
        except
              raise;
        end;
     finally
          Codice := LookTable.FieldByName('Ris').asString;
          LookTable.Free;
     end;
     // Comune
     CF := CF + Codice;

     // Caratterre di controllo
     CF := CF + SetControllo(CF);

end;

Function ControllaPiva(PI:string):boolean;
var
   Index, Cifra,Code, Controllo,i : Integer;
begin
     Result := False;
     if Length(PI) <> 11 then
     begin
          ShowMessage('LUNGHEZZA PARTITA IVA NON VALIDA');
          Exit;
     end;

     for i:= 1 to 11 do
     begin
          if not (PI[i] in ['0','1','2','3','4','5','6','7','8','9']) then
          begin
               ShowMessage('CIFRE PARTITA IVA NON VALIDE');
               Exit;
          end;
     end;

     Controllo:=0;
     for index:=1 to 10 do
     begin
          val(copy(PI,index,1),cifra,code);
          if (index mod 2)= 0 then
          begin
               cifra:=cifra*2;
               Controllo := Controllo+(cifra mod 10)+(cifra div 10);
          end
          else Controllo := Controllo+cifra;
     end;
     Controllo := 10-(Controllo mod 10);
     Controllo := Controllo mod 10;
     val(copy(PI,11,1),cifra,code);
     if (Cifra <> Controllo) then
     begin
           Showmessage('CODICE IVA NON VALIDO');
           Exit;
     end;
     Result := True;
end;

end.

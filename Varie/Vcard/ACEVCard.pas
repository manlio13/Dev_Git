unit ACEVCard;

Interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ACEVCCls, StrUtils;

const
  DefaultDate: TDateTime = 0;

type
  TAceVCard = Class(TComponent)
  private
    FIdentInfo: TVCIdentInfo;
    FAddressInfo: TVCAddressInfo;
    FPhoneNumbers: TVCPhoneNumbers;
    FEmails: TVCEmailAddresses;
    FAdditional: TVCAdditionalInfo;
    FVersion: String;
    FRevision: TDateTime;
    procedure SetIdent(Value: TVCIdentInfo);
    procedure SetAddressInfo(Value: TVCAddressInfo);
    procedure SetPhoneNumbers(Value: TVCPhoneNumbers);
    procedure SetEmails(Value: TVCEmailAddresses);
    procedure SetAdditional(Value: TVCAdditionalInfo);
  Public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Value: TPersistent); override;
    procedure Clear;
    procedure LoadFromFile(Filename: String);
    function SaveToFile(Filename: String): Boolean;
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
  published
    property Personal: TVCIdentInfo read FIdentInfo write SetIdent;
    property Addresses: TVCAddressInfo read FAddressInfo write SetAddressInfo;
    property PhoneNumbers: TVCPhoneNumbers read FPhoneNumbers write SetPhoneNumbers;
    property EmailAddresses: TVCEmailAddresses read FEmails write SetEmails;
    property Additional: TVCAdditionalInfo read FAdditional write SetAdditional;
    property Version: string read FVersion;
    property Revision: TDateTime read FRevision;
  End;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('ACESoftware', [TACEVCard]);
end;

constructor TAceVCard.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIdentInfo := TVCIdentInfo.Create;
  FAddressInfo := TVCAddressInfo.Create;
  FPhoneNumbers := TVCPhoneNumbers.Create;
  FEmails := TVCEmailAddresses.Create;
  FAdditional := TVCAdditionalInfo.Create;
end;

destructor TAceVCard.Destroy;
begin
  FIdentInfo.Free;
  FAddressInfo.Free;
  FPhonenumbers.Free;
  FEmails.Free;
  FAdditional.Free;
  inherited Destroy;
end;

procedure TACEVCard.SetIdent(Value: TVCIdentInfo);
begin
  FIdentInfo.Assign(Value);
end;

procedure TACEVCard.SetAddressInfo(Value: TVCAddressInfo);
begin
  FAddressInfo.Assign(Value);
end;

procedure TACEVCard.SetPhoneNumbers(Value: TVCPhoneNumbers);
begin
  FPhoneNumbers.Assign(Value);
end;

procedure TACEVCard.SetEmails(Value: TVCEmailAddresses);
begin
  FEmails.Assign(Value);
end;

procedure TACEVCard.SetAdditional(Value: TVCAdditionalInfo);
begin
  FAdditional.Assign(Value);
end;

procedure TACEVCard.Assign(Value: TPersistent);
begin
  if Value is TACEVCard then
  begin
    FIdentInfo.Assign((Value as TACEVCard).Personal);
    FAddressInfo.Assign((Value as TACEVCard).Addresses);
    FPhoneNumbers.Assign((Value as TACEVCard).PhoneNumbers);
    FEmails.Assign((Value as TACEVCard).EmailAddresses);
    FAdditional.Assign((Value as TACEVCard).Additional);
    FVersion := (Value as TACEVCard).Version;
    FRevision := (Value as TACEVCard).Revision;
  end
  else inherited Assign(Value);
end;

procedure TACEVCard.Clear;
begin
  FIdentInfo.Clear;
  FAddressInfo.Clear;
  FPhoneNumbers.Clear;
  FEmails.Clear;
  FAdditional.Clear;
  FVersion := '';
  FRevision := DefaultDate;
end;

procedure TACEVCard.LoadFromFile(Filename: string);
var
  I, V: TStrings;
  FV, FFN, FN: Boolean;
  A: Integer;
  S, D1, D2: String;
begin
  I := TStringList.Create;
  V := TStringList.Create;
  try
    I.LoadFromFile(FileName);
    I.Text := AnsiReplaceStr(I.Text, #13#10#32, '');
    I.Text := AnsiReplaceStr(I.Text, #13#10#9, '');
    A := I.Count;
    if (I[1] <> 'BEGIN:VCARD') OR (I[A-1] <> 'END:VCARD') then
      Raise EVCardLoadError.CreateFmt('%s is not a valid VCard File', [FileName]);
    FV := False;
    FFN := False;
    FN := False;
    for A := 0 to I.Count - 1 do
    begin
      if AnsiLeftStr(I[A], 8) = 'VERSION:' then FV := True;
      if AnsiLeftStr(I[A], 3) = 'FN:' then FFN := True;
      if AnsiLeftStr(I[A], 2) = 'N:' then FN := True;
    end;
    if NOT FV then
      Raise EVCardLoadError.CreateFmt('%s does not contain a valid Version Identifier', [FileName]);
    if NOT FFN then
      Raise EVCardLoadError.CreateFmt('%s does not contain a valid Formatted Name Identifier', [FileName]);
    if NOT FN then
      Raise EVCardLoadError.CreateFmt('%s does not contain a valid Name Identifier', [FileName]);
    FIdentInfo.LoadFromStringList(I);
    FAddressInfo.LoadFromStringList(I);
    FPhoneNumbers.LoadFromStringList(I);
    FEmails.LoadFromStringList(I);
    FAdditional.LoadFromStringList(I);
    for A := 0 to I.Count - 1 do
    begin
      S := I[A];
      if AnsiLeftStr(S, 8) = 'VERSION:' then
        FVersion := Copy(S, 9, Length(S));
      if AnsiLeftStr(S, 4) = 'REV:' then
      begin
        S := Copy(S, 5, Length(S));
        if Pos('T', S) = 0 then
        begin
          D2 := '00:00:00';
          V := Explode(S, '-');
          D1 := V[2] + '-' + V[1] + '-' + V[0];
        end
        else
        begin
          V := Explode(Copy(S, 1, Pos('T', S) - 1), '-');
          D1 := V[2] + '-' + V[1] + '-' + V[0];
          D2 := Copy(S, Pos('T', S) + 1, Pos('Z', S) - 1);
        end;
        FRevision := StrToDateTime(D1 + ' ' + D2);
      end;
    end;
  finally
    I.Free;
    V.Free;
  end;
end;

function TACEVCard.SaveToFile(Filename: string): Boolean;
var
  O: TStrings;
  S: String;
  L: Integer;
begin
  Result := False;
  try
    O := TStringList.Create;
    try
      O.Clear;
      O.Add('BEGIN:VCARD');
      O.Add('VERSION:3.0');
      if NOT FIdentInfo.SaveToStringList(O) then Exit;
      FAddressInfo.SaveToStringList(O);
      FPhoneNumbers.SaveToStringList(O);
      FEmails.SaveToStringList(O);
      FAdditional.SaveToStringList(O);
      O.Add('REV:' + FormatDateTime('yyyy-mm-dd', now) + 'T' + FormatDateTime('hh:nn:ss', now) + 'Z');
      L := 0;
      while L < O.Count do
      begin
        S := O[L];
        if Length(S) > 75 then
        begin
          O[L] := Copy(S, 1, 75);
          O.Insert(L + 1, #32 + Copy(S, 76, Length(S) - 75));
        end;
        Inc(L, 1);
      end;
      O.Add('END:VCARD');
      O.SaveToFile(FileName);
    finally
      O.Free;
    end;
    Result := True;
  except
    L := GetLastError;
    Raise EVCardSaveError.CreateFmt('An Error occured while saving the VCard to File %s' + #13#10 + '(ErrCod: 0x%x.4)', [FileName, L]);
  end;
end;

procedure TACEVCard.LoadFromStream(Stream: TStream);
var
  I, V: TStrings;
  FV, FFN, FN: Boolean;
  A: Integer;
  S, D1, D2: String;
begin
  I := TStringList.Create;
  V := TStringList.Create;
  try
    I.LoadFromStream(Stream);
    I.Text := AnsiReplaceStr(I.Text, #13#10#32, '');
    I.Text := AnsiReplaceStr(I.Text, #13#10#9, '');
    A := I.Count;
    if (I[1] <> 'BEGIN:VCARD') OR (I[A-1] <> 'END:VCARD') then
      Raise EVCardLoadError.Create('Stream does not contain a valid VCard File');
    FV := False;
    FFN := False;
    FN := False;
    for A := 0 to I.Count - 1 do
    begin
      if AnsiLeftStr(I[A], 8) = 'VERSION:' then FV := True;
      if AnsiLeftStr(I[A], 3) = 'FN:' then FFN := True;
      if AnsiLeftStr(I[A], 2) = 'N:' then FN := True;
    end;
    if NOT FV then
      Raise EVCardLoadError.Create('VCard in Stream does not contain a valid Version Identifier');
    if NOT FFN then
      Raise EVCardLoadError.Create('VCard in Stream does not contain a valid Formatted Name Identifier');
    if NOT FN then
      Raise EVCardLoadError.Create('VCard in Stream does not contain a valid Name Identifier');
    FIdentInfo.LoadFromStringList(I);
    FAddressInfo.LoadFromStringList(I);
    FPhoneNumbers.LoadFromStringList(I);
    FEmails.LoadFromStringList(I);
    FAdditional.LoadFromStringList(I);
    for A := 0 to I.Count - 1 do
    begin
      S := I[A];
      if AnsiLeftStr(S, 8) = 'VERSION:' then
        FVersion := Copy(S, 9, Length(S));
      if AnsiLeftStr(S, 4) = 'REV:' then
      begin
        S := Copy(S, 5, Length(S));
        if Pos('T', S) = 0 then
        begin
          D2 := '00:00:00';
          V := Explode(S, '-');
          D1 := V[2] + '-' + V[1] + '-' + V[0];
        end
        else
        begin
          V := Explode(Copy(S, 1, Pos('T', S) - 1), '-');
          D1 := V[2] + '-' + V[1] + '-' + V[0];
          D2 := Copy(S, Pos('T', S) + 1, Pos('Z', S) - 1);
        end;
        FRevision := StrToDateTime(D1 + ' ' + D2);
      end;
    end;
  finally
    I.Free;
    V.Free;
  end;
end;

procedure TACEVCard.SaveToStream(Stream: TStream);
var
  O: TStrings;
  S: String;
  L: Integer;
begin
  try
    O := TStringList.Create;
    try
      O.Clear;
      O.Add('BEGIN:VCARD');
      O.Add('VERSION:3.0');
      if NOT FIdentInfo.SaveToStringList(O) then Exit;
      FAddressInfo.SaveToStringList(O);
      FPhoneNumbers.SaveToStringList(O);
      FEmails.SaveToStringList(O);
      FAdditional.SaveToStringList(O);
      O.Add('REV:' + FormatDateTime('yyyy-mm-dd', now) + 'T' + FormatDateTime('hh:nn:ss', now) + 'Z');
      L := 0;
      while L < O.Count do
      begin
        S := O[L];
        if Length(S) > 75 then
        begin
          O[L] := Copy(S, 1, 75);
          O.Insert(L + 1, #32 + Copy(S, 76, Length(S) - 75));
        end;
        Inc(L, 1);
      end;
      O.Add('END:VCARD');
      O.SaveToStream(Stream);
    finally
      O.Free;
    end;
  except
    L := GetLastError;
    Raise EVCardSaveError.CreateFmt('An Error occured while saving the VCard to Stream.' + #13#10 + '(ErrCod: 0x%x.4)', [L]);
  end;
end;

end.

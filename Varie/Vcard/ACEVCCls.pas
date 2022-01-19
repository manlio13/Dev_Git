unit ACEVCCls;

interface

uses
  SysUtils, Classes, StrUtils;

type
  TVCAddressType = (vcaDomestic, vcaInternational, vcaPostal, vcaParcel,
                    vcaHome, vcaWork);
  TVCPhoneType = (vcpPreferred, vcpWork, vcpHome, vcpVoice, vcpFax,
                  vcpMessaging, vcpMobile, vcpPager, vcpBBS, vcpModem,
                  vcpCarphone, vcpISDN, vcpVideo);
  TVCEmailType = (vceDefault, vceAOL, vceAppleLink, vceATTMail, vceCompuserve,
                  vceeWorld, vceInternet, vceIBM, vceMCI, vcePowerShare,
                  vceProdigy, vceTelex, vceX400, vceMessenger);

  TVCAddressAttr = Set of TVCAddressType;
  TVCPhoneAttr = Set of TVCPhoneType;

Const
  AddressStrings : array[TVCAddressType] of string[6] =
                  ('DOM','INTL','POSTAL','PARCEL','HOME','WORK');
  PhoneStrings : array[TVCPhoneType] of string[5] =
                  ('PREF','WORK','HOME','VOICE','FAX','MSG','CELL',
                   'PAGER','BBS','MODEM','CAR','ISDN','VIDEO');
  EmailStrings : array[TVCEmailType] of string[10] =
                  ('','AOL','APPLELINK','ATTMAIL','CIS','EWORLD','INTERNET',
                   'IBMMAIL','MCIMAIL','POWERSHARE','PRODIGY','TLX','X400',
                   'MESSENGER');

Type

  EVCardException = Class(Exception);

  EVCardSaveError = Class(EVCardException);

  EVCardLoadError = Class(EVCardException);

  TVCNameRec = class(TPersistent)
  private
    FFamilyName : string;
    FGivenName : string;
    FAdditionalNames : string;
    FPrefix : string;
    FSuffix : string;
  public
    procedure Assign(Value : TPersistent); override;
    procedure Clear;
    function SaveToString: String;
    procedure LoadFromString(Input: String);
  published
    property FamilyName : string read FFamilyName write FFamilyName;
    property GivenName : string read FGivenName write FGivenName;
    property AdditionalNames : string read FAdditionalNames write FAdditionalNames;
    property Prefix : string read FPrefix write FPrefix;
    property Suffix : string read FSuffix write FSuffix;
  end;

  TVCAddressRec = Class(TPersistent)
  Private
    FAttributes: TVCAddressAttr;
    FPostBox: String;
    FExtended: String;
    FStreet : string;
    FLocality : string;
    FRegion : string;
    FPostalCode : string;
    FCountry : string;
  Protected
    procedure GetAttributes(Input: TStrings);
  Public
    procedure Assign(Value: TPersistent); override;
    procedure Clear;
    function SaveToString: String;
    procedure LoadFromString(Input: String);
  Published
    property Attributes: TVCAddressAttr read FAttributes write FAttributes;
    property Postbox: String read FPostBox write FPostBox;
    property ExtendedAddress: string read FExtended write FExtended;
    property Street : string read FStreet write FStreet;
    property Locality : string read FLocality write FLocality;
    property Region : string read FRegion write FRegion;
    property PostalCode : string read FPostalCode write FPostalCode;
    property Country : string read FCountry write FCountry;
  end;

  TVCPhoneRec = Class(TPersistent)
  private
    FAttributes: TVCPhoneAttr;
    FNumber: String;
  Protected
    procedure GetAttributes(Input: TStrings);
  Public
    procedure Assign(Value: TPersistent); override;
    procedure Clear;
    Function SaveToString: String;
    Procedure LoadFromString(Input: String);
  Published
    property Attributes: TVCPhoneAttr read FAttributes write FAttributes;
    property Number: String Read FNumber Write FNumber;
  End;

  TVCEmailRec = Class(TPersistent)
  private
    FAttribute: TVCEmailType;
    FAddress: String;
  Public
    procedure Assign(Value: TPersistent); override;
    procedure Clear;
    function SaveToString: string;
    procedure LoadFromString(Input: String);
  published
    property EmailType: TVCEmailType read FAttribute write FAttribute;
    property Address: string read FAddress write FAddress;
  End;

  TVCCompanyRec = Class(TPersistent)
  private
    FCName: String;
    FUnit: String;
    FSubUnit1: String;
    FSubUnit2: String;
    FSubUnit3: String;
    FSubUnit4: String;
    FTitle: String;
    FRole: String;
    Procedure ParseCompany(Input: String);
  public
    procedure Assign(Value: TPersistent); override;
    procedure Clear;
    procedure SaveToStringList(Output: TStrings);
    Procedure LoadFromStringList(Input: TStrings);
  Published
    Property CompanyName: String read FCName write FCName;
    Property CompanyUnit: String read FUnit write FUnit;
    Property SubUnit1: String read FSubUnit1 write FSubUnit1;
    Property SubUnit2: String read FSubUnit2 write FSubUnit2;
    Property SubUnit3: String read FSubUnit3 write FSubUnit3;
    Property SubUnit4: String read FSubUnit4 write FSubUnit4;
    Property Title: String read FTitle write FTitle;
    property Role: String read FRole write FRole;
  End;

  TVCGeoLoc = class(TPersistent)
  private
    FLatitude: Double;
    FLongitude: Double;
  Public
    procedure Assign(Value: TPersistent); override;
    procedure Clear;
    procedure LoadFromString(Input: String);
    function SaveToString: String;
  published
    Property Latitude: Double read FLatitude write FLatitude;
    Property Longitude: Double read FLongitude write FLongitude;
  end;

  TVCIdentInfo = Class(TPersistent)
  private
    FName: TVCNameRec;
    FFormattedName: String;
    FSortString: String;
    FCompany: TVCCompanyRec;
    procedure SetName(Value: TVCNameRec);
    procedure SetCompany(Value: TVCCompanyRec);
  Public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Value: TPersistent); override;
    procedure Clear;
    function SaveToStringList(Output: TStrings): Boolean;
    procedure LoadFromStringList(Input: TStrings);
  Published
    property Name: TVCNameRec read FName Write FName;
    property FormattedName: String read FFormattedname write FFormattedName;
    property SortString: String read FSortString write fSortString;
    property Company: TVCCompanyRec read FCompany write FCompany;
  End;

  TVCAddressInfo = Class(TPersistent)
  private
    FAddress1: TVCAddressRec;
    FAddress2: TVCAddressRec;
    FAddress3: TVCAddressRec;
    FAddress4: TVCAddressRec;
    procedure SetAddress1(A: TVCAddressRec);
    procedure SetAddress2(A: TVCAddressRec);
    procedure SetAddress3(A: TVCAddressRec);
    procedure SetAddress4(A: TVCAddressRec);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Value: TPersistent); override;
    procedure Clear;
    procedure SaveToStringList(Output: TStrings);
    procedure LoadFromStringList(Input: TStrings);
  published
    property Address1: TVCAddressRec read FAddress1 write FAddress1;
    property Address2: TVCAddressRec read FAddress2 write FAddress2;
    property Address3: TVCAddressRec read FAddress3 write FAddress3;
    property Address4: TVCAddressRec read FAddress4 write FAddress4;
  End;

  TVCPhoneNumbers = Class(TPersistent)
  private
    FPhone1: TVCPhoneRec;
    FPhone2: TVCPhoneRec;
    FPhone3: TVCPhoneRec;
    FPhone4: TVCPhoneRec;
    FPhone5: TVCPhoneRec;
    FPhone6: TVCPhoneRec;
    FPhone7: TVCPhoneRec;
    FPhone8: TVCPhoneRec;
    procedure SetPhone1(Value: TVCPhoneRec);
    procedure SetPhone2(Value: TVCPhoneRec);
    procedure SetPhone3(Value: TVCPhoneRec);
    procedure SetPhone4(Value: TVCPhoneRec);
    procedure SetPhone5(Value: TVCPhoneRec);
    procedure SetPhone6(Value: TVCPhoneRec);
    procedure SetPhone7(Value: TVCPhoneRec);
    procedure SetPhone8(Value: TVCPhoneRec);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Value: TPersistent); override;
    procedure Clear;
    procedure SaveToStringList(Output: TStrings);
    procedure LoadFromStringList(Input: TStrings);
  published
    property Phone1: TVCPhoneRec read FPhone1 write FPhone1;
    property Phone2: TVCPhoneRec read FPhone2 write FPhone2;
    property Phone3: TVCPhoneRec read FPhone3 write FPhone3;
    property Phone4: TVCPhoneRec read FPhone4 write FPhone4;
    property Phone5: TVCPhoneRec read FPhone5 write FPhone5;
    property Phone6: TVCPhoneRec read FPhone6 write FPhone6;
    property Phone7: TVCPhoneRec read FPhone7 write FPhone7;
    property Phone8: TVCPhoneRec read FPhone8 write FPhone8;
  end;

  TVCEmailAddresses = Class(TPersistent)
  private
    FEmail1: TVCEmailRec;
    FEmail2: TVCEmailRec;
    FEmail3: TVCEmailRec;
    FEmail4: TVCEmailRec;
    FEmail5: TVCEmailRec;
    FEmail6: TVCEmailRec;
    FEmail7: TVCEmailRec;
    FEmail8: TVCEmailRec;
    procedure SetEmail1(Value: TVCEmailRec);
    procedure SetEmail2(Value: TVCEmailRec);
    procedure SetEmail3(Value: TVCEmailRec);
    procedure SetEmail4(Value: TVCEmailRec);
    procedure SetEmail5(Value: TVCEmailRec);
    procedure SetEmail6(Value: TVCEmailRec);
    procedure SetEmail7(Value: TVCEmailRec);
    procedure SetEmail8(Value: TVCEmailRec);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Value: TPersistent); override;
    procedure Clear;
    procedure LoadFromStringList(Input: TStrings);
    procedure SaveToStringList(OutPut: TStrings);
  published
    property EmailAddress1: TVCEmailRec read FEmail1 write FEmail1;
    property EmailAddress2: TVCEmailRec read FEmail2 write FEmail2;
    property EmailAddress3: TVCEmailRec read FEmail3 write FEmail3;
    property EmailAddress4: TVCEmailRec read FEmail4 write FEmail4;
    property EmailAddress5: TVCEmailRec read FEmail5 write FEmail5;
    property EmailAddress6: TVCEmailRec read FEmail6 write FEmail6;
    property EmailAddress7: TVCEmailRec read FEmail7 write FEmail7;
    property EmailAddress8: TVCEmailRec read FEmail8 write FEmail8;
  End;

  TVCAdditionalInfo = Class(TPersistent)
  private
    FComment: TStrings;
    FURL1: String;
    FURL2: String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Value: TPersistent); override;
    procedure Clear;
    procedure SaveToStringList(Output: TStrings);
    procedure LoadFromStringList(Input: TStrings);
  Published
    property Comment: TStrings read FComment write FComment;
    property URL1: String read FURL1 write FURL1;
    property URL2: String read FURL2 write FURL2;
  end;

function EscapeStr(Input: String): String;
function UnEscapeStr(Input: String): String;
Function Explode(Input: String; Delim: Char): TStrings;

implementation

{Escape Characters : ; , to comply with VCard 3.0 Specs}
function EscapeStr(Input: String): String;
var
  R: String;
begin
  {First, escape all characters}
  R := AnsiReplaceText(Input, ',', '\,');
  R := AnsiReplaceText(R, ';', '\;');
  R := AnsiReplaceText(R, ':', '\:');
  {Next, remove any accidental double escapes}
  R := AnsiReplaceText(R, '\\,', '\,');
  R := AnsiReplaceText(R, '\\;', '\;');
  R := AnsiReplaceText(R, '\\:', '\:');
  Result := R;
end;

{UnEscape Characters : ; , after escaping them}
function UnEscapeStr(Input: String): String;
var
  R: String;
begin
  R := AnsiReplaceText(Input, '\,', ',');
  R := AnsiReplaceText(R, '\;', ';');
  R := AnsiReplaceText(R, '\:', ':');
  Result := R;
end;

{Explode any string to a TStringSet, using Delim as a splitter,
  unless the Delim Character is escaped}
Function Explode(Input: String; Delim: Char): TStrings;
var
  P: Integer;
  UnEsc: String;
  Sub: String;
begin
  Result := nil;
  if Delim = '%' then Sub := '$ESCAPEDCHAR$' else Sub := '%ESCAPEDCHAR%';
  Result.Clear;
  UnEsc := AnsiReplaceText(Input, '\' + Delim, Sub);
  while Pos(Delim, UnEsc) > 0 do
  begin
    P := Pos(Delim, UnEsc);
    Result.Add(Copy(UnEsc, 1, P-1));
    Delete(UnEsc, 1, P);
  end;
  if UnEsc <> '' then Result.Add(UnEsc);
  for P := 0 to Result.Count - 1 do
    Result.Strings[P] := AnsiReplaceText(Result.Strings[P], Sub, '\' + Delim);
end;

{TVCNameRec}

procedure TVCNameRec.Assign(Value: TPersistent);
begin
  if Value is TVCNameRec then
  begin
    FFamilyName := (Value as TVCNameRec).FamilyName;
    FGivenName := (Value as TVCNameRec).GivenName;
    FAdditionalNames := (Value as TVCNameRec).AdditionalNames;
    FPrefix := (Value as TVCNameRec).Prefix;
    FSuffix := (Value as TVCNameRec).Suffix;
  end
  else inherited Assign(Value);
end;

procedure TVCNameRec.Clear;
begin
  FFamilyName := '';
  FGivenName := '';
  FAdditionalNames := '';
  FPrefix := '';
  FSuffix := '';
end;

function TVCNameRec.SaveToString: String;
var
  S: String;
begin
  S := 'N:' + EscapeStr(FFamilyName) + ';';
  S := S + EscapeStr(FGivenName) + ';';
  S := S + EscapeStr(FAdditionalNames) + ';';
  S := S + EscapeStr(FPrefix) + ';';
  S := S + EscapeStr(FSuffix);
  Result := S;
end;

procedure TVCNameRec.LoadFromString(Input: String);
var
  V: TStrings;
begin
  Clear;
  V := TStringList.Create;
  Try
    V := Explode(Input, ';');
    if NOT (Copy(V.Strings[0], 1, 2) = 'N:') then Exit;
    if V.Count > 0 then FFamilyName := UnEscapeStr(Copy(V.Strings[0], 3, Length(V.Strings[0]) - 2));
    if V.Count > 1 then FGivenName := UnEscapeStr(V.Strings[1]);
    if V.Count > 2 then FAdditionalNames := UnEscapeStr(V.Strings[2]);
    if V.Count > 3 then FPrefix := UnEscapeStr(V.Strings[3]);
    if V.Count > 4 then FSuffix := UnEscapeStr(V.Strings[4]);
  Finally
    V.Free;
  End;
end;

{TVCAddressRec}

procedure TVCAddressRec.Assign(Value: TPersistent);
begin
  if Value is TVCAddressRec then
  begin
    FAttributes := (Value as TVCAddressRec).Attributes;
    FPostBox := (Value as TVCAddressRec).Postbox;
    FExtended := (Value as TVCAddressRec).ExtendedAddress;
    FStreet := (Value as TVCAddressRec).Street;
    FLocality := (Value as TVCAddressRec).Locality;
    FRegion := (Value as TVCAddressRec).Region;
    FPostalCode := (Value as TVCAddressRec).PostalCode;
    FCountry := (Value as TVCAddressRec).Country;
  end
  else inherited Assign(Value);
end;

procedure TVCAddressRec.Clear;
begin
  FAttributes := [];
  FPostbox := '';
  FExtended := '';
  FStreet := '';
  FLocality := '';
  FRegion := '';
  FPostalCode := '';
  FCountry := '';
end;

procedure TVCAddressRec.GetAttributes(Input: TStrings);
var
  A: TVCAddressType;
begin
  if Input.Count > 0 then
  begin
    for A := vcaDomestic to vcaWork do
    begin
      if Input.IndexOf(String(AddressStrings[A])) > -1 then
        Include(FAttributes, A);
    end;
  end;
end;

procedure TVCAddressRec.LoadFromString(Input: string);
var
  T, V: TStrings;
  S: String;
begin
  Clear;
  V := TStringList.Create;
  T := TStringList.Create;
  try
    V := Explode(Input, ';');
    if AnsiUpperCase(V.Strings[0]) <> 'ADR' then Exit;
    T := Explode(V.Strings[1], ':');
    V.Strings[1] := T.Strings[1];
    S := T.Strings[0];
    if AnsiUpperCase(Copy(S, 1, 5)) = 'TYPE=' then
      Delete(S, 1, 5);
    T := Explode(S, ',');
    GetAttributes(T);
    if V.Count > 1 then FPostBox := UnEscapeStr(V.Strings[1]);
    if V.Count > 2 then FExtended := UnEscapeStr(V.Strings[2]);
    if V.Count > 3 then FStreet := UnEscapeStr(V.Strings[3]);
    if V.Count > 4 then FLocality := UnEscapeStr(V.Strings[4]);
    if V.Count > 5 then FRegion := UnEscapeStr(V.Strings[5]);
    if V.Count > 6 then FPostalCode := UnEscapeStr(V.Strings[6]);
    if V.Count > 7 then FCountry := UnEscapeStr(V.Strings[7]);
  finally
    T.Free;
    V.Free;
  end;
end;

function TVCAddressRec.SaveToString: String;
var
  S: String;
  A: TVCAddressType;
begin
  Result := '';
  if ((FPostBox = '') AND (FExtended = '') AND (FStreet = '') AND
     (FLocality = '') AND (FRegion = '') AND (FPostalCode = '') AND
     (FCountry = '')) then Exit;
  S := 'ADR;TYPE=';
  for A := vcaDomestic to vcaWork do
    if (A in FAttributes) then S := S + String(AddressStrings[A]) + ',';
  S[Length(S)] := ':';
  S := S + EscapeStr(FPostBox) + ';' + EscapeStr(FExtended) + ';' +
       EscapeStr(FStreet) + ';' + EscapeStr(FLocality) + ';' +
       EscapeStr(FRegion) + ';' + EscapeStr(FPostalCode) + ';' +
       EscapeStr(FCountry);
  Result := S;
end;

{ TVCPhoneRec }

procedure TVCPhoneRec.Assign(Value: TPersistent);
begin
  if Value is TVCPhoneRec then
  begin
    FAttributes := (Value as TVCPhoneRec).Attributes;
    FNumber := (Value as TVCPhoneRec).Number;
  end
  else inherited Assign(Value);
end;

procedure TVCPhoneRec.Clear;
begin
  FAttributes := [];
  FNumber := '';
end;

procedure TVCPhoneRec.GetAttributes(Input: TStrings);
var
  A: TVCPhoneType;
begin
  if Input.Count > 0 then
  begin
    for A := vcpPreferred to vcpVideo do
    begin
      if Input.IndexOf(String(PhoneStrings[A])) > -1 then
        Include(FAttributes, A);
    end;
  end;
end;

procedure TVCPhoneRec.LoadFromString(Input: string);
var
  T, V: TStrings;
  S: String;
begin
  Clear;
  V := TStringList.Create;
  T := TStringList.Create;
  Try
    V := Explode(Input, ';');
    if AnsiUpperCase(V.Strings[0]) <> 'TEL' then Exit;
    T := Explode(V.Strings[1], ':');
    V.Strings[1] := T.Strings[1];
    S := T.Strings[0];
    if AnsiUpperCase(Copy(S, 1, 5)) = 'TYPE=' then
      Delete(S, 1, 5);
    T := Explode(S, ',');
    GetAttributes(T);
    if V.Count > 1 then FNumber := UnEscapeStr(V.Strings[1]);
  Finally
    T.Free;
    V.Free;
  End;
end;

Function TVCPhoneRec.SaveToString: string;
var
  S: String;
  A: TVCPhoneType;
begin
  Result := '';
  if FNumber = '' then Exit;
  S := 'TEL;TYPE=';
  for A := vcpPreferred to vcpVideo do
    if (A in FAttributes) then S := S + String(PhoneStrings[A]) + ',';
  S[Length(S)] := ':';
  S := S + EscapeStr(FNumber);
  Result := S;
end;

{ TVCEmailRec }

procedure TVCEmailRec.Assign(Value: TPersistent);
begin
  if Value is TVCEmailRec then
  begin
    FAttribute := (Value as TVCEmailRec).EmailType;
    FAddress := (Value as TVCEmailRec).Address;
  end
  else
    inherited Assign(Value);
end;

procedure TVCEmailRec.Clear;
begin
  FAttribute := vceDefault;
  FAddress := '';
end;

procedure TVCEmailRec.LoadFromString(Input: string);
var
  T, V: TStrings;
  A: TVCEmailType;
  S: String;
begin
  Clear;
  T := TStringList.Create;
  V := TStringList.Create;
  try
    V := Explode(Input, ';');
    if AnsiUpperCase(V.Strings[0]) <> 'EMAIL' then Exit;
    T := Explode(V.Strings[1], ':');
    V.Strings[1] := T.Strings[1];
    S := T.Strings[0];
    if AnsiUpperCase(Copy(S, 1, 5)) = 'TYPE=' then
      Delete(S, 1, 5);
    T := Explode(S, ',');
    FAttribute := vceDefault;
    for A := vceAOL to vceMessenger do
      if T.IndexOf(String(EmailStrings[A])) > -1 then
        FAttribute := A;
    if V.Count > 1 then FAddress := UnEscapeStr(V.Strings[1]);
  finally
    T.Free;
    V.Free;
  end;
end;

Function TVCEmailRec.SaveToString: String;
var
  S: String;
begin
  Result := '';
  if FAddress = '' then Exit;
  S := 'EMAIL;';
  if FAttribute = vceDefault then
    S := S + ':'
  else
    S := S + 'TYPE=' + String(EmailStrings[FAttribute]) + ':';
  S := S + EscapeStr(FAddress);
  Result := S;
end;

{ TVCCompanyRec }

procedure TVCCompanyRec.Assign(Value: TPersistent);
begin
  if Value is TVCCompanyRec then
  begin
    FCName := (Value as TVCCompanyRec).CompanyName;
    FUnit := (Value as TVCCompanyRec).UnitName;
    FSubUnit1 := (Value as TVCCompanyRec).SubUnit1;
    FSubUnit2 := (Value as TVCCompanyRec).SubUnit2;
    FSubUnit3 := (Value as TVCCompanyRec).SubUnit3;
    FSubUnit4 := (Value as TVCCompanyRec).SubUnit4;
    FTitle := (Value as TVCCompanyRec).Title;
    FRole := (Value as TVCCompanyRec).Role;
  end
  else Inherited Assign(Value);
end;

procedure TVCCompanyRec.Clear;
begin
  FCname := '';
  Funit := '';
  FSubUnit1 := '';
  FSubUnit2 := '';
  FSubUnit3 := '';
  FSubUnit4 := '';
  FTitle := '';
  FRole := '';
end;

Procedure TVCCompanyRec.ParseCompany(Input: String);
var
  I, V: TStrings;
begin
  FCname := '';
  Funit := '';
  FSubUnit1 := '';
  FSubUnit2 := '';
  FSubUnit3 := '';
  FSubUnit4 := '';
  I := TStringList.Create;
  V := TStringList.Create;
  Try
    I := Explode(Input, ':');
    if I.Strings[0] <> 'ORG' then Exit;
    V := Explode(I.Strings[1], ';');
    if V.Count > 0 then FCName := UnEscapeStr(V.Strings[0]);
    if V.Count > 1 then FUnit := UnEscapeStr(V.Strings[1]);
    if V.Count > 2 then FSubUnit1 := UnEscapeStr(V.Strings[2]);
    if V.Count > 3 then FSubUnit2 := UnEscapeStr(V.Strings[3]);
    if V.Count > 4 then FSubUnit3 := UnEscapeStr(V.Strings[4]);
    if V.Count > 5 then FSubUnit4 := UnEscapeStr(V.Strings[5]);
  Finally
    I.Free;
    V.Free;
  End;
end;

procedure TVCCompanyRec.SaveToStringList(Output: TStrings);
var
  S: String;
begin
  if FCName = '' then Exit;
  S := 'ORG:';
  if FCName <> '' then S := S + EscapeStr(FCname);
  if FUnit <> '' then S := S + ';' + EscapeStr(FUnit) else S := S + ';NONE';
  if FSubUnit1 <> '' then S := S + ';' + EscapeStr(FSubUnit1);
  if FSubUnit2 <> '' then S := S + ';' + EscapeStr(FSubUnit2);
  if FSubUnit3 <> '' then S := S + ';' + EscapeStr(FSubUnit3);
  if FSubUnit4 <> '' then S := S + ';' + EscapeStr(FSubUnit4);
  Output.Add(S);
  if FTitle <> '' then
  begin
    S := 'TITLE:' + EscapeStr(FTitle);
    OutPut.Add(S);
  end;
  if FRole <> '' then
  begin
    S := 'ROLE:' + EscapeStr(FRole);
    Output.Add(S);
  end;
end;

procedure TVCCompanyRec.LoadFromStringList(Input: TStrings);
var
  S: String;
  A: Integer;
begin
  for A := 0 to Input.Count - 1 do
  begin
    S := Input.Strings[A];
    if AnsiLeftStr(S, 4) = 'ORG:' then ParseCompany(S);
    if AnsiLeftStr(S, 6) = 'TITLE:' then
      FTitle := UnEscapeStr(Copy(S, 7, Length(S)));
    if AnsiLeftStr(S, 5) = 'ROLE:' then
      FTitle := UnEscapeStr(Copy(S, 6, Length(S)));
  end;
end;

{ TVCGeoLoc }

procedure TVCGeoLoc.Assign(Value: TPersistent);
begin
  if Value is TVCGeoLoc then
  begin
    FLatitude := (Value as TVCGeoLoc).Latitude;
    FLongitude := (Value as TVCGeoLoc).Longitude;
  end
  else inherited Assign(Value);
end;

procedure TVCGeoLoc.Clear;
begin
  fLatitude := 0;
  FLongitude := 0;
end;

procedure TVCGeoLoc.LoadFromString(Input: string);
var
  T, V: TStrings;
begin
  Clear;
  T := TStringList.Create;
  V := TStringList.Create;
  try
    T := Explode(Input, ':');
    if T.Strings[0] <> 'GEO' then Exit;
    V := Explode(T.Strings[1], ';');
    if V.Count > 1 then
    begin
      try
        FLatitude := StrToFloat(V.Strings[2]);
        FLongitude := StrToFloat(V.Strings[1]);
      Except
      end;
    end;
  Finally
    T.Free;
    V.Free;
  end;
end;

Function TVCGeoLoc.SaveToString: String;
var
  S: String;
begin
  Result := '';
  if (FLatitude = 0) OR (FLongitude = 0) then Exit;
  S := 'GEO:' + FloatToStrF(FLatitude, ffFixed, 10, 6) + ';' +
       FloatToStrF(FLongitude, ffFixed, 10, 6);
  Result := S;
end;

{TVCIdentInfo}

constructor TVCIDentInfo.Create;
begin
  inherited Create;
  FName := TVCNameRec.Create;
  FCompany := TVCCompanyRec.Create;
end;

destructor TVCIdentInfo.Destroy;
begin
  Fname.Free;
  FCompany.Free;
  inherited Destroy;
end;

procedure TVCIdentInfo.SetName(Value: TVCNameRec);
begin
  FName.Assign(Value);
end;

procedure TVCIdentInfo.SetCompany(Value: TVCCompanyRec);
begin
  FCompany.Assign(Value);
end;

procedure TVCIdentInfo.Assign(Value: TPersistent);
begin
  if Value is TVCIdentInfo then
  begin
    SetName((Value as TVCIdentInfo).Name);
    FFormattedName := (Value as TVCIdentInfo).FormattedName;
    FSortString := (Value as TVCIdentInfo).SortString;
    SetCompany((Value as TVCIdentInfo).Company);
  end
  else inherited Assign(Value);
end;

procedure TVCIdentInfo.Clear;
begin
  FName.Clear;
  FFormattedName := '';
  FSortString := '';
end;

function TVCIdentInfo.SaveToStringList(Output: TStrings): Boolean;
var
  S: String;
begin
  Result := False;
  if (FFormattedName = '') OR (FName.SaveToString = '') then Exit;
  Output.Add(FName.SaveToString);
  S := 'FN:' + EscapeStr(FFormattedName);
  Output.Add(S);
  S := 'SORT-STRING:' + EscapeStr(FSortString);
  OutPut.Add(S);
  Result := True;
end;

procedure TVCIdentInfo.LoadFromStringList(Input: TStrings);
var
  A: Integer;
  I: String;
begin
  Clear;
  for A := 0 to Input.Count - 1 do
  begin
    I := Input.Strings[A];
    if AnsiLeftStr(I, 2) = 'N:' then
      FName.LoadFromString(I);
    if AnsiLeftStr(I, 3) = 'FN:' then
      FFormattedName := UnEscapeStr(Copy(I, 4, Length(I)));
    if AnsiLeftStr(I, 12) = 'SORT-STRING:' then
      FSortString := UnEscapeStr(Copy(I, 13, Length(I)));
  end;
end;

{ TVCAddressInfo }

constructor TVCAddressInfo.Create;
begin
  inherited Create;
  FAddress1 := TVCAddressRec.Create;
  FAddress2 := TVCAddressRec.Create;
  FAddress3 := TVCAddressRec.Create;
  FAddress4 := TVCAddressRec.Create;
end;

destructor TVCAddressInfo.Destroy;
begin
  FAddress1.Free;
  FAddress2.Free;
  FAddress3.Free;
  FAddress4.Free;
  inherited Destroy;
end;

procedure TVCAddressInfo.SetAddress1(A: TVCAddressRec);
begin
  FAddress1.Assign(A);
end;

procedure TVCAddressInfo.SetAddress2(A: TVCAddressRec);
begin
  FAddress2.Assign(A);
end;

procedure TVCAddressInfo.SetAddress3(A: TVCAddressRec);
begin
  FAddress3.Assign(A);
end;

procedure TVCAddressInfo.SetAddress4(A: TVCAddressRec);
begin
  FAddress4.Assign(A);
end;

procedure TVCAddressInfo.Assign(Value: TPersistent);
begin
  if Value is TVCAddressInfo then
  begin
    SetAddress1((Value as TVCAddressInfo).Address1);
    SetAddress2((Value as TVCAddressInfo).Address2);
    SetAddress3((Value as TVCAddressInfo).Address3);
    SetAddress4((Value as TVCAddressInfo).Address4);
  end
  else inherited Assign(Value);
end;

procedure TVCAddressinfo.Clear;
begin
  FAddress1.Clear;
  FAddress2.Clear;
  FAddress3.Clear;
  FAddress4.Clear;
end;

procedure TVCAddressInfo.SaveToStringList(Output: TStrings);
var
  S: String;
begin
  S := FAddress1.SaveToString;
  if S <> '' then Output.Add(S);
  S := FAddress2.SaveToString;
  if S <> '' then Output.Add(S);
  S := FAddress3.SaveToString;
  if S <> '' then Output.Add(S);
  S := FAddress4.SaveToString;
  if S <> '' then Output.Add(S);
end;

procedure TVCAddressInfo.LoadFromStringList(Input: TStrings);
var
  A, B: Integer;
  I: String;
begin
  Clear;
  B := 1;
  for A := 0 to Input.Count - 1 do
  begin
    I := Input.Strings[A];
    if AnsiLeftStr(I, 4) = 'ADR:' then
    begin
      case B of
        1: FAddress1.LoadFromString(I);
        2: FAddress2.LoadFromString(I);
        3: FAddress3.LoadFromString(I);
        4: FAddress4.LoadFromString(I);
      end;
      Inc(B, 1);
    end;
    if B > 4 then Break;
  end;
end;

{ TVCPhoneNumbers }

constructor TVCPhoneNumbers.Create;
begin
  inherited Create;
  FPhone1 := TVCPhoneRec.Create;
  FPhone2 := TVCPhoneRec.Create;
  FPhone3 := TVCPhoneRec.Create;
  FPhone4 := TVCPhoneRec.Create;
  FPhone5 := TVCPhoneRec.Create;
  FPhone6 := TVCPhoneRec.Create;
  FPhone7 := TVCPhoneRec.Create;
  FPhone8 := TVCPhoneRec.Create;
end;

destructor TVCPhoneNumbers.Destroy;
begin
  FPhone8.Free;
  FPhone7.Free;
  FPhone6.Free;
  FPhone5.Free;
  FPhone4.Free;
  FPhone3.Free;
  FPhone2.Free;
  FPhone1.Free;
  inherited Destroy
end;

procedure TVCPhoneNumbers.SetPhone1(Value: TVCPhoneRec);
begin
  FPhone1.Assign(Value);
end;

procedure TVCPhoneNumbers.SetPhone2(Value: TVCPhoneRec);
begin
  FPhone2.Assign(Value);
end;

procedure TVCPhoneNumbers.SetPhone3(Value: TVCPhoneRec);
begin
  FPhone3.Assign(Value);
end;

procedure TVCPhoneNumbers.SetPhone4(Value: TVCPhoneRec);
begin
  FPhone4.Assign(Value);
end;

procedure TVCPhoneNumbers.SetPhone5(Value: TVCPhoneRec);
begin
  FPhone5.Assign(Value);
end;

procedure TVCPhoneNumbers.SetPhone6(Value: TVCPhoneRec);
begin
  FPhone6.Assign(Value);
end;

procedure TVCPhoneNumbers.SetPhone7(Value: TVCPhoneRec);
begin
  FPhone7.Assign(Value);
end;

procedure TVCPhoneNumbers.SetPhone8(Value: TVCPhoneRec);
begin
  FPhone8.Assign(Value);
end;

procedure TVCPhoneNumbers.Assign(Value: TPersistent);
begin
  if Value is TVCPhoneNumbers then
  begin
    SetPhone1((Value as TVCPhoneNumbers).Phone1);
    SetPhone2((Value as TVCPhoneNumbers).Phone2);
    SetPhone3((Value as TVCPhoneNumbers).Phone3);
    SetPhone4((Value as TVCPhoneNumbers).Phone4);
    SetPhone5((Value as TVCPhoneNumbers).Phone5);
    SetPhone6((Value as TVCPhoneNumbers).Phone6);
    SetPhone7((Value as TVCPhoneNumbers).Phone7);
    SetPhone8((Value as TVCPhoneNumbers).Phone8);
  end
  else inherited Assign(Value);
end;

procedure TVCPhoneNumbers.Clear;
begin
  FPhone1.Clear;
  FPhone2.Clear;
  FPhone3.Clear;
  FPhone4.Clear;
  FPhone5.Clear;
  FPhone6.Clear;
  FPhone7.Clear;
  FPhone8.Clear;
end;

procedure TVCPhoneNumbers.SaveToStringList(Output: TStrings);
var
  S: String;
begin
  S := FPhone1.SaveToString;
  if S <> '' then Output.Add(S);
  S := FPhone2.SaveToString;
  if S <> '' then Output.Add(S);
  S := FPhone3.SaveToString;
  if S <> '' then Output.Add(S);
  S := FPhone4.SaveToString;
  if S <> '' then Output.Add(S);
  S := FPhone5.SaveToString;
  if S <> '' then Output.Add(S);
  S := FPhone6.SaveToString;
  if S <> '' then Output.Add(S);
  S := FPhone7.SaveToString;
  if S <> '' then Output.Add(S);
  S := FPhone8.SaveToString;
  if S <> '' then Output.Add(S);
end;

procedure TVCPhoneNumbers.LoadFromStringList(Input: TStrings);
var
  A, B: Integer;
  I: String;
begin
  Clear;
  B := 1;
  for A := 0 to Input.Count - 1 do
  begin
    I := Input.Strings[A];
    if AnsiLeftStr(I, 4) = 'TEL:' then
    begin
      case B of
        1: FPhone1.LoadFromString(I);
        2: FPhone2.LoadFromString(I);
        3: FPhone3.LoadFromString(I);
        4: FPhone4.LoadFromString(I);
        5: FPhone5.LoadFromString(I);
        6: FPhone6.LoadFromString(I);
        7: FPhone7.LoadFromString(I);
        8: FPhone8.LoadFromString(I);
      end;
      Inc(B, 1);
    end;
    if B > 8 then Break;
  end;
end;

{ TVCEmailAddresses }

constructor TVCEmailAddresses.Create;
begin
  inherited Create;
  FEmail1 := TVCEmailRec.Create;
  FEmail2 := TVCEmailRec.Create;
  FEmail3 := TVCEmailRec.Create;
  FEmail4 := TVCEmailRec.Create;
  FEmail5 := TVCEmailRec.Create;
  FEmail6 := TVCEmailRec.Create;
  FEmail7 := TVCEmailRec.Create;
  FEmail8 := TVCEmailRec.Create;
end;

Destructor TVCEmailAddresses.Destroy;
begin
  FEmail1.Free;
  FEmail2.Free;
  FEmail3.Free;
  FEmail4.Free;
  FEmail5.Free;
  FEmail6.Free;
  FEmail7.Free;
  FEmail8.Free;
  inherited Destroy;
end;

procedure TVCEmailAddresses.SetEmail1(Value: TVCEmailRec);
begin
  FEmail1.Assign(Value);
end;

procedure TVCEmailAddresses.SetEmail2(Value: TVCEmailRec);
begin
  FEmail2.Assign(Value);
end;

procedure TVCEmailAddresses.SetEmail3(Value: TVCEmailRec);
begin
  FEmail3.Assign(Value);
end;

procedure TVCEmailAddresses.SetEmail4(Value: TVCEmailRec);
begin
  FEmail4.Assign(Value);
end;

procedure TVCEmailAddresses.SetEmail5(Value: TVCEmailRec);
begin
  FEmail5.Assign(Value);
end;

procedure TVCEmailAddresses.SetEmail6(Value: TVCEmailRec);
begin
  FEmail6.Assign(Value);
end;

procedure TVCEmailAddresses.SetEmail7(Value: TVCEmailRec);
begin
  FEmail7.Assign(Value);
end;

procedure TVCEmailAddresses.SetEmail8(Value: TVCEmailRec);
begin
  FEmail8.Assign(Value);
end;

procedure TVCEmailAddresses.Assign(Value: TPersistent);
begin
  if Value is TVCEmailAddresses then
  begin
    SetEmail1((Value as TVCEmailAddresses).EmailAddress1);
    SetEmail2((Value as TVCEmailAddresses).EmailAddress2);
    SetEmail3((Value as TVCEmailAddresses).EmailAddress3);
    SetEmail4((Value as TVCEmailAddresses).EmailAddress4);
    SetEmail5((Value as TVCEmailAddresses).EmailAddress5);
    SetEmail6((Value as TVCEmailAddresses).EmailAddress6);
    SetEmail7((Value as TVCEmailAddresses).EmailAddress7);
    SetEmail8((Value as TVCEmailAddresses).EmailAddress8);
  end
  else inherited Assign(Value);
end;

procedure TVCEmailAddresses.Clear;
begin
  FEmail1.Clear;
  FEmail2.Clear;
  FEmail3.Clear;
  FEmail4.Clear;
  FEmail5.Clear;
  FEmail6.Clear;
  FEmail7.Clear;
  FEmail8.Clear;
end;

procedure TVCEmailAddresses.LoadFromStringList(Input: TStrings);
var
  A, B: Integer;
  I: String;
begin
  Clear;
  B := 1;
  for A := 0 to Input.Count - 1 do
  begin
    I := Input[A];
    if AnsiLeftStr(I, 6) = 'EMAIL:' then
    begin
      case B of
        1: FEmail1.LoadFromString(I);
        2: FEmail2.LoadFromString(I);
        3: FEmail3.LoadFromString(I);
        4: FEmail4.LoadFromString(I);
        5: FEmail5.LoadFromString(I);
        6: FEmail6.LoadFromString(I);
        7: FEmail7.LoadFromString(I);
        8: FEmail8.LoadFromString(I);
      end;
      Inc(B, 1);
    end;
    if B > 8 then Break;
  end;
end;

procedure TVCEmailAddresses.SaveToStringList(OutPut: TStrings);
var
  S: String;
begin
  S := FEmail1.SaveToString;
  if S <> '' then Output.Add(S);
  S := FEmail2.SaveToString;
  if S <> '' then Output.Add(S);
  S := FEmail3.SaveToString;
  if S <> '' then Output.Add(S);
  S := FEmail4.SaveToString;
  if S <> '' then Output.Add(S);
  S := FEmail5.SaveToString;
  if S <> '' then Output.Add(S);
  S := FEmail6.SaveToString;
  if S <> '' then Output.Add(S);
  S := FEmail7.SaveToString;
  if S <> '' then Output.Add(S);
  S := FEmail8.SaveToString;
  if S <> '' then Output.Add(S);
end;

{ TVCAdditionalInfo }

constructor TVCAdditionalInfo.Create;
begin
  inherited Create;
  FComment := TStringList.Create;
end;

Destructor TVCAdditionalInfo.Destroy;
begin
  FComment.Free;
  inherited Destroy;
end;

procedure TVCAdditionalInfo.Assign(Value: TPersistent);
begin
  if Value is TVCAdditionalInfo then
  begin
    FComment := (Value as TVCAdditionalInfo).Comment;
    FURL1 := (Value as TVCAdditionalInfo).URL1;
    FURL2 := (Value as TVCAdditionalInfo).URL2;
  end
  else inherited Assign(Value);
end;

procedure TVCAdditionalInfo.Clear;
begin
  FComment.Clear;
  FURL1 := '';
  FURL2 := '';
end;

procedure TVCAdditionalInfo.SaveToStringList(Output: TStrings);
var
  S: String;
begin
  if FComment.Text <> '' then
  begin
    S := EscapeStr(FComment.Text);
    AnsiReplaceText(S, '#13#10', '\N');
    Output.Add('NOTE:' + S);
  end;
  if FURL1 <> '' then
    Output.Add('URL:' + EscapeStr(FURL1));
  if FURL2 <> '' then
    Output.Add('URL:' + EscapeStr(FURL2));
end;

procedure TVCAdditionalInfo.LoadFromStringList(Input: TStrings);
var
  I, P: Integer;
  S, V: String;
begin
  Clear;
  P := 1;
  for I := 0 to Input.Count - 1 do
  begin
    S := Input[I];
    if AnsiLeftStr(S, 5) = 'NOTE:' then
    begin
      V := UnEscapeStr(AnsiReplaceText(Copy(S, 6, Length(S)), '/N', #13#10));
      FComment.Text := V;
    end;
    S := Input[I];
    if AnsiLeftStr(S, 4) = 'URL:' then
    begin
      V := UnEscapeStr(Copy(S, 5, Length(S)));
      case P of
        1: FURL1 := V;
        2: FURL2 := V;
      end;
      inc(P, 1);
    end;
  end;
end;

end.

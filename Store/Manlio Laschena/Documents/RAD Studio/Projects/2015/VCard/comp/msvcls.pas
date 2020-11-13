unit Msvcls;

interface

uses Classes, SysUtils;

type
  TmsAddressType = (msaDomestic, msaInternational, msaPostal, msaParcel,
                    msaHome, msaWork);
  TmsAddressAttributes = set of TmsAddressType;
  TmsPhoneType = (mstPreferred, mstWork, mstHome, mstVoice, mstFax,
                  mstMessaging, mstCellular, mstPager, mstBBS, mstModem,
                  mstCar, mstISDN, mstVideo);
  TmsPhoneAttributes = set of TmsPhoneType;
  TmsEmailType = (mseDefault, mseAOL, mseAppleLink, mseATTMail, mseCompuserve,
                  mseeWorld, mseInternet, mseIBM, mseMCI, msePowerShare,
                  mseProdigy, mseTelex, mseX400);

const
  AddressStrings : array[TmsAddressType] of string[6] =
                  ('DOM','INTL','POSTAL','PARCEL','HOME','WORK');
  PhoneStrings : array[TmsPhoneType] of string[5] =
                  ('PREF','WORK','HOME','VOICE','FAX','MSG','CELL',
                   'PAGER','BBS','MODEM','CAR','ISDN','VIDEO');
  EmailStrings : array[TmsEmailType] of string[10] =
                  ('','AOL','APPLELINK','ATTMAIL','CIS','EWORLD','INTERNET',
                   'IBMMAIL','MCIMAIL','POWERSHARE','PRODIGY','TLX','X400');

type

  TmsNameRec = class(TPersistent)
  private
    FFamilyName : string;
    FGivenName : string;
    FAdditionalNames : string;
    FPrefix : string;
    FSuffix : string;
  public
    procedure Assign(Value : TPersistent); override;
    procedure Clear;
    procedure SaveToStrings(Strings : TStrings);
    procedure LoadFromStrings(Strings : TStrings);
  published
    property FamilyName : string read FFamilyName write FFamilyName;
    property GivenName : string read FGivenName write FGivenName;
    property AdditionalNames : string read FAdditionalNames write FAdditionalNames;
    property Prefix : string read FPrefix write FPrefix;
    property Suffix : string read FSuffix write FSuffix;
  end;

  TmsIdentification = class(TPersistent)
  private
    FName : TmsNameRec;
    FFormattedName : string;
    procedure SetName(Value : TmsNameRec);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Value : TPersistent); override;
    procedure Clear;
    procedure SaveToStrings(Strings : TStrings);
    procedure LoadFromStrings(Strings : TStrings);
  published
    property Name : TmsNameRec read FName write SetName;
    property FormattedName : string read FFormattedName write FFormattedName;
  end;

  TmsAddressRec = class(TPersistent)
  private
    FAttributes : TmsAddressAttributes;
    FPOAddress : string;
    FExtendedAddress : string;
    FStreet : string;
    FLocality : string;
    FRegion : string;
    FPostalCode : string;
    FCountry : string;
  protected
    procedure FillAttributes(Strings : TStrings);
  public
    procedure Assign(Value : TPersistent); override;
    procedure Clear;
    procedure SaveToStrings(Strings : TStrings);
    procedure LoadFromStrings(Strings : TStrings);
  published
    property Attributes : TmsAddressAttributes read FAttributes write FAttributes;
    property POAddress : string read FPOAddress write FPOAddress;
    property ExtendedAddress : string read FExtendedAddress write FExtendedAddress;
    property Street : string read FStreet write FStreet;
    property Locality : string read FLocality write FLocality;
    property Region : string read FRegion write FRegion;
    property PostalCode : string read FPostalCode write FPostalCode;
    property Country : string read FCountry write FCountry;
  end;

  TmsDeliveryInfo = class(TPersistent)
  private
    FAddress1 : TmsAddressRec;
    FAddress2 : TmsAddressRec;
    procedure SetAddress1(Value : TmsAddressRec);
    procedure SetAddress2(Value : TmsAddressRec);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Value : TPersistent); override;
    procedure Clear;
    procedure SaveToStrings(Strings : TStrings);
    procedure LoadFromStrings(Strings : TStrings);
  published
    property Address1 : TmsAddressRec read FAddress1 write SetAddress1;
    property Address2 : TmsAddressRec read FAddress2 write SetAddress2;
  end;

  TmsPhoneRec = class(TPersistent)
  private
    FAttributes : TmsPhoneAttributes;
    FNumber : string;
  protected
    procedure FillAttributes(Strings : TStrings);
  public
    procedure Assign(Value : TPersistent); override;
    procedure Clear;
    procedure SaveToStrings(Strings : TStrings);
    procedure LoadFromStrings(Strings : TStrings);
  published
    property Attributes : TmsPhoneAttributes read FAttributes write FAttributes;
    property Number : string read FNumber write FNumber;
  end;

  TmsEmailRec = class(TPersistent)
  private
    FEmailType : TmsEmailType;
    FAddress : string;
  protected
    procedure FillEmaiLType(Strings : TStrings);
  public
    procedure Assign(Value : TPersistent); override;
    procedure Clear;
    procedure SaveToStrings(Strings : TStrings);
    procedure LoadFromStrings(Strings : TStrings);
  published
    property EmailType : TmsEmailType read FEmailType write FEmailType;
    property Address : string read FAddress write FAddress;
  end;

  TmsTelecomInfo = class(TPersistent)
  private
    FPhone1 : TmsPhoneRec;
    FPhone2 : TmsPhoneRec;
    FPhone3 : TmsPhoneRec;
    FEmail1 : TmsEmailRec;
    FEmail2 : TmsEmailRec;
    procedure SetPhone1(Value : TmsPhoneRec);
    procedure SetPhone2(Value : TmsPhoneRec);
    procedure SetPhone3(Value : TmsPhoneRec);
    procedure SetEmail1(Value : TmsEmailRec);
    procedure SetEmail2(Value : TmsEmailRec);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Value : TPersistent); override;
    procedure Clear;
    procedure SaveToStrings(Strings : TStrings);
    procedure LoadFromStrings(Strings : TStrings);
  published
    property Phone1 : TmsPhoneRec read FPhone1 write SetPhone1;
    property Phone2 : TmsPhoneRec read FPhone2 write SetPhone2;
    property Phone3 : TmsPhoneRec read FPhone3 write SetPhone3;
    property Email1 : TmsEmailRec read FEmail1 write SetEmail1;
    property Email2 : TmsEmailRec read FEmail2 write SetEmail2;
  end;

  TmsCompanyRec = class(TPersistent)
  private
    FName : string;
    FAUnit : string;
  public
    procedure Assign(Value : TPersistent); override;
    procedure Clear;
    procedure SaveToStrings(Strings : TStrings);
    procedure LoadFromStrings(Strings : TStrings);
  published
    property Name : string read FName write FName;
    property AUnit : string read FAUnit write FAUnit;
  end;

  TmsBusinessInfo = class(TPersistent)
  private
    FTitle : string;
    FRole : string;
    FCompany : TmsCompanyRec;
    procedure SetCompany(Value : TmsCompanyRec);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Value : TPersistent); override;
    procedure Clear;
    procedure SaveToStrings(Strings : TStrings);
    procedure LoadFromStrings(Strings : TStrings);
  published
    property Title : string read FTitle write FTitle;
    property Role : string read FRole write FRole;
    property Company : TmsCompanyRec read FCompany write SetCompany;
  end;

  TmsExplanatoryInfo = class(TPersistent)
  private
    FComment : TStrings;
    FURL1 : string;
    FURL2 : string;
    procedure SetComment(Value : TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Value : TPersistent); override;
    procedure Clear;
    procedure SaveToStrings(Strings : TStrings);
    procedure LoadFromStrings(Strings : TStrings);
  published
    property Comment : TStrings read FComment write SetComment;
    property URL1 : string read FURL1 write FURL1;
    property URL2 : string read FURL2 write FURL2;
  end;

implementation

type
  TmsPropertyParser = class
  private
    FLines : TStrings;
    FNames : TStrings;
    FValues : TStrings;
    FPropertyName : string;
  protected
    Buf : PChar;
    function IndexOfName : Integer;
    procedure PropertyToBuffer;
    procedure FillNamesAndValues;
    procedure Buf2Strings(Buf : PChar; Strings : TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Process;
    property Lines : TStrings read FLines write FLines;
    property Names : TStrings read FNames;
    property Values : TStrings read FValues;
    property PropertyName : string read FPropertyName write FPropertyName;
  end;

constructor TmsPropertyParser.Create;
begin
  inherited Create;
  FNames:=TStringList.Create;
  FValues:=TStringList.Create;
  Buf:=StrAlloc($2000);
end;

destructor TmsPropertyParser.Destroy;
begin
  StrDispose(Buf);
  FValues.Free;
  FNames.Free;
  inherited Destroy;
end;

function TmsPropertyParser.IndexOfName : Integer;
var
  i : Integer;
  Found : boolean;
  s, Name : string;
begin
  Result:=-1;
  if FLines.Count=0 then Exit;
  Name:=UpperCase(FPropertyName);
  if Name[Length(Name)]=':' then
    Delete(Name,Length(Name),1);
  i:=0;
  repeat
    s:=UpperCase(Lines[i]);
    Found:=(Length(s)>Length(Name)) and (Copy(s,1,Length(Name))=Name) and
      (s[Length(Name)+1] in [':',';']);
    Inc(i);
  until Found or (i=Lines.Count);
  if Found then
    Result:=i-1;
end;

procedure TmsPropertyParser.PropertyToBuffer;
var
  i : Integer;
  s : string;
begin
  FillChar(Buf^,StrBufSize(Buf),0);
  i:=IndexOfName;
  if i>-1 then
  begin
    repeat
{$IFDEF WIN32}
      s:=Trim(FLines[i]);
{$ENDIF}
      if s<>'' then
      begin
        if StrLen(Buf)<>0 then
          s:=Concat(' ',s);
        s:=Concat(s,#00);
        StrCat(Buf,@s[1]);
      end;
      FLines.Delete(i);
    until (i=FLines.Count) or
      ((Copy(FLines[i],1,1)<>' ') and (Copy(FLines[i],1,1)<>^I));
  end;
end;

procedure TmsPropertyParser.Buf2Strings(Buf : PChar; Strings : TStrings);
var
  p, TempBuf : PChar;
begin
  Strings.Clear;
  TempBuf:=StrAlloc($1000);
  try
    repeat
      p:=StrPos(Buf,';');
      if p<>nil then
      begin
        StrLCopy(TempBuf,Buf,p-Buf);
        Strings.Add(StrPas(TempBuf));
        Buf:=p+1;
      end
      else
        Strings.Add(StrPas(Buf));
    until p=nil;
  finally
    StrDispose(TempBuf);
  end;
end;

procedure TmsPropertyParser.FillNamesAndValues;
var
  NamesStr, ValuesStr, p : PChar;
begin
  if StrLen(Buf)>0 then
  begin
    ValuesStr:=StrAlloc($1000);
    try
      NamesStr:=StrAlloc($1000);
      try
        p:=StrPos(Buf,':');
        if p<>nil then
        begin
          StrLCopy(NamesStr,Buf,p-Buf);
          StrCopy(ValuesStr,p+1);
          Buf2Strings(NamesStr,Names);
          Buf2Strings(ValuesStr,Values);
        end;
      finally
        StrDispose(NamesStr);
      end;
    finally
      StrDispose(ValuesStr);
    end;
  end;
end;

procedure TmsPropertyParser.Process;
begin
  PropertyToBuffer;
  FillNamesAndValues;
end;

{TmsNameRec}
procedure TmsNameRec.Assign(Value : TPersistent);
begin
  if Value is TmsNameRec then
  begin
    FFamilyName:=(Value as TmsNameRec).FamilyName;
    FGivenName:=(Value as TmsNameRec).GivenName;
    FAdditionalNames:=(Value as TmsNameRec).AdditionalNames;
    FPrefix:=(Value as TmsNameRec).Prefix;
    FSuffix:=(Value as TmsNameRec).Suffix;
  end
  else
    inherited Assign(Value);
end;

procedure TmsNameRec.Clear;
begin
  FFamilyName:='';
  FGivenName:='';
  FAdditionalNames:='';
  FPrefix:='';
  FSuffix:='';
end;

procedure TmsNameRec.SaveToStrings(Strings : TStrings);
var
  s : string;
begin
  if Concat(FFamilyName,FGivenName,FAdditionalNames,FPrefix,FSuffix)<>'' then
  begin
    s:='N:';
    s:=Concat(s,FamilyName,';');
    s:=Concat(s,FGivenName,';');
    s:=Concat(s,FAdditionalNames,';');
    s:=Concat(s,FPrefix,';');
    s:=Concat(s,FSuffix);
    Strings.Add(s);
  end;
end;

procedure TmsNameRec.LoadFromStrings(Strings : TStrings);
begin
  Clear;
  with TmsPropertyParser.Create do
  try
    Lines:=Strings;
    PropertyName:='N';
    Process;
    if Values.Count>4 then
      FSuffix:=Values[4];
    if Values.Count>3 then
      FPrefix:=Values[3];
    if Values.Count>2 then
      FAdditionalNames:=Values[2];
    if Values.Count>1 then
      FGivenName:=Values[1];
    if Values.Count>0 then
      FFamilyName:=Values[0];
  finally
    Free;
  end;
end;

{TmsIdentification}
constructor TmsIdentification.Create;
begin
  inherited Create;
  FName:=TmsNameRec.Create;
end;

destructor TmsIdentification.Destroy;
begin
  FName.Free;
  inherited Destroy;
end;

procedure TmsIdentification.SetName(Value : TmsNameRec);
begin
  FName.Assign(Value);
end;

procedure TmsIdentification.Assign(Value : TPersistent);
begin
  if Value is TmsIdentification then
  begin
    FName.Assign((Value as TmsIdentification).Name);
    FFormattedName:=(Value as TmsIdentification).FormattedName;
  end
  else inherited Assign(Value);
end;

procedure TmsIdentification.Clear;
begin
  FName.Clear;
  FFormattedName:='';
end;

procedure TmsIdentification.SaveToStrings(Strings : TStrings);
begin
  if FFormattedName<>'' then
    Strings.Add(Concat('FN:',FFormattedName));
  FName.SaveToStrings(Strings);
end;

procedure TmsIdentification.LoadFromStrings(Strings : TStrings);
begin
  Clear;
  FName.LoadFromStrings(Strings);
  with TmsPropertyParser.Create do
  try
    Lines:=Strings;
    PropertyName:='FN';
    Process;
    if Values.Count>0 then
      FFormattedName:=Values[0];
  finally
    Free;
  end;
end;

{TmsAddressRec}
procedure TmsAddressRec.Assign(Value : TPersistent);
begin
  if Value is TmsAddressRec then
  begin
    FAttributes:=(Value as TmsAddressRec).Attributes;
    FPOAddress:=(Value as TmsAddressRec).POAddress;
    FExtendedAddress:=(Value as TmsAddressRec).ExtendedAddress;
    FStreet:=(Value as TmsAddressRec).Street;
    FLocality:=(Value as TmsAddressRec).Locality;
    FRegion:=(Value as TmsAddressRec).Region;
    FPostalCode:=(Value as TmsAddressRec).PostalCode;
    FCountry:=(Value as TmsAddressRec).Country;
  end
  else
    inherited Assign(Value);
end;

procedure TmsAddressRec.Clear;
begin
  FAttributes:=[];
  FPOAddress:='';
  FExtendedAddress:='';
  FStreet:='';
  FLocality:='';
  FRegion:='';
  FPostalCode:='';
  FCountry:='';
end;

procedure TmsAddressRec.SaveToStrings(Strings : TStrings);
var
  s : string;
  i : TmsAddressType;
begin
  if Concat(FPOAddress,FExtendedAddress,FStreet,FLocality,FRegion,FPostalCode,
            FCountry)<>'' then
  begin
    s:='ADR';
    for i:=msaDomestic to msaWork do
    if i in Attributes then
      s:=Concat(s,';',AddressStrings[i]);
    s:=Concat(s,':');
    s:=Concat(s,FPOAddress,';');
    s:=Concat(s,FExtendedAddress,';');
    s:=Concat(s,FStreet,';');
    s:=Concat(s,FLocality,';');
    s:=Concat(s,FRegion,';');
    s:=Concat(s,FPostalCode,';');
    s:=Concat(s,FCountry);
    Strings.Add(s);
  end;
end;

procedure TmsAddressRec.FillAttributes(Strings : TStrings);
var
  i : TmsAddressType;
begin
  if Strings.Count>0 then
  begin
    for i:=msaDomestic to msaWork do
    begin
      if Strings.IndexOf(AddressStrings[i])>-1 then
        Include(FAttributes,i);
    end;
  end;
end;

procedure TmsAddressRec.LoadFromStrings(Strings : TStrings);
begin
  Clear;
  with TmsPropertyParser.Create do
  try
    Lines:=Strings;
    PropertyName:='ADR';
    Process;
    if Values.Count>6 then
      FCountry:=Values[6];
    if Values.Count>5 then
      FPostalCode:=Values[5];
    if Values.Count>4 then
      FRegion:=Values[4];
    if Values.Count>3 then
      FLocality:=Values[3];
    if Values.Count>2 then
      FStreet:=Values[2];
    if Values.Count>1 then
      FExtendedAddress:=Values[1];
    if Values.Count>0 then
      FPOAddress:=Values[0];
    FillAttributes(Names);
  finally
    Free;
  end;
end;

{TmsDeliveryInfo}
constructor TmsDeliveryInfo.Create;
begin
  inherited Create;
  FAddress1:=TmsAddressRec.Create;
  FAddress2:=TmsAddressRec.Create;
end;

destructor TmsDeliveryInfo.Destroy;
begin
  FAddress2.Free;
  FAddress1.Free;
  inherited Destroy;
end;

procedure TmsDeliveryInfo.SetAddress1(Value : TmsAddressRec);
begin
  FAddress1.Assign(Value);
end;

procedure TmsDeliveryInfo.SetAddress2(Value : TmsAddressRec);
begin
  FAddress2.Assign(Value);
end;

procedure TmsDeliveryInfo.Assign(Value : TPersistent);
begin
  if Value is TmsDeliveryInfo then
  begin
    FAddress1.Assign((Value as TmsDeliveryInfo).Address1);
    FAddress2.Assign((Value as TmsDeliveryInfo).Address2);
  end
  else
    inherited Assign(Value);
end;

procedure TmsDeliveryInfo.Clear;
begin
  FAddress1.Clear;
  FAddress2.Clear;
end;

procedure TmsDeliveryInfo.SaveToStrings(Strings : TStrings);
begin
  FAddress1.SaveToStrings(Strings);
  FAddress2.SaveToStrings(Strings);
end;

procedure TmsDeliveryInfo.LoadFromStrings(Strings : TStrings);
begin
  Clear;
  FAddress1.LoadFromStrings(Strings);
  FAddress2.LoadFromStrings(Strings);
end;

{TmsPhoneRec}
procedure TmsPhoneRec.Assign(Value : TPersistent);
begin
  if Value is TmsPhoneRec then
  begin
    FAttributes:=(Value as TmsPhoneRec).Attributes;
    FNumber:=(Value as TmsPhoneRec).Number;
  end
  else
    inherited Assign(Value);
end;

procedure TmsPhoneRec.Clear;
begin
  FAttributes:=[];
  FNumber:='';
end;

procedure TmsPhoneRec.SaveToStrings(Strings : TStrings);
var
  i : TmsPhoneType;
  s : string;
begin
  if FNumber<>'' then
  begin
    s:='TEL';
    for i:=mstPreferred to mstVideo do
    if i in FAttributes then
      s:=Concat(s,';',PhoneStrings[i]);
    s:=Concat(s,':',FNumber);
    Strings.Add(s);
  end;
end;

procedure TmsPhoneRec.FillAttributes(Strings : TStrings);
var
  i : TmsPhoneType;
begin
  if Strings.Count>0 then
  begin
    for i:=mstPreferred to mstVideo do
    begin
      if Strings.IndexOf(PhoneStrings[i])>-1 then
        Include(FAttributes,i);
    end;
  end;
end;

procedure TmsPhoneRec.LoadFromStrings(Strings : TStrings);
begin
  with TmsPropertyParser.Create do
  try
    Lines:=Strings;
    PropertyName:='TEL';
    Process;
    if Values.Count>0 then
      FNumber:=Values[0];
    FillAttributes(Names);
  finally
    Free;
  end;
end;

{TmsEmailRec}
procedure TmsEmailRec.Assign(Value : TPersistent);
begin
  if Value is TmsEmailRec then
  begin
    FEmailType:=(Value as TmsEmailRec).EmailType;
    FAddress:=(Value as TmsEmailRec).Address;
  end
  else
    inherited Assign(Value);
end;

procedure TmsEmailRec.Clear;
begin
  FEmailType:=mseDefault;
  FAddress:='';
end;

procedure TmsEmailRec.SaveToStrings(Strings : TStrings);
var
  s : string;
begin
  if FAddress<>'' then
  begin
    s:='EMAIL';
    s:=Concat(s,';',EmailStrings[FEmailType],':',FAddress);
    Strings.Add(s);
  end;
end;

procedure TmsEmailRec.FillEmaiLType(Strings : TStrings);
var
  i : TmsEmailType;
begin
  if Strings.Count>0 then
  begin
    for i:=mseDefault to mseX400 do
    begin
      if Strings.IndexOf(EmailStrings[i])>0 then
        FEmailType:=i;
    end;
  end;
end;

procedure TmsEmailRec.LoadFromStrings(Strings : TStrings);
begin
  with TmsPropertyParser.Create do
  try
    Lines:=Strings;
    PropertyName:='EMAIL';
    Process;
    if Values.Count>0 then
      FAddress:=Values[0];
    FillEmailType(Names);
  finally
    Free;
  end;
end;

{TmsTelecomInfo}
constructor TmsTelecomInfo.Create;
begin
  inherited Create;
  FPhone1:=TmsPhoneRec.Create;
  FPhone2:=TmsPhoneRec.Create;
  FPhone3:=TmsPhoneRec.Create;
  FEmail1:=TmsEmailRec.Create;
  FEmail2:=TmsEmailRec.Create;
end;

destructor TmsTelecomInfo.Destroy;
begin
  FEmail2.Free;
  FEmail1.Free;
  FPhone3.Free;
  FPhone2.Free;
  FPhone1.Free;
  inherited Destroy;
end;

procedure TmsTelecomInfo.SetPhone1(Value : TmsPhoneRec);
begin
  FPhone1.Assign(Value);
end;

procedure TmsTelecomInfo.SetPhone2(Value : TmsPhoneRec);
begin
  FPhone2.Assign(Value);
end;

procedure TmsTelecomInfo.SetPhone3(Value : TmsPhoneRec);
begin
  FPhone3.Assign(Value);
end;

procedure TmsTelecomInfo.SetEmail1(Value : TmsEmailRec);
begin
  FEmail1.Assign(Value);
end;

procedure TmsTelecomInfo.SetEmail2(Value : TmsEmailRec);
begin
  FEmail2.Assign(Value);
end;

procedure TmsTelecomInfo.Assign(Value : TPersistent);
begin
  if Value is TmsTelecomInfo then
  begin
    FPhone1.Assign((Value as TmsTelecomInfo).FPhone1);
    FPhone2.Assign((Value as TmsTelecomInfo).FPhone2);
    FPhone3.Assign((Value as TmsTelecomInfo).FPhone3);
    FEmail1.Assign((Value as TmsTelecomInfo).FEmail1);
    FEmail2.Assign((Value as TmsTelecomInfo).FEmail2);
  end
  else
    inherited Assign(Value);
end;

procedure TmsTelecomInfo.Clear;
begin
  FPhone1.Clear;
  FPhone2.Clear;
  FPhone3.Clear;
  FEmail1.Clear;
  Femail2.Clear;
end;

procedure TmsTelecomInfo.SaveToStrings(Strings : TStrings);
begin
  FPhone1.SaveToStrings(Strings);
  FPhone2.SaveToStrings(Strings);
  FPhone3.SaveToStrings(Strings);
  FEmail1.SaveToStrings(Strings);
  FEmail2.SaveToStrings(Strings);
end;

procedure TmsTelecomInfo.LoadFromStrings(Strings : TStrings);
begin
  Clear;
  FPhone1.LoadFromStrings(Strings);
  FPhone2.LoadFromStrings(Strings);
  FPhone3.LoadFromStrings(Strings);
  FEmail1.LoadFromStrings(Strings);
  FEmail2.LoadFromStrings(Strings);
end;

{TmsCompanyRec}
procedure TmsCompanyRec.Assign(Value : TPersistent);
begin
  if Value is TmsCompanyRec then
  begin
    FName:=(Value as TmsCompanyRec).Name;
    FAUnit:=(Value as TmsCompanyRec).AUnit;
  end
  else
    inherited Assign(Value);
end;

procedure TmsCompanyRec.Clear;
begin
  FName:='';
  FAUnit:='';
end;

procedure TmsCompanyRec.SaveToStrings(Strings : TStrings);
var
  s : string;
begin
  if Concat(FName, FAUnit)<>'' then
  begin
    s:=Concat('ORG:',FName,';',FAUnit);
    Strings.Add(s);
  end;
end;

procedure TmsCompanyRec.LoadFromStrings(Strings : TStrings);
begin
  Clear;
  with TmsPropertyParser.Create do
  try
    Lines:=Strings;
    PropertyName:='ORG';
    Process;
    if Values.Count>1 then
      FAUnit:=Values[1];
    if Values.Count>0 then
      FName:=Values[0];
  finally
    Free;
  end;
end;

{TmsBusinessInfo}
constructor TmsBusinessInfo.Create;
begin
  inherited Create;
  FCompany:=TmsCompanyRec.Create;
end;

destructor TmsBusinessInfo.Destroy;
begin
  FCompany.Free;
  inherited Destroy;
end;

procedure TmsBusinessInfo.SetCompany(Value : TmsCompanyRec);
begin
  FCompany.Assign(Value);
end;

procedure TmsBusinessInfo.Assign(Value : TPersistent);
begin
  if Value is TmsBusinessInfo then
  begin
    FTitle:=(Value as TmsBusinessInfo).Title;
    FRole:=(Value as TmsBusinessInfo).Role;
    FCompany.Assign((Value as TmsBusinessInfo).Company);
  end
  else
    inherited Assign(Value);
end;

procedure TmsBusinessInfo.Clear;
begin
  FTitle:='';
  FRole:='';
  FCompany.Clear;
end;

procedure TmsBusinessInfo.SaveToStrings(Strings : TStrings);
begin
  FCompany.SaveToStrings(Strings);
  if FTitle<>'' then
    Strings.Add(Concat('TITLE:',FTitle));
  if FRole<>'' then
    Strings.Add(Concat('ROLE:',FRole));
end;

procedure TmsBusinessInfo.LoadFromStrings(Strings : TStrings);
begin
  Clear;
  FCompany.LoadFromStrings(Strings);
  with TmsPropertyParser.Create do
  try
    Lines:=Strings;
    PropertyName:='TITLE';
    Process;
    if Values.Count<>0 then
      FTitle:=Values[0];
    PropertyName:='ROLE';
    Process;
    if Values.Count<>0 then
      FRole:=Values[0];
  finally
    Free;
  end;
end;

{TmsExplanatoryInfo}
constructor TmsExplanatoryInfo.Create;
begin
  inherited Create;
  FComment:=TStringList.Create;
end;

destructor TmsExplanatoryInfo.Destroy;
begin
  FComment.Free;
  inherited Destroy;
end;

procedure TmsExplanatoryInfo.SetComment(Value : TStrings);
begin
  FComment.Assign(Value);
end;

procedure TmsExplanatoryInfo.Assign(Value : TPersistent);
begin
  if Value is TmsExplanatoryInfo then
  begin
    FComment.Assign((Value as TmsExplanatoryInfo).Comment);
    FURL1:=(Value as TmsExplanatoryInfo).URL1;
    FURL2:=(Value as TmsExplanatoryInfo).URL2;
  end
  else
    inherited Assign(Value);
end;

procedure TmsExplanatoryInfo.Clear;
begin
  FComment.Clear;
  FURL1:='';
  FURL2:='';
end;

procedure TmsExplanatoryInfo.SaveToStrings(Strings : TStrings);
var
  i : Integer;
begin
  if FComment.Count>0 then
  begin
    FComment[0]:=Concat('NOTE:',FComment[0]);
    Strings.Add(FComment[0]);
    for i:=1 to FComment.Count-1 do
      Strings.Add(Concat('  ',FComment[i]));
  end;
  if FURL1<>'' then
    Strings.Add(Concat('URL:',FURL1));
  if FURL2<>'' then
    Strings.Add(Concat('URL:',FURL2));
end;

procedure TmsExplanatoryInfo.LoadFromStrings(Strings : TStrings);
var
  i : Integer;
begin
  Clear;
  with TmsPropertyParser.Create do
  try
    PropertyName:='NOTE';
    Lines:=Strings;
    Process;
    for i:=0 to Values.Count-1 do
      FComment.Add(Values[i]);
    PropertyName:='URL';
    Process;
    if Values.Count<>0 then
      FURL1:=Values[0];
    Process;
    if Values.Count<>0 then
      FURL2:=Values[0];
  finally
    Free;
  end;
end;

end.

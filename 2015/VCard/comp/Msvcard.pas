unit Msvcard;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, msvcls;

type
  TmsVCard = class(TComponent)
  private
    { Private declarations }
    FIdentification : TmsIdentification;
    FDeliveryInfo : TmsDeliveryInfo;
    FTelecomInfo : TmsTelecomInfo;
    FBusinessInfo : TmsBusinessInfo;
    FExplanatoryInfo : TmsExplanatoryInfo;
    procedure SetIdentification(Value : TmsIdentification);
    procedure SetDeliveryInfo(Value : TmsDeliveryInfo);
    procedure SetTelecomInfo(Value : TmsTelecomInfo);
    procedure SetBusinessInfo(Value : TmsBusinessInfo);
    procedure SetExplanatoryInfo(Value : TmsExplanatoryInfo);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(Value : TPersistent); override;
    procedure LoadFromStream(Stream : TStream);
    procedure SaveToStream(Stream : TStream);
    procedure LoadFromFile(const FileName : string);
    procedure SaveToFile(const FileName : string);
  published
    { Published declarations }
    property Identification : TmsIdentification read FIdentification
       write SetIdentification;
    property DeliveryInfo : TmsDeliveryInfo read FDeliveryInfo
       write SetDeliveryInfo;
    property TelecomInfo : TmsTelecomInfo read FTelecomInfo
       write SetTelecomInfo;
    property BusinessInfo : TmsBusinessInfo read FBusinessInfo
       write SetBusinessInfo;
    property ExplanatoryInfo : TmsExplanatoryInfo read FExplanatoryInfo
       write SetExplanatoryInfo;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('ArGoSoft', [TmsVCard]);
end;

constructor TmsVCard.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FIdentification:=TmsIdentification.Create;
  FDeliveryInfo:=TmsDeliveryInfo.Create;
  FTelecomInfo:=TmsTelecomInfo.Create;
  FBusinessInfo:=TmsBusinessInfo.Create;
  FExplanatoryInfo:=TmsExplanatoryInfo.Create;
end;

destructor TmsVCard.Destroy;
begin
  FExplanatoryInfo.Free;
  FBusinessInfo.Free;
  FTelecomInfo.Free;
  FDeliveryInfo.Free;
  FIdentification.Free;
  inherited Destroy;
end;

procedure TmsVCard.SetIdentification(Value : TmsIdentification);
begin
  FIdentification.Assign(Value);
end;

procedure TmsVCard.SetDeliveryInfo(Value : TmsDeliveryInfo);
begin
  FDeliveryInfo.Assign(Value);
end;

procedure TmsVCard.SetTelecomInfo(Value : TmsTelecomInfo);
begin
  FTelecomInfo.Assign(Value);
end;

procedure TmsVCard.SetBusinessInfo(Value : TmsBusinessInfo);
begin
  FBusinessInfo.Assign(Value);
end;

procedure TmsVCard.SetExplanatoryInfo(Value : TmsExplanatoryInfo);
begin
  FExplanatoryInfo.Assign(Value);
end;

procedure TmsVCard.Clear;
begin
  FIdentification.Clear;
  FDeliveryInfo.Clear;
  FTelecomInfo.Clear;
  FBusinessInfo.Clear;
  FExplanatoryInfo.Clear;
end;

procedure TmsVCard.Assign(Value : TPersistent);
begin
  if Value is TmsVCard then
  begin
    FIdentification.Assign((Value as TmsVCard).Identification);
    FDeliveryInfo.Assign((Value as TmsVCard).DeliveryInfo);
    FTelecomInfo.Assign((Value as TmsVCard).TelecomInfo);
    FBusinessInfo.Assign((Value as TmsVCard).BusinessInfo);
    FExplanatoryInfo.Assign((Value as TmsVCard).ExplanatoryInfo);
  end
  else
    inherited Assign(Value);
end;

procedure TmsVCard.LoadFromStream(Stream : TStream);
var
  Lines : TStrings;
begin
  Lines:=TStringList.Create;
  try
    Stream.Position:=0;
    Lines.LoadFromStream(Stream);
    FIdentification.LoadFromStrings(Lines);
    FDeliveryInfo.LoadFromStrings(Lines);
    FTelecomInfo.LoadFromStrings(Lines);
    FBusinessInfo.LoadFromStrings(Lines);
    FExplanatoryInfo.LoadFromStrings(Lines);
  finally
    Lines.Free;
  end;
end;

procedure TmsVCard.SaveToStream(Stream : TStream);
var
  Lines : TStrings;
  s : string;
  i : Integer;
begin
  Lines:=TStringList.Create;
  try
    Lines.Add('BEGIN:VCARD');
    Lines.Add('VERSION:1.2');
    FIdentification.SaveToStrings(Lines);
    FDeliveryInfo.SaveToStrings(Lines);
    FTelecomInfo.SaveToStrings(Lines);
    FBusinessInfo.SaveToStrings(Lines);
    FExplanatoryInfo.SaveToStrings(Lines);
    Lines.Add('END:VCARD');
    for i:=0 to Lines.Count-1 do
    begin
      s:=Concat(Lines[i],^M^J);
      Stream.Write(s[1],Length(s));
    end;
  finally
    Lines.Free;
  end;
end;

procedure TmsVCard.LoadFromFile(const FileName : string);
var
  FileStream : TStream;
begin
  FileStream:=TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(FileStream);
  finally
    FileStream.Free;
  end;
end;

procedure TmsVCard.SaveToFile(const FileName : string);
var
  FileStream : TStream;
begin
  FileStream:=TFileStream.Create(FileName, fmOpenWrite or fmCreate);
  try
    SaveToStream(FileStream);
  finally
    FileStream.Free;
  end;
end;

end.

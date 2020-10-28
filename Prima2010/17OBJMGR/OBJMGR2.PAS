unit OBJMGR2;

interface

uses
  WinProcs, WinTypes, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, TypInfo, DsgnIntF, Registry;

const
  // These are the supported property types
  tkProps = [tkInteger,tkChar,tkString,tkLString];
  ppComponent = 0;
  ppProperty  = 1;
  ppSubKey    = 2;
  ppName      = 3;
  ppDefault   = 4;
  ppValid     = 5;

type
  TObjMgr = class(TComponent)
  private
    FItems    : TStrings;
    procedure SetItems(Value: TStrings);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Load;
    procedure Save;
  published
    property Items: TStrings read FItems write SetItems;
  end;

  function Parse(TmpS: String; A: Integer; C: Char): String;

implementation

function Parse(TmpS: String; A: Integer; C: Char): String;
var
  SCNum,X : Integer;
begin
  Result := '';
  SCNum := 0;
  for X := 1 to Length(TmpS) do
    if TmpS[X] = C then
      Inc(SCNum)
    else
      if SCNum = A then
        Result := Result + TmpS[X];
  Result := Trim(Result);
end;

function IsValid(a: String): Boolean;
begin
  Result := (Parse(a,ppComponent,';')<>'');
  if not Result then Result := (Parse(a,ppProperty,';')<>'');
  if not Result then Result := (Parse(a,ppSubKey,';')<>'');
  if not Result then Result := (Parse(a,ppName,';')<>'');
end;

function GetPropAsString(Obj: TObject; Info: PPropInfo): String;
var
  IntVal    : LongInt;
begin
  Result := '';
  with Info^ do
    case PropType^.Kind of
      tkInteger : begin
                    // Get the integer value
                    IntVal := LongInt(GetOrdProp(Obj,Info));
                    // See if it is a TColor or TCursor - convert to text
                    if (PropType^.Name = 'TColor') and
                      ColorToIdent(IntVal,Result) then
                    else
                      if (PropType^.Name = 'TCursor') and
                         CursorToIdent(IntVal,Result) then
                      else
                        Result := IntToStr(IntVal);
                  end;
      tkChar    : Result := Chr(GetOrdProp(Obj,Info));
      tkString,
      tkLString : Result := GetStrProp(Obj,Info);
    end;
end;

procedure SetPropFromString(Obj: TObject; Info: PPropInfo; Str: String);
var
  IntVal   : LongInt;
  CharVal  : Char;
begin
  try with Info^ do
    case PropType^.Kind of
       tkInteger : if Str<>'' then
                     if PropType^.Name = 'TColor' then
                       if IdentToColor(Str,IntVal) then
                         SetOrdProp(Obj,Info,IntVal)
                       else
                         SetOrdProp(Obj,Info,StrToInt(Str))
                     else
                       if PropType^.Name = 'TCursor' then
                         if IdentToCursor(Str,IntVal) then
                           SetOrdProp(Obj,Info,IntVal)
                         else
                           SetOrdProp(Obj,Info,StrToInt(Str))
                       else
                         SetOrdProp(Obj,Info,StrToInt(Str));
       tkChar    : begin
                     CharVal := Str[1];
                     SetOrdProp(Obj,Info,Ord(CharVal));
                   end;
       tkString,
       tkLString : SetStrProp(Obj,Info,Str);
    end;
  except
    // This catches invalid property assignments
  end;
end;

(*******************************************)
(*   TObjMgr - Persistent Object Manager   *)
(*******************************************)

constructor TObjMgr.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := nil;
end;

destructor TObjMgr.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TObjMgr.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TObjMgr.Load;
var
  Reg      : TRegistry;
  A        : Integer;
  TmpCmp   : TComponent;
  PropInfo : PPropInfo;
  S1       : String;
  CmpName  : String;
  PrpName  : String;
  SubKey   : String;
  KeyName  : String;
  DefVal   : String;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    // Loop through all items managed
    for A := 0 to Items.Count-1 do
      begin
        S1 := Items[A];
        // Verify item is valid
        if not IsValid(S1) then continue;
        // Extract the individual elements from the item
        CmpName := Parse(S1,ppComponent,';');
        PrpName := Parse(S1,ppProperty,';');
        SubKey  := Parse(S1,ppSubKey,';');
        KeyName := Parse(S1,ppName,';');
        DefVal  := Parse(S1,ppDefault,';');
        // Check to see if this is a form
        if CmpName = (Owner as TForm).Name then
          // Yes - use the form
          TmpCmp := (Owner as TForm)
        else
          // Find the component on the form
          TmpCmp := (Owner as TForm).FindComponent(CmpName);
        // Couldn't find component - go on to next
        if TmpCmp = nil then Continue;
        // Get the info record on this component
        PropInfo := GetPropInfo(TmpCmp.ClassInfo,PrpName);
        if PropInfo = nil then Continue;
        try
          Reg.CloseKey;
          // Open the Subkey
          if Reg.OpenKey(SubKey,False) then
            // Does this key name exist?
            if Reg.ValueExists(KeyName) then
              // Yes - set the property
              SetPropFromString(TmpCmp,PropInfo,Reg.ReadString(KeyName))
            else
              // No it doesn't exist - use the default
              SetPropFromString(TmpCmp,PropInfo,DefVal)
          else
            // Couldn't open the key - use the default
            SetPropFromString(TmpCmp,PropInfo,DefVal);
        except
        end;
      end;
  finally
    Reg.Free;
  end;
end;

procedure TObjMgr.Save;
var
  Reg      : TRegistry;
  A        : Integer;
  TmpCmp   : TComponent;
  PropInfo : PPropInfo;
  S1       : String;
  CmpName  : String;
  PrpName  : String;
  SubKey   : String;
  KeyName  : String;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    // Loop through all items managed
    for A := 0 to Items.Count-1 do
      begin
        S1 := Items[A];
        // Verify item is valid
        if not IsValid(S1) then continue;
        // Extract the individual elements from the item
        CmpName := Parse(S1,ppComponent,';');
        PrpName := Parse(S1,ppProperty,';');
        SubKey  := Parse(S1,ppSubKey,';');
        KeyName := Parse(S1,ppName,';');
        // Check to see if this is a form
        if CmpName = (Owner as TForm).Name then
          // Yes - use the form
          TmpCmp := (Owner as TForm)
        else
          // Find the component on the form
          TmpCmp := (Owner as TForm).FindComponent(CmpName);
        // Couldn't find component - go on to next
        if TmpCmp = nil then Continue;
        // Get the info record on this component
        PropInfo := GetPropInfo(TmpCmp.ClassInfo,PrpName);
        if PropInfo = nil then Continue;
        try
          Reg.CloseKey;
          if Reg.OpenKey(Subkey,True) then
            Reg.WriteString(KeyName,GetPropAsString(TmpCmp,PropInfo));
        except
        end;
      end;
  finally
    Reg.Free;
  end;
end;

end.

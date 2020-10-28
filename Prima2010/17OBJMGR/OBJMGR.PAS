unit OBJMGR;

interface

uses
  WinProcs, WinTypes, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, DsgnIntF, StdCtrls, Buttons, TypInfo, ObjMgr2, ExtCtrls;

type

  TObjMgrCEditor = class(TDefaultEditor)
  protected
    procedure EditProperty(PropertyEditor: TPropertyEditor;
      var Continue, FreeEditor: Boolean); override;
  public
    function GetVerb(Index: Integer): String; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  TObjMgrProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TObjMgrDialog = class(TForm)
    lbItemsManaged: TListBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cmbComponent: TComboBox;
    cmbProperty: TComboBox;
    cmbRegSubKey: TComboBox;
    edtKeyName: TEdit;
    edtDefault: TEdit;
    btnAdd: TBitBtn;
    btnDelete: TBitBtn;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure lbItemsManagedClick(Sender: TObject);
    // Procedures to make sure controls are displaying correct data
    procedure UpdateComponentsCombo;
    procedure UpdatePropertiesCombo;
    procedure UpdateSubKeyCombo;
    procedure UpdateKeyNameEditBox;
    procedure UpdateDefaultsEditBox;

    procedure DisableCombos;
    procedure EnableCombos;
    procedure ValidateAll;
    procedure ValidateOne(Index: Integer);
    procedure lbItemsManagedDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure NewRegSubKeyCheck;
    procedure cmbRegSubKeyKeyPress(Sender: TObject; var Key: Char);
    procedure cmbRegSubKeyExit(Sender: TObject);
    procedure cmbComponentChange(Sender: TObject);
    procedure cmbPropertyChange(Sender: TObject);
    procedure cmbRegSubKeyChange(Sender: TObject);
    procedure edtKeynameChange(Sender: TObject);
    procedure edtDefaultExit(Sender: TObject);
    function  GetItemStr: String;
    procedure SetItemStr(a: String);
  private
    TheObjEd   : TObjMgrProperty;
    GoodBadBmp : TBitmap;
    procedure WMGetMinMaxInfo(var Message :TWMGetMinMaxInfo ); message WM_GETMINMAXINFO;
  public
    { Public declarations }
  end;

  procedure Register;

implementation

{$R *.DFM}
{$R OBJMGR.RES}

procedure Register;
begin
  RegisterComponents('System', [TObjMgr]);
  RegisterPropertyEditor(TypeInfo(TStrings),TObjMgr,'Items',TObjMgrProperty);
  RegisterComponentEditor(TObjMgr,TObjMgrCEditor);
end;

function Replace(var TheStr: String; Ind: Integer; SubStr: String): Boolean;
var
  SCNum,a : Integer;
  SCStart : Integer;
  SCStop  : Integer;
begin
  SCNum := 0;
  SCStart := -1;
  SCStop := -1;
  for a := 1 to Length(TheStr) do
    begin
      if TheStr[a] = ';' then
        begin
          Inc(SCNum);
          if (SCStart=-1) and (SCNum=Ind) then SCStart := a+1;
        end;
      if SCNum=Ind then SCStop := a;
    end;
  Result := False;
  if (SCStart=-1) and (SCStop=-1) then exit;
  Result := True;
  if (Ind=0) and (SCStart=-1) then SCStart := 1;
  Delete(TheStr,SCStart,SCStop-SCStart+1);
  Insert(SubStr,TheStr,SCStart);
end;

(*****************************************)
(*   TObjMgrCEditor - Component Editor   *)
(*****************************************)

function TObjMgrCEditor.GetVerb(Index: Integer): String;
begin
  if Index = 0 then Result := 'E&dit Managed Properties';
end;

function TObjMgrCEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TObjMgrCEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then Edit;
end;

procedure TObjMgrCEditor.EditProperty(PropertyEditor: TPropertyEditor;
  var Continue, FreeEditor: Boolean);
var
  PropName: string;
begin
  PropName := PropertyEditor.GetName;
  if (CompareText(PropName, 'ITEMS') = 0) then
  begin
    PropertyEditor.Edit;
    Continue := False;
  end;
end;

(****************************************)
(*   TObjMgrProperty - Property Editor  *)
(****************************************)

procedure TObjMgrProperty.Edit;
var
  ObjMgrDlg : TObjMgrDialog;
  TheItems  : TStringList;
  a         : Integer;
  b         : String;
begin
  ObjMgrDlg := TObjMgrDialog.Create(Application);
  ObjMgrDlg.TheObjEd := Self;
  try
    TheItems := TStringList(Pointer(GetOrdValue));
    for a := 0 to TheItems.Count-1 do
      begin
        // Add the item to the Items Managed listbox
        ObjMgrDlg.lbItemsManaged.Items.Add(TheItems[a]);
        // Here we are populating the cmbRegSubKey combo with all the subkeys
        // that we currently have defined. This saves repeated typing of subkeys
        // that have already been typed.

        // Extract the SubKey name used
        b := Trim(Parse(TheItems[a],ppSubKey,';'));
        // Is it already in the cmbRegSubKey stringlist?
        if b <> '' then with ObjMgrDlg.cmbRegSubKey.Items do
          // If not, then add it
          if IndexOf(b)=-1 then Add(b);
      end;
    if TheItems.Count=0 then
      begin
        ObjMgrDlg.DisableCombos;
        ObjMgrDlg.cmbComponent.Enabled := False;
      end;
    // When the component editor is up, we are waiting on this next line
    if ObjMgrDlg.ShowModal = mrOK then
      // If user clicks "OK" then set stringlist back to property
      SetOrdValue(LongInt(ObjMgrDlg.lbItemsManaged.Items));
  finally
    ObjMgrDlg.Free;
  end;
end;

function TObjMgrProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

(**********************************************)
(*   TObjMgrDialog - Dialog for Property Editor  *)
(**********************************************)

procedure TObjMgrDialog.FormShow(Sender: TObject);
var
  a : Integer;
begin
  // Add the form name to the list so we can access it's properties
  cmbComponent.Items.Add(TheObjEd.Designer.Form.Name);
  // Populate combo with all components on form
  with TheObjEd.Designer.Form do
    for a := 0 to ComponentCount-1 do
      cmbComponent.Items.Add(Components[a].Name);
  ValidateAll;
  // Are there items in the items managed list?
  if lbItemsManaged.Items.Count > 0 then
    begin
      // Select the first one
      lbItemsManaged.ItemIndex := 0;
      // Simulate a click on it to populate other controls
      lbItemsManagedClick(lbItemsManaged);
    end;
end;

procedure TObjMgrDialog.WMGetMinMaxInfo(var Message :TWMGetMinMaxInfo);
begin
  with Message.MinMaxInfo^ do
  begin
    ptMinTrackSize.X := 387; {Minimum form width}
    ptMinTrackSize.Y := 276; {Minimum form height}
  end;
  Message.Result := 0;
  inherited;
end;

procedure TObjMgrDialog.DisableCombos;
begin
  cmbProperty.ItemIndex := -1;
  cmbProperty.Enabled := False;
  cmbRegSubKey.ItemIndex := -1;
  cmbRegSubKey.Enabled := False;
  edtKeyName.Text := '';
  edtKeyName.Enabled := False;
  edtDefault.Text := '';
  edtDefault.Enabled := False;
end;

procedure TObjMgrDialog.EnableCombos;
begin
  cmbProperty.Enabled := True;
  cmbRegSubKey.Enabled := True;
  edtKeyName.Enabled := True;
  edtDefault.Enabled := True;
end;

procedure TObjMgrDialog.UpdateComponentsCombo;
var
  a,b : String;
begin
  with lbItemsManaged do
    if ItemIndex >= 0 then
      a := Items[ItemIndex]
    else
      a := '';
  with cmbComponent do
    begin
      b := '';
      if a <> '' then b := Parse(a,ppComponent,';');
      if (b='<Unknown>') or (b='') then
        ItemIndex := -1
      else
        ItemIndex := Items.IndexOf(b);
      if ItemIndex = -1 then DisableCombos else EnableCombos;
    end;
end;

procedure TObjMgrDialog.UpdatePropertiesCombo;
var
  a,c       : String;
  b,Count   : Integer;
  TmpCmp    : TComponent;
  PropInfos : PPropList;
begin
  with lbItemsManaged do a := Items[ItemIndex];
  c := Parse(a,ppComponent,';');
  // If this is the form, then use its properties
  if c = TheObjEd.Designer.Form.Name then
    TmpCmp := TheObjEd.Designer.Form
  else
    // Otherwise get the component from current form...
    TmpCmp := TheObjEd.Designer.GetComponent(c);
  if TmpCmp = nil then
    begin
      DisableCombos;
      exit;
    end
  else EnableCombos;
  // Get the number of properties it has
  Count := GetPropList(TmpCmp.ClassInfo,tkProps,nil);
  // Get memory for the list of properties
  GetMem(PropInfos,Count*SizeOf(PPropInfo));
  try
    // Get all the property names
    GetPropList(TmpCmp.ClassInfo,tkProps,PropInfos);
    with cmbProperty do
      begin
        // Prevent updates to the control while adding items
        Items.BeginUpdate;
        // Clear all items in list
        Clear;
        // Go through all property names and add them to the combobox
        for b := 0 to Count-1 do Items.Add(PropInfos^[b]^.Name);
        // Set selected property
        ItemIndex := Items.IndexOf(Parse(a,ppProperty,';'));
        // Allow updates
        Items.EndUpdate;
      end;
  finally
    // Free memory allocated for PropInfos
    FreeMem(PropInfos,Count*SizeOf(PPropInfo));
  end;
end;

procedure TObjMgrDialog.UpdateSubKeyCombo;
var
  a : String;
begin
  with lbItemsManaged do
    if ItemIndex >= 0 then a := Parse(Items[ItemIndex],ppSubKey,';') else a := '';
  cmbRegSubKey.ItemIndex := cmbRegSubKey.Items.IndexOf(a);
end;

procedure TObjMgrDialog.UpdateKeyNameEditBox;
begin
  with lbItemsManaged do
    if ItemIndex >= 0 then
      edtKeyName.Text := Parse(Items[ItemIndex],ppName,';')
    else
      edtKeyName.Text := '';
end;

procedure TObjMgrDialog.UpdateDefaultsEditBox;
begin
  with lbItemsManaged do
    if ItemIndex >= 0 then
      edtDefault.Text := Parse(Items[ItemIndex],ppDefault,';')
    else
      edtDefault.Text := '';
end;

procedure TObjMgrDialog.ValidateOne(Index: Integer);
var
  IsBad : Boolean;
  a : String;
begin
  with lbItemsManaged do
    begin
      if (Index < 0) or (Index > Items.Count-1) then exit;
      a := Items[Index];
      IsBad := (Parse(a,ppComponent,';')='');
      if not IsBad then IsBad := (Parse(a,ppProperty,';')='');
      if not IsBad then IsBad := (Parse(a,ppSubKey,';')='');
      if not IsBad then IsBad := (Parse(a,ppName,';')='');
      if IsBad then Replace(a,ppValid,'0') else Replace(a,ppValid,'1');
      Items[Index] := a;
      ItemIndex := Items.IndexOf(a);
    end;
end;

procedure TObjMgrDialog.ValidateAll;
var
  a : Integer;
begin
  for a := 0 to lbItemsManaged.Items.Count-1 do ValidateOne(a);
end;

procedure TObjMgrDialog.lbItemsManagedClick(Sender: TObject);
begin
  UpdateComponentsCombo;
  UpdatePropertiesCombo;
  UpdateSubKeyCombo;
  UpdateKeyNameEditBox;
  UpdateDefaultsEditBox;
end;

// How to draw the items in the lbItemsManaged listbox
procedure TObjMgrDialog.lbItemsManagedDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with lbItemsManaged,Canvas do
    begin
      FillRect(Rect);
      // Draw graphic indicating if item is validated
      if Parse(Items[Index],ppValid,';')='1' then
        BrushCopy(Bounds(Rect.Left+3,Rect.Top+2,9,9),GoodBadBmp,Bounds(0,0,9,9),clOlive)
      else
        BrushCopy(Bounds(Rect.Left+3,Rect.Top+2,9,9),GoodBadBmp,Bounds(9,0,9,9),clOlive);
      // Write out the component and property name
      TextOut(Rect.Left+15,Rect.Top,Parse(Items[Index],ppComponent,';'));
      TextOut(Rect.Right div 2,Rect.Top,Parse(Items[Index],ppProperty,';'));
    end;
end;

procedure TObjMgrDialog.FormResize(Sender: TObject);
begin
  Panel1.Left := ClientWidth div 2+4;
  Panel1.Width := ClientWidth-Panel1.Left-2;
  with lbItemsManaged do
    SetBounds(Left,Top,Panel1.Left-Left-4,
              Self.ClientHeight-Top-btnAdd.Height-15);
  cmbComponent.Width := Panel1.Width-9;
  cmbProperty.Width := Panel1.Width-9;
  cmbRegSubKey.Width := Panel1.Width-9;
  edtKeyName.Width := Panel1.Width-9;
  edtDefault.Width := Panel1.Width-9;
  btnAdd.Top := ClientHeight-btnAdd.Height-6;
  btnDelete.Top := btnAdd.Top;
end;

procedure TObjMgrDialog.FormCreate(Sender: TObject);
begin
  GoodBadBmp := TBitmap.Create;
  GoodBadBmp.Handle := LoadBitmap(hInstance,'GOODBAD');
end;

procedure TObjMgrDialog.FormDestroy(Sender: TObject);
begin
  GoodBadBmp.Free;
end;

procedure TObjMgrDialog.btnAddClick(Sender: TObject);
begin
  with lbItemsManaged do
    begin
      Items.Add('<Unknown>;;;;;0;0');
      ItemIndex := Items.Count-1;
      lbItemsManagedClick(lbItemsManaged);
      cmbComponent.Enabled := True;
    end;
end;

procedure TObjMgrDialog.btnDeleteClick(Sender: TObject);
var
  a : Integer;
begin
  with lbItemsManaged do
    if ItemIndex >= 0 then
      begin
        a := ItemIndex;
        Items.Delete(ItemIndex);
        if a > Items.Count-1 then a := Items.Count-1;
        if a >= 0 then
          begin
            ItemIndex := a;
            lbItemsManagedClick(lbItemsManaged);
          end
        else
          DisableCombos;
      end;
end;

procedure TObjMgrDialog.NewRegSubKeyCheck;
var
  a : String;
begin
  a := Trim(cmbRegSubKey.Text);
  if Length(a) = 0 then exit;
  // if String doesn't exist, add it
  if cmbRegSubKey.Items.IndexOf(a) = -1 then
    cmbRegSubKey.Items.Add(a);
  // Set combo selection to be new string
  cmbRegSubKey.ItemIndex := cmbRegSubKey.Items.IndexOf(a);
end;

procedure TObjMgrDialog.cmbRegSubKeyKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then NewRegSubKeyCheck;
end;

procedure TObjMgrDialog.cmbRegSubKeyExit(Sender: TObject);
begin
  NewRegSubKeyCheck;
end;

procedure TObjMgrDialog.cmbComponentChange(Sender: TObject);
var
  a : String;
begin
  cmbProperty.ItemIndex := -1;
  cmbRegSubKey.ItemIndex := -1;
  edtKeyName.Text := '';
  edtDefault.Text := '';
  a := cmbComponent.Text+';;;;;0';
  with lbItemsManaged do
    if ItemIndex >= 0 then
      begin
        Items[ItemIndex] := a;
        ItemIndex := Items.IndexOf(a);
      end;
  EnableCombos;
  UpdatePropertiesCombo;
end;

procedure TObjMgrDialog.cmbPropertyChange(Sender: TObject);
var
  a : String;
begin
  cmbRegSubKey.ItemIndex := -1;
  edtKeyName.Text := '';
  edtDefault.Text := '';
  a := cmbComponent.Text+';'+cmbProperty.Text+';;;;0';
  with lbItemsManaged do
    if ItemIndex >= 0 then
      begin
        Items[ItemIndex] := a;
        ItemIndex := Items.IndexOf(a);
      end;
  UpdateDefaultsEditBox;
end;

procedure TObjMgrDialog.cmbRegSubKeyChange(Sender: TObject);
var
  a : String;
begin
  a := GetItemStr;
  if a <> '' then
    begin
      Replace(a,ppSubKey,cmbRegSubKey.Text);
      SetItemStr(a);
    end;
end;

procedure TObjMgrDialog.edtKeyNameChange(Sender: TObject);
var
  a : String;
begin
  a := GetItemStr;
  if a <> '' then
    begin
      Replace(a,ppName,edtKeyName.Text);
      SetItemStr(a);
    end;
end;

function TObjMgrDialog.GetItemStr: String;
begin
  with lbItemsManaged do
    if ItemIndex >= 0 then
      Result := Items[ItemIndex]
    else
      Result := '';
end;

procedure TObjMgrDialog.SetItemStr(a: String);
begin
  with lbItemsManaged do
    if ItemIndex >= 0 then
      begin
        Items[ItemIndex] := a;
        ItemIndex := Items.IndexOf(a);
        ValidateOne(ItemIndex);
      end;
end;

procedure TObjMgrDialog.edtDefaultExit(Sender: TObject);
var
  a : String;
begin
  a := GetItemStr;
  if a <> '' then
    begin
      Replace(a,ppDefault,edtDefault.Text);
      SetItemStr(a);
    end;
end;

end.

unit vcmain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ExtCtrls, Msvcard, ComCtrls, Tabnotbk,
  msVCls, ShellAPI;

type
  TvCardForm = class(TForm)
    MainMenu1: TMainMenu;
    TabbedNotebook1: TTabbedNotebook;
    Label1: TLabel;
    GivenNameEdit: TEdit;
    Label2: TLabel;
    AdditionalNamesEdit: TEdit;
    Label3: TLabel;
    FamilyNameEdit: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    PrefixEdit: TEdit;
    SuffixEdit: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Bevel2: TBevel;
    FormattedNameEdit: TEdit;
    Bevel3: TBevel;
    Label8: TLabel;
    Dom1CheckBox: TCheckBox;
    Intl1CheckBox: TCheckBox;
    Postal1CheckBox: TCheckBox;
    Parcel1CheckBox: TCheckBox;
    Home1CheckBox: TCheckBox;
    Work1CheckBox: TCheckBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    POAddress1Edit: TEdit;
    ExtendedAddress1Edit: TEdit;
    Street1Edit: TEdit;
    Locality1Edit: TEdit;
    Region1Edit: TEdit;
    Label14: TLabel;
    PostalCode1Edit: TEdit;
    Label15: TLabel;
    Country1Edit: TEdit;
    Dom2CheckBox: TCheckBox;
    Intl2CheckBox: TCheckBox;
    Postal2CheckBox: TCheckBox;
    Parcel2CheckBox: TCheckBox;
    Home2CheckBox: TCheckBox;
    Work2CheckBox: TCheckBox;
    Label16: TLabel;
    POAddress2Edit: TEdit;
    Bevel4: TBevel;
    Label17: TLabel;
    ExtendedAddress2Edit: TEdit;
    Locality2Edit: TEdit;
    Label18: TLabel;
    Street2Edit: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Region2Edit: TEdit;
    Label21: TLabel;
    PostalCode2Edit: TEdit;
    Label22: TLabel;
    Country2Edit: TEdit;
    Label23: TLabel;
    Bevel5: TBevel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    NameEdit: TEdit;
    UnitEdit: TEdit;
    Bevel6: TBevel;
    Label27: TLabel;
    Bevel7: TBevel;
    Label28: TLabel;
    TitleEdit: TEdit;
    RoleEdit: TEdit;
    Bevel8: TBevel;
    Phone1PrefCheckBox: TCheckBox;
    Phone1WorkCheckBox: TCheckBox;
    Phone1HomeCheckBox: TCheckBox;
    Phone1VoiceCheckBox: TCheckBox;
    Phone1MsgCheckBox: TCheckBox;
    Phone1CellCheckBox: TCheckBox;
    Phone1PagerCheckBox: TCheckBox;
    Phone1BBSCheckBox: TCheckBox;
    Phone1ModemCheckBox: TCheckBox;
    Phone1CarCheckBox: TCheckBox;
    Phone1ISDNCheckBox: TCheckBox;
    Phone1FaxCheckBox: TCheckBox;
    Phone1VideoCheckBox: TCheckBox;
    Label29: TLabel;
    Label30: TLabel;
    PhoneNumber1Edit: TEdit;
    Bevel10: TBevel;
    Phone3PrefCheckBox: TCheckBox;
    PhoneNumber3Edit: TEdit;
    Label32: TLabel;
    Phone3WorkCheckBox: TCheckBox;
    Phone3HomeCheckBox: TCheckBox;
    Phone3VoiceCheckBox: TCheckBox;
    Phone3FaxCheckBox: TCheckBox;
    Phone3MsgCheckBox: TCheckBox;
    Phone3CellCheckBox: TCheckBox;
    Phone3PagerCheckBox: TCheckBox;
    Phone3BBSCheckBox: TCheckBox;
    Phone3ModemCheckBox: TCheckBox;
    Phone3CarCheckBox: TCheckBox;
    Phone3ISDNCheckBox: TCheckBox;
    Phone3VideoCheckBox: TCheckBox;
    Bevel9: TBevel;
    Phone2PrefCheckBox: TCheckBox;
    PhoneNumber2Edit: TEdit;
    Label33: TLabel;
    Phone2WorkCheckBox: TCheckBox;
    Phone2HomeCheckBox: TCheckBox;
    Phone2VoiceCheckBox: TCheckBox;
    Phone2FaxCheckBox: TCheckBox;
    Phone2MsgCheckBox: TCheckBox;
    Phone2CellCheckBox: TCheckBox;
    Phone2PagerCheckBox: TCheckBox;
    Phone2BBSCheckBox: TCheckBox;
    Phone2ModemCheckBox: TCheckBox;
    Phone2CarCheckBox: TCheckBox;
    Phone2ISDNCheckBox: TCheckBox;
    Phone2VideoCheckBox: TCheckBox;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Email1ComboBox: TComboBox;
    Email1Edit: TEdit;
    Label40: TLabel;
    Label41: TLabel;
    Email2ComboBox: TComboBox;
    Email2Edit: TEdit;
    Bevel13: TBevel;
    Label42: TLabel;
    CommentsMemo: TMemo;
    Bevel14: TBevel;
    Bevel15: TBevel;
    URL1Edit: TEdit;
    URL2Edit: TEdit;
    Label43: TLabel;
    Label44: TLabel;
    msVCard1: TmsVCard;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    File1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    SaveAs1: TMenuItem;
    Open1: TMenuItem;
    New1: TMenuItem;
    Help1: TMenuItem;
    vCardcomponent1: TMenuItem;
    VisitArGoSofthome1: TMenuItem;
    About1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure VisitArGoSofthome1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Buf2Scr;
    procedure Scr2Buf;
  public
    { Public declarations }
  end;

var
  vCardForm: TvCardForm;

implementation

uses vcabout;

{$R *.DFM}

procedure TvCardForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TvCardForm.Buf2Scr;
var
  CheckBox : TCheckBox;
  i : TmsAddressType;
  j : TmsPhoneType;
begin
  with msVCard1 do
  begin
    with Identification do
    begin
      with Name do
      begin
        FamilyNameEdit.Text:=FamilyName;
        GivenNameEdit.Text:=GivenName;
        AdditionalNamesEdit.Text:=AdditionalNames;
        PrefixEdit.Text:=Prefix;
        SuffixEdit.Text:=Suffix;
      end;
      FormattedNameEdit.Text:=FormattedName;
    end;
    with DeliveryInfo do
    begin
      with Address1 do
      begin
        for i:=msaDomestic to msaWork do
        begin
          CheckBox:=TCheckBox(Owner.FindComponent(Concat(AddressStrings[i],'1','CheckBox')));
          if CheckBox<>nil then
              CheckBox.Checked:=i in Attributes
          else
            ShowMessage(AddressStrings[i]);
        end;
        POAddress1Edit.Text:=POAddress;
        ExtendedAddress1Edit.Text:=ExtendedAddress;
        Street1Edit.Text:=Street;
        Locality1Edit.Text:=Locality;
        Region1Edit.Text:=Region;
        PostalCode1Edit.Text:=PostalCode;
        Country1Edit.Text:=Country;
      end;
      with Address2 do
      begin
        for i:=msaDomestic to msaWork do
        begin
          CheckBox:=TCheckBox(Owner.FindComponent(Concat(AddressStrings[i],'2','CheckBox')));
          if CheckBox<>nil then
              CheckBox.Checked:=i in Attributes
          else
            ShowMessage(AddressStrings[i]);
        end;
        POAddress2Edit.Text:=POAddress;
        ExtendedAddress2Edit.Text:=ExtendedAddress;
        Street2Edit.Text:=Street;
        Locality2Edit.Text:=Locality;
        Region2Edit.Text:=Region;
        PostalCode2Edit.Text:=PostalCode;
        Country2Edit.Text:=Country;
      end;
    end;
    with BusinessInfo do
    begin
      with Company do
      begin
        NameEdit.Text:=Name;
        UnitEdit.Text:=AUnit;
      end;
      TitleEdit.Text:=Title;
      RoleEdit.Text:=Role;
    end;
    with TelecomInfo do
    begin
      with Phone1 do
      begin
        for j:=mstPreferred to mstVideo do
        begin
          CheckBox:=TCheckBox(Owner.FindComponent(Concat('Phone1',PhoneStrings[j],'CheckBox')));
          if CheckBox<>nil then
              CheckBox.Checked:=j in Attributes
          else
            ShowMessage(PhoneStrings[j]);
        end;
        PhoneNumber1Edit.Text:=Number;
      end;
      with Phone2 do
      begin
        for j:=mstPreferred to mstVideo do
        begin
          CheckBox:=TCheckBox(Owner.FindComponent(Concat('Phone2',PhoneStrings[j],'CheckBox')));
          if CheckBox<>nil then
              CheckBox.Checked:=j in Attributes
          else
            ShowMessage(PhoneStrings[j]);
        end;
        PhoneNumber2Edit.Text:=Number;
      end;
      with Phone3 do
      begin
        for j:=mstPreferred to mstVideo do
        begin
          CheckBox:=TCheckBox(Owner.FindComponent(Concat('Phone3',PhoneStrings[j],'CheckBox')));
          if CheckBox<>nil then
              CheckBox.Checked:=j in Attributes
          else
            ShowMessage(PhoneStrings[j]);
        end;
        PhoneNumber3Edit.Text:=Number;
      end;
      with EMail1 do
      begin
        EMail1ComboBox.ItemIndex:=Ord(EMailType)-1;
        EMail1Edit.Text:=Address;
      end;
      with EMail2 do
      begin
        EMail2ComboBox.ItemIndex:=Ord(EMailType)-1;
        EMail2Edit.Text:=Address;
      end;
    end;
    with ExplanatoryInfo do
    begin
      CommentsMemo.Lines:=Comment;
      URL1Edit.Text:=URL1;
      URL2Edit.Text:=URL2;
    end;
  end;
end;

procedure TvCardForm.Scr2Buf;
var
  i : TmsAddressType;
  AddressAttributes : TmsAddressAttributes;
  j : TmsPhoneType;
  PhoneAttributes : TmsPhoneAttributes;
  CheckBox : TCheckBox;
begin
  with msVCard1 do
  begin
    Clear;
    with Identification do
    begin
      with Name do
      begin
        FamilyName:=FamilyNameEdit.Text;
        GivenName:=GivenNameEdit.Text;
        AdditionalNames:=AdditionalNamesEdit.Text;
        Prefix:=PrefixEdit.Text;
        Suffix:=SuffixEdit.Text;
      end;
      FormattedName:=FormattedNameEdit.Text;
    end;
    with DeliveryInfo do
    begin
      AddressAttributes:=[];
      with Address1 do
      begin
        for i:=msaDomestic to msaWork do
        begin
          CheckBox:=TCheckBox(Owner.FindComponent(Concat(AddressStrings[i],'1','CheckBox')));
          if (CheckBox<>nil) and (CheckBox.Checked) then
            Include(AddressAttributes,i);
        end;
        Attributes:=AddressAttributes;
        POAddress:=POAddress1Edit.Text;
        ExtendedAddress:=ExtendedAddress1Edit.Text;
        Street:=Street1Edit.Text;
        Locality:=Locality1Edit.Text;
        Region:=Region1Edit.Text;
        PostalCode:=PostalCode1Edit.Text;
        Country:=Country1Edit.Text;
      end;
      AddressAttributes:=[];
      with Address2 do
      begin
        for i:=msaDomestic to msaWork do
        begin
          CheckBox:=TCheckBox(Owner.FindComponent(Concat(AddressStrings[i],'2','CheckBox')));
          if (CheckBox<>nil) and (CheckBox.Checked) then
            Include(AddressAttributes,i);
        end;
        Attributes:=AddressAttributes;
        POAddress:=POAddress2Edit.Text;
        ExtendedAddress:=ExtendedAddress2Edit.Text;
        Street:=Street2Edit.Text;
        Locality:=Locality2Edit.Text;
        Region:=Region2Edit.Text;
        PostalCode:=PostalCode2Edit.Text;
        Country:=Country2Edit.Text;
      end;
    end;
    with BusinessInfo do
    begin
      with Company do
      begin
        Name:=NameEdit.Text;
        AUnit:=UnitEdit.Text;
      end;
      Title:=TitleEdit.Text;
      Role:=RoleEdit.Text;
    end;
    with TelecomInfo do
    begin
      PhoneAttributes:=[];
      with Phone1 do
      begin
        for j:=mstPreferred to mstVideo do
        begin
          CheckBox:=TCheckBox(Owner.FindComponent(Concat('Phone1',PhoneStrings[j],'CheckBox')));
          if (CheckBox<>nil) and (CheckBox.Checked) then
            Include(PhoneAttributes,j);
        end;
        Attributes:=PhoneAttributes;
        Number:=PhoneNumber1Edit.Text;
      end;
      PhoneAttributes:=[];
      with Phone2 do
      begin
        for j:=mstPreferred to mstVideo do
        begin
          CheckBox:=TCheckBox(Owner.FindComponent(Concat('Phone2',PhoneStrings[j],'CheckBox')));
          if (CheckBox<>nil) and (CheckBox.Checked) then
            Include(PhoneAttributes,j);
        end;
        Attributes:=PhoneAttributes;
        Number:=PhoneNumber2Edit.Text;
      end;
      PhoneAttributes:=[];
      with Phone3 do
      begin
        for j:=mstPreferred to mstVideo do
        begin
          CheckBox:=TCheckBox(Owner.FindComponent(Concat('Phone3',PhoneStrings[j],'CheckBox')));
          if (CheckBox<>nil) and (CheckBox.Checked) then
            Include(PhoneAttributes,j);
        end;
        Attributes:=PhoneAttributes;
        Number:=PhoneNumber3Edit.Text;
      end;
      with EMail1 do
      begin
        EMailType:=TmsEmailType(Email1ComboBox.ItemIndex+1);
        Address:=Email1Edit.Text;
      end;
      with EMail2 do
      begin
        EMailType:=TmsEmailType(Email2ComboBox.ItemIndex+1);
        Address:=Email2Edit.Text;
      end;
    end;
    with ExplanatoryInfo do
    begin
      Comment:=CommentsMemo.Lines;
      URL1:=URL1Edit.Text;
      URL2:=URL2Edit.Text;
    end;
  end;
end;

procedure TvCardForm.Open1Click(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    msVCard1.LoadFromFile(OpenDialog.FileName);
    Buf2Scr;
  end;
end;

procedure TvCardForm.New1Click(Sender: TObject);
begin
  msVCard1.Clear;
  Buf2Scr;
end;

procedure TvCardForm.SaveAs1Click(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    Scr2Buf;
    msVCard1.SaveToFile(SaveDialog.FileName);
  end;
end;

procedure TvCardForm.About1Click(Sender: TObject);
begin
  with TAboutBox.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TvCardForm.VisitArGoSofthome1Click(Sender: TObject);
begin
  ShellExecute(Handle,'open','http://www.argosoft.com',nil,
    nil,SW_SHOW);
end;

end.

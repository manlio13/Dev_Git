HelpScribble project file.
16
Znayvb Ynfpuran-07NP42
0
2
vCard component for Delphi



TRUE


1
BrowseButtons()
0
FALSE

FALSE
TRUE
16777215
0
16711680
8388736
255
FALSE
FALSE
FALSE
FALSE
150
50
600
500
TRUE
FALSE
1
FALSE
FALSE
Contents
%s Contents
Index
%s Index
Previous
Next
FALSE

27
10
vCard_component
vCard component




Imported



FALSE
18
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 vCard component\cf2\fs0\{keepn\} 
\par 
\par \cf0\fs20 vCard is a new standard for electronic business cards, developed by \b Versit Consortium\b0  (http://www.versit.com) and maintained by the \b Internet Mail Consortium\b0  (IMC, http://www.imc.org). vCard is used for personal data interchange (PDI) and is supported by popular white pages services such as \b Four11\b0  (http://www.four11.com), \b Populus Intelligent People Locator\b0  (http://www.populus.net),  also it is implemented in the popular email programs and database software, such as Microsoft \b Outlook\b0  and \b Outlook express\b0 , \b Netscape Communicator\b0 , \b Lotus Organizer 97 GS\b0 , \b Sidekick 98\b0  and many many more.
\par 
\par You can get more information about vCard at IMC pages.  Check out:
\par 
\par http://www.imc.org/pdi
\par 
\par You will also find there the documentation about vCard and vCalendar objects.
\par 
\par \cf2\strike TmsVCard component reference\strike0\{linkID=50\}\cf0 
\par \cf2\strike Limitations\strike0\{linkID=20\}\cf0 
\par \cf2\strike Installation\strike0\{linkID=30\}\cf0 
\par \cf2\strike Contact\strike0\{linkID=40\}\cf0 
\par 
\par }
20
Limitations
Limitations




Imported



FALSE
11
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 Limitations\cf2\fs0\{keepn\} 
\par \cf0\fs20 
\par ArGoSoft vCard component complies with the requirements of vCard v2.1, but it does not support binary properties, such as IMAGE, LOGO, SOUND.
\par 
\par Component does not decode the fields which are encoded using Quoted-Printable encoding method.
\par 
\par The binary properties, also decoding of Quoted-Printable and Base64 encoded fields will be implemented in more advanced vCard component, which will be a part of the \b Internet Mail Suite\b0 , developed by ArGo Software Design (http://www.argosoft.com).
\par 
\par }
30
Installation
Installation




Imported



FALSE
12
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 Installation\cf2\fs0\{keepn\} 
\par \cf0\fs20 
\par TmsVCard component will work only with 32 bit versions of Delphi and BCBuilder.
\par 
\par In Delphi 2 and Borland C++ Builder: install the file msvcard.pas,
\par in Delphi 3 - a package vcard.dpl.  In Delphi 3 you probably also will need to add the path to the vCard files manually, in Tools - Environment Options - Library.
\par 
\par TmsVCard component should appear in the ArGoSoft tab on the component palette.
\par 
\par }
40
Contact
Contact




Imported



FALSE
15
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 Contact\cf2\fs0\{keepn\} 
\par \cf0\fs20 You can contact \b ArGo Software Design\b0  by:
\par 
\par Internet mail:\tab support@argosoft.com
\par CompuServe:\tab [75231,330]
\par WWW:\tab\tab http://www.argosoft.com
\par Fax:\tab\tab +1-416-352-5054
\par Mail:\tab\tab ArGo Software Design
\par \tab\tab 77 Davisville Ave. Suite 2107
\par \tab\tab Toronto Ontario M4S 1G4
\par \tab\tab Canada
\par 
\par }
50
TmsVCard_component
TmsVCard component
TmsVCard component



Imported



FALSE
10
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 TmsVCard component\cf2\fs0 
\par \ul\fs20 properties\ulnone\{linkID=60\}\cf0\tab\cf2\ul methods\ulnone\{linkID=70\}\fs0 
\par \cf0\fs20 
\par You can use TmsVCard component to generate standard vCard files, also read and parse the data contained in vCard files.
\par 
\par You can take a look at demo program vcard.dpr, which is included in this package.
\par 
\par }
60
properties
properties




Imported



FALSE
10
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}}
{\colortbl ;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs0 
\par \strike\fs20 BusinessInfo\strike0\{linkID=140\}\cf0 
\par \cf1\strike DeliveryInfo\strike0\{linkID=160\}\cf0 
\par \cf1\strike ExplanatoryInfo\strike0\{linkID=170\}\cf0 
\par \cf1\strike Identification\strike0\{linkID=180\}\cf0 
\par \cf1\strike TelecomInfo\strike0\{linkID=190\}\cf0 
\par 
\par }
70
methods
methods




Imported



FALSE
11
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}}
{\colortbl ;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs0 
\par \strike\fs20 Clear\strike0\{linkID=80\}\cf0 
\par \cf1\strike Assign\strike0\{linkID=90\}\cf0 
\par \cf1\strike LoadFromStream\strike0\{linkID=100\}\cf0 
\par \cf1\strike LoadFromFile\strike0\{linkID=110\}\cf0 
\par \cf1\strike SaveToStream\strike0\{linkID=120\}\cf0 
\par \cf1\strike SaveToFile\strike0\{linkID=130\}\cf0 
\par 
\par }
80
Clear_method
Clear method
Clear method



Imported



FALSE
16
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 Clear method\cf2\fs0 
\par \cf0\b\fs20 unit\cf2\b0\fs24 
\par \cf0\fs20 msVCard;
\par 
\par \b applies to\cf2\b0\fs24 
\par \strike\fs20 TmsVCard\strike0\{linkID=50\}\cf0  component;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 procedure Clear;\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Clears all fields of \cf2\strike TmsVCard\strike0\{linkID=50\}\cf0  component instance\cf2\fs0 
\par 
\par }
90
Assign_method
Assign method
Assign method



Imported



FALSE
16
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 Assign method\cf2\fs0 
\par \cf0\b\fs20 unit\cf2\b0\fs24 
\par \cf0\fs20 msVCard;
\par 
\par \b applies to\cf2\b0\fs24 
\par \strike\fs20 TmsVCard\strike0\{linkID=50\}\cf0  component;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 procedure Assign(Value : TPersistent); override;\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 You can use this method to assign to the instance of \cf2\strike TmsVCard\strike0\{linkID=50\}\cf0  component another instance of the component.  If you are trying to assign another descendant of TPersistent, there will be an exception, generated by inherited Assign method.
\par 
\par }
100
LoadFromStream_method
LoadFromStream method
LoadFromStream method



Imported



FALSE
16
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 LoadFromStream method\cf2\fs0 
\par \cf0\b\fs20 unit\cf2\b0\fs24 
\par \cf0\fs20 msVCard;
\par 
\par \b applies to\cf2\b0\fs24 
\par \strike\fs20 TmsVCard\strike0\{linkID=50\}\cf0  component;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 procedure LoadFromStream(Stream : TStream);\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Loads the vCard object from stream and fills in the properties of \cf2\strike TmsVCard\strike0\{linkID=50\}\cf0  component.\cf2\fs0 
\par 
\par }
110
LoadFromFile_method
LoadFromFile method
LoadFromFile method



Imported



FALSE
16
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 LoadFromFile method\cf2\fs0 
\par \cf0\b\fs20 unit\cf2\b0\fs24 
\par \cf0\fs20 msVCard;
\par 
\par \b applies to\cf2\b0\fs24 
\par \strike\fs20 TmsVCard\strike0\{linkID=50\}\cf0  component;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 procedure LoadFromFile(const FileName : string);\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Loads the vCard object from the file, indicated in FileName parameter and fills in the properties of \cf2\strike TmsVCard\strike0\{linkID=50\}\cf0  component.
\par 
\par }
120
SaveToStream_method
SaveToStream method
SaveToStream method



Imported



FALSE
16
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 SaveToStream method\cf2\fs0 
\par \cf0\b\fs20 unit\cf2\b0\fs24 
\par \cf0\fs20 msVCard;
\par 
\par \b applies to\cf2\b0\fs24 
\par \strike\fs20 TmsVCard\strike0\{linkID=50\}\cf0  component;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 procedure SaveToStream(Stream : TSream);\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Saves a contents if \cf2\strike TmsVCard\strike0\{linkID=50\}\cf0  component into the stream according to the standard format of vCard specifications.\cf2\fs0 
\par 
\par }
130
SaveToFile_method
SaveToFile method
SaveToFile method



Imported



FALSE
16
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 SaveToFile method\cf2\fs0 
\par \cf0\b\fs20 unit\cf2\b0\fs24 
\par \cf0\fs20 msVCard;
\par 
\par \b applies to\cf2\b0\fs24 
\par \strike\fs20 TmsVCard\strike0\{linkID=50\}\cf0  component;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 procedure SaveToFile(const FileName : string);\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Saves the contents of TmsVCard component into the file, specified in FileName parameter, according to vCard specifications.\cf2\fs0 
\par 
\par }
140
BusinessInfo_property
BusinessInfo property
BusinessInfo property



Imported



FALSE
16
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 BusinessInfo property\cf2\fs0 
\par \cf0\b\fs20 unit\cf2\b0\fs24 
\par \cf0\fs20 msVCard;
\par 
\par \b applies to\cf2\b0\fs24 
\par \strike\fs20 TmsVCard\strike0\{linkID=50\}\cf0  component;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 property BusinessInfo : \cf2\strike TmsBusinessInfo\strike0\{linkID=150\}\cf0 ;\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Contains the business related information related to the person or company associated with vCard object.  See the description of TmsBusinessInfo class for more information.
\par 
\par }
150
TmsBusinessInfo_class
TmsBusinessInfo class
TmsBusinessInfo class;TmsCompanyRec class



Imported



FALSE
23
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 TmsBusinessInfo class\cf2\fs0 
\par \cf0\b\fs20 unit\b0  msVCls;
\par 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Has three published properties: Title, Role and Company.
\par 
\par \i Title\i0  - job title, e.g. President;
\par \i Role\i0  - role in the company, e.g. Programmer;
\par 
\par \i Company\i0  property is of type \b\i TmsCompanyRec\b0\i0 , which is also declared in the unit msVCls and contains two properties:
\par Name - company name;
\par AUnit - unit of the company (we had to add A in front, because unit is a reserved word in Object pascal).
\par 
\par Example:
\par \cf2\fs0 
\par \cf0\f1\fs20 msVCard1.BusinessInfo.Title:='Sales manager';
\par msVCard1.Businessinfo.Role:='';
\par msVCard1.BusinessInfo.Company.Name:='Somecompany Ltd.';
\par msVCard1.BusinessInfo.Unit:='Sales department';
\par 
\par }
160
DeliveryInfo_property
DeliveryInfo property
DeliveryInfo property



Imported



FALSE
15
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 DeliveryInfo property\cf2\fs0 
\par \cf0\b\fs20 unit\b0  msVCard;
\par 
\par \b applies to\cf2\b0\fs24 
\par \strike\fs20 TmsVCard\strike0\{linkID=50\}\cf0  component;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 property DeliveryInfo : \cf2\strike TmsDeliveryInfo\strike0\{linkID=200\}\cf0 ;\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Contains address information for the subject associated with vCard.  Can hold two addresses.  See description of \cf2\strike TmsDeliveryInfo\strike0\{linkID=200\}\cf0  class for more information.
\par 
\par }
170
ExplanatoryInfo_property
ExplanatoryInfo property
ExplanatoryInfo property



Imported



FALSE
15
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 ExplanatoryInfo property\cf2\fs0 
\par \cf0\b\fs20 unit\b0  msVCard;
\par 
\par \b applies to\cf2\b0\fs24 
\par \strike\fs20 TmsVCard\strike0\{linkID=50\}\cf0  component;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 property ExplanatoryInfo : \cf2\strike TmsExplanatoryInfo\strike0\{linkID=230\}\cf0 ;\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Contains additional information about the subject associated with vCard, such as two URLs and additional notes.  See \cf2\strike TmsExplanatoryInfo\strike0\{linkID=230\}\cf0  class description for more information.
\par 
\par }
180
Identification_property
Identification property
Identification property



Imported



FALSE
15
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 Identification property\cf2\fs0 
\par \cf0\b\fs20 unit\b0  msVCard;
\par 
\par \b applies to\cf2\b0\fs24 
\par \strike\fs20 TmsVCard\strike0\{linkID=50\}\cf0  component;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 property Identification : \cf2\strike TmsIdentification\strike0\{linkID=240\}\cf0 ;\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Contains identification information about subject, such as name, suffix, prefix and so on.  See the description of \cf2\strike TmsIdentification\strike0\{linkID=240\}\cf0  class for more information.
\par 
\par }
190
TelecomInfo_property
TelecomInfo property
TelecomInfo property



Imported



FALSE
15
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 TelecomInfo property\cf2\fs0 
\par \cf0\b\fs20 unit\b0  msVCard;
\par 
\par \b applies to\cf2\b0\fs24 
\par \strike\fs20 TmsVCard\strike0\{linkID=50\}\cf0  component;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 property TelecomInfo : \cf2\strike TmsTelecomInfo\strike0\{linkID=250\}\cf0 ;\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Can hold three telephone numbers and two email addresses, associated with the vCard object.  See \cf2\strike TmsTelecomInfo\strike0\{linkID=250\}\cf0  class reference for more information.
\par 
\par }
200
TmsDeliveryInfo_class
TmsDeliveryInfo class
TmsDeliveryInfo class



Imported



FALSE
12
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 TmsDeliveryInfo class\cf2\fs0 
\par \cf0\b\fs20 unit\b0  msVCls;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 TmsDeliveryInfo = class(TPersistent);\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Holds two addresses - two properties, Address1 and Address2.  Each Address property is \cf2\strike TmsAddressRec\strike0\{linkID=210\}\cf0 .\cf2\fs0 
\par 
\par }
210
TmsAddressRec_class
TmsAddressRec class
TmsAddressRec class



Imported



FALSE
38
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 TmsAddressRec class\cf2\fs0 
\par \cf0\b\fs20 unit\b0  msVCls;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 TmsAddressRec = class(TPersistent);\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Contains the address information, included in the vCard object.  Contains following published properties:
\par \cf2\fs0 
\par \cf0\f1\fs20 Attributes  : \cf2\strike TmsAddressAttributes\strike0\{linkID=220\}\cf0 
\par \cf2\f0\fs24 
\par \cf0\fs20 Address attributes, such as Domestic, International, Home, Work.  See TmsAddressType reference for more information.
\par \cf2\fs0 
\par \cf0\f1\fs20 POAddress : string;
\par ExtendedAddress : string;
\par Street : string;
\par Locality : string;
\par Region : string;
\par PostalCode : string;
\par Country : string;
\par \cf2\f0\fs24 
\par \cf0\fs20 For example:
\par \cf2\fs0 
\par \cf0\f1\fs20 with msVCard1.DeliveryInfo.Address1 do
\par begin
\par   Include(Attributes,msaPostal);
\par   POAddress:='';
\par   ExtendedAddress:='';
\par   Street:='123 Anystreet, Suite 12';
\par   Locality:='Anycity';
\par   Region:='Somestate';
\par   PostalCode:='222222';
\par   Country:='Somecountry';
\par end;
\par 
\par }
220
TmsAddressAttributes_type
TmsAddressAttributes type
TmsAddressAttributes type



Imported



FALSE
13
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 TmsAddressAttributes type\cf2\fs0 
\par \cf0\b\fs20 unit\b0  msVCls;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20   TmsAddressType = (msaDomestic, msaInternational, msaPostal, msaParcel, msaHome, msaWork);
\par   TmsAddressAtrributes = set of TmsAddressType; 
\par \cf2\f0\fs24 
\par \cf0\fs20 This is a type of the Attributes of \cf2\strike TmsAddressRec\strike0\{linkID=210\}\cf0  class.  The values are self explanatory.
\par \cf2\fs0 
\par 
\par }
230
TmsExplanatoryInfo_class
TmsExplanatoryInfo class
TmsExplanatoryInfo class



Imported



FALSE
18
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 TmsExplanatoryInfo class\cf2\fs0 
\par \cf0\b\fs20 unit\b0  msVCls;
\par 
\par \b description\cf2\b0\fs24 
\par \cf0\f1\fs20 TmsExplanatoryInfo = class(TPersistent);\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 This is a type of \cf2\strike ExplanatoryInfo\strike0\{linkID=170\}\cf0  property of \cf2\strike TmsVCard\strike0\{linkID=50\}\cf0  component and contains three published fields:
\par \cf2\fs0 
\par \cf0\f1\fs20 Comment : TStrings;
\par URL1 : string;
\par URL2 : string;\cf2\f0\fs24 
\par \cf0\fs20 
\par Comments contains the additional information for the subject associated with vCard, URL1 and URL2 may include the ULRs of WWW pages where one can obtain up to date information about the subject.
\par 
\par }
240
TmsIdentification_class
TmsIdentification class
TmsIdentification class;TmsNameRec class



Imported



FALSE
39
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 TmsIdentification class\cf2\fs0 
\par \cf0\b\fs20 unit\b0  msVCls;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 TmsIdentification = class(TPersistent);\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Type of the \cf2\strike Identification\strike0\{linkID=180\}\cf0  property of \cf2\strike TmsVCard\strike0\{linkID=50\}\cf0  component.  Contains two published fields:
\par \cf2\fs0 
\par \cf0\f1\fs20 FormattedName : string;
\par Name : TmsNameRec;
\par \cf2\f0\fs24 
\par \cf0\fs20 FormattedName property contains the name of the subject as it should appear in the envelope salutations, official letters and so on.
\par 
\par \b\i TmsNameRec\b0\i0  class contains five sub properties:
\par \cf2\fs0 
\par \cf0\f1\fs20 FamilyName : string;
\par GivenName : string;
\par AdditionalNames : string;
\par Prefix : string;
\par Suffix : string;
\par \cf2\f0\fs24 
\par \cf0\fs20 Example:
\par \cf2\fs0 
\par \cf0\f1\fs20 with msVCard1.Identification do
\par begin
\par   with Name do
\par   begin
\par     FamilyName:='Doe';
\par     GivenName:='John';
\par     Preffix:='Mr.';
\par     Suffix:='Esq.';
\par   end;
\par   FormattedName:='J Doe';
\par end;\cf2\f0\fs24 
\par 
\par }
250
TmsTelecomInfo_class
TmsTelecomInfo class
TmsTelecomInfo class



Imported



FALSE
12
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 TmsTelecomInfo class\cf2\fs0 
\par \cf0\b\fs20 unit\b0  msVCls;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 TmsTelecomInfo = class(TPersistent);\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Type of \cf2\strike TelecomInfo\strike0\{linkID=190\}\cf0  property of \cf2\strike TmsVCard\strike0\{linkID=50\}\cf0  component.  Phone1, Phone2, Phone3 are of type \cf2\strike TmsPhoneRec\strike0\{linkID=260\}\cf0  and are holding the information about three phone numbers, Email1 and Email2 are of type \cf2\strike TmsEmailRec\strike0\{linkID=270\}\cf0  and contain the information about three email addresses.
\par 
\par }
260
TmsPhoneRec_class
TmsPhoneRec class
TmsPhoneAttributes type;TmsPhoneRec class;TmsPhoneType type



Imported



FALSE
37
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 TmsPhoneRec class\cf2\fs0 
\par \cf0\b\fs20 unit\b0  msVCls;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 TmsPhoneRec = class(TPersistent)\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 Contains the information about phone numbers.  Has two published properties:
\par \cf2\fs0 
\par \cf0\f1\fs20 Attributes : TmsPhoneAttributes;
\par Number : string;
\par \cf2\f0\fs24 
\par \cf0\fs20 Number property contains the phone number itself, Attributes are indicating the type of phone numbers.
\par 
\par \b\i TmsPhoneAttributes\b0\i0  is declared as:
\par \cf2\fs0 
\par \cf0\f1\fs20 TmsPhoneAttributes = set of TmsPhoneType;\cf2\f0\fs24 
\par \cf0\fs20 
\par where \b\i TmsPhoneType\b0\i0  is:
\par \cf2\fs0 
\par \cf0\f1\fs20 TmsPhoneType = (mstPreferred, mstWork, mstHome, mstVoice, mstFax, mstMessaging, mstCellular, mstPager, mstBBS, mstModem, mstCar, mstISDN, mstVideo);
\par \cf2\f0\fs24 
\par \cf0\fs20 You can set the the elements of the Attributes set to indicate the character of the phone number.
\par 
\par Example:
\par \cf2\fs0 
\par \cf0\f1\fs20 with msVCard1.TelecomInfo.Phone1 do
\par begin
\par   Attributes:=[mstPreferred, mstVoice, mstMessaging];
\par   Number:='+1-416-231-2222';
\par end;
\par \cf2\f0\fs24 
\par \cf0\fs20 The above example indicates that the phone number is a preferred one, and is voice and has massaging service.
\par 
\par }
270
TmsEmailRec_class
TmsEmailRec class
TmsEmailRec class;TmsEmailType type



Imported



FALSE
31
{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss Arial;}{\f1\fmodern Courier New;}}
{\colortbl ;\red0\green0\blue255;\red0\green0\blue0;}
\viewkind4\uc1\pard\cf1\lang1040\f0\fs36 TmsEmailRec class\cf2\fs0 
\par \cf0\b\fs20 unit\b0  msVCls;
\par 
\par \b declaration\cf2\b0\fs24 
\par \cf0\f1\fs20 TmsEmailRec = class(TPersistent);\cf2\f0\fs24 
\par \cf0\fs20 
\par \b description\cf2\b0\fs24 
\par \cf0\fs20 The used in \cf2\strike TelecomInfo\strike0\{linkID=190\}\cf0  property of \cf2\strike TmsVCard\strike0\{linkID=50\}\cf0  component.  Contains the information about an email address.  Has two published properties:
\par \cf2\fs0 
\par \cf0\f1\fs20 EmailType : TmsEmailType;
\par Address : string;
\par \cf2\f0\fs24 
\par \cf0\fs20 Address contains the email address itself.
\par 
\par TmsEmailType is declared as:
\par \cf2\fs0 
\par \cf0\f1\fs20 TmsEmailType = (mseDefault, mseAOL, mseAppleLink, mseATTMail, mseCompuserve, mseInternet, mseIBM, mseMCI, msePowerShare, mseProdigy, mseTelex, mseX400);
\par \cf2\f0\fs24 
\par \cf0\fs20 And shows the kind of email address.  Default is Internet.
\par 
\par Example:
\par \cf2\fs0 
\par \cf0\f1\fs20 with msVCard1.TelecomInfo.Email1 do
\par begin
\par   EmailType:=mseInternet;
\par   Address:='jdoe@domain.com';
\par end;\cf2\f0\fs24 
\par 
\par }
1
main="",,,,
0
0
0
6
*InternetLink
16711680
Courier New
0
10
1
....
0
0
0
0
0
0
*ParagraphTitle
-16777208
Arial
0
11
1
B...
0
0
0
0
0
0
*PopupLink
-16777208
Arial
0
8
1
....
0
0
0
0
0
0
*PopupTopicTitle
16711680
Arial
0
10
1
B...
0
0
0
0
0
0
*TopicText
-16777208
Arial
0
10
1
....
0
0
0
0
0
0
*TopicTitle
16711680
Arial
0
16
1
B...
0
0
0
0
0
0

; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Ecom_en"
#define MyAppVersion "2020.1.18"
#define MyAppPublisher "MLSoft"
#define MyAppURL "manlio.laschena@gmail.com"
#define MyAppExeName "Ecom.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{5C8EE223-5BAE-4A7F-8D51-0BA90B27DEF8}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2014\ecom\En_ver\Disk_en\Readme.txt
InfoBeforeFile=C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2014\ecom\En_ver\Disk_en\Readme.txt
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2014\ecom\En_ver
OutputBaseFilename=ecom_en
SetupIconFile=C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2014\ecom\Ecom_Icon1.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2014\ecom\En_ver\Disk_en\Ecom.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2014\ecom\En_ver\Disk_en\DBManager.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2014\ecom\En_ver\Disk_en\ecom.abs"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2014\ecom\En_ver\Disk_en\Readme.txt"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent


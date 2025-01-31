; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Diesel4"
#define MyAppVersion "4"
#define MyAppPublisher "MLSoft"
#define MyAppExeName "Diesel4.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{1F3B2B6E-9223-4444-B0CE-3FC50A3F3C76}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; The [Icons] "quicklaunchicon" entry uses {userappdata} but its [Tasks] entry has a proper IsAdminInstallMode Check.
UsedUserAreasWarning=no
LicenseFile=C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2017\Diesel4\install\Readme.txt
InfoAfterFile=C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2017\Diesel4\install\Note.txt
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2017\Diesel4\install
OutputBaseFilename=Diese4Setup
SetupIconFile=C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2017\Diesel4\install\ML17_2.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 6.1; Check: not IsAdminInstallMode

[Files]
Source: "C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2017\Diesel4\install\Diesel4.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2017\Diesel4\install\Diesel.chm"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2017\Diesel4\install\diesel.ini"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2017\Diesel4\install\DieselDB.ABS"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2017\Diesel4\install\ML17_2.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2017\Diesel4\install\Note.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio_Laschena\Documents\RAD Studio\Projects\2017\Diesel4\install\Readme.txt"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent


; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Corbi"
#define MyAppVersion "6.8.10.1310"
#define MyAppPublisher "MLSoft 2016"
#define MyAppExeName "Corbi.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{4B7D4709-3AAC-4788-AC34-7DFC60FB2A3F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
LicenseFile=C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2015\corbi\Readme.txt
OutputBaseFilename=setup_Corbi6810
SetupIconFile=C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2015\corbi\ML15.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2015\corbi\Corbi.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2015\corbi\ML15.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2015\corbi\corbi.ABS"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2015\corbi\DBManager.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2015\corbi\Help\Corbi.chm"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent


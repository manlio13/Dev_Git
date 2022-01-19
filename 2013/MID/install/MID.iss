; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "MID"
#define MyAppVersion "1.0"
#define MyAppPublisher "MLSoft"
#define MyAppExeName "MID.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{3690B691-3BA1-4ACB-85EF-BB5EAD59965F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
LicenseFile=C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2013\MID\Disk\Readme.txt
OutputDir=C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2013\MID\install
OutputBaseFilename=setup_MID01
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2013\MID\Disk\MID.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2013\MID\Disk\MID.abs"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2013\MID\Disk\DBManager.exe"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent


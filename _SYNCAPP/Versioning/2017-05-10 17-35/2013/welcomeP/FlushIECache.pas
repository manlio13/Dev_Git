unit FlushIECache;

interface
procedure Register;

implementation

uses Windows,WinInet;


procedure PreemptFileRemoval;
var
  BaseURL: string;
  CacheLocation : string;
  BufSize: Integer;
  CacheEntry: PInternetCacheEntryInfo;
begin
    CacheEntry := nil;
    BaseURL := 'bds:/xsl/languageStrings.xsl';
    BufSize := 0;
    if not GetUrlCacheEntryInfoEx(PChar(BaseURL), nil, @BufSize, nil, nil, nil, 0) and
      (GetLastError = ERROR_INSUFFICIENT_BUFFER) then
    begin
      CacheEntry := AllocMem(BufSize);
      try
      if not GetURLCacheEntryInfoEx(PChar(BaseURL), CacheEntry, @BufSize, nil, nil, nil, 0) and
        (GetLastError <> ERROR_INSUFFICIENT_BUFFER) then  Exit;
        if CacheEntry <> nil then
        begin
          CacheLocation := 'Deleting... ' + CacheEntry.lpszLocalFileName;
          Outputdebugstring(PChar(CacheLocation));
          DeleteUrlCacheEntry(PChar(BaseURL));
        end;
      finally
          if CacheEntry <> nil then Freemem(CacheEntry);
      end;
    end;
end;

procedure Register;
begin
  PreemptFileRemoval;
end;

initialization
finalization
  PreemptFileRemoval;
end.

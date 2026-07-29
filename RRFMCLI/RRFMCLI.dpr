program RRFMCLI;

{$APPTYPE CONSOLE}

{$R *.res}

uses
   System.SysUtils, System.IOUtils,
   Winapi.Windows;

const ver='v1.0.20260729';

//-------------------------------------------------------------------------------------------------
// Display Usage
procedure DisplayUsage;
begin
   WriteLn('RRFMCLI /UF /source:<sourcefile> /search:<searchpath>');
   WriteLn('/UF - Update files');
   WriteLn('/source:<sourcefile> - Specify the source file (path included)');
   WriteLn('/search:<searchpath> - Specify the search path');
end;

//-------------------------------------------------------------------------------------------------
// Search and Replace
procedure SearchAndReplace(const sourceFile, searchPath: string; out replacedCount: Integer);
var
   targetName: string;
   sourceFull: string;
   files: TArray<string>;
   f: string;
begin
   replacedCount := 0;

   targetName:=ExtractFileName(sourceFile);
   sourceFull:=TPath.GetFullPath(sourceFile);

   files:=TDirectory.GetFiles(searchPath, targetName,  TSearchOption.soAllDirectories);

   for f in files do
   begin
      // Skip the source file
      if SameText(TPath.GetFullPath(f), sourceFull) then
         Continue;

      try
         TFile.Copy(sourceFile, f, True); // True = overwrite
         Inc(replacedCount);
         WriteLn('#', replacedCount, ': ', f);
      except
         on E: Exception do
            WriteLn('Failed to replace ', f, ': ', E.Message);
      end;
   end;
end;

//-------------------------------------------------------------------------------------------------
// main procedure
var
   sourceFile: String;
   searchPath: String;
   p2, p3:     String;
   replacedCount: Integer;
begin
   // Set CodePage = UTF8 ~ allow printing of special chars
   // Default CodePage = CP437
   SetConsoleOutputCP(CP_UTF8);
   WriteLn;
   WriteLn('RRFMCLI '+ver);
   WriteLn('   '+Chr(169)+' 2026 Remus Rigo');
   WriteLn;

   if ParamCount = 0 then
       DisplayUsage;

   if ParamCount = 1 then
   begin
       if UpperCase(ParamStr(1))='/H' then
          DisplayUsage;
   end;

   if ParamCount = 3 then
   begin
      p2:=ParamStr(2);
      p3:=ParamStr(3);
      if UpperCase(ParamStr(1))='/UF' then
      begin
         if p2.StartsWith('/source:', True) then
            sourceFile:=Copy(p2, Length('/source:') + 1, MaxInt);
         if p3.StartsWith('/search:', True) then
            searchPath:=Copy(p3, Length('/search:') + 1, MaxInt);

         if not TFile.Exists(sourceFile) then
         begin
            WriteLn('Source file not found: ', sourceFile);
            Exit;
         end;

         if not TDirectory.Exists(searchPath) then
         begin
            WriteLn('Search path not found: ', searchPath);
            Exit;
         end;

         SearchAndReplace(sourceFile, searchPath, replacedCount);
         WriteLn;
         WriteLn('Total files updated: ', replacedCount);
      end;
   end;
end.

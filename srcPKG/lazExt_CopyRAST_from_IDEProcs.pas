unit lazExt_CopyRAST_from_IDEProcs;

{$mode objfpc}{$H+}

interface

uses LazFileUtils,LazFileCache, FileUtil,
  Classes, SysUtils;


//!!! начинать с NextStartPos=1
function GetNextDirectoryInSearchPath(const SearchPath: string; var NextStartPos: integer): string;
function FilenameIsPascalSource8HasResources(const Filename:string): boolean;


implementation

function GetNextDirectoryInSearchPath(const SearchPath: string;
                                      var NextStartPos: integer): string;
var
  PathLen: Integer;
  CurStartPos: Integer;
begin
  PathLen:=length(SearchPath);
  if PathLen>0 then begin
    repeat
      while (NextStartPos<=PathLen)
      and (SearchPath[NextStartPos] in [';',#0..#32]) do
        inc(NextStartPos);
      CurStartPos:=NextStartPos;
      while (NextStartPos<=PathLen) and (SearchPath[NextStartPos]<>';') do
        inc(NextStartPos);
      Result:=TrimFilename(copy(SearchPath,CurStartPos,NextStartPos-CurStartPos));
      if Result<>'' then exit;
    until (NextStartPos>PathLen);
  end else begin
    NextStartPos:=1;
  end;
  Result:='';
end;


function FilenameIsFormText(const Filename: string): boolean;
var Ext: string;
begin
  Ext:=lowercase(ExtractFileExt(Filename));
  Result:=((Ext='.lfm') or (Ext='.dfm') or (Ext='.xfm'))
          and (ExtractFileNameOnly(Filename)<>'');
end;


{function FilenameIsPascalSource(const Filename: string): boolean;
var Ext: string;
  p: Integer;
  AnUnitName: String;
begin
  AnUnitName:=ExtractFileNameOnly(Filename);
  if (AnUnitName='') or (not IsValidIdent(AnUnitName)) then
    exit(false);
  Ext:=lowercase(ExtractFileExt(Filename));
  for p:=Low(PascalFileExt) to High(PascalFileExt) do
    if Ext=PascalFileExt[p] then
      exit(true);
  Result:=(Ext='.lpr') or (Ext='.dpr') or (Ext='.dpk');
end; }


function FilenameIsPascalSource8HasResources(const Filename:string): boolean;
begin
    result:=FilenameIsPascalUnit(Filename) AND
            FileExistsCached(ChangeFileExt(Filename,'.lfm'));
end;

end.


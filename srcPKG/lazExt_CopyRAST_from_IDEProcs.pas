unit lazExt_CopyRAST_from_IDEProcs;

{$mode objfpc}{$H+}

interface

uses LazFileUtils,
  Classes, SysUtils;


//!!! начинать с NextStartPos=1
function GetNextDirectoryInSearchPath(const SearchPath: string; var NextStartPos: integer): string;

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


end.


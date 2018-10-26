unit lazExt_CopyRAST_fileSystemFNKs;

{$mode objfpc}{$H+}

interface

uses
  FileUtil,
  LazFileUtils;


function copyRast_fsFnk_DirectoryExists(const DirectoryName:string):boolean;
function copyRast_fsFnk_DirectoryDelete(const DirectoryName:string; const OnlyChildren:boolean):boolean;
function copyRast_fsFnk_DirectoryForce (const DirectoryName:string):boolean;
function copyRast_fsFnk_CopyFile(const SrcFilename, DestFilename: string; Flags: TCopyFileFlags=[cffOverwriteFile]; ExceptionOnError: Boolean=False): boolean;




implementation

function copyRast_fsFnk_DirectoryExists(const DirectoryName:string):boolean;
begin
    result:=DirPathExists(DirectoryName);
end;

function copyRast_fsFnk_DirectoryDelete(const DirectoryName:string; const OnlyChildren:boolean):boolean;
begin
    result:=DeleteDirectory(DirectoryName,OnlyChildren);
end;

function copyRast_fsFnk_DirectoryForce(const DirectoryName:string):boolean;
begin
    result:=ForceDirectory(DirectoryName);
end;

function copyRast_fsFnk_CopyFile(const SrcFilename, DestFilename: string; Flags: TCopyFileFlags=[cffOverwriteFile]; ExceptionOnError: Boolean=False): boolean;
begin
    result:=CopyFile( SrcFilename,DestFilename, Flags, ExceptionOnError);
end;

end.


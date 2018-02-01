unit uTST_000_srcTree_fsFNK_xxx;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  //---
  Classes, SysUtils, fpcunit, testregistry;


type

 tTST_srcTree__fsFNK__absPATH=class(TTestCase)
  published
    procedure AppConfigDir_Global;
    procedure AppConfigDir_Local;
    procedure TempDir_Global;
    procedure TempDir_Local;
  end;

 tTST_srcTree__fsFNK__relPATH=class(TTestCase)
  published
    procedure Test_Single;
    procedure Test_Dotted;
  end;

 tTST_srcTree__fsFNK__FirstDIR=class(TTestCase)
  published
    procedure Test;
  end;


implementation

procedure tTST_srcTree__fsFNK__absPATH.AppConfigDir_Global;
var tmpPath:string;
begin
    tmpPath:=srcTree_fsFnk_ChompPathDelim(GetAppConfigDir(TRUE));
    Assert(srcTree_fsFnk_pathIsAbsolute(tmpPath),'Path "'+tmpPath+'" must by ABSOLUTE');
end;

procedure tTST_srcTree__fsFNK__absPATH.AppConfigDir_Local;
var tmpPath:string;
begin
    tmpPath:=srcTree_fsFnk_ChompPathDelim(GetAppConfigDir(FALSE));
    Assert(srcTree_fsFnk_pathIsAbsolute(tmpPath),'Path "'+tmpPath+'" must by ABSOLUTE');
end;

procedure tTST_srcTree__fsFNK__absPATH.TempDir_Global;
var tmpPath:string;
begin
    tmpPath:=srcTree_fsFnk_ChompPathDelim(GetTempDir(TRUE));
    Assert(srcTree_fsFnk_pathIsAbsolute(tmpPath),'Path "'+tmpPath+'" must by ABSOLUTE');
end;

procedure tTST_srcTree__fsFNK__absPATH.TempDir_Local;
var tmpPath:string;
begin
    tmpPath:=srcTree_fsFnk_ChompPathDelim(GetTempDir(FALSE));
    Assert(srcTree_fsFnk_pathIsAbsolute(tmpPath),'Path "'+tmpPath+'" must by ABSOLUTE');
end;

//==============================================================================

procedure tTST_srcTree__fsFNK__relPATH.Test_Single;
var tmpPathBase:string;
    tmpPathNext:string;
    tmpPath    :string;
begin
    tmpPathBase:=srcTree_fsFnk_ExtractFileDir(GetAppConfigFile(true,false));
    tmpPathNext:=tmpPathBase;
    tmpPathNext:=srcTree_fsFnk_ConcatPaths(tmpPathNext,'A');
    tmpPathNext:=srcTree_fsFnk_ConcatPaths(tmpPathNext,'B');
    // СОЗДАЕМ относительный путь
    tmpPath:=srcTree_fsFnk_CreateRelativePath(tmpPathNext,tmpPathBase);
    Assert(srcTree_fsFnk_pathIsRelative(tmpPath),'Path "'+tmpPath+'" must by ABSOLUTE');
end;

procedure tTST_srcTree__fsFNK__relPATH.Test_Dotted;
var tmpPathBase:string;
    tmpPathNext:string;
    tmpPath    :string;
begin
    tmpPathBase:=srcTree_fsFnk_ExtractFileDir(GetAppConfigFile(true,false));
    tmpPathNext:=tmpPathBase;
    //
    tmpPathBase:=srcTree_fsFnk_ConcatPaths(tmpPathBase,'A');
    tmpPathBase:=srcTree_fsFnk_ConcatPaths(tmpPathBase,'B');
    //
    tmpPathNext:=srcTree_fsFnk_ConcatPaths(tmpPathNext,'A');
    tmpPathNext:=srcTree_fsFnk_ConcatPaths(tmpPathNext,'C');
    // СОЗДАЕМ относительный путь
    tmpPath:=srcTree_fsFnk_CreateRelativePath(tmpPathNext,tmpPathBase);
    Assert(srcTree_fsFnk_pathIsRelative(tmpPath),'Path "'+tmpPath+'" must by ABSOLUTE');
end;

//==============================================================================

procedure tTST_srcTree__fsFNK__FirstDIR.Test;
var tmpPath:string;

    tmpName:string;
    tmpDriv:string;

    resPath:string;
begin
    tmpPath:=srcTree_fsFnk_ChompPathDelim(GetTempDir(TRUE));
    //---
    resPath:=srcTree_fsFnk_ExtractFirstDIR(tmpPath);
    //---
    tmpName:=ExtractFileName (resPath);
    tmpDriv:=ExtractFileDrive(resPath);
    //
    tmpPath:=srcTree_fsFnk_ConcatPaths(tmpDriv,tmpName);
    Assert(tmpPath=resPath);
end;

//==============================================================================

initialization
    RegisterTest('srcTree_fsFNK',tTST_srcTree__fsFNK__absPATH);
    RegisterTest('srcTree_fsFNK',tTST_srcTree__fsFNK__relPATH);
    RegisterTest('srcTree_fsFNK',tTST_srcTree__fsFNK__FirstDIR);
end.


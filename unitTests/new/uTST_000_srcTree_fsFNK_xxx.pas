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
  protected
    function _farWay_:string;
    function _dirStr_:string;

  published
    procedure relative_FLDR_nill;
    procedure relative_FLDR_short;
    procedure relative_FLDR_long;
  published
    procedure absolute_FLDR_nill;
    procedure absolute_FLDR_nErr;
    procedure absolute_FLDR_short;
    procedure absolute_FLDR_long;
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

function tTST_srcTree__fsFNK__FirstDIR._dirStr_:string;
begin
    result:=srcTree_fsFnk_ExtractFileDrive(GetTempDir);
end;

function tTST_srcTree__fsFNK__FirstDIR._farWay_:string;
begin
    result:='';
    result:=srcTree_fsFnk_ConcatPaths(result,'mega');
    result:=srcTree_fsFnk_ConcatPaths(result,'super');
    result:=srcTree_fsFnk_ConcatPaths(result,'long');
    result:=srcTree_fsFnk_ConcatPaths(result,'file');
    result:=srcTree_fsFnk_ConcatPaths(result,'path');
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tTST_srcTree__fsFNK__FirstDIR.relative_FLDR_nill;
var srcFD:string;
    testF:string;
    resFD:string;
begin // test ""
    srcFD:='';
    testF:=srcFD;
    //
    resFD:=srcTree_fsFnk_ExtractFirstDIR(testF);
    AssertEquals('"'+testF+'" wrong result',srcFD,resFD);
end;

procedure tTST_srcTree__fsFNK__FirstDIR.relative_FLDR_short;
var srcFD:string;
    testF:string;
    resFD:string;
begin // test "A"
    srcFD:='A';
    testF:=srcFD;
    //
    resFD:=srcTree_fsFnk_ExtractFirstDIR(testF);
    AssertEquals('"'+testF+'" wrong result',srcFD,resFD);
end;

procedure tTST_srcTree__fsFNK__FirstDIR.relative_FLDR_long;
var srcFD:string;
    testF:string;
    resFD:string;
begin // test "A\..\.."
    srcFD:='A';
    testF:=srcTree_fsFnk_ConcatPaths(srcFD,_farWay_);
    //
    resFD:=srcTree_fsFnk_ExtractFirstDIR(testF);
    AssertEquals('"'+testF+'" wrong result',srcFD,resFD);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tTST_srcTree__fsFNK__FirstDIR.absolute_FLDR_nill;
var srcFD:string;
    testF:string;
    resFD:string;
begin // test "C:"
    srcFD:='';
    testF:=srcTree_fsFnk_ConcatPaths(_dirStr_,srcFD);
    //
    resFD:=srcTree_fsFnk_ExtractFirstDIR(testF);
    AssertEquals('"'+testF+'" wrong result',srcFD,resFD);
end;

procedure tTST_srcTree__fsFNK__FirstDIR.absolute_FLDR_nErr;
var srcFD:string;
    testF:string;
    resFD:string;
begin // test "C:\"
    srcFD:='';
    testF:=srcTree_fsFnk_ConcatPaths(_dirStr_,srcFD);
    testF:=srcTree_fsFnk_AppendPathDelim(testF);
    //
    resFD:=srcTree_fsFnk_ExtractFirstDIR(testF);
    AssertEquals('"'+testF+'" wrong result',srcFD,resFD);
end;

procedure tTST_srcTree__fsFNK__FirstDIR.absolute_FLDR_short;
var srcFD:string;
    testF:string;
    resFD:string;
begin // test "C:\A"
    srcFD:='A';
    testF:=srcTree_fsFnk_ConcatPaths(_dirStr_,srcFD);
    testF:=srcTree_fsFnk_AppendPathDelim(testF);
    //
    resFD:=srcTree_fsFnk_ExtractFirstDIR(testF);
    AssertEquals('"'+testF+'" wrong result',srcFD,resFD);
end;

procedure tTST_srcTree__fsFNK__FirstDIR.absolute_FLDR_long;
var srcFD:string;
    testF:string;
    resFD:string;
begin // test "C:\A"
    srcFD:='A';
    testF:=srcTree_fsFnk_ConcatPaths(_dirStr_,srcFD);
    testF:=srcTree_fsFnk_ConcatPaths(srcFD,_farWay_);
    testF:=srcTree_fsFnk_AppendPathDelim(testF);
    //
    resFD:=srcTree_fsFnk_ExtractFirstDIR(testF);
    AssertEquals('"'+testF+'" wrong result',srcFD,resFD);
end;

//==============================================================================

initialization
    RegisterTest('srcTree_fsFNK',tTST_srcTree__fsFNK__absPATH);
    RegisterTest('srcTree_fsFNK',tTST_srcTree__fsFNK__relPATH);
    RegisterTest('srcTree_fsFNK',tTST_srcTree__fsFNK__FirstDIR);
end.


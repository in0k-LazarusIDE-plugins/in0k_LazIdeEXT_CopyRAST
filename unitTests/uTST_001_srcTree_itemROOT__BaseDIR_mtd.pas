unit uTST_001_srcTree_itemROOT__BaseDIR_mtd;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_item_CORE,
  in0k_lazIdeSRC_srcTree_item_coreFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_FNK_fndBaseDIR,
  in0k_lazIdeSRC_srcTree_FNK_getBaseDIR,
  in0k_lazIdeSRC_srcTree_FNK_setBaseDIR,
  //---
  in0k_lazIdeSRC_srcTree_coreFileSystemFNK,
  //---
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

 tUTST_srcTree_itemROOT__BaseDIR_mtd=class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  protected
    function _CRT_(const BaseDIR_PATH:string):tSrcTree_BASE;
  published
    procedure FND;
    procedure GET;
  published
    procedure GET_FND;
  published
    procedure SET_FND;
    procedure SET_GET;
  end;

implementation

procedure tUTST_srcTree_itemROOT__BaseDIR_mtd.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');
end;

procedure tUTST_srcTree_itemROOT__BaseDIR_mtd.TearDown;
begin
    ROOT.FREE;
end;

//------------------------------------------------------------------------------

function tUTST_srcTree_itemROOT__BaseDIR_mtd._CRT_(const BaseDIR_PATH:string):tSrcTree_BASE;
begin
    result:= tSrcTree_BASE.Create(srcTree_fsFnk_ChompPathDelim(BaseDIR_PATH));
end;

//==============================================================================

procedure tUTST_srcTree_itemROOT__BaseDIR_mtd.FND;
var baseDir:tSrcTree_item;
begin
    baseDir:=SrcTree_fndBaseDIR(ROOT);
    AssertNull('`baseDir` MUST be nil',baseDir);
end;

procedure tUTST_srcTree_itemROOT__BaseDIR_mtd.GET;
var baseDir:tSrcTree_item;
begin
    baseDir:=SrcTree_getBaseDIR(ROOT,@_CRT_);
    AssertNotNull('`baseDir` must be NOT nil',baseDir);
    AssertSame   ('`baseDir.parent` must be ROOT',baseDir.ItemPRNT,ROOT);
end;

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__BaseDIR_mtd.GET_FND;
var baseDir0:tSrcTree_item;
var baseDir1:tSrcTree_item;
begin
    baseDir0:=SrcTree_getBaseDIR(ROOT,@_CRT_);
    baseDir1:=SrcTree_fndBaseDIR(ROOT);
    AssertSame('must be EQUAL',baseDir0,baseDir1);
end;

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__BaseDIR_mtd.SET_FND;
var baseDir:tSrcTree_item;
begin
    SrcTree_setBaseDIR(ROOT,GetTempDir,@_CRT_);
    //---
    baseDir:=SrcTree_fndBaseDIR(ROOT);
    AssertNotNull('`baseDir` must be NOT nil',baseDir);
    AssertSame   ('`baseDir.parent` must be ROOT',baseDir.ItemPRNT,ROOT);
end;

procedure tUTST_srcTree_itemROOT__BaseDIR_mtd.SET_GET;
var baseDir:tSrcTree_item;
begin
    SrcTree_setBaseDIR(ROOT,GetTempDir,@_CRT_);
    //---
    baseDir:=SrcTree_getBaseDIR(ROOT);
    AssertNotNull('`baseDir` must be NOT nil',baseDir);
    AssertSame   ('`baseDir.parent` must be ROOT',baseDir.ItemPRNT,ROOT);
end;

//==============================================================================

initialization
    RegisterTest(tUTST_srcTree_itemROOT__BaseDIR_mtd);
end.

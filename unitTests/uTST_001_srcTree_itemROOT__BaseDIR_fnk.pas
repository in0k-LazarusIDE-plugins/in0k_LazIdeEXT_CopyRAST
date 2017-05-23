unit uTST_001_srcTree_itemROOT__BaseDIR_fnk;

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
  Classes, SysUtils, fpcunit, testregistry;

type

 tUTST_srcTree_itemROOT__BaseDIR_fnk=class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
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

procedure tUTST_srcTree_itemROOT__BaseDIR_fnk.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');
end;

procedure tUTST_srcTree_itemROOT__BaseDIR_fnk.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================

procedure tUTST_srcTree_itemROOT__BaseDIR_fnk.FND;
var baseDir:tSrcTree_item;
begin
    baseDir:=SrcTree_fndBaseDIR(ROOT);
    AssertNull('`baseDir` MUST be nil',baseDir);
end;

procedure tUTST_srcTree_itemROOT__BaseDIR_fnk.GET;
var baseDir:tSrcTree_item;
begin
    baseDir:=SrcTree_getBaseDIR(ROOT);
    AssertNotNull('`baseDir` must be NOT nil',baseDir);
    AssertSame   ('`baseDir.parent` must be ROOT',baseDir.ItemPRNT,ROOT);
end;

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__BaseDIR_fnk.GET_FND;
var baseDir0:tSrcTree_item;
var baseDir1:tSrcTree_item;
begin
    baseDir0:=SrcTree_getBaseDIR(ROOT);
    baseDir1:=SrcTree_fndBaseDIR(ROOT);
    AssertSame('must be EQUAL',baseDir0,baseDir1);
end;

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__BaseDIR_fnk.SET_FND;
var baseDir:tSrcTree_item;
begin
    SrcTree_setBaseDIR(ROOT,GetTempDir);
    //---
    baseDir:=SrcTree_fndBaseDIR(ROOT);
    AssertNotNull('`baseDir` must be NOT nil',baseDir);
    AssertSame   ('`baseDir.parent` must be ROOT',baseDir.ItemPRNT,ROOT);
end;

procedure tUTST_srcTree_itemROOT__BaseDIR_fnk.SET_GET;
var baseDir:tSrcTree_item;
begin
    SrcTree_setBaseDIR(ROOT,GetTempDir);
    //---
    baseDir:=SrcTree_getBaseDIR(ROOT);
    AssertNotNull('`baseDir` must be NOT nil',baseDir);
    AssertSame   ('`baseDir.parent` must be ROOT',baseDir.ItemPRNT,ROOT);
end;

//==============================================================================

initialization
    RegisterTest(tUTST_srcTree_itemROOT__BaseDIR_fnk);
end.


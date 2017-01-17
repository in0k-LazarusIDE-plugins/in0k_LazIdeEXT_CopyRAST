unit uTST_001_srcTree_itemROOT__BaseDIR;

{$mode objfpc}{$H+}

interface

uses
  srcTree_item_CORE,
  srcTree_item_coreROOT,
  srcTree_item_coreFileSystem,
  //---
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

 tUTST_srcTree_itemROOT__BaseDIR=class(TTestCase)
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

procedure tUTST_srcTree_itemROOT__BaseDIR.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');
end;

procedure tUTST_srcTree_itemROOT__BaseDIR.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================

procedure tUTST_srcTree_itemROOT__BaseDIR.FND;
var baseDir:tSrcTree_item;
begin
    baseDir:=SrcTreeROOT_fnd_BaseDIR(ROOT);
    AssertNull('`baseDir` MUST be nil',baseDir);
end;

procedure tUTST_srcTree_itemROOT__BaseDIR.GET;
var baseDir:tSrcTree_item;
begin
    baseDir:=SrcTreeROOT_get_BaseDIR(ROOT);
    AssertNotNull('`baseDir` must be NOT nil',baseDir);
    AssertSame   ('`baseDir.parent` must be ROOT',baseDir.ItemPRNT,ROOT);
end;

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__BaseDIR.GET_FND;
var baseDir0:tSrcTree_item;
var baseDir1:tSrcTree_item;
begin
    baseDir0:=SrcTreeROOT_get_BaseDIR(ROOT);
    baseDir1:=SrcTreeROOT_fnd_BaseDIR(ROOT);
    AssertSame('must be EQUAL',baseDir0,baseDir1);
end;

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__BaseDIR.SET_FND;
var baseDir:tSrcTree_item;
begin
    SrcTreeROOT_set_BaseDIR(ROOT,GetTempDir);
    //---
    baseDir:=SrcTreeROOT_fnd_BaseDIR(ROOT);
    AssertNotNull('`baseDir` must be NOT nil',baseDir);
    AssertSame   ('`baseDir.parent` must be ROOT',baseDir.ItemPRNT,ROOT);
end;

procedure tUTST_srcTree_itemROOT__BaseDIR.SET_GET;
var baseDir:tSrcTree_item;
begin
    SrcTreeROOT_set_BaseDIR(ROOT,GetTempDir);
    //---
    baseDir:=SrcTreeROOT_get_BaseDIR(ROOT);
    AssertNotNull('`baseDir` must be NOT nil',baseDir);
    AssertSame   ('`baseDir.parent` must be ROOT',baseDir.ItemPRNT,ROOT);
end;

//==============================================================================

initialization
    RegisterTest(tUTST_srcTree_itemROOT__BaseDIR);
end.


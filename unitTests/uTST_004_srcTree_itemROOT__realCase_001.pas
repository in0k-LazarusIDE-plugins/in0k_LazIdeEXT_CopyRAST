unit uTST_004_srcTree_itemROOT__realCase_001;

{$mode objfpc}{$H+}

interface

uses srcTree_item_coreROOT,
     srcTree_item_coreFileSystem,
     srcTree_item_fsFolder,
     srcTree_FNC,
     in0k_srcTree_getRelPATH,
     in0k_srcTree_setBaseDIR,
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

 tUTST_srcTree_itemROOT__realCase_001=class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Test;
//    procedure baseDIR_is_Present;
  end;

implementation

procedure tUTST_srcTree_itemROOT__realCase_001.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');       //< собсно создаем
    SrcTree_setBaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
end;

procedure tUTST_srcTree_itemROOT__realCase_001.TearDown;
begin
    ROOT.FREE;
end;

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__realCase_001.Test;
var fldr:tSrcTree_item_fsNodeFLDR;
begin
    SrcTree_getRelPATH(root,'srcPKG');
    SrcTree_getRelPATH(root,'srcPKG\srcTree');
    SrcTree_getRelPATH(root,'srcPKG\srcTree\Items\CORE');
    SrcTree_getRelPATH(root,'srcPKG\srcTree\Items');
    SrcTree_getRelPATH(root,'srcPKG\UI\cmp');
    SrcTree_getRelPATH(root,'srcPKG\Forms');
    SrcTree_getRelPATH(root,'srcPKG\Nodes');
    SrcTree_getRelPATH(root,'srcPKG\OperationNODEs\Processing_ProjPack');
    SrcTree_getRelPATH(root,'srcEXT\in0k-lazarusIdeSRC-wndDEBUG');
    SrcTree_getRelPATH(root,'srcEXT\in0k-lazarusIdeSRC-FuckUpForm');
    SrcTree_getRelPATH(root,'srcEXT\in0k-lazarusIdeSRC-ExpertCORE');
    SrcTree_getRelPATH(root,'srcPKG');
    SrcTree_getRelPATH(root,'srcPKG');
    //---
    fldr:=SrcTreeROOT_fnd_relPATH(root,'srcPKG\UI\cmp');
    //---
    AssertNotNull('`fldr` is NIL',fldr);

end;

initialization
    RegisterTest(tUTST_srcTree_itemROOT__realCase_001);

end.


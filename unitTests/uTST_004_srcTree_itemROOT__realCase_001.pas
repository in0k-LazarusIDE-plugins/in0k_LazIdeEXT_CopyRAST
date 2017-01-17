unit uTST_004_srcTree_itemROOT__realCase_001;

{$mode objfpc}{$H+}

interface

uses srcTree_item_coreROOT,
     srcTree_item_coreFileSystem,
     srcTree_item_fsFolder,
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
    SrcTreeROOT_set_BaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
end;

procedure tUTST_srcTree_itemROOT__realCase_001.TearDown;
begin
    ROOT.FREE;
end;

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__realCase_001.Test;
var fldr:tSrcTree_item_fsNodeFLDR;
begin
    SrcTreeROOT_get_relPATH(root,'srcPKG');
    SrcTreeROOT_get_relPATH(root,'srcPKG\srcTree');
    SrcTreeROOT_get_relPATH(root,'srcPKG\srcTree\Items\CORE');
    SrcTreeROOT_get_relPATH(root,'srcPKG\srcTree\Items');
    SrcTreeROOT_get_relPATH(root,'srcPKG\UI\cmp');
    SrcTreeROOT_get_relPATH(root,'srcPKG\Forms');
    SrcTreeROOT_get_relPATH(root,'srcPKG\Nodes');
    SrcTreeROOT_get_relPATH(root,'srcPKG\OperationNODEs\Processing_ProjPack');
    SrcTreeROOT_get_relPATH(root,'srcEXT\in0k-lazarusIdeSRC-wndDEBUG');
    SrcTreeROOT_get_relPATH(root,'srcEXT\in0k-lazarusIdeSRC-FuckUpForm');
    SrcTreeROOT_get_relPATH(root,'srcEXT\in0k-lazarusIdeSRC-ExpertCORE');
    SrcTreeROOT_get_relPATH(root,'srcPKG');
    SrcTreeROOT_get_relPATH(root,'srcPKG');
    //---
    fldr:=SrcTreeROOT_fnd_relPATH(root,'srcPKG\UI\cmp');
    //---
    AssertNotNull('`fldr` is NIL',fldr);

end;

initialization
    RegisterTest(tUTST_srcTree_itemROOT__realCase_001);

end.


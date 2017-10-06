unit uTST_004_srcTree_itemROOT__realCase_001;

{$mode objfpc}{$H+}

interface

uses
   in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
   in0k_lazIdeSRC_srcTree_item_Globals,
   in0k_lazIdeSRC_srcTree_item_fsFolder,
   //
   in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
   in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
   in0k_lazIdeSRC_srcTree_FNK_PATH_FND_rel,
   in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel,
   //
   SysUtils, fpcunit, testregistry;

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
var fldr:_tSrcTree_item_fsNodeFLDR_;
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
    fldr:=SrcTree_fndPathREL(root,'srcPKG\UI\cmp');
    //---
    AssertNotNull('`fldr` is NIL',fldr);

end;

initialization
    RegisterTest(tUTST_srcTree_itemROOT__realCase_001);
end.


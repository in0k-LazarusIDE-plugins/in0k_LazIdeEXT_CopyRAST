unit uTST_003_srcTree_itemROOT__get_relPATH_W_b_c__xn;

{$mode objfpc}{$H+}

interface

uses
    in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
    in0k_lazIdeSRC_srcTree_item_Globals,
    in0k_lazIdeSRC_srcTree_item_fsFolder,
    //
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
    in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel,
    //
    SysUtils, fpcunit, testregistry;

type

 tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn= class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
    FldA:tSrcTree_fsFLDR;
    FldB:tSrcTree_fsFLDR;
    FldC:tSrcTree_fsFLDR;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure relPATH_get_Wbc_Wn;
    procedure relPATH_get_Wbc_bn;
    procedure relPATH_get_Wbc_cn;
  end;

implementation

const
  c_FLDR_A={'Y'+DirectorySeparator+}'a';
  c_FLDR_B='b';
  c_FLDR_C='c';

procedure tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');       //< собсно создаем
    SrcTree_setBaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
    //---
    FldA:=SrcTree_getRelPATH(root,c_FLDR_A);
    FldB:=SrcTree_getRelPATH(root,c_FLDR_B);
    FldC:=SrcTree_getRelPATH(root,c_FLDR_C);
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================

procedure tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn.relPATH_get_Wbc_Wn;
var tst__Flder:string;
    resul__Get:_tSrcTree_item_fsNodeFLDR_;
begin
    // собсно ТЕСТ должен СОЗДАТЬ новую
    tst__Flder:=c_FLDR_A+DirectorySeparator+'n';
    resul__Get:=SrcTree_getRelPATH(root,tst__Flder);
    //
    AssertNotNull('`resul__Get` is NIL',resul__Get);
    AssertSame   ('wrong PARENT',resul__Get.ItemPRNT,FldA);
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn.relPATH_get_Wbc_bn;
var tst__Flder:string;
    resul__Get:_tSrcTree_item_fsNodeFLDR_;
begin
    // собсно ТЕСТ должен СОЗДАТЬ новую
    tst__Flder:=c_FLDR_B+DirectorySeparator+'n';
    resul__Get:=SrcTree_getRelPATH(root,tst__Flder);
    //
    AssertNotNull('`resul__Get` is NIL',resul__Get);
    AssertSame   ('wrong PARENT',resul__Get.ItemPRNT,FldB);
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn.relPATH_get_Wbc_cn;
var tst__Flder:string;
    resul__Get:_tSrcTree_item_fsNodeFLDR_;
begin
    // собсно ТЕСТ должен СОЗДАТЬ новую
    tst__Flder:=c_FLDR_C+DirectorySeparator+'n';
    resul__Get:=SrcTree_getRelPATH(root,tst__Flder);
    //
    AssertNotNull('`resul__Get` is NIL',resul__Get);
    AssertSame   ('wrong PARENT',resul__Get.ItemPRNT,FldC);
end;

initialization

    RegisterTest(tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn);
end.


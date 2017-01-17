unit uTST_003_srcTree_itemROOT__get_relPATH_W_b_c__xn;

{$mode objfpc}{$H+}

interface

uses srcTree_item_coreROOT,
     srcTree_item_coreFileSystem,
     srcTree_item_fsFolder,
    Classes, SysUtils, fpcunit, testutils, testregistry;

type

 tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn= class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
    FldA:tSrcTree_item_fsNodeFLDR;
    FldB:tSrcTree_item_fsNodeFLDR;
    FldC:tSrcTree_item_fsNodeFLDR;
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
  c_FLDR_A='Y'+DirectorySeparator+'a';
  c_FLDR_B='b';
  c_FLDR_C='c';

procedure tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');       //< собсно создаем
    SrcTreeROOT_set_BaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
    //---
    FldA:=SrcTreeROOT_get_relPATH(root,c_FLDR_A);
    FldB:=SrcTreeROOT_get_relPATH(root,c_FLDR_B);
    FldC:=SrcTreeROOT_get_relPATH(root,c_FLDR_C);
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================

procedure tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn.relPATH_get_Wbc_Wn;
var tst__Flder:string;
    resul__Get:tSrcTree_item_fsNodeFLDR;
begin
    // собсно ТЕСТ должен СОЗДАТЬ новую
    tst__Flder:=c_FLDR_A+DirectorySeparator+'n';
    resul__Get:=SrcTreeROOT_get_relPATH(root,tst__Flder);
    //
    AssertNotNull('`resul__Get` is NIL',resul__Get);
    AssertSame   ('wrong PARENT',resul__Get.ItemPRNT,FldA);
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn.relPATH_get_Wbc_bn;
var tst__Flder:string;
    resul__Get:tSrcTree_item_fsNodeFLDR;
begin
    // собсно ТЕСТ должен СОЗДАТЬ новую
    tst__Flder:=c_FLDR_B+DirectorySeparator+'n';
    resul__Get:=SrcTreeROOT_get_relPATH(root,tst__Flder);
    //
    AssertNotNull('`resul__Get` is NIL',resul__Get);
    AssertSame   ('wrong PARENT',resul__Get.ItemPRNT,FldB);
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn.relPATH_get_Wbc_cn;
var tst__Flder:string;
    resul__Get:tSrcTree_item_fsNodeFLDR;
begin
    // собсно ТЕСТ должен СОЗДАТЬ новую
    tst__Flder:=c_FLDR_C+DirectorySeparator+'n';
    resul__Get:=SrcTreeROOT_get_relPATH(root,tst__Flder);
    //
    AssertNotNull('`resul__Get` is NIL',resul__Get);
    AssertSame   ('wrong PARENT',resul__Get.ItemPRNT,FldC);
end;

initialization

    RegisterTest(tUTST_srcTree_itemROOT__get_relPATH_W_b_c__xn);
end.


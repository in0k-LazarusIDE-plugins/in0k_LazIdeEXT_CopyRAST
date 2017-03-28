unit uTST_003_srcTree_itemROOT__getRelPATH_4m__a_b_c;

{$mode objfpc}{$H+}

interface

uses srcTree_item_coreROOT,
     srcTree_item_fsFolder,
     in0k_srcTree_getRelPATH,
     in0k_srcTree_fndBaseDIR,
     in0k_srcTree_setBaseDIR,
     srcTree_item_baseDIR,

    Classes, SysUtils, fpcunit, testregistry;

type

 tUTST_srcTree_itemROOT__getRelPATH_4m__a_b_c=class(TTestCase)
 protected
    ROOT:tSrcTree_ROOT;
    FldA:tSrcTree_item_fsNodeFLDR;
    FldB:tSrcTree_item_fsNodeFLDR;
    FldC:tSrcTree_item_fsNodeFLDR;
  protected
    function _CRT_(const relFolderName:string):tSrcTree_item_fsNodeFLDR;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure relPATH_get_empty;
  published
    procedure relPATH_get_a;
    procedure relPATH_get_a_b;
    procedure relPATH_get_a_b_c;
  end;

implementation

procedure tUTST_srcTree_itemROOT__getRelPATH_4m__a_b_c.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');       //< собсно создаем
    SrcTree_setBaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
    FldA:=nil;
    FldB:=nil;
    FldC:=nil;
end;

procedure tUTST_srcTree_itemROOT__getRelPATH_4m__a_b_c.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================

function tUTST_srcTree_itemROOT__getRelPATH_4m__a_b_c._CRT_(const relFolderName:string):tSrcTree_item_fsNodeFLDR;
begin
    result:=tSrcTree_item_fsNodeFLDR.Create(relFolderName);
end;

const
  c_FLDR_A='a';
  c_FLDR_B='b';
  c_FLDR_C='c';

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__getRelPATH_4m__a_b_c.relPATH_get_empty;
var res:tSrcTree_item_fsNodeFLDR;
begin // должно возвращать BaseDIR
    res:=SrcTree_getRelPATH(root,'',@_CRT_);
    //---
    AssertNotNull('notFound',res);
    AssertSame   ('`res` must by BaseDIR',res,SrcTree_fndBaseDIR(ROOT));
end;

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__getRelPATH_4m__a_b_c.relPATH_get_a;
begin
    FldA:=SrcTree_getRelPATH(root,c_FLDR_A,@_CRT_);
    //---
    AssertNotNull('`FldA` is NIL',FldA);
    AssertSame   ('`FldA.PRNT` <> BaseDIR',FldA.ItemPRNT,SrcTree_fndBaseDIR(ROOT));
end;

procedure tUTST_srcTree_itemROOT__getRelPATH_4m__a_b_c.relPATH_get_a_b;
begin
    FldA:=SrcTree_getRelPATH(root,c_FLDR_A,@_CRT_);
    FldB:=SrcTree_getRelPATH(root,c_FLDR_B,@_CRT_);
    //---
    AssertNotNull('`FldB` is NIL',FldB);
    AssertSame   ('`FldB.PRNT` <> BaseDIR',FldB.ItemPRNT,SrcTree_fndBaseDIR(ROOT));
    AssertSame   ('`FldA.NEXT` <> FldB',   FldA.ItemNEXT,FldB);
end;

procedure tUTST_srcTree_itemROOT__getRelPATH_4m__a_b_c.relPATH_get_a_b_c;
begin
    FldA:=SrcTree_getRelPATH(root,c_FLDR_A,@_CRT_);
    FldB:=SrcTree_getRelPATH(root,c_FLDR_B,@_CRT_);
    FldC:=SrcTree_getRelPATH(root,c_FLDR_C,@_CRT_);
    //---
    AssertNotNull('`FldC` is NIL',FldC);
    AssertSame   ('`FldC.PRNT` <> BaseDIR',FldC.ItemPRNT,SrcTree_fndBaseDIR(ROOT));
    AssertSame   ('`FldB.NEXT` <> FldC',   FldB.ItemNEXT,FldC);
    //---

end;

initialization

    RegisterTest(tUTST_srcTree_itemROOT__getRelPATH_4m__a_b_c);
end.


unit uTST_003_srcTree_itemROOT__get_relPATH_4m__a_b_c;

{$mode objfpc}{$H+}

interface

uses
    in0k_lazIdeSRC_srcTree_item_Globals,
    in0k_lazIdeSRC_srcTree_item_fsFolder,
    //
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
    in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel,
    //
    SysUtils, fpcunit, testregistry;

type

 tUTST_srcTree_itemROOT__get_relPATH_4m__a_b_c=class(TTestCase)
 protected
   ROOT:tSrcTree_ROOT;
   FldA:tSrcTree_fsFLDR;
   FldB:tSrcTree_fsFLDR;
   FldC:tSrcTree_fsFLDR;
  protected
    function _CRT_(const relFolderName:string):tSrcTree_fsFLDR;
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

procedure tUTST_srcTree_itemROOT__get_relPATH_4m__a_b_c.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');  //< собсно создаем
    SrcTree_setBaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
    FldA:=nil;
    FldB:=nil;
    FldC:=nil;
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_4m__a_b_c.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================

function tUTST_srcTree_itemROOT__get_relPATH_4m__a_b_c._CRT_(const relFolderName:string):tSrcTree_fsFLDR;
begin
    result:=tSrcTree_fsFLDR.Create(relFolderName);
end;

const
  c_FLDR_A='a';
  c_FLDR_B='b';
  c_FLDR_C='c';

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__get_relPATH_4m__a_b_c.relPATH_get_empty;
var res:tSrcTree_fsFLDR;
begin // должно возвращать BaseDIR
    res:=SrcTree_getPathREL(root,'',@_CRT_);
    //---
    AssertNotNull('notFound',res);
    AssertSame   ('`res` must by BaseDIR',res,SrcTree_fndBaseDIR(ROOT));
end;

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__get_relPATH_4m__a_b_c.relPATH_get_a;
begin
    FldA:=SrcTree_getPathREL(root,c_FLDR_A,@_CRT_);
    //---
    AssertNotNull('`FldA` is NIL',FldA);
    AssertSame   ('`FldA.PRNT` <> BaseDIR',FldA.ItemPRNT,SrcTree_fndBaseDIR(ROOT));
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_4m__a_b_c.relPATH_get_a_b;
begin
    FldA:=SrcTree_getPathREL(root,c_FLDR_A,@_CRT_);
    FldB:=SrcTree_getPathREL(root,c_FLDR_B,@_CRT_);
    //---
    AssertNotNull('`FldB` is NIL',FldB);
    AssertSame   ('`FldB.PRNT` <> BaseDIR',FldB.ItemPRNT,SrcTree_fndBaseDIR(ROOT));
    AssertSame   ('`FldA.NEXT` <> FldB',   FldA.ItemNEXT,FldB);
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_4m__a_b_c.relPATH_get_a_b_c;
begin
    FldA:=SrcTree_getPathREL(root,c_FLDR_A,@_CRT_);
    FldB:=SrcTree_getPathREL(root,c_FLDR_B,@_CRT_);
    FldC:=SrcTree_getPathREL(root,c_FLDR_C,@_CRT_);
    //---
    AssertNotNull('`FldC` is NIL',FldC);
    AssertSame   ('`FldC.PRNT` <> BaseDIR',FldC.ItemPRNT,SrcTree_fndBaseDIR(ROOT));
    AssertSame   ('`FldB.NEXT` <> FldC',   FldB.ItemNEXT,FldC);
    //---

end;

initialization
    RegisterTest(tUTST_srcTree_itemROOT__get_relPATH_4m__a_b_c);
end.


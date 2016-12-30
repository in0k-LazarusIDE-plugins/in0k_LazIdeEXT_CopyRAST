unit uTST_003_srcTree_itemROOT__get_relPATH_a_b_c;

{$mode objfpc}{$H+}

interface

uses srcTree_item_coreROOT,
     srcTree_item_coreFileSystem,
    Classes, SysUtils, fpcunit, testutils, testregistry;

type

 tUTST_srcTree_itemROOT__get_relPATH_a_b_c=class(TTestCase)
 protected
    ROOT:tSrcTree_ROOT;
    FldA:tSrcTree_item_fsNodeDIR;
    FldB:tSrcTree_item_fsNodeDIR;
    FldC:tSrcTree_item_fsNodeDIR;
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

procedure tUTST_srcTree_itemROOT__get_relPATH_a_b_c.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');       //< собсно создаем
    SrcTreeROOT_set_BaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
    FldA:=nil;
    FldB:=nil;
    FldC:=nil;
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_a_b_c.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================

const
  c_FLDR_A='a';
  c_FLDR_B='b';
  c_FLDR_C='c';

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__get_relPATH_a_b_c.relPATH_get_empty;
var res:tSrcTree_item_fsNodeDIR;
begin // должно возвращать BaseDIR
    res:=SrcTreeROOT_get_relPATH(root,'');
    //---
    AssertNotNull('notFound',res);
    AssertSame   ('`res` must by BaseDIR',res,SrcTreeROOT_fnd_BaseDIR(ROOT));
end;

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__get_relPATH_a_b_c.relPATH_get_a;
begin
    FldA:=SrcTreeROOT_get_relPATH(root,c_FLDR_A);
    //---
    AssertNotNull('`FldA` is NIL',FldA);
    AssertSame   ('`FldA.PRNT` <> BaseDIR',FldA.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_a_b_c.relPATH_get_a_b;
begin
    FldA:=SrcTreeROOT_get_relPATH(root,c_FLDR_A);
    FldB:=SrcTreeROOT_get_relPATH(root,c_FLDR_B);
    //---
    AssertNotNull('`FldB` is NIL',FldB);
    AssertSame   ('`FldB.PRNT` <> BaseDIR',FldB.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('`FldA.NEXT` <> FldB',   FldA.ItemNEXT,FldB);
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_a_b_c.relPATH_get_a_b_c;
begin
    FldA:=SrcTreeROOT_get_relPATH(root,c_FLDR_A);
    FldB:=SrcTreeROOT_get_relPATH(root,c_FLDR_B);
    FldC:=SrcTreeROOT_get_relPATH(root,c_FLDR_C);
    //---
    AssertNotNull('`FldC` is NIL',FldC);
    AssertSame   ('`FldC.PRNT` <> BaseDIR',FldC.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('`FldB.NEXT` <> FldC',   FldB.ItemNEXT,FldC);
    //---

end;

initialization

    RegisterTest(tUTST_srcTree_itemROOT__get_relPATH_a_b_c);
end.


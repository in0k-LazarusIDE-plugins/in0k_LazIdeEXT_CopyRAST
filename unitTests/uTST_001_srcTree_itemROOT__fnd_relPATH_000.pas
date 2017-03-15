unit uTST_001_srcTree_itemROOT__fnd_relPATH_000;

{$mode objfpc}{$H+}

interface

uses srcTree_item_coreROOT,
     srcTree_item_fsFolder,
     srcTree_FNC,
     in0k_srcTree_fndBaseDIR,
     in0k_srcTree_setBaseDIR,
    Classes, SysUtils, fpcunit, testregistry;

type

 tUTST_srcTree_itemROOT__fnd_relPATH_000= class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure itmROOT_is_Present;
    procedure baseDIR_is_Present;
  published
    procedure relPATH_find_empty;
  published
    procedure relPATH_find_TEST;
    procedure relPATH_find_TEST_ds;
    procedure relPATH_find_TEST_ds_TEST;
    procedure relPATH_find_TEST_ds_TEST_ds;
  end;

implementation

procedure tUTST_srcTree_itemROOT__fnd_relPATH_000.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');       //< собсно создаем
    SrcTree_setBaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
end;

procedure tUTST_srcTree_itemROOT__fnd_relPATH_000.TearDown;
begin
    ROOT.FREE;
end;

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__fnd_relPATH_000.itmROOT_is_Present;
begin
    AssertNotNull(ROOT);
end;

procedure tUTST_srcTree_itemROOT__fnd_relPATH_000.baseDIR_is_Present;
begin
    AssertNotNull(SrcTree_fndBaseDIR(ROOT));
end;

//==============================================================================

procedure tUTST_srcTree_itemROOT__fnd_relPATH_000.relPATH_find_empty;
var res:tSrcTree_item_fsNodeFLDR;
begin // должно возвращать BaseDIR
    res:=SrcTreeROOT_fnd_relPATH(root,'');
    //---
    AssertNotNull('notFound',res);
    AssertSame   ('`res` must by BaseDIR',res,SrcTree_fndBaseDIR(ROOT));
end;

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__fnd_relPATH_000.relPATH_find_TEST;
var res:tSrcTree_item_fsNodeFLDR;
begin
    res:=SrcTreeROOT_fnd_relPATH(root,'TEST');
    //---
    AssertNull   ('`res` must by NIL',res);
end;

procedure tUTST_srcTree_itemROOT__fnd_relPATH_000.relPATH_find_TEST_ds;
var res:tSrcTree_item_fsNodeFLDR;
begin
    res:=SrcTreeROOT_fnd_relPATH(root,'TEST'+DirectorySeparator);
    //---
    AssertNull   ('`res` must by NIL',res);
end;


procedure tUTST_srcTree_itemROOT__fnd_relPATH_000.relPATH_find_TEST_ds_TEST;
var res:tSrcTree_item_fsNodeFLDR;
begin
    res:=SrcTreeROOT_fnd_relPATH(root,'TEST'+DirectorySeparator+'TEST');
    //---
    AssertNull   ('`res` must by NIL',res);
end;

procedure tUTST_srcTree_itemROOT__fnd_relPATH_000.relPATH_find_TEST_ds_TEST_ds;
var res:tSrcTree_item_fsNodeFLDR;
begin
    res:=SrcTreeROOT_fnd_relPATH(root,'TEST'+DirectorySeparator+'TEST'+DirectorySeparator);
    //---
    AssertNull   ('`res` must by NIL',res);
end;


initialization

    RegisterTest(tUTST_srcTree_itemROOT__fnd_relPATH_000);
end.


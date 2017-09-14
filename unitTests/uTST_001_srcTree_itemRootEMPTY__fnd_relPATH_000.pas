unit uTST_001_srcTree_itemRootEMPTY__fnd_relPATH_000;

{$mode objfpc}{$H+}

interface

uses
    in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
    in0k_lazIdeSRC_srcTree_item_Globals,
    //
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
    //
    in0k_lazIdeSRC_srcTree_FNK_PATH_rel_FND,
    //
    SysUtils, fpcunit, testregistry;

type

 tTST_srcTree_itemRootEMPTY__fnd_relPATH_000=class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure itmROOT_is_Present;
    procedure baseDIR_is_Present;
  published
    procedure find_empty;
  published
    procedure find_TEST;
    procedure find_TEST_ds;
    procedure find_TEST_ds_TEST;
    procedure find_TEST_ds_TEST_ds;
  end;

implementation

procedure tTST_srcTree_itemRootEMPTY__fnd_relPATH_000.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');  //< собсно создаем
    SrcTree_setBaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
end;

procedure tTST_srcTree_itemRootEMPTY__fnd_relPATH_000.TearDown;
begin
    ROOT.FREE;
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree_itemRootEMPTY__fnd_relPATH_000.itmROOT_is_Present;
begin
    AssertNotNull(ROOT);
end;

procedure tTST_srcTree_itemRootEMPTY__fnd_relPATH_000.baseDIR_is_Present;
begin
    AssertNotNull(SrcTree_fndBaseDIR(ROOT));
end;

//==============================================================================

procedure tTST_srcTree_itemRootEMPTY__fnd_relPATH_000.find_empty;
var res:_tSrcTree_item_fsNodeFLDR_;
begin // должно возвращать BaseDIR
    res:=SrcTree_fndPathREL(root,'');
    //---
    AssertNotNull('notFound',res);
    AssertSame   ('`res` must by BaseDIR',res,SrcTree_fndBaseDIR(ROOT));
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree_itemRootEMPTY__fnd_relPATH_000.find_TEST;
var res:_tSrcTree_item_fsNodeFLDR_;
begin
    res:=SrcTree_fndPathREL(root,'TEST');
    //---
    AssertNull   ('`res` must by NIL',res);
end;

procedure tTST_srcTree_itemRootEMPTY__fnd_relPATH_000.find_TEST_ds;
var res:_tSrcTree_item_fsNodeFLDR_;
begin
    res:=SrcTree_fndPathREL(root,'TEST'+DirectorySeparator);
    //---
    AssertNull   ('`res` must by NIL',res);
end;


procedure tTST_srcTree_itemRootEMPTY__fnd_relPATH_000.find_TEST_ds_TEST;
var res:_tSrcTree_item_fsNodeFLDR_;
begin
    res:=SrcTree_fndPathREL(root,'TEST'+DirectorySeparator+'TEST');
    //---
    AssertNull   ('`res` must by NIL',res);
end;

procedure tTST_srcTree_itemRootEMPTY__fnd_relPATH_000.find_TEST_ds_TEST_ds;
var res:_tSrcTree_item_fsNodeFLDR_;
begin
    res:=SrcTree_fndPathREL(root,'TEST'+DirectorySeparator+'TEST'+DirectorySeparator);
    //---
    AssertNull   ('`res` must by NIL',res);
end;


initialization
    RegisterTest(tTST_srcTree_itemRootEMPTY__fnd_relPATH_000);
end.


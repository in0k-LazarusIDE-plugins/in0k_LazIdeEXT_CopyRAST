unit uTST_002_srcTree__PATH_fnd_REL;

{$mode objfpc}{$H+}

interface

uses
    in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
    in0k_lazIdeSRC_srcTree_item_Globals,
    //
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
    //
    in0k_lazIdeSRC_srcTree_FNK_PATH_FND_rel,
    //
    SysUtils, fpcunit, testregistry;

type

 tTST_srcTree__PATH_fnd_REL=class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure find_empty;
    procedure find_TEST;
    procedure find_TEST_ds_TEST;
  end;

implementation

procedure tTST_srcTree__PATH_fnd_REL.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');  //< собсно создаем
    SrcTree_setBaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
end;

procedure tTST_srcTree__PATH_fnd_REL.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================

procedure tTST_srcTree__PATH_fnd_REL.find_empty;
var res:_tSrcTree_item_fsNodeFLDR_;
begin // должно возвращать BaseDIR
    res:=SrcTree_fndPathREL(root,'');
    //---
    AssertNotNull('notFound',res);
    AssertSame   ('`res` must by BaseDIR',res,SrcTree_fndBaseDIR(ROOT));
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree__PATH_fnd_REL.find_TEST;
var res:_tSrcTree_item_fsNodeFLDR_;
begin
    res:=SrcTree_fndPathREL(root,'TEST');
    //---
    AssertNull('`res` must by NIL',res);
end;

procedure tTST_srcTree__PATH_fnd_REL.find_TEST_ds_TEST;
var res:_tSrcTree_item_fsNodeFLDR_;
begin
    res:=SrcTree_fndPathREL(root,'TEST'+DirectorySeparator+'TEST');
    //---
    AssertNull('`res` must by NIL',res);
end;

initialization
    RegisterTest(tTST_srcTree__PATH_fnd_REL);
end.

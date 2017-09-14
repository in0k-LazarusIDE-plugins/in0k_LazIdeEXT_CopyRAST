unit uTST_005_srcTree_itemROOT__fnd_absPATH_000;

{$mode objfpc}{$H+}

interface

uses
    in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
    in0k_lazIdeSRC_srcTree_item_Globals,
    //
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
    //
    in0k_lazIdeSRC_srcTree_FNK_PATH_abs_FND,
    //
    SysUtils, fpcunit, testregistry;

type

 tTST_srcTree_itemROOT__fnd_absPATH_000= class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  {published
    procedure itmROOT_is_Present;
    procedure baseDIR_is_Present;
  published
    procedure relPATH_find_empty;
  published
    procedure relPATH_find_TEST;
    procedure relPATH_find_TEST_ds;
    procedure relPATH_find_TEST_ds_TEST;
    procedure relPATH_find_TEST_ds_TEST_ds;}
  end;


implementation

procedure tTST_srcTree_itemROOT__fnd_absPATH_000.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');  //< собсно создаем
    SrcTree_setBaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
end;

procedure tTST_srcTree_itemROOT__fnd_absPATH_000.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================



initialization
    RegisterTest(tTST_srcTree_itemROOT__fnd_absPATH_000);

end.


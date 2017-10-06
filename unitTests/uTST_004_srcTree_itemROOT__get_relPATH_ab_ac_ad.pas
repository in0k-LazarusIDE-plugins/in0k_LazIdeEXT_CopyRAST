unit uTST_004_srcTree_itemROOT__get_relPATH_ab_ac_ad;

{$mode objfpc}{$H+}

interface

uses
   in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
   in0k_lazIdeSRC_srcTree_item_Globals,
   in0k_lazIdeSRC_srcTree_item_fsFolder,
   //
   in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
   in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
   in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel,
   //
   SysUtils, fpcunit, testregistry;

type

 tUTST_srcTree_itemROOT__get_relPATH_ab_ac_ad= class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
    dir1:tSrcTree_fsFLDR;
    dir2:tSrcTree_fsFLDR;
    dir3:tSrcTree_fsFLDR;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published // X - сложная папка вида "x/у"
    procedure relPATH_get_abc;
//    procedure relPATH_get_Wbc;
//    procedure relPATH_get_aWc;
//    procedure relPATH_get_abW;
  {published
    procedure relPATH_get_DEcrement_01;
    procedure relPATH_get_DEcrement_02;
    procedure relPATH_get_DEcrement_03;
    procedure relPATH_get_DEcrement_04; }
  end;

implementation

procedure tUTST_srcTree_itemROOT__get_relPATH_ab_ac_ad.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');       //< собсно создаем
    SrcTree_setBaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
    dir1:=nil;
    dir2:=nil;
    dir3:=nil;
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_ab_ac_ad.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================

const
  c_FLDR_A='a';
  c_FLDR_B='b';
  c_FLDR_C='c';

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__get_relPATH_ab_ac_ad.relPATH_get_abc;
var dirName1:string;
    dirName2:string;
    dirName3:string;
begin //Проверка: #1(a/b) #2(a; a/b; a/c) #3(a; a/b; a/c; a/d)
    dirName1:=c_FLDR_A+DirectorySeparator+c_FLDR_b;
    dirName2:=c_FLDR_A+DirectorySeparator+c_FLDR_c;
    dirName3:=c_FLDR_A+DirectorySeparator+'D';

    //#1 - НОВАЯ
    dir1:=SrcTree_getRelPATH(root,dirName1);
    AssertNotNull('`dir1` is NIL',dir1);
    // проверим структуру
    AssertSame   ('wrong PARENT' ,dir1.ItemPRNT,SrcTree_fndBaseDIR(ROOT));

    //#2 - НОВАЯ
    dir2:=SrcTree_getRelPATH(root,dirName2);
    AssertNotNull('`dir2` is NIL',dir2);
    // проверим структуру
    AssertNotSame('wrong PARENT',dir1.ItemPRNT,SrcTree_fndBaseDIR(ROOT));
    AssertSame   ('wrong NEXT'  ,dir1.ItemNEXT,dir2);

    //--- должен СОЗДАТЬ новую
    dir3:=SrcTree_getRelPATH(root,dirName3);
    AssertNotNull('`dir3` is NIL',dir3);

    AssertSame   ('wrong NEXT'  ,dir2.ItemNEXT,dir3);

end;

initialization

    RegisterTest(tUTST_srcTree_itemROOT__get_relPATH_ab_ac_ad);
end.


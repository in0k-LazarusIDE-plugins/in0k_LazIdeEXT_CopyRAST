unit uTST_004_srcTree_itemROOT__get_relPATH_ab_ac_ad;

{$mode objfpc}{$H+}

interface

uses srcTree_item_coreROOT,
     srcTree_item_coreFileSystem,
    Classes, SysUtils, fpcunit, testutils, testregistry;

type

 tUTST_srcTree_itemROOT__get_relPATH_ab_ac_ad= class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
    dir1:tSrcTree_item_fsNodeDIR;
    dir2:tSrcTree_item_fsNodeDIR;
    dir3:tSrcTree_item_fsNodeDIR;
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
    SrcTreeROOT_set_BaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
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
    dir1:=SrcTreeROOT_get_relPATH(root,dirName1);
    AssertNotNull('`dir1` is NIL',dir1);
    // проверим структуру
    AssertSame   ('wrong PARENT' ,dir1.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));

    //#2 - НОВАЯ
    dir2:=SrcTreeROOT_get_relPATH(root,dirName2);
    AssertNotNull('`dir2` is NIL',dir2);
    // проверим структуру
    AssertNotSame('wrong PARENT',dir1.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong NEXT'  ,dir1.ItemNEXT,dir2);

    //--- должен СОЗДАТЬ новую
    dir3:=SrcTreeROOT_get_relPATH(root,dirName3);
    AssertNotNull('`dir3` is NIL',dir3);

    AssertSame   ('wrong NEXT'  ,dir2.ItemNEXT,dir3);

end;

initialization

    RegisterTest(tUTST_srcTree_itemROOT__get_relPATH_ab_ac_ad);
end.


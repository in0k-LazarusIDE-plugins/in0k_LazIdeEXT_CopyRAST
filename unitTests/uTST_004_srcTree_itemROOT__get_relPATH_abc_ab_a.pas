unit uTST_004_srcTree_itemROOT__get_relPATH_abc_ab_a;

{$mode objfpc}{$H+}

interface

uses srcTree_item_coreROOT,
     srcTree_item_coreFileSystem,
    Classes, SysUtils, fpcunit, testutils, testregistry;

type

 tUTST_srcTree_itemROOT__get_relPATH_abc_ab_a= class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
    FldA:tSrcTree_item_fsNodeDIR;
    FldB:tSrcTree_item_fsNodeDIR;
    FldC:tSrcTree_item_fsNodeDIR;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published // X - сложная папка вида "x/у"
    procedure relPATH_get_abc;
    procedure relPATH_get_Wbc;
    procedure relPATH_get_aWc;
    procedure relPATH_get_abW;
  {published
    procedure relPATH_get_DEcrement_01;
    procedure relPATH_get_DEcrement_02;
    procedure relPATH_get_DEcrement_03;
    procedure relPATH_get_DEcrement_04; }
  end;

implementation

procedure tUTST_srcTree_itemROOT__get_relPATH_abc_ab_a.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');       //< собсно создаем
    SrcTreeROOT_set_BaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
    FldA:=nil;
    FldB:=nil;
    FldC:=nil;
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_abc_ab_a.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================

const
  c_FLDR_A='a';
  c_FLDR_B='b';
  c_FLDR_C='c';

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__get_relPATH_abc_ab_a.relPATH_get_abc;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:=                              c_FLDR_A;
    tstFlder01:=tstFlder00+DirectorySeparator+c_FLDR_B;
    tstFlder02:=tstFlder01+DirectorySeparator+c_FLDR_C;

    //--- должен СОЗДАТЬ новую
    FldC:=SrcTreeROOT_get_relPATH(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertSame   ('wrong PARENT',FldC.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));

    //--- должен СОЗДАТЬ новую
    FldB:=SrcTreeROOT_get_relPATH(root,tstFlder01);
    AssertNotNull('`FldB` is NIL',FldB);
    AssertSame   ('wrong PARENT',FldB.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong CHILD' ,FldB.ItemCHLD,FldC);
    AssertSame   ('wrong PARENT',FldC.ItemPRNT,FldB);

    //--- должен СОЗДАТЬ новую
    FldA:=SrcTreeROOT_get_relPATH(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertSame   ('wrong PARENT',FldA.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong CHILD' ,FldA.ItemCHLD,FldB);
    AssertSame   ('wrong PARENT',FldB.ItemPRNT,FldA);
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_abc_ab_a.relPATH_get_Wbc;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:='W'+DirectorySeparator       +c_FLDR_A;
    tstFlder01:=tstFlder00+DirectorySeparator+c_FLDR_B;
    tstFlder02:=tstFlder01+DirectorySeparator+c_FLDR_C;

    //--- должен СОЗДАТЬ новую
    FldC:=SrcTreeROOT_get_relPATH(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertSame   ('wrong PARENT',FldC.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));

    //--- должен СОЗДАТЬ новую
    FldB:=SrcTreeROOT_get_relPATH(root,tstFlder01);
    AssertNotNull('`FldB` is NIL',FldB);
    AssertSame   ('wrong PARENT',FldB.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong CHILD' ,FldB.ItemCHLD,FldC);
    AssertSame   ('wrong PARENT',FldC.ItemPRNT,FldB);

    //--- должен СОЗДАТЬ новую
    FldA:=SrcTreeROOT_get_relPATH(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertSame   ('wrong PARENT',FldA.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong CHILD' ,FldA.ItemCHLD,FldB);
    AssertSame   ('wrong PARENT',FldB.ItemPRNT,FldA);
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_abc_ab_a.relPATH_get_aWc;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:=c_FLDR_A;
    tstFlder01:=tstFlder00+DirectorySeparator+'W'+DirectorySeparator+c_FLDR_B;
    tstFlder02:=tstFlder01+DirectorySeparator+c_FLDR_C;

    //--- должен СОЗДАТЬ новую
    FldC:=SrcTreeROOT_get_relPATH(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertSame   ('wrong PARENT',FldC.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));

    //--- должен СОЗДАТЬ новую
    FldB:=SrcTreeROOT_get_relPATH(root,tstFlder01);
    AssertNotNull('`FldB` is NIL',FldB);
    AssertSame   ('wrong PARENT',FldB.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong CHILD' ,FldB.ItemCHLD,FldC);
    AssertSame   ('wrong PARENT',FldC.ItemPRNT,FldB);

    //--- должен СОЗДАТЬ новую
    FldA:=SrcTreeROOT_get_relPATH(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertSame   ('wrong PARENT',FldA.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong CHILD' ,FldA.ItemCHLD,FldB);
    AssertSame   ('wrong PARENT',FldB.ItemPRNT,FldA);
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_abc_ab_a.relPATH_get_abW;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:=c_FLDR_A;
    tstFlder01:=tstFlder00+DirectorySeparator+c_FLDR_B;
    tstFlder02:=tstFlder01+DirectorySeparator+'W'+DirectorySeparator+c_FLDR_C;

    //--- должен СОЗДАТЬ новую
    FldC:=SrcTreeROOT_get_relPATH(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertSame   ('wrong PARENT',FldC.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));

    //--- должен СОЗДАТЬ новую
    FldB:=SrcTreeROOT_get_relPATH(root,tstFlder01);
    AssertNotNull('`FldB` is NIL',FldB);
    AssertSame   ('wrong PARENT',FldB.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong CHILD' ,FldB.ItemCHLD,FldC);
    AssertSame   ('wrong PARENT',FldC.ItemPRNT,FldB);

    //--- должен СОЗДАТЬ новую
    FldA:=SrcTreeROOT_get_relPATH(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertSame   ('wrong PARENT',FldA.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong CHILD' ,FldA.ItemCHLD,FldB);
    AssertSame   ('wrong PARENT',FldB.ItemPRNT,FldA);
end;


initialization

    RegisterTest(tUTST_srcTree_itemROOT__get_relPATH_abc_ab_a);
end.


unit uTST_004_srcTree_itemROOT__get_relPATH_a_ab_abc;

{$mode objfpc}{$H+}

interface

uses
   in0k_lazIdeSRC_srcTree_CORE_item,
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
 {            inside
             in depth
 нисходящий  descending
             ascending
  восходяший ascendant
             downward  }
 tUTST_srcTree_itemROOT__get_relPATH_a_ab_abc= class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
    FldA:tSrcTree_fsFLDR;
    FldB:tSrcTree_fsFLDR;
    FldC:tSrcTree_fsFLDR;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  public
    //class procedure Assert_isSun_BaseDIR(const AMessage: string; ACondition: boolean; AErrorAddrs: Pointer = nil); overload;

  published // X - сложная папка вида "x/у"
    procedure descending_newPATH_abc;
   // procedure relPATH_get_Wbc;
   // procedure relPATH_get_aWc;
   // procedure relPATH_get_abW;
  {published
    procedure relPATH_get_DEcrement_01;
    procedure relPATH_get_DEcrement_02;
    procedure relPATH_get_DEcrement_03;
    procedure relPATH_get_DEcrement_04; }
  end;

implementation

procedure tUTST_srcTree_itemROOT__get_relPATH_a_ab_abc.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');       //< собсно создаем
    SrcTree_setBaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
    FldA:=nil;
    FldB:=nil;
    FldC:=nil;
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_a_ab_abc.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================

const
  c_FLDR_A='a';
  c_FLDR_B='b';
  c_FLDR_C='c';

//------------------------------------------------------------------------------

procedure tUTST_srcTree_itemROOT__get_relPATH_a_ab_abc.relPATH_get_abc;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:=                              c_FLDR_A;
    tstFlder01:=tstFlder00+DirectorySeparator+c_FLDR_B;
    tstFlder02:=tstFlder01+DirectorySeparator+c_FLDR_C;

    //--- должен СОЗДАТЬ новую
    FldA:=SrcTree_getPathREL(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertTrue   ('wrong PARENT `BaseDIR`',SrcTree_isParent_4_Item(SrcTree_fndBaseDIR(ROOT),FldA));

    //--- должен СОЗДАТЬ новую
    Fldb:=SrcTree_getPathREL(root,tstFlder01);
    AssertNotNull('`Fldb` is NIL',Fldb);
    AssertTrue   ('wrong PARENT `FldA`',SrcTree_isParent_4_Item(FldA,Fldb));

    //--- еще вызов, должен СОЗДАТЬ новую
    FldC:=SrcTree_getPathREL(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertTrue   ('wrong PARENT `FldB`',SrcTree_isParent_4_Item(Fldb,FldC));
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_a_ab_abc.relPATH_get_Wbc;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:='W'+DirectorySeparator       +c_FLDR_A;
    tstFlder01:=tstFlder00+DirectorySeparator+c_FLDR_B;
    tstFlder02:=tstFlder01+DirectorySeparator+c_FLDR_C;

    //--- должен СОЗДАТЬ новую
    FldA:=SrcTree_getPathREL(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertTrue   ('wrong PARENT `BaseDIR`',SrcTree_isParent_4_Item(SrcTree_fndBaseDIR(ROOT),FldA));

    //--- должен СОЗДАТЬ новую
    Fldb:=SrcTree_getPathREL(root,tstFlder01);
    AssertNotNull('`Fldb` is NIL',Fldb);
    AssertTrue   ('wrong PARENT `FldA`',SrcTree_isParent_4_Item(FldA,Fldb));

    //--- еще вызов, должен СОЗДАТЬ новую
    FldC:=SrcTree_getPathREL(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertTrue   ('wrong PARENT `FldB`',SrcTree_isParent_4_Item(Fldb,FldC));
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_a_ab_abc.relPATH_get_aWc;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:=c_FLDR_A;
    tstFlder01:=tstFlder00+DirectorySeparator+'W'+DirectorySeparator+c_FLDR_B;
    tstFlder02:=tstFlder01+DirectorySeparator+c_FLDR_C;

    //--- должен СОЗДАТЬ новую
    FldA:=SrcTree_getPathREL(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertTrue   ('wrong PARENT `BaseDIR`',SrcTree_isParent_4_Item(SrcTree_fndBaseDIR(ROOT),FldA));

    //--- должен СОЗДАТЬ новую
    Fldb:=SrcTree_getPathREL(root,tstFlder01);
    AssertNotNull('`Fldb` is NIL',Fldb);
    AssertTrue   ('wrong PARENT `FldA`',SrcTree_isParent_4_Item(FldA,Fldb));

    //--- еще вызов, должен СОЗДАТЬ новую
    FldC:=SrcTree_getPathREL(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertTrue   ('wrong PARENT `FldB`',SrcTree_isParent_4_Item(Fldb,FldC));
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_a_ab_abc.relPATH_get_abW;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:=c_FLDR_A;
    tstFlder01:=tstFlder00+DirectorySeparator+c_FLDR_B;
    tstFlder02:=tstFlder01+DirectorySeparator+'W'+DirectorySeparator+c_FLDR_C;

    //--- должен СОЗДАТЬ новую
    FldA:=SrcTree_getPathREL(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertTrue   ('wrong PARENT `BaseDIR`',SrcTree_isParent_4_Item(SrcTree_fndBaseDIR(ROOT),FldA));

    //--- должен СОЗДАТЬ новую
    Fldb:=SrcTree_getPathREL(root,tstFlder01);
    AssertNotNull('`Fldb` is NIL',Fldb);
    AssertTrue   ('wrong PARENT `FldA`',SrcTree_isParent_4_Item(FldA,Fldb));

    //--- еще вызов, должен СОЗДАТЬ новую
    FldC:=SrcTree_getPathREL(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertTrue   ('wrong PARENT `FldB`',SrcTree_isParent_4_Item(Fldb,FldC));
end;

{//==============================================================================

procedure tUTST_srcTree_itemROOT__get_relPATH_a_ab_abc.relPATH_get_DEcrement_01;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
    resulGet00:tSrcTree_fsFLDR;
    resulGet01:tSrcTree_fsFLDR;
    resulGet02:tSrcTree_fsFLDR;
begin
    tstFlder00:='a';
    tstFlder01:=tstFlder00+DirectorySeparator+'b';
    tstFlder02:=tstFlder01+DirectorySeparator+'c';

    //--- должен СОЗДАТЬ новую
    resulGet02:=SrcTree_get_relPATH(root,tstFlder02);
    //
    AssertNotNull('`resulGet02` is NIL',resulGet02);
    AssertSame   ('wrong PARENT',resulGet00.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));

    //--- должен СОЗДАТЬ новую
    resulGet01:=SrcTree_get_relPATH(root,tstFlder01);
    //
    AssertNotNull('`resulGet01` is NIL',resulGet01);
    AssertSame   ('wrong PARENT',resulGet01.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong PARENT',resulGet02.ItemPRNT,resulGet01);

    //--- еще вызов, должен СОЗДАТЬ новую
    resulGet00:=SrcTree_get_relPATH(root,tstFlder00);
    //
    AssertNotNull('`resulGet00` is NIL',resulGet00);
    AssertSame   ('wrong PARENT',resulGet00.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong PARENT',resulGet01.ItemPRNT,resulGet00);
end;


procedure tUTST_srcTree_itemROOT__get_relPATH_a_ab_abc.relPATH_get_DEcrement_02;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
    resulGet00:tSrcTree_fsFLDR;
    resulGet01:tSrcTree_fsFLDR;
    resulGet02:tSrcTree_fsFLDR;
begin
    tstFlder00:='TEST'+DirectorySeparator+'a';
    tstFlder01:=tstFlder00+DirectorySeparator+'b';
    tstFlder02:=tstFlder01+DirectorySeparator+'c';

    //--- должен СОЗДАТЬ новую
    resulGet02:=SrcTree_get_relPATH(root,tstFlder02);
    //
    AssertNotNull('`resulGet02` is NIL',resulGet02);
    AssertSame   ('wrong PARENT',resulGet00.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));

    //--- должен СОЗДАТЬ новую
    resulGet01:=SrcTree_get_relPATH(root,tstFlder01);
    //
    AssertNotNull('`resulGet01` is NIL',resulGet01);
    AssertSame   ('wrong PARENT',resulGet01.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong PARENT',resulGet02.ItemPRNT,resulGet01);

    //--- еще вызов, должен СОЗДАТЬ новую
    resulGet00:=SrcTree_get_relPATH(root,tstFlder00);
    //
    AssertNotNull('`resulGet00` is NIL',resulGet00);
    AssertSame   ('wrong PARENT',resulGet00.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong PARENT',resulGet01.ItemPRNT,resulGet00);
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_a_ab_abc.relPATH_get_DEcrement_03;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
    resulGet00:tSrcTree_fsFLDR;
    resulGet01:tSrcTree_fsFLDR;
    resulGet02:tSrcTree_fsFLDR;
begin
    tstFlder00:='a';
    tstFlder01:=tstFlder00+DirectorySeparator+'TEST'+DirectorySeparator+'b';
    tstFlder02:=tstFlder01+DirectorySeparator+'c';

    //--- должен СОЗДАТЬ новую
    resulGet02:=SrcTree_get_relPATH(root,tstFlder02);
    //
    AssertNotNull('`resulGet02` is NIL',resulGet02);
    AssertSame   ('wrong PARENT',resulGet00.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));

    //--- должен СОЗДАТЬ новую
    resulGet01:=SrcTree_get_relPATH(root,tstFlder01);
    //
    AssertNotNull('`resulGet01` is NIL',resulGet01);
    AssertSame   ('wrong PARENT',resulGet01.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong PARENT',resulGet02.ItemPRNT,resulGet01);

    //--- еще вызов, должен СОЗДАТЬ новую
    resulGet00:=SrcTree_get_relPATH(root,tstFlder00);
    //
    AssertNotNull('`resulGet00` is NIL',resulGet00);
    AssertSame   ('wrong PARENT',resulGet00.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong PARENT',resulGet01.ItemPRNT,resulGet00);
end;

procedure tUTST_srcTree_itemROOT__get_relPATH_a_ab_abc.relPATH_get_DEcrement_04;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
    resulGet00:tSrcTree_fsFLDR;
    resulGet01:tSrcTree_fsFLDR;
    resulGet02:tSrcTree_fsFLDR;
begin
    tstFlder00:='a';
    tstFlder01:=tstFlder00+DirectorySeparator+'b';
    tstFlder02:=tstFlder01+DirectorySeparator+'TEST'+DirectorySeparator+'c';

    //--- должен СОЗДАТЬ новую
    resulGet02:=SrcTree_get_relPATH(root,tstFlder02);
    //
    AssertNotNull('`resulGet02` is NIL',resulGet02);
    AssertSame   ('wrong PARENT',resulGet00.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));

    //--- должен СОЗДАТЬ новую
    resulGet01:=SrcTree_get_relPATH(root,tstFlder01);
    //
    AssertNotNull('`resulGet01` is NIL',resulGet01);
    AssertSame   ('wrong PARENT',resulGet01.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong PARENT',resulGet02.ItemPRNT,resulGet01);

    //--- еще вызов, должен СОЗДАТЬ новую
    resulGet00:=SrcTree_get_relPATH(root,tstFlder00);
    //
    AssertNotNull('`resulGet00` is NIL',resulGet00);
    AssertSame   ('wrong PARENT',resulGet00.ItemPRNT,SrcTreeROOT_fnd_BaseDIR(ROOT));
    AssertSame   ('wrong PARENT',resulGet01.ItemPRNT,resulGet00);
end;                                                 }

initialization

    RegisterTest(tUTST_srcTree_itemROOT__get_relPATH_a_ab_abc);
end.


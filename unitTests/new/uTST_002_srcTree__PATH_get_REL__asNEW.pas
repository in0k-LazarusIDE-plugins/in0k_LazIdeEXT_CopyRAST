unit uTST_002_srcTree__PATH_get_REL__asNEW;

{$mode objfpc}{$H+}

interface

uses
    in0k_lazIdeSRC_srcTree_CORE_item,
    in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
    in0k_lazIdeSRC_srcTree_item_Globals,
    //
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
    //
    in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel,
    //
    Classes, SysUtils, fpcunit, testregistry;

type

 tTST_srcTree__PATH_get_REL__asNEW= class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
    FldA:_tSrcTree_item_fsNodeFLDR_;
    FldB:_tSrcTree_item_fsNodeFLDR_;
    FldC:_tSrcTree_item_fsNodeFLDR_;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published // последовательно создание ВЛОЖЕННЫХ папок
    procedure descending_newPATH_abc;
    procedure descending_newPATH_Xbc;
    procedure descending_newPATH_aXc;
    procedure descending_newPATH_abX;
  published // создание самой глубокой, потом "поиск" родительских
    procedure ascendant_newPATH_abc;
    procedure ascendant_newPATH_Xbc;
    procedure ascendant_newPATH_aXc;
  end;

implementation

procedure tTST_srcTree__PATH_get_REL__asNEW.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT');       //< собсно создаем
    SrcTree_setBaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
    FldA:=nil;
    FldB:=nil;
    FldC:=nil;
end;

procedure tTST_srcTree__PATH_get_REL__asNEW.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================

const
  PD=PathDelim;
  c_FLDR_A='a';
  c_FLDR_B='b';
  c_FLDR_C='c';
  c_FLDR_X='X';

//------------------------------------------------------------------------------

procedure tTST_srcTree__PATH_get_REL__asNEW.descending_newPATH_abc;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    // названия папок (они ВЛОЖЕННЫЕ)
    tstFlder00:=              c_FLDR_A;
    tstFlder01:=tstFlder00+PD+c_FLDR_B;
    tstFlder02:=tstFlder01+PD+c_FLDR_C;

    //--- должен СОЗДАТЬ новую
    FldA:=SrcTree_getRelPATH(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertTrue   ('wrong PARENT `BaseDIR`',SrcTree_isParent_4_Item(SrcTree_fndBaseDIR(ROOT),FldA));

    //--- должен СОЗДАТЬ новую
    FldB:=SrcTree_getRelPATH(root,tstFlder01);
    AssertNotNull('`FldB` is NIL',FldB);
    AssertTrue   ('wrong PARENT `FldA`',SrcTree_isParent_4_Item(FldA,FldB));

    //--- должен СОЗДАТЬ новую
    FldC:=SrcTree_getRelPATH(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertTrue   ('wrong PARENT `FldB`',SrcTree_isParent_4_Item(FldB,FldC));
end;

procedure tTST_srcTree__PATH_get_REL__asNEW.descending_newPATH_Xbc;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:=c_FLDR_X+  PD+c_FLDR_A;
    tstFlder01:=tstFlder00+PD+c_FLDR_B;
    tstFlder02:=tstFlder01+PD+c_FLDR_C;

    //--- должен СОЗДАТЬ новую
    FldA:=SrcTree_getRelPATH(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertTrue   ('wrong PARENT `BaseDIR`',SrcTree_isParent_4_Item(SrcTree_fndBaseDIR(ROOT),FldA));

    //--- должен СОЗДАТЬ новую
    FldB:=SrcTree_getRelPATH(root,tstFlder01);
    AssertNotNull('`FldB` is NIL',FldB);
    AssertTrue   ('wrong PARENT `FldA`',SrcTree_isParent_4_Item(FldA,FldB));

    //--- еще вызов, должен СОЗДАТЬ новую
    FldC:=SrcTree_getRelPATH(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertTrue   ('wrong PARENT `FldB`',SrcTree_isParent_4_Item(FldB,FldC));
end;

procedure tTST_srcTree__PATH_get_REL__asNEW.descending_newPATH_aXc;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:=c_FLDR_A;
    tstFlder01:=tstFlder00+PD+c_FLDR_X+PD+c_FLDR_B;
    tstFlder02:=tstFlder01+PD+c_FLDR_C;

    //--- должен СОЗДАТЬ новую
    FldA:=SrcTree_getRelPATH(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertTrue   ('wrong PARENT `BaseDIR`',SrcTree_isParent_4_Item(SrcTree_fndBaseDIR(ROOT),FldA));

    //--- должен СОЗДАТЬ новую
    FldB:=SrcTree_getRelPATH(root,tstFlder01);
    AssertNotNull('`FldB` is NIL',FldB);
    AssertTrue   ('wrong PARENT `FldA`',SrcTree_isParent_4_Item(FldA,FldB));

    //--- еще вызов, должен СОЗДАТЬ новую
    FldC:=SrcTree_getRelPATH(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertTrue   ('`FldC` wrong PARENT `FldB`',SrcTree_isParent_4_Item(FldB,FldC));
end;

procedure tTST_srcTree__PATH_get_REL__asNEW.descending_newPATH_abX;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:=c_FLDR_A;
    tstFlder01:=tstFlder00+PD+c_FLDR_B;
    tstFlder02:=tstFlder01+PD+c_FLDR_X+PD+c_FLDR_C;

    //--- должен СОЗДАТЬ новую
    FldA:=SrcTree_getRelPATH(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertTrue   ('`FldA` wrong PARENT `BaseDIR`',SrcTree_isParent_4_Item(SrcTree_fndBaseDIR(ROOT),FldA));

    //--- должен СОЗДАТЬ новую
    FldB:=SrcTree_getRelPATH(root,tstFlder01);
    AssertNotNull('`FldB` is NIL',FldB);
    AssertTrue   ('`FldB` wrong PARENT `FldA`',SrcTree_isParent_4_Item(FldA,FldB));

    //--- еще вызов, должен СОЗДАТЬ новую
    FldC:=SrcTree_getRelPATH(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertTrue   ('`FldC` wrong PARENT `FldB`',SrcTree_isParent_4_Item(FldB,FldC));
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree__PATH_get_REL__asNEW.ascendant_newPATH_abc;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:=              c_FLDR_A;
    tstFlder01:=tstFlder00+PD+c_FLDR_B;
    tstFlder02:=tstFlder01+PD+c_FLDR_C;

    //--- должен СОЗДАТЬ новую
    FldC:=SrcTree_getRelPATH(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertTrue   ('`FldC` wrong PARENT `BaseDIR`',SrcTree_isParent_4_Item(SrcTree_fndBaseDIR(ROOT),FldC));

    //--- должен НАЙТИ уже ссозданную
    FldB:=SrcTree_getRelPATH(root,tstFlder01);
    AssertNotNull('`FldB` is NIL',FldB);
    AssertSame   ('`FldC` wrong PARENT `FldB`',FldC.ItemPRNT,FldB);

    //--- должен НАЙТИ уже ссозданную, должна ЛЕЖАТЬ в `BaseDIR`
    FldA:=SrcTree_getRelPATH(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertSame   ('`FldB` wrong PARENT `FldA`',FldB.ItemPRNT,FldA);
    AssertSame   ('`FldA` wrong PARENT `BaseDIR`',FldA.ItemPRNT,SrcTree_fndBaseDIR(ROOT));
end;

procedure tTST_srcTree__PATH_get_REL__asNEW.ascendant_newPATH_Xbc;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:=              c_FLDR_X+PD+c_FLDR_A;
    tstFlder01:=tstFlder00+PD+c_FLDR_B;
    tstFlder02:=tstFlder01+PD+c_FLDR_C;

    //--- должен СОЗДАТЬ новую, она ДОЛЖНА лежать в `BaseDIR`
    FldC:=SrcTree_getRelPATH(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertTrue   ('`FldC` wrong PARENT `BaseDIR`',SrcTree_isParent_4_Item(SrcTree_fndBaseDIR(ROOT),FldC));

    //--- должен НАЙТИ уже ссозданную
    FldB:=SrcTree_getRelPATH(root,tstFlder01);
    AssertNotNull('`FldB` is NIL',FldB);
    AssertSame   ('`FldC` wrong PARENT `FldB`',FldC.ItemPRNT,FldB);

    //--- должен НАЙТИ уже ссозданную, НЕ должна ЛЕЖАТЬ в `BaseDIR`
    FldA:=SrcTree_getRelPATH(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertSame   ('`FldB` wrong PARENT `FldA`',FldB.ItemPRNT,FldA);
    AssertNotSame('`FldA` wrong PARENT',FldA.ItemPRNT,SrcTree_fndBaseDIR(ROOT));

end;

procedure tTST_srcTree__PATH_get_REL__asNEW.ascendant_newPATH_aXc;
var tstFlder00:string;
    tstFlder01:string;
    tstFlder02:string;
begin
    tstFlder00:=                          c_FLDR_A;
    tstFlder01:=tstFlder00+PD+c_FLDR_X+PD+c_FLDR_B;
    tstFlder02:=tstFlder01+PD+c_FLDR_C;

    //--- должен СОЗДАТЬ новую, она ДОЛЖНА лежать в `BaseDIR`
    FldC:=SrcTree_getRelPATH(root,tstFlder02);
    AssertNotNull('`FldC` is NIL',FldC);
    AssertTrue   ('`FldC` wrong PARENT `BaseDIR`',SrcTree_isParent_4_Item(SrcTree_fndBaseDIR(ROOT),FldC));

    //--- должен НАЙТИ уже ссозданную
    FldB:=SrcTree_getRelPATH(root,tstFlder01);
    AssertNotNull('`FldB` is NIL',FldB);
    AssertSame   ('`FldC` wrong PARENT `FldB`',FldC.ItemPRNT,FldB);

    //--- должен НАЙТИ уже ссозданную
    FldA:=SrcTree_getRelPATH(root,tstFlder00);
    AssertNotNull('`FldA` is NIL',FldA);
    AssertSame   ('`FldA` wrong PARENT `BaseDIR`',FldA.ItemPRNT,SrcTree_fndBaseDIR(ROOT));
    AssertNotSame('`FldB` wrong PARENT',FldA.ItemPRNT,FldA);
end;

initialization
    RegisterTest(tTST_srcTree__PATH_get_REL__asNEW);
end.


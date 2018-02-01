unit uTST_003_srcTree__PATH_get_ABS__asNEW;
// по ЗАРАНЕЕ созданому дереву
// ищем "папки" по АБСОЛЮТНОМУ пути, используем `SrcTree_getPathABS`

{$mode objfpc}{$H+}

{todo: ПЕРЕДЕЛАТЬ ТЕСТЫ}

interface

uses
    in0k_lazIdeSRC_srcTree_CORE_item,
    in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
    in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
    in0k_lazIdeSRC_srcTree_item_fsFolder,
    in0k_lazIdeSRC_srcTree_item_Globals,
    //
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
    //
    in0k_lazIdeSRC_srcTree_FNK_fsFLDR_get_ABS,
    //
    Classes, SysUtils, fpcunit, testregistry;

type

 tTST_srcTree__PATH_get_ABS__asNEW=class(TTestCase)
  protected
    lTST:TStrings;
    ROOT:tSrcTree_ROOT;
  protected
    procedure _setUp_(const item:tSrcTree_item; const preFix:string);
  protected
    function  SetUp_lTST_addNode(const prnt:tSrcTree_item; const lPath:string):tSrcTree_item;
    function  SetUp_lTST_extNode(const prnt:tSrcTree_item; const lPath:string):tSrcTree_item;
    procedure SetUp;    override;
    procedure TearDown; override;
  protected
    procedure _TEST_getAbsPATH_asNew_4BASE_;
    procedure _TEST_getAbsPATH_asNew_4OTHR_;
  published
    procedure getABS_base;
  published
    procedure getABS_A;
    procedure getABS_AC;
    procedure getABS_ACD;
    procedure getABS_ACDE;
  end;

implementation

const PD=PathDelim;
const RT='ROOT';

//------------------------------------------------------------------------------

// добавить путь в тестовый список (он ДОЛЖЕН быть найден)
function tTST_srcTree__PATH_get_ABS__asNEW.SetUp_lTST_addNode(const prnt:tSrcTree_item; const lPath:string):tSrcTree_item;
begin // путь который ДОЛЖЕН находиться
    result:=tSrcTree_fsFLDR.Create(lPath);
    SrcTree_insert_ChldLast(prnt,result);
    lTST.AddObject(lPath,result);
end;

// добавить путь пустышку (такого НЕ должно быть найдено)
function tTST_srcTree__PATH_get_ABS__asNEW.SetUp_lTST_extNode(const prnt:tSrcTree_item; const lPath:string):tSrcTree_item;
begin // путь который НЕ должен находиться
    result:=nil;
    lTST.AddObject(lPath,result);
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree__PATH_get_ABS__asNEW._setUp_(const item:tSrcTree_item; const preFix:string);
var tmp:tSrcTree_item;
    fld:string;
begin
    fld:=srcTree_fsFnk_ConcatPaths(GetTempDir,preFix);
    //--- добавляем тестовые пути
    tmp:=item;
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'A');
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'A'+PD+'A');
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'A'+PD+'A'+PD+'A');
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'A'+PD+'A'+PD+'A'+PD+'A');
    //
    tmp:=item;
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'B');
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'B'+PD+'B');
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'B'+PD+'B'+PD+'B');
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'B'+PD+'B'+PD+'B'+PD+'B');
    //
    tmp:=item;
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'D');
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'D'+PD+'D');
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'D'+PD+'D'+PD+'D');
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'D'+PD+'D'+PD+'D'+PD+'D');
    //-
    tmp:=item;
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'E');
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'E'+PD+'E');
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'E'+PD+'E'+PD+'E');
    tmp:=SetUp_lTST_extNode(tmp,fld+PD+'E'+PD+'E'+PD+'E'+PD+'E');
    //
    tmp:=item;
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'F');
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'F'+PD+'F');
    tmp:=SetUp_lTST_extNode(tmp,fld+PD+'F'+PD+'F'+PD+'F');
    tmp:=SetUp_lTST_extNode(tmp,fld+PD+'F'+PD+'F'+PD+'F'+PD+'F');
    //
    tmp:=item;
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'G');
    tmp:=SetUp_lTST_extNode(tmp,fld+PD+'G'+PD+'G');
    tmp:=SetUp_lTST_extNode(tmp,fld+PD+'G'+PD+'G'+PD+'G');
    tmp:=SetUp_lTST_extNode(tmp,fld+PD+'G'+PD+'G'+PD+'G'+PD+'G');
    //
    tmp:=item;
    tmp:=SetUp_lTST_addNode(tmp,fld+PD+'H');
    tmp:=SetUp_lTST_extNode(tmp,fld+PD+'H'+PD+'H');
    tmp:=SetUp_lTST_extNode(tmp,fld+PD+'H'+PD+'H'+PD+'H');
    tmp:=SetUp_lTST_extNode(tmp,fld+PD+'H'+PD+'H'+PD+'H'+PD+'H');
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree__PATH_get_ABS__asNEW.SetUp;
var tmp:tSrcTree_item;
begin
    // делаем коренЬ
    ROOT:=tSrcTree_ROOT.Create('ROOT');  //< собсно создаем
    SrcTree_setBaseDIR(ROOT, GetTempDir+PD+RT); //< устанавливаем ГЛАВНЫЙ путь
    //--- ХРАНИТЕЛЬ тестовых путей
    lTST:=TStringList.Create;
end;

procedure tTST_srcTree__PATH_get_ABS__asNEW.TearDown;
begin
    ROOT.FREE;
    lTST.FREE;
end;

//==============================================================================

procedure tTST_srcTree__PATH_get_ABS__asNEW._TEST_getAbsPATH_asNew_4BASE_;
var res:_tSrcTree_item_fsNodeFLDR_;
      i: integer;
begin
    // ищем по АБСОЛЮТНЫМ
    for i:=0 to lTST.Count-1 do begin
        res:=SrcTree_getFsFldrABS(ROOT,lTST.Strings[i]);
        //--- от ДОЛЖЕН быть или НЕ быть
        if Assigned(lTST.Objects[i])
        then AssertSame('`res` noFound PATH:"'+lTST.Strings[i]+'"',lTST.Objects[i],res)
        else begin
            if not Assigned(res) then Assert(FALSE,'`res` NOT create for PATH:"'+lTST.Strings[i]+'"')
            else begin // оно ДОЛЖНО лежать в БАЗОВОМ
                Assert(SrcTree_isParent_4_Item(SrcTree_fndBaseDIR(ROOT),res),'`res` wrong Parent for PATH:"'+lTST.Strings[i]+'"')
            end;
        end
    end;
end;

procedure tTST_srcTree__PATH_get_ABS__asNEW._TEST_getAbsPATH_asNew_4OTHR_;
var res:_tSrcTree_item_fsNodeFLDR_;
      i: integer;
begin
    // ищем по АБСОЛЮТНЫМ
    for i:=0 to lTST.Count-1 do begin
        res:=SrcTree_getFsFldrABS(ROOT,lTST.Strings[i]);
        //--- от ДОЛЖЕН быть или НЕ быть
        if Assigned(lTST.Objects[i])
        then AssertSame('`res` noFound PATH:"'+lTST.Strings[i]+'"',lTST.Objects[i],res)
        else begin
            if not Assigned(res) then Assert(FALSE,'`res` NOT create for PATH:"'+lTST.Strings[i]+'"')
            else begin // оно ДОЛЖНО лежать в КОРНЕ
                AssertSame('`res` not in ROOT for PATH:"'+lTST.Strings[i]+'"', ROOT,res.ItemPRNT);
            end;
        end
    end;
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree__PATH_get_ABS__asNEW.getABS_base;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(SrcTree_fndBaseDIR(ROOT),RT);
    // ТЕСТЫ ...
   _TEST_getAbsPATH_asNew_4BASE_;
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree__PATH_get_ABS__asNEW.getABS_A;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(ROOT,'A');
    // ТЕСТЫ ...
   _TEST_getAbsPATH_asNew_4OTHR_;
end;

procedure tTST_srcTree__PATH_get_ABS__asNEW.getABS_AC;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(ROOT,'A');
   _setUp_(ROOT,'C');
    // ТЕСТЫ ...
   _TEST_getAbsPATH_asNew_4OTHR_;
end;

procedure tTST_srcTree__PATH_get_ABS__asNEW.getABS_ACD;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(ROOT,'A');
   _setUp_(ROOT,'C');
   _setUp_(ROOT,'D');
    // ТЕСТЫ ...
   _TEST_getAbsPATH_asNew_4OTHR_;
end;

procedure tTST_srcTree__PATH_get_ABS__asNEW.getABS_ACDE;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(ROOT,'A');
   _setUp_(ROOT,'C');
   _setUp_(ROOT,'D');
   _setUp_(ROOT,'E');
    // ТЕСТЫ ...
   _TEST_getAbsPATH_asNew_4OTHR_;
end;

initialization
   // RegisterTest(tTST_srcTree__PATH_get_ABS__asNEW);
end.


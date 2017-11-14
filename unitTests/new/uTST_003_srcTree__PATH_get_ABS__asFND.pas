unit uTST_003_srcTree__PATH_get_ABS__asFND;
// по ЗАРАНЕЕ созданому дереву
// ищем "папки" по АБСОЛЮТНОМУ пути, используем `SrcTree_getPathABS`

{$mode objfpc}{$H+}

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
    in0k_lazIdeSRC_srcTree_FNK_PATH_GET_abs,
    //
    Classes, SysUtils, fpcunit, testregistry;

type

 tTST_srcTree__PATH_fnd_ABS__asFND=class(TTestCase)
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
    procedure _TEST_getAbsPATH_;
  published
    procedure getABS_base;
    procedure getABS_b__A;
    procedure getABS_b_AC;
    procedure getABS_A__b;
    procedure getABS_AC_b;
  published
    procedure getABS_A_b_C;
    procedure getABS_ADb_C;
    procedure getABS_A_bEC;
    procedure getABS_ADbEC;
  end;

implementation

const PD=PathDelim;
const RT='ROOT';

//------------------------------------------------------------------------------

// добавить путь в тестовый список (он ДОЛЖЕН быть найден)
function tTST_srcTree__PATH_fnd_ABS__asFND.SetUp_lTST_addNode(const prnt:tSrcTree_item; const lPath:string):tSrcTree_item;
begin // путь который ДОЛЖЕН находиться
    result:=tSrcTree_fsFLDR.Create(lPath);
    SrcTree_insert_ChldLast(prnt,result);
    lTST.AddObject(lPath,result);
end;

// добавить путь пустышку (такого НЕ должно быть найдено)
function tTST_srcTree__PATH_fnd_ABS__asFND.SetUp_lTST_extNode(const prnt:tSrcTree_item; const lPath:string):tSrcTree_item;
begin // путь который НЕ должен находиться
    result:=nil;
    lTST.AddObject(lPath,result);
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree__PATH_fnd_ABS__asFND._setUp_(const item:tSrcTree_item; const preFix:string);
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
    (*tmp:=item;
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
    tmp:=SetUp_lTST_extNode(tmp,fld+PD+'H'+PD+'H'+PD+'H'+PD+'H'); *)
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree__PATH_fnd_ABS__asFND.SetUp;
var tmp:tSrcTree_item;
begin
    // делаем коренЬ
    ROOT:=tSrcTree_ROOT.Create('ROOT');  //< собсно создаем
    SrcTree_setBaseDIR(ROOT, GetTempDir+PD+RT); //< устанавливаем ГЛАВНЫЙ путь
    //--- ХРАНИТЕЛЬ тестовых путей
    lTST:=TStringList.Create;
end;

procedure tTST_srcTree__PATH_fnd_ABS__asFND.TearDown;
begin
    ROOT.FREE;
    lTST.FREE;
end;

//==============================================================================

procedure tTST_srcTree__PATH_fnd_ABS__asFND._TEST_getAbsPATH_;
var res:_tSrcTree_item_fsNodeFLDR_;
      i: integer;
begin
    // ищем по АБСОЛЮТНЫМ
    for i:=0 to lTST.Count-1 do begin
        res:=SrcTree_getPathABS(ROOT,lTST.Strings[i]);
        //--- от ДОЛЖЕН быть или НЕ быть
        if Assigned(lTST.Objects[i])
        then AssertSame('`res` noFound PATH:"'+lTST.Strings[i]+'"',lTST.Objects[i],res)
        else begin
             if Assigned(res) then Assert(FALSE,'`res` mustNIL PATH:"'+lTST.Strings[i]+'"'+' found:"'+res.fsPath+'"');
        end
    end;
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree__PATH_fnd_ABS__asFND.getABS_base;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(SrcTree_fndBaseDIR(ROOT),RT);
    // ТЕСТЫ ...
   _TEST_getAbsPATH_;
end;

procedure tTST_srcTree__PATH_fnd_ABS__asFND.getABS_b__A;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(SrcTree_fndBaseDIR(ROOT),RT);
   _setUp_(ROOT,'A');
    // ТЕСТЫ ...
   _TEST_getAbsPATH_;
end;

procedure tTST_srcTree__PATH_fnd_ABS__asFND.getABS_b_AC;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(SrcTree_fndBaseDIR(ROOT),RT);
   _setUp_(ROOT,'A');
   _setUp_(ROOT,'C');
    // ТЕСТЫ ...
   _TEST_getAbsPATH_;
end;

procedure tTST_srcTree__PATH_fnd_ABS__asFND.getABS_A__b;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(ROOT,'A');
   _setUp_(SrcTree_fndBaseDIR(ROOT),RT);
    // ТЕСТЫ ...
   _TEST_getAbsPATH_;
end;

procedure tTST_srcTree__PATH_fnd_ABS__asFND.getABS_AC_b;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(ROOT,'A');
   _setUp_(ROOT,'C');
   _setUp_(SrcTree_fndBaseDIR(ROOT),RT);
    // ТЕСТЫ ...
   _TEST_getAbsPATH_;
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree__PATH_fnd_ABS__asFND.getABS_A_b_C;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(ROOT,'A');
   _setUp_(SrcTree_fndBaseDIR(ROOT),RT);
   _setUp_(ROOT,'C');
    // ТЕСТЫ ...
   _TEST_getAbsPATH_;
end;

procedure tTST_srcTree__PATH_fnd_ABS__asFND.getABS_ADb_C;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(ROOT,'A');
   _setUp_(ROOT,'D');
   _setUp_(SrcTree_fndBaseDIR(ROOT),RT);
   _setUp_(ROOT,'C');
    // ТЕСТЫ ...
   _TEST_getAbsPATH_;
end;

procedure tTST_srcTree__PATH_fnd_ABS__asFND.getABS_A_bEC;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(ROOT,'A');
   _setUp_(SrcTree_fndBaseDIR(ROOT),RT);
   _setUp_(ROOT,'E');
   _setUp_(ROOT,'C');
    // ТЕСТЫ ...
   _TEST_getAbsPATH_;
end;

procedure tTST_srcTree__PATH_fnd_ABS__asFND.getABS_ADbEC;
begin
    // создаем ТЕСТОВЫЙ набор
   _setUp_(ROOT,'A');
   _setUp_(ROOT,'D');
   _setUp_(SrcTree_fndBaseDIR(ROOT),RT);
   _setUp_(ROOT,'E');
   _setUp_(ROOT,'C');
    // ТЕСТЫ ...
   _TEST_getAbsPATH_;
end;

initialization
    RegisterTest(tTST_srcTree__PATH_fnd_ABS__asFND);
end.


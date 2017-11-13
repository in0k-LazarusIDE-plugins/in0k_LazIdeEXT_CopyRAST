unit uTST_002_srcTree__PATH_get_REL__asFND;
// по ЗАРАНЕЕ созданому дереву
// ищем "папки" по ОТНОСИТЕЛЬНОМУ пути, используем `SrcTree_getRelPATH`

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

 tTST_srcTree__PATH_get_REL__asFND=class(TTestCase)
  protected
    lTST:TStrings;
    ROOT:tSrcTree_ROOT;
  protected
    function  SetUp_lTST_addNode(const prnt:tSrcTree_item; const lPath:string):tSrcTree_item;
    procedure SetUp;    override;
    procedure TearDown; override;
  published
    procedure asRelative;
  end;

implementation

const PD=PathDelim;

//------------------------------------------------------------------------------

// добавить путь в тестовый список (он ДОЛЖЕН быть найден)
function tTST_srcTree__PATH_get_REL__asFND.SetUp_lTST_addNode(const prnt:tSrcTree_item; const lPath:string):tSrcTree_item;
begin // путь который ДОЛЖЕН находиться
    result:=_tSrcTree_item_fsNodeFLDR_.Create(lPath);
    SrcTree_insert_ChldLast(prnt,result);
    lTST.AddObject(lPath,result);
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree__PATH_get_REL__asFND.SetUp;
var tmp:tSrcTree_item;
begin
    // делаем коренЬ
    ROOT:=tSrcTree_ROOT.Create('ROOT');  //< собсно создаем
    SrcTree_setBaseDIR(ROOT,GetTempDir); //< устанавливаем ГЛАВНЫЙ путь
    //--- ХРАНИТЕЛЬ тестовых путей
    lTST:=TStringList.Create;
    //--- добавляем тестовые пути
    tmp:=SrcTree_fndBaseDIR(ROOT);
    tmp:=SetUp_lTST_addNode(tmp,'A');
    tmp:=SetUp_lTST_addNode(tmp,'A'+PD+'A');
    tmp:=SetUp_lTST_addNode(tmp,'A'+PD+'A'+PD+'A');
    tmp:=SetUp_lTST_addNode(tmp,'A'+PD+'A'+PD+'A'+PD+'A');
    //
    tmp:=SrcTree_fndBaseDIR(ROOT);
    tmp:=SetUp_lTST_addNode(tmp,'B');
    tmp:=SetUp_lTST_addNode(tmp,'B'+PD+'B');
    tmp:=SetUp_lTST_addNode(tmp,'B'+PD+'B'+PD+'B');
    tmp:=SetUp_lTST_addNode(tmp,'B'+PD+'B'+PD+'B'+PD+'B');
    //
    tmp:=SrcTree_fndBaseDIR(ROOT);
    tmp:=SetUp_lTST_addNode(tmp,'D');
    tmp:=SetUp_lTST_addNode(tmp,'D'+PD+'D');
    tmp:=SetUp_lTST_addNode(tmp,'D'+PD+'D'+PD+'D');
    tmp:=SetUp_lTST_addNode(tmp,'D'+PD+'D'+PD+'D'+PD+'D');
end;

procedure tTST_srcTree__PATH_get_REL__asFND.TearDown;
begin
    ROOT.FREE;
    lTST.FREE;
end;

//==============================================================================

procedure tTST_srcTree__PATH_get_REL__asFND.asRelative;
var res:_tSrcTree_item_fsNodeFLDR_;
      i: integer;
begin // ищем как ОТНОСИТЕЛЬНЫЕ
    for i:=0 to lTST.Count-1 do begin
        res:=SrcTree_getPathREL(ROOT,lTST.Strings[i]);
        //--- от ДОЛЖЕН быть или НЕ быть
        if Assigned(lTST.Objects[i])
        then AssertSame('`res` noFound PATH:"'+lTST.Strings[i]+'"',lTST.Objects[i],res)
        else AssertNull('`res` mustNIL PATH:"'+lTST.Strings[i]+'"',res);
    end;
end;

initialization
    RegisterTest(tTST_srcTree__PATH_get_REL__asFND);
end.


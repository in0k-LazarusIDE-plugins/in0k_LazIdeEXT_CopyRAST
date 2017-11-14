unit uTST_002_srcTree__PATH_fnd_REL;
// по ЗАРАНЕЕ созданому дереву
// ищем "папки" по ОТНОСИТЕЛЬНОМУ пути, используем `SrcTree_fndPathREL`

{$mode objfpc}{$H+}

interface

uses
    in0k_lazIdeSRC_srcTree_CORE_item,
    in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
    in0k_lazIdeSRC_srcTree_item_fsFolder,
    in0k_lazIdeSRC_srcTree_item_Globals,
    //
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
    //
    in0k_lazIdeSRC_srcTree_FNK_PATH_FND_rel,
    //
    Classes, SysUtils, fpcunit, testregistry;

type

 tTST_srcTree__PATH_fnd_REL=class(TTestCase)
  protected
    lTST:TStrings;
    ROOT:tSrcTree_ROOT;
  protected
    function  SetUp_lTST_addNode(const prnt:tSrcTree_item; const lPath:string):tSrcTree_item;
    function  SetUp_lTST_extNode(const prnt:tSrcTree_item; const lPath:string):tSrcTree_item;
    procedure SetUp;    override;
    procedure TearDown; override;
  published
    procedure find_relative_path;
  end;

implementation

const PD=PathDelim;

//------------------------------------------------------------------------------

// добавить путь в тестовый список (он ДОЛЖЕН быть найден)
function tTST_srcTree__PATH_fnd_REL.SetUp_lTST_addNode(const prnt:tSrcTree_item; const lPath:string):tSrcTree_item;
begin // путь который ДОЛЖЕН находиться
    result:=tSrcTree_fsFLDR.Create(lPath);
    SrcTree_insert_ChldLast(prnt,result);
    lTST.AddObject(lPath,result);
end;

// добавить путь пустышку (такого НЕ должно быть найдено)
function tTST_srcTree__PATH_fnd_REL.SetUp_lTST_extNode(const prnt:tSrcTree_item; const lPath:string):tSrcTree_item;
begin // путь который НЕ должен находиться
    result:=nil;
    lTST.AddObject(lPath,result);
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree__PATH_fnd_REL.SetUp;
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
    //-
    tmp:=SrcTree_fndBaseDIR(ROOT);
    tmp:=SetUp_lTST_addNode(tmp,'E');
    tmp:=SetUp_lTST_addNode(tmp,'E'+PD+'E');
    tmp:=SetUp_lTST_addNode(tmp,'E'+PD+'E'+PD+'E');
    tmp:=SetUp_lTST_extNode(tmp,'E'+PD+'E'+PD+'E'+PD+'E');
    //
    tmp:=SrcTree_fndBaseDIR(ROOT);
    tmp:=SetUp_lTST_addNode(tmp,'F');
    tmp:=SetUp_lTST_addNode(tmp,'F'+PD+'F');
    tmp:=SetUp_lTST_extNode(tmp,'F'+PD+'F'+PD+'F');
    tmp:=SetUp_lTST_extNode(tmp,'F'+PD+'F'+PD+'F'+PD+'F');
    //
    tmp:=SrcTree_fndBaseDIR(ROOT);
    tmp:=SetUp_lTST_addNode(tmp,'G');
    tmp:=SetUp_lTST_extNode(tmp,'G'+PD+'G');
    tmp:=SetUp_lTST_extNode(tmp,'G'+PD+'G'+PD+'G');
    tmp:=SetUp_lTST_extNode(tmp,'G'+PD+'G'+PD+'G'+PD+'G');
    //
    tmp:=SrcTree_fndBaseDIR(ROOT);
    tmp:=SetUp_lTST_extNode(tmp,'H');
    tmp:=SetUp_lTST_extNode(tmp,'H'+PD+'H');
    tmp:=SetUp_lTST_extNode(tmp,'H'+PD+'H'+PD+'H');
    tmp:=SetUp_lTST_extNode(tmp,'H'+PD+'H'+PD+'H'+PD+'H');
end;

procedure tTST_srcTree__PATH_fnd_REL.TearDown;
begin
    ROOT.FREE;
    lTST.FREE;
end;

//==============================================================================

procedure tTST_srcTree__PATH_fnd_REL.find_relative_path;
var res:_tSrcTree_item_fsNodeFLDR_;
      i: integer;
begin // ищем как ОТНОСИТЕЛЬНЫЕ
    for i:=0 to lTST.Count-1 do begin
        res:=SrcTree_fndPathREL(ROOT,lTST.Strings[i]);
        //--- от ДОЛЖЕН быть или НЕ быть
        if Assigned(lTST.Objects[i])
        then AssertSame('`res` noFound PATH:"'+lTST.Strings[i]+'"',lTST.Objects[i],res)
        else AssertNull('`res` mustNIL PATH:"'+lTST.Strings[i]+'"',res);
    end;
end;

initialization
    RegisterTest(tTST_srcTree__PATH_fnd_REL);
end.


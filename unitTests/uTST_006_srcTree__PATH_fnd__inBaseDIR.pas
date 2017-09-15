unit uTST_006_srcTree__PATH_fnd__inBaseDIR;

{$mode objfpc}{$H+}

interface

uses
    in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
    in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
    in0k_lazIdeSRC_srcTree_item_Globals,
    //
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
    //
    in0k_lazIdeSRC_srcTree_FNK_PATH_rel_GET,
    in0k_lazIdeSRC_srcTree_FNK_PATH_FND,
    //
    Classes, SysUtils, fpcunit, testregistry;

type

 tTST_srcTree__PATH_fnd__inBaseDIR=class(TTestCase)
  protected
    lTST:TStrings;
    ROOT:tSrcTree_ROOT;
  protected
    procedure SetUp_lTST_addNode(const lPath:string);
    procedure SetUp_lTST_extNode(const lPath:string);
    procedure SetUp;    override;
    procedure TearDown; override;
  published
    procedure asRelative;
    procedure asAbsolute;
  end;


implementation

const PD=PathDelim;

procedure tTST_srcTree__PATH_fnd__inBaseDIR.SetUp_lTST_addNode(const lPath:string);
begin // путь который ДОЛЖЕН находиться
    lTST.AddObject(lPath,SrcTree_getRelPATH(ROOT,lPath));
end;

procedure tTST_srcTree__PATH_fnd__inBaseDIR.SetUp_lTST_extNode(const lPath:string);
begin // путь который НЕ должен находиться
    lTST.AddObject(lPath,nil);
end;

procedure tTST_srcTree__PATH_fnd__inBaseDIR.SetUp;
var bDIR:string;
begin
    bDIR:=srcTree_fsFnk_ChompPathDelim(GetTempDir);
    // делаем коренЬ
    ROOT:=tSrcTree_ROOT.Create('ROOT'); //< собсно создаем
    SrcTree_setBaseDIR(ROOT,bDIR);      //< устанавливаем ГЛАВНЫЙ путь
    // добавляем тестовые пути
    lTST:=TStringList.Create;
    //---
    SetUp_lTST_addNode('A');
    SetUp_lTST_addNode('A'+PD+'A');
    SetUp_lTST_addNode('A'+PD+'A'+PD+'A');
    SetUp_lTST_addNode('A'+PD+'A'+PD+'A'+PD+'A');
    //
    SetUp_lTST_addNode('B');
    SetUp_lTST_addNode('B'+PD+'B');
    SetUp_lTST_addNode('B'+PD+'B'+PD+'B');
    SetUp_lTST_addNode('B'+PD+'B'+PD+'B'+PD+'B');
    //
    SetUp_lTST_addNode('C');
    SetUp_lTST_addNode('C'+PD+'C');
    SetUp_lTST_addNode('C'+PD+'C'+PD+'C');
    SetUp_lTST_addNode('C'+PD+'C'+PD+'C'+PD+'C');
    //
    SetUp_lTST_addNode('D');
    SetUp_lTST_addNode('D'+PD+'D');
    SetUp_lTST_addNode('D'+PD+'D'+PD+'D');
    SetUp_lTST_addNode('D'+PD+'D'+PD+'D'+PD+'D');
    //---
    SetUp_lTST_extNode('E');
    SetUp_lTST_addNode('E'+PD+'E');
    SetUp_lTST_addNode('E'+PD+'E'+PD+'E');
    SetUp_lTST_addNode('E'+PD+'E'+PD+'E'+PD+'E');
    //
    SetUp_lTST_extNode('F');
    SetUp_lTST_extNode('F'+PD+'F');
    SetUp_lTST_addNode('F'+PD+'F'+PD+'F');
    SetUp_lTST_addNode('F'+PD+'F'+PD+'F'+PD+'F');
    //
    SetUp_lTST_extNode('G');
    SetUp_lTST_extNode('G'+PD+'G');
    SetUp_lTST_extNode('G'+PD+'G'+PD+'G');
    SetUp_lTST_addNode('G'+PD+'G'+PD+'G'+PD+'G');
end;

procedure tTST_srcTree__PATH_fnd__inBaseDIR.TearDown;
begin
    ROOT.FREE;
    lTST.FREE;
end;

//==============================================================================

procedure tTST_srcTree__PATH_fnd__inBaseDIR.asRelative;
var res:_tSrcTree_item_fsNodeFLDR_;
      i: integer;
begin // ищем как ОТНОСИТЕЛЬНЫЕ
    for i:=0 to lTST.Count-1 do begin
        res:=SrcTree_fndPath(ROOT,lTST.Strings[i]);
        //--- от ДОЛЖЕН быть или НЕ быть
        if Assigned(lTST.Objects[i])
        then AssertSame('`res` noFound PATH:"'+lTST.Strings[i]+'"',lTST.Objects[i],res)
        else AssertNull('`res` mustNIL PATH:"'+lTST.Strings[i]+'"',res);
    end;
end;

procedure tTST_srcTree__PATH_fnd__inBaseDIR.asAbsolute;
var bDIR:string;
     res:_tSrcTree_item_fsNodeFLDR_;
       i: integer;
begin
    bDIR:=srcTree_fsFnk_ChompPathDelim(GetTempDir);
    for i:=0 to lTST.Count-1 do begin
        lTST.Strings[i]:=bDIR+PathDelim+lTST.Strings[i]; //< теперь этот путь АБСОЛЮТНЫЙ
        //
        res:=SrcTree_fndPath(ROOT,lTST.Strings[i]);
        //--- от ДОЛЖЕН быть или НЕ быть
        if Assigned(lTST.Objects[i])
        then AssertSame('`res` noFound PATH:"'+lTST.Strings[i]+'"',lTST.Objects[i],res)
        else AssertNull('`res` mustNIL PATH:"'+lTST.Strings[i]+'"',res);
    end;
end;

initialization//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    RegisterTest(tTST_srcTree__PATH_fnd__inBaseDIR);

end.


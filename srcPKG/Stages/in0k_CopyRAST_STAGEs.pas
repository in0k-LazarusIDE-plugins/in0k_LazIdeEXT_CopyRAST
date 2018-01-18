unit in0k_CopyRAST_STAGEs;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.


uses
  {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
  in0k_lazIdeSRC_srcTree_item_Globals,

  in0k_CopyRAST_srcTree_Stage_0t1,

  in0k_CopyRAST_srcTree_Stage,
  lazExt_CopyRAST__xmlConfig,
  srcTree_builder_CORE;


{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}


type

 tCopyRAST_STAGEs=class
  private
   _mainIdeOBJ_:pointer;
  protected
    function _mainIdeOBJ_GET_:pointer;
    function _mainIdeOBJ_CNF_:tLazExt_CopyRAST_CONFIG; virtual;
  protected
   _srcRoot_:tSrcTree_ROOT;
  protected
   _Builder_:tSrcTree_Builder_CORE;
    function _builder_TYPE_:tSrcTree_Builder_TYPE; virtual;
    function _creater_TYPE_:tSrcTree_Creater_TYPE; virtual;
  protected
   _stage_0t1_:tCopyRast_SrcTree_prcSTAGE;

    procedure _doClear_(const stageIndex:integer); virtual;
  public
    procedure Configs_LOAD;
    procedure Configs_SAVE;

    procedure doStage_0; virtual;
    procedure doStage_1; virtual;
  public
    property Stage_1:tCopyRast_SrcTree_prcSTAGE read _stage_0t1_;
  public
    constructor Create(const MainIdeOobject:TObject); virtual;
    destructor DESTROY; override;
  end;

implementation

constructor tCopyRAST_STAGEs.Create(const MainIdeOobject:TObject);
begin
   _mainIdeOBJ_:= MainIdeOobject;
   _srcRoot_   := nil;
   _Builder_   :=_builder_TYPE_.Create;
   _stage_0t1_ := tCopyRast_SrcTree_prcSTAGE__0_1.Create(_Builder_);
end;

destructor tCopyRAST_STAGEs.DESTROY;
begin
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'.DESTROY','START');{$endIf}
   _doClear_(-1);
    inherited;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'.DESTROY','END');{$endIf}
end;

//------------------------------------------------------------------------------

function tCopyRAST_STAGEs._builder_TYPE_:tSrcTree_Builder_TYPE;
begin
    result:=nil;
end;

function tCopyRAST_STAGEs._creater_TYPE_:tSrcTree_Creater_TYPE;
begin
    result:=nil;
end;

//------------------------------------------------------------------------------

procedure tCopyRAST_STAGEs._doClear_(const stageIndex:integer);
begin
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=???');{$endIf}
    //
    if stageIndex>1 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=1');{$endIf}
   _stage_0t1_.doClear;
    //
    if stageIndex>0 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=0');{$endIf}
   _srcRoot_.FREE;
   _srcRoot_:=nil;
    //
    if stageIndex>=0 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex<0');{$endIf}
   _Builder_.FREE;
end;

//------------------------------------------------------------------------------

function tCopyRAST_STAGEs._mainIdeOBJ_GET_:pointer;
begin
    result:=_mainIdeOBJ_;
end;

function tCopyRAST_STAGEs._mainIdeOBJ_CNF_:tLazExt_CopyRAST_CONFIG;
begin
    result:=nil;
end;

//------------------------------------------------------------------------------

procedure tCopyRAST_STAGEs.Configs_LOAD;
begin
    //
   _stage_0t1_.CNFGs_LOAD(_mainIdeOBJ_CNF_);
end;

procedure tCopyRAST_STAGEs.Configs_SAVE;
begin
    //
   _stage_0t1_.CNFGs_SAVE(_mainIdeOBJ_CNF_);
end;

//------------------------------------------------------------------------------

// создаем дерево исходников на основании ФАйЛОВ проекта/пакета
procedure tCopyRAST_STAGEs.doStage_0;
var tmpCreater:tSrcTree_Creater;
begin
   _doClear_(0);
    //---
    tmpCreater:=_creater_TYPE_.Create;
    try
       _srcRoot_:=tmpCreater.MAKE_SourceTREE(_Builder_,_mainIdeOBJ_);
    finally
	    tmpCreater.FREE;
    end;
end;

procedure tCopyRAST_STAGEs.doStage_1;
begin
   _doClear_(1);
    //
   _stage_0t1_.EXECUTE(_srcRoot_);
    //
end;


end.


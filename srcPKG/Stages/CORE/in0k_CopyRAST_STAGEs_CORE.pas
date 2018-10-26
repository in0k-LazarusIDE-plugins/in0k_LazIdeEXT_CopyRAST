unit in0k_CopyRAST_STAGEs_CORE;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.


uses
  sysutils,

  {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
  ProjectIntf,
  PackageIntf,

  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_CopyRAST_srcTree_ITEMs,
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  //
  //

//  in0k_CopyRAST_srcTree_Stage,
  lazExt_CopyRAST__xmlConfig,
  srcTree_builder_CORE;


{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}


type
 tCopyRAST_STAGEs_CORE=class;
 tCopyRast_STAGE=class;


 mCopyRast_STAGE_onRootChange=procedure(const Sender:tCopyRast_STAGE; const newRoot:tCopyRast_stROOT) of object;


 tCopyRast_STAGE=class
  protected
   _owner_:tCopyRAST_STAGEs_CORE;
    function _owner_Builder:tSrcTree_Builder_CORE;
    function _owner_Ide_OBJ:tObject;
  protected //< что хотим получить
   _resultROOT_:tCopyRast_stROOT;
   _resultROOT_mOnCHANGE_:mCopyRast_STAGE_onRootChange;
    procedure _resultROOT_SET_(const value:tCopyRast_stROOT); {$ifOpt D-}inline;{$endIf}
    procedure _result_CLR_; virtual;
  protected // работа с Конфигурацией
    procedure _CNFGs_INIT_;                                        virtual;
    procedure _CNFGs_FREE_;                                        virtual;
    procedure _CNFGs_LOAD_(const Configs:tLazExt_CopyRAST_CONFIG); virtual;
    procedure _CNFGs_SAVE_(const Configs:tLazExt_CopyRAST_CONFIG); virtual;
  public
    constructor Create(const STAGEs:tCopyRAST_STAGEs_CORE);        virtual;
    destructor DESTROY; override;
  public // работа с Конфигурацией
    procedure  CNFGs_LOAD (const Configs:tLazExt_CopyRAST_CONFIG);
    procedure  CNFGs_SAVE (const Configs:tLazExt_CopyRAST_CONFIG);
  public
    property RootRESULT_onChange:mCopyRast_STAGE_onRootChange  write _resultROOT_mOnCHANGE_;
    property RootRESULT         :tCopyRast_stROOT              read  _resultROOT_;
  public
    procedure DoCLEAN(const full:boolean=true); virtual;
  end;

 tCopyRast_SrcTree_STAGE_00=class(tCopyRast_STAGE)
  protected
   _creater_:tSrcTree_Creater;
  public
    constructor Create(const STAGEs:tCopyRAST_STAGEs_CORE; const treeCreater:tSrcTree_Creater);
    destructor DESTROY; override;
  public
    function EXECUTE:boolean;
  end;

 tCopyRast_STAGE_=class(tCopyRast_STAGE)
  public
    //function EXECUTE(const srcROOT:tCopyRast_stROOT):boolean; virtual;
  end;


 tCopyRast_SrcTree_STAGE_L_R=class(tCopyRast_STAGE_)
  protected
   _enabled_:boolean;
  protected //< над чем работаем
   _sourceROOT_:tCopyRast_stROOT;
   _sourceROOT_mOnCHANGE_:mCopyRast_STAGE_onRootChange;
    procedure _sourceROOT_SET_(const value:tCopyRast_stROOT); virtual;
  protected
    procedure _source_CLR_; virtual;
  public
    constructor Create(const STAGEs:tCopyRAST_STAGEs_CORE); override;
    destructor DESTROY; override;
  public
    property RootSOURCE_onChange:mCopyRast_STAGE_onRootChange  write _sourceROOT_mOnCHANGE_;
    property RootSOURCE         :tCopyRast_stROOT              read  _sourceROOT_;
  protected
    function _execute_makeResultROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT; virtual;
  public
    property  Enabled:boolean read _enabled_ write _enabled_;
    function  EXECUTE(const srcROOT:tCopyRast_stROOT):boolean; virtual;
    procedure DoCLEAN(const full:boolean=true); override;
  end;

 tCopyRast_SrcTree_STAGE_LMR=class(tCopyRast_SrcTree_STAGE_L_R)
  protected
    procedure _sourceROOT_SET_(const value:tCopyRast_stROOT); overload;
  protected //< над чем РЕАЛЬНО работаем
   _midlleROOT_:tCopyRast_stROOT;
   _midlleROOT_mOnCHANGE_:mCopyRast_STAGE_onRootChange;
    procedure _midlleROOT_SET_(const value:tCopyRast_stROOT); {$ifOpt D-}inline;{$endIf}
  protected
    procedure _midlle_CLR_; virtual;
  public
    constructor Create(const STAGEs:tCopyRAST_STAGEs_CORE);
    destructor DESTROY; override;
  public
    property RootMIDDLE_onChange:mCopyRast_STAGE_onRootChange  write _midlleROOT_mOnCHANGE_;
    property RootMIDDLE         :tCopyRast_stROOT              read  _midlleROOT_;
  protected
    function _execute_makeMidlleROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT; virtual;
  public
    function  EXECUTE(const srcROOT:tCopyRast_stROOT):boolean; override;
  end;




 mCopyRAST_STAGEs_onCLEAN=procedure(const Sender:tObject; const stageIndex:integer) of object;
 mCopyRAST_STAGEs_onSTAGE=procedure(const Sender:tObject; const stageIndex:integer) of object;

 tCopyRAST_STAGEs_CORE=class
  private
   _mainIdeOBJ_:pointer;
  private
    function _CNFG_fileName_4IDE_:string;
    function _CNFG_fileName_4EXT_:string;
    function _CNFG_fndInFile_IDE_:boolean;
    function _CNFG_fndInFile_EXT_:boolean;
  private
   _CNFG_inSideInIDE_:boolean;
    procedure _CNFG_setUp_onCreate_;
    function  _CNFG_create_xml_OBJ_(const forIde:boolean):tLazExt_CopyRAST_CONFIG;
  public
    property Config_InsideInIDE:boolean read _CNFG_inSideInIDE_ write _CNFG_inSideInIDE_;
    property ConfigFileName4IDE:string  read _CNFG_fileName_4IDE_;
    property ConfigFileName4EXT:string  read _CNFG_fileName_4EXT_;


  protected
    function _mainIdeOBJ_GET_:pointer;
    //function _mainIdeOBJ_CNF_:tLazExt_CopyRAST_CONFIG; virtual;
  protected
   _srcRoot_:tSrcTree_ROOT;
  protected
   _Builder_:tSrcTree_Builder_CORE;
    function _builder_TYPE_:tSrcTree_Builder_TYPE; virtual;
    function _creater_TYPE_:tSrcTree_Creater_TYPE; virtual;
  protected
   _stageIDX_:integer;
   _stageEND_:boolean;
   _stage_00_:tCopyRast_SrcTree_STAGE_00;
   _stage_01_:tCopyRast_SrcTree_STAGE_L_R;
   _stage_02_:tCopyRast_SrcTree_STAGE_L_R;
   _stage_03_:tCopyRast_SrcTree_STAGE_L_R;
   _stage_04_:tCopyRast_SrcTree_STAGE_L_R;
   _stage_05_:tCopyRast_SrcTree_STAGE_L_R;
    procedure _stages_CRT_; virtual;
  protected
   _mOn_Clear_:mCopyRAST_STAGEs_onCLEAN;
    procedure _doClear_(const stageIndex:integer); virtual;
    procedure _goCLEAR_(const stageIndex:integer);
  protected
   _mOn_Stage_:mCopyRAST_STAGEs_onSTAGE;
    procedure _doStage_0_;                         virtual;
    procedure _doStage_(const stageIndex:integer); virtual;
    procedure _goSTAGE_(const stageIndex:integer);
  public
    procedure Configs_LOAD;
    procedure Configs_SAVE;
  public
    procedure DoSTAGE(const stageIndex:integer);
    procedure DoCLEAN(const stageIndex:integer);
  public
    property SrcTREE:tSrcTree_ROOT read _srcRoot_;
  public
    property STAGE_IDX:integer read _stageIDX_;
    property STAGE_END:boolean read _stageEND_;

  public
    property onCLEAN:mCopyRAST_STAGEs_onCLEAN read _mOn_Clear_ write _mOn_Clear_;
    property onSTAGE:mCopyRAST_STAGEs_onSTAGE read _mOn_Stage_ write _mOn_Stage_;
  public
    property Stage_0:tCopyRast_SrcTree_STAGE_00  read _stage_00_;
    property Stage_1:tCopyRast_SrcTree_STAGE_L_R read _stage_01_;
    property Stage_2:tCopyRast_SrcTree_STAGE_L_R read _stage_02_;
    property Stage_3:tCopyRast_SrcTree_STAGE_L_R read _stage_03_;
    property Stage_4:tCopyRast_SrcTree_STAGE_L_R read _stage_04_;
    property Stage_5:tCopyRast_SrcTree_STAGE_L_R read _stage_05_;
  public
    constructor Create(const MainIdeOobject:TObject); virtual;
    destructor DESTROY; override;
  end;

implementation
uses in0k_CopyRAST__STAGE_05__editFiles;

constructor tCopyRast_STAGE.Create(const STAGEs:tCopyRAST_STAGEs_CORE);
begin
   _owner_:=STAGEs;
   _CNFGs_INIT_;
    //
   _resultROOT_mOnCHANGE_:=nil;
   _resultROOT_          :=nil;
end;

destructor tCopyRast_STAGE.DESTROY;
begin
   _result_CLR_;
    //---
   _CNFGs_FREE_;
    inherited;
end;

//------------------------------------------------------------------------------

function tCopyRast_STAGE._owner_Builder:tSrcTree_Builder_CORE;
begin
    result:=_owner_._Builder_;
end;

function tCopyRast_STAGE._owner_Ide_OBJ:tObject;
begin
    result:=tObject(_owner_._mainIdeOBJ_GET_);
end;

//------------------------------------------------------------------------------

procedure tCopyRast_STAGE._resultROOT_SET_(const value:tCopyRast_stROOT);
var tmpRoot:tCopyRast_stROOT;
begin
    if _resultROOT_<>value then begin
        tmpRoot    :=_resultROOT_;
       _resultROOT_:= value;
        if Assigned(_resultROOT_mOnCHANGE_) then _resultROOT_mOnCHANGE_(self,_resultROOT_);
        tmpRoot.Free;
    end;
end;

//------------------------------------------------------------------------------

procedure tCopyRast_STAGE._result_CLR_;
begin
   _resultROOT_SET_(NIL);
end;

//------------------------------------------------------------------------------

procedure tCopyRast_STAGE.DoCLEAN(const full:boolean=true);
begin
   _result_CLR_;
end;

//------------------------------------------------------------------------------

procedure tCopyRast_STAGE._CNFGs_INIT_;
begin
    //
end;

procedure tCopyRast_STAGE._CNFGs_FREE_;
begin
    //
end;

procedure tCopyRast_STAGE._CNFGs_LOAD_(const Configs:tLazExt_CopyRAST_CONFIG);
begin
    //
end;

procedure tCopyRast_STAGE._CNFGs_SAVE_(const Configs:tLazExt_CopyRAST_CONFIG);
begin
    //
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRast_STAGE.CNFGs_LOAD(const Configs:tLazExt_CopyRAST_CONFIG);
begin
    // чистим
   _CNFGs_FREE_;
   _CNFGs_INIT_;
    // загружаем
   _CNFGs_LOAD_(Configs);
end;

procedure tCopyRast_STAGE.CNFGs_SAVE(const Configs:tLazExt_CopyRAST_CONFIG);
begin
   _CNFGs_SAVE_(Configs);
end;


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

constructor tCopyRast_SrcTree_STAGE_00.Create(const STAGEs:tCopyRAST_STAGEs_CORE; const treeCreater:tSrcTree_Creater);
begin
    inherited Create(STAGEs);
   _creater_:=treeCreater;
end;

destructor tCopyRast_SrcTree_STAGE_00.DESTROY;
begin
    inherited;
   _creater_.FREE;
end;

//------------------------------------------------------------------------------

function tCopyRast_SrcTree_STAGE_00.EXECUTE:boolean;
var tmpRes:tCopyRast_stROOT;
begin
    tmpRes:=_creater_.MAKE_SourceTREE(_owner_Builder,_owner_Ide_OBJ);
   _resultROOT_SET_(tmpRes);
end;


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

{function tCopyRast_STAGE_CORE.EXECUTE(const srcROOT:tCopyRast_stROOT):boolean;
begin

end;}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

constructor tCopyRast_SrcTree_STAGE_L_R.Create(const STAGEs:tCopyRAST_STAGEs_CORE);
begin
    inherited Create(STAGEs);
   _enabled_             :=false;
   _sourceROOT_mOnCHANGE_:=nil;
   _sourceROOT_          :=nil;
end;

destructor tCopyRast_SrcTree_STAGE_L_R.DESTROY;
begin
   _result_CLR_;
   _source_CLR_;
    inherited;
end;

//------------------------------------------------------------------------------

procedure tCopyRast_SrcTree_STAGE_L_R._sourceROOT_SET_(const value:tCopyRast_stROOT);
begin
    if _sourceROOT_<>value then begin
       _result_CLR_;
       _sourceROOT_:=value;
        if Assigned(_sourceROOT_mOnCHANGE_) then _sourceROOT_mOnCHANGE_(self,_sourceROOT_);
    end;
end;

procedure tCopyRast_SrcTree_STAGE_L_R._source_CLR_;
begin
   _sourceROOT_SET_(NIL);
end;

//------------------------------------------------------------------------------

function tCopyRast_SrcTree_STAGE_L_R._execute_makeResultROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT;
begin
    result:=nil;
end;

function tCopyRast_SrcTree_STAGE_L_R.EXECUTE(const srcROOT:tCopyRast_stROOT):boolean;
var tmpROOT:tCopyRast_stROOT;
begin
   _result_CLR_;
   _sourceROOT_SET_(srcROOT);
    if _enabled_ then begin
        tmpROOT:=_execute_makeResultROOT_(_sourceROOT_);
    end
    else begin //< тут ПРОСТО копируем _sourceROOT_->_resultROOT_
        tmpROOT:=CopyRast_SrcTree_copyLeft2Right(_sourceROOT_);
    end;
   _resultROOT_SET_(tmpROOT);
end;

//------------------------------------------------------------------------------

procedure tCopyRast_SrcTree_STAGE_L_R.DoCLEAN(const full:boolean=true);
begin
    inherited;
    if full then _sourceROOT_SET_(nil);
end;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

constructor tCopyRast_SrcTree_STAGE_LMR.Create(const STAGEs:tCopyRAST_STAGEs_CORE);
begin
    inherited;
   _midlleROOT_mOnCHANGE_:=nil;
   _midlleROOT_          :=nil;
end;

destructor tCopyRast_SrcTree_STAGE_LMR.DESTROY;
begin
   _result_CLR_;
   _midlle_CLR_;
   _source_CLR_;
    inherited;
end;

//------------------------------------------------------------------------------

procedure tCopyRast_SrcTree_STAGE_LMR._sourceROOT_SET_(const value:tCopyRast_stROOT); overload;
begin
    if _sourceROOT_<>value then begin
       _result_CLR_;
       _midlle_CLR_;
       _sourceROOT_:=value;
        if Assigned(_sourceROOT_mOnCHANGE_) then _sourceROOT_mOnCHANGE_(self,_sourceROOT_);
    end;
end;

//------------------------------------------------------------------------------

procedure tCopyRast_SrcTree_STAGE_LMR._midlle_CLR_;
begin
   _midlleROOT_SET_(NIL);
end;

procedure tCopyRast_SrcTree_STAGE_LMR._midlleROOT_SET_(const value:tCopyRast_stROOT);
var tmpRoot:tCopyRast_stROOT;
begin
    if _midlleROOT_<>value then begin
        tmpRoot    :=_midlleROOT_;
       _midlleROOT_:= value;
        if Assigned(_midlleROOT_mOnCHANGE_) then _midlleROOT_mOnCHANGE_(self,_midlleROOT_);
        tmpRoot.Free;
    end;
end;

//------------------------------------------------------------------------------

function tCopyRast_SrcTree_STAGE_LMR._execute_makeMidlleROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT;
begin
   //
end;

function tCopyRast_SrcTree_STAGE_LMR.EXECUTE(const srcROOT:tCopyRast_stROOT):boolean;
var tmpMiddleROOT:tCopyRast_stROOT;
var tmpResultROOT:tCopyRast_stROOT;
begin
   _result_CLR_;
   _midlle_CLR_;
   _sourceROOT_SET_(srcROOT);
    if _enabled_ then begin
        tmpMiddleROOT:=_execute_makeMidlleROOT_(_sourceROOT_);
        tmpResultROOT:=_execute_makeResultROOT_( tmpMiddleROOT);
    end
    else begin //< тут ПРОСТО копируем _sourceROOT_->_resultROOT_
        tmpMiddleROOT:=CopyRast_SrcTree_copyLeft2Right(_sourceROOT_);
        tmpResultROOT:=CopyRast_SrcTree_copyLeft2Right( tmpMiddleROOT);
    end;
   _midlleROOT_SET_(tmpMiddleROOT);
   _resultROOT_SET_(tmpResultROOT);
end;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------


//==============================================================================


constructor tCopyRAST_STAGEs_CORE.Create(const MainIdeOobject:TObject);
begin
   _mainIdeOBJ_:= MainIdeOobject;
   _srcRoot_   := nil;
   _Builder_   :=_builder_TYPE_.Create;
    //---
//   _mOn_Clear_ :=nil;
//   _mOn_Stage_ :=nil;
    //---
   _stageIDX_  := 0;
   _stageEND_  := FALSE;
   _stages_CRT_;
    //---
    //---
   _CNFG_setUp_onCreate_;
end;

destructor tCopyRAST_STAGEs_CORE.DESTROY;
begin
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'.DESTROY','START');{$endIf}
    // чистим ДАННЫЕ
   _goCLEAR_(-1);
    // чистим ОБЪЕКТЫ
   _stage_05_.FREE;
   _stage_04_.FREE;
   _stage_03_.FREE;
   _stage_02_.FREE;
   _stage_01_.FREE;
   _stage_00_.FREE;
    // остальное
   _Builder_.Free;
    inherited;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'.DESTROY','END');{$endIf}
end;

//------------------------------------------------------------------------------

procedure tCopyRAST_STAGEs_CORE._stages_CRT_;
begin
   _stage_00_  := tCopyRast_SrcTree_STAGE_00.Create(self,_creater_TYPE_.Create);
   _stage_01_  := nil;//tCopyRast_SrcTree_STAGE_L_R.Create;//(_Builder_);
   _stage_02_  := nil;//tCopyRast_SrcTree_STAGE_L_R.Create;//tCopyRast_stage__JustCopying.Create(_Builder_);
   _stage_03_  := nil;//tCopyRast_SrcTree_STAGE_L_R.Create;//tCopyRast_stage__ChangePaths.Create(_Builder_);
   _stage_04_  := nil;//tCopyRast_SrcTree_STAGE_L_R.Create;//tCopyRast_stage__JustCopying.Create(_Builder_);
   _stage_05_  := nil;//tCopyRast_SrcTree_STAGE_L_R.Create;//tCopyRast_stage__JustCopying.Create(_Builder_);
end;

//------------------------------------------------------------------------------

function tCopyRAST_STAGEs_CORE._builder_TYPE_:tSrcTree_Builder_TYPE;
begin
    result:=nil;
end;

function tCopyRAST_STAGEs_CORE._creater_TYPE_:tSrcTree_Creater_TYPE;
begin
    result:=nil;
end;

//------------------------------------------------------------------------------

procedure tCopyRAST_STAGEs_CORE._doClear_(const stageIndex:integer);
begin
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=???');{$endIf}
    //
    if stageIndex>5 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=5');{$endIf}
   _stage_05_.DoCLEAN(stageIndex<5);
    //
    if stageIndex>4 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=4');{$endIf}
   _stage_04_.DoCLEAN(stageIndex<4);
    //
    if stageIndex>3 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=3');{$endIf}
   _stage_03_.DoCLEAN(stageIndex<3);
    //
    if stageIndex>2 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=2');{$endIf}
   _stage_02_.DoCLEAN(stageIndex<2);
    //
    if stageIndex>1 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=1');{$endIf}
   _stage_01_.DoCLEAN(stageIndex<1);
    //
    if stageIndex>0 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=0');{$endIf}
   _stage_00_.DoCLEAN(stageIndex<0);
    //
    if stageIndex>=0 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex<0');{$endIf}
end;

procedure tCopyRAST_STAGEs_CORE._goCLEAR_(const stageIndex:integer);
begin
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._goCLEAR_',inttostr(stageIndex));{$endIf}
   _stageIDX_:=stageIndex;
   _stageEND_:=FALSE;
    if Assigned(_mOn_Clear_) then _mOn_Clear_(self,stageIndex);
   _doClear_(stageIndex);
end;

//------------------------------------------------------------------------------

// создаем дерево исходников на основании ФАйЛОВ проекта/пакета
procedure tCopyRAST_STAGEs_CORE._doStage_0_;
var tmpCreater:tSrcTree_Creater;
begin
    tmpCreater:=_creater_TYPE_.Create;
    try
       _srcRoot_:=tmpCreater.MAKE_SourceTREE(_Builder_,_mainIdeOBJ_);
    finally
       tmpCreater.FREE;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRAST_STAGEs_CORE._doStage_(const stageIndex:integer);
begin
    case stageIndex of
      //0:_doStage_0_;
      0:_stage_00_.EXECUTE;
      1:_stage_01_.EXECUTE(_stage_00_.RootRESULT);
      2:_stage_02_.EXECUTE(_stage_01_.RootRESULT);
      3:_stage_03_.EXECUTE(_stage_02_.RootRESULT);
      4:_stage_04_.EXECUTE(_stage_03_.RootRESULT);
      5:tCopyRast_STAGE_05__editFiles(_stage_05_).EXECUTE(_stage_04_.RootSOURCE,_stage_04_.RootRESULT);
    end;
end;

procedure tCopyRAST_STAGEs_CORE._goSTAGE_(const stageIndex:integer);
begin
   {$ifdef _DEBUG_}DEBUG(self.ClassName+'._goSTAGE_',inttostr(stageIndex));{$endIf}
   _stageIDX_:=stageIndex;
   _doStage_(stageIndex);
   _stageEND_:=TRUE;
    if Assigned(_mOn_Stage_) then _mOn_Stage_(self,stageIndex);
end;

//------------------------------------------------------------------------------

function tCopyRAST_STAGEs_CORE._mainIdeOBJ_GET_:pointer;
begin
    result:=_mainIdeOBJ_;
end;

{function tCopyRAST_STAGEs_CORE._mainIdeOBJ_CNF_:tLazExt_CopyRAST_CONFIG;
begin
    result:=nil;
end;}

//------------------------------------------------------------------------------

procedure tCopyRAST_STAGEs_CORE.Configs_LOAD;
var xmlCNFG:tLazExt_CopyRAST_CONFIG;
begin
    xmlCNFG:=_CNFG_create_xml_OBJ_(_CNFG_inSideInIDE_);
    //
    //CheckBoxThemed1.Checked:=CRxC_BASE__SettingsEXCLUDE(cnf);
    //
   _stage_01_.CNFGs_LOAD(xmlCNFG);
   _stage_02_.CNFGs_LOAD(xmlCNFG);
   _stage_03_.CNFGs_LOAD(xmlCNFG);
   _stage_04_.CNFGs_LOAD(xmlCNFG);
   _stage_05_.CNFGs_LOAD(xmlCNFG);
    //
    xmlCNFG.FREE;
end;

procedure tCopyRAST_STAGEs_CORE.Configs_SAVE;
var xmlCNFG:tLazExt_CopyRAST_CONFIG;
begin
    //--- сначала пытаемся очистить в СТАРЫХ местах
    {todo: разбираться с МЕСТОМ хранения настроек}
    (*if inIde then begin
        // чистим кеши LAZARUS`a
        tmp:=CopyRAST_fileConfig_FIND(_getConfigFileName_EXT_,FALSE);
        tmp.FREE;
        // физически идаляем файл
        DeleteFile(_getConfigFileName_EXT_);
    end
    else begin
        tmp:=CopyRAST_fileConfig_FIND(_getConfigFileName_IDE_,FALSE);
        if Assigned(tmp) then tmp.DeletePath(cLazExt_CopyRAST__xmlConfig_SECTION);
    end;*)
    //--- получаем ЭКЗЕМПЛЯР
    xmlCNFG:=_CNFG_create_xml_OBJ_(_CNFG_inSideInIDE_);
    //
    //CheckBoxThemed1.Checked:=CRxC_BASE__SettingsEXCLUDE(cnf);
    //
   _stage_01_.CNFGs_SAVE(xmlCNFG);
   _stage_02_.CNFGs_SAVE(xmlCNFG);
   _stage_03_.CNFGs_SAVE(xmlCNFG);
   _stage_04_.CNFGs_SAVE(xmlCNFG);
   _stage_05_.CNFGs_SAVE(xmlCNFG);
    //
    xmlCNFG.FREE;
end;

//------------------------------------------------------------------------------

procedure tCopyRAST_STAGEs_CORE.DoSTAGE(const stageIndex:integer);
begin
   _goCLEAR_(stageIndex);
   _goSTAGE_(stageIndex);
end;

procedure tCopyRAST_STAGEs_CORE.DoCLEAN(const stageIndex:integer);
begin
   _goCLEAR_(stageIndex);
end;

//------------------------------------------------------------------------------

// по сути просто получаем ИМЯ ГЛАВНОГО Файла
function tCopyRAST_STAGEs_CORE._CNFG_fileName_4IDE_:string;
begin
    result:='';
    if Assigned(_mainIdeOBJ_) then begin
        if tObject(_mainIdeOBJ_) is TLazProject
        then result:=TLazProject(_mainIdeOBJ_).ProjectInfoFile
       else
        if tObject(_mainIdeOBJ_) is TIDEPackage
        then result:=TIDEPackage(_mainIdeOBJ_).Filename;
    end;
end;

// по сути меняем РАСШИРЕНИЕ ГЛАВНОГО Файла на НАШЕ
function tCopyRAST_STAGEs_CORE._CNFG_fileName_4EXT_:string;
begin
    result:=srcTree_fsFnk_ChangeFileExt(_CNFG_fileName_4IDE_,'.CopyRAST');
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCopyRAST_STAGEs_CORE._CNFG_fndInFile_IDE_:boolean;
var tmp:tLazExt_CopyRAST_CONFIG;
begin {todo: разбираться с МЕСТОМ хранения настроек}
    result:=FALSE;
    (*tmp:=CopyRAST_fileConfig_FIND(_getConfigFileName_IDE_,FALSE);
    if Assigned(tmp) then begin
        result:=CRxC_BASE__SettingsPRESENT(tmp);
    end;
    tmp.WriteToDisk;
    tmp.FREE;*)
end;

function tCopyRAST_STAGEs_CORE._CNFG_fndInFile_EXT_:boolean;
var tmp:tLazExt_CopyRAST_CONFIG;
begin {todo: разбираться с МЕСТОМ хранения настроек}
    result:=TRUE;
    (*tmp:=CopyRAST_fileConfig_FIND(_getConfigFileName_EXT_,TRUE);
    if Assigned(tmp) then begin
        result:=CRxC_BASE__SettingsPRESENT(tmp);
    end;
    tmp.WriteToDisk;
    tmp.FREE;*)
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRAST_STAGEs_CORE._CNFG_setUp_onCreate_;
var inIDE:boolean;
    inEXT:boolean;
begin
    {todo: разбираться с МЕСТОМ хранения настроек}
    inIde:=_CNFG_fndInFile_IDE_;
    inEXT:=_CNFG_fndInFile_EXT_;
    //---
    if inIde and inEXT then begin
      _CNFG_inSideInIDE_:=TRUE;
    end
    else
    if inIde then begin
      _CNFG_inSideInIDE_:=TRUE;
    end
    else
    if inEXT then begin
      _CNFG_inSideInIDE_:=FALSE;
    end
    else begin
      _CNFG_inSideInIDE_:=TRUE;
    end;
end;

function tCopyRAST_STAGEs_CORE._CNFG_create_xml_OBJ_(const forIde:boolean):tLazExt_CopyRAST_CONFIG;
begin
    if forIde
    then result:=CopyRAST_fileConfig_FIND(_CNFG_fileName_4IDE_,false)
    else result:=CopyRAST_fileConfig_FIND(_CNFG_fileName_4EXT_,true);
end;

//==============================================================================

end.


unit in0k_CopyRAST_STAGEs;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.


uses
  {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
  ProjectIntf,
  PackageIntf,

  in0k_lazIdeSRC_srcTree_item_Globals,

  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  //
  in0k_CopyRAST_stage__JustCopying,
  in0k_CopyRAST_stage__FileHandling,
  in0k_CopyRAST_stage__ChangePaths,
  //
  in0k_CopyRAST_srcTree_Stage,
  lazExt_CopyRAST__xmlConfig,
  srcTree_builder_CORE;


{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}


type
 tCopyRAST_STAGEs=class;

 mCopyRAST_STAGEs_onCLEAN=procedure(const Sender:tCopyRAST_STAGEs; const stageIndex:integer) of object;
 mCopyRAST_STAGEs_onSTAGE=procedure(const Sender:tCopyRAST_STAGEs; const stageIndex:integer) of object;

 tCopyRAST_STAGEs=class
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
   _stage_01_:tCopyRast_SrcTree_prcSTAGE;
   _stage_02_:tCopyRast_SrcTree_prcSTAGE;
   _stage_03_:tCopyRast_SrcTree_prcSTAGE;
   _stage_04_:tCopyRast_SrcTree_prcSTAGE;
   _stage_05_:tCopyRast_SrcTree_prcSTAGE;
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
    property Stage_1:tCopyRast_SrcTree_prcSTAGE read _stage_01_;
    property Stage_2:tCopyRast_SrcTree_prcSTAGE read _stage_02_;
    property Stage_3:tCopyRast_SrcTree_prcSTAGE read _stage_03_;
    property Stage_4:tCopyRast_SrcTree_prcSTAGE read _stage_04_;
    property Stage_5:tCopyRast_SrcTree_prcSTAGE read _stage_05_;
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
    //---
   _mOn_Clear_ :=nil;
   _mOn_Stage_ :=nil;
    //---
   _stageIDX_  := 0;
   _stageEND_  := FALSE;
   _stage_01_  := tCopyRast_stage__FileHandling.Create(_Builder_);
   _stage_02_  := tCopyRast_stage__JustCopying.Create(_Builder_);
   _stage_03_  := tCopyRast_stage__ChangePaths.Create(_Builder_);
   _stage_04_  := tCopyRast_stage__JustCopying.Create(_Builder_);
   _stage_05_  := tCopyRast_stage__JustCopying.Create(_Builder_);
    //---
   _CNFG_setUp_onCreate_;
end;

destructor tCopyRAST_STAGEs.DESTROY;
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
    // остальное
   _Builder_.Free;
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
    if stageIndex>5 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=5');{$endIf}
   _stage_05_.doClear(stageIndex<5);
    //
    if stageIndex>4 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=4');{$endIf}
   _stage_04_.doClear(stageIndex<4);
    //
    if stageIndex>3 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=3');{$endIf}
   _stage_03_.doClear(stageIndex<3);
    //
    if stageIndex>2 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=2');{$endIf}
   _stage_02_.doClear(stageIndex<2);
    //
    if stageIndex>1 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=1');{$endIf}
   _stage_01_.doClear(stageIndex<1);
    //
    if stageIndex>0 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex=0');{$endIf}
   _srcRoot_.FREE;
   _srcRoot_:=nil;
    //
    if stageIndex>=0 then EXIT;
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._doClear_','stageIndex<0');{$endIf}
end;

procedure tCopyRAST_STAGEs._goCLEAR_(const stageIndex:integer);
begin
    {$ifdef _DEBUG_}DEBUG(self.ClassName+'._goCLEAR_',inttostr(stageIndex));{$endIf}
   _stageIDX_:=stageIndex;
   _stageEND_:=FALSE;
    if Assigned(_mOn_Clear_) then _mOn_Clear_(self,stageIndex);
   _doClear_(stageIndex);
end;

//------------------------------------------------------------------------------

// создаем дерево исходников на основании ФАйЛОВ проекта/пакета
procedure tCopyRAST_STAGEs._doStage_0_;
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

procedure tCopyRAST_STAGEs._doStage_(const stageIndex:integer);
begin
    case stageIndex of
      0:_doStage_0_;
      1:_stage_01_.EXECUTE(_srcRoot_);
      2:_stage_02_.EXECUTE(_stage_01_.ROOT_Target);
      3:_stage_03_.EXECUTE(_stage_02_.ROOT_Target);
      4:_stage_04_.EXECUTE(_stage_03_.ROOT_Target);
      5:_stage_05_.EXECUTE(_stage_04_.ROOT_Target);
    end;
end;

procedure tCopyRAST_STAGEs._goSTAGE_(const stageIndex:integer);
begin
   {$ifdef _DEBUG_}DEBUG(self.ClassName+'._goSTAGE_',inttostr(stageIndex));{$endIf}
   _stageIDX_:=stageIndex;
   _doStage_(stageIndex);
   _stageEND_:=TRUE;
    if Assigned(_mOn_Stage_) then _mOn_Stage_(self,stageIndex);
end;

//------------------------------------------------------------------------------

function tCopyRAST_STAGEs._mainIdeOBJ_GET_:pointer;
begin
    result:=_mainIdeOBJ_;
end;

{function tCopyRAST_STAGEs._mainIdeOBJ_CNF_:tLazExt_CopyRAST_CONFIG;
begin
    result:=nil;
end;}

//------------------------------------------------------------------------------

procedure tCopyRAST_STAGEs.Configs_LOAD;
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

procedure tCopyRAST_STAGEs.Configs_SAVE;
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

procedure tCopyRAST_STAGEs.DoSTAGE(const stageIndex:integer);
begin
   _goCLEAR_(stageIndex);
   _goSTAGE_(stageIndex);
end;

procedure tCopyRAST_STAGEs.DoCLEAN(const stageIndex:integer);
begin
   _goCLEAR_(stageIndex);
end;

//------------------------------------------------------------------------------

// по сути просто получаем ИМЯ ГЛАВНОГО Файла
function tCopyRAST_STAGEs._CNFG_fileName_4IDE_:string;
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
function tCopyRAST_STAGEs._CNFG_fileName_4EXT_:string;
begin
    result:=srcTree_fsFnk_ChangeFileExt(_CNFG_fileName_4IDE_,'.CopyRAST');
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCopyRAST_STAGEs._CNFG_fndInFile_IDE_:boolean;
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

function tCopyRAST_STAGEs._CNFG_fndInFile_EXT_:boolean;
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

procedure tCopyRAST_STAGEs._CNFG_setUp_onCreate_;
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

function tCopyRAST_STAGEs._CNFG_create_xml_OBJ_(const forIde:boolean):tLazExt_CopyRAST_CONFIG;
begin
    if forIde
    then result:=CopyRAST_fileConfig_FIND(_CNFG_fileName_4IDE_,false)
    else result:=CopyRAST_fileConfig_FIND(_CNFG_fileName_4EXT_,true);
end;


end.


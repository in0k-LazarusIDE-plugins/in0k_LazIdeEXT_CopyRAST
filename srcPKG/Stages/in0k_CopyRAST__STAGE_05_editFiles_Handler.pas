unit in0k_CopyRAST__STAGE_05_editFiles_Handler;

{$mode objfpc}{$H+}

interface

uses
  dialogs,


  CodeCache,
  CodeToolManager,
  PackageIntf,
  BasicCodeTools,
  Laz2_XMLCfg,

  lazExt_CopyRAST_TEXTs,


  in0k_CopyRAST_srcTree_ITEMs,
  srcTree_handler_CORE,
  srcTree_handler_CORE_fsFile2CodeBUF;

type
_tSTAGE05_itmHandler_=class(tSrcTree_itmHandler_fsFile2CodeBUF)
  protected
    function _coreROOT_:tCopyRast_stROOT;
  protected
   _codeBuff_:TCodeBuffer;
   _codeTool_:TCodeTool;
    function _do4EDIT_:boolean;
    function _doCLOSE_:boolean;
  end;

_tSTAGE05_lpiHandler_=class(tSrcTree_itmHandler_fsFile_XMLConfig)
  protected
    function _coreROOT_:tCopyRast_stROOT;
  protected
   _codeBuff_:TCodeBuffer;
   _xmlConfig_:TXmlConfig;
    function _do4EDIT_:boolean;
    function _doCLOSE_:boolean;
  end;

function STAGE_05__editFiles(const sourceRoot,targetRoot:tCopyRast_stROOT):boolean;

implementation
uses in0k_CopyRAST__STAGE_05_editFiles_Handler_updateUses,
     in0k_CopyRAST__STAGE_05_editFiles_Handler_LpiFILE;

function _tSTAGE05_itmHandler_._do4EDIT_:boolean;
begin
    result:=false;
    //-----------
   _codeBuff_:=_SrcTree_fsFILE__2__codeBUF_(tCopyRastNODE_FILE(prcssdITEM));
    result   :=_codeBUF_4EDIT_(_codeBuff_,_codeTool_);
end;

function _tSTAGE05_itmHandler_._doCLOSE_:boolean;
begin
    result:=false;
    //-----------
    result:=_codeBUF_WRITE_(_codeBuff_);
end;


//==============================================================================


function _tSTAGE05_lpiHandler_._do4EDIT_:boolean;
begin
    result:=false;
    //-----------
   _codeBuff_:=_SrcTree_fsFILE__2__codeBUF_(tCopyRastNODE_FILE(prcssdITEM));
    result   :=_codeBUF_4EDIT_XML_(_codeBuff_,_xmlConfig_);
end;

function _tSTAGE05_lpiHandler_._doCLOSE_:boolean;
begin
    result:=false;
    //-----------
    result:=_codeBUF_WRITE_XML_(_codeBuff_,_xmlConfig_);
   _xmlConfig_.Free;
   _xmlConfig_:=nil;
end;


//==============================================================================
// переименование НАЗВАНИЯ unit

type
_tSTAGE05_itmHandler__updateUnit_=class(_tSTAGE05_itmHandler_)
  public // ВЫПОЛНЕНИЕ
    function  Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;

function _tSTAGE05_itmHandler__updateUnit_.Processing:boolean;
var srcNode:tCopyRast_stITEM;
    untName:string;
begin
    result:=true;
    if (prcssdITEM is tCopyRastNODE_FILE) and
       (tCopyRastNODE_FILE(prcssdITEM).fileKIND in [pftUnit,pftVirtualUnit,pftMainUnit]) and
       (CopyRastNODE_IS_NOT_SOURCE(prcssdITEM))
    then begin
        srcNode:=CopyRAST_stITEM__findInLFT(_coreROOT_,prcssdITEM);
        if Assigned(srcNode) and (srcNode.ItemNAME<>prcssdITEM.ItemNAME) then begin
            result:=_do4EDIT_;
            if result then begin
                untName:=CodeToolBoss.GetSourceName(_codeBuff_,false);
                if untName<>'' then begin
                    if CodeToolBoss.RenameSource(_codeBuff_,prcssdITEM.ItemNAME +CopyRAST_Text_comment_InlineReplace_PAS(untName))
                    then doEvent_onPASSED('RenameSource "'+untName+'"->"'+prcssdITEM.ItemNAME+'"')
                    else doEvent_on_ERROR('RenameSource "'+untName+'"->"'+prcssdITEM.ItemNAME+'"');
                end;
            end;
            result:=_doCLOSE_;
        end;
    end;
    result:=true;
end;

//==============================================================================


type
_tSTAGE05_prcHandler__updateUnit_=class(tSrcTree_prcHandler)
  protected
   _coreRoot_:tCopyRast_stROOT; //<
  protected
    procedure _EXECUTE_; override;
  end;

procedure _tSTAGE05_prcHandler__updateUnit_._EXECUTE_;
begin
    EXECUTE_4TREE(_tSTAGE05_itmHandler__updateUnit_);
    EXECUTE_4TREE(_tSTAGE05_itmHandler__updateUses_);
    EXECUTE_4TREE(_tSTAGE05_itmHandler__LpiFILE_);
    EXECUTE_4TREE(_tSTAGE05_itmHandler__LpiFILE_01_);
end;

function STAGE_05__editFiles(const sourceRoot,targetRoot:tCopyRast_stROOT):boolean;
var tmp:_tSTAGE05_prcHandler__updateUnit_;
begin
    tmp:=_tSTAGE05_prcHandler__updateUnit_.Create;
    tmp._coreRoot_:=sourceRoot;
    tmp. EXECUTE   (targetRoot);
    tmp.FREE;
    //---
    result:=true;
end;

//==============================================================================


function _tSTAGE05_itmHandler_._coreROOT_:tCopyRast_stROOT;
begin
    result:=_tSTAGE05_prcHandler__updateUnit_(_OWNER_)._coreRoot_;
end;

function _tSTAGE05_lpiHandler_._coreROOT_:tCopyRast_stROOT;
begin
    result:=_tSTAGE05_prcHandler__updateUnit_(_OWNER_)._coreRoot_;
end;

end.


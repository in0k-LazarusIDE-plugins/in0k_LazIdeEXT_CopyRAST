unit in0k_CopyRAST__STAGE_05_editFiles_Handler;

{$mode objfpc}{$H+}

interface

uses
  dialogs,


  CodeCache,
  CodeToolManager,

  lazExt_CopyRAST_TEXTs,


  in0k_CopyRAST_srcTree_ITEMs,
  srcTree_handler_CORE,
  srcTree_handler_CORE_fsFile2CodeBUF;

function STAGE_05__editFiles(const sourceRoot,targetRoot:tCopyRast_stROOT):boolean;

implementation

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

type
_tSTAGE05_itmHandler__updateUnit_=class(_tSTAGE05_itmHandler_)
  public // ВЫПОЛНЕНИЕ
    function  Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;

function _tSTAGE05_itmHandler__updateUnit_.Processing:boolean;
var lstName:string;
    srcNode:tCopyRast_stITEM;
begin
    result:=true;
    if ( prcssdITEM is tCopyRastNODE_FILE) and
       (CopyRastNODE_IS_NOT_SOURCE(prcssdITEM))
    then begin
        srcNode:=CopyRAST_stITEM__findInLFT(_coreROOT_,prcssdITEM);
        if Assigned(srcNode) and (srcNode.ItemNAME<>prcssdITEM.ItemNAME) then begin
            result:=_do4EDIT_;
            if result then begin
                lstName:=CodeToolBoss.GetSourceName(_codeBuff_,false);
                if CodeToolBoss.RenameSource(_codeBuff_,prcssdITEM.ItemNAME +CopyRAST_Text_comment_InlineReplace_PAS(lstName))
                then doEvent_onPASSED('RenameSource "'+lstName+'"->"'+prcssdITEM.ItemNAME+'"')
                else doEvent_on_ERROR('RenameSource "'+lstName+'"->"'+prcssdITEM.ItemNAME+'"');
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
end;

function _tSTAGE05_itmHandler_._coreROOT_:tCopyRast_stROOT;
begin
    result:=_tSTAGE05_prcHandler__updateUnit_(_OWNER_)._coreRoot_;
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

end.


unit prcNode_core_srcEdit;

{$mode objfpc}{$H+}

interface

uses
  CodeCache, CodeToolManager,
  LazFileUtils,
  lazExt_CopyRAST_node,


  Processing_CORE,
  lazExt_CopyRAST_processingNODE;


type

 tPrcNODE_core_srcEdit=class(tPrcNODE_Base)
  protected
    CodeBuff:TCodeBuffer;
    CodeTool:TCodeTool;
  protected
    function doEditFile(const t_eItem:tOperationNode_TYPE; const Node:tCopyRAST_node):boolean;
    function doEditFile(const t_eItem:tOperationNode_TYPE):boolean;
  end;

 tPrcNODE_core_srcEditDO=class(tPrcNODE_Base)
  private
    function _get_prntEdit_:tPrcNODE_core_srcEdit;
    function _get_CodeBuff_:TCodeBuffer;
    function _get_CodeTool_:TCodeTool;
  protected
    property CodeBuff:TCodeBuffer read _get_CodeBuff_;
    property CodeTool:TCodeTool   read _get_CodeTool_;
    function CleanPos_in_CodeBuff(const CleanPos:integer):boolean;
  end;

implementation

//==============================================================================

function tPrcNODE_core_srcEdit.doEditFile(const t_eItem:tOperationNode_TYPE; const Node:tCopyRAST_node):boolean;
begin
    result:=TRUE; //< НЕ останавливаться на достигнутом :-)

    // взято из http://wiki.freepascal.org/Codetools#Usage
    // Step 0: проверим ... он вообще есть? ... он не может не есть
    if NOT FileExistsUTF8(Node.Get_Target_fullName) then begin
        doEvent_on_ERROR('TARGET file NOT exists:'+'"'+Node.Get_Target_fullName+'"');
    end;
    // Step 1: load the file and parse it
    CodeBuff:=CodeToolBoss.LoadFile(Node.Get_Target_fullName,true,false);
    if NOT Assigned(CodeBuff) then begin
        doEvent_on_ERROR('CodeBuffer NOT received:"'+Node.Get_Target_fullName+'"');
    end;
    CodeToolBoss.Explore(CodeBuff,CodeTool,false);
    if NOT Assigned(CodeTool) then begin
        doEvent_on_ERROR('CodeTool NOT received:"'+Node.Get_Target_fullName+'"');
    end;
    // Step 2: connect the SourceChangeCache
    CodeToolBoss.SourceChangeCache.MainScanner:=CodeTool.Scanner;
    CodeToolBoss.SourceChangeCache.BeginUpdate;
    // Step 3: EDIT
    result:=EXECUTE_4NODE(t_eItem);
    // Step 4: Apply the changes
    if not CodeToolBoss.SourceChangeCache.EndUpdate then begin
        doEvent_on_ERROR('CodeToolBoss.SourceChangeCache.EndUpdate ERROR:"'+Node.Get_Target_fullName+'"');
    end;
    // Step 5: SAVE the changes
    if NOT CodeBuff.Save then begin
         doEvent_on_ERROR('CodeBuff.Save ERROR:"'+Node.Get_Target_fullName+'" ER');
    end;
end;

function tPrcNODE_core_srcEdit.doEditFile(const t_eItem:tOperationNode_TYPE):boolean;
begin
    result:=doEditFile(t_eItem,node4Execut);
end;

//------------------------------------------------------------------------------

function tPrcNODE_core_srcEditDO._get_prntEdit_:tPrcNODE_core_srcEdit;
var tmp:tOperationNode_CORE;
begin
    result:=nil;
    //---
    tmp:=self.Tool_Parent;
    while Assigned(tmp) do begin
        if tmp is tPrcNODE_core_srcEdit then begin
            result:=tPrcNODE_core_srcEdit(tmp);
            BREAK;
		end;
        tmp:=tmp.Tool_Parent;
	end;
end;

function tPrcNODE_core_srcEditDO._get_CodeBuff_:TCodeBuffer;
var tmp:tPrcNODE_core_srcEdit;
begin
    result:=nil;
    tmp:=_get_prntEdit_;
    if Assigned(tmp) then result:=tmp.CodeBuff;
end;

function tPrcNODE_core_srcEditDO._get_CodeTool_:TCodeTool;
var tmp:tPrcNODE_core_srcEdit;
begin
    result:=nil;
    tmp:=_get_prntEdit_;
    if Assigned(tmp) then result:=tmp.CodeTool;
end;

//------------------------------------------------------------------------------

function tPrcNODE_core_srcEditDO.CleanPos_in_CodeBuff(const CleanPos:integer):boolean;
begin
    with CodeBuff do result:=(1<=CleanPos)and(CleanPos<=SourceLength) ;
end;

end.


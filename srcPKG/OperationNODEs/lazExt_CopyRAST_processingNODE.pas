unit lazExt_CopyRAST_processingNODE;

{$mode objfpc}{$H+}

interface

uses
  CodeCache, CodeToolManager,
  LazFileUtils,
  lazExt_CopyRAST_node,
  Processing_CORE;

type

 tPrcNODE_Base=class(tOperationNode_CORE)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;

 tPrcNODE_Edit=class(tPrcNODE_Base)
  protected
    CodeBuff:TCodeBuffer;
    CodeTool:TCodeTool;
  protected
    function doEditFile(const t_eItem:tOperationNode_TYPE; const Node:tCopyRAST_node):boolean;
    function doEditFile(const t_eItem:tOperationNode_TYPE):boolean;
  end;

 tPrcNODE_EditDO=class(tPrcNODE_Base)
  private
    function _get_prntEdit_:tPrcNODE_Edit;
    function _get_CodeBuff_:TCodeBuffer;
    function _get_CodeTool_:TCodeTool;
  protected
    property CodeBuff:TCodeBuffer read _get_CodeBuff_;
    property CodeTool:TCodeTool   read _get_CodeTool_;
  end;

implementation

function tPrcNODE_Base.Is_Possible:boolean;
begin
    result:=true;
end;

function tPrcNODE_Base.doOperation:boolean;
begin
    result:=TRUE;  //< по умолчанию: продолжить обработку СЛЕДУЮЩИХ узлов
end;

//==============================================================================

function tPrcNODE_Edit.doEditFile(const t_eItem:tOperationNode_TYPE; const Node:tCopyRAST_node):boolean;
begin
    result:=TRUE; //< НЕ останавливаться на достигнутом :-)

    // взято из http://wiki.freepascal.org/Codetools#Usage
    // Step 0: проверим ... он вообще есть? ... он не может не есть
    if NOT FileExistsUTF8(Node.Get_Target_fullName) then begin
        doEvent_on_ERROR('TARGET file NOT exists:'+'"'+Node.Get_Target_fullName+'"');
    end;
    // Step 1: load the file and parse it
    CodeBuff:=CodeToolBoss.LoadFile(Node.Get_Target_fullName,false{true},false);
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

function tPrcNODE_Edit.doEditFile(const t_eItem:tOperationNode_TYPE):boolean;
begin
    result:=doEditFile(t_eItem,node4Execut);
end;

//------------------------------------------------------------------------------

function tPrcNODE_EditDO._get_prntEdit_:tPrcNODE_Edit;
var tmp:tOperationNode_CORE;
begin
    result:=nil;
    //---
    tmp:=self.Tool_Parent;
    while Assigned(tmp) do begin
        if tmp is tPrcNODE_Edit then begin
            result:=tPrcNODE_Edit(tmp);
            BREAK;
		end;
        tmp:=tmp.Tool_Parent;
	end;
end;

function tPrcNODE_EditDO._get_CodeBuff_:TCodeBuffer;
var tmp:tPrcNODE_Edit;
begin
    result:=nil;
    tmp:=_get_prntEdit_;
    if Assigned(tmp) then result:=tmp.CodeBuff;
end;

function tPrcNODE_EditDO._get_CodeTool_:TCodeTool;
var tmp:tPrcNODE_Edit;
begin
    result:=nil;
    tmp:=_get_prntEdit_;
    if Assigned(tmp) then result:=tmp.CodeTool;
end;

end.


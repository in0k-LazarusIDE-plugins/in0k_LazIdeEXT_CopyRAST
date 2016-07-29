unit lazExt_CopyRAST_operation_clearTargetDir;

{$mode objfpc}{$H+}

interface


{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

{$define _DEBUG_}

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
  lazExt_CopyRAST_node,
  lazExt_CopyRAST_node_ROOT;

type

 tLazExt_CopyRAST_operation_clearTargetDir=class(tLazExt_CopyRAST_operation_CORE)
  protected
    function _getOperationName_:string; override;
    {$ifdef _DEBUG_}
    function _getMessageOnSKIP_:boolean;  override;
    {$endIf}
  public
    function Is_Possible(const Node:tCopyRAST_node):boolean; override;
    function doOperation(const Node:tCopyRAST_node):boolean; override;
  end;

implementation

function tLazExt_CopyRAST_operation_clearTargetDir._getOperationName_:string;
begin
    result:='clear Target Dir';
end;

//------------------------------------------------------------------------------

{$ifdef _DEBUG_}
function tLazExt_CopyRAST_operation_clearTargetDir._getMessageOnSKIP_:boolean;
begin
    result:=FALSE;
end;
{$endIf}

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_clearTargetDir.Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=node is tCopyRAST_ROOT;
end;

function tLazExt_CopyRAST_operation_clearTargetDir.doOperation(const Node:tCopyRAST_node):boolean;
begin
    result:=inherited;
end;

end.


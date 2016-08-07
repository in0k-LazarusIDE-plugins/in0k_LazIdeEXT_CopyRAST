unit lazExt_CopyRAST_operation_clearTargetDir;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
  lazExt_CopyRAST_node,
  lazExt_CopyRAST_node_ROOT,
  FileUtil;

type

 tLazExt_CopyRAST_operation_clearTargetDir=class(tLazExt_CopyRAST_operation_CORE)
  protected
    function _getOperationName_:string; override;
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

function tLazExt_CopyRAST_operation_clearTargetDir.Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=node is tCopyRAST_ROOT;
end;

function tLazExt_CopyRAST_operation_clearTargetDir.doOperation(const Node:tCopyRAST_node):boolean;
begin
    result:=DirPathExists(tCopyRAST_ROOT(Node).Get_TARGET_basePath);
    if result then begin
        result:=DeleteDirectory(tCopyRAST_ROOT(Node).Get_TARGET_basePath,FALSE);
        if not result then begin
           _Error_:='DeleteDirectory "'+tCopyRAST_ROOT(Node).Get_TARGET_basePath+'" ER';
        end
        {$ifdef _DEBUG_}
        else begin
            DEBUG('DeleteDirectory "'+tCopyRAST_ROOT(Node).Get_TARGET_basePath+'" OK');
        end{$endIf};
    end
    {$ifdef _DEBUG_}
    else begin
        DEBUG('TARGET_basePath "'+tCopyRAST_ROOT(Node).Get_TARGET_basePath+'" already missing')
    end{$endIf};
end;

end.

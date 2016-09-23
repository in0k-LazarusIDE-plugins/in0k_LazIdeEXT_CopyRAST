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
  lazExt_CopyRAST_node_Folder,
  FileUtil,LazFileUtils;

type

 tLazExt_CopyRAST_operation_clearTargetDir=class(tLazExt_CopyRAST_operation_CORE)
  protected
    function _getOperationName_:string; override;
  public
    function Is_Possible(const Node:tCopyRAST_node):boolean; override;
    function doOperation(const Node:tCopyRAST_node):integer; override;
  end;

implementation

function tLazExt_CopyRAST_operation_clearTargetDir._getOperationName_:string;
begin
    result:='Clear Target Dir';
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_clearTargetDir.Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=node is tCopyRAST_node_BaseDIR;
end;

function tLazExt_CopyRAST_operation_clearTargetDir.doOperation(const Node:tCopyRAST_node):integer;
begin
    if not DirPathExists(Node.Get_Target_fullName) then begin
        result:=0;
       _mssge_:='TARGET_basePath already missing';
    end
   else
    if DeleteDirectory(Node.Get_Target_fullName,FALSE) then begin
       _mssge_:='TARGET_basePath DELETED';
        result:=+1;
    end
   else begin
       _mssge_:='DeleteDirectory';
        result:=-1;
    end;
end;

end.


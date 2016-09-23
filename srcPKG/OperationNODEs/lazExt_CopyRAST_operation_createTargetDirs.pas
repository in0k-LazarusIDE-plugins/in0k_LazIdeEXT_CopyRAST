unit lazExt_CopyRAST_operation_createTargetDirs;

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
  lazExt_CopyRAST_node_ROOT, lazExt_CopyRAST_node_Folder,
  LazFileUtils;

type

 tLazExt_CopyRAST_operation_createTargetDirs=class(tLazExt_CopyRAST_operation_CORE)
  protected
    function _getOperationName_:string; override;
  public
    function Is_Possible(const Node:tCopyRAST_node):boolean; override;
    function doOperation(const Node:tCopyRAST_node):integer; override;
  end;

implementation

function tLazExt_CopyRAST_operation_createTargetDirs._getOperationName_:string;
begin
    result:='Create Target Dirs';
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_createTargetDirs.Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=(node is tCopyRAST_node_Folder);
end;

function tLazExt_CopyRAST_operation_createTargetDirs.doOperation(const Node:tCopyRAST_node):integer;
begin
    if DirPathExists(Node.Get_Target_fullName) then begin
       _mssge_:='TARGET_Path already present';
        result:=0;
    end
   else
    if ForceDirectory(Node.Get_Target_fullName) then begin
       _mssge_:='TARGET_Path CREATED';
        result:=+1;
    end
   else begin
       _mssge_:='ForceDirectory';
        result:=-1;
    end;
end;

end.


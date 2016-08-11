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
  FileUtil;

type

 tLazExt_CopyRAST_operation_createTargetDirs=class(tLazExt_CopyRAST_operation_CORE)
  protected
    function _getOperationName_:string; override;
  public
    function Is_Possible(const Node:tCopyRAST_node):boolean; override;
    function doOperation(const Node:tCopyRAST_node):boolean; override;
  end;

implementation

function tLazExt_CopyRAST_operation_createTargetDirs._getOperationName_:string;
begin
    result:='clreate Target Dirs';
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_createTargetDirs.Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:={(node is tCopyRAST_ROOT)or}(node is tCopyRAST_node_Folder);
end;

function tLazExt_CopyRAST_operation_createTargetDirs.doOperation(const Node:tCopyRAST_node):boolean;
begin
    result:=true;
    {$ifdef _DEBUG_}
        DEBUG('>---','Get_Source_obj_Name "'+tCopyRAST_ROOT(Node).Get_Source_obj_Name+'"');
        DEBUG('>---','Get_Source_dir_Name "'+tCopyRAST_ROOT(Node).Get_Source_dir_Name+'"');
        DEBUG('>---','Get_Source_fullName "'+tCopyRAST_ROOT(Node).Get_Source_fullName+'"');
        //---
        DEBUG('--->','Get_Target_fullName "'+tCopyRAST_ROOT(Node).Get_Target_fullName+'"');
    {$endIf};
    //ForceDirectoriesUTF8();

{    result:=DirPathExists(tCopyRAST_ROOT(Node).Get_TARGET_basePath);
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
    end{$endIf};}
end;

end.


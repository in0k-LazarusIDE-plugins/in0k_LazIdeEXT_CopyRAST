unit lazExt_CopyRAST_operation_copyFiles;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
  lazExt_CopyRAST_node,  lazExt_CopyRAST_node_ROOT,
  lazExt_CopyRAST_node_File,
  FileUtil, LazFileUtils;

type

 tLazExt_CopyRAST_operation_copyFiles=class(tLazExt_CopyRAST_operation_CORE)
  protected
    function _getOperationName_:string; override;
  public
    function Is_Possible(const Node:tCopyRAST_node):boolean; override;
    function doOperation(const Node:tCopyRAST_node):boolean; override;
  end;

implementation

function tLazExt_CopyRAST_operation_copyFiles._getOperationName_:string;
begin
    result:='Copy Files';
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_copyFiles.Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=(node is tCopyRAST_node_File_CORE);
end;

function tLazExt_CopyRAST_operation_copyFiles.doOperation(const Node:tCopyRAST_node):boolean;
begin
    _mssge_:='"'+Node.Get_Source_fullName+'"'+' -> '+'"'+Node.Get_Target_fullName+'"';
     result:=NOT FileExistsUTF8(_mssge_);
     if result then begin
         result:=CopyFile(Node.Get_Source_fullName,Node.Get_Target_fullName{,[cffOverwriteFile,cffPreserveTime]});
         if result
         then _mssge_:=_mssge_+'" COPYED'
         else _mssge_:='CopyFile('+_mssge_+') ERR';
     end
     else begin
         result:=TRUE;
        _mssge_:='TARGET File:'+'"'+Node.Get_Target_fullName+'"'+' already present';
     end;
end;

end.


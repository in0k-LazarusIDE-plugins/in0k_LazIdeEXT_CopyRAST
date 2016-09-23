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
    function doOperation(const Node:tCopyRAST_node):integer; override;
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

function tLazExt_CopyRAST_operation_copyFiles.doOperation(const Node:tCopyRAST_node):integer;
begin
    if NOT FileExistsUTF8(Node.Get_Source_fullName) then begin
        result:=-1;
       _mssge_:='Source file NOT present:'+'"'+Node.Get_Source_fullName+'"';
    end
   else
    if FileExistsUTF8(Node.Get_Target_fullName) then begin
        result:=-1;
       _mssge_:='Target file ALREADY present:'+'"'+Node.Get_Target_fullName+'"';
    end
   else
    if CopyFile(Node.Get_Source_fullName,Node.Get_Target_fullName{,[cffOverwriteFile,cffPreserveTime]})
    then begin
        result:=+1;
       _mssge_:='COPYED';
    end
    else begin
       _mssge_:='COPYED';
        result:=-1;
    end;
end;

end.


unit lazExt_CopyRAST_operation_PSF_updateUnit;
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
  lazExt_CopyRAST_TEXTs,
  FileUtil, LazFileUtils,  LazIDEIntf,
  CodeToolManager, CodeCache;

type

 tLazExt_CopyRAST_operation_PSF_updateUnit=class(tLazExt_CopyRAST_operation_CORE)
  protected
    function _getOperationName_:string; override;
  protected
   _new_UnitName_:string;
  public
    function Is_Possible(const Node:tCopyRAST_node):boolean; override;
    function doOperation(const Node:tCopyRAST_node):integer; override;
    function doOperation_EDIT(const Node:tCopyRAST_node; const Code:TCodeBuffer; const Tool:TCodeTool):integer; override;
  end;

implementation

function tLazExt_CopyRAST_operation_PSF_updateUnit._getOperationName_:string;
begin
    result:='Pascal source files update UNIT name';
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_PSF_updateUnit.Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=(node is tCopyRAST_node_File_CORE) and (FilenameIsPascalUnit(node.Get_Target_fullName));
end;

function tLazExt_CopyRAST_operation_PSF_updateUnit.doOperation(const Node:tCopyRAST_node):integer;
begin
   _new_UnitName_:=ExtractFileNameOnly(Node.Get_Target_obj_Name);
    result:=_doOperation_EDIT_(node,Node.Get_Target_fullName);
end;

function tLazExt_CopyRAST_operation_PSF_updateUnit.doOperation_EDIT(const Node:tCopyRAST_node; const Code:TCodeBuffer; const Tool:TCodeTool):integer;
var lstName:string;
begin
    lstName:=CodeToolBoss.GetSourceName(Code,false);
    if CodeToolBoss.RenameSource(Code,ExtractFileNameOnly(Node.Get_Target_obj_Name)+CopyRAST_Text_comment_InlineReplace_PAS(lstName))
    then begin
      _mssge_:='RenameSource "'+lstName+'"->"'+ExtractFileNameOnly(Node.Get_Target_obj_Name)+'"';
       result:=+1;
    end
    else begin
      _mssge_:='RenameSource "'+lstName+'"->"'+ExtractFileNameOnly(Node.Get_Target_obj_Name)+'"';
       result:=+1;
    end
end;

end.

unit lazExt_CopyRAST_operation_PSF_updateUsesMain;
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
  FileUtil, LazFileUtils,
  CodeToolManager, CodeCache;

type

 tLazExt_CopyRAST_operation_PSF_updateUsesMain=class(tLazExt_CopyRAST_operation_CORE_twoStep)
  protected
    function _getOperationName_:string; override;
  public
    function Is_Possible(const Node:tCopyRAST_node):boolean; override;
    function doOperation(const Node:tCopyRAST_node):boolean; override;
  public
    function secondStep_Is_Possible(const Node:tCopyRAST_node):boolean; override;
    function secondStep_doOperation(const Node:tCopyRAST_node):boolean; override;
  end;

implementation

function tLazExt_CopyRAST_operation_PSF_updateUsesMain._getOperationName_:string;
begin
    result:='Pascal source files update USES main section';
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_PSF_updateUsesMain.Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=true;//(node is tCopyRAST_node_File_CORE) and (FilenameIsPascalUnit(node.Get_Target_fullName));
end;

function tLazExt_CopyRAST_operation_PSF_updateUsesMain.doOperation(const Node:tCopyRAST_node):boolean;
var Code:TCodeBuffer;
    Tool:TCodeTool;
begin
    result:=true;
{   _mssge_:=Node.Get_Target_fullName;
    result:=FileExistsUTF8(Node.Get_Target_fullName);
    if result then begin
        //---
        Code:=CodeToolBoss.LoadFile(node.Get_Target_fullName,true,false);
        result:=Assigned(Code);
        if not result then _mssge_:='CodeBuffer:"'+_mssge_+'" NOT received';
        //---
        if result then begin
            CodeToolBoss.Explore(Code,Tool,false);
            result:=Assigned(Tool);
            if not result then _mssge_:='CodeTool:"'+_mssge_+'" NOT received'
        end;
        //---
        if result then begin
            result:=Tool.RenameSource(ExtractFileNameOnly(Node.Get_Target_obj_Name),CodeToolBoss.SourceChangeCache);
            if not result then _mssge_:='Tool.RenameSource:"'+_mssge_+'" ER';
        end;
        //---
        if result then begin
            result:=code.Save;
            if not result then _mssge_:='code.Save:"'+_mssge_+'" ER'
        end;
        //----------
        if result then begin
            _mssge_:='changes APPLIED: unit "'+ExtractFileNameOnly(Node.Get_Source_obj_Name)+'" -> "'+ExtractFileNameOnly(Node.Get_Target_obj_Name)+'" in file "'+Node.Get_Target_fullName+'"';
        end;
     end
     else begin
        _mssge_:='TARGET File:'+'"'+Node.Get_Target_fullName+'"'+' NOT exists';
     end; }
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_PSF_updateUsesMain.secondStep_Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=true;
end;

function tLazExt_CopyRAST_operation_PSF_updateUsesMain.secondStep_doOperation(const Node:tCopyRAST_node):boolean;
begin
    result:=true;
end;

end.


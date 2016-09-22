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
  FileUtil, LazFileUtils,  LazIDEIntf,
  CodeToolManager, CodeCache;

type

 tLazExt_CopyRAST_operation_PSF_updateUnit=class(tLazExt_CopyRAST_operation_CORE)
  protected
    function _getOperationName_:string; override;
  public
    function Is_Possible(const Node:tCopyRAST_node):boolean; override;
    function doOperation(const Node:tCopyRAST_node):boolean; override;
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

function tLazExt_CopyRAST_operation_PSF_updateUnit.doOperation(const Node:tCopyRAST_node):boolean;
var Code:TCodeBuffer;
    Tool:TCodeTool;
begin

    // save changes in source editor to codetools
     // LazarusIDE.SaveSourceEditorChangesToCodeCache(-1);

   _mssge_:=Node.Get_Target_fullName;
    result:=FileExistsUTF8(Node.Get_Target_fullName);
    if result then begin
        //--- Загружаем
        Code:=CodeToolBoss.LoadFile(node.Get_Target_fullName,true,false);
        result:=Assigned(Code);
        if not result then _mssge_:='CodeBuffer:"'+_mssge_+'" NOT received';
        //--- Получаем средство для редактирования
        if result then begin
            CodeToolBoss.Explore(Code,Tool,false);
            result:=Assigned(Tool);
            if not result then _mssge_:='CodeTool:"'+_mssge_+'" NOT received'
        end;

        // Step 2: connect the SourceChangeCache
        //  CodeToolBoss.SourceChangeCache.MainScanner:=Tool.Scanner;
        //  CodeToolBoss.SourceChangeCache.BeginUpdate;

        //--- Переименовываем
        if result then begin
            result:=Tool.RenameSource(ExtractFileNameOnly(Node.Get_Target_obj_Name)+'{asdf}',CodeToolBoss.SourceChangeCache);
            if not result then _mssge_:='Tool.RenameSource:"'+_mssge_+'" ER';
        end;
        // Step 4: Apply the changes
        //if result then begin
        //     result:=CodeToolBoss.SourceChangeCache.Apply;
        //     if not result then _mssge_:='CodeToolBoss.SourceChangeCache.Apply:"'+_mssge_+'" ER'
        //end;

      //   CodeToolBoss.SourceCache.;

        //--- Сохраняем
        //if result then begin
        //    result:=CodeToolBoss.SourceChangeCache.EndUpdate;
        //    if not result then _mssge_:='code.Save:"'+_mssge_+'" ER'
        //end;
        //--- Сохраняем
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
     end;
end;

end.

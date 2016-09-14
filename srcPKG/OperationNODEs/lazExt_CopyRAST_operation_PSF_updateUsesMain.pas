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
  FileUtil, LazFileUtils, CodeTree, LinkScanner,  SourceChanger, CodeAtom,
  CodeToolManager, CodeCache, StdCodeTools{CodeTree};

type

 tLazExt_CopyRAST_operation_PSF_updateUsesMain=class(tLazExt_CopyRAST_operation_CORE_twoStep)
  protected
   _src_:tCopyRAST_node_FILE;
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
    result:=(node is tCopyRAST_node_File_CORE) and            //< этот ФАЙЛ
            (FilenameIsPascalUnit(node.Get_Target_fullName)); //< ПАСКАЛЕВСКИЙ исходник
end;

function tLazExt_CopyRAST_operation_PSF_updateUsesMain.doOperation(const Node:tCopyRAST_node):boolean;
begin
    result:=true;
   _mssge_:='"'+tCopyRAST_node_File_CORE(node).Get_Source_obj_Name+'"->"'+tCopyRAST_node_File_CORE(node).Get_Target_obj_Name+'"';
    if tCopyRAST_node_File_CORE(node).Get_Source_obj_Name=tCopyRAST_node_File_CORE(node).Get_Target_obj_Name then begin
        // ту НИЧЕГО делать НЕ надо ... название НЕ изменилось
       _mssge_:='SKIP: ..obj_Name ("'+tCopyRAST_node_File_CORE(node).Get_Source_obj_Name+'") not changed';
    end
    else begin
        // тут идем По ВСЕМ исходникам ...
        result:=true;
       _src_  :=tCopyRAST_node_FILE(Node);
    end;
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_PSF_updateUsesMain.secondStep_Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=(node <> _src_) and                               //< исключаем САМО вход
            (node is tCopyRAST_node_File_CORE) and            //< этот ФАЙЛ
            (FilenameIsPascalUnit(node.Get_Target_fullName)); //< ПАСКАЛЕВСКИЙ исходник
end;

function tLazExt_CopyRAST_operation_PSF_updateUsesMain.secondStep_doOperation(const Node:tCopyRAST_node):boolean;
var Code:TCodeBuffer;
    Tool:TCodeTool;
    UsesNode:TCodeTreeNode;

    fndNAME:string;
    needSave:integer;
begin
    needSave:=0;


   _mssge_:=Node.Get_Target_fullName;
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

        // Step 2: connect the SourceChangeCache
        CodeToolBoss.SourceChangeCache.MainScanner:=Tool.Scanner;

        // Step 3: EDIT
        if result then begin
            fndNAME:=upcase(ExtractFileNameWithoutExt(node.Get_Source_obj_Name));
            tool.MoveCursorToCleanPos(0);
            while tool.CurPos.EndPos<tool.SrcLen do begin
                if (tool.CurPos.Flag=cafWord)and
                   (tool.UpAtomIs(fndNAME))
                then begin
                    DEBUG('FIND "'+fndNAME +'" SP='+inttostr(tool.CurPos.StartPos)+' EP='+inttostr(tool.CurPos.EndPos)+' in file "'+Node.Get_Target_fullName+'"');
                    result:=CodeToolBoss.SourceChangeCache.Replace(gtNone,gtNone,tool.CurPos.StartPos,tool.CurPos.EndPos,fndNAME);
                    if result then inc(needSave)
                    else begin
                       _mssge_:='CodeToolBoss.SourceChangeCache.Replace: ERR';
                        BREAK;
                    end;
                end;
                Tool.ReadNextAtom;
            end;
        end;

        // Step 4: Apply the changes
        if result and (needSave>0) then begin
             result:=CodeToolBoss.SourceChangeCache.Apply;
             if not result then _mssge_:='CodeToolBoss.SourceChangeCache.Apply:"'+_mssge_+'" ER'
        end;
        // Step 5: SAVE the changes
        if result then begin
            result:=code.Save;
            if not result then _mssge_:='code.Save:"'+_mssge_+'" ER'
        end;
        //----------
        if result then begin
            _mssge_:='changes APPLIED '+inttostr(needSave)+': unit "'+{ExtractFileNameOnly(Node.Get_Source_obj_Name)+'" -> "'+ExtractFileNameOnly(Node.Get_Target_obj_Name)+}'" in file "'+Node.Get_Target_fullName+'"';
        end;
     end
     else begin
        _mssge_:='TARGET File:'+'"'+Node.Get_Target_fullName+'"'+' NOT exists';
     end;
end;

end.


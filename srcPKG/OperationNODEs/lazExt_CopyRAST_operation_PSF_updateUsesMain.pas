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
  lazExt_CopyRAST_TEXTs,
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
    function secondStep_doOperation(const Node:tCopyRAST_node):integer; override;
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

function tLazExt_CopyRAST_operation_PSF_updateUsesMain.secondStep_doOperation(const Node:tCopyRAST_node):integer;
var Code:TCodeBuffer;
    Tool:TCodeTool;
    UsesNode:TCodeTreeNode;

    fndNAME:string;
    repNAME:string;
begin
    result:=0;
    //---
   _mssge_:=Node.Get_Target_fullName;
    if NOT FileExistsUTF8(Node.Get_Target_fullName) then begin
       _mssge_:='TARGET File:'+'"'+Node.Get_Target_fullName+'"'+' NOT exists';
        exit(-1);
    end;

    Code:=CodeToolBoss.LoadFile(node.Get_Target_fullName,true,false);
    if NOT Assigned(Code) then begin
       _mssge_:='CodeBuffer:"'+Node.Get_Target_fullName+'" NOT received';
        exit(-1);
    end;

    CodeToolBoss.Explore(Code,Tool,false);
    if NOT Assigned(Tool) then begin
        _mssge_:='CodeTool:"'+Node.Get_Target_fullName+'" NOT received';
         exit(-1);
    end;

        // Step 2: connect the SourceChangeCache
        CodeToolBoss.SourceChangeCache.MainScanner:=Tool.Scanner;
        CodeToolBoss.SourceChangeCache.BeginUpdate;

        // Step 3: EDIT

    fndNAME:=upcase(ExtractFileNameWithoutExt(_src_.Get_Source_obj_Name));
    repNAME:=      (ExtractFileNameWithoutExt(_src_.Get_Target_obj_Name));
    tool.MoveCursorToCleanPos(0);
    while tool.CurPos.EndPos<tool.SrcLen do begin
        if (tool.CurPos.Flag=cafWord)and(tool.UpAtomIs(fndNAME)) then begin
            DEBUG('FIND "'+fndNAME +'" SP='+inttostr(tool.CurPos.StartPos)+' EP='+inttostr(tool.CurPos.EndPos)+' in file "'+Node.Get_Target_fullName+'"');
            //code.Replace();
            //inc(result);
            //result:=CodeToolBoss.SourceChangeCache.Replace(gtNone,gtNone,tool.CurPos.StartPos,tool.CurPos.EndPos,fndNAME);
            if CodeToolBoss.SourceChangeCache.Replace(gtNone,gtNone,tool.CurPos.StartPos,tool.CurPos.EndPos,repNAME+CopyRAST_Text_comment_InlineReplace_PAS(tool.GetAtom)) then begin
                result:=result+1;
            end;
            {if result then inc(result)
            else begin
            _mssge_:='CodeToolBoss.SourceChangeCache.Replace: ERR';
            BREAK;
            end;}
        end;
        Tool.ReadNextAtom;
    end;

    // Step 4: Apply the changes
    if not CodeToolBoss.SourceChangeCache.EndUpdate then begin
        _mssge_:='CodeToolBoss.SourceChangeCache.EndUpdate:"'+Node.Get_Target_fullName+'" ER';
         exit(-1);
    end;

    // Step 5: SAVE the changes
    if NOT code.Save then begin
        _mssge_:='code.Save:"'+Node.Get_Target_fullName+'" ER';
         exit(-1);
    end;

    //---
   _mssge_:='in file "'+Node.Get_Target_fullName+'"';

end;

end.


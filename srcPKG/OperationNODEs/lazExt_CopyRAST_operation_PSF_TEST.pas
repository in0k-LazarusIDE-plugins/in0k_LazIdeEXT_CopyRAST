unit lazExt_CopyRAST_operation_PSF_TEST{%CopyRAST:"lazExt_CopyRAST_operation_PSF_TEST"};
{$mode objfpc}{$H+}

interface

{%CopyRAST:"sdfasdf"}





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

 tLazExt_CopyRAST_operation_PSF_TEST=class(tLazExt_CopyRAST_operation_CORE)
  protected
    function _getOperationName_:string; override;
  public
    function Is_Possible(const Node:tCopyRAST_node):boolean; override;
    function doOperation(const Node:tCopyRAST_node):boolean; override;
  end;

implementation

function tLazExt_CopyRAST_operation_PSF_TEST._getOperationName_:string;
begin
    result:='Pascal source files update UNIT name';
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_PSF_TEST.Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=(node is tCopyRAST_node_File_CORE) and (FilenameIsPascalUnit(node.Get_Target_fullName));
end;

function tLazExt_CopyRAST_operation_PSF_TEST.doOperation(const Node:tCopyRAST_node):boolean;
var Code:TCodeBuffer;
    Tool:TCodeTool;
begin
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
        //--- Переименовываем
        if result then begin
            DEBUG(_mssge_);
            //---
            tool.MoveCursorToCleanPos(0);
            DEBUG(inttostr(tool.SrcLen)+'==='+inttostr(tool.CurPos.StartPos)+'==='+inttostr(tool.CurPos.EndPos));
            try
            while tool.CurPos.EndPos<tool.SrcLen do begin
                Tool.ReadNextAtom;
                DEBUG(inttostr(tool.SrcLen)+'==='+inttostr(tool.CurPos.StartPos)+'==='+inttostr(tool.CurPos.EndPos)+'==='+tool.GetAtom);
                if tool.UpAtomIs('USES') then begin
                    DEBUG('FIND USES in "'+Node.Get_Target_fullName+'"');
                end;
            end;
            except
              DEBUG('ERRRR');
            end;


        end;
        //--- Сохраняем
        //if result then begin
        //    result:=code.Save;
        //    if not result then _mssge_:='code.Save:"'+_mssge_+'" ER'
        //end;
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

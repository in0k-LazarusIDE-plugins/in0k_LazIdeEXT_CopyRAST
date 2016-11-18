unit prcNode_PSF_updateUnit;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
        in0k_lazIdeSRC_DEBUG,
        lazExt_CopyRAST_Node2TEXTs,
     {$endIf}
    CodeToolManager,
    lazExt_CopyRAST_TEXTs,
    lazExt_CopyRAST_node,
    lazExt_CopyRAST_node_File,
    lazExt_CopyRAST_processingNODE,
    FileUtil, LazFileUtils;

type

 tPrcNODE_PSF_updateUnit=class(tPrcNODE_Edit)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;

 tPrcNODE_PSF_updateUnit_DO=class(tPrcNODE_EditDO)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;


implementation

function tPrcNODE_PSF_updateUnit_DO.Is_Possible:boolean;
begin
    result:=TRUE;
end;

function tPrcNODE_PSF_updateUnit_DO.doOperation:boolean;
var lstName:string;
begin
    result:=TRUE; //< НЕ останавливаться на достигнутом :-)
    //---
    lstName:=CodeToolBoss.GetSourceName(CodeBuff,false);
    if lstName<>ExtractFileNameOnly(node4Execut.Get_Source_obj_Name) then begin
        doEvent_on_ERROR('GetSourceName<>"'+ExtractFileNameOnly(node4Execut.Get_Source_obj_Name)+'"');
    end
    else begin
        if CodeToolBoss.RenameSource(CodeBuff,ExtractFileNameOnly(node4Execut.Get_Target_obj_Name)+CopyRAST_Text_comment_InlineReplace_PAS(lstName))
        then doEvent_onPASSED('RenameSource "'+lstName+'"->"'+ExtractFileNameOnly(node4Execut.Get_Target_obj_Name)+'"')
        else doEvent_on_ERROR('RenameSource "'+lstName+'"->"'+ExtractFileNameOnly(node4Execut.Get_Target_obj_Name)+'"');
    end
end;

//------------------------------------------------------------------------------

function tPrcNODE_PSF_updateUnit.Is_Possible:boolean;
begin
    result:=(node4Execut is tCopyRAST_node_File_CORE) and (FilenameIsPascalUnit(node4Execut.Get_Target_fullName));
end;

function tPrcNODE_PSF_updateUnit.doOperation:boolean;
begin
    result:=doEditFile(tPrcNODE_PSF_updateUnit_DO);
end;



end.


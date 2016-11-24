unit prcNode_PSF_updateUses;

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
    CodeToolManager, CodeAtom, SourceChanger,
    lazExt_CopyRAST_TEXTs,
    lazExt_CopyRAST_node,
    lazExt_CopyRAST_node_File,
    lazExt_CopyRAST_processingNODE,
    prcNode_core_srcEdit,
    FileUtil, LazFileUtils;

type

 tPrcNODE_PSF_updateUses=class(tPrcNODE_core_srcEdit)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;

 tPrcNODE_PSF_updateUses_D0=class(tPrcNODE_core_srcEditDO)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;

 tPrcNODE_PSF_updateUses_D1=class(tPrcNODE_core_srcEditDO)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;


implementation

function tPrcNODE_PSF_updateUses_D1.Is_Possible:boolean;
begin
    result:=(node4Execut is tCopyRAST_node_File_CORE) //< это ФАЙЛ
        and (FilenameIsPascalUnit(node4Execut.Get_Target_fullName)) //< файл ИСХОДНИК
        and (node4Execut<>Tool_Higher.node4Execut); //< и это НЕ самовызов
end;

function tPrcNODE_PSF_updateUses_D1.doOperation:boolean;
var fndNAME:string;
    repNAME:string;
begin
    result:=true;
    //---
    fndNAME:=upcase(ExtractFileNameWithoutExt(node4Execut.Get_Source_obj_Name));
    repNAME:=      (ExtractFileNameWithoutExt(node4Execut.Get_Target_obj_Name));
    {$ifdef _DEBUG_}if CodeBuff.Filename= 'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\CopyRAST\srcPKG\lazExt_CopyRAST_CR.pas' then begin
        DEBUG('----------'+CodeBuff.Filename+' '+fndNAME+'->'+repNAME);

        //CodeTool.Src:=;
    	end;
    {$endIf}
	//---
    CodeTool.MoveCursorToCleanPos(0);
    while CodeTool.CurPos.EndPos<CodeTool.SrcLen do begin
        {$ifdef _DEBUG_}if CodeBuff.Filename= 'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\CopyRAST\srcPKG\lazExt_CopyRAST_CR.pas'
        then begin

            DEBUG('----------'+inttostr(CodeTool.CurPos.EndPos)+' '+inttostr(CodeTool.SrcLen)+' '+copy(CodeTool.Src,CodeTool.CurPos.StartPos,CodeTool.CurPos.EndPos-CodeTool.CurPos.StartPos));

            //CodeTool.cre

            //CodeBuff.;

		end;
        {$endIf}
		if {(CodeTool.CurPos.Flag=cafWord)and}(CodeTool.UpAtomIs(fndNAME)) then begin
            {$ifdef _DEBUG_}DEBUG('FND '+fndNAME+' '+CodeTool.CleanPosToStr(CodeTool.CurPos.StartPos,true) );{$endIf}
            if CodeToolBoss.SourceChangeCache.Replace(gtNone,gtNone,CodeTool.CurPos.StartPos,CodeTool.CurPos.EndPos,repNAME+CopyRAST_Text_comment_InlineReplace_PAS(CodeTool.GetAtom)) then begin
                doEvent_onPASSED('rePlace "'+fndNAME +'" SP='+inttostr(CodeTool.CurPos.StartPos)+' EP='+inttostr(CodeTool.CurPos.EndPos)+' to "'+repNAME+'" in file "'+CodeBuff.Filename+'"');
            end
            else begin
                doEvent_on_ERROR('CodeToolBoss.SourceChangeCache.Replace: ERR');
                BREAK;
            end;
        end;
        CodeTool.ReadNextAtom;
    end;
end;

//------------------------------------------------------------------------------

function tPrcNODE_PSF_updateUses_D0.Is_Possible:boolean;
begin
    result:=TRUE;
end;

function tPrcNODE_PSF_updateUses_D0.doOperation:boolean;
begin
    {$ifdef _DEBUG_}DEBUG('----------'+node4Execut.Get_Target_obj_Name);{$endIf}
    result:=EXECUTE_4TREE(tPrcNODE_PSF_updateUses_D1);
end;

//------------------------------------------------------------------------------

function tPrcNODE_PSF_updateUses.Is_Possible:boolean;
begin
    result:=(node4Execut is tCopyRAST_node_File_CORE) and (FilenameIsPascalUnit(node4Execut.Get_Target_fullName));
end;

function tPrcNODE_PSF_updateUses.doOperation:boolean;
begin
    result:=doEditFile(tPrcNODE_PSF_updateUses_D0);
end;

end.


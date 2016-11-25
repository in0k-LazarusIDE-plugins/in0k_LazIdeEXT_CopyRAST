unit prcNode_PSF_updateInclude;

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

        BasicCodeTools,   sysutils,  PackageIntf,
    CodeToolManager, CodeAtom, SourceChanger,
    lazExt_CopyRAST_TEXTs,
    lazExt_CopyRAST_node,
    lazExt_CopyRAST_node_File,
    lazExt_CopyRAST_processingNODE,
    prcNode_core_srcEdit,
    FileUtil, LazFileUtils;

type

 tPrcNODE_PSF_updateInclude=class(tPrcNODE_core_srcEdit)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;

 tPrcNODE_PSF_updateInclude_D0=class(tPrcNODE_core_srcEditDO)
  protected
   _includeFileName_:string;
   _includeFileNode_:tCopyRAST_node;
  protected
    function _processing_(const ACleanPos: integer; var FilenameStartPos, FileNameEndPos, CommentStart, CommentEnd: integer):integer;
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;

{ tPrcNODE_PSF_updateUses_D1=class(tPrcNODE_core_srcEditDO)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end; }


implementation

{function tPrcNODE_PSF_updateUses_D1.Is_Possible:boolean;
begin
    result:=(node4Execut is tCopyRAST_node_File_CORE) //< это ФАЙЛ
        and (FilenameIsPascalUnit(node4Execut.Get_Target_fullName)) //< файл ИСХОДНИК
        and (node4Execut<>Tool_Higher.node4Execut); //< и это НЕ самовызов
end; }

{function tPrcNODE_PSF_updateUses_D1.doOperation:boolean;
var fndNAME:string;
    repNAME:string;
begin
    result:=true;
    //---
    fndNAME:=upcase(ExtractFileNameWithoutExt(node4Execut.Get_Source_obj_Name));
    repNAME:=      (ExtractFileNameWithoutExt(node4Execut.Get_Target_obj_Name));
    //---
    CodeTool.MoveCursorToCleanPos(0);
    while CodeTool.CurPos.EndPos<CodeTool.SrcLen do begin
        if (CodeTool.CurPos.Flag=cafWord)and(CodeTool.UpAtomIs(fndNAME)) then begin
            if CodeToolBoss.SourceChangeCache.Replace(gtNone,gtNone,CodeTool.CurPos.StartPos,CodeTool.CurPos.EndPos,repNAME+CopyRAST_Text_comment_InlineReplace_PAS(CodeTool.GetAtom)) then begin
                doEvent_onPASSED('rePlace "'+fndNAME +'" SP='+inttostr(CodeTool.CurPos.StartPos)+' EP='+inttostr(CodeTool.CurPos.EndPos)+' to "'+repNAME+'" in file "'+node4Execut.Get_Target_fullName+'"');
            end
            else begin
                doEvent_on_ERROR('CodeToolBoss.SourceChangeCache.Replace: ERR');
                BREAK;
            end;
        end;
        CodeTool.ReadNextAtom;
    end;
end;}

{%region --- find Include file /fold}

type
_tFindIncludeFile_=class(tPrcNODE_Base)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;

function _tFindIncludeFile_.Is_Possible:boolean;
begin
    result:=(Tool_Parent is tPrcNODE_PSF_updateInclude_D0)
            and
            (node4Execut is tCopyRAST_node_File_CORE)
            //and
            //(tCopyRAST_node_File_CORE(node4Execut).FileTYPE=pftInclude);
end;

function _tFindIncludeFile_.doOperation:boolean;
begin
    if 0=CompareFilenamesIgnoreCase(node4Execut.Get_Source_obj_Name,tPrcNODE_PSF_updateInclude_D0(Tool_Parent)._includeFileName_) then begin
        tPrcNODE_PSF_updateInclude_D0(Tool_Parent)._includeFileNode_:=node4Execut;
        result:=FALSE; //<
	end
    else begin
        result:=TRUE;  //< продолжать поиски
	end;
end;

{%endregion}


//------------------------------------------------------------------------------

function tPrcNODE_PSF_updateInclude_D0.Is_Possible:boolean;
begin
    result:=TRUE;
end;


function tPrcNODE_PSF_updateInclude_D0._processing_(const ACleanPos: integer; var FilenameStartPos, FileNameEndPos, CommentStart, CommentEnd: integer):integer;
var fileName:string;
begin
    fileName:=Copy(CodeBuff.Source,FilenameStartPos,FilenameEndPos-FilenameStartPos);
    //#1 проверим, есть ли такой в НАШЕЙ системе фалов
   _includeFileName_:=fileName;
   _includeFileNode_:=nil;
    EXECUTE_4TREE(_tFindIncludeFile_);
    //#2 проверим
    if Assigned(_includeFileNode_) then begin
        if _includeFileName_<>_includeFileNode_.Get_Target_obj_Name then begin
            // ну вот ... надо МЕНЯТЬ
            if CodeToolBoss.SourceChangeCache.Replace(gtNone,gtNone,FilenameStartPos,FileNameEndPos,_includeFileNode_.Get_Target_obj_Name) then begin
                // заного все поисчем начиная с ACleanPos
                // result:=FindNextIncludeDirective(CodeBuff.Source,ACleanPos,CodeBuff.Scanner.NestedComments, FilenameStartPos,FilenameEndPos,CommentStart,CommentEnd);
                {if NOT CleanPos_in_CodeBuff(result) then begin
                    // нету тут таких директив!
                    doEvent_on_ERROR('Include file ["$I or $INCLUDE] : divective NOT found afte replace "FileName"');
	            end
                else begin //< вставим НАШ комментарий}
                    result:=FindCommentEnd(CodeBuff.Source,ACleanPos,CodeBuff.Scanner.NestedComments); // найдем КУДА
                    if NOT CleanPos_in_CodeBuff(result) then begin
                        doEvent_on_ERROR('Include file ["$I or $INCLUDE] : can`t find the end of the Directive');
       	            end
                    else begin
                        //if CodeToolBoss.SourceChangeCache.Replace(gtNone,gtNone,result,result,'{asdf}') then begin
                        if CodeToolBoss.SourceChangeCache.ReplaceEx(gtNone,gtNone,result,result,CodeBuff,result,result,CopyRAST_Text_comment_InlineReplace_PAS(_includeFileName_)) then begin
                            doEvent_onPASSED('rePlace Include file ["$I or $INCLUDE]: "'+_includeFileName_ +'"->"'+_includeFileNode_.Get_Target_obj_Name+'"');
                            //result:=FilenameEndPos+1;
			    		end
                        else begin
                            doEvent_on_ERROR('CodeToolBoss.SourceChangeCache.Replace: ERR');
    					end;
					end;
				//end;
            end
            else begin
               doEvent_on_ERROR('CodeToolBoss.SourceChangeCache.Replace: ERR');
            end;
 		end
        else begin //< название НЕ изменилось
            result:=FilenameEndPos+1;
            doEvent_onNoNeed('Include file ["$I or $INCLUDE] : the file name is "'+_includeFileName_+'" has not changed');
		end;
	end
    else begin //< не нашли
        result:=FilenameEndPos+1;
        doEvent_onNoNeed('Include file ["$I or $INCLUDE] : a file with the name "'+_includeFileName_+'" was not found');
	end;
end;


// см. function TCodeToolManager.FindIncludeDirective(Code: TCodeBuffer; StartX,

function tPrcNODE_PSF_updateInclude_D0.doOperation:boolean;
var FilenameStartPos, FileNameEndPos,
    CommentStart, CommentEnd: integer;
    ACleanPos: integer;
begin
    result:=true;
    ACleanPos:=1;
    //---
    //CodeToolBoss.SourceChangeCache.FindIncludeDirective();

    //CodeToolBoss.FindIncludeDirective(CodeBuff);
    //CodeToolBoss.

    ACleanPos:=FindNextIncludeDirective(CodeBuff.Source,ACleanPos,CodeTool.Scanner.NestedComments,FilenameStartPos,FilenameEndPos,CommentStart,CommentEnd);
  //  {$ifdef _DEBUG_}DEBUG('ШТСssssssДГВУ >> ACleanPos '+inttostr(ACleanPos)+' === '+CodeTool.CleanPosToStr(ACleanPos,true)+' ===== FilenameStartPos '+inttostr(FilenameStartPos)+', FileNameEndPos '+inttostr(FileNameEndPos)+', CommentStart '+inttostr(CommentStart)+', CommentEnd '+inttostr(CommentEnd)+'');{$endIf}
    if NOT CleanPos_in_CodeBuff(ACleanPos) then begin
        // нету тут таких директив!
        doEvent_onNoNeed('Compiler directive "$I or $INCLUDE : Include file" NOT found');
	end
    else begin
        while CleanPos_in_CodeBuff(ACleanPos) do begin
            ACleanPos:=_processing_(ACleanPos,FilenameStartPos,FilenameEndPos,CommentStart,CommentEnd);
            //-->
            ACleanPos:=FindNextIncludeDirective(CodeBuff.Source,ACleanPos,CodeTool.Scanner.NestedComments,FilenameStartPos,FilenameEndPos,CommentStart,CommentEnd);
		end;


	end;
end;

//------------------------------------------------------------------------------

function tPrcNODE_PSF_updateInclude.Is_Possible:boolean;
begin
    result:=(node4Execut is tCopyRAST_node_File_CORE) and (FilenameIsPascalUnit(node4Execut.Get_Target_fullName));
end;

function tPrcNODE_PSF_updateInclude.doOperation:boolean;
begin
    result:=doEditFile(tPrcNODE_PSF_updateInclude_D0);
end;

end.


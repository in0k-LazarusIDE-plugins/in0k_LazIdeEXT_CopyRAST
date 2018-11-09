unit in0k_CopyRAST__STAGE_05_editFiles_Handler_includes;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  BasicCodeTools,
  CodeToolManager,
  SourceChanger,
  in0k_CopyRAST_srcTree_ITEMs,
  in0k_CopyRAST__STAGE_05_editFiles_Handler,
  lazExt_CopyRAST_TEXTs,
  Classes, SysUtils;

type
_tSTAGE05_itmHandler__includes_=class(_tSTAGE05_itmHandler_)
  protected
   _objName_:string;
   _objNode_:tCopyRast_stITEM;
  protected
    function _processing_ATOM_(const ACleanPos: integer; var FilenameStartPos, FileNameEndPos, CommentStart, CommentEnd: integer):integer;
    function _processing_:boolean;
  public // ВЫПОЛНЕНИЕ
    function  Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;


implementation

function _tSTAGE05_itmHandler__includes_._processing_ATOM_(const ACleanPos: integer; var FilenameStartPos, FileNameEndPos, CommentStart, CommentEnd: integer):integer;
var fileName:string;
begin
    fileName:=Copy(_codeBuff_.Source,FilenameStartPos,FilenameEndPos-FilenameStartPos);
    //#1 проверим, есть ли такой в НАШЕЙ системе фалов
   _objName_:=fileName;
    {todo: БОЛЕЕ интелектуальный поиск, через "пути" _coreROOT_}
   _objNode_:=CopyRastNODE_findItemINCL(_coreROOT_,lowercase(_objName_));
    // _includeFileName_:=fileName;  //< это был поиск
    // _includeFileNode_:=nil;
    //  EXECUTE_4TREE(_tFindIncludeFile_);
    //#2 проверим
    if Assigned(_objNode_) then begin
       _objNode_:=CopyRAST_stITEM__findInRGT(CopyRastNODE_ROOT(executed_Root),_objNode_);
        if (Assigned(_objNode_)) and (lowercase(_objName_)<>lowercase(_objNode_.ItemNAME)) then begin
            // ну вот ... надо МЕНЯТЬ
            if CodeToolBoss.SourceChangeCache.Replace(gtNone,gtNone,FilenameStartPos,FileNameEndPos,_objNode_.ItemNAME) then begin
                // заного все поисчем начиная с ACleanPos
                // result:=FindNextIncludeDirective(_codeBuff_.Source,ACleanPos,_codeBuff_.Scanner.NestedComments, FilenameStartPos,FilenameEndPos,CommentStart,CommentEnd);
                {if NOT CleanPos_in_CodeBuff(result) then begin
                    // нету тут таких директив!
                    doEvent_on_ERROR('Include file ["$I or $INCLUDE] : divective NOT found afte replace "FileName"');
	            end
                else begin //< вставим НАШ комментарий}
                    result:=FindCommentEnd(_codeBuff_.Source,ACleanPos,_codeBuff_.Scanner.NestedComments); // найдем КУДА
                    if NOT CleanPos_in_CodeBuff(result) then begin
                        doEvent_on_ERROR('Include file ["$I or $INCLUDE] : can`t find the end of the Directive');
       	            end
                    else begin
                        //if CodeToolBoss.SourceChangeCache.Replace(gtNone,gtNone,result,result,'{asdf}') then begin
                        if CodeToolBoss.SourceChangeCache.ReplaceEx(gtNone,gtNone,result,result,_codeBuff_,result,result,CopyRAST_Text_comment_InlineReplace_PAS(_objName_)) then begin
                            doEvent_onPASSED('rePlace Include file ["$I or $INCLUDE]: "'+_objName_ +'"->"'+_objNode_.ItemNAME+'"');
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
            doEvent_onNoNeed('Include file ["$I or $INCLUDE] : the file name is "'+_objName_+'" has not changed');
		end;
	end
    else begin //< не нашли
        result:=FilenameEndPos+1;
        doEvent_onNoNeed('Include file ["$I or $INCLUDE] : a file with the name "'+_objName_+'" was not found');
	end;
end;

function _tSTAGE05_itmHandler__includes_._processing_:boolean;
var FilenameStartPos, FileNameEndPos,
    CommentStart, CommentEnd: integer;
    ACleanPos: integer;
begin
    result:=true;
    ACleanPos:=1;
    //---
    ACleanPos:=FindNextIncludeDirective(_codeBuff_.Source,ACleanPos,_codeTool_.Scanner.NestedComments,FilenameStartPos,FilenameEndPos,CommentStart,CommentEnd);
  //  {$ifdef _DEBUG_}DEBUG('ШТСssssssДГВУ >> ACleanPos '+inttostr(ACleanPos)+' === '+CodeTool.CleanPosToStr(ACleanPos,true)+' ===== FilenameStartPos '+inttostr(FilenameStartPos)+', FileNameEndPos '+inttostr(FileNameEndPos)+', CommentStart '+inttostr(CommentStart)+', CommentEnd '+inttostr(CommentEnd)+'');{$endIf}
    if NOT CleanPos_in_CodeBuff(ACleanPos) then begin
        // нету тут таких директив!
        doEvent_onNoNeed('Compiler directive "$I or $INCLUDE : Include file" NOT found');
	end
    else begin
        while CleanPos_in_CodeBuff(ACleanPos) do begin
            ACleanPos:=_processing_ATOM_(ACleanPos,FilenameStartPos,FilenameEndPos,CommentStart,CommentEnd);
            //-->
            ACleanPos:=FindNextIncludeDirective(_codeBuff_.Source,ACleanPos,_codeTool_.Scanner.NestedComments,FilenameStartPos,FilenameEndPos,CommentStart,CommentEnd);
		end;
	end;
end;

function _tSTAGE05_itmHandler__includes_.Processing:boolean;
//var srcNode:tCopyRast_stITEM;
//    untName:string;
begin
    result:=true;
    if (prcssdITEM is tCopyRastNODE_FILE) and
       (tCopyRastNODE_FILE(prcssdITEM).fileKIND in [pftUnit,pftVirtualUnit,pftMainUnit,pftInclude]) and {todo: проверить все это для INC файлов}
       (CopyRastNODE_IS_NOT_SOURCE(prcssdITEM))
    then begin
        //srcNode:=CopyRAST_stITEM__findInLFT(_coreROOT_,prcssdITEM);
        {todo: test prcssdITEM is TARGET file and have srcFile}
        if true{Assigned(srcNode) and (srcNode.ItemNAME<>prcssdITEM.ItemNAME)} then begin
            result:=_do4EDIT_;
            if result then begin
                result:=_processing_;
            end;
            result:=_doCLOSE_;
        end;
    end;
    result:=true;
end;

end.


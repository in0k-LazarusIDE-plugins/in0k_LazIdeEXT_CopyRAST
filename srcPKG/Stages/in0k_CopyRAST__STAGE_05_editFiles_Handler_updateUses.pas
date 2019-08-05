unit in0k_CopyRAST__STAGE_05_editFiles_Handler_updateUses;

{$mode objfpc}{$H+}

interface

uses

  Dialogs,

  PackageIntf,
  BasicCodeTools,

  srcTree_handler_CORE,
  lazExt_CopyRAST_TEXTs,

  CodeToolManager,
  SourceChanger,
  lazExt_CopyRAST_node,
  in0k_CopyRAST_srcTree_ITEMs,

  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  lazExt_CopyRAST_processingNODE,
  in0k_CopyRAST__STAGE_05_editFiles_Handler,
  Classes, SysUtils;


type
_tSTAGE05_itmHandler__updateUses_=class(_tSTAGE05_itmHandler_)
  protected
   _objName_:string;
   _objNode_:tCopyRast_stITEM;
  protected
   _untList_:TStrings;
  protected
    function _find_UsesSection_AFTER_(const AFTER:string; out UsesStart,UsesEnd:integer):boolean;
    function _find_UsesSection_AFTE_BEFO_(const AFTE,BEFO:string; out UsesStart,UsesEnd:integer):boolean;
    function _find_interfaceUses_start_(out UsesStart,UsesEnd:integer):boolean;
    function _find_implementationUses_start_(out UsesStart,UsesEnd:integer):boolean;
  protected
    //function _find_UnitsNameInUses_(const Start:integer; const namesList:TStrings):integer;
  protected
    function _nextAtom_Is_DOT_(const Start:integer):boolean;
  protected
    function _replaceUnitsInUses_(const Start:integer):integer;
    function _replaceUnitsInCode_(const Start:integer):integer;
  protected
    function _processing_:boolean;
  public // ВЫПОЛНЕНИЕ
    function  Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;

implementation

//------------------------------------------------------------------------------

function _tSTAGE05_itmHandler__updateUses_._find_UsesSection_AFTER_(const AFTER:string; out UsesStart,UsesEnd:integer):boolean;
var Atom:string;
begin
    Result:=false;
    // search interface section
    UsesStart:=SearchCodeInSource(_codeBuff_.Source,AFTER,1,UsesEnd,false);
    if UsesStart<1 then exit;
    //---
    Atom:=ReadNextPascalAtom(_codeBuff_.Source,UsesEnd,UsesStart);
    if UsesEnd>_codeBuff_.SourceLength then exit;
    {$ifdef _DEBUG_}DEBUG(Atom);{$endIf}
    if not (lowercase(Atom)='uses') then exit;
    //---
    Result:=TRUE;
end;


function _tSTAGE05_itmHandler__updateUses_._find_UsesSection_AFTE_BEFO_(const AFTE,BEFO:string; out UsesStart,UsesEnd:integer):boolean;
var Atom:string;
begin
    Result:=false;
    // search interface section
    UsesStart:=SearchCodeInSource(_codeBuff_.Source,AFTE,1,UsesEnd,false);
    if UsesStart<1 then exit;
    //---
    Atom:=ReadNextPascalAtom(_codeBuff_.Source,UsesEnd,UsesStart);
    //{$ifdef _DEBUG_}DEBUG(Atom+' '+inttostr(UsesStart)+' '+inttostr(UsesEnd));{$endIf}
    while UsesEnd<_codeBuff_.SourceLength do begin
        if lowercase(Atom)=BEFO then exit;
        if (lowercase(Atom)='uses') then exit(TRUE);
        //--->
        Atom:=ReadNextPascalAtom(_codeBuff_.Source,UsesEnd,UsesStart);
        //{$ifdef _DEBUG_}DEBUG(Atom+' '+inttostr(UsesStart)+' '+inttostr(UsesEnd));{$endIf}
	end;
end;

//------------------------------------------------------------------------------

function _tSTAGE05_itmHandler__updateUses_._find_interfaceUses_start_(out UsesStart,UsesEnd:integer):boolean;
begin
  Result:=_find_UsesSection_AFTE_BEFO_('interface',';', UsesStart,UsesEnd);
end;

function _tSTAGE05_itmHandler__updateUses_._find_implementationUses_start_(out UsesStart,UsesEnd:integer):boolean;
begin
  Result:=_find_UsesSection_AFTE_BEFO_('implementation',';',UsesStart,UsesEnd);
end;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------

function _tSTAGE05_itmHandler__updateUses_._replaceUnitsInUses_(const Start:integer):integer;
var tmpStart:integer;
var AtomText:string;
    newName :string;
begin
    // проходим по ВСЕМ токена в секции, пока не встретим символ ";"
    // токен считаем НАЗВАНИЕМ юнита, исчем: а надо ли его поменять

    //---
    result:=Start;
    //--- вот даже и не знаю ... нужна-ли такая проверка
    AtomText:=ReadNextPascalAtom(_codeBuff_.Source,result,tmpStart);
    if lowercase(AtomText)<>'uses' then exit(-1);
    //--- все ... поехали
    AtomText:=ReadNextPascalAtom(_codeBuff_.Source,result,tmpStart);
    while result<_codeBuff_.SourceLength do begin
        if AtomText=';' then exit //< прошли секцию ДО КОНЦА
       else
        if AtomText=',' then begin {ничего не делаем} end
       else
        if lowercase(AtomText)='in' then begin {тоже пропускаем} end
       else begin
            //{$ifdef _DEBUG_}DEBUG(AtomText+' '+inttostr(tmpStart)+' '+inttostr(result));{$endIf}
            //--- пытаемся её найти в списке НАШИХ файлов
           _objName_:=AtomText;
            {todo: БОЛЕЕ интелектуальный поиск, через "пути" _coreROOT_}
           _objNode_:=CopyRastNODE_findItemUnit(_coreROOT_,lowercase(_objName_));
            //--- проверим признак успешного поиска ... и замена
            if Assigned(_objNode_) then begin //< нашлась ... надо заменять
                {todo: проверка, что имя ИЗМЕНИЛОСЬ}
                //
               _objNode_:=CopyRAST_stITEM__findInRGT(CopyRastNODE_ROOT(executed_Root),_objNode_);
                newName:=srcTree_fsFnk_ExtractFileNameOnly(_objNode_.ItemNAME);
                newName:=srcTree_fsFnk_ChangeFileExt(newName,'');
                CodeToolBoss.SourceChangeCache.ReplaceEx(gtNone,gtNone, tmpStart, result,_codeBuff_, tmpStart, result,newName+CopyRAST_Text_comment_InlineReplace_PAS(_objName_));
               _untList_.Add(_objName_+'='+newName); //< сохраняем список, что именно изменили
                doEvent_onPASSED('rePlace in Uses : "'+_objName_ +'"->"'+srcTree_fsFnk_ExtractFileNameOnly(_objNode_.ItemNAME)+'"');
			end;
		end;
        //--->
        AtomText:=ReadNextPascalAtom(_codeBuff_.Source,result,tmpStart);
	end;
end;


function _tSTAGE05_itmHandler__updateUses_._nextAtom_Is_DOT_(const Start:integer):boolean;
var tmpStart:integer;
var tmp_Stop:integer;
var AtomText:string;
begin
    tmp_Stop:=Start;
    AtomText:=ReadNextPascalAtom(_codeBuff_.Source,tmp_Stop,tmpStart);
    result:=AtomText='.';
end;

function _tSTAGE05_itmHandler__updateUses_._replaceUnitsInCode_(const Start:integer):integer;
var tmpStart:integer;
var AtomText:string;
    i       :integer;
begin
    ShowMessage('----------------------------------------'+inttostr(Start));

    result:=Start;
    AtomText:=ReadNextPascalAtom(_codeBuff_.Source,result,tmpStart);
    while tmpStart<_codeBuff_.SourceLength do begin
        AtomText:=lowercase(AtomText);
        //---
        i:=_untList_.IndexOfName(AtomText);
        if i>=0 then begin
            ShowMessage('----------------------------------------'+inttostr(i)+'===');
            {$ifdef _DEBUG_}DEBUG('interfaceUses FIND in CODE '+' '+inttostr(tmpStart)+' '+inttostr(result));{$endIf}
            if _nextAtom_Is_DOT_(result) then begin
                CodeToolBoss.SourceChangeCache.ReplaceEx(gtNone,gtNone, tmpStart, result,_codeBuff_, tmpStart, result,_untList_.ValueFromIndex[i]+CopyRAST_Text_comment_InlineReplace_PAS(AtomText));
                doEvent_onPASSED('rePlace in Code : "'+AtomText +'"->"'+srcTree_fsFnk_ExtractFileNameOnly(_untList_.ValueFromIndex[i])+'"');
			end;
		end;
        //--->
        AtomText:=ReadNextPascalAtom(_codeBuff_.Source,result,tmpStart);
	end;
end;

//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------


function _tSTAGE05_itmHandler__updateUses_._processing_:boolean;
var UsesStart,UsesEnd:integer;
begin
   _untList_:=TStringList.Create;
    //---
    if _find_interfaceUses_start_(UsesStart,UsesEnd)
    then begin
       UsesEnd:=_replaceUnitsInUses_(UsesStart)
	end
    else doEvent_onNoNeed('interface Uses NOT found');
    //---
    if _find_implementationUses_start_(UsesStart,UsesEnd)
    then begin
        UsesEnd:=_replaceUnitsInUses_(UsesStart);
	end
    else doEvent_onNoNeed('implementation Uses NOT found');
    //---
    if (_untList_.Count>0) then begin
        doEvent_onPASSED('rePlace in Code : --------------');
        UsesStart:=SearchCodeInSource(_CodeBuff_.Source,'implementation',1,UsesEnd,false);
        if UsesEnd>=1 then begin
     	   _replaceUnitsInCode_(UsesEnd);
		end;
	end
    else doEvent_onNoNeed('not replaced Units');
    //---
   _untList_.FREE;
    //---
    result:=TRUE;//EXECUTE_4TREE(tPrcNODE_PSF_updateUses_D1);
end;

//------------------------------------------------------------------------------

function _tSTAGE05_itmHandler__updateUses_.Processing:boolean;
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


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
        BasicCodeTools,
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
 protected
  _objName_:string;
  _objNode_:tCopyRAST_node;
  protected
    function _find_UsesSection_AFTER_(const AFTER:string; out UsesStart,UsesEnd:integer):boolean;
    function _find_UsesSection_AFTE_BEFO_(const AFTE,BEFO:string; out UsesStart,UsesEnd:integer):boolean;
    function _find_interfaceUses_start_(out UsesStart,UsesEnd:integer):boolean;
    function _find_implementationUses_start_(out UsesStart,UsesEnd:integer):boolean;
  protected
    function _find_units_(const Start:integer):boolean;
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
    Position:integer;
    IdentStart,IdentEnd:integer;
    var UsesStart,UsesEnd:integer;
begin
    result:=true;
    //---
   { if _find_interfaceUses_start_(UsesStart,UsesEnd)
    then DEBUG('interfaceUses FIND '+' '+inttostr(UsesStart)+' '+inttostr(UsesEnd))
    else DEBUG('interfaceUses not'); }



    {
    if CodeBuff.Filename= 'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\CopyRAST\srcPKG\lazExt_CopyRAST_CR.pas' then begin
        //DEBUG('----------'+CodeBuff.Filename+' '+fndNAME+'->'+repNAME);


        CodeTool.BuildTreeAndGetCleanPos();

        //CodeTool.FindUsedUnitNames();
        // CodeTool.BuildTreeAndGetCleanPos();

      //CodeTool.findu;

        Position:=1;
        GetIdentStartEndAtPosition(CodeBuff.Source, Position, IdentStart,IdentEnd);
        while IdentStart<IdentEnd do begin
            DEBUG(copy(CodeBuff.Source,IdentStart,IdentEnd-IdentStart)+' '+inttostr(Position)+' '+inttostr(IdentStart)+' '+inttostr(IdentEnd)+' ');
            //-->
            Position:=IdentEnd+2;
            GetIdentStartEndAtPosition(CodeBuff.Source, Position, IdentStart,IdentEnd);
	    end;
        // CodeToolBoss.FindUnusedUnits();
        //CodeTool.Src:=;
    end;

{    procedure GetIdentStartEndAtPosition(const Source:string; Position:integer;
    out IdentStart,IdentEnd:integer);


    //        CodeTool.BuildTree();
   // CodeBuff.;

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
    end; } }
end;



{%region --- find Include file /fold}

type
_tFindIncludeFile_=class(tPrcNODE_Base)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;

function _tFindIncludeFile_.Is_Possible:boolean;
begin
    result:=(Tool_Parent is tPrcNODE_PSF_updateUses_D0)
            and
            (node4Execut is tCopyRAST_node_File_CORE)
            //and
            //(tCopyRAST_node_File_CORE(node4Execut).FileTYPE=pftInclude);
end;

function _tFindIncludeFile_.doOperation:boolean;
begin
    if 0=CompareFilenamesIgnoreCase(lowercase( ExtractFileNameWithoutExt(node4Execut.Get_Source_obj_Name)),tPrcNODE_PSF_updateUses_D0(Tool_Parent)._objName_) then begin
        tPrcNODE_PSF_updateUses_D0(Tool_Parent)._objNode_:=node4Execut;
        result:=FALSE; //<
	end
    else begin
        result:=TRUE;  //< продолжать поиски
	end;
end;

{%endregion}

//------------------------------------------------------------------------------

function tPrcNODE_PSF_updateUses_D0.Is_Possible:boolean;
begin
    result:=TRUE;
end;


function tPrcNODE_PSF_updateUses_D0._find_UsesSection_AFTER_(const AFTER:string; out UsesStart,UsesEnd:integer):boolean;
var Atom:string;
begin
    Result:=false;
    // search interface section
    UsesStart:=SearchCodeInSource(CodeBuff.Source,AFTER,1,UsesEnd,false);
    if UsesStart<1 then exit;
    //---
    Atom:=ReadNextPascalAtom(CodeBuff.Source,UsesEnd,UsesStart);
    if UsesEnd>CodeBuff.SourceLength then exit;
    {$ifdef _DEBUG_}DEBUG(Atom);{$endIf}
    if not (lowercase(Atom)='uses') then exit;
    //---
    Result:=TRUE;
end;


function tPrcNODE_PSF_updateUses_D0._find_UsesSection_AFTE_BEFO_(const AFTE,BEFO:string; out UsesStart,UsesEnd:integer):boolean;
var Atom:string;
begin
    Result:=false;
    // search interface section
    UsesStart:=SearchCodeInSource(CodeBuff.Source,AFTE,1,UsesEnd,false);
    if UsesStart<1 then exit;
    //---
    Atom:=ReadNextPascalAtom(CodeBuff.Source,UsesEnd,UsesStart);
    //{$ifdef _DEBUG_}DEBUG(Atom+' '+inttostr(UsesStart)+' '+inttostr(UsesEnd));{$endIf}
    while UsesEnd<CodeBuff.SourceLength do begin
        if lowercase(Atom)=BEFO then exit;
        if (lowercase(Atom)='uses') then exit(TRUE);
        //--->
        Atom:=ReadNextPascalAtom(CodeBuff.Source,UsesEnd,UsesStart);
        //{$ifdef _DEBUG_}DEBUG(Atom+' '+inttostr(UsesStart)+' '+inttostr(UsesEnd));{$endIf}
	end;
end;

//------------------------------------------------------------------------------

function tPrcNODE_PSF_updateUses_D0._find_interfaceUses_start_(out UsesStart,UsesEnd:integer):boolean;
begin
  Result:=_find_UsesSection_AFTE_BEFO_('interface',';', UsesStart,UsesEnd);
end;

function tPrcNODE_PSF_updateUses_D0._find_implementationUses_start_(out UsesStart,UsesEnd:integer):boolean;
begin
  Result:=_find_UsesSection_AFTE_BEFO_('implementation',';',UsesStart,UsesEnd);
end;

//------------------------------------------------------------------------------

function tPrcNODE_PSF_updateUses_D0._find_units_(const Start:integer):boolean;
var UsesStart,UsesEnd:integer;
var Atom:string;
begin
    //---
    UsesEnd:=Start;
    //---
    Atom:=ReadNextPascalAtom(CodeBuff.Source,UsesEnd,UsesStart);
    if lowercase(Atom)<>'uses' then exit(false);
    //---
    Atom:=ReadNextPascalAtom(CodeBuff.Source,UsesEnd,UsesStart);
    while UsesEnd<CodeBuff.SourceLength do begin
        if Atom=';' then exit(TRUE);
        if (Atom<>',')and(lowercase(Atom)<>'in') then begin
            {$ifdef _DEBUG_}DEBUG(Atom+' '+inttostr(UsesStart)+' '+inttostr(UsesEnd));{$endIf}
            //--- пытаемся её найти в списке НАШИХ файлов
           _objName_:=lowercase(Atom);
           _objNode_:=nil;
            EXECUTE_4TREE(_tFindIncludeFile_);
            //---
            if Assigned(_objNode_) then begin //< нашлась ... надо заменять
                {$ifdef _DEBUG_}DEBUG('9999999999999999999');{$endIf}
                CodeToolBoss.SourceChangeCache.ReplaceEx(gtNone,gtNone, UsesStart, UsesEnd,CodeBuff, UsesStart, UsesEnd, ExtractFileNameWithoutExt(_objNode_.Get_Target_obj_Name)+CopyRAST_Text_comment_InlineReplace_PAS(_objName_));
                doEvent_onPASSED('rePlace in Uses : "'+_objName_ +'"->"'+ExtractFileNameWithoutExt(_objNode_.Get_Target_obj_Name)+'"');

			end;
            //---
		end;
        //--->
        Atom:=ReadNextPascalAtom(CodeBuff.Source,UsesEnd,UsesStart);
	end;
end;

//------------------------------------------------------------------------------

function tPrcNODE_PSF_updateUses_D0.doOperation:boolean;
var UsesStart,UsesEnd:integer;
begin
    {$ifdef _DEBUG_}DEBUG('----------'+node4Execut.Get_Target_obj_Name);{$endIf}
    //---
    if _find_interfaceUses_start_(UsesStart,UsesEnd)
    then begin
        DEBUG('interfaceUses FIND '+' '+inttostr(UsesStart)+' '+inttostr(UsesEnd));
       _find_units_(UsesStart)
	end
    else DEBUG('interfaceUses not');
    //---
    if _find_implementationUses_start_(UsesStart,UsesEnd)
    then begin
        DEBUG('implementationUses FIND '+' '+inttostr(UsesStart)+' '+inttostr(UsesEnd));
       _find_units_(UsesStart)
	end
    else DEBUG('implementationUses not');


    result:=TRUE;//EXECUTE_4TREE(tPrcNODE_PSF_updateUses_D1);
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


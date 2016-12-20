unit prcNode_XML_CompilerOptions_SearchPaths;

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
     {$endIf}
    lazExt_CopyRAST_from_IDEProcs,
    lazExt_CopyRAST_node_Folder,
    prcNode_XML_updateLPK;


{todo: ДЕЛАТЬ надо ФВСЕ}


type

 tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_DO=class(tPrcNODE_xml_updLpk_DO)
  protected
    function _SearchPath_getName_:string; virtual;
    function _config_getPath_    :string; virtual;
    function _getKind_Srch_:eCopyRAST_node_SrchPath; virtual;
  protected
   _tmpDirNAME_:string;
  protected
    function doOperation:boolean; override;
  end;




 tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fu=class(tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_DO)
 protected
   function _SearchPath_getName_:string;                  override;
   function _getKind_Srch_:eCopyRAST_node_SrchPath; override;

  end;

 tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fi=class(tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_DO)
 protected
   function _SearchPath_getName_:string;                  override;
   function _getKind_Srch_:eCopyRAST_node_SrchPath; override;

  end;

 tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fl=class(tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_DO)
 protected
   function _SearchPath_getName_:string;                  override;
   function _getKind_Srch_:eCopyRAST_node_SrchPath; override;
  end;


implementation

type

  tPrcNODE__DO__=class(tPrcNODE_xml_updLpk_DO)
   protected
    function prntTOOL_VALID:boolean;
    function prntTOOL:tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_DO;
   protected
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
   end;

function tPrcNODE__DO__.prntTOOL:tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_DO;
begin
    result:=nil;
    if Tool_Parent is tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_DO
    then result:=tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_DO(Tool_Parent)
    else begin
        if Assigned(Tool_Parent) then doEvent_on_ERROR('Vrong parent TOOL: '+Tool_Parent.ClassName)
        else doEvent_on_ERROR('Parent TOOL is NIL');
	end;
end;

function tPrcNODE__DO__.prntTOOL_VALID:boolean;
begin
    result:=Assigned(prntTOOL);
end;

function tPrcNODE__DO__.Is_Possible:boolean;
begin
    result:=(node4Execut is tCopyRAST_node_Folder) and //< это ПАПКА
            (prntTOOL_VALID) and
            // НУЖНЫЙ нам ПУТЬ по типу
            (prntTOOL._getKind_Srch_ in tCopyRAST_node_Folder(node4Execut).inPATHs);
end;

function tPrcNODE__DO__.doOperation:boolean;
begin
    if prntTOOL._tmpDirNAME_=node4Execut.source_Text then begin
        // запосним что на замену
        {TODO: ОБЯЗАТЕЛЬНО надо делать}
        //prntTOOL._tmpDirNAME_:=node4Execut.Get_Target_fullName;
        // для отчета, изменилось или нет
        if node4Execut.source_Text<>node4Execut.Get_Target_fullName
        then doEvent_onPASSED('Rename DIR "'+node4Execut.source_Text+'"->"'+prntTOOL._tmpDirNAME_+'"')
        else doEvent_onNoNeed('Search DIR "'+node4Execut.source_Text+'" NOT changed');
	end;
end;

function tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_DO._getKind_Srch_:eCopyRAST_node_SrchPath;
begin

end;

function tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_DO._SearchPath_getName_:string;
begin

end;

function tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_DO._config_getPath_:string;
begin
    result:='Package/CompilerOptions/SearchPaths/'+_SearchPath_getName_+'/Value';
end;

function tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_DO.doOperation:boolean;
var SearchPath_old:string;
    SearchPath_NEW:string;
    single_Dir_old:string;
    i     :integer;
begin
    SearchPath_NEW:='';
    SearchPath_old:=XMLConfg.GetValue(_config_getPath_,'');
    if SearchPath_old<>'' then begin
        //---
        i:=1;
        single_Dir_old:=GetNextDirectoryInSearchPath(SearchPath_old,i);
        while single_Dir_old<>'' do begin
            //--- готовимся к запуску проверки (получению) изменений
           _tmpDirNAME_:=single_Dir_old;
            EXECUTE_4TREE(tPrcNODE__DO__);
            //--- продолжаем формировать НОВУЮ строку поиска
            if (SearchPath_NEW<>'')and(_tmpDirNAME_<>'') then SearchPath_NEW:=SearchPath_NEW+cSearchPaths_delimeter;
            SearchPath_NEW:=SearchPath_NEW+_tmpDirNAME_;
            //-->
            single_Dir_old:=GetNextDirectoryInSearchPath(SearchPath_old,i);
        end;
        //--- запоминаем изменения, если необходимо
        if SearchPath_old<>SearchPath_NEW then begin
            XMLConfg.SetDeleteValue(_config_getPath_,SearchPath_NEW,'');
            doEvent_onPASSED('replace Search Path "'+_SearchPath_getName_+'": "'+SearchPath_old+'"->"'+SearchPath_NEW+'"');
		end
        else doEvent_onNoNeed('Search Path "'+_SearchPath_getName_+'" NOT changed');
	end
    else begin // а такого то и нет :-)
        doEvent_onNoNeed('Search Path "'+_SearchPath_getName_+'" NOT represented')
	end;
end;


function tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fu._SearchPath_getName_:string;
begin
    result:='OtherUnitFiles';
end;

function tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fu._getKind_Srch_:eCopyRAST_node_SrchPath;
begin
    result:=CopyRAST_node_SrchPTH__Fu;
end;

function tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fi._SearchPath_getName_:string;
begin
    result:='IncludeFiles';
end;
function tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fi._getKind_Srch_:eCopyRAST_node_SrchPath;
begin
    result:=CopyRAST_node_SrchPTH__Fi;
end;

function tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fl._SearchPath_getName_:string;
begin
    result:='Libraries';
end;

function tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fl._getKind_Srch_:eCopyRAST_node_SrchPath;
begin
    result:=CopyRAST_node_SrchPTH__Fl;
end;

end.


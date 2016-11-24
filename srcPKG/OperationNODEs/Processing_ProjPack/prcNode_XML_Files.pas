unit prcNode_XML_Files;

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
    FileUtil,    LazFileUtils, sysutils,
    lazExt_CopyRAST_from_IDEProcs,
    lazExt_CopyRAST_node_File,
    prcNode_XML_updateLPK;


{todo: ДЕЛАТЬ надо ФВСЕ}


type

 tPrcNODE_xmlPrjPkg_Files_DO=class(tPrcNODE_xml_updLpk_DO)
  protected
    function _SearchPath_getName_:string; virtual;
    function _config_getPath_    :string; virtual;
  protected
   _FileName_:string;
   _UnitName_:string;
  protected
    function doOperation(const cnfgPTH:string):boolean; virtual;
    function doOperation:boolean; override;
  end;


{

 tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fu=class(tPrcNODE_xmlPrjPkg_Files_DO)
 protected
   function _SearchPath_getName_:string;                  override;
   function _getKind_Srch_:eCopyRAST_node_SrchPath; override;

  end;

 tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fi=class(tPrcNODE_xmlPrjPkg_Files_DO)
 protected
   function _SearchPath_getName_:string;                  override;
   function _getKind_Srch_:eCopyRAST_node_SrchPath; override;

  end;

 tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fl=class(tPrcNODE_xmlPrjPkg_Files_DO)
 protected
   function _SearchPath_getName_:string;                  override;
   function _getKind_Srch_:eCopyRAST_node_SrchPath; override;
  end;
}

implementation

type

  tPrcNODE__DO__=class(tPrcNODE_xml_updLpk_DO)
   protected
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
   end;

function tPrcNODE__DO__.Is_Possible:boolean;
begin
    result:=(node4Execut is tCopyRAST_node_FILE) and
            (self.Tool_Parent is tPrcNODE_xmlPrjPkg_Files_DO);
end;

function tPrcNODE__DO__.doOperation:boolean;
begin
    result:=true;
    //{$ifdef _DEBUG_}DEBUG(tPrcNODE_xmlPrjPkg_Files_DO(self.Tool_Parent)._FileName_+' '+node4Execut.NodeTXT+' ');{$endIf}
    if node4Execut.NodeTXT=tPrcNODE_xmlPrjPkg_Files_DO(self.Tool_Parent)._FileName_ then begin
        tPrcNODE_xmlPrjPkg_Files_DO(self.Tool_Parent)._FileName_:=AppendPathDelim(ExtractFileDir(tPrcNODE_xmlPrjPkg_Files_DO(self.Tool_Parent)._FileName_))+node4Execut.Get_Target_obj_Name;
        tPrcNODE_xmlPrjPkg_Files_DO(self.Tool_Parent)._UnitName_:=ExtractFileNameWithoutExt(node4Execut.Get_Target_obj_Name);
        //---
        result:=FALSE; //< ВСЕ, нашли ... дальше идти по дереву НЕ надо
	end;
end;


function tPrcNODE_xmlPrjPkg_Files_DO._SearchPath_getName_:string;
begin

end;

function tPrcNODE_xmlPrjPkg_Files_DO._config_getPath_:string;
begin
    result:='Package/Files/'+_SearchPath_getName_+'/Value';
end;


function tPrcNODE_xmlPrjPkg_Files_DO.doOperation(const cnfgPTH:string):boolean;
var tmp_FileName:string;
    tmp_UnitName:string;
begin
    result:=true;
    //---
    tmp_Filename:=XMLConfg.GetValue(cnfgPTH+'/'+'Filename'+'/'+'Value','');
    tmp_UnitName:=XMLConfg.GetValue(cnfgPTH+'/'+'UnitName'+'/'+'Value','');
    //---
    if tmp_Filename<>'' then begin
       _FileName_:=tmp_Filename;
       _UnitName_:=tmp_UnitName;
        EXECUTE_4TREE(tPrcNODE__DO__);
        if (_FileName_<>tmp_FileName)or(_UnitName_<>tmp_UnitName) then begin
            XMLConfg.SetDeleteValue(cnfgPTH+'/'+'Filename'+'/'+'Value',_FileName_,'');
            XMLConfg.SetDeleteValue(cnfgPTH+'/'+'UnitName'+'/'+'Value',_UnitName_,'');
            doEvent_onPASSED('replace path "'+cnfgPTH+'"');
		end;
	end;
end;

function tPrcNODE_xmlPrjPkg_Files_DO.doOperation:boolean;
var tmpPTH:string;
    SP_NEW:string;
    singlDir:string;
    i     :integer;
begin
    {$ifdef _DEBUG_}DEBUG(self.ClassName);{$endIf}
    i:=XMLConfg.GetValue('Package/Files/Count',0);
    for i:=1 to i do begin
        tmpPTH:='Package/Files/Item'+inttostr(i);
        doOperation(tmpPTH);
	end;
end;

{
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
end;  }

end.


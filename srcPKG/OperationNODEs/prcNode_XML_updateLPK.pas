unit prcNode_XML_updateLPK;

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
        LazFileUtils,
    lazExt_CopyRAST_node_File,
    prcNode_core_xmlEdit;

type

 tPrcNODE_xml_updateLpk=class(tPrcNODE_core_xmlEdit)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;

 tPrcNODE_xml_updLpk_DO=class(tPrcNODE_core_xmlEditDO)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;

implementation
uses prcNode_XML_updateLPK_v4;


function tPrcNODE_xml_updLpk_DO.Is_Possible:boolean;
begin
    result:=(node4Execut is tCopyRAST_node_File_CORE)
            and
            (CompareFileExt(node4Execut.Get_Target_fullName,'lpk',FALSE)=0)
end;

function tPrcNODE_xml_updLpk_DO.doOperation:boolean;
begin
    if XMLConfg.GetValue('Package/Version',0)=4 then begin
        EXECUTE_4NODE(tPrcNODE_xml_updLpkV4_DO);
        {$ifdef _DEBUG_}DEBUG('LPK EDIT');{$endIf}
	end
    else begin
        {$ifdef _DEBUG_}DEBUG('ERRRRR');{$endIf}
	end;
end;

//------------------------------------------------------------------------------

function tPrcNODE_xml_updateLpk.Is_Possible:boolean;
begin
    result:=(node4Execut is tCopyRAST_node_File_CORE)
            and
            (CompareFileExt(node4Execut.Get_Target_fullName,'lpk',FALSE)=0);
end;

function tPrcNODE_xml_updateLpk.doOperation:boolean;
begin
    result:=doEditFile(tPrcNODE_xml_updLpk_DO);
end;

end.


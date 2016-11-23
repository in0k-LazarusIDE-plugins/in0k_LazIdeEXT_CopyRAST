unit prcNode_XML_updateLPK_v4;

{$mode objfpc}{$H+}

interface

uses prcNode_XML_updateLPK,
     lazExt_CopyRAST_node_Folder,
     prcNode_XML_CompilerOptions_SearchPaths,
     prcNode_XML_Files;

type


 tPrcNODE_xml_updLpkV4_DO=class(tPrcNODE_xml_updLpk_DO)
  protected
    function doOperation:boolean; override;
  end;

implementation


function tPrcNODE_xml_updLpkV4_DO.doOperation:boolean;
begin
    //--- пути поиска
    self.EXECUTE_4NODE(tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fu);
    self.EXECUTE_4NODE(tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fi);
    self.EXECUTE_4NODE(tPrcNODE_xmlPrjPkg_CompilerOptions_SearchPaths_Fl);
    //--- назнвания ФАЙЛОВ
    self.EXECUTE_4NODE(tPrcNODE_xmlPrjPkg_Files_DO);

end;

end.


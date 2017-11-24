unit lazExt_CopyRAST__xmlConfig_approvedFILEs2NAMEs;

{$mode objfpc}{$H+}

interface

uses
  lazExt_CopyRAST__xmlConfig;

const
 cCopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION    ='approvedFILEs2NAMEs';
 cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName    ='newName';
 cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName_DEF='Copy';






function CopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION:string;



function  CRxC_aF2N_lazObj_NewName__GET(const CNF:tLazExt_CopyRAST_CONFIG):string;
procedure CRxC_aF2N_lazObj_NewName__SET(const CNF:tLazExt_CopyRAST_CONFIG; const value:string);

implementation

function CopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION:string;
begin
    result:=cLazExt_CopyRAST__xmlConfig_SECTION+cXmlConfig_pathDELIM+cCopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION;
end;



//------------------------------------------------------------------------------

function CRxC_aF2N_lazObj_NewName__GET(const CNF:tLazExt_CopyRAST_CONFIG):string;
begin
    result:=CNF.GetValue( CopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION+cXmlConfig_pathDELIM+cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName+cXmlConfig_pathDELIM+cXmlConfig_valueNAME, cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName_DEF);
end;


procedure CRxC_aF2N_lazObj_NewName__SET(const CNF:tLazExt_CopyRAST_CONFIG; const value:string);
begin
    CNF.SetDeleteValue( CopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION+cXmlConfig_pathDELIM+cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName+cXmlConfig_pathDELIM+cXmlConfig_valueNAME, value, cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName_DEF);
end;




end.


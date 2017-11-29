unit lazExt_CopyRAST__xmlConfig_approvedFILEs2NAMEs;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs,
  lazExt_CopyRAST__xmlConfig;

const
 cCopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION    ='approvedFILEs2NAMEs';
 cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName    ='newName';
 cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName_DEF='Copy_';
 cCopyRast_xmlCNFG_approvedFILEs2NAMEs_Names      ='Names';






function CopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION:string;


function  CRxC_aF2N_ROOT_newName__GET(const CNF:tLazExt_CopyRAST_CONFIG; const oldName:string):string;
procedure CRxC_aF2N_ROOT_newName__SET(const CNF:tLazExt_CopyRAST_CONFIG; const newName:string);

function  CRxC_aF2N_BASE_newName__GET(const CNF:tLazExt_CopyRAST_CONFIG; const oldPath:string):string;
procedure CRxC_aF2N_BASE_newName__SET(const CNF:tLazExt_CopyRAST_CONFIG; const newPath:string);


function  CRxC_aF2N_lazObj_NewName__GET(const CNF:tLazExt_CopyRAST_CONFIG):string;
procedure CRxC_aF2N_lazObj_NewName__SET(const CNF:tLazExt_CopyRAST_CONFIG; const value:string);

          //lECRxCaF2N_newName

procedure CRxC_aF2N__names_Load(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);
procedure CRxC_aF2N__names_Save(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);


implementation

function _section_:string;
begin
    result:=CopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION;
end;

function CopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION:string;
begin
    result:=cLazExt_CopyRAST__xmlConfig_SECTION+cXmlConfig_pathDELIM+cCopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION;
end;

//------------------------------------------------------------------------------

function _ROOT_NewName__path_:string;
begin
    result:= lERxC_addObjVal(_section_,'ROOT','newName')
end;

function CRxC_aF2N_ROOT_NewName__GET(const CNF:tLazExt_CopyRAST_CONFIG; const oldName:string):string;
begin
    result:=CNF.GetValue( _ROOT_NewName__path_,cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName_DEF+oldName);
end;

procedure CRxC_aF2N_ROOT_NewName__SET(const CNF:tLazExt_CopyRAST_CONFIG; const newName:string);
begin
    CNF.SetDeleteValue(_ROOT_NewName__path_, newName,'');
end;

//------------------------------------------------------------------------------

function _BASE_NewPath__path_:string;
begin
    result:= lERxC_addObjVal(_section_,'BASE','newPath')
end;

function CRxC_aF2N_BASE_newName__GET(const CNF:tLazExt_CopyRAST_CONFIG; const oldPath:string):string;
begin
    result:=CNF.GetValue( _BASE_NewPath__path_,oldPath);
end;

procedure CRxC_aF2N_BASE_newName__SET(const CNF:tLazExt_CopyRAST_CONFIG; const newPath:string);
begin
    CNF.SetDeleteValue(_BASE_NewPath__path_, newPath,'');
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

//------------------------------------------------------------------------------

const
  _objNames_newName_='NameNew';
  _objNames_cstName_='NameCST';
  _objNames_newPath_='PathNew';
  _objNames_cstPath_='PathCST';

procedure CRxC_aF2N__names_Load_obj(const CNF:tLazExt_CopyRAST_CONFIG; const Section,NodeName:string; out obj:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
begin
    obj:=tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME.Create;
    //---
    obj.newName:=CNF.GetValue( lERxC_addObjVal(Section,NodeName,_objNames_newName_),'');
    obj.cstName:=CNF.GetValue( lERxC_addObjVal(Section,NodeName,_objNames_cstName_),true);
    //--
    obj.newPath:=CNF.GetValue( lERxC_addObjVal(Section,NodeName,_objNames_newPath_),'');
    obj.cstPath:=CNF.GetValue( lERxC_addObjVal(Section,NodeName,_objNames_cstPath_),true);
end;

procedure CRxC_aF2N__names_Save_obj(const CNF:tLazExt_CopyRAST_CONFIG; const Section,NodeName:string; const obj:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
begin
    CNF.SetDeleteValue( lERxC_addObjVal(Section,NodeName,_objNames_newName_),obj.newName,'');
    CNF.SetDeleteValue( lERxC_addObjVal(Section,NodeName,_objNames_cstName_),obj.cstName,true);
    //--
    CNF.SetDeleteValue( lERxC_addObjVal(Section,NodeName,_objNames_newPath_),obj.newPath,'');
    CNF.SetDeleteValue( lERxC_addObjVal(Section,NodeName,_objNames_cstPath_),obj.cstPath,true);
end;

//------------------------------------------------------------------------------

procedure CRxC_aF2N__names_Load(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);
var cnt:integer;
    i  :integer;
begin
    Names.Clear;
    //
    cnt:=CNF.GetValue( lERxC_addObjVal(_section_,'BASE','count'),0);
    for i:=0 to cnt-1 do begin

    end;
end;


procedure CRxC_aF2N__names_Save(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);
begin

end;



end.


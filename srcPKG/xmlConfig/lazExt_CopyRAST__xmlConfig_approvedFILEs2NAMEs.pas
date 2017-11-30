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

procedure CRxC_aF2N__namesFILE_Load(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);
procedure CRxC_aF2N__namesFILE_Save(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);


implementation

const
 _cObjNames_ITEM_='item';
 _cObjNames_PATH_='Path';

//



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
    result:= lERxC_8Value(_section_,'ROOT','newName')
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
    result:= lERxC_8Value(_section_,'BASE','newPath')
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
  _objNames_cstName_='NameCustom';
  _objNames_newName_='NameNew';
  _objNames_cstPath_='PathCustom';
  _objNames_newPath_='PathNew';

procedure CRxC_aF2N__names_Load_obj(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out obj:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
begin
    obj:=tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME.Create;
    //---
    obj.nameCst:=CNF.GetValue( lERxC_8Value(Section,_objNames_cstName_),true);
    obj.nameNew:=CNF.GetValue( lERxC_8Value(Section,_objNames_newName_),'');
    //--
    obj.pathCst:=CNF.GetValue( lERxC_8Value(Section,_objNames_cstPath_),true);
    obj.pathNew:=CNF.GetValue( lERxC_8Value(Section,_objNames_newPath_),'');
end;

procedure CRxC_aF2N__names_Save_obj(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const obj:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
begin
    CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_cstName_),obj.nameCst,true);
    CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_newName_),obj.nameNew,'');
    //--
    CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_cstPath_),obj.pathCst,true);
    CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_newPath_),obj.pathNew,'');
end;

//------------------------------------------------------------------------------


procedure _names_Load_(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const Names:TStrings);
var itmName:string;
var cnt:integer;
    i  :integer;
    tmp:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME;
begin
    Names.Clear;
    cnt:=CNF.GetValue( lERxC_8Count(Section),0);
    for i:=0 to cnt-1 do begin
        str(i,itmName);
        itmName:=lERxC_sctn8Name(section,_cObjNames_ITEM_+itmName);
        CRxC_aF2N__names_Load_obj(cnf,itmName,tmp);
        itmName:=Cnf.GetValue( lERxC_sctn8Name(itmName,_cObjNames_PATH_),'');
        NAMEs.AddObject(itmName,tmp);
    end;
end;

procedure _names_Save_(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const Names:TStrings);
var itmName:string;
var i  :integer;
    tmp:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME;
begin
    CNF.DeletePath(Section);
    if Names.Count>0 then begin
        CNF.SetValue(lERxC_8Count(Section), Names.Count);
        for i:=0 to Names.Count-1 do begin
            str(i,itmName);
            itmName:=lERxC_sctn8Name(section,_cObjNames_ITEM_+itmName);
            tmp:=tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME(Names.Objects[i]);
            CRxC_aF2N__names_Save_obj(cnf,itmName,tmp);
            Cnf.SetValue( lERxC_sctn8Name(itmName,_cObjNames_PATH_),Names.Strings[i]);
        end;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const
  _objNames_FILEs_='FILEs';
  _objNames_FLDRs_='FLDRs';


function _namesFILE_Section_:string;
begin
    result:=CopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION;
    result:=lERxC_sctn8Name(result,cCopyRast_xmlCNFG_approvedFILEs2NAMEs_Names);
    result:=lERxC_sctn8Name(result,_objNames_FILEs_);
end;

procedure CRxC_aF2N__namesFILE_Load(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);
begin
   _names_Load_(CNF,_namesFILE_Section_,Names);
end;

procedure CRxC_aF2N__namesFILE_Save(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);
begin
    _names_Save_(CNF,_namesFILE_Section_,Names);
end;



end.


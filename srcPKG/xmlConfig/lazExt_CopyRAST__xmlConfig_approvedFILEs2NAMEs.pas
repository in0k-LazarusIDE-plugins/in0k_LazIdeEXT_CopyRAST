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


//function  CRxC_aF2N_ROOT_newName__GET(const CNF:tLazExt_CopyRAST_CONFIG; const oldName:string):string;
//procedure CRxC_aF2N_ROOT_newName__SET(const CNF:tLazExt_CopyRAST_CONFIG; const newName:string);

//function  CRxC_aF2N_BASE_newName__GET(const CNF:tLazExt_CopyRAST_CONFIG; const oldPath:string):string;
//procedure CRxC_aF2N_BASE_newName__SET(const CNF:tLazExt_CopyRAST_CONFIG; const newPath:string);


//function  CRxC_aF2N_lazObj_NewName__GET(const CNF:tLazExt_CopyRAST_CONFIG):string;
//procedure CRxC_aF2N_lazObj_NewName__SET(const CNF:tLazExt_CopyRAST_CONFIG; const value:string);

          //lECRxCaF2N_newName


procedure CRxC_aF2N__namesROOT_Load(const CNF:tLazExt_CopyRAST_CONFIG; const obj:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
procedure CRxC_aF2N__namesROOT_Save(const CNF:tLazExt_CopyRAST_CONFIG; const obj:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);

procedure CRxC_aF2N__namesFILE_Load(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);
procedure CRxC_aF2N__namesFILE_Save(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);

procedure CRxC_aF2N__namesFLDR_Load(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);
procedure CRxC_aF2N__namesFLDR_Save(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);



procedure CRxC_aF2N__tmplItem__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out   item:tCopyRAST_Handler_ReNAMEs_template);
procedure CRxC_aF2N__tmplItem__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out   item:tCopyRAST_Handler_ReNAMEs_template);
procedure CRxC_aF2N__template__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out   laer:tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER);
procedure CRxC_aF2N__template__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out   laer:tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER);
procedure CRxC_aF2N__templates_Load(const CNF:tLazExt_CopyRAST_CONFIG; const list:TStrings);
procedure CRxC_aF2N__templates_Save(const CNF:tLazExt_CopyRAST_CONFIG; const list:TStrings);


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
    result:=cCopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION;
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
    obj.nameNew:=CNF.GetValue( lERxC_8Value(Section,_objNames_newName_),'');
    obj.nameCst:=CNF.GetValue( lERxC_8Value(Section,_objNames_cstName_),obj.nameNew<>'');
    //--
    obj.pathNew:=CNF.GetValue( lERxC_8Value(Section,_objNames_newPath_),'');
    obj.pathCst:=CNF.GetValue( lERxC_8Value(Section,_objNames_cstPath_),obj.pathNew<>'');
end;

procedure CRxC_aF2N__names_Save_obj(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const obj:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
begin
    CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_newName_),obj.nameNew,'');
    CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_cstName_),obj.nameCst,obj.nameNew<>'');
    //--
    CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_newPath_),obj.pathNew,'');
    CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_cstPath_),obj.pathCst,obj.pathNew<>'');
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

function _namesROOT_Section_:string;
begin
    result:=CopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION;
    result:=lERxC_sctn8Name(result,cXmlConfig_itm_ROOT_name);
end;

procedure CRxC_aF2N__namesROOT_Load(const CNF:tLazExt_CopyRAST_CONFIG; const obj:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
var tmp:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME;
begin
    CRxC_aF2N__names_Load_obj(cnf,_namesROOT_Section_,tmp);
    obj.Copy(tmp);
    tmp.FREE;
end;

procedure CRxC_aF2N__namesROOT_Save(const CNF:tLazExt_CopyRAST_CONFIG; const obj:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
begin
    CRxC_aF2N__names_Save_obj(cnf,_namesROOT_Section_,obj);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const
  _objNames_FILEs_='FILEs';

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

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const
  _objNames_FLDRs_='FLDRs';

function _namesFLDR_Section_:string;
begin
    result:=CopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION;
    result:=lERxC_sctn8Name(result,cCopyRast_xmlCNFG_approvedFILEs2NAMEs_Names);
    result:=lERxC_sctn8Name(result,_objNames_FLDRs_);
end;

procedure CRxC_aF2N__namesFLDR_Load(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);
begin
    _names_Load_(CNF,_namesFLDR_Section_,Names);
end;

procedure CRxC_aF2N__namesFLDR_Save(const CNF:tLazExt_CopyRAST_CONFIG; const Names:TStrings);
begin
    _names_Save_(CNF,_namesFLDR_Section_,Names);
end;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

const

  _cSection_templates_='Templates';
const
 _cCRxC_aF2N__tmplItem_template_='template';
 _cCRxC_aF2N__tmplItem_exchange_='exchange';

procedure CRxC_aF2N__tmplItem__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out item:tCopyRAST_Handler_ReNAMEs_template);
begin
    CNF.DeletePath(Section);
    CNF.SetValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_template_),item.nameNew);
    CNF.SetValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_exchange_),item.pathNew);
end;

procedure CRxC_aF2N__template__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out   laer:tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER);
var itmName:string;
var cnt:integer;
    i  :integer;
    tmp:tCopyRAST_Handler_ReNAMEs_template;
begin
    CNF.DeletePath(Section);
    if laer.Count>0 then begin
        CNF.SetValue(lERxC_8Count(Section), laer.Count);
        for i:=0 to laer.Count-1 do begin
            str(i,itmName);
            itmName:=lERxC_sctn8Name(Section,_cObjNames_ITEM_+itmName);
            tmp:=laer.Items[i];
            CRxC_aF2N__tmplItem__Save(cnf,itmName,tmp);
            //CRxC_aF2N__template__Save(cnf,itmName,tmp);
            //C//nf.SetValue( lERxC_sctn8Name(itmName,_cObjNames_PATH_),list.Strings[i]);
        end;
    end;
end;

procedure CRxC_aF2N__templates_Save(const CNF:tLazExt_CopyRAST_CONFIG; const list:TStrings);
var itmName:string;
var cnt:integer;
    i  :integer;
    tmp:tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER;
begin
    CNF.DeletePath(_cSection_templates_);
    if list.Count>0 then begin
        CNF.SetValue(lERxC_8Count(_cSection_templates_), list.Count);
        for i:=0 to list.Count-1 do begin
            str(i,itmName);
            itmName:=lERxC_sctn8Name(_cSection_templates_,_cObjNames_ITEM_+itmName);
            tmp:=tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER(list.Objects[i]);
            CRxC_aF2N__template__Save(cnf,itmName,tmp);
            Cnf.SetValue( lERxC_sctn8Name(itmName,_cObjNames_PATH_),list.Strings[i]);
        end;
    end;
   {


    list.Clear;
    cnt:=CNF.GetValue( lERxC_8Count(_cSection_templates_),0);
    for i:=0 to cnt-1 do begin
        str(i,itmName);
        itmName:=lERxC_sctn8Name(_cSection_templates_,_cObjNames_ITEM_+itmName);
        CRxC_aF2N__template__Load(cnf,itmName,tmp);
        itmName:=Cnf.GetValue( lERxC_sctn8Name(itmName,_cObjNames_PATH_),'');
        list.AddObject(itmName,tmp);
    end;  }
end;

procedure CRxC_aF2N__tmplItem__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out item:tCopyRAST_Handler_ReNAMEs_template);
begin
  {  item:=tCopyRAST_Handler_ReNAMEs_template.Create;
    //---
    item.nameNew:=CNF.GetValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_template_),'');
    item.pathNew:=CNF.GetValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_exchange_),'');}
end;

procedure CRxC_aF2N__template__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out laer:tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER);
var itmName:string;
var cnt:integer;
    i  :integer;
var tmp:tCopyRAST_Handler_ReNAMEs_template;
begin
 {   laer:=tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER.Create;
    //---
    cnt:=CNF.GetValue( lERxC_8Count(Section),0);
    for i:=0 to cnt-1 do begin
        str(i,itmName);
        itmName:=lERxC_sctn8Name(section,_cObjNames_ITEM_+itmName);
        CRxC_aF2N__tmplItem__Load(cnf,itmName,tmp);
        laer.Add(tmp);
    end; }
end;

procedure CRxC_aF2N__templates_Load(const CNF:tLazExt_CopyRAST_CONFIG; const list:TStrings);
var itmName:string;
var cnt:integer;
    i  :integer;
    tmp:tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER;
begin
  {  list.Clear;
    cnt:=CNF.GetValue( lERxC_8Count(_cSection_templates_),0);
    for i:=0 to cnt-1 do begin
        str(i,itmName);
        itmName:=lERxC_sctn8Name(_cSection_templates_,_cObjNames_ITEM_+itmName);
        CRxC_aF2N__template__Load(cnf,itmName,tmp);
        itmName:=Cnf.GetValue( lERxC_sctn8Name(itmName,_cObjNames_PATH_),'');
        list.AddObject(itmName,tmp);
    end; }
end;














end.


unit lazExt_CopyRAST__xmlConfig_approvedFILEs2NAMEs;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  CopyRAST_srcTree_4Handler_CNFGs,
  in0k_CopyRAST__STAGE_03_configs,
  lazExt_CopyRAST__xmlConfig;

// НАПРЯМУЮ указанные имена

procedure CRxC_aF2N__customerROOT__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const node:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
procedure CRxC_aF2N__customerROOT__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const node:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);

//procedure CRxC_aF2N__customerNode__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out   node:tCopyRAST_srcTree_4Handler_CNFGsNode);
//procedure CRxC_aF2N__customerNode__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const node:tCopyRAST_srcTree_4Handler_CNFGsNode);

procedure CRxC_aF2N__customerFILE__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LAIR:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER);
procedure CRxC_aF2N__customerFILE__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LAIR:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER);

procedure CRxC_aF2N__customerFLDR__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LAIR:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER);
procedure CRxC_aF2N__customerFLDR__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LAIR:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER);

// шаблоны ПЕРЕИМЕНОВАНИЯ

procedure CRxC_aF2N__templateROOT__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const List:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
procedure CRxC_aF2N__templateROOT__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const List:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);

//procedure CRxC_aF2N__templateNode__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out   node:tCopyRAST_srcTree_4Handler_CNFGsNode);
//procedure CRxC_aF2N__templateNode__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const node:tCopyRAST_srcTree_4Handler_CNFGsNode);

//procedure CRxC_aF2N__templateList__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out   List:tCopyRAST_srcTree_4Handler_CNFGsNode);
//procedure CRxC_aF2N__templateList__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const List:tCopyRAST_srcTree_4Handler_CNFGsNode);

procedure CRxC_aF2N__templateLAIR__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LAIR:tCopyRAST_HandlerCNFGs_ReNAMEs_template_LAIR);
procedure CRxC_aF2N__templateLAIR__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LAIR:tCopyRAST_HandlerCNFGs_ReNAMEs_template_LAIR);

implementation

const
 _cMainSection_='approvedFILEs2NAMEs';
 _cSectionROOT_=cXmlConfig_itm_ROOT_name;


function _cSection_ROOT_(const Section:string):string;
begin
    result:=lERxC_sctn8Name(_cMainSection_,_cSectionROOT_);
end;


//const
// _cObjNames_ITEM_='item';
// _cObjNames_PATH_='Path';

//------------------------------------------------------------------------------

{function _ROOT_NewName__path_:string;
begin
    result:= lERxC_8Value(_section_,'ROOT','newName')
end;}

{function CRxC_aF2N_ROOT_NewName__GET(const CNF:tLazExt_CopyRAST_CONFIG; const oldName:string):string;
begin
    result:=CNF.GetValue( _ROOT_NewName__path_,cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName_DEF+oldName);
end;}

{procedure CRxC_aF2N_ROOT_NewName__SET(const CNF:tLazExt_CopyRAST_CONFIG; const newName:string);
begin
    CNF.SetDeleteValue(_ROOT_NewName__path_, newName,'');
end;}

//------------------------------------------------------------------------------

{function _BASE_NewPath__path_:string;
begin
    result:= lERxC_8Value(_section_,'BASE','newPath')
end;}

{function CRxC_aF2N_BASE_newName__GET(const CNF:tLazExt_CopyRAST_CONFIG; const oldPath:string):string;
begin
    result:=CNF.GetValue( _BASE_NewPath__path_,oldPath);
end;}

{procedure CRxC_aF2N_BASE_newName__SET(const CNF:tLazExt_CopyRAST_CONFIG; const newPath:string);
begin
    CNF.SetDeleteValue(_BASE_NewPath__path_, newPath,'');
end;}

//------------------------------------------------------------------------------

{function CRxC_aF2N_lazObj_NewName__GET(const CNF:tLazExt_CopyRAST_CONFIG):string;
begin
    result:=CNF.GetValue( CopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION+cXmlConfig_pathDELIM+cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName+cXmlConfig_pathDELIM+cXmlConfig_valueNAME, cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName_DEF);
end;}

{procedure CRxC_aF2N_lazObj_NewName__SET(const CNF:tLazExt_CopyRAST_CONFIG; const value:string);
begin
    CNF.SetDeleteValue( CopyRast_xmlCNFG_approvedFILEs2NAMEs_SECTION+cXmlConfig_pathDELIM+cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName+cXmlConfig_pathDELIM+cXmlConfig_valueNAME, value, cCopyRast_xmlCNFG_approvedFILEs2NAMEs_newName_DEF);
end;}

//------------------------------------------------------------------------------

const
   _objNames_cstName_='nameCustom';
   _objNames_newName_='nameStated';
   _objNames_cstPath_='pathCustom';
   _objNames_newPath_='pathStated';

{procedure CRxC_aF2N__names_Load_obj(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out obj:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
begin
    obj:=tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME.Create;
    //---
    obj.nameNew:=CNF.GetValue( lERxC_8Value(Section,_objNames_newName_),'');
    obj.nameCst:=CNF.GetValue( lERxC_8Value(Section,_objNames_cstName_),obj.nameNew<>'');
    //--
    obj.pathNew:=CNF.GetValue( lERxC_8Value(Section,_objNames_newPath_),'');
    obj.pathCst:=CNF.GetValue( lERxC_8Value(Section,_objNames_cstPath_),obj.pathNew<>'');
end;}

{procedure CRxC_aF2N__names_Save_obj(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const obj:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
begin
    CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_newName_),obj.nameNew,'');
    CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_cstName_),obj.nameCst,obj.nameNew<>'');
    //--
    CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_newPath_),obj.pathNew,'');
    CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_cstPath_),obj.pathCst,obj.pathNew<>'');
end;}

procedure CRxC_aF2N__customerNode__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out node:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    node:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.Create;
    with tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(node) do begin
        NameStated:=CNF.GetValue( lERxC_8Value(Section,_objNames_newName_),'');
        NameCustom:=CNF.GetValue( lERxC_8Value(Section,_objNames_cstName_),NameStated<>'');
        //--
        PathStated:=CNF.GetValue( lERxC_8Value(Section,_objNames_newPath_),'');
        PathCustom:=CNF.GetValue( lERxC_8Value(Section,_objNames_cstPath_),PathStated<>'');
    end;
end;

procedure CRxC_aF2N__customerNode__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const node:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    //CNF.DeletePath(Section); {todo: ДУМАТЬ, а это Надо?}
    with tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(node) do begin
        CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_newName_),NameStated,'');
        CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_cstName_),NameCustom,NameStated<>'');
        //--
        CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_newPath_),PathStated,'');
        CNF.SetDeleteValue( lERxC_8Value(Section,_objNames_cstPath_),PathCustom,PathStated<>'');
    end;
end;

//------------------------------------------------------------------------------


(*procedure _names_Load_(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const Names:TStrings);
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
*)
(*
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
*)
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure CRxC_aF2N__customerROOT__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const node:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
var tmp:tCopyRAST_srcTree_4Handler_CNFGsNode;
begin
    CRxC_aF2N__customerNode__Load(cnf,_cSection_ROOT_(Section),tmp);
    node.Copy(tmp);
    tmp.FREE;
end;


procedure CRxC_aF2N__customerROOT__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const node:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
begin
    CRxC_aF2N__customerNode__Save(cnf,_cSection_ROOT_(Section),node);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const
  _cSection_customers_='Customers';

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const
  _cSection_FILEs_='FILEs';

function _cSection_customers_FILEs_(const Section:string):string;
begin
    result:=lERxC_sctn8Name(_cMainSection_,_cSection_customers_);
    result:=lERxC_sctn8Name( result,_cSection_FILEs_);
end;

procedure CRxC_aF2N__customerFILE__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LAIR:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER);
begin
    lazExt_CopyRAST__ConfigLOAD(CNF,_cSection_customers_FILEs_(Section),LAIR,@CRxC_aF2N__customerNode__Load)
end;

procedure CRxC_aF2N__customerFILE__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LAIR:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER);
begin
    lazExt_CopyRAST__ConfigSAVE(CNF,_cSection_customers_FILEs_(Section),LAIR,@CRxC_aF2N__customerNode__Save)
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const
  _cSection_FLDRs_='FLDRs';

function _cSection_customers_FLDRs_(const Section:string):string;
begin
    result:=lERxC_sctn8Name(_cMainSection_,_cSection_customers_);
    result:=lERxC_sctn8Name( result,_cSection_FLDRs_);
end;

procedure CRxC_aF2N__customerFLDR__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LAIR:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER);
begin
    lazExt_CopyRAST__ConfigLOAD(CNF,_cSection_customers_FLDRs_(Section),LAIR,@CRxC_aF2N__customerNode__Load)
end;

procedure CRxC_aF2N__customerFLDR__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LAIR:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER);
begin
    lazExt_CopyRAST__ConfigSAVE(CNF,_cSection_customers_FLDRs_(Section),LAIR,@CRxC_aF2N__customerNode__Save)
end;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

const
 _cCRxC_aF2N__tmplItem_type_='type';
 _cCRxC_aF2N__tmplItem_type_inherited_='inherited';

 _cCRxC_aF2N__tmplItem_Enabled_  ='enabled';

 _cCRxC_aF2N__tmplItem_regExUSE_ ='regExUSE';
 _cCRxC_aF2N__tmplItem_template_ ='template';
 _cCRxC_aF2N__tmplItem_exchange_ ='exchange';

 _cCRxC_aF2N__tmplItem_Use4FILE_ ='_Use4FILE_';
 _cCRxC_aF2N__tmplItem_Use4FLDR_ ='_Use4FLDR_';
 _cCRxC_aF2N__tmplItem_use_Last_ ='_use_Last_';

procedure CRxC_aF2N__templateNode__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out node:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    if _cCRxC_aF2N__tmplItem_type_inherited_=CNF.GetValue( lERxC_sctn8Name(Section,_cCRxC_aF2N__tmplItem_type_),'') then begin
        node:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_prnt.Create;
    end
   else begin
        node:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule.Create;
        with tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(node) do begin
            Enabled :=CNF.GetValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_Enabled_),TRUE);
            //
            RegExUSE:=CNF.GetValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_regExUSE_),TRUE);
            Template:=CNF.GetValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_template_),'');
            Exchange:=CNF.GetValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_exchange_),'');
            //
            Use4FILE:=CNF.GetValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_Use4FILE_),TRUE);
            Use4FLDR:=CNF.GetValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_Use4FLDR_),false);
            //
            use_Last:=CNF.GetValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_use_Last_),false);
        end;
    end;
end;

procedure CRxC_aF2N__templateNode__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const node:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    //CNF.DeletePath(Section); {todo: ДУМАТЬ, а это Надо?}
    if not tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(node).isInherited_MARK then begin
        with tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(node) do begin
            CNF.SetDeleteValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_template_),Enabled,true);

            CNF.SetDeleteValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_regExUSE_),RegExUSE,true);
            CNF.SetDeleteValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_template_),Template,'');
            CNF.SetDeleteValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_exchange_),Exchange,'');

            CNF.SetDeleteValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_Use4FILE_),Use4FILE,true);
            CNF.SetDeleteValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_Use4FLDR_),Use4FLDR,false);

            CNF.SetDeleteValue( lERxC_8Value(Section,_cCRxC_aF2N__tmplItem_use_Last_),use_Last,false);
        end;
    end
    else begin
        CNF.SetValue(lERxC_sctn8Name(Section,_cCRxC_aF2N__tmplItem_type_),_cCRxC_aF2N__tmplItem_type_inherited_);
    end;
end;

//------------------------------------------------------------------------------

procedure CRxC_aF2N__templateList__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out List:tCopyRAST_srcTree_4Handler_CNFGsNode);
var tmp:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
begin // !!! через копирование !!! избавляемся от ДВОЙНЫХ меток РОДИТЕЛЬСКИХ
    tmp:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.Create;
    lazExt_CopyRAST__ConfigLOAD(CNF,Section,tCopyRAST_HandlerCNFGs_ReNAMEs_template_List(tmp),@CRxC_aF2N__templateNode__Load);
    List:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.Create;
    List.COPY(tmp);
    tmp.FREE;
end;

procedure CRxC_aF2N__templateList__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const List:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    lazExt_CopyRAST__ConfigSAVE(CNF,Section,tCopyRAST_HandlerCNFGs_ReNAMEs_template_List(List),@CRxC_aF2N__templateNode__Save)
end;

//------------------------------------------------------------------------------

const
  _cSection_templates_='Templates';

procedure CRxC_aF2N__templateLAIR__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LAIR:tCopyRAST_HandlerCNFGs_ReNAMEs_template_LAIR);
begin
    lazExt_CopyRAST__ConfigLOAD(CNF,lERxC_sctn8Name(_cMainSection_,_cSection_templates_),LAIR,@CRxC_aF2N__templateList__Load)
end;

procedure CRxC_aF2N__templateLAIR__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LAIR:tCopyRAST_HandlerCNFGs_ReNAMEs_template_LAIR);
begin
    lazExt_CopyRAST__ConfigSAVE(CNF,lERxC_sctn8Name(_cMainSection_,_cSection_templates_),LAIR,@CRxC_aF2N__templateList__Save)
end;

//------------------------------------------------------------------------------

procedure CRxC_aF2N__templateROOT__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const List:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
var tmp:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
begin
    tmp:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.Create;
    lazExt_CopyRAST__ConfigLOAD(CNF,lERxC_sctn8Name(_cSection_ROOT_(Section),_cSection_templates_),tmp,@CRxC_aF2N__templateNode__Load);
    List.COPY(tmp);
    tmp.FREE;
end;

procedure CRxC_aF2N__templateROOT__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const List:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
begin
    lazExt_CopyRAST__ConfigSAVE(CNF,lERxC_sctn8Name(_cSection_ROOT_(Section),_cSection_templates_),List,@CRxC_aF2N__templateNode__Save)
end;

end.


unit lazExt_CopyRAST__xmlConfig__reVision__FILEs;

{$mode objfpc}{$H+}

interface

uses
  Dialogs, sysutils,
  CopyRAST_srcTree_4Handler_CNFGs,
  in0k_CopyRAST__STAGE_02__cnfg_FILEsAdd,
  lazExt_CopyRAST__xmlConfig;


procedure CRxC_rV_FInC__LIST__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LIST:tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_List);
//procedure CRxC_aF2N__macross_LIST__Save(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LIST:tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_List);

implementation

const
 _cMainSection_='reVision';
 _cSectionROOT_=cXmlConfig_itm_ROOT_name;


function _cSection_ROOT_(const Section:string):string;
begin
    result:=lERxC_sctn8Name(_cMainSection_,_cSectionROOT_);
end;




const
 _cCRxC_rV_FInC__fileName_='fileName';

procedure CRxC_rV_FInC__NODE__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; out node:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    node:=tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node.Create;
    with tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node(node) do begin
        fileName:=CNF.GetValue( lERxC_sctn8Name(Section,_cCRxC_rV_FInC__fileName_),'');
        //ShowMessage('dfdddddddddddddddddddd  '+lERxC_sctn8Name(Section,_cCRxC_rV_FInC__fileName_));
    end;
end;


const
  _cSection_inClude_='include';

procedure CRxC_rV_FInC__LIST__Load(const CNF:tLazExt_CopyRAST_CONFIG; const Section:string; const LIST:tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_List);
var tmp:tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_List;
begin // !!! через копирование !!! избавляемся от ДВОЙНЫХ меток РОДИТЕЛЬСКИХ ???
    tmp:=tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_List.Create;
    lazExt_CopyRAST__ConfigLOAD(CNF,lERxC_sctn8Name(_cMainSection_,_cSection_inClude_),tCopyRAST_srcTree_4Handler_CNFGsLAIR(tmp),@CRxC_rV_FInC__NODE__Load);
    //ShowMessage('dfdddddddddddddddddddd  '+lERxC_sctn8Name(_cMainSection_,_cSection_inClude_)+'    '+ inttostr( tmp.Count));
    List.COPY(tmp);
    tmp.FREE;
end;

end.


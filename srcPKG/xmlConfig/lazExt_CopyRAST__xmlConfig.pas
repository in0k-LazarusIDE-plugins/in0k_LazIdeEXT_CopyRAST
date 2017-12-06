unit lazExt_CopyRAST__xmlConfig;

{$mode objfpc}{$H+}

interface

uses LazConfigStorage,

  CopyRAST_srcTree_4Handler_CNFGs,
  XMLConf,
  Classes, SysUtils;


type
  tLazExt_CopyRAST_CONFIG=TXMLConfig;



const

  cXmlConfig_pathDELIM ='/';
  cXmlConfig_valueNAME ='Value';
  cXmlConfig_countNAME ='count';
  cXmlConfig_itmCntNME='itemsCount';

  cLazExt_CopyRAST__xmlConfig_SECTION='CopyRAST';


  cXmlConfig_itm_ROOT_name='ROOT';

function lERxC_sctn8Name(const section,name:string):string;                    inline;

function lERxC_8Value(const section:string):string;                            inline;
function lERxC_8Value(const section:string; const lblVal:string):string;       inline;
function lERxC_8Value(const section:string; const lblObj,lblVal:string):string;inline;
function lERxC_8Count(const section:string):string;                            inline;

//function lERxC_8ItmCnt(const section:string):string;                            inline;



type
  fCopyRAST__ConfigNODE_SAVE=procedure(const CNFG:tLazExt_CopyRAST_CONFIG; const Section:string; const NODE:tCopyRAST_srcTree_4Handler_CNFGsNode);
  fCopyRAST__ConfigNODE_LOAD=procedure(const CNFG:tLazExt_CopyRAST_CONFIG; const Section:string; out   NODE:tCopyRAST_srcTree_4Handler_CNFGsNode);


procedure lazExt_CopyRAST__ConfigSAVE(const CNFG:tLazExt_CopyRAST_CONFIG; const Section:string; const CNFGs:tCopyRAST_srcTree_4Handler_CNFGsLAIR; const SavePRC:fCopyRAST__ConfigNODE_SAVE); overload;
procedure lazExt_CopyRAST__ConfigLOAD(const CNFG:tLazExt_CopyRAST_CONFIG; const Section:string; const CNFGs:tCopyRAST_srcTree_4Handler_CNFGsLAIR; const LoadPRC:fCopyRAST__ConfigNODE_LOAD); overload;

procedure lazExt_CopyRAST__ConfigSAVE(const CNFG:tLazExt_CopyRAST_CONFIG; const Section:string; const CNFGs:tCopyRAST_srcTree_4Handler_CNFGs; const SavePRC:fCopyRAST__ConfigNODE_SAVE);     overload;
procedure lazExt_CopyRAST__ConfigLOAD(const CNFG:tLazExt_CopyRAST_CONFIG; const Section:string; const CNFGs:tCopyRAST_srcTree_4Handler_CNFGs; const LoadPRC:fCopyRAST__ConfigNODE_LOAD);     overload;

implementation

//------------------------------------------------------------------------------

function _n2n_(const n0,n1:string):string; inline;
begin
    result:=n0+cXmlConfig_pathDELIM+n1;
end;

function lERxC_sctn8Name(const section,name:string):string;
begin
    result:=_n2n_(section,name);
end;

//------------------------------------------------------------------------------

function lERxC_8Value(const section:string):string;
begin
    result:=_n2n_(section,cXmlConfig_valueNAME);
end;

function lERxC_8Value(const section:string; const lblVal:string):string;
begin
    result:=lERxC_8Value(_n2n_(section,lblVal));
end;

function lERxC_8Value(const section:string; const lblObj,lblVal:string):string;
begin
    result:=lERxC_8Value(_n2n_(section,lblObj));
end;

//------------------------------------------------------------------------------

function lERxC_8Count(const section:string):string;
begin
    result:=_n2n_(section,cXmlConfig_countNAME);
end;

{function lERxC_8ItmCnt(const section:string):string;
begin
    result:=_n2n_(section,cXmlConfig_itmCntNME);
end;}


//------------------------------------------------------------------------------

const
 _cObjNames_ITEM_='item';

procedure lazExt_CopyRAST__ConfigSAVE(const CNFG:tLazExt_CopyRAST_CONFIG; const Section:string; const CNFGs:tCopyRAST_srcTree_4Handler_CNFGsLAIR; const SavePRC:fCopyRAST__ConfigNODE_SAVE); overload;
var i:integer;
var itmName:string;
    itmNode:tCopyRAST_srcTree_4Handler_CNFGsNode;
begin
    CNFG.DeletePath(Section);
    if CNFGs.Count>0 then begin
        CNFG.SetValue(lERxC_8Count(Section), CNFGs.Count);
        for i:=0 to CNFGs.Count-1 do begin
            // узнаем данные
            str(i,itmName);
            itmName:=lERxC_sctn8Name(Section,_cObjNames_ITEM_+itmName);
            itmNode:=CNFGs.Items[i];
            // сохраняем
            SavePRC(CNFG, itmName,itmNode);
        end;
    end;
end;

procedure lazExt_CopyRAST__ConfigLOAD(const CNFG:tLazExt_CopyRAST_CONFIG; const Section:string; const CNFGs:tCopyRAST_srcTree_4Handler_CNFGsLAIR; const LoadPRC:fCopyRAST__ConfigNODE_LOAD); overload;
var cnt:integer;
    i  :integer;
var itmName:string;
    itmNode:tCopyRAST_srcTree_4Handler_CNFGsNode;
begin
    cnt:=CNFG.GetValue(lERxC_8Count(Section),0);
    for i:=0 to cnt-1 do begin
        // узнаем данные
        str(i,itmName);
        itmName:=lERxC_sctn8Name(Section,_cObjNames_ITEM_+itmName);
        // грузим
        LoadPRC(CNFG, itmName,itmNode);
        // добавляем
        CNFGs.Add(itmNode);
    end;
end;


//------------------------------------------------------------------------------

const
 _cObjNames_PATH_='Path';


procedure lazExt_CopyRAST__ConfigSAVE(const CNFG:tLazExt_CopyRAST_CONFIG; const Section:string; const CNFGs:tCopyRAST_srcTree_4Handler_CNFGs; const SavePRC:fCopyRAST__ConfigNODE_SAVE);
var i:integer;
var itmName:string;
    itmPath:string;
    itmNode:tCopyRAST_srcTree_4Handler_CNFGsNode;
begin
    CNFG.DeletePath(Section);
    if CNFGs.CNFGS_Count>0 then begin
        CNFG.SetValue(lERxC_8Count(Section), CNFGs.CNFGS_Count);
        for i:=0 to CNFGs.CNFGS_Count-1 do begin
            // узнаем данные
            str(i,itmName);
            itmName:=lERxC_sctn8Name(Section,_cObjNames_ITEM_+itmName);
            CNFGs.CNFGS_Item(i, itmPath,itmNode);
            // сохраняем
            SavePRC(CNFG, itmName,itmNode);
            // пишем ПУТЬ
            CNFG.SetValue( lERxC_sctn8Name(itmName,_cObjNames_PATH_),itmPath);
        end;
    end;
end;

procedure lazExt_CopyRAST__ConfigLOAD(const CNFG:tLazExt_CopyRAST_CONFIG; const Section:string; const CNFGs:tCopyRAST_srcTree_4Handler_CNFGs; const LoadPRC:fCopyRAST__ConfigNODE_LOAD);
var cnt:integer;
    i  :integer;
var itmName:string;
    itmPath:string;
    itmNode:tCopyRAST_srcTree_4Handler_CNFGsNode;
begin
    cnt:=CNFG.GetValue(lERxC_8Count(Section),0);
    for i:=0 to cnt-1 do begin
        // узнаем данные
        str(i,itmName);
        itmName:=lERxC_sctn8Name(Section,_cObjNames_ITEM_+itmName);
        // грузим
        LoadPRC(CNFG, itmName,itmNode);
        itmPath:=CNFG.GetValue(lERxC_sctn8Name(itmName,_cObjNames_PATH_),'');
        // добавляем
        CNFGs.CNFGS_Add(itmPath,itmNode);
    end;
end;

end.


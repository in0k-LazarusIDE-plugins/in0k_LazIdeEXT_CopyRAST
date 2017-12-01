unit lazExt_CopyRAST__xmlConfig;

{$mode objfpc}{$H+}

interface

uses LazConfigStorage,
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

end.


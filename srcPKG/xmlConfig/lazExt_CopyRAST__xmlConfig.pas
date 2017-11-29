unit lazExt_CopyRAST__xmlConfig;

{$mode objfpc}{$H+}

interface

uses LazConfigStorage,
  XMLConf,
  Classes, SysUtils;


type
  tLazExt_CopyRAST_CONFIG=TXMLConfig;



const

  cXmlConfig_pathDELIM='/';
  cXmlConfig_valueNAME='Value';

  cLazExt_CopyRAST__xmlConfig_SECTION='CopyRAST';


function lERxC_addValue (const s:string):string;
function lERxC_addObjVal(const s:string; const lblObj,lblVal:string):string;

implementation

function lERxC_addValue(const s:string):string;
begin
    result:=s+cXmlConfig_pathDELIM+cXmlConfig_valueNAME;
end;

function lERxC_addObjVal(const s:string; const lblObj,lblVal:string):string;
begin
    result:=lERxC_addValue(s+cXmlConfig_pathDELIM+lblObj+cXmlConfig_pathDELIM+lblVal);
end;

end.


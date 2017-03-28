unit in0k_srcTree_getMainFILE;

{$mode objfpc}{$H+}

interface

uses
  srcTree_item_CORE,
  srcTree_item_coreMAIN,
  srcTree_item_coreROOT,
  srcTree_item_baseDIR,
  in0k_srcTree_getBaseDIR,
  in0k_srcTree_fndMainFILE,
  Classes, SysUtils;

type // создание ЭКЗеМпЛЯРа "Базовой директории"
  fSrcTree_getMainFILE_crtMainFILE=function(const MainFILE_Name:string):tSrcTree_MAIN;
  mSrcTree_getMainFILE_crtMainFILE=function(const MainFILE_Name:string):tSrcTree_MAIN of object;

// -----

function SrcTree_getMainFILE(const item:tSrcTree_ROOT; const crtFnc:fSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;
function SrcTree_getMainFILE(const item:tSrcTree_ROOT; const crtFnc:mSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;


implementation

function SrcTree_getMainFILE(const item:tSrcTree_ROOT; const crtFnc:fSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;
var tmp:tSrcTree_BASE;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    {$ifOpt D+}Assert(Assigned(crtFnc));{$endIf}
    result:=SrcTree_fndMainFILE(item);
    if not Assigned(result) then begin //< ничего страшного, его еще просто НЕ добавляли
        tmp:=SrcTree_getBaseDIR(item,crtBaseDIR);
        result:=crtFnc('');
        SrcTree_insert_ChldFrst(tmp,result);
    end;
end;

function SrcTree_getMainFILE(const item:tSrcTree_ROOT; const crtFnc:mSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;

  function _crtFnc_(const MainFILE_Name:string):tSrcTree_MAIN;// is nested;
  begin result:=crtFnc(MainFILE_Name); end;

  function _crtBaseDIR_(const BaseDIR_PATH:string):tSrcTree_BASE;// is nested;
  begin result:=crtBaseDIR(BaseDIR_PATH); end;

begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    {$ifOpt D+}Assert(Assigned(crtFnc));{$endIf}
    result:=SrcTree_getMainFILE(item,fSrcTree_getMainFILE_crtMainFILE(@_crtFnc_),fSrcTree_getBaseDIR_crtBaseDIR(@_crtBaseDIR_));
end;


end.


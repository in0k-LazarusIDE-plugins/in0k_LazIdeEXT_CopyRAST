unit in0k_srcTree_getBaseDIR;

{$mode objfpc}{$H+}

interface

uses
    srcTree_item_CORE,
    srcTree_item_coreROOT,
    srcTree_item_baseDIR,
    in0k_srcTree_fndBaseDIR,
    LazFileUtils,

  Classes, SysUtils;

type // создание ЭКЗеМпЛЯРа "Базовой директории"
  fSrcTree_getBaseDIR_crtBaseDIR=function(const BaseDIR_PATH:string):tSrcTree_BASE;// is nested;
  aSrcTree_getBaseDIR_crtBaseDIR=function(const BaseDIR_PATH:string):tSrcTree_BASE of object;

// -----

function  SrcTree_getBaseDIR(const item:tSrcTree_ROOT; const crtFnc:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
function  SrcTree_getBaseDIR(const item:tSrcTree_ROOT; const crtFnc:aSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
function  SrcTree_getBaseDIR(const item:tSrcTree_ROOT):tSrcTree_BASE;

implementation

// просто создаем папку с путем.
// при кастомизации тут момжно выбирать классы
function _getBaseDIR__crt_BaseDIR_(const BaseDIR_PATH:string):tSrcTree_BASE;
begin
    result:=tSrcTree_BASE.Create(ChompPathDelim(BaseDIR_PATH));
end;

function SrcTree_getBaseDIR(const item:tSrcTree_ROOT; const crtFnc:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    {$ifOpt D+}Assert(Assigned(crtFnc));{$endIf}
    result:=SrcTree_fndBaseDIR(item);
    if not Assigned(result) then begin //< ничего страшного, его еще просто НЕ добавляли
        result:=crtFnc('');//tSrcTree_BASE.Create('');
        SrcTree_insert_ChldFrst(item,result);
    end;
end;

function SrcTree_getBaseDIR(const item:tSrcTree_ROOT; const crtFnc:aSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    {$ifOpt D+}Assert(Assigned(crtFnc));{$endIf}
    result:=SrcTree_fndBaseDIR(item);
    if not Assigned(result) then begin //< ничего страшного, его еще просто НЕ добавляли
        result:=crtFnc('');//tSrcTree_BASE.Create('');
        SrcTree_insert_ChldFrst(item,result);
    end;
end;



function SrcTree_getBaseDIR(const item:tSrcTree_ROOT):tSrcTree_BASE;
begin
    result:=SrcTree_getBaseDIR(item,@_getBaseDIR__crt_BaseDIR_);
end;

end.


unit in0k_srcTree_setMainFILE;

{$mode objfpc}{$H+}

interface

uses
  srcTree_item_CORE,
  srcTree_item_coreROOT,
  srcTree_item_coreMAIN,
    in0k_srcTree_getBaseDIR,
    in0k_srcTree_getMainFILE;

function SrcTree_setMainFILE(const item:tSrcTree_ROOT; const MainFileNAME:string; const crtFnc:aSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:aSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;

implementation

function SrcTree_setMainFILE(const item:tSrcTree_ROOT; const MainFileNAME:string; const crtFnc:aSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:aSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    result:=SrcTree_getMainFILE(item,crtFnc,crtBaseDIR);
    SrcTree_re_set_itemTEXT(result,MainFileNAME);
end;

end.


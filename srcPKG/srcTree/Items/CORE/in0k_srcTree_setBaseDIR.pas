unit in0k_srcTree_setBaseDIR;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_item_CORE,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_FNK_getBaseDIR,

  Classes, SysUtils;


function SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string; const crtFnc:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
function SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string; const crtFnc:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;


procedure SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string; const crtFnc:fSrcTree_getBaseDIR_crtBaseDIR);
procedure SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string);

implementation

function SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string; const crtFnc:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    result:=SrcTree_getBaseDIR(item,crtFnc);
    SrcTree_re_set_itemTEXT(result,baseDir);
end;

function SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string; const crtFnc:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    result:=SrcTree_getBaseDIR(item,crtFnc);
    SrcTree_re_set_itemTEXT(result,baseDir);
end;


procedure SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string; const crtFnc:fSrcTree_getBaseDIR_crtBaseDIR);
begin
    SrcTree_setBaseDIR(item,baseDir,crtFnc);
end;

procedure SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string);
var tmp:tSrcTree_BASE;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    tmp:=SrcTree_getBaseDIR(item);
    SrcTree_re_set_itemTEXT(tmp,baseDir);
end;

end.


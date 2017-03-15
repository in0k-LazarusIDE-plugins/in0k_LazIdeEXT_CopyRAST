unit in0k_srcTree_fndMainFILE;

{$mode objfpc}{$H+}

interface

uses
  srcTree_item_CORE,
  srcTree_item_coreROOT,

in0k_srcTree_fndBaseDIR,
srcTree_item_coreMAIN,
  Classes, SysUtils;

function SrcTree_fndMainFILE(const item:tSrcTree_ROOT):tSrcTree_MAIN;

implementation

function SrcTree_fndMainFILE(const item:tSrcTree_ROOT):tSrcTree_MAIN;
var tmp:tSrcTree_item;
begin //< оно ДОЛЖНО быть ребенком в Главной Директории
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    result:=nil;
    //---
    tmp:=SrcTree_fndBaseDIR(item);
    if Assigned(tmp) then begin
        tmp:=tmp.ItemCHLD;
        while Assigned(tmp) do begin
            if tmp is tSrcTree_MAIN then begin
                result:=tSrcTree_MAIN(tmp);
                break;
            end;
            tmp:=tmp.ItemNEXT;
        end;
    end;
end;

end.


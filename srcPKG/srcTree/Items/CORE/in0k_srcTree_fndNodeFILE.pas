unit in0k_srcTree_fndNodeFILE;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, LazFileUtils,
  in0k_lazIdeSRC_srcTree_item_CORE,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  in0k_srcTree_fndRelPATH;


function SrcTree_fndNodeFILE(const item:tSrcTree_ROOT; const fileName:string):tSrcTree_fsFILE;

implementation

function SrcTree_fndNodeFILE(const item:tSrcTree_ROOT; const fileName:string):tSrcTree_fsFILE;
begin
    // ищем папку
    result:=tSrcTree_fsFILE(tSrcTree_item(SrcTree_fndRelPATH(item,extractFileDir(fileName))));
    // ищем сам файл внутри него
    if Assigned(result) then begin
        result:=tSrcTree_fsFILE(tSrcTree_item(result).ItemCHLD);
        while Assigned(result) do begin
            if tSrcTree_item(result) is tSrcTree_fsFILE then begin //< мы же тока файлы исчем
                if 0=CompareFilenames(result.src_Name, ExtractFileName(fileName)) then begin
                    BREAK;
                end;
            end;
            //-->
            result:=tSrcTree_fsFILE(tSrcTree_item(result).ItemCHLD);
        end;
    end;
end;

end.


unit in0k_srcTree_fndNodeFILE;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, LazFileUtils,
  srcTree_item_CORE,
  srcTree_item_fsFolder,
  srcTree_item_fsFile,
  srcTree_item_coreROOT,
  in0k_srcTree_fndRelPATH;


function SrcTree_fndNodeFILE(const item:tSrcTree_ROOT; const fileName:string):tSrcTree_item_fsFile;

implementation

function SrcTree_fndNodeFILE(const item:tSrcTree_ROOT; const fileName:string):tSrcTree_item_fsFile;
begin
    // ищем папку
    result:=tSrcTree_item_fsFile(tSrcTree_item(SrcTree_fndRelPATH(item,extractFileDir(fileName))));
    // ищем сам файл внутри него
    if Assigned(result) then begin
        result:=tSrcTree_item_fsFile(tSrcTree_item(result).ItemCHLD);
        while Assigned(result) do begin
            if tSrcTree_item(result) is tSrcTree_item_fsFile then begin //< мы же тока файлы исчем
                if 0=CompareFilenames(result.src_Name, ExtractFileName(fileName)) then begin
                    BREAK;
                end;
            end;
            //-->
            result:=tSrcTree_item_fsFile(tSrcTree_item(result).ItemCHLD);
        end;
    end;
end;

end.


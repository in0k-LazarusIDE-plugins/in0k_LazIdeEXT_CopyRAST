unit in0k_srcTree_addSrchPATH;

{$mode objfpc}{$H+}

interface

uses
  srcTree_item_coreROOT,
  srcTree_item_fsFolder,
  in0k_srcTree_getRelPATH,
  lazExt_CopyRAST_from_IDEProcs;


function  srcTree_builder_add_SearchPATH_DirNAME(const ROOT:tSrcTree_ROOT; const DirNAME:string; const PathKIND:eSrcTree_SrchPath):tSrcTree_item_fsNodeFLDR;
procedure srcTree_builder_add_SearchPATH_DirLIST(const ROOT:tSrcTree_ROOT; const DirLIST:string; const PathKIND:eSrcTree_SrchPath);

implementation

// добавить ПУТь поиска
// @prm ROOT     куда именно добавляем
// @prm DirNAME  название директории (путь в файловой системе)
// @prm PathKIND тип "пути поиска"
function srcTree_builder_add_SearchPATH_DirNAME(const ROOT:tSrcTree_ROOT; const DirNAME:string; const PathKIND:eSrcTree_SrchPath):tSrcTree_item_fsNodeFLDR;
begin {todo: мож проверки добавить}
    result:=SrcTree_getRelPATH(ROOT,DirNAME);
    {$ifDef _debug_}DEBUG('srcTree_builder_add_SearchPATH_DirNAME',Assigned2OK(result)+' PathKIND="'+SrcTree_SrchPathKIND_2_Text(PathKIND)+'"'+' DirNAME="'+DirNAME+'"');{$endIf}
    if Assigned(result) then begin
        //--- добавим найденному ТИП пути
        SrcTree_item_fsFolder__addSearhPATH(result,PathKIND);
    end;
end;

// добавить СПИСОК ПУТЕЙ поиска
// @prm ROOT     куда именно добавляем
// @prm DirLIST  список директорий с разделителем ";"
// @prm PathKIND тип "пути поиска"
procedure srcTree_builder_add_SearchPATH_DirLIST(const ROOT:tSrcTree_ROOT; const DirLIST:string; const PathKIND:eSrcTree_SrchPath);
var StartPos:Integer;
    singlDir:string;
begin
    {$ifDef _debug_}DEBUG('srcTree_builder_add_SearchPATH_DirLIST','PathKIND="'+SrcTree_SrchPathKIND_2_Text(PathKIND)+'"'+' DirLIST="'+DirLIST+'"');{$endIf}
    StartPos:=1;
    singlDir:=GetNextDirectoryInSearchPath(DirLIST,StartPos);
    while singlDir<>'' do begin
        srcTree_builder_add_SearchPATH_DirNAME(ROOT,singlDir,PathKIND);
        //-->
        singlDir:=GetNextDirectoryInSearchPath(DirLIST,StartPos);
    end;
end;

end.


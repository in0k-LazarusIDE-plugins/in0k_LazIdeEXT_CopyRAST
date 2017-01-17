unit srcTree_builder_CORE;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
  srcTree_item_CORE,
  srcTree_item_coreROOT,
  lazExt_CopyRAST_from_IDEProcs,
  srcTree_item_coreFileSystem,
  srcTree_item_coreMAIN,
  srcTree_item_fsFolder;



procedure srcTree_builder_add_MainFILE          (const ROOT:tSrcTree_ROOT; const MAIN:tSrcTree_MAIN);


function  srcTree_builder_add_SearchPATH_DirNAME(const ROOT:tSrcTree_ROOT; const DirNAME:string; const PathKIND:eSrcTree_SrchPath):tSrcTree_item_fsNodeFLDR;
procedure srcTree_builder_add_SearchPATH_DirLIST(const ROOT:tSrcTree_ROOT; const DirLIST:string; const PathKIND:eSrcTree_SrchPath);

procedure srcTree_builder_add_FileNode          (const ROOT:tSrcTree_ROOT; const DirNode:tSrcTree_item_fsNodeFLDR; const FileNode:_tSrcTree_item_fsNodeFILE_);


implementation

{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if defined(in0k_lazExt_CopyRAST_wndCORE___DebugLOG) AND declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется
    //                       моя "система имен и папок"
    {$define _debug_}     //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debug_}
{$endIf}
{%endregion}

// добавить ПУТь поиска
// @prm ROOT     куда именно добавляем
// @prm DirNAME  название директории (путь в файловой системе)
// @prm PathKIND тип "пути поиска"
function srcTree_builder_add_SearchPATH_DirNAME(const ROOT:tSrcTree_ROOT; const DirNAME:string; const PathKIND:eSrcTree_SrchPath):tSrcTree_item_fsNodeFLDR;
begin {todo: мож проверки добавить}
    {$ifdef _debug_}DEBUG('add_SrchPTH','{'{+eCopyRAST_node_SrchPath__2__text(PathKIND)}+'}'+DirNAME);{$endIf} {todo: детализировать лог указанием ТИПА PathKIND}
    result:=SrcTreeROOT_get_relPATH(ROOT,DirNAME);
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
    StartPos:=1;
    singlDir:=GetNextDirectoryInSearchPath(DirLIST,StartPos);
    while singlDir<>'' do begin
        srcTree_builder_add_SearchPATH_DirNAME(ROOT,singlDir,PathKIND);
        //-->
        singlDir:=GetNextDirectoryInSearchPath(DirLIST,StartPos);
    end;
end;


procedure srcTree_builder_add_MainFILE(const ROOT:tSrcTree_ROOT; const MAIN:tSrcTree_MAIN);
begin
    SrcTreeROOT_add_Main(ROOT,MAIN);
end;

procedure srcTree_builder_add_FileNode(const ROOT:tSrcTree_ROOT; const DirNode:tSrcTree_item_fsNodeFLDR; const FileNode:_tSrcTree_item_fsNodeFILE_);
begin
    SrcTreeROOT_add_File(ROOT,DirNode,FileNode);
end;

end.


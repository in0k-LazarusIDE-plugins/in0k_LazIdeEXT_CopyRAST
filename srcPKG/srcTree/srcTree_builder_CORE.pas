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
  srcTree_item_fsFolder;


procedure srcTree_builder_add_SearchPATH(const ROOT:tSrcTree_ROOT; const DirPATH:string; const SrchPath:eSrcTree_SrchPath);

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


// добавить ПУТИ поиска
procedure srcTree_builder_add_SearchPATH(const ROOT:tSrcTree_ROOT; const DirPATH:string; const SrchPath:eSrcTree_SrchPath);
var StartPos:Integer;
    singlDir:string;
    NodeFLDR:tSrcTree_item_fsNodeFLDR;
begin
    StartPos:=1;
    singlDir:=GetNextDirectoryInSearchPath(DirPATH,StartPos);
    while singlDir<>'' do begin
        {$ifdef _debug_}DEBUG('add_SrchPTH','{'{+eCopyRAST_node_SrchPath__2__text(SrchPath)}+'}'+singlDir);{$endIf}
        {todo: чет наверно как-то потестить надо}
        NodeFLDR:=SrcTreeROOT_get_relPATH(ROOT,singlDir);
        if Assigned(NodeFLDR) then begin
            //--- добавим найденному ТИП пути
            SrcTree_item_fsFolder__addSearhPATH(NodeFLDR,SrchPath);
        end;
        //-->
        singlDir:=GetNextDirectoryInSearchPath(DirPATH,StartPos);
    end;
end;

end.


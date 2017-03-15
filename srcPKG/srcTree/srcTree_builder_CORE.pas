unit srcTree_builder_CORE;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
        in0k_lazIdeSRC_DEBUG,
        sysutils,
     {$endIf}
  srcTree_item_CORE,
  srcTree_item_coreROOT,
  lazExt_CopyRAST_from_IDEProcs,
  srcTree_item_coreFileSystem,
  srcTree_item_coreMAIN,
  srcTree_item_fsFolder,
  srcTree_item_baseDIR,
  in0k_srcTree_fndBaseDIR,
  in0k_srcTree_fndRelPATH,
        in0k_srcTree_fndMainFILE,
  in0k_srcTree_getRelPATH;


type

 tSrcTree_Builder_CORE=class
  protected
    function new_ROOT(const name:string):tSrcTree_ROOT; virtual;
    function new_Base(const name:string):tSrcTree_BASE; virtual;
    function new_Main(const name:string):tSrcTree_MAIN; virtual;
  protected
    function Set_ROOT(const MainOBJ:pointer                          ):tSrcTree_ROOT; virtual;
    function Set_Base(const MainOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_BASE; virtual;
    function Set_Main(const MainOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_MAIN; virtual;


  protected

    function Crt_fsNodeFLDR(const folderName:string):tSrcTree_item_fsNodeFLDR;
  public
    function MAKE_SourceTREE(const MainOBJ:pointer):tSrcTree_ROOT;
  public
    //constructor Create(const MainOBJ:pointer);
  end;

type
 fCrt_Node_ROOT =function(const OBJ:pointer; const ROOT_Name:string):tSrcTree_ROOT;
 fCrt_fsNodeFLDR=function(const OBJ:pointer; const folderName:string):tSrcTree_item_fsNodeFLDR;

 rSrcTree_builder_nodeCreator=record
    OBJ:pointer;
    Crt_node_Root:fCrt_Node_ROOT;
    Crt_fsNodeFLDR:fCrt_fsNodeFLDR;
  end;
 pSrcTree_builder_nodeCreator=^rSrcTree_builder_nodeCreator;



function srcTree_builder__CRT__NodeROOT(const nodeCreator:pSrcTree_builder_nodeCreator; const ROOT_Name:string):tSrcTree_ROOT;




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

{constructor tSrcTree_Builder_CORE.Create(const MainOBJ:pointer);
begin
  // _mainOBJ_:=MainOBJ;
end;}

function tSrcTree_Builder_CORE.new_ROOT(const name:string):tSrcTree_ROOT;
begin // чисто для примера! переОПРЕдЕЛИТЬ в наследниках!
    result:=tSrcTree_ROOT(name);//NIL;//tSrcTree_ROOT.Create(rootName);
end;

function tSrcTree_Builder_CORE.new_Base(const name:string):tSrcTree_BASE;
begin // чисто для примера! переОПРЕдЕЛИТЬ в наследниках!
    result:=tSrcTree_BASE(name);//nil;
end;

function tSrcTree_Builder_CORE.new_Main(const name:string):tSrcTree_MAIN;
begin // чисто для примера! переОПРЕдЕЛИТЬ в наследниках!
    result:=tSrcTree_MAIN(name);//nil;
end;


{function tSrcTree_Builder_CORE.new_Base(const BaseDIR_PATH:string):tSrcTree_BASE;
begin
    result:=tSrcTree_BASE.Create(BaseDIR_PATH);
end;}

function tSrcTree_Builder_CORE.Crt_fsNodeFLDR(const folderName:string):tSrcTree_item_fsNodeFLDR;
begin
    result:=tSrcTree_item_fsNodeFLDR.Create(folderName);
end;

{function tSrcTree_Builder_CORE._make_SourceTREE_root_(const MainOBJ:pointer):tSrcTree_ROOT;
begin
    result:=Crt_RootNODE('');
end;}

function tSrcTree_Builder_CORE.Set_ROOT(const MainOBJ:pointer):tSrcTree_ROOT;
begin
    result:=nil;
end;

function tSrcTree_Builder_CORE.Set_Base(const MainOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_BASE;
begin
    result:=nil;
end;

function tSrcTree_Builder_CORE.Set_Main(const MainOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_MAIN;
begin
    result:=nil;
end;

function tSrcTree_Builder_CORE.MAKE_SourceTREE(const MainOBJ:pointer):tSrcTree_ROOT;
begin
    //--------------
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','START at '+DateTimeToStr(NOW)+' for MainOBJ'+addr2txt(MainOBJ));{$endIf}
    //--------------

    //--- создаем файл ROOT
    result:=Set_ROOT(MainOBJ);
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','create Root'+'('+result.ClassName+')'+':'+result.ItemNAME);{$endIf}

    //--- пробиваем БАЗОВЫЙ путь
    Set_Base(MainOBJ,result);
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','set BaseDIR'+'('+SrcTree_fndBaseDIR(result).ClassName+')'+':'+'"'+SrcTree_fndBaseDIR(result).src_PATH+'"');{$endIf}
    //SrcTreeROOT_set_BaseDIR(result,Package.DirectoryExpanded);

    //--- пробиваем ГЛАВНЫЙ файл
    Set_Main(MainOBJ,result);
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','set MainFILE'+'('+SrcTree_fndMainFILE(result).ClassName+')'+':'+'"'+SrcTree_fndMainFILE(result).ItemNAME+'"');{$endIf}

    //   SrcTree_fndBaseDIR(result).src_PATH;

    //{$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','START at '+DateTimeToStr(NOW));{$endIf}
    //--------------
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','END at '+DateTimeToStr(NOW)+' for MainOBJ'+addr2txt(MainOBJ));{$endIf}
    //--------------
end;
















function srcTree_builder__CRT__NodeROOT(const nodeCreator:pSrcTree_builder_nodeCreator; const ROOT_Name:string):tSrcTree_ROOT;
begin
    {$IfOpt D+}Assert(Assigned(nodeCreator),'nodeCreator NOT define');{$endIf}
    {$IfOpt D+}Assert(Assigned(nodeCreator^.Crt_node_Root),'nodeCreator^.Crt_node_Root NOT define');{$endIf}
    result:=nodeCreator^.Crt_node_Root(nodeCreator^.OBJ,ROOT_Name);
    {$ifDef _DEBUG_}DEBUG('srcTree_builder__CORE','create Root '+result.ClassName+':'+result.ItemNAME);{$endIf}
end;



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


procedure srcTree_builder_add_MainFILE(const ROOT:tSrcTree_ROOT; const MAIN:tSrcTree_MAIN);
begin
    {$ifDef _debug_}DEBUG('srcTree_builder_add_MainFILE','MAIN="'+MAIN.ItemTEXT+'"');{$endIf}
    SrcTreeROOT_add_Main(ROOT,MAIN);
end;

procedure srcTree_builder_add_FileNode(const ROOT:tSrcTree_ROOT; const DirNode:tSrcTree_item_fsNodeFLDR; const FileNode:_tSrcTree_item_fsNodeFILE_);
begin
    SrcTreeROOT_add_File(ROOT,DirNode,FileNode);
end;

end.


unit srcTree_item_coreROOT;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

uses //{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}

     FileUtil, LazFileUtils, sysutils,
     //srcTree_fnd_relPATH
     srcTree_item_CORE,
     srcTree_item_coreFileSystem,
     srcTree_item_coreMAIN,
     srcTree_item_baseDIR,
     srcTree_item_fsFolder//,
     {in0k_srcTree_getBaseDIR};

type

 tSrcTree_ROOT=class(tSrcTree_item)

  end;


//function  SrcTreeROOT_fnd_BaseDIR(const item:tSrcTree_ROOT):tCopyRAST_item_BaseDIR;
//function  SrcTreeROOT_get_BaseDIR(const item:tSrcTree_ROOT):tCopyRAST_item_BaseDIR;
//procedure SrcTreeROOT_set_BaseDIR(const item:tSrcTree_ROOT; const baseDir:string);

//function  SrcTreeROOT_fnd_relPATH(const item:tSrcTree_ROOT; const folder:string; out lstDir:tSrcTree_item_fsNodeDIR):tSrcTree_item_fsNodeDIR;


procedure SrcTreeROOT_add_Main   (const item:tSrcTree_ROOT; const MainNode:tSrcTree_MAIN);
procedure SrcTreeROOT_add_File   (const item:tSrcTree_ROOT; const fldrNode:_tSrcTree_item_fsNodeFLDR_; fileNode:_tSrcTree_item_fsNodeFILE_);

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




//------------------------------------------------------------------------------



//------------------------------------------------------------------------------




//==============================================================================

procedure SrcTreeROOT_add_Main(const item:tSrcTree_ROOT; const MainNode:tSrcTree_MAIN);
begin
  //  SrcTree_insert_ChldFrst(SrcTreeROOT_get_BaseDIR(item),MainNode);
end;

procedure SrcTreeROOT_add_File(const item:tSrcTree_ROOT; const fldrNode:_tSrcTree_item_fsNodeFLDR_; fileNode:_tSrcTree_item_fsNodeFILE_);
begin
  //  SrcTree_insert_ChldLast(fldrNode,fileNode);
end;

end.


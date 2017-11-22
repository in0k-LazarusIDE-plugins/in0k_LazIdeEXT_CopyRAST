unit in0k_lazIdeSRC_CopyRAST_srcTree;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  in0k_lazIdeSRC_CopyRAST_srcTree_Nodes,

  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_fsFile,

  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,

  //in0k_lazIdeSRC_srcTree_FNK_FILE_FND,
  //in0k_lazIdeSRC_srcTree_FNK_PATH_FND,
  in0k_lazIdeSRC_srcTree_FNK_rootFILE_FND,


  in0k_lazIdeSRC_srcTree_4Package,
  srcTree_handler_CORE,

  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_CORE,
  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4INCs,
  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4USEs,


  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_usesFile,
  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_files4INC;


type

 tCopyRastSrcTree_Builder4Package=class(tSrcTree_Builder_4Package)
  protected
    function new_ROOT(const name:string):tSrcTree_ROOT;   override;
    function new_Base(const path:string):tSrcTree_BASE;   override;
    function new_Main(const name:string):tSrcTree_MAIN;   override;
    function new_FLDR(const path:string):tSrcTree_fsFLDR; override;
    function new_FILE(const path:string):tSrcTree_fsFILE; override;
  end;

type

 tCopyRastSrcTree_f8a=class(tSrcTree_itmHandler4Build__f8a_CORE)
  protected
    //function _prc__fileName_Need_ADD_(const srcName:string):boolean; override;
  public
    constructor Create(const Owner:tSrcTree_prcHandler; const Parent:tSrcTree_itmHandler); override;
  end;

 tCopyRastSrcTree_P4Build=class(tSrcTree_prcHandler)
  protected
    procedure _EXECUTE_; override;

  end;

// Processing
// Handler
// prcHandler
// prcBuilder

implementation

function tCopyRastSrcTree_Builder4Package.new_ROOT(const name:string):tSrcTree_ROOT;
begin
    result:=tCopyRastNODE_Root4Package.Create(name);
end;

function tCopyRastSrcTree_Builder4Package.new_Base(const path:string):tSrcTree_BASE;
begin
    result:=tCopyRastNODE_BASE.Create(path);
end;

function tCopyRastSrcTree_Builder4Package.new_Main(const name:string):tSrcTree_MAIN;
begin
    result:=tCopyRastNODE_Main4Package.Create(name);
end;

function tCopyRastSrcTree_Builder4Package.new_FLDR(const path:string):tSrcTree_fsFLDR;
begin
    result:=tCopyRastNODE_FLDR.Create(path);
end;

function tCopyRastSrcTree_Builder4Package.new_FILE(const path:string):tSrcTree_fsFILE;
begin
    result:=tCopyRastNODE_FILE.Create(path);
end;

//==============================================================================









constructor tCopyRastSrcTree_f8a.Create(const Owner:tSrcTree_prcHandler; const Parent:tSrcTree_itmHandler);
begin
   inherited Create(Owner,Parent);
   //
   Handler_ADD(tSrcTree_itmHandler4Build__f8a_Item_4USEs);
   Handler_ADD(tSrcTree_itmHandler4Build__f8a_Item_4INCs);
end;

(*function tCopyRastSrcTree_f8a._prc__fileName_Need_ADD_(const srcName:string):boolean;
var fsFLDR:_tSrcTree_item_fsNodeFLDR_;
begin
    result:=false;
    //----
    fsFLDR:=SrcTree_fndPath(SrcTree_fndRootFILE(prcssdITEM), srcTree_fsFnk_ExtractFileDir(srcName));
    if Assigned(fsFLDR) then begin
        {todo: тут ДОЛЖНЫ быть какие-то ОГРАНИЧЕНИЯ на fsFLDR}
        result:=TRUE;
    end;
end;*)


procedure tCopyRastSrcTree_P4Build._EXECUTE_;
begin
    //  _EXECUTE_4ROOT_(tSrcTree_itmHandler4Build__f8a_usesFile);
    //_EXECUTE_4ROOT_(tSrcTree_itmHandler4Build__f8a_files4INC);
   _EXECUTE_4ROOT_(tCopyRastSrcTree_f8a);
end;

end.


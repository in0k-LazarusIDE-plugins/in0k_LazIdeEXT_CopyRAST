unit in0k_lazIdeSRC_CopyRAST_srcTree;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  in0k_CopyRAST_srcTree_ITEMs,
  srcTree_handler4build_CORE,
  in0k_lazIdeSRC_srcTree_CORE_item,
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
  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_files4INC,

  in0k_CopyRAST_srcTreeNode_DATA;


type

 tCopyRastSrcTree_Builder4Package=class(tSrcTree_Builder_4Package)
  protected
    function new_ROOT(const name:string):tSrcTree_ROOT;   override;
    function new_Base(const path:string):tSrcTree_BASE;   override;
    function new_Main(const name:string):tSrcTree_MAIN;   override;
    function new_FLDR(const path:string):tSrcTree_fsFLDR; override;
    function new_FILE(const path:string):tSrcTree_fsFILE; override;
  protected
    procedure Node_clrState__notVerified(const item:tSrcTree_item);
  public
    function set_BASE(const ROOT:tSrcTree_ROOT; const path:string):tSrcTree_BASE;                                 override;
    function set_MAIN(const ROOT:tSrcTree_ROOT; const path:string):tSrcTree_MAIN;                                 override;
  public
    function add_FLDR(const ROOT:tSrcTree_ROOT; const path:string; const kind:eSrcTree_SrchPath):tSrcTree_fsFLDR; override;
    function add_FLDR(const ROOT:tSrcTree_ROOT; const path:string; const KNDs:sSrcTree_SrchPath):tSrcTree_fsFLDR; override;
    function add_FILE(const ROOT:tSrcTree_ROOT; const path:string; const kind:eSrcTree_FileType):tSrcTree_fsFILE; override;
  public
    procedure AllNodes_SetSTATE(const ROOT:tSrcTree_ROOT; const newState:tCopyRastNODE_KIND);
  end;

 tCopyRastSrcTree_Creater4Package=class(tSrcTree_Creater_4Package);

    function CreateRoot4Package(const Builder:tCopyRastSrcTree_Builder4Package; const Package:TIDEPackage):tCopyRast_stROOT;



type

 {tCopyRastSrcTree_f8a=class(tSrcTree_itmHandler__f8a)
  protected
    //function _prc__fileName_Need_ADD_(const srcName:string):boolean; override;
  public
    constructor Create(const Owner:tSrcTree_prcHandler; const Parent:tSrcTree_itmHandler); override;
  end;}

 tCopyRastSrcTree_P4Build=class(tSrcTree_prcHandler__f8a);
{  protected
    procedure _EXECUTE_; override;
  end; }

// Processing
// Handler
// prcHandler
// prcBuilder

implementation

function CreateRoot4Package(const Builder:tCopyRastSrcTree_Builder4Package; const Package:TIDEPackage):tCopyRast_stROOT;
var creator:tSrcTree_Creater_4Package;
begin
    creator:=tSrcTree_Creater_4Package.Create;
    try
        result:=creator.MAKE_SourceTREE(Builder,Package);
    finally
        creator.FREE;
    end;
end;

//------------------------------------------------------------------------------

function tCopyRastSrcTree_Builder4Package.new_ROOT(const name:string):tSrcTree_ROOT;
begin
    result:=tCopyRastNODE_Root4Package.Create(name);
end;

function tCopyRastSrcTree_Builder4Package.new_Base(const path:string):tSrcTree_BASE;
begin
    result:=tCopyRast_stBASE.Create(path);
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

//------------------------------------------------------------------------------

procedure _AllNodes_SetSTATE_(const Item:tSrcTree_item; const newState:tCopyRastNODE_KIND);
var tmp:tSrcTree_item;
    tmq:pCopyRastNODE_DATA;
begin
    if IS_CopyRast_stITEM(Item) then begin
        tmq:=CopyRAST_stITEM_DATA(Item);
        tmq^.NodeSTATE:=newState;
    end;
    //---
    tmp:=Item.ItemCHLD;
    while Assigned(tmp) do begin
       _AllNodes_SetSTATE_(tmp,newState);
        tmp:=tmp.ItemNEXT;
    end;
end;

procedure tCopyRastSrcTree_Builder4Package.AllNodes_SetSTATE(const ROOT:tSrcTree_ROOT; const newState:tCopyRastNODE_KIND);
begin
   _AllNodes_SetSTATE_(ROOT,newState);
end;

//------------------------------------------------------------------------------

procedure tCopyRastSrcTree_Builder4Package.Node_clrState__notVerified(const item:tSrcTree_item);
var tmp:pCopyRastNODE_DATA;
begin
    if IS_CopyRast_stITEM(Item) then begin
        tmp:=CopyRAST_stITEM_DATA(Item);
        tmp^.NodeSTATE:=tmp^.NodeSTATE-[CRNK_notVerified];
    end;
end;

//------------------------------------------------------------------------------

function tCopyRastSrcTree_Builder4Package.set_BASE(const ROOT:tSrcTree_ROOT; const path:string):tSrcTree_BASE;
begin
    result:=inherited;
    Node_clrState__notVerified(result);
end;

function tCopyRastSrcTree_Builder4Package.set_MAIN(const ROOT:tSrcTree_ROOT; const path:string):tSrcTree_MAIN;
begin
    result:=inherited;
    Node_clrState__notVerified(result);
end;

function tCopyRastSrcTree_Builder4Package.add_FLDR(const ROOT:tSrcTree_ROOT; const path:string; const kind:eSrcTree_SrchPath):tSrcTree_fsFLDR;
begin
    result:=inherited;
    Node_clrState__notVerified(result);
end;

function tCopyRastSrcTree_Builder4Package.add_FLDR(const ROOT:tSrcTree_ROOT; const path:string; const KNDs:sSrcTree_SrchPath):tSrcTree_fsFLDR;
begin
    result:=inherited;
    Node_clrState__notVerified(result);
end;

function tCopyRastSrcTree_Builder4Package.add_FILE(const ROOT:tSrcTree_ROOT; const path:string; const kind:eSrcTree_FileType):tSrcTree_fsFILE;
begin
    result:=inherited;
    Node_clrState__notVerified(result);
end;

//==============================================================================









{constructor tCopyRastSrcTree_f8a.Create(const Owner:tSrcTree_prcHandler; const Parent:tSrcTree_itmHandler);
begin
   inherited Create(Owner,Parent);
   //
   Handler_ADD(tSrcTree_itmHandler4Build__f8a_Item_4USEs);
   Handler_ADD(tSrcTree_itmHandler4Build__f8a_Item_4INCs);
end;}

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


{procedure tCopyRastSrcTree_P4Build._EXECUTE_;
begin
    //  _EXECUTE_4ROOT_(tSrcTree_itmHandler4Build__f8a_usesFile);
    //_EXECUTE_4ROOT_(tSrcTree_itmHandler4Build__f8a_files4INC);
    EXECUTE_4ROOT(tCopyRastSrcTree_f8a);
end;}

end.


unit in0k_lazIdeSRC_CopyRAST_srcTree;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_fsFile,

  srcTree_builder_4Package,
  srcTree_handler_CORE,

  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_CORE,
  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4INCs,
  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4USEs,


  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_usesFile,
  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_files4INC;

type
  tCopyRastNODE_ROOT=tSrcTree_ROOT;
  tCopyRastNODE_BASE=tSrcTree_BASE;
  tCopyRastNODE_MAIN=tSrcTree_MAIN;
  //---
  tCopyRastNODE_Root4Package=tSrcTree_Root4Package;
  tCopyRastNODE_Main4Package=tSrcTree_Main4Package;
  //---
  tCopyRastNODE_Root4Project=tSrcTree_Root4Project;
  tCopyRastNODE_Main4Project=tSrcTree_Main4Project;
  //---
  tCopyRastNODE_fsFLDR=tSrcTree_fsFLDR;
  tCopyRastNODE_fsFILE=tSrcTree_fsFILE;

type

 tCopyRastSrcTree_Builder=class(tSrcTree_Builder_4Package);

type

 tCopyRastSrcTree_f8a=class(tSrcTree_itmHandler4Build__f8a_CORE)
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

constructor tCopyRastSrcTree_f8a.Create(const Owner:tSrcTree_prcHandler; const Parent:tSrcTree_itmHandler);
begin
   inherited Create(Owner,Parent);
   //
   Handler_ADD(tSrcTree_itmHandler4Build__f8a_Item_4USEs);
   Handler_ADD(tSrcTree_itmHandler4Build__f8a_Item_4INCs);
end;

procedure tCopyRastSrcTree_P4Build._EXECUTE_;
begin
    //  _EXECUTE_4ROOT_(tSrcTree_itmHandler4Build__f8a_usesFile);
    //_EXECUTE_4ROOT_(tSrcTree_itmHandler4Build__f8a_files4INC);
   _EXECUTE_4ROOT_(tCopyRastSrcTree_f8a);
end;

end.


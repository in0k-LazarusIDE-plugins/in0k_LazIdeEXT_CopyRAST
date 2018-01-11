unit lazExt_CopyRAST_clcNotRenamed;

{$mode objfpc}{$H+}

interface

uses


  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,

  in0k_CopyRAST_srcTree_ITEMs,
  in0k_CopyRAST_srcTreeNode_DATA;

function CopyRASTItem_isReNamed(const item:tSrcTree_item):boolean;

function CopyRAST_Item_notReNamedChild_FLDR(const item:tSrcTree_item):integer;
function CopyRAST_Item_notReNamedChild_FILE(const item:tSrcTree_item):integer;

implementation

function CopyRASTItem_isReNamed(const item:tSrcTree_item):boolean;
var tmpData:pCopyRastNODE_DATA;
    tmpItem:tSrcTree_item;
begin
    {$ifOpt D+}
    Assert(Assigned(item));
    {$endif}
    result:=false;
    if not (item is _tSrcTree_item_fsNode_) then EXIT;
    //---
    tmpData:=CopyRAST_stITEM_DATA(item);
    if Assigned(tmpData) then begin
        tmpItem:=tmpData^.sideLeft;
        if Assigned(tmpItem) and (tmpItem is _tSrcTree_item_fsNode_) then begin
            result:=0<> srcTree_fsFnk_CompareFilenames(
                               _tSrcTree_item_fsNode_(tmpItem).fsName,
                               _tSrcTree_item_fsNode_(   item).fsName
                                                      );
        end;
    end;
end;

function CopyRAST_Item_notReNamedChild_FLDR(const item:tSrcTree_item):integer;
var tmpItem:tSrcTree_item;
begin
    {$ifOpt D+}
    Assert(Assigned(item));
    {$endif}
    result:=0;
    //---
    tmpItem:=item.ItemCHLD;
    while Assigned(tmpItem) do begin
        if (tmpItem is _tSrcTree_item_fsNodeFLDR_) and
           (not CopyRASTItem_isReNamed(tmpItem))
        then inc(result);
        result:=result+CopyRAST_Item_notReNamedChild_FLDR(tmpItem);
        //-->
        tmpItem:=tmpItem.ItemNEXT;
    end;
end;

function CopyRAST_Item_notReNamedChild_FILE(const item:tSrcTree_item):integer;
var tmpItem:tSrcTree_item;
begin
    {$ifOpt D+}
    Assert(Assigned(item));
    {$endif}
    result:=0;
    //---
    tmpItem:=item.ItemCHLD;
    while Assigned(tmpItem) do begin
        if (tmpItem is _tSrcTree_item_fsNodeFILE_) and
           (not CopyRASTItem_isReNamed(tmpItem))
        then inc(result);
        result:=result+CopyRAST_Item_notReNamedChild_FILE(tmpItem);
        //-->
        tmpItem:=tmpItem.ItemNEXT;
    end;
end;

end.


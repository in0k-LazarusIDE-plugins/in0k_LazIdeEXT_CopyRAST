unit cmpCopyRAST_srcTree_approvedNAMEs;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  sysutils,
  ComCtrls,
  Graphics,

  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,

  in0k_ext4ColorTheme,
  lazExt_CopyRAST_clcNotRenamed,
  cmpCopyRAST_srcTree;

type

 tCmpCopyRAST_srcTree_approvedNAMEs=class(tCmpCopyRAST_srcTree)
  protected
   _show_unReNamed_FLDR_:boolean;
   _show_unReNamed_FILE_:boolean;
  protected
    function  CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; Stage:TCustomDrawStage; var PaintImages:Boolean):Boolean; override;
  public
    constructor Create(AnOwner: TComponent); override;
  end;

implementation

constructor tCmpCopyRAST_srcTree_approvedNAMEs.Create(AnOwner:TComponent);
begin
    inherited Create(AnOwner);
   _lftSide_mustNotNIL_:=TRUE;
    //---
   _show_unReNamed_FLDR_:=false;
   _show_unReNamed_FILE_:=true;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCmpCopyRAST_srcTree_approvedNAMEs.CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; Stage:TCustomDrawStage; var PaintImages:Boolean):Boolean;
var tmpNode:tSrcTree_item;
    tmpRect:TRect;
    tmpCNTs:integer;
begin
    result:=inherited;
    if (Stage=cdPrePaint) and result then begin //< мы можем что-то порисовать
        if ( _show_unReNamed_FILE_ or _show_unReNamed_FLDR_) then begin
            tmpNode:=tSrcTree_item(Node.Data);
            //---

            //---
            if (tmpNode is _tSrcTree_item_fsNodeFILE_) and (_show_unReNamed_FILE_) then begin
                if NOT lazExt_CopyRAST_clcNotRenamed.CopyRASTItem_isReNamed(tmpNode) then begin
                    Canvas.Font.Color:=color_Red//clGray
                end;
            end
           else
            if (tmpNode is _tSrcTree_item_fsNodeFLDR_) and (_show_unReNamed_FLDR_) then begin
                if NOT lazExt_CopyRAST_clcNotRenamed.CopyRASTItem_isReNamed(tmpNode) then begin
                    Canvas.Font.Color:=color_Red//clGray
                end;
            end
        end;
    end;
    if (Stage=cdPostPaint)and result then begin
        tmpNode:=tSrcTree_item(Node.Data);
        if ( _show_unReNamed_FILE_ or _show_unReNamed_FLDR_) then begin
            //
            Canvas.Brush.Style:=bsClear;
            Canvas.Font.Color:=color_Red;//clGray
            //
            tmpCNTs:=0;
            if _show_unReNamed_FLDR_ then tmpCNTs:=tmpCNTs+ CopyRAST_Item_notReNamedChild_FLDR(tmpNode);
            if _show_unReNamed_FILE_ then tmpCNTs:=tmpCNTs+ CopyRAST_Item_notReNamedChild_FILE(tmpNode);
            if tmpCNTs>0 then begin
                tmpRect:=node.DisplayRect(true);
                Canvas.TextOut(tmpRect.Right+4,tmpRect.Top, inttostr(tmpCNTs));
            end;
        end;
    end;
end;

end.


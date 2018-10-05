unit in0k_CopyRAST__stage_01__frm_cmpResult;

{$mode objfpc}{$H+}

interface

uses
  in0k_ext4ColorTheme,
  sysutils,
  Classes,
  Graphics,
  ComCtrls,
  in0k_lazIdeSRC_srcTree_CORE_item,

  in0k_CopyRAST_srcTree_ITEMs,
  in0k_CopyRAST_srcTreeNode_DATA,
  in0k_CopyRAST__cmpSTAGE_Tree;


type

 tCmpCopyRAST_srcTree_Stage1_result=class(tCmpCopyRAST_stageTree)
  protected
   _rootSRC_:tCopyRast_stROOT;
    procedure _rootSRC_set_(const value:tCopyRast_stROOT);
  protected
    procedure _CDI_countAddedFiles(const Node:TTreeNode; const count:integer);
    function  CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; aStage:TCustomDrawStage; var PaintImages:Boolean):Boolean; override;
  public
    property RootSRC:tCopyRast_stROOT write _rootSRC_set_;
  end;

implementation


// расчитать кол-во ДОБАВЛЕННЫХ файлов (считаем для ПАПОК)
function _calc_Item_notInLeftRoot_FILE_(const leftRoot:tCopyRast_stROOT; const item:tSrcTree_item):integer;
var tmpItem:tCopyRast_stITEM;
begin
    {$ifOpt D+}
    Assert(Assigned(item));
    {$endif}
    result:=0;
    //---
    tmpItem:=item.ItemCHLD;
    while Assigned(tmpItem) do begin
        if (tmpItem is tCopyRastNODE_FILE) and
           (not Assigned( CopyRastNODE_presentInLeft(leftRoot,tmpItem) ))
        then inc(result);
        result:=result+_calc_Item_notInLeftRoot_FILE_(leftRoot,tmpItem);
        //-->
        tmpItem:=tmpItem.ItemNEXT;
    end;
end;


procedure tCmpCopyRAST_srcTree_Stage1_result._rootSRC_set_(const value:tCopyRast_stROOT);
begin
   _rootSRC_:=value;
end;


procedure tCmpCopyRAST_srcTree_Stage1_result._CDI_countAddedFiles(const Node:TTreeNode; const count:integer);
var tmpRect:TRect;
    tmpText:string;
    tmpFSTL:TFontStyles;
begin
    tmpFSTL:=Canvas.Font.Style;
    //
    Canvas.Brush.Color:=self.Color;
    //Canvas.Font.Color:=in0k_ext4ColorTheme_asGreen;
    Canvas.Font.Style:=tmpFSTL+[fsBold];

    //---


    //self.Expand();

    if nsExpanded in Node.States
    then Canvas.Font.Color:=in0k_ext4ColorTheme_clGrayText
    else Canvas.Font.Color:=in0k_ext4ColorTheme_clHotLight;

    //---
    str(count,tmpText);
    tmpText:='+'+tmpText;
    //---
    tmpRect:=node.DisplayRect(true);
    tmpRect.Left:=tmpRect.Right;
    //---
   _canvasTextOut_000_(Canvas,tmpText,tmpRect);
    //
    Canvas.Font.Style:=tmpFSTL;
end;

function tCmpCopyRAST_srcTree_Stage1_result.CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; aStage:TCustomDrawStage; var PaintImages:Boolean):Boolean;
var tmpNode:tSrcTree_item;
    tmpData:pCopyRastNODE_DATA;

    tmpRect:TRect;
    tmpCNTs:integer;

begin
    result:=inherited;
    if (aStage=cdPrePaint) and result then begin
        tmpNode:=tSrcTree_item(Node.Data);
        if Assigned(tmpNode) and IS_CopyRast_stITEM(tmpNode)
        then begin
            // если это НОВЫЙ (т.е. у него нет СЛЕВА) - то покрасим его
            if not Assigned( CopyRastNODE_presentInLeft(_rootSRC_,tmpNode) )
            then Canvas.Font.Color:=in0k_ext4ColorTheme_clHotLight;
        end;
    end;
    if (aStage=cdPostPaint)and result then begin
        tmpNode:=tSrcTree_item(Node.Data);
        tmpCNTs:=0;
        //if _show_unReNamed_FLDR_ then tmpCNTs:=tmpCNTs+ CopyRAST_Item_notReNamedChild_FLDR(tmpNode);
        //if _show_unReNamed_FILE_ then
        tmpCNTs:=tmpCNTs+ _calc_Item_notInLeftRoot_FILE_(_rootSRC_,tmpNode);
        if tmpCNTs>0 then _CDI_countAddedFiles(Node,tmpCNTs);
    end;
end;

end.


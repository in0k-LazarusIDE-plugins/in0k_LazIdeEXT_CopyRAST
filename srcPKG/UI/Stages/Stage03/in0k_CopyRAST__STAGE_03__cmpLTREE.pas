unit in0k_CopyRAST__STAGE_03__cmpLTREE;

{$mode objfpc}{$H+}

interface

uses
  Types,
  ComCtrls,
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_CopyRAST_srcTreeNode_DATA,
  in0k_CopyRAST__STAGE_03__reName,
  in0k_ext4ColorTheme,
  in0k_CopyRAST__cmpSTAGE_Tree;

type
 tCmpCopyRAST_srcTree_Stage03_cmpLTREE=class(tCmpCopyRAST_stageTree)
  protected
    function _calcCount_SELF_NameCustom_(const item:tSrcTree_item):integer;
    function _calcCount_SELF_PathCustom_(const item:tSrcTree_item):integer;
  protected
    procedure _node_have_csFile_(const node:TTreeNode; out ruleHave,ruleOn:boolean);
  protected
    function CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; aStage:TCustomDrawStage; var PaintImages:Boolean):Boolean; override;
  end;


implementation

// олучить указатель на STAGE СВОЕГО типа
function _STAGE_(const cmp:tCmpCopyRAST_srcTree_Stage03_cmpLTREE):tCopyRast_stage__ChangePaths; //inline;
begin
    result:=nil;
    if Assigned(cmp.CopyRast_STAGE) and (cmp.CopyRast_STAGE is tCopyRast_stage__ChangePaths)
    then result:=tCopyRast_stage__ChangePaths(cmp.CopyRast_STAGE);
end;

function _STAGE_isEMPTY_(const cmp:tCmpCopyRAST_srcTree_Stage03_cmpLTREE):boolean; //inline;
begin
    result:=not Assigned(_STAGE_(cmp));
end;

//==============================================================================

function tCmpCopyRAST_srcTree_Stage03_cmpLTREE._calcCount_SELF_NameCustom_(const item:tSrcTree_item):integer;
begin
    result:=0;
    if _STAGE_(self).CNFG_customer_NameCustom(item) then result:=1;
end;

function tCmpCopyRAST_srcTree_Stage03_cmpLTREE._calcCount_SELF_PathCustom_(const item:tSrcTree_item):integer;
begin
    result:=0;
    if _STAGE_(self).CNFG_customer_PathCustom(item) then result:=1;
end;

//==============================================================================


procedure tCmpCopyRAST_srcTree_Stage03_cmpLTREE._node_have_csFile_(const node:TTreeNode; out ruleHave,ruleOn:boolean);
begin
    //in0k_CopyRAST_srcTreeNode_DATA


end;

function tCmpCopyRAST_srcTree_Stage03_cmpLTREE.CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; aStage:TCustomDrawStage; var PaintImages:Boolean):Boolean;
var tmpNode:tSrcTree_item;
    tmpData:pCopyRastNODE_DATA;
    tmpRect:tRect;
begin
    result:=inherited;
    if _STAGE_isEMPTY_(self) then EXIT;
    //--------------------------------------
    if (aStage=cdPostPaint) then begin
        tmpNode:=tSrcTree_item(Node.Data);
        {if Assigned(tmpNode) and IS_CopyRast_stITEM(tmpNode) then begin
            tmpData:=CopyRAST_stITEM_DATA(tmpNode);

        end;}
        tmpRect:=_displayRect_RIGHT_(Node);
        //Self._canvasTextOut_l2r_(Canvas,_STAGE_(self).ClassName,tmpRect);
        Canvas.Brush.Color:=self.Color;
        Canvas.Font.Color:=in0k_ext4ColorTheme_asGreen;
        //Canvas.Font.Style:=tmpFSTL+[fsBold];
        //
        //
        if _calcCount_SELF_NameCustom_(tmpNode)>0
        then Self._canvasTextOut_l2r_(Canvas,'F',tmpRect);
        if _calcCount_SELF_PathCustom_(tmpNode)>0
        then Self._canvasTextOut_l2r_(Canvas,'D',tmpRect);
    end;


{    if (aStage=cdPostPaint) then begin {and (_lftSide_mustNotNIL_ or _rhtSide_mustNotNIL_) and result then begin
        tmpNode:=tSrcTree_item(Node.Data);
        if Assigned(tmpNode) and IS_CopyRast_stITEM(tmpNode) then begin
            tmpData:=CopyRAST_stITEM_DATA(tmpNode);
            if _lftSide_mustNotNIL_ and not Assigned(tmpData^.sideLeft)
            then Canvas.Font.Color:=clGrayText//color_Red//clGray
           else
            if _rhtSide_mustNotNIL_ and not Assigned(tmpData^.sideRight)
            then Canvas.Font.Color:=clGrayText//color_Red//clGray
        end;}
        tmpRect      :=_displayRect_RIGHT_(Node);
        //
        Self._canvasTextOut_l2r_(Canvas,_STAGE_(self).ClassName,tmpRect);
        Self._canvasTextOut_l2r_(Canvas,'bcd',tmpRect);
    end;  }
end;

end.


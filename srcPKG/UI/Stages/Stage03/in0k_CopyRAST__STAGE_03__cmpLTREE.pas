unit in0k_CopyRAST__STAGE_03__cmpLTREE;

{$mode objfpc}{$H+}

interface

uses
  Types,
  ComCtrls,
  sysutils,
  Graphics,
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_CopyRAST_srcTreeNode_DATA,
  in0k_CopyRAST__STAGE_03__reName,
  in0k_ext4ColorTheme,
  in0k_CopyRAST__cmpSTAGE_Tree;

type
 tCmpCopyRAST_srcTree_Stage03_cmpLTREE=class(tCmpCopyRAST_stageTree)
  protected
    function _calcCount_SELF_FileNames_(const item:tSrcTree_item):integer;
    function _calcCount_ChldsFileNames_(const item:tSrcTree_item):integer;
    function _calcCount_SELF_PathNames_(const item:tSrcTree_item):integer;
    function _calcCount_ChldsPathNames_(const item:tSrcTree_item):integer;
    function _calcCount_SELF_Templates_(const item:tSrcTree_item):integer;
    function _calcCount_ChldsTemplates_(const item:tSrcTree_item):integer;
  protected
    procedure _node_have_csFile_(const node:TTreeNode; out ruleHave,ruleOn:boolean);
  protected
    procedure _CDI_customFileNames_(var aRect:TRect; const node:TTreeNode; const item:tSrcTree_item);
    procedure _CDI_customPathNames_(var aRect:TRect; const node:TTreeNode; const item:tSrcTree_item);
    procedure _CDI_customTemplates_(var aRect:TRect; const node:TTreeNode; const item:tSrcTree_item);
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

function tCmpCopyRAST_srcTree_Stage03_cmpLTREE._calcCount_SELF_FileNames_(const item:tSrcTree_item):integer;
begin
    result:=0;
    if _STAGE_(self).CNFG_customer_NameCustom(item) then result:=1;
end;

// сколько ВЛОЖЕННЫХ узлов имеют СОБСТВЕННЫЕ названия
function tCmpCopyRAST_srcTree_Stage03_cmpLTREE._calcCount_ChldsFileNames_(const item:tSrcTree_item):integer;
var tmp:tSrcTree_item;
begin {todo: УЙТИ от рекурсии}
    result:=0;
    //---
    tmp:=item.ItemCHLD;
    while Assigned(tmp) do begin
        result:=result+_calcCount_SELF_FileNames_(tmp);
        result:=result+_calcCount_ChldsFileNames_(tmp);
        //-->
        tmp:=tmp.ItemNEXT;
    end;
end;

//------------------------------------------------------------------------------

function tCmpCopyRAST_srcTree_Stage03_cmpLTREE._calcCount_SELF_PathNames_(const item:tSrcTree_item):integer;
begin
    result:=0;
    if _STAGE_(self).CNFG_customer_PathCustom(item) then result:=1;
end;

// сколько ВЛОЖЕННЫХ узлов имеют СОБСТВЕННЫЕ пути
function tCmpCopyRAST_srcTree_Stage03_cmpLTREE._calcCount_ChldsPathNames_(const item:tSrcTree_item):integer;
var tmp:tSrcTree_item;
begin {todo: УЙТИ от рекурсии}
    result:=0;
    //---
    tmp:=item.ItemCHLD;
    while Assigned(tmp) do begin
        result:=result+_calcCount_SELF_PathNames_(tmp);
        result:=result+_calcCount_ChldsPathNames_(tmp);
        //-->
        tmp:=tmp.ItemNEXT;
    end;
end;

//------------------------------------------------------------------------------

function tCmpCopyRAST_srcTree_Stage03_cmpLTREE._calcCount_SELF_Templates_(const item:tSrcTree_item):integer;
begin
    result:=_STAGE_(self).CNFG_template_count(item);
end;

function tCmpCopyRAST_srcTree_Stage03_cmpLTREE._calcCount_ChldsTemplates_(const item:tSrcTree_item):integer;
var tmp:tSrcTree_item;
begin {todo: УЙТИ от рекурсии}
    result:=0;
    //---
    tmp:=item.ItemCHLD;
    while Assigned(tmp) do begin
        result:=result+_calcCount_SELF_Templates_(tmp);
        result:=result+_calcCount_ChldsTemplates_(tmp);
        //-->
        tmp:=tmp.ItemNEXT;
    end;
end;

//==============================================================================


procedure tCmpCopyRAST_srcTree_Stage03_cmpLTREE._node_have_csFile_(const node:TTreeNode; out ruleHave,ruleOn:boolean);
begin
    //in0k_CopyRAST_srcTreeNode_DATA
end;

procedure tCmpCopyRAST_srcTree_Stage03_cmpLTREE._CDI_customFileNames_(var aRect:TRect; const node:TTreeNode; const item:tSrcTree_item);
var cHimSelf:integer;
    cInChlds:integer;
begin
    cHimSelf:=_calcCount_SELF_FileNames_(item);
    cInChlds:=_calcCount_ChldsFileNames_(item);
    if (cHimSelf>0)or(cInChlds>0) then begin
        if cHimSelf>0
        then begin
           Canvas.Font.Color:=in0k_ext4ColorTheme_clHotLight;
           Canvas.Font.Style:=[fsBold];
        end
        else begin
           Canvas.Font.Color:=in0k_ext4ColorTheme_clGrayText;
           Canvas.Font.Style:=[];
        end;
       _canvasTextOut_l2r_(Canvas,'D',aRect);
        //
        if cInChlds>0 then begin
           Canvas.Font.Color:=in0k_ext4ColorTheme_clGrayText;
           Canvas.Font.Style:=[];
          _canvasTextOut_l2r_(Canvas,'[',aRect);

           if not node.Expanded then Canvas.Font.Color:=in0k_ext4ColorTheme_clHotLight;
           Canvas.Font.Style:=[fsBold];
          _canvasTextOut_l2r_(Canvas,'+'+inttostr(cInChlds),aRect);

           Canvas.Font.Color:=in0k_ext4ColorTheme_clGrayText;
           Canvas.Font.Style:=[];
          _canvasTextOut_l2r_(Canvas,']',aRect);
        end;
    end;
end;

procedure tCmpCopyRAST_srcTree_Stage03_cmpLTREE._CDI_customPathNames_(var aRect:TRect;  const node:TTreeNode; const item:tSrcTree_item);
var cHimSelf:integer;
    cInChlds:integer;
begin
    cHimSelf:=_calcCount_SELF_PathNames_(item);
    cInChlds:=_calcCount_ChldsPathNames_(item);
    if (cHimSelf>0)or(cInChlds>0) then begin
        if cHimSelf>0
        then begin
           Canvas.Font.Color:=in0k_ext4ColorTheme_clHotLight;
           Canvas.Font.Style:=[fsBold];
        end
        else begin
           Canvas.Font.Color:=in0k_ext4ColorTheme_clGrayText;
           Canvas.Font.Style:=[];
        end;
       _canvasTextOut_l2r_(Canvas,'F',aRect);
        //
        if cInChlds>0 then begin
           Canvas.Font.Color:=in0k_ext4ColorTheme_clGrayText;
           Canvas.Font.Style:=[];
          _canvasTextOut_l2r_(Canvas,'[',aRect);

           if not node.Expanded then Canvas.Font.Color:=in0k_ext4ColorTheme_clHotLight;
           Canvas.Font.Style:=[fsBold];
          _canvasTextOut_l2r_(Canvas,'+'+inttostr(cInChlds),aRect);

           Canvas.Font.Color:=in0k_ext4ColorTheme_clGrayText;
           Canvas.Font.Style:=[];
          _canvasTextOut_l2r_(Canvas,']',aRect);
        end;
    end;
end;

procedure tCmpCopyRAST_srcTree_Stage03_cmpLTREE._CDI_customTemplates_(var aRect:TRect; const node:TTreeNode; const item:tSrcTree_item);
var cHimSelf:integer;
    cInChlds:integer;
begin
    cHimSelf:=_calcCount_SELF_Templates_(item);
    cInChlds:=_calcCount_ChldsTemplates_(item);
    if (cHimSelf>0)or(cInChlds>0) then begin
        Canvas.Font.Color:=in0k_ext4ColorTheme_clGrayText;
        Canvas.Font.Style:=[];
       _canvasTextOut_l2r_(Canvas,'[',aRect);
        //---
        if cHimSelf>0 then begin
            Canvas.Font.Color:=in0k_ext4ColorTheme_clHotLight;
            Canvas.Font.Style:=[fsBold];
           _canvasTextOut_l2r_(Canvas,inttostr(cHimSelf),aRect);
        end;
        if cInChlds>0 then begin
            Canvas.Font.Color:=in0k_ext4ColorTheme_clGrayText;
            Canvas.Font.Style:=[];
           _canvasTextOut_l2r_(Canvas,'+',aRect);
            //---
            if not node.Expanded then Canvas.Font.Color:=in0k_ext4ColorTheme_clHotLight;
            Canvas.Font.Style:=[fsBold];
           _canvasTextOut_l2r_(Canvas,inttostr(cHimSelf),aRect);
        end;
        //---
        Canvas.Font.Color:=in0k_ext4ColorTheme_clGrayText;
        Canvas.Font.Style:=[];
       _canvasTextOut_l2r_(Canvas,']',aRect);
    end;
end;


function tCmpCopyRAST_srcTree_Stage03_cmpLTREE.CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; aStage:TCustomDrawStage; var PaintImages:Boolean):Boolean;
var tmpItem:tSrcTree_item;
    tmpData:pCopyRastNODE_DATA;
    tmpRect:tRect;
begin
    result:=inherited;
    if _STAGE_isEMPTY_(self) then EXIT;
    //--------------------------------------
    if (aStage=cdPostPaint) then begin
        tmpItem:=tSrcTree_item(Node.Data);
        {if Assigned(tmpItem) and IS_CopyRast_stITEM(tmpItem) then begin
            tmpData:=CopyRAST_stITEM_DATA(tmpItem);

        end;}
        tmpRect:=_displayRect_RIGHT_(Node);
        //Self._canvasTextOut_l2r_(Canvas,_STAGE_(self).ClassName,tmpRect);
        Canvas.Brush.Color:=self.Color;
       _canvasFont_saveDEF_(Canvas);
       _CDI_customFileNames_(tmpRect,Node, tmpItem);
       _CDI_customPathNames_(tmpRect,Node, tmpItem);
       _CDI_customTemplates_(tmpRect,Node, tmpItem);
       _canvasFont_reStore_(Canvas);

        //if _calcCount_SELF_NameCustom_(tmpItem)>0
        //then Self._canvasTextOut_l2r_(Canvas,'F',tmpRect);
        //if _calcCount_SELF_PathCustom_(tmpItem)>0
        //then Self._canvasTextOut_l2r_(Canvas,'D',tmpRect);
    end;


{    if (aStage=cdPostPaint) then begin {and (_lftSide_mustNotNIL_ or _rhtSide_mustNotNIL_) and result then begin
        tmpItem:=tSrcTree_item(Node.Data);
        if Assigned(tmpItem) and IS_CopyRast_stITEM(tmpItem) then begin
            tmpData:=CopyRAST_stITEM_DATA(tmpItem);
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


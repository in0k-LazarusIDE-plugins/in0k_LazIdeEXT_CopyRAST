unit in0k_CopyRAST__STAGE_03__cmpRTREE;

{$mode objfpc}{$H+}

interface

uses
  Types,
  sysutils,
  Classes,
  ComCtrls,
  Graphics,


  in0k_CopyRAST_srcTree_ITEMs,

  in0k_CopyRAST__cmpSTAGE_Tree,
  in0k_ext4ColorTheme,
  //
  in0k_CopyRAST__STAGE_03__reName;


type
 tCmpCopyRAST_srcTree_Stage03_cmpRTREE=class(tCmpCopyRAST_stageTree)
  protected
   _invert_:boolean;
  protected //< функции расчета кол-ва элементов в подДеревьях
    function _calcCount_SELF_WasReName_(const item:tCopyRast_stITEM; const invrt:boolean):integer;
    function _calcCount_ChldsWasReName_(const item:tCopyRast_stITEM; const invrt:boolean):integer;
  protected //< рисование доп.Инфы
    procedure _CDI_WasReName_(var aRect:TRect; const node:TTreeNode; const item:tCopyRast_stITEM);
  protected //< рисование УЗЛА
    function CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; aStage:TCustomDrawStage; var PaintImages:Boolean):Boolean; override;
  public
    constructor Create(AnOwner: TComponent); override;
  end;


implementation

// получить указатель на STAGE СВОЕГО типа
function _STAGE_(const cmp:tCmpCopyRAST_srcTree_Stage03_cmpRTREE):tCopyRast_stage__ChangePaths; {$ifOpt D-}inline;{$endIf}
begin
    result:=nil;
    if Assigned(cmp.CopyRast_STAGE) and (cmp.CopyRast_STAGE is tCopyRast_stage__ChangePaths)
    then result:=tCopyRast_stage__ChangePaths(cmp.CopyRast_STAGE);
end;

function _STAGE_isEMPTY_(const cmp:tCmpCopyRAST_srcTree_Stage03_cmpRTREE):boolean; {$ifOpt D-}inline;{$endIf}
begin
    result:=not Assigned(_STAGE_(cmp));
end;

//==============================================================================

constructor tCmpCopyRAST_srcTree_Stage03_cmpRTREE.Create(AnOwner: TComponent);
begin
    inherited Create(AnOwner);
   _invert_:=TRUE;
end;

//------------------------------------------------------------------------------

function tCmpCopyRAST_srcTree_Stage03_cmpRTREE._calcCount_SELF_WasReName_(const item:tCopyRast_stITEM; const invrt:boolean):integer;
begin
    result:=0;
    if _STAGE_(self).RSLT_wasReNamed(item) then result:=1;
    //
    if invrt then result:=1-result;
end;

// сколько ВЛОЖЕННЫХ узлов имеют СОБСТВЕННЫЕ названия
function tCmpCopyRAST_srcTree_Stage03_cmpRTREE._calcCount_ChldsWasReName_(const item:tCopyRast_stITEM; const invrt:boolean):integer;
var tmp:tCopyRast_stITEM;
begin {todo: УЙТИ от рекурсии}
    result:=0;
    // считаем кол-во ПЕРЕименнованных потомков
    tmp:=item.ItemCHLD;
    while Assigned(tmp) do begin
        result:=result+_calcCount_SELF_WasReName_(tmp,FALSE);
        result:=result+_calcCount_ChldsWasReName_(tmp,FALSE);
        //-->
        tmp:=tmp.ItemNEXT;
    end;
    //---
    if invrt then result:=item.CountCHILDs-result;
end;

//==============================================================================

procedure tCmpCopyRAST_srcTree_Stage03_cmpRTREE._CDI_WasReName_(var aRect:TRect; const node:TTreeNode; const item:tCopyRast_stITEM);
var cntInChlds:integer;
begin
    cntInChlds:=_calcCount_ChldsWasReName_(item,_invert_);
    if cntInChlds>0 then begin
        Canvas.Font.Color:=in0k_ext4ColorTheme_clGrayText;
        Canvas.Font.Style:=[];
       _canvasTextOut_l2r_(Canvas,'[',aRect);

        if not node.Expanded then Canvas.Font.Color:=in0k_ext4ColorTheme_clHotLight;
        Canvas.Font.Style:=[fsBold];
       _canvasTextOut_l2r_(Canvas,'+'+inttostr(cntInChlds),aRect);

        Canvas.Font.Color:=in0k_ext4ColorTheme_clGrayText;
        Canvas.Font.Style:=[];
       _canvasTextOut_l2r_(Canvas,']',aRect);
    end;
end;

//==============================================================================

function tCmpCopyRAST_srcTree_Stage03_cmpRTREE.CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; aStage:TCustomDrawStage; var PaintImages:Boolean):Boolean;
var tmpItem:tCopyRast_stITEM;
    tmpRect:tRect;
begin
    result:=inherited;
    if _STAGE_isEMPTY_(self) then EXIT;
    //---
    if (aStage=cdPrePaint) then begin
        tmpItem:=tCopyRast_stITEM(Node.Data);
        if _calcCount_SELF_WasReName_(tmpItem,_invert_)>0 then begin
            Canvas.Font.Color:=in0k_ext4ColorTheme_clHotLight;
        end;
    end
    else
    if (aStage=cdPostPaint) then begin
        tmpItem:=tCopyRast_stITEM(Node.Data);
        tmpRect:=_displayRect_RIGHT_(Node);
        //
        Canvas.Brush.Color:=self.Color;
       _canvasFont_saveDEF_(Canvas);
        // доп ИНФА
       _CDI_WasReName_(tmpRect,Node, tmpItem);
        //
       _canvasFont_reStore_(Canvas);
    end;
end;

end.


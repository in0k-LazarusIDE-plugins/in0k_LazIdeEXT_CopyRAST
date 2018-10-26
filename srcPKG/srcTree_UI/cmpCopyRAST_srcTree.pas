unit cmpCopyRAST_srcTree;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Graphics,
  ComCtrls,

  in0k_ext4ColorTheme,

  in0k_lazIdeSRC_srcTree_CORE_item,

  in0k_CopyRAST_srcTree_ITEMs,
  in0k_lazExt_CopyRAST_cmpTree,

  in0k_CopyRAST_srcTreeNode_DATA;

type

 tCmpCopyRAST_srcTree=class(tCmp_CopyRAST_Tree)
  protected
    procedure _root_set_(const newRoot:tSrcTree_item); override;
  protected
   _lftSide_mustNotNIL_:boolean;
   _rhtSide_mustNotNIL_:boolean;
  protected
    procedure _paint_notVerified_(const node:TTreeNode);
    function  IsCustomDrawn(Target:TCustomDrawTarget; Stage:TCustomDrawStage): Boolean; override;
    function  CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; Stage:TCustomDrawStage; var PaintImages:Boolean):Boolean; override;
    procedure DoPaintNode(Node: TTreeNode); override;
  protected
   _fontDef_:TFont;
    procedure _canvasFont_saveDEF_(const aCanvas:TCanvas);
    procedure _canvasFont_reStore_(const aCanvas:TCanvas);
  protected
    function  _displayRect_RIGHT_ (const aNode:TTreeNode):tRect;
    procedure _canvasTextOut_000_ (const aCanvas:TCanvas; const aText:string; const aRect:tRect);
    procedure _canvasTextOut_l2r_ (const aCanvas:TCanvas; const aText:string; var   aRect:tRect);
  public
    procedure Select_4Right(const item:tSrcTree_item);
    procedure Select_4Left (const item:tSrcTree_item);
  public
    constructor Create(AnOwner: TComponent); override;
    destructor DESTROY; override;
  public
    procedure Expand_MainNODEs;
  end;
  tCmpCopyRAST_srcTree_TYPE=class of tCmpCopyRAST_srcTree;

implementation

constructor tCmpCopyRAST_srcTree.Create(AnOwner:TComponent);
begin
    inherited Create(AnOwner);
   _fontDef_:=nil;
   _lftSide_mustNotNIL_:=false;
   _rhtSide_mustNotNIL_:=false;
    self.Options:=self.Options-[tvoThemedDraw]+[tvoReadOnly];
end;

destructor tCmpCopyRAST_srcTree.DESTROY;
begin
    inherited DESTROY;
   _fontDef_.FREE;
end;

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree._root_set_(const newRoot:tSrcTree_item);
begin
    inherited;
    Expand_MainNODEs;
end;

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree.Select_4Right(const item:tSrcTree_item);
var i:integer;
  tmp:pointer;
begin
    ClearSelection;
    for i:=0 to self.Items.Count-1 do begin
        tmp:=Items.Item[i].Data;
        if Assigned(tmp) and
           IS_CopyRast_stITEM(tObject(tmp))
        then begin
            tmp:=CopyRAST_stITEM_DATA(tCopyRast_stITEM(tmp));
            if Assigned(tmp) and
               (pCopyRastNODE_DATA(tmp)^.sideRight=item)
            then begin
                items[i].Selected:=TRUE;
            end;
        end;
    end;
end;

procedure tCmpCopyRAST_srcTree.Select_4Left(const item:tSrcTree_item);
var i:integer;
  tmp:pointer;
begin
    ClearSelection;
    for i:=0 to self.Items.Count-1 do begin
        tmp:=Items.Item[i].Data;
        if Assigned(tmp) and
           IS_CopyRast_stITEM(tObject(tmp))
        then begin
            tmp:=CopyRAST_stITEM_DATA(tObject(tmp));
            if Assigned(tmp) and
               (pCopyRastNODE_DATA(tmp)^.sideLeft=item)
            then begin
                items[i].Selected:=TRUE;
            end;
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree._paint_notVerified_(const node:TTreeNode);
var rect:tRect;
begin
    rect:=Node.DisplayRect(true);
    rect.Top   :=rect.Top+(rect.Bottom-rect.Top)div 2;
    rect.Bottom:=Indent div 4;
    rect.Left  :=rect.Left +rect.Bottom;
    rect.Right :=rect.Right-rect.Bottom;

    Canvas.Pen.Color:=clRed;
    Canvas.Line(Rect.Left,rect.Top, rect.Right,rect.Top);
end;


function tCmpCopyRAST_srcTree.IsCustomDrawn(Target:TCustomDrawTarget; Stage:TCustomDrawStage): Boolean;
begin
    if (Target=dtItem) and (Stage=cdPrePaint) then begin
        result:=true;
    end;
end;

function tCmpCopyRAST_srcTree.CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; Stage:TCustomDrawStage; var PaintImages:Boolean):Boolean;
var tmpNode:tSrcTree_item;
    tmpData:pCopyRastNODE_DATA;
begin
    result:=inherited;
    if (Stage=cdPrePaint) and (_lftSide_mustNotNIL_ or _rhtSide_mustNotNIL_) and result then begin
        tmpNode:=tSrcTree_item(Node.Data);
        if Assigned(tmpNode) and IS_CopyRast_stITEM(tmpNode) then begin
            tmpData:=CopyRAST_stITEM_DATA(tmpNode);
            if _lftSide_mustNotNIL_ and not Assigned(tmpData^.sideLeft)
            then Canvas.Font.Color:=clGrayText//color_Red//clGray
           else
            if _rhtSide_mustNotNIL_ and not Assigned(tmpData^.sideRight)
            then Canvas.Font.Color:=clGrayText//color_Red//clGray
        end;
    end;
end;

procedure tCmpCopyRAST_srcTree.DoPaintNode(Node:TTreeNode);
var tmpNode:tSrcTree_item;
    tmpData:pCopyRastNODE_DATA;
begin
    inherited;
    tmpNode:=tSrcTree_item(Node.Data);
    if Assigned(tmpNode) and IS_CopyRast_stITEM(tmpNode) then begin
        tmpData:=CopyRAST_stITEM_DATA(tmpNode);
        if CRNK_notVerified in tmpData^.NodeSTATE then begin
           _paint_notVerified_(Node);
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree.Expand_MainNODEs;
var i:integer;
    p:pointer;
begin
    for i:=0 to self.Items.Count-1 do begin
        p:=items[i].Data;
        if IS_CopyRAST_stROOT(p) or IS_CopyRAST_stBASE(p) or IS_CopyRAST_stMAIN(p)
        then begin
            items[i].Expanded:=TRUE;
        end;
    end;
end;

//------------------------------------------------------------------------------

function tCmpCopyRAST_srcTree._displayRect_RIGHT_(const aNode:TTreeNode):tRect;
begin
    result:=Rect(0,0,0,0);
    if Assigned(aNode) then begin
        result:=aNode.DisplayRect(TRUE);
        result.Left :=result.Right+1;
        result.Right:=self.ClientWidth;
    end;
end;

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree._canvasFont_saveDEF_(const aCanvas:TCanvas);
begin
    if not assigned(_fontDef_) then _fontDef_:=TFont.Create;
   _fontDef_.Assign(aCanvas.Font);
end;

procedure tCmpCopyRAST_srcTree._canvasFont_reStore_(const aCanvas:TCanvas);
begin
    aCanvas.Font.Assign(_fontDef_);
end;

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree._canvasTextOut_000_(const aCanvas:TCanvas; const aText:string; const aRect:tRect);
var y:integer;
begin {todo: пооптимизировать как-то надо, наверное}
    y:=aRect.Top+(aRect.Bottom-aRect.Top-aCanvas.TextHeight(aText)) div 2;
    aCanvas.TextOut(aRect.Left,y,aText);
end;

// выводим текст и СДВИГАЕМ левю границу прямоугольника на ширину ВЫВЕДЕННОГО
procedure tCmpCopyRAST_srcTree._canvasTextOut_l2r_(const aCanvas:TCanvas; const aText:string; var aRect:tRect);
var y:integer;
begin {todo: пооптимизировать как-то надо, наверное}
    y:=aRect.Top+(aRect.Bottom-aRect.Top-aCanvas.TextHeight(aText)) div 2;
    aCanvas.TextOut(aRect.Left,y,aText);
    aRect.Left:=aCanvas.TextWidth(aText)+aRect.Left+1;
end;

end.


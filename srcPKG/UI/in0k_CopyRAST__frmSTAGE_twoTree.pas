unit in0k_CopyRAST__frmSTAGE_twoTree;

{$mode objfpc}{$H+}

interface

uses
  Classes, Controls, ExtCtrls,

  in0k_CopyRAST_srcTree_ITEMs,
  in0k_CopyRAST_srcTree_Stage,
  in0k_lazIdeSRC_srcTree_CORE_item,

  in0k_CopyRAST__frmSTAGE,
  cmpCopyRAST_srcTree;

type

 { TfrmCopyRAST_STAGE_twoTree }

 TfrmCopyRAST_STAGE_twoTree=class(tFrmCopyRAST_STAGE)
	pnlMDL:TPanel;
  protected
   _treeL_:tCmpCopyRAST_srcTree;
    function  _treeL_TYPE_:tCmpCopyRAST_srcTree_TYPE; virtual;
    procedure _treeL_SelectionChanged_(Sender:TObject);
    procedure _treeL_CRT_;
  protected
   _treeR_:tCmpCopyRAST_srcTree;
    function  _treeR_TYPE_:tCmpCopyRAST_srcTree_TYPE; virtual;
    procedure _treeR_SelectionChanged_(Sender:TObject);
    procedure _treeR_CRT_;
  protected
    procedure _onLRootChange_(const aStage:tCopyRast_SrcTree_prcSTAGE; const aRoot:tCopyRast_stROOT);
    procedure _onRRootChange_(const aStage:tCopyRast_SrcTree_prcSTAGE; const aRoot:tCopyRast_stROOT);
  protected
    procedure _editItem_SET_(const value:tSrcTree_item); virtual;
  protected
    procedure _ctrl_Enabled_SET_(const value:boolean); override;
    procedure _ctrl_eventSet_onChange_; override;
    procedure _ctrl_eventClr_onChange_; override;
  protected
    procedure _STAGE_set_(const value:tCopyRast_SrcTree_prcSTAGE); override;
  public
    constructor Create(AOwner:TComponent); override;
  end;

implementation

{$R *.lfm}

constructor TfrmCopyRAST_STAGE_twoTree.Create(AOwner:TComponent);
begin
    inherited Create(AOwner);
    //---
   _treeL_CRT_;
   _treeR_CRT_;
end;

//------------------------------------------------------------------------------

procedure TfrmCopyRAST_STAGE_twoTree._ctrl_Enabled_SET_(const value:boolean);
begin
   //_treeL_.Enabled:=value;
   //_treeR_.Enabled:=value;
end;

procedure TfrmCopyRAST_STAGE_twoTree._ctrl_eventSet_onChange_;
begin
    with _treeL_ do begin
        OnSelectionChanged:=@_treeL_SelectionChanged_;
    end;
    with _treeR_ do begin
        OnSelectionChanged:=@_treeR_SelectionChanged_;
    end;
end;

procedure TfrmCopyRAST_STAGE_twoTree._ctrl_eventClr_onChange_;
begin
    with _treeL_ do begin
        OnSelectionChanged:=nil;
    end;
    with _treeR_ do begin
        OnSelectionChanged:=nil;
    end;
end;

//------------------------------------------------------------------------------

procedure TfrmCopyRAST_STAGE_twoTree._STAGE_set_(const value:tCopyRast_SrcTree_prcSTAGE);
begin
    inherited;
    //---
    if Assigned(_STAGE_) then begin
       _STAGE_.ROOT_Source_onChange:=@_onLRootChange_;
       _STAGE_.ROOT_Target_onChange:=@_onRRootChange_;
        //---
       _treeL_.Root:=_STAGE_.ROOT_Source;
       _treeR_.Root:=_STAGE_.ROOT_Target;
        //frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_FNK:=@(_STAGE_.Template_APPLAY);
        //
       _ctrl_eventSet_onChange_;
       _ctrl_Enabled_SET_(TRUE);
    end
    else begin
       _treeL_.Root:=nil;
       _treeR_.Root:=nil;
        //frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_FNK:=nil;
        //
       _ctrl_eventClr_onChange_;
       _ctrl_Enabled_SET_(FALSE);
    end;
end;

//------------------------------------------------------------------------------

procedure TfrmCopyRAST_STAGE_twoTree._editItem_SET_(const value:tSrcTree_item);
begin

end;

//------------------------------------------------------------------------------

function TfrmCopyRAST_STAGE_twoTree._treeL_TYPE_:tCmpCopyRAST_srcTree_TYPE;
begin
    result:=tCmpCopyRAST_srcTree;
end;

procedure TfrmCopyRAST_STAGE_twoTree._treeL_CRT_;
begin
   _treeL_:=_treeL_TYPE_.Create(Self);
    with _treeL_ do begin
        Parent:=Self;
        //
        with AnchorSide[akLeft] do begin
            Control:=Self;
            Side   :=asrLeft;
        end;
        with AnchorSide[akTop] do begin
            Control:=Self;
            Side   :=asrTop;
        end;
        with AnchorSide[akRight] do begin
            Control:=pnlMDL;
            Side   :=asrLeft;
        end;
        with AnchorSide[akBottom] do begin
            Control:=pnlMDL;
            Side   :=asrBottom;
        end;
        Anchors:=[akTop, akLeft, akRight, akBottom];
        //
    end;
end;


//------------------------------------------------------------------------------

function TfrmCopyRAST_STAGE_twoTree._treeR_TYPE_:tCmpCopyRAST_srcTree_TYPE;
begin
    result:=tCmpCopyRAST_srcTree;
end;

procedure TfrmCopyRAST_STAGE_twoTree._treeR_CRT_;
begin
   _treeR_:=_treeR_TYPE_.Create(Self);
    with _treeR_ do begin
        Parent:=Self;
        //
        with AnchorSide[akLeft] do begin
            Control:=pnlMDL;
            Side   :=asrRight;
        end;
        with AnchorSide[akTop] do begin
            Control:=Self;
            Side   :=asrTop;
        end;
        with AnchorSide[akRight] do begin
            Control:=Self;
            Side   :=asrRight;
        end;
        with AnchorSide[akBottom] do begin
            Control:=pnlMDL;
            Side   :=asrBottom;
        end;
        //
        Anchors:=[akTop, akLeft, akRight, akBottom];
    end;
end;

//------------------------------------------------------------------------------

procedure TfrmCopyRAST_STAGE_twoTree._treeL_SelectionChanged_(Sender:TObject);
begin
    //if _ctrl_OnChange_LOCKED_ then EXIT;
    if csDestroying in _treeL_.ComponentState then EXIT; {todo: ДУМАТЬ: этотут НАДО?}
   _ctrl_OnChange_LOCK_(TRUE);
    //---
    if Assigned(_treeL_.SelectedITEM) then begin
       _editItem_SET_(_treeL_.SelectedITEM);
       _treeR_.Select_4Left(_treeL_.SelectedITEM);
    end
    else begin
       _editItem_SET_(NIL);
    end;
    //---
   _ctrl_OnChange_LOCK_(FALSE);
end;

procedure TfrmCopyRAST_STAGE_twoTree._treeR_SelectionChanged_(Sender:TObject);
begin
    //if _ctrl_OnChange_LOCKED_ then EXIT;
    if csDestroying in _treeR_.ComponentState then EXIT; {todo: ДУМАТЬ: этотут НАДО?}
   _ctrl_OnChange_LOCK_(TRUE);
    //---
    if Assigned(_treeR_.SelectedITEM) then begin
       _treeL_.Select_4Right(_treeR_.SelectedITEM);
       _treeL_SelectionChanged_(_treeL_);
    end
    else begin
       _editItem_SET_(NIL);
    end;
    //---
   _ctrl_OnChange_LOCK_(FALSE);
end;

//------------------------------------------------------------------------------

procedure TfrmCopyRAST_STAGE_twoTree._onLRootChange_(const aStage:tCopyRast_SrcTree_prcSTAGE; const aRoot:tCopyRast_stROOT);
begin
    if STAGE=aStage then begin
       _ctrl_OnChange_LOCK_(TRUE);
        //---
       _treeL_.Root:=aRoot;
        //---
       _ctrl_OnChange_LOCK_(FALSE);
    end;
end;

procedure TfrmCopyRAST_STAGE_twoTree._onRRootChange_(const aStage:tCopyRast_SrcTree_prcSTAGE; const aRoot:tCopyRast_stROOT);
begin
    if STAGE=aStage then begin
       _ctrl_OnChange_LOCK_(TRUE);
        //---
       _treeR_.Root:=aRoot;
        //---
       _ctrl_OnChange_LOCK_(FALSE);
    end;
end;

end.


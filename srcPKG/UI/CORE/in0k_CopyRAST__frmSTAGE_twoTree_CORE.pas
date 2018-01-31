unit in0k_CopyRAST__frmSTAGE_twoTree_CORE;

{$mode objfpc}{$H+}

interface

uses
  Classes, Controls, ExtCtrls, StdCtrls,

  in0k_CopyRAST_srcTree_ITEMs,
  in0k_CopyRAST_STAGEs_CORE,
  in0k_CopyRAST_STAGEs,
  in0k_lazIdeSRC_srcTree_CORE_item,
  lazExt_CopyRAST__xmlConfig,

  in0k_CopyRAST__frmSTAGE_CORE,
  cmpCopyRAST_srcTree;

type

 { TfrmCopyRAST_STAGE_L_R }

 TfrmCopyRAST_STAGE_L_R=class(tFrmCopyRAST_STAGE)
    Label1: TLabel;
    Label2: TLabel;
    Splitter_LR: TSplitter;
  protected
    function _SplitterLR_defPosition_:integer;
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
    procedure _onLRootChange_(const aStage:tCopyRast_STAGE; const aRoot:tCopyRast_stROOT);
    procedure _onRRootChange_(const aStage:tCopyRast_STAGE; const aRoot:tCopyRast_stROOT);
  protected
    procedure _editItem_SET_(const value:tSrcTree_item); virtual;
  protected
    procedure _ctrl_Enabled_SET_(const value:boolean); override;
    procedure _ctrl_eventSet_onChange_; override;
    procedure _ctrl_eventClr_onChange_; override;
  protected
    procedure _STAGE_onSet_(const value:tCopyRast_STAGE); override;
    procedure _STAGE_onCLR_;                              override;
  public
    constructor Create(AOwner:TComponent); override;
  public
    procedure frmSettings_LOAD(const xmlCongif:tLazExt_CopyRAST_CONFIG); override;
    procedure frmSettings_SAVE(const xmlCongif:tLazExt_CopyRAST_CONFIG); override;
  end;

implementation

{$R *.lfm}

constructor TfrmCopyRAST_STAGE_L_R.Create(AOwner:TComponent);
begin
    inherited Create(AOwner);
    //---
    Splitter_LR.Left:=_SplitterLR_defPosition_;
    //---
   _treeL_CRT_;
   _treeR_CRT_;
end;

//------------------------------------------------------------------------------

procedure TfrmCopyRAST_STAGE_L_R._ctrl_Enabled_SET_(const value:boolean);
begin
   //_treeL_.Enabled:=value;
   //_treeR_.Enabled:=value;
end;

procedure TfrmCopyRAST_STAGE_L_R._ctrl_eventSet_onChange_;
begin
    with _treeL_ do begin
        OnSelectionChanged:=@_treeL_SelectionChanged_;
    end;
    with _treeR_ do begin
        OnSelectionChanged:=@_treeR_SelectionChanged_;
    end;
end;

procedure TfrmCopyRAST_STAGE_L_R._ctrl_eventClr_onChange_;
begin
    with _treeL_ do begin
        OnSelectionChanged:=nil;
    end;
    with _treeR_ do begin
        OnSelectionChanged:=nil;
    end;
end;

//------------------------------------------------------------------------------

procedure TfrmCopyRAST_STAGE_L_R._STAGE_onCLR_;
begin
    _treeL_.Root:=nil;
    _treeR_.Root:=nil;
     //frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_FNK:=nil;
     inherited;
end;

procedure TfrmCopyRAST_STAGE_L_R._STAGE_onSet_(const value:tCopyRast_STAGE);
begin
    //inherited;
    //---
    if Assigned(_STAGE_) then
    with tCopyRast_SrcTree_STAGE_L_R(value) do begin
        RootSOURCE_onChange:=@_onLRootChange_;
        RootRESULT_onChange:=@_onRRootChange_;
        //---
       _treeL_.Root:=RootSOURCE;
       _treeR_.Root:=RootRESULT;
        //frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_FNK:=@(_STAGE_.Template_APPLAY);
        //
       _ctrl_eventSet_onChange_;
       _ctrl_Enabled_SET_(TRUE);
    end;
end;

//------------------------------------------------------------------------------

procedure TfrmCopyRAST_STAGE_L_R._editItem_SET_(const value:tSrcTree_item);
begin

end;

//------------------------------------------------------------------------------

function TfrmCopyRAST_STAGE_L_R._treeL_TYPE_:tCmpCopyRAST_srcTree_TYPE;
begin
    result:=tCmpCopyRAST_srcTree;
end;

procedure TfrmCopyRAST_STAGE_L_R._treeL_CRT_;
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
            Control:=Label1;
            Side   :=asrBottom;
        end;
        with AnchorSide[akRight] do begin
            Control:=Splitter_LR;
            Side   :=asrLeft;
        end;
        with AnchorSide[akBottom] do begin
            Control:=Splitter_LR;
            Side   :=asrBottom;
        end;
        Anchors:=[akTop, akLeft, akRight, akBottom];
        //
    end;
end;


//------------------------------------------------------------------------------

function TfrmCopyRAST_STAGE_L_R._treeR_TYPE_:tCmpCopyRAST_srcTree_TYPE;
begin
    result:=tCmpCopyRAST_srcTree;
end;

procedure TfrmCopyRAST_STAGE_L_R._treeR_CRT_;
begin
   _treeR_:=_treeR_TYPE_.Create(Self);
    with _treeR_ do begin
        Parent:=Self;
        //
        with AnchorSide[akLeft] do begin
            Control:=Splitter_LR;
            Side   :=asrRight;
        end;
        with AnchorSide[akTop] do begin
            Control:=Label2;
            Side   :=asrBottom;
        end;
        with AnchorSide[akRight] do begin
            Control:=self;
            Side   :=asrRight;
        end;
        with AnchorSide[akBottom] do begin
            Control:=Splitter_LR;
            Side   :=asrBottom;
        end;
        //
        Anchors:=[akTop, akLeft, akRight, akBottom];
    end;
end;

//------------------------------------------------------------------------------

procedure TfrmCopyRAST_STAGE_L_R._treeL_SelectionChanged_(Sender:TObject);
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

procedure TfrmCopyRAST_STAGE_L_R._treeR_SelectionChanged_(Sender:TObject);
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

procedure TfrmCopyRAST_STAGE_L_R._onLRootChange_(const aStage:tCopyRast_STAGE; const aRoot:tCopyRast_stROOT);
begin
    if STAGE=aStage then begin
       _ctrl_OnChange_LOCK_(TRUE);
        //---
       _treeL_.Root:=aRoot;
        //---
       _ctrl_OnChange_LOCK_(FALSE);
    end;
end;

procedure TfrmCopyRAST_STAGE_L_R._onRRootChange_(const aStage:tCopyRast_STAGE; const aRoot:tCopyRast_stROOT);
begin
    if STAGE=aStage then begin
       _ctrl_OnChange_LOCK_(TRUE);
        //---
       _treeR_.Root:=aRoot;
        //---
       _ctrl_OnChange_LOCK_(FALSE);
    end;
end;

//------------------------------------------------------------------------------

function TfrmCopyRAST_STAGE_L_R._SplitterLR_defPosition_:integer;
begin
    result:=(ClientWidth-Splitter_LR.Width) div 2;
end;

//------------------------------------------------------------------------------

const
 _cWndSettings_SplitterLR='Splitter_LR';
 _cWndSettings_LEFT      ='left';


procedure TfrmCopyRAST_STAGE_L_R.frmSettings_LOAD(const xmlCongif:tLazExt_CopyRAST_CONFIG);
begin
    inherited;
    Splitter_LR.Left:=xmlCongif.GetValue(lERxC_8Value(frmSettings_Section,_cWndSettings_SplitterLR,_cWndSettings_LEFT),Splitter_LR.Left);
end;

procedure TfrmCopyRAST_STAGE_L_R.frmSettings_SAVE(const xmlCongif:tLazExt_CopyRAST_CONFIG);
begin
    inherited;
    xmlCongif.SetDeleteValue(lERxC_8Value(frmSettings_Section,_cWndSettings_SplitterLR,_cWndSettings_LEFT),Splitter_LR.Left,_SplitterLR_defPosition_);
end;

end.


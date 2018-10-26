unit in0k_CopyRAST__frmSTAGE_00_CreateTree;

{$mode objfpc}{$H+}

interface

uses
  Controls, Classes,

  cmpCopyRAST_srcTree,
  in0k_CopyRAST_STAGEs_CORE,
  in0k_CopyRAST_srcTree_ITEMs,
  in0k_CopyRAST__frmSTAGE_CORE;

type

 tFrmCopyRAST__STAGE_00_CreateTree=class(tFrmCopyRAST_STAGE)
  protected
   _tree_:tCmpCopyRAST_srcTree;
    //procedure _treeL_SelectionChanged_(Sender:TObject);
    procedure _tree_CRT_;
    procedure _treeROOT_onChange_(const aStage:tCopyRast_STAGE; const aRoot:tCopyRast_stROOT);
  protected
    procedure _ctrl_Enabled_SET_(const value:boolean); override;
    procedure _ctrl_validate_;                         override;
    procedure _ctrl_eventSet_onChange_;                override;
    procedure _ctrl_eventClr_onChange_;                override;
  protected
    procedure _STAGE_onSet_(const value:tCopyRast_STAGE); override;
    procedure _STAGE_onCLR_;                              override;
  public
    constructor Create(AOwner:TComponent); override;
  end;

implementation

{$R *.lfm}

constructor tFrmCopyRAST__STAGE_00_CreateTree.Create(AOwner:TComponent);
begin
    inherited;
    //
   _tree_CRT_;
end;

//------------------------------------------------------------------------------


procedure tFrmCopyRAST__STAGE_00_CreateTree._tree_CRT_;
begin
   _tree_:=tCmpCopyRAST_srcTree.Create(Self);
    with _tree_ do begin
        Parent:=Self;
        Align:=alClient;
        //
        {*with AnchorSide[akLeft] do begin
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
        Anchors:=[akTop, akLeft, akRight, akBottom];*}
        //
    end;
end;

//------------------------------------------------------------------------------

procedure tFrmCopyRAST__STAGE_00_CreateTree._treeROOT_onChange_(const aStage:tCopyRast_STAGE; const aRoot:tCopyRast_stROOT);
begin
    if aStage=_STAGE_ then begin
       _ctrl_OnChange_LOCK_(TRUE);
       _tree_.Root:=aRoot;
       _ctrl_OnChange_LOCK_(FALSE);
    end;
end;

//------------------------------------------------------------------------------

procedure tFrmCopyRAST__STAGE_00_CreateTree._STAGE_onCLR_;
begin
   _tree_.Root:=nil;
    inherited;
end;

procedure tFrmCopyRAST__STAGE_00_CreateTree._STAGE_onSet_(const value:tCopyRast_STAGE);
begin
   _STAGE_.RootRESULT_onChange:=@_treeROOT_onChange_;
   _treeROOT_onChange_(_STAGE_,STAGE.RootRESULT);
end;

//------------------------------------------------------------------------------

procedure tFrmCopyRAST__STAGE_00_CreateTree._ctrl_Enabled_SET_(const value:boolean);
begin
   _tree_.Enabled:=value;
end;

procedure tFrmCopyRAST__STAGE_00_CreateTree._ctrl_validate_;
begin
    //
end;

procedure tFrmCopyRAST__STAGE_00_CreateTree._ctrl_eventSet_onChange_;
begin
   // _tree_.Enabled:=value;
end;

procedure tFrmCopyRAST__STAGE_00_CreateTree._ctrl_eventClr_onChange_;
begin
   //_tree_.Enabled:=value;
end;


end.


unit frmCopyRAST_srcTree_approvedFILEs2NAMEs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, CheckBoxThemed, Forms, Controls, ExtCtrls,
  StdCtrls, ComCtrls, cmpCopyRAST_srcTree_approvedFiles,
  cmpCopyRAST_srcTree_approvedNAMEs,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs;

type

 { TfrmApprovedFILEs2NAMEs }

 TfrmApprovedFILEs2NAMEs = class(TFrame)
    cntrl_nameCST: TCheckBoxThemed;
    cntrl_pathCST: TCheckBoxThemed;
    cntrl_nameNEW: TEdit;
    cntrl_pathNEW: TEdit;
    pnlMDL: TPanel;
    pnlPRP: TPanel;
    TreeView1: TTreeView;
    procedure cntrl_nameCSTClick(Sender: TObject);
    procedure cntrl_pathCSTClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure pnlPRPResize(Sender: TObject);
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);

 private
   _CNFGs4NAME_:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME;

    function  _CNFGs4NAME_validate_nameNew_(const value:string):boolean;
    function  _CNFGs4NAME_validate_pathNew_(const value:string):boolean;

    procedure _CNFGs4NAME_xxxxCST_onChange_(Sender: TObject);
    procedure _CNFGs4NAME_xxxxNEW_onChange_(Sender: TObject);

    procedure _CNFGs4NAME_frm_validate_;
    procedure _CNFGs4NAME_frm_toNullState_;
    procedure _CNFGs4NAME_frm_SetEnabled_ (const value:boolean);
    procedure _CNFGs4NAME_frm_SetOnChange_(const value:boolean);

    procedure _CNFGs4NAME_obj2frm_;
    procedure _CNFGs4NAME_frm2obj_;
 private
   _treeL_:tCmpCopyRAST_srcTree_approvedFILEs;
   _treeR_:tCmpCopyRAST_srcTree_approvedNAMEs;

    procedure _treeL_SelectionChanged_(Sender:TObject);
    procedure _treeL_Changing(Sender:TObject; Node:TTreeNode; var AllowChange:Boolean);

  private
   _HNDLR_:tCopyRastSrcTree_prcH4ReNAMEs;
    procedure _HNDLR_set_(const value:tCopyRastSrcTree_prcH4ReNAMEs);
  public
    constructor Create(AOwner:TComponent); override;
    destructor DESTROY; override;
  public
    property Handler:tCopyRastSrcTree_prcH4ReNAMEs read _HNDLR_ write _HNDLR_set_;
  end;

implementation

{$R *.lfm}


destructor TfrmApprovedFILEs2NAMEs.DESTROY;
begin
    inherited;
end;

constructor TfrmApprovedFILEs2NAMEs.Create(AOwner:TComponent);
begin
    inherited Create(AOwner);
    //---
   _treeL_:=tCmpCopyRAST_srcTree_approvedFILEs.Create(Self);
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
            Control:=pnlPRP;
            Side   :=asrTop;
        end;
        Anchors:=[akTop, akLeft, akRight, akBottom];
        //
        OnSelectionChanged:=@_treeL_SelectionChanged_;
        OnChanging:=@_treeL_Changing;
    end;
    //---
   _treeR_:=tCmpCopyRAST_srcTree_approvedNAMEs.Create(Self);
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
            Control:=pnlPRP;
            Side   :=asrTop;
        end;
        //
        Anchors:=[akTop, akLeft, akRight, akBottom];
    end;

    //---
   _CNFGs4NAME_:=NIL;
   _CNFGs4NAME_frm_toNullState_;
   _CNFGs4NAME_frm_validate_;
end;

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._HNDLR_set_(const value:tCopyRastSrcTree_prcH4ReNAMEs);
begin
   _HNDLR_:=value;
    if Assigned(_HNDLR_) then begin
       _treeL_.Root:=_HNDLR_.ROOT_old;
       _treeR_.Root:=_HNDLR_.ROOT_NEW;
    end
    else begin
       _treeL_.Root:=nil;
       _treeR_.Root:=nil;
    end;
end;

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._treeL_SelectionChanged_(Sender:TObject);
begin
    if csDestroying in _treeL_.ComponentState then EXIT;
    //---
    if Assigned(_HNDLR_) and Assigned(_treeL_.Selected) then begin
       _CNFGs4NAME_:=_HNDLR_.CNFGs4NAME_GET(_treeL_.SelectedITEM);
    end
    else begin
       _CNFGs4NAME_:=nil;
    end;
   _CNFGs4NAME_obj2frm_;
end;

procedure TfrmApprovedFILEs2NAMEs._treeL_Changing(Sender:TObject; Node:TTreeNode; var AllowChange:Boolean);
begin
    if csDestroying in _treeL_.ComponentState then EXIT;
    //---
    if Assigned(_CNFGs4NAME_) and Assigned(_treeL_.SelectedITEM) then begin
       _CNFGs4NAME_frm2obj_;
       _HNDLR_.CNFGs4NAME_SET(_treeL_.SelectedITEM,_CNFGs4NAME_);
    end;
end;

//------------------------------------------------------------------------------

function TfrmApprovedFILEs2NAMEs._CNFGs4NAME_validate_nameNew_(const value:string):boolean;
begin
    result:=trim(value)<>'';
    {todo: доделать проверку}
end;

function TfrmApprovedFILEs2NAMEs._CNFGs4NAME_validate_pathNew_(const value:string):boolean;
begin
    result:=trim(value)<>'';
    {todo: доделать проверку}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TfrmApprovedFILEs2NAMEs._CNFGs4NAME_frm_toNullState_;
begin
    cntrl_nameNEW.text:='';
    cntrl_nameCST.Checked:=false;
    cntrl_pathNEW.text:='';
    cntrl_pathCST.Checked:=false;
end;

procedure TfrmApprovedFILEs2NAMEs._CNFGs4NAME_frm_SetEnabled_ (const value:boolean);
begin
    cntrl_nameCST.Enabled:=value;
    cntrl_pathCST.Enabled:=value;
    cntrl_nameNEW.Enabled:=value;
    cntrl_pathNEW.Enabled:=value;
end;

procedure TfrmApprovedFILEs2NAMEs._CNFGs4NAME_frm_SetOnChange_(const value:boolean);
begin
    if value then begin
        cntrl_nameCST.OnChange:=@_CNFGs4NAME_xxxxCST_onChange_;
        cntrl_pathCST.OnChange:=@_CNFGs4NAME_xxxxCST_onChange_;
        cntrl_nameNEW.OnChange:=@_CNFGs4NAME_xxxxNEW_onChange_;
        cntrl_pathNEW.OnChange:=@_CNFGs4NAME_xxxxNEW_onChange_;
    end
    else begin
        cntrl_nameCST.OnChange:=nil;
        cntrl_pathCST.OnChange:=nil;
        cntrl_nameNEW.OnChange:=nil;
        cntrl_pathNEW.OnChange:=nil;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TfrmApprovedFILEs2NAMEs._CNFGs4NAME_obj2frm_;
begin
   _CNFGs4NAME_frm_SetOnChange_(false);
   _CNFGs4NAME_frm_toNullState_;
    //---
    if Assigned(_CNFGs4NAME_) then begin
        //
        cntrl_nameNEW.Text   :=_CNFGs4NAME_.nameNew;
        cntrl_nameCST.Checked:=_CNFGs4NAME_.nameCst;
        cntrl_pathNEW.Text   :=_CNFGs4NAME_.pathNew;
        cntrl_pathCST.Checked:=_CNFGs4NAME_.pathCst;
        //
       _CNFGs4NAME_frm_validate_;
       _CNFGs4NAME_frm_SetOnChange_(true);
     end;
end;

procedure TfrmApprovedFILEs2NAMEs._CNFGs4NAME_frm2obj_;
begin
    _CNFGs4NAME_.nameNew := cntrl_nameNEW.Text;
    _CNFGs4NAME_.nameCst := cntrl_nameCST.Checked;
    _CNFGs4NAME_.pathNew := cntrl_pathNEW.Text;
    _CNFGs4NAME_.pathCst := cntrl_pathCST.Checked;
end;

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._CNFGs4NAME_frm_validate_;
var isValid:boolean;
begin
    case cntrl_nameCST.State of
      cbUnchecked:cntrl_nameNEW.Enabled:=false;
      cbChecked  :cntrl_nameNEW.Enabled:=true;
      cbGrayed   :cntrl_nameNEW.Enabled:=true;
    end;
    isValid:=_CNFGs4NAME_validate_nameNew_(cntrl_nameNEW.Text);
    case cntrl_nameCST.State of
      cbChecked  :if not isValid then cntrl_nameCST.State:=cbGrayed;
      cbGrayed   :if isValid then begin
                      cntrl_nameCST.Tag  :=0;
                      cntrl_nameCST.State:=cbChecked;
                  end;
    end;
    //
    case cntrl_pathCST.State of
      cbUnchecked:cntrl_pathNEW.Enabled:=false;
      cbChecked  :cntrl_pathNEW.Enabled:=true;
      cbGrayed   :cntrl_pathNEW.Enabled:=true;
    end;
    isValid:=_CNFGs4NAME_validate_pathNew_(cntrl_pathNEW.Text);
    case cntrl_pathCST.State of
      cbChecked  :if not isValid then cntrl_pathCST.State:=cbGrayed;
      cbGrayed   :if isValid then begin
                      cntrl_pathCST.Tag  :=0;
                      cntrl_pathCST.State:=cbChecked;
                  end;
    end;
end;

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._CNFGs4NAME_xxxxCST_onChange_(Sender: TObject);
begin
    if TCheckBoxThemed(Sender).Tag=1 then begin
        TCheckBoxThemed(Sender).Tag:=0;
        TCheckBoxThemed(Sender).Checked:=false;
    end
    else begin
       _CNFGs4NAME_frm_validate_;
        if TCheckBoxThemed(Sender).State=cbGrayed then begin
            TCheckBoxThemed(Sender).Tag:=1;
        end
        else begin
            TCheckBoxThemed(Sender).Tag:=0;
        end;
    end;
end;

procedure TfrmApprovedFILEs2NAMEs.cntrl_nameCSTClick(Sender: TObject);
begin
    case tCheckBoxThemed(Sender).State of
      cbUnchecked: ;
      cbChecked,
      cbGrayed   : if cntrl_nameNEW.Enabled then cntrl_nameNEW.SetFocus;
    end;
end;

procedure TfrmApprovedFILEs2NAMEs.cntrl_pathCSTClick(Sender: TObject);
begin
    case tCheckBoxThemed(Sender).State of
      cbUnchecked: ;
      cbChecked,
      cbGrayed   : if cntrl_pathNEW.Enabled then cntrl_pathNEW.SetFocus;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TfrmApprovedFILEs2NAMEs._CNFGs4NAME_xxxxNEW_onChange_(Sender: TObject);
begin
    _CNFGs4NAME_frm_validate_;
end;




//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs.FrameResize(Sender: TObject);
begin
    pnlMDL.Left:=(TFrame(Sender).Width-pnlMDL.Width) div 2;
end;



procedure TfrmApprovedFILEs2NAMEs.pnlPRPResize(Sender: TObject);
var w:integer;
begin
    w:=0;
    if w<cntrl_nameCST.Width then w:=cntrl_nameCST.Width;
    if w<cntrl_pathCST.Width then w:=cntrl_pathCST.Width;
    cntrl_nameNEW.Left:=w+2;
end;

procedure TfrmApprovedFILEs2NAMEs.TreeView1Changing(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin

end;




end.


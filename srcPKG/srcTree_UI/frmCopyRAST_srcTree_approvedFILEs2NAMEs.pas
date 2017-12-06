unit frmCopyRAST_srcTree_approvedFILEs2NAMEs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, CheckBoxThemed, Forms, Controls, ExtCtrls,
  StdCtrls, ComCtrls, cmpCopyRAST_srcTree_approvedFiles,

  in0k_lazIdeSRC_srcTree_CORE_item,

  cmpCopyRAST_srcTree_nameTemplates,
  cmpCopyRAST_srcTree_approvedNAMEs,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs;

type

 { TfrmApprovedFILEs2NAMEs }

 TfrmApprovedFILEs2NAMEs = class(TFrame)
    cntrl_nameCST: TCheckBoxThemed;
    cntrl_pathCST: TCheckBoxThemed;
    cntrl_nameStated: TEdit;
    cntrl_pathStated: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    pnlPRP_1: TPanel;
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
   _editItem_:tSrcTree_item;
    procedure _editItem_SET_(const value:tSrcTree_item);
    procedure _editItem_onCHG_;
 private
   _customer_node_:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
    procedure _customer_node_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
 private
    function  _CNFGs4NAME_validate_nameNew_(const value:string):boolean;
    function  _CNFGs4NAME_validate_pathNew_(const value:string):boolean;

    procedure _CNFGs4NAME_xxxxCST_onChange_(Sender: TObject);
    procedure _CNFGs4NAME_xxxxNEW_onChange_(Sender: TObject);

    procedure _CNFGs4NAME_frm_validate_;
    procedure _CNFGs4NAME_frm_toNullState_;
    procedure _CNFGs4NAME_frm_SetEnabled_ (const value:boolean);
    procedure _CNFGs4NAME_frm_SetOnChange_(const value:boolean);

    procedure _customer_node_obj2frm_;
    procedure _customer_node_frm2obj_;
 private
   _treeL_:tCmpCopyRAST_srcTree_approvedFILEs;
   _treeR_:tCmpCopyRAST_srcTree_approvedNAMEs;

    procedure _treeL_SelectionChanged_(Sender:TObject);
    procedure _treeL_Changing(Sender:TObject; Node:TTreeNode; var AllowChange:Boolean);

  private
   _HNDLR_:tCopyRastSrcTree_prcH4ReNAMEs;
    procedure _HNDLR_set_(const value:tCopyRastSrcTree_prcH4ReNAMEs);

  private
   _tmplt_:tCmpCopyRAST_srcTree_nameTemplates;

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
   _customer_node_:=NIL;
   _CNFGs4NAME_frm_toNullState_;
   _CNFGs4NAME_frm_validate_;

    //----------------

   _tmplt_:=tCmpCopyRAST_srcTree_nameTemplates.Create(self);
    with _tmplt_ do begin
        Parent:=pnlPRP;
        //
        with AnchorSide[akLeft] do begin
            Control:=pnlPRP;
            Side   :=asrLeft;
        end;
        with AnchorSide[akTop] do begin
            Control:=cntrl_pathStated;
            Side   :=asrBottom;
        end;
        with AnchorSide[akRight] do begin
            Control:=pnlPRP_1;
            Side   :=asrLeft;
        end;
        with AnchorSide[akBottom] do begin
            Control:=pnlPRP;
            Side   :=asrBottom;
        end;
        //
        Anchors:=[akTop, akLeft, akRight, akBottom];
    end;

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

procedure TfrmApprovedFILEs2NAMEs._editItem_SET_(const value:tSrcTree_item);
begin
    if Assigned(value) then begin
       _editItem_:=value;
       _customer_node_SET_(_HNDLR_.CNFG_customer_GET(_editItem_));
    end
    else begin
       _editItem_:=nil;
       _customer_node_SET_(nil);
    end;
end;

procedure TfrmApprovedFILEs2NAMEs._editItem_onCHG_;
begin
    if Assigned(_editItem_) then begin
        if Assigned(_customer_node_) then begin
           _customer_node_frm2obj_;
           _HNDLR_.CNFG_customer_SET(_editItem_,_customer_node_);
        end;
    end;
end;


{procedure TfrmApprovedFILEs2NAMEs._itemEditor_Lock_(const value:boolean);
begin
    if value then _CNFGs4NAME_frm_toNullState_;
   _CNFGs4NAME_frm_SetOnChange_(not value);
   _CNFGs4NAME_frm_SetEnabled_ (not value);
end;}

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._treeL_SelectionChanged_(Sender:TObject);
begin
    if csDestroying in _treeL_.ComponentState then EXIT;
    //---
    if Assigned(_treeL_.SelectedITEM) then begin
       _editItem_SET_(_treeL_.SelectedITEM);
    end
    else begin
       _editItem_SET_(NIL);
    end;
    (*


    if csDestroying in _treeL_.ComponentState then EXIT;
    //---
    if Assigned(_HNDLR_) and Assigned(_treeL_.Selected) then begin
       _customer_node_:=_HNDLR_.CNFGs4NAME_GET(_treeL_.SelectedITEM);
    end
    else begin
       _customer_node_:=nil;
    end;
   _CNFGs4NAME_obj2frm_;*)
end;

procedure TfrmApprovedFILEs2NAMEs._treeL_Changing(Sender:TObject; Node:TTreeNode; var AllowChange:Boolean);
begin
    {if csDestroying in _treeL_.ComponentState then EXIT;
    //---
    if Assigned(_treeL_.SelectedITEM) then begin
       _editItem_SET_(_treeL_.SelectedITEM);
    end
    else begin
       _editItem_SET_(NIL);
    end;}
    {
    if Assigned(_customer_node_) and Assigned(_treeL_.SelectedITEM) then begin
       _CNFGs4NAME_frm2obj_;
       _HNDLR_.CNFG_customer_SET(_treeL_.SelectedITEM,_customer_node_);
    end;
    }
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
    cntrl_nameStated.text:='';
    cntrl_nameCST.Checked:=false;
    cntrl_pathStated.text:='';
    cntrl_pathCST.Checked:=false;
end;

procedure TfrmApprovedFILEs2NAMEs._CNFGs4NAME_frm_SetEnabled_ (const value:boolean);
begin
    cntrl_nameCST.Enabled:=value;
    cntrl_pathCST.Enabled:=value;
    cntrl_nameStated.Enabled:=value;
    cntrl_pathStated.Enabled:=value;
end;

procedure TfrmApprovedFILEs2NAMEs._CNFGs4NAME_frm_SetOnChange_(const value:boolean);
begin
    if value then begin
        cntrl_nameCST.OnChange:=@_CNFGs4NAME_xxxxCST_onChange_;
        cntrl_pathCST.OnChange:=@_CNFGs4NAME_xxxxCST_onChange_;
        cntrl_nameStated.OnChange:=@_CNFGs4NAME_xxxxNEW_onChange_;
        cntrl_pathStated.OnChange:=@_CNFGs4NAME_xxxxNEW_onChange_;
    end
    else begin
        cntrl_nameCST.OnChange:=nil;
        cntrl_pathCST.OnChange:=nil;
        cntrl_nameStated.OnChange:=nil;
        cntrl_pathStated.OnChange:=nil;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TfrmApprovedFILEs2NAMEs._customer_node_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
begin
   _customer_node_.Free;
   _customer_node_:=value;
   _customer_node_obj2frm_;
end;

procedure TfrmApprovedFILEs2NAMEs._customer_node_obj2frm_;
begin
   _CNFGs4NAME_frm_SetOnChange_(false);
   _CNFGs4NAME_frm_toNullState_;
    //---
    if Assigned(_customer_node_) then begin
        //
        cntrl_nameStated.Text:=_customer_node_.NameStated;
        cntrl_nameCST.Checked:=_customer_node_.NameCustom;
        cntrl_pathStated.Text:=_customer_node_.PathStated;
        cntrl_pathCST.Checked:=_customer_node_.PathCustom;
        //
       _CNFGs4NAME_frm_validate_;
       _CNFGs4NAME_frm_SetOnChange_(true);
     end;
end;

procedure TfrmApprovedFILEs2NAMEs._customer_node_frm2obj_;
begin
    _customer_node_.NameStated:=cntrl_nameStated.Text;
    _customer_node_.NameCustom:=cntrl_nameCST.Checked;
    _customer_node_.PathStated:=cntrl_pathStated.Text;
    _customer_node_.PathCustom:=cntrl_pathCST.Checked;
end;

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._CNFGs4NAME_frm_validate_;
var isValid:boolean;
begin
    case cntrl_nameCST.State of
      cbUnchecked:cntrl_nameStated.Enabled:=false;
      cbChecked  :cntrl_nameStated.Enabled:=true;
      cbGrayed   :cntrl_nameStated.Enabled:=true;
    end;
    isValid:=_CNFGs4NAME_validate_nameNew_(cntrl_nameStated.Text);
    case cntrl_nameCST.State of
      cbChecked  :if not isValid then cntrl_nameCST.State:=cbGrayed;
      cbGrayed   :if isValid then begin
                      cntrl_nameCST.Tag  :=0;
                      cntrl_nameCST.State:=cbChecked;
                  end;
    end;
    //
    case cntrl_pathCST.State of
      cbUnchecked:cntrl_pathStated.Enabled:=false;
      cbChecked  :cntrl_pathStated.Enabled:=true;
      cbGrayed   :cntrl_pathStated.Enabled:=true;
    end;
    isValid:=_CNFGs4NAME_validate_pathNew_(cntrl_pathStated.Text);
    case cntrl_pathCST.State of
      cbChecked  :if not isValid then cntrl_pathCST.State:=cbGrayed;
      cbGrayed   :if isValid then begin
                      cntrl_pathCST.Tag  :=0;
                      cntrl_pathCST.State:=cbChecked;
                  end;
    end;
   _editItem_onCHG_;
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
    if not tCheckBoxThemed(sender).Focused then EXIT;
    case tCheckBoxThemed(Sender).State of
      cbUnchecked: ;
      cbChecked,
      cbGrayed   : if cntrl_nameStated.Enabled then cntrl_nameStated.SetFocus;
    end;
end;

procedure TfrmApprovedFILEs2NAMEs.cntrl_pathCSTClick(Sender: TObject);
begin
    if not tCheckBoxThemed(sender).Focused then EXIT;
    case tCheckBoxThemed(Sender).State of
      cbUnchecked: ;
      cbChecked,
      cbGrayed   : if cntrl_pathStated.Enabled then cntrl_pathStated.SetFocus;
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
    cntrl_nameStated.Left:=w+2;
end;

procedure TfrmApprovedFILEs2NAMEs.TreeView1Changing(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin

end;




end.


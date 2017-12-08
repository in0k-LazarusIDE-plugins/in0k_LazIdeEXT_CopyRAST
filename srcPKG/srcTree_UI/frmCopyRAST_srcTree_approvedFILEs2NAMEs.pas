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
     Button1: TButton;
     Button2: TButton;
    cntrl_nameCST: TCheckBoxThemed;
    cntrl_pathCST: TCheckBoxThemed;
    cntrl_nameStated: TEdit;
    cntrl_pathStated: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    pnlPRP_1: TPanel;
    pnlMDL: TPanel;
    pnlPRP: TPanel;
    Splitter1: TSplitter;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure pnlPRPResize(Sender: TObject);
 private
   _cnfg_template_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
    procedure _cnfg_template_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);

  private
   _editItem_:tSrcTree_item;
    procedure _editItem_SET_(const value:tSrcTree_item);
    procedure _editItem_onCHG_customer;
    procedure _editItem_onCHG_template;



  private
   _ctrl_customer_lockOnChange_Counter_:integer;
    procedure _ctrl_customer_enabled_SET_ (const value:boolean);
    procedure _ctrl_customer_OnChange_SET_(const value:boolean);
    procedure _ctrl_customer_OnChange_setLock_(const value:boolean);
    function  _ctrl_customer_OnChange_LOCKED_:boolean;
  private // события для контролов
    procedure _ctrl_customer_xxxxNEW_onChange_(Sender: TObject);
    procedure _ctrl_customer_xxxxCST_onChange_(Sender: TObject);
    procedure _ctrl_customer_nameCST_onClick_ (Sender: TObject);
    procedure _ctrl_customer_pathCST_onClick_ (Sender: TObject);
  private // проверки на вшивость
    function  _cnfg_customer_ctrl_validate_NAME_(const value:string):boolean;
    function  _cnfg_customer_ctrl_validate_PATH_(const value:string):boolean;
    procedure _cnfg_customer_ctrl_validate_;
  private // копирвание инфы
    procedure _cnfg_customer_nil2ctrl_;
    procedure _cnfg_customer_obj2ctrl_;
    procedure _cnfg_customer_ctrl2obj_;
  private // сама настройка, с которой работаем
   _cnfg_customer_:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
    procedure _cnfg_customer_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);









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
   _cnfg_customer_.FREE;
   _cnfg_template_.FREE;
end;

constructor TfrmApprovedFILEs2NAMEs.Create(AOwner:TComponent);
begin
   _cnfg_customer_:=NIL;
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
   //_cnfg_customer_null2frm;
   //_cnfg_customer_ctrl_validate_;

   _cnfg_template_:=NIL;

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
            Control:=Panel1;
            Side   :=asrTop;
        end;
        with AnchorSide[akRight] do begin
            Control:=Splitter1;
            Side   :=asrLeft;
        end;
        with AnchorSide[akBottom] do begin
            Control:=pnlPRP;
            Side   :=asrBottom;
        end;
        //
        Anchors:=[akTop, akLeft, akRight, akBottom];
    end;

   _cnfg_customer_SET_(nil);

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
       _cnfg_customer_SET_(_HNDLR_.CNFG_customer_GET(_editItem_));
       _cnfg_template_SET_(_HNDLR_.CNFG_template_GET(_editItem_));
    end
    else begin
       _editItem_        :=nil ;
       _cnfg_customer_SET_(nil);
       _cnfg_customer_SET_(nil);
    end;
end;

procedure TfrmApprovedFILEs2NAMEs._editItem_onCHG_customer;
begin
    if Assigned(_editItem_) then begin
        if Assigned(_cnfg_customer_) then begin
            _cnfg_customer_ctrl2obj_;
            _HNDLR_.CNFG_customer_SET(_editItem_,_cnfg_customer_);
        end;
    end;
end;

procedure TfrmApprovedFILEs2NAMEs._editItem_onCHG_template;
begin
    if Assigned(_editItem_) then begin
        if Assigned(_cnfg_template_) then begin
           _HNDLR_.CNFG_template_SET(_editItem_,_cnfg_template_);
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
    if csDestroying in _treeL_.ComponentState then EXIT; {todo: ДУМАТЬ: этотут НАДО?}
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

{%region --- ..customer..------------------------------------------------}

procedure TfrmApprovedFILEs2NAMEs._ctrl_customer_enabled_SET_(const value:boolean);
begin
    if value then begin
        cntrl_nameCST.Enabled   :=true;
        cntrl_pathCST.Enabled   :=true;
        // ниже написаное НЕ надо делать, оно в _cnfg_customer_ctrl_validate_
        //cntrl_nameStated.Enabled:=value;
        //cntrl_pathStated.Enabled:=value;
    end
    else begin
        cntrl_nameStated.Enabled:=false;
        cntrl_pathStated.Enabled:=false;
        cntrl_nameCST.Enabled   :=false;
        cntrl_pathCST.Enabled   :=false;
    end;
end;

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._ctrl_customer_OnChange_setLock_(const value:boolean);
begin
    if value
    then inc(_ctrl_customer_lockOnChange_Counter_)
    else dec(_ctrl_customer_lockOnChange_Counter_);
    //---
   _ctrl_customer_OnChange_SET_(_ctrl_customer_lockOnChange_Counter_=0);
end;

function TfrmApprovedFILEs2NAMEs._ctrl_customer_OnChange_LockED_:boolean;
begin
    result:=_ctrl_customer_lockOnChange_Counter_<>0;
end;

procedure TfrmApprovedFILEs2NAMEs._ctrl_customer_OnChange_SET_(const value:boolean);
begin
    if value then begin
        cntrl_nameCST.OnChange   :=@_ctrl_customer_xxxxCST_onChange_;
        cntrl_nameCST.OnClick    :=@_ctrl_customer_nameCST_onClick_;
        cntrl_pathCST.OnChange   :=@_ctrl_customer_xxxxCST_onChange_;
        cntrl_pathCST.OnClick    :=@_ctrl_customer_pathCST_onClick_;
        cntrl_nameStated.OnChange:=@_ctrl_customer_xxxxNEW_onChange_;
        cntrl_pathStated.OnChange:=@_ctrl_customer_xxxxNEW_onChange_;
    end
    else begin
        cntrl_nameCST.OnChange:=nil;
        cntrl_nameCST.OnClick :=nil;
        cntrl_pathCST.OnChange:=nil;
        cntrl_pathCST.OnClick :=nil;
        cntrl_nameStated.OnChange:=nil;
        cntrl_pathStated.OnChange:=nil;
    end;
end;

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._ctrl_customer_xxxxNEW_onChange_(Sender: TObject);
begin
    if _ctrl_customer_OnChange_LOCKED_ then exit;
   _ctrl_customer_OnChange_setLock_(true);
    //---
   _cnfg_customer_ctrl_validate_;
    //---
   _ctrl_customer_OnChange_setLock_(false);
   _editItem_onCHG_customer;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TfrmApprovedFILEs2NAMEs._ctrl_customer_xxxxCST_onChange_(Sender: TObject);
begin
    if _ctrl_customer_OnChange_LOCKED_ then exit;
   _ctrl_customer_OnChange_setLock_(true);
    //---
    if TCheckBoxThemed(Sender).Tag=1 then begin
        TCheckBoxThemed(Sender).Tag:=0;
        TCheckBoxThemed(Sender).Checked:=false;
       _cnfg_customer_ctrl_validate_;
    end
    else begin
       _cnfg_customer_ctrl_validate_;
        if TCheckBoxThemed(Sender).State=cbGrayed then begin
            TCheckBoxThemed(Sender).Tag:=1;
        end
        else begin
            TCheckBoxThemed(Sender).Tag:=0;
        end;
    end;
    //---
   _ctrl_customer_OnChange_setLock_(false);
   _editItem_onCHG_customer;
end;

procedure TfrmApprovedFILEs2NAMEs._ctrl_customer_nameCST_onClick_(Sender: TObject);
begin
    if _ctrl_customer_OnChange_LOCKED_ then exit;
   _ctrl_customer_OnChange_setLock_(true);
    //---
    case tCheckBoxThemed(Sender).State of
      cbUnchecked: ;
      cbChecked,
      cbGrayed   : if cntrl_nameStated.Enabled then cntrl_nameStated.SetFocus;
    end;
    //---
   _ctrl_customer_OnChange_setLock_(false);
end;

procedure TfrmApprovedFILEs2NAMEs._ctrl_customer_pathCST_onClick_(Sender: TObject);
begin
    if _ctrl_customer_OnChange_LOCKED_ then exit;
   _ctrl_customer_OnChange_setLock_(true);
    //---
    case tCheckBoxThemed(Sender).State of
      cbUnchecked: ;
      cbChecked,
      cbGrayed   : if cntrl_pathStated.Enabled then cntrl_pathStated.SetFocus;
    end;
    //---
   _ctrl_customer_OnChange_setLock_(false);
end;

//-----------------------------------------------------------------[ validate ]-

function TfrmApprovedFILEs2NAMEs._cnfg_customer_ctrl_validate_NAME_(const value:string):boolean;
begin
    result:=trim(value)<>'';
    {todo: доделать проверку}
end;

function TfrmApprovedFILEs2NAMEs._cnfg_customer_ctrl_validate_PATH_(const value:string):boolean;
begin
    result:=trim(value)<>'';
    {todo: доделать проверку}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TfrmApprovedFILEs2NAMEs._cnfg_customer_ctrl_validate_;
var isValid:boolean;
begin
    case cntrl_nameCST.State of
      cbUnchecked:cntrl_nameStated.Enabled:=false;
      cbChecked  :cntrl_nameStated.Enabled:=true;
      cbGrayed   :cntrl_nameStated.Enabled:=true;
    end;
    isValid:=_cnfg_customer_ctrl_validate_NAME_(cntrl_nameStated.Text);
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
    isValid:=_cnfg_customer_ctrl_validate_PATH_(cntrl_pathStated.Text);
    case cntrl_pathCST.State of
      cbChecked  :if not isValid then cntrl_pathCST.State:=cbGrayed;
      cbGrayed   :if isValid then begin
                      cntrl_pathCST.Tag  :=0;
                      cntrl_pathCST.State:=cbChecked;
                  end;
    end;
end;

//-----------------------------------------------------------------[ dataCopy ]-

procedure TfrmApprovedFILEs2NAMEs._cnfg_customer_nil2ctrl_;
begin
    cntrl_nameStated.text:='';
    cntrl_nameCST.Checked:=false;
    cntrl_pathStated.text:='';
    cntrl_pathCST.Checked:=false;
end;

procedure TfrmApprovedFILEs2NAMEs._cnfg_customer_ctrl2obj_;
begin
    if not Assigned(_cnfg_customer_) then EXIT;
   _cnfg_customer_.NameStated:=cntrl_nameStated.Text;
   _cnfg_customer_.NameCustom:=cntrl_nameCST.Checked;
   _cnfg_customer_.PathStated:=cntrl_pathStated.Text;
   _cnfg_customer_.PathCustom:=cntrl_pathCST.Checked;
end;

procedure TfrmApprovedFILEs2NAMEs._cnfg_customer_obj2ctrl_;
begin
    if not Assigned(_cnfg_customer_) then EXIT;
    cntrl_nameStated.Text:=_cnfg_customer_.NameStated;
    cntrl_nameCST.Checked:=_cnfg_customer_.NameCustom;
    cntrl_nameCST.Tag    :=0;
    cntrl_pathStated.Text:=_cnfg_customer_.PathStated;
    cntrl_pathCST.Checked:=_cnfg_customer_.PathCustom;
    cntrl_pathCST.Tag    :=0;
end;

{%endregion}

procedure TfrmApprovedFILEs2NAMEs._cnfg_customer_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
begin
   _cnfg_customer_.Free;
   _cnfg_customer_:=value;
    //
   _ctrl_customer_lockOnChange_Counter_:=0;
   _ctrl_customer_OnChange_setLock_ (TRUE);
    //
    if Assigned(_cnfg_customer_) then begin
       _cnfg_customer_obj2ctrl_;
       _ctrl_customer_enabled_SET_(true);
       _cnfg_customer_ctrl_validate_;
    end
    else begin
       _cnfg_customer_nil2ctrl_;
       _ctrl_customer_enabled_SET_(false);
    end;
    //
   _ctrl_customer_OnChange_setLock_(false);
end;

//------------------------------------------------------------------------------

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TfrmApprovedFILEs2NAMEs._cnfg_template_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
var i:integer;
begin
   _cnfg_template_.Free;
   _cnfg_template_:=value;
    //_cnfg_customer_obj2ctrl_;
   _tmplt_.Templates:=_cnfg_template_;
end;





procedure TfrmApprovedFILEs2NAMEs.FrameResize(Sender: TObject);
begin
    pnlMDL.Left:=(TFrame(Sender).Width-pnlMDL.Width) div 2;
end;

procedure TfrmApprovedFILEs2NAMEs.Button1Click(Sender: TObject);
begin
   _tmplt_.SendToBack;
   _tmplt_.Anchors:=_tmplt_.Anchors-[akRight];
end;

procedure TfrmApprovedFILEs2NAMEs.Button2Click(Sender: TObject);
begin
    Splitter1.Left:=_tmplt_.Width+_tmplt_.Left;
   _tmplt_.Anchors:=_tmplt_.Anchors+[akRight];
end;

procedure TfrmApprovedFILEs2NAMEs.pnlPRPResize(Sender: TObject);
var w:integer;
begin
    w:=0;
    if w<cntrl_nameCST.Width then w:=cntrl_nameCST.Width;
    if w<cntrl_pathCST.Width then w:=cntrl_pathCST.Width;
    cntrl_nameStated.Left:=w+2;
end;

end.


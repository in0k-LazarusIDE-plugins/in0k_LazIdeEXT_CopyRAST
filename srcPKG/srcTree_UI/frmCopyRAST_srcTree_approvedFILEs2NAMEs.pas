unit frmCopyRAST_srcTree_approvedFILEs2NAMEs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, CheckBoxThemed, Forms, Controls, ExtCtrls,
  StdCtrls, ComCtrls,



  frmCopyRAST_EDIT,

  cmpCopyRAST_srcTree_approvedFiles,
  in0k_lazIdeSRC_srcTree_CORE_item,

  frmCopyRAST_CnfgItem_EDIT,

  cmpCopyRAST_srcTree_nameTemplates,
  cmpCopyRAST_srcTree_approvedNAMEs,
  frmCopyRAST_cie_ReNames_customer, frmCopyRAST_cie_ReNames_template,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs;

type

 { TfrmApprovedFILEs2NAMEs }

 TfrmApprovedFILEs2NAMEs = class(tFrmCopyRastEDIT)
    frmCopyRAST_cie_ReNamesCustomer1: TfrmCopyRAST_cie_ReNamesCustomer;
    frmCopyRAST_cie_ReNamesTemplate1: TfrmCopyRAST_cie_ReNamesTemplate;
    pnlMDL: TPanel;
    pnlPRP: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  protected
    procedure _ctrl_Enabled_SET_(const value:boolean); override;
    //procedure _ctrl_validate_;                         virtual; {$ifOpt D-}abstract;{$endIf}
    procedure _ctrl_eventSet_onChange_; override;
    procedure _ctrl_eventClr_onChange_; override;
  private
   _cnfg_template_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
    procedure _cnfg_template_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
  private
   _editItem_:tSrcTree_item;
    procedure _editItem_SET_(const value:tSrcTree_item);
  private
    procedure _onChange_customer_(const Sender:tObject; const itemCnfg:pointer);
    procedure _onChange_template_(const Sender:tObject; const itemCnfg:pointer);
  private
   _treeL_:tCmpCopyRAST_srcTree_approvedFILEs;
    procedure _treeL_SelectionChanged_(Sender:TObject);
  private
   _treeR_:tCmpCopyRAST_srcTree_approvedNAMEs;
    procedure _treeR_SelectionChanged_(Sender:TObject);
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
   _cnfg_template_.FREE;
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




    //---
    frmCopyRAST_cie_ReNamesCustomer1.ItemCNFG_OnChange:=@_onChange_customer_;
    frmCopyRAST_cie_ReNamesTemplate1.ItemCNFG_OnChange:=@_onChange_template_;
    frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_FNK:=NIL;
end;

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._ctrl_Enabled_SET_(const value:boolean);
begin
    //
end;

procedure TfrmApprovedFILEs2NAMEs._ctrl_eventSet_onChange_;
begin
    //
    with _treeL_ do begin
        OnSelectionChanged:=@_treeL_SelectionChanged_;
    end;
    with _treeR_ do begin
        OnSelectionChanged:=@_treeR_SelectionChanged_;
    end;
end;

procedure TfrmApprovedFILEs2NAMEs._ctrl_eventClr_onChange_;
begin
    //
    with _treeL_ do begin
        OnSelectionChanged:=nil;
    end;
    with _treeR_ do begin
        OnSelectionChanged:=nil;
    end;
end;

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._HNDLR_set_(const value:tCopyRastSrcTree_prcH4ReNAMEs);
begin
   _HNDLR_:=value;
    if Assigned(_HNDLR_) then begin
       _treeL_.Root:=_HNDLR_.ROOT_Source;
       _treeR_.Root:=_HNDLR_.ROOT_Target;
        frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_FNK:=@(_HNDLR_.Template_APPLAY);
        _ctrl_eventSet_onChange_;
    end
    else begin
       _treeL_.Root:=nil;
       _treeR_.Root:=nil;
        frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_FNK:=nil;
        //
       _ctrl_eventClr_onChange_;
    end;
end;

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._editItem_SET_(const value:tSrcTree_item);
begin
    if Assigned(value) then begin
       _editItem_:=value;
        frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_ITM:=nil;
        frmCopyRAST_cie_ReNamesCustomer1.ItemCNFG:=_HNDLR_.CNFG_customer_GET(_editItem_);
        frmCopyRAST_cie_ReNamesTemplate1.ItemCNFG:=_HNDLR_.CNFG_template_GET(_editItem_);
        frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_ITM:=_editItem_;
    end
    else begin
       _editItem_        :=nil ;
        frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_ITM:=nil;
        frmCopyRAST_cie_ReNamesCustomer1.ItemCNFG:=nil;
        frmCopyRAST_cie_ReNamesTemplate1.ItemCNFG:=nil;
       _cnfg_template_SET_(nil);
    end;
end;

procedure TfrmApprovedFILEs2NAMEs._onChange_customer_(const Sender:tObject; const itemCnfg:pointer);
begin
    if Assigned(_editItem_) then begin
       _HNDLR_.CNFG_customer_SET(_editItem_,tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(itemCnfg));
    end;
end;

procedure TfrmApprovedFILEs2NAMEs._onChange_template_(const Sender:tObject; const itemCnfg:pointer);
begin
    if Assigned(_editItem_) then begin
       _HNDLR_.CNFG_template_SET(_editItem_,tCopyRAST_HandlerCNFGs_ReNAMEs_template_List(itemCnfg));
    end;
end;

{procedure TfrmApprovedFILEs2NAMEs._editItem_onCHG_template;
begin
    {if Assigned(_editItem_) then begin
        if Assigned(_cnfg_template_) then begin
           _HNDLR_.CNFG_template_SET(_editItem_,_cnfg_template_);
        end;
    end;}
end;}



{procedure TfrmApprovedFILEs2NAMEs._itemEditor_Lock_(const value:boolean);
begin
    if value then _CNFGs4NAME_frm_toNullState_;
   _CNFGs4NAME_frm_SetOnChange_(not value);
   _CNFGs4NAME_frm_SetEnabled_ (not value);
end;}

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._treeL_SelectionChanged_(Sender:TObject);
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

procedure TfrmApprovedFILEs2NAMEs._treeR_SelectionChanged_(Sender:TObject);
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



//------------------------------------------------------------------------------

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TfrmApprovedFILEs2NAMEs._cnfg_template_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
var i:integer;
begin
   _cnfg_template_.Free;
   _cnfg_template_:=value;
    //_cnfg_customer_obj2ctrl_;
  // _tmplt_.Templates:=_cnfg_template_;
end;

procedure TfrmApprovedFILEs2NAMEs.Button1Click(Sender: TObject);
begin
   //_tmplt_.SendToBack;
   //_tmplt_.Anchors:=_tmplt_.Anchors-[akRight];
end;

procedure TfrmApprovedFILEs2NAMEs.Button2Click(Sender: TObject);
begin
//    Splitter1.Left:=_tmplt_.Width+_tmplt_.Left;
//   _tmplt_.Anchors:=_tmplt_.Anchors+[akRight];
end;

end.


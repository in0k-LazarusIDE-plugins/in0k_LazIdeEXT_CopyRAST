unit in0k_CopyRAST__STAGE_03__frmRename;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, CheckBoxThemed, Forms, Controls, ExtCtrls,
  StdCtrls, ComCtrls,


  in0k_CopyRAST__cmpSTAGE_Tree,
  in0k_CopyRAST__STAGE_03__cmpLTREE,

  lazExt_CopyRAST__xmlConfig,
  in0k_CopyRAST__frmSTAGE_twoTree_CORE,

  in0k_CopyRAST_STAGEs_CORE,

  cmpCopyRAST_srcTree_approvedFiles,
  in0k_lazIdeSRC_srcTree_CORE_item,

  frmCopyRAST_CnfgItem_EDIT,

  cmpCopyRAST_srcTree_nameTemplates,
  cmpCopyRAST_srcTree_approvedNAMEs,
  frmCopyRAST_cie_ReNames_customer, frmCopyRAST_cie_ReNames_template,
  in0k_CopyRAST__STAGE_03__reName,
  in0k_CopyRAST_stage__ChangePaths_CNFGs;

type

 { TfrmApprovedFILEs2NAMEs }

 TfrmApprovedFILEs2NAMEs = class(TfrmCopyRAST_STAGE_L_R)
    frmCopyRAST_cie_ReNamesCustomer1: TfrmCopyRAST_cie_ReNamesCustomer;
    frmCopyRAST_cie_ReNamesTemplate1: TfrmCopyRAST_cie_ReNamesTemplate;
    pnlPRP: TPanel;
    Splitter_TB: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FrameConstrainedResize(Sender: TObject; var MinWidth, MinHeight, MaxWidth, MaxHeight: TConstraintSize);
  private
    function _stageMY_:tCopyRast_stage__ChangePaths; inline;
  protected
    function  _treeL_TYPE_:tCmpCopyRAST_stageTree_TYPE; override;


  protected
    //procedure _ctrl_Enabled_SET_(const value:boolean); override;
    //procedure _ctrl_validate_;                         virtual; {$ifOpt D-}abstract;{$endIf}
    //procedure _ctrl_eventSet_onChange_; override;
    //procedure _ctrl_eventClr_onChange_; override;
  private
   _cnfg_template_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
    procedure _cnfg_template_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
  private
   _editItem_:tSrcTree_item;
    procedure _editItem_SET_(const value:tSrcTree_item); override;
  private
    procedure _onChange_customer_(const Sender:tObject; const itemCnfg:pointer);
    procedure _onChange_template_(const Sender:tObject; const itemCnfg:pointer);
  private
    //_HNDLR_:tCopyRast_stage__ChangePaths;
    //procedure _STAGE_set_(const value:tCopyRast_STAGE); override;
  public
    constructor Create(AOwner:TComponent); override;
    destructor DESTROY; override;
  public
    procedure frmSettings_LOAD(const xmlCongif:tLazExt_CopyRAST_CONFIG); override;
    procedure frmSettings_SAVE(const xmlCongif:tLazExt_CopyRAST_CONFIG); override;
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
    //_cnfg_customer_null2frm;
    //_cnfg_customer_ctrl_validate_;
   _cnfg_template_:=NIL;
    //----------------
    frmCopyRAST_cie_ReNamesCustomer1.ItemCNFG_OnChange:=@_onChange_customer_;
    frmCopyRAST_cie_ReNamesTemplate1.ItemCNFG_OnChange:=@_onChange_template_;
    frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_FNK:=NIL;
end;

//------------------------------------------------------------------------------

function TfrmApprovedFILEs2NAMEs._stageMY_:tCopyRast_stage__ChangePaths;
begin
    result:=tCopyRast_stage__ChangePaths(_STAGE_);
end;

//------------------------------------------------------------------------------

function TfrmApprovedFILEs2NAMEs._treeL_TYPE_:tCmpCopyRAST_stageTree_TYPE;
begin
    result:=tCmpCopyRAST_srcTree_Stage03_cmpLTREE;
end;

//------------------------------------------------------------------------------

{procedure TfrmApprovedFILEs2NAMEs._ctrl_Enabled_SET_(const value:boolean);
begin
    //
end;}

{procedure TfrmApprovedFILEs2NAMEs._ctrl_eventSet_onChange_;
begin
    //
end;}

{procedure TfrmApprovedFILEs2NAMEs._ctrl_eventClr_onChange_;
begin
    //
end;}

//------------------------------------------------------------------------------

(*procedure TfrmApprovedFILEs2NAMEs._STAGE_set_(const value:tCopyRast_STAGE);
begin
   (*
    frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_FNK:=nil;//@(_HNDLR_.Template_APPLAY);
    inherited;
    if Assigned(_STAGE_) then begin
        frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_FNK:=@(tCopyRast_stage__ChangePaths(_STAGE_).Template_APPLAY);
    end
    else begin
        frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_FNK:=nil;
    end; *)
end; *)

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._editItem_SET_(const value:tSrcTree_item);
begin
    if Assigned(value) then begin
       _editItem_:=value;
        frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_ITM:=nil;
        frmCopyRAST_cie_ReNamesCustomer1.ItemCNFG:=tCopyRast_stage__ChangePaths(_STAGE_).CNFG_customer_GET(_editItem_);
        //frmCopyRAST_cie_ReNamesTemplate1.ItemCNFG:=tCopyRast_stage__ChangePaths(_STAGE_).CNFG_template_GET(_editItem_);
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
       tCopyRast_stage__ChangePaths(_STAGE_).CNFG_customer_SET(_editItem_,tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(itemCnfg));
    end;
end;

procedure TfrmApprovedFILEs2NAMEs._onChange_template_(const Sender:tObject; const itemCnfg:pointer);
begin
  (*   if Assigned(_editItem_) then begin
       tCopyRast_stage__ChangePaths(_STAGE_).CNFG_template_SET(_editItem_,tCopyRAST_HandlerCNFGs_ReNAMEs_template_List(itemCnfg));
    end; *)
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
//    Splitter_TB.Left:=_tmplt_.Width+_tmplt_.Left;
//   _tmplt_.Anchors:=_tmplt_.Anchors+[akRight];
end;

procedure TfrmApprovedFILEs2NAMEs.FrameConstrainedResize(Sender: TObject; var MinWidth, MinHeight, MaxWidth, MaxHeight: TConstraintSize);
var tmp:integer;
begin
    //
    //tmp:=0;
    //---
    //frmCopyRAST_cie_ReNamesCustomer1
    pnlPRP.Constraints.MinHeight:=(frmCopyRAST_cie_ReNamesCustomer1.Constraints.MinHeight + frmCopyRAST_cie_ReNamesTemplate1.Constraints.MinHeight);

end;


//------------------------------------------------------------------------------

const
 _cWndSettings_pnlPRP='pnlPRP';
 _cWndSettings_Height='Height';

procedure TfrmApprovedFILEs2NAMEs.frmSettings_LOAD(const xmlCongif:tLazExt_CopyRAST_CONFIG);
begin
    inherited;
    pnlPRP.Height:=xmlCongif.GetValue(lERxC_8Value(frmSettings_Section,_cWndSettings_pnlPRP,_cWndSettings_Height),pnlPRP.Constraints.MinHeight);
end;

procedure TfrmApprovedFILEs2NAMEs.frmSettings_SAVE(const xmlCongif:tLazExt_CopyRAST_CONFIG);
begin
    inherited;
    xmlCongif.SetDeleteValue(lERxC_8Value(frmSettings_Section,_cWndSettings_pnlPRP,_cWndSettings_Height),pnlPRP.Height,pnlPRP.Constraints.MinHeight);
end;


end.


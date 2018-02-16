unit frmCopyRAST_cie_ReNames_customer;

{$mode objfpc}{$H+}

interface

uses
  in0k_CopyRAST_stage__ChangePaths_CNFGs,
  frmCopyRAST_CnfgItem_EDIT, Classes, SysUtils, FileUtil, CheckBoxThemed, Forms,
  Controls, Graphics, Dialogs, StdCtrls;

type

 { tFrmCopyRAST_cie_ReNamesCustomer }

 tFrmCopyRAST_cie_ReNamesCustomer=class(TfrmCopyRAST_CnfgItemEDIT)
    cntrl_nameCST: TCheckBoxThemed;
    cntrl_nameStated: TEdit;
    cntrl_pathCST: TCheckBoxThemed;
    cntrl_pathStated: TEdit;
    procedure FrameConstrainedResize(Sender: TObject; var MinWidth, MinHeight,
      MaxWidth, MaxHeight: TConstraintSize);
    procedure FrameResize(Sender: TObject);
  protected
    function  _itemCNFG_GET_:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
    procedure _itemCNFG_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
  private // события для контролов
    procedure _ctrl_xxxxNEW_onChange_(Sender:TObject);
    procedure _ctrl_xxxxCST_onChange_(Sender:TObject);
    procedure _ctrl_nameCST_onClick_ (Sender:TObject);
    procedure _ctrl_pathCST_onClick_ (Sender:TObject);
  private // проверки на вшивость
    function  _cnfg_ctrl_validate_NAME_(const value:string):boolean;
    function  _cnfg_ctrl_validate_PATH_(const value:string):boolean;
  protected
    procedure _cnfg_itmCLEAN_(const item:pointer);     override;
    procedure _cnfg_nil2ctrl_;                         override;
    procedure _cnfg_itm2ctrl_(const item:pointer);     override;
    procedure _cnfg_ctrl2itm_(const item:pointer);     override;
  protected
    procedure _ctrl_Enabled_SET_(const value:boolean); override;
    procedure _ctrl_validate_;                         override;
    procedure _ctrl_eventSet_onChange_;                override;
    procedure _ctrl_eventClr_onChange_;                override;
  public
    property ItemCNFG:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node read _itemCNFG_GET_ write _itemCNFG_SET_;
  public
    constructor Create(AOwner:TComponent); override;
  end;

implementation

{$R *.lfm}

constructor tFrmCopyRAST_cie_ReNamesCustomer.Create(AOwner:TComponent);
begin
    inherited;
    Constraints_reSet;
end;

//------------------------------------------------------------------------------

function tFrmCopyRAST_cie_ReNamesCustomer._itemCNFG_GET_:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
begin
    result:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(inherited _itemCNFG_GET_);
end;

procedure tFrmCopyRAST_cie_ReNamesCustomer._itemCNFG_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
begin
    inherited _itemCNFG_SET_(value);
end;

//-----------------------------------------------------------------[ ..data.. ]-

procedure tFrmCopyRAST_cie_ReNamesCustomer._cnfg_itmCLEAN_(const item:pointer);
begin
    tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(item).FREE;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tFrmCopyRAST_cie_ReNamesCustomer._cnfg_nil2ctrl_;
begin
    cntrl_nameStated.text:='';
    cntrl_nameCST.Checked:=false;
    cntrl_pathStated.text:='';
    cntrl_pathCST.Checked:=false;
end;

procedure tFrmCopyRAST_cie_ReNamesCustomer._cnfg_itm2ctrl_(const item:pointer);
begin
    with tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(item) do begin
        cntrl_nameStated.Text:=NameStated;
        cntrl_nameCST.Checked:=NameCustom;
        cntrl_nameCST.Tag    :=0;
        cntrl_pathStated.Text:=PathStated;
        cntrl_pathCST.Checked:=PathCustom;
        cntrl_pathCST.Tag    :=0;
    end;
end;

procedure tFrmCopyRAST_cie_ReNamesCustomer._cnfg_ctrl2itm_(const item:pointer);
begin
    with tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(item) do begin
        NameStated:=cntrl_nameStated.Text;
        NameCustom:=cntrl_nameCST.Checked;
        PathStated:=cntrl_pathStated.Text;
        PathCustom:=cntrl_pathCST.Checked;
    end;
end;

//--------------------------------------------------------------------------[ ]-

procedure tFrmCopyRAST_cie_ReNamesCustomer._ctrl_Enabled_SET_(const value:boolean);
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

//---------------------------------------------------------[ events onChanges ]-

procedure tFrmCopyRAST_cie_ReNamesCustomer._ctrl_eventSet_onChange_;
begin
    cntrl_nameCST.OnChange   :=@_ctrl_xxxxCST_onChange_;
    cntrl_nameCST.OnClick    :=@_ctrl_nameCST_onClick_;
    cntrl_pathCST.OnChange   :=@_ctrl_xxxxCST_onChange_;
    cntrl_pathCST.OnClick    :=@_ctrl_pathCST_onClick_;
    cntrl_nameStated.OnChange:=@_ctrl_xxxxNEW_onChange_;
    cntrl_pathStated.OnChange:=@_ctrl_xxxxNEW_onChange_;
end;

procedure tFrmCopyRAST_cie_ReNamesCustomer._ctrl_eventClr_onChange_;
begin
    cntrl_nameCST.OnChange:=nil;
    cntrl_nameCST.OnClick :=nil;
    cntrl_pathCST.OnChange:=nil;
    cntrl_pathCST.OnClick :=nil;
    cntrl_nameStated.OnChange:=nil;
    cntrl_pathStated.OnChange:=nil;
end;

//-----------------------------------------------------------------[ validate ]-

function tFrmCopyRAST_cie_ReNamesCustomer._cnfg_ctrl_validate_NAME_(const value:string):boolean;
begin
    result:=trim(value)<>'';
    {todo: доделать проверку}
end;

function tFrmCopyRAST_cie_ReNamesCustomer._cnfg_ctrl_validate_PATH_(const value:string):boolean;
begin
    result:=trim(value)<>'';
    {todo: доделать проверку}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tFrmCopyRAST_cie_ReNamesCustomer._ctrl_validate_;
var isValid:boolean;
begin
    case cntrl_nameCST.State of
      cbUnchecked:cntrl_nameStated.Enabled:=false;
      cbChecked  :cntrl_nameStated.Enabled:=true;
      cbGrayed   :cntrl_nameStated.Enabled:=true;
    end;
    isValid:=_cnfg_ctrl_validate_NAME_(cntrl_nameStated.Text);
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
    isValid:=_cnfg_ctrl_validate_PATH_(cntrl_pathStated.Text);
    case cntrl_pathCST.State of
      cbChecked  :if not isValid then cntrl_pathCST.State:=cbGrayed;
      cbGrayed   :if isValid then begin
                      cntrl_pathCST.Tag  :=0;
                      cntrl_pathCST.State:=cbChecked;
                  end;
    end;
end;

//------------------------------------------------------------[ xxx..onChange ]-

procedure tFrmCopyRAST_cie_ReNamesCustomer._ctrl_xxxxNEW_onChange_(Sender: TObject);
begin
    if _ctrl_OnChange_LOCKED_ then exit;
   _ctrl_OnChange_LOCK_(true);
    //---
   _ctrl_validate_;
    //---
   _ctrl_OnChange_LOCK_(false);
   _CNFG_do_OnCHANGE_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tFrmCopyRAST_cie_ReNamesCustomer._ctrl_xxxxCST_onChange_(Sender: TObject);
begin
    if _ctrl_OnChange_LOCKED_ then exit;
   _ctrl_OnChange_LOCK_(true);
    //---
    if TCheckBoxThemed(Sender).Tag=1 then begin
        TCheckBoxThemed(Sender).Tag:=0;
        TCheckBoxThemed(Sender).Checked:=false;
       _ctrl_validate_;
    end
    else begin
       _ctrl_validate_;
        if TCheckBoxThemed(Sender).State=cbGrayed then begin
            TCheckBoxThemed(Sender).Tag:=1;
        end
        else begin
            TCheckBoxThemed(Sender).Tag:=0;
        end;
    end;
    //---
   _ctrl_OnChange_LOCK_(false);
   _CNFG_do_OnCHANGE_;
end;

procedure tFrmCopyRAST_cie_ReNamesCustomer._ctrl_nameCST_onClick_(Sender: TObject);
begin
    if _ctrl_OnChange_LOCKED_ then exit;
   _ctrl_OnChange_LOCK_(true);
    //---
    case tCheckBoxThemed(Sender).State of
      cbUnchecked: ;
      cbChecked,
      cbGrayed   : if cntrl_nameStated.Enabled then cntrl_nameStated.SetFocus;
    end;
    //---
   _ctrl_OnChange_LOCK_(false);
   _CNFG_do_OnCHANGE_;
end;

procedure tFrmCopyRAST_cie_ReNamesCustomer._ctrl_pathCST_onClick_(Sender: TObject);
begin
    if _ctrl_OnChange_LOCKED_ then exit;
   _ctrl_OnChange_LOCK_(true);
    //---
    case tCheckBoxThemed(Sender).State of
      cbUnchecked: ;
      cbChecked,
      cbGrayed   : if cntrl_pathStated.Enabled then cntrl_pathStated.SetFocus;
    end;
    //---
   _ctrl_OnChange_LOCK_(false);
   _CNFG_do_OnCHANGE_;
end;

//------------------------------------------------------------------------------

procedure tFrmCopyRAST_cie_ReNamesCustomer.FrameResize(Sender: TObject);
var w:integer;
begin
    w:=0;
    if w<cntrl_nameCST.Width then w:=cntrl_nameCST.Width;
    if w<cntrl_pathCST.Width then w:=cntrl_pathCST.Width;
    cntrl_nameStated.Left:=w+2;
end;

procedure tFrmCopyRAST_cie_ReNamesCustomer.FrameConstrainedResize(Sender: TObject; var MinWidth, MinHeight, MaxWidth, MaxHeight: TConstraintSize);
begin
    MinHeight:=cntrl_pathStated.Top+cntrl_pathStated.Height;
    MaxHeight:=MinHeight;
    MinWidth :=cntrl_nameCST.Width+cntrl_pathCST.Width;
end;

end.


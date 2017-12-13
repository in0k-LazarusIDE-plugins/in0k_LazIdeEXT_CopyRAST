unit frmCopyRAST_cie_ReNames_template;

{$mode objfpc}{$H+}

interface

uses
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs,
  cmpCopyRAST_srcTree_nameTemplates,


    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
    Buttons, ActnList, frmCopyRAST_CnfgItem_EDIT;

type

 { TfrmCopyRAST_cie_ReNamesTemplate }

 TfrmCopyRAST_cie_ReNamesTemplate = class(TfrmCopyRAST_CnfgItemEDIT)
      a_newCNFG: TAction;
      a_deleTE: TAction;
      a_moveUP: TAction;
      a_moveDW: TAction;
      ActionList1: TActionList;
      BitBtn1: TBitBtn;
      BitBtn2: TBitBtn;
      BitBtn3: TBitBtn;
      BitBtn4: TBitBtn;
    cntrl_Template:tCmpCopyRAST_srcTree_nameTemplates;
    Panel1: TPanel;
    procedure a_deleTEExecute(Sender: TObject);
    procedure a_deleTEUpdate(Sender: TObject);
    procedure a_moveDWExecute(Sender: TObject);
    procedure a_moveDWUpdate(Sender: TObject);
    procedure a_moveUPExecute(Sender: TObject);
    procedure a_moveUPUpdate(Sender: TObject);
    procedure a_newCNFGExecute(Sender: TObject);
    procedure a_newCNFGUpdate(Sender: TObject);
  protected
    function  _itemCNFG_GET_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
    procedure _itemCNFG_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
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
    constructor Create(AOwner:TComponent); override;
    //destructor DESTROY; override;
  public
    property ItemCNFG:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List read _itemCNFG_GET_ write _itemCNFG_SET_;
  end;

implementation

{$R *.lfm}

constructor TfrmCopyRAST_cie_ReNamesTemplate.Create(AOwner:TComponent);
begin
    inherited;
    //---
    cntrl_Template:=tCmpCopyRAST_srcTree_nameTemplates.Create(self);
    with cntrl_Template do begin
        Parent:=self;
        //
        Align:=alClient;
        {with AnchorSide[akLeft] do begin
            Control:=self;
            Side   :=asrLeft;
        end;
        with AnchorSide[akTop] do begin
            Control:=self;
            Side   :=asrTop;
        end;
        with AnchorSide[akRight] do begin
            Control:=self;
            Side   :=asrRight;
        end;
        with AnchorSide[akBottom] do begin
            Control:=self;
            Side   :=asrBottom;
        end;
        //
        Anchors:=[akTop, akLeft, akRight, akBottom];}
    end;

end;

//------------------------------------------------------------------------------

function TfrmCopyRAST_cie_ReNamesTemplate._itemCNFG_GET_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
begin
    result:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List(inherited _itemCNFG_GET_);
end;

procedure TfrmCopyRAST_cie_ReNamesTemplate._itemCNFG_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
begin
    inherited _itemCNFG_SET_(value);
end;

//-----------------------------------------------------------------[ ..data.. ]-

procedure TfrmCopyRAST_cie_ReNamesTemplate._cnfg_itmCLEAN_(const item:pointer);
begin
    tCopyRAST_HandlerCNFGs_ReNAMEs_template_List(item).FREE;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TfrmCopyRAST_cie_ReNamesTemplate._cnfg_nil2ctrl_;
begin
    cntrl_Template.Templates:=nil;
end;

procedure TfrmCopyRAST_cie_ReNamesTemplate._cnfg_itm2ctrl_(const item:pointer);
begin
    cntrl_Template.Templates:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List(item);

    with tCopyRAST_HandlerCNFGs_ReNAMEs_template_List(item) do begin
        {cntrl_nameStated.Text:=NameStated;
        cntrl_nameCST.Checked:=NameCustom;
        cntrl_nameCST.Tag    :=0;
        cntrl_pathStated.Text:=PathStated;
        cntrl_pathCST.Checked:=PathCustom;
        cntrl_pathCST.Tag    :=0;}
    end;
end;

procedure TfrmCopyRAST_cie_ReNamesTemplate._cnfg_ctrl2itm_(const item:pointer);
begin
    with tCopyRAST_HandlerCNFGs_ReNAMEs_template_List(item) do begin
        cntrl_Template.Templates; //< этим самым КОПИРНЕМ инфу
    end;
end;

//--------------------------------------------------------------------------[ ]-

procedure TfrmCopyRAST_cie_ReNamesTemplate._ctrl_Enabled_SET_(const value:boolean);
begin
    if value then begin
        cntrl_Template.Enabled:=true;
    end
    else begin
        cntrl_Template.Enabled:=false;
    end;
end;

//---------------------------------------------------------[ events onChanges ]-

procedure TfrmCopyRAST_cie_ReNamesTemplate._ctrl_eventSet_onChange_;
begin
 {   cntrl_nameCST.OnChange   :=@_ctrl_xxxxCST_onChange_;
    cntrl_nameCST.OnClick    :=@_ctrl_nameCST_onClick_;
    cntrl_pathCST.OnChange   :=@_ctrl_xxxxCST_onChange_;
    cntrl_pathCST.OnClick    :=@_ctrl_pathCST_onClick_;
    cntrl_nameStated.OnChange:=@_ctrl_xxxxNEW_onChange_;
    cntrl_pathStated.OnChange:=@_ctrl_xxxxNEW_onChange_;   }
end;

procedure TfrmCopyRAST_cie_ReNamesTemplate._ctrl_eventClr_onChange_;
begin
  {  cntrl_nameCST.OnChange:=nil;
    cntrl_nameCST.OnClick :=nil;
    cntrl_pathCST.OnChange:=nil;
    cntrl_pathCST.OnClick :=nil;
    cntrl_nameStated.OnChange:=nil;
    cntrl_pathStated.OnChange:=nil;   }
end;

//-----------------------------------------------------------------[ validate ]-

procedure TfrmCopyRAST_cie_ReNamesTemplate._ctrl_validate_;
begin
    //
end;

//==============================================================================

procedure TfrmCopyRAST_cie_ReNamesTemplate.a_moveUPUpdate(Sender: TObject);
begin
    tAction(sender).Enabled:=cntrl_Template.selected_moveUpCAN;
end;

procedure TfrmCopyRAST_cie_ReNamesTemplate.a_moveUPExecute(Sender: TObject);
begin
    cntrl_Template.selected_MoveUP;
    cntrl_Template.SetFocus;
   _CNFG_do_OnCHANGE_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TfrmCopyRAST_cie_ReNamesTemplate.a_moveDWUpdate(Sender: TObject);
begin
    tAction(sender).Enabled:=cntrl_Template.selected_moveDwCAN;
end;

procedure TfrmCopyRAST_cie_ReNamesTemplate.a_moveDWExecute(Sender: TObject);
begin
    cntrl_Template.selected_MoveDW;
    cntrl_Template.SetFocus;
   _CNFG_do_OnCHANGE_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TfrmCopyRAST_cie_ReNamesTemplate.a_deleTEUpdate(Sender: TObject);
begin
    tAction(sender).Enabled:=cntrl_Template.selected_DeleteCAN;
end;

procedure TfrmCopyRAST_cie_ReNamesTemplate.a_deleTEExecute(Sender: TObject);
begin
    cntrl_Template.selected_Delete;
    cntrl_Template.SetFocus;
   _CNFG_do_OnCHANGE_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TfrmCopyRAST_cie_ReNamesTemplate.a_newCNFGUpdate(Sender: TObject);
begin
    tAction(sender).Enabled:=cntrl_Template.new_Cnfg_CreateCAN;
end;

procedure TfrmCopyRAST_cie_ReNamesTemplate.a_newCNFGExecute(Sender: TObject);
begin
    cntrl_Template.new_Cnfg_Create;
    cntrl_Template.SetFocus;
   _CNFG_do_OnCHANGE_;
end;

end.


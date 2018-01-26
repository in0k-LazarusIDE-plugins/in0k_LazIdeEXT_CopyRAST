unit frmCopyRAST_cie_ReNames_tmpltRule;

{$mode objfpc}{$H+}

interface

uses
  in0k_CopyRAST_stage__ChangePaths_CNFGs,

    Classes, SysUtils, FileUtil, CheckBoxThemed, Forms, Controls, Graphics,
    Dialogs, StdCtrls, frmCopyRAST_CnfgItem_EDIT;

type

 { tFrmCopyRAST_cie_ReNamesTmpltRULE }

 tFrmCopyRAST_cie_ReNamesTmpltRULE=class(TfrmCopyRAST_CnfgItemEDIT)
      CheckBoxThemed1: TCheckBoxThemed;
      CheckBoxThemed2: TCheckBoxThemed;
      CheckBoxThemed3: TCheckBoxThemed;
      CheckBoxThemed4: TCheckBoxThemed;
      CheckBoxThemed5: TCheckBoxThemed;
      Edit1: TEdit;
      Edit2: TEdit;
    GroupBox1:TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FrameResize(Sender: TObject);
    procedure GroupBox1Resize(Sender: TObject);
  private
    procedure _lbl_msg_HIDE_;
    procedure _lbl_msg_SHOW_readOnly;
    procedure _lbl_msg_SHOW_editMode;
    procedure _lbl_msg_SHOW_noSelect;
  protected
    procedure _chBox_onChange_(Sender:TObject);
    procedure _editX_onChange_(Sender: TObject);
  protected
    procedure _cnfg_nil2ctrl_;                         override;
    procedure _cnfg_itm2ctrl_(const item:pointer);     override;
    procedure _cnfg_ctrl2itm_(const item:pointer);     override;
  protected
    procedure _ctrl_Enabled_SET_(const value:boolean); override;
    procedure _ctrl_validate_;                         override;
    procedure _ctrl_eventSet_onChange_;                override;
    procedure _ctrl_eventClr_onChange_;                override;
  end;

implementation

{$R *.lfm}

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE.GroupBox1Resize(Sender: TObject);
var i:integer;
    p:TPoint;
begin
    //-----------------------------
    p.x:=0;
    //
    p.y:=GroupBox1.top;
    p:=GroupBox1.Parent.ClientToScreen(p);
    i:=p.y;
    //
    p.y:=0;
    p:=GroupBox1.ClientToScreen(p);
    //
    i:=p.y-i;
    //
    Label1.Top:=-i;//GroupBox1.Top-point.y;

    //-----------------------------
    i:=0;
    if i<Label2.Width then i:=Label2.Width;
    if i<Label3.Width then i:=Label3.Width;
    if i<Label4.Width then i:=Label4.Width;
    if i<Label5.Width then i:=Label5.Width;
    if i<Label6.Width then i:=Label6.Width;
    //
    Edit1.Left:=Label2.Left+i+2;
end;

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE.FrameResize(Sender: TObject);
begin
    GroupBox1Resize(GroupBox1);
end;

//------------------------------------------------------------------------------

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE._cnfg_nil2ctrl_;
begin
   _lbl_msg_SHOW_noSelect;

    CheckBoxThemed1.Checked:=false;
    CheckBoxThemed2.Checked:=false;
    Edit1.Text:='';
    Edit2.Text:='';
end;

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE._cnfg_itm2ctrl_(const item:pointer);
begin
    with tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(item) do begin
        if isInherited
        then _lbl_msg_SHOW_readOnly
        else _lbl_msg_SHOW_editMode;
        //
        CheckBoxThemed1.Checked:=Enabled;
        //
        CheckBoxThemed2.Checked:=RegExUSE;
        Edit1.Text:=Template;
        Edit2.Text:=Exchange;
        //
        CheckBoxThemed3.Checked:=Use4FILE;
        CheckBoxThemed4.Checked:=Use4FLDR;
        //
        CheckBoxThemed5.Checked:=use_Last;
    end;
    GroupBox1.Enabled:=true;
end;

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE._cnfg_ctrl2itm_(const item:pointer);
begin
   with tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(item) do begin
       Enabled  := CheckBoxThemed1.Checked;
       //
       RegExUSE := CheckBoxThemed2.Checked;
       Template := Edit1.Text;
       Exchange := Edit2.Text;
       //
       Use4FILE := CheckBoxThemed3.Checked;
       Use4FLDR := CheckBoxThemed4.Checked;
       //
       use_Last := CheckBoxThemed5.Checked;
   end;
end;

//------------------------------------------------------------------------------

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE._ctrl_Enabled_SET_(const value:boolean);
begin
    GroupBox1.Enabled:=VALUE;
end;

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE._ctrl_validate_;
begin

end;

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE._ctrl_eventSet_onChange_;
begin
    CheckBoxThemed1.OnChange:=@_chBox_onChange_;
    CheckBoxThemed2.OnChange:=@_chBox_onChange_;
    Edit1.OnChange:=@_editX_onChange_;
    Edit2.OnChange:=@_editX_onChange_;
    CheckBoxThemed3.OnChange:=@_chBox_onChange_;
    CheckBoxThemed4.OnChange:=@_chBox_onChange_;
    CheckBoxThemed5.OnChange:=@_chBox_onChange_;
end;

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE._ctrl_eventClr_onChange_;
begin
    CheckBoxThemed1.OnChange:=nil;
    CheckBoxThemed2.OnChange:=nil;
    Edit1.OnChange:=nil;
    Edit2.OnChange:=nil;
    CheckBoxThemed3.OnChange:=nil;
    CheckBoxThemed4.OnChange:=nil;
    CheckBoxThemed5.OnChange:=nil;
end;

//------------------------------------------------------------------------------

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE._lbl_msg_HIDE_;
begin
    Label1.Hide;
end;

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE._lbl_msg_SHOW_readOnly;
begin
    with Label1 do begin
        Font.Color:=clRed;
        Caption   :=' read ONLY ';
        SHOW;
    end;
end;

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE._lbl_msg_SHOW_editMode;
begin
    with Label1 do begin
        Font.Color:=clHotLight;
        Caption   :=' EDIT mode ';
        SHOW;
    end;
end;

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE._lbl_msg_SHOW_noSelect;
begin
    with Label1 do begin
        Font.Color:=clHotLight;
        Caption   :=' no Select ';
        SHOW;
    end;
end;

//==============================================================================

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE._chBox_onChange_(Sender:TObject);
begin
  {  if _ctrl_OnChange_LOCKED_ then EXIT;
   _ctrl_OnChange_setLOCK_(TRUE);
    //
    // VALIDATE
    //
   _ctrl_OnChange_setLOCK_(FALSE);  }
   _CNFG_do_OnCHANGE_;
end;

procedure tFrmCopyRAST_cie_ReNamesTmpltRULE._editX_onChange_(Sender: TObject);
begin
   _CNFG_do_OnCHANGE_;
end;


end.


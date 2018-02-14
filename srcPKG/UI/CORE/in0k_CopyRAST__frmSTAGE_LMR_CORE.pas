unit in0k_CopyRAST__frmSTAGE_LMR_CORE;

{$mode objfpc}{$H+}

interface

uses
  Dialogs,
  in0k_CopyRAST_STAGEs_CORE,
  in0k_CopyRAST__frmSTAGE_twoTree_CORE;

type
 tFrmCopyRAST_STAGE_LMR = class(TfrmCopyRAST_STAGE_L_R)
  protected
    procedure _STAGE_onSet_(const value:tCopyRast_STAGE); override;
  end;

implementation

{$R *.lfm}

procedure tFrmCopyRAST_STAGE_LMR._STAGE_onSet_(const value:tCopyRast_STAGE);
begin
    //inherited;
    //---
    if Assigned(_STAGE_) then
    with tCopyRast_SrcTree_STAGE_LMR(value) do begin
        RootMIDDLE_onChange:=@_onLRootChange_;
        RootRESULT_onChange:=@_onRRootChange_;
        //---
       _treeL_.Root:=RootMIDDLE;
       _treeR_.Root:=RootRESULT;
        //frmCopyRAST_cie_ReNamesTemplate1.TemplateAPPLAY_FNK:=@(_STAGE_.Template_APPLAY);
        //
       _ctrl_eventSet_onChange_;
       _ctrl_Enabled_SET_(TRUE);
    end;
end;

end.


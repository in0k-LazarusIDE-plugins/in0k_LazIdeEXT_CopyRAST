unit in0k_CopyRAST__frmSTAGE_01_Handling;

{$mode objfpc}{$H+}

interface

uses
  in0k_CopyRAST__frmSTAGE_twoTree_CORE,
  in0k_CopyRAST__frmSTAGE_LMR_CORE,
  cmpCopyRAST_srcTree,
  cmpCopyRAST_srcTree_Stage1_result,
  in0k_CopyRAST_STAGEs_CORE,
  in0k_CopyRAST__stage_01_Handling;

type
 TfrmCopyRAST__STAGE_01_Handling = class(tFrmCopyRAST_STAGE_LMR)
 protected
   function  _treeR_TYPE_:tCmpCopyRAST_srcTree_TYPE; override;
 protected
   procedure _STAGE_onSet_(const value:tCopyRast_STAGE); override;

  end;

implementation

{$R *.lfm}

function  TfrmCopyRAST__STAGE_01_Handling._treeR_TYPE_:tCmpCopyRAST_srcTree_TYPE;
begin
    result:=tCmpCopyRAST_srcTree_Stage1_result;
end;

procedure TfrmCopyRAST__STAGE_01_Handling._STAGE_onSet_(const value:tCopyRast_STAGE);
begin
    inherited;
    tCmpCopyRAST_srcTree_Stage1_result(_treeR_).RootSRC:=tCopyRast__stage_01_Handling(value).RootSOURCE;
end;

end.


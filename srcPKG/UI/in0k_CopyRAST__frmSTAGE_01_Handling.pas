unit in0k_CopyRAST__frmSTAGE_01_Handling;

{$mode objfpc}{$H+}

interface

uses
  Dialogs,

  in0k_CopyRAST__frmSTAGE_twoTree_CORE,
  in0k_CopyRAST__frmSTAGE_LMR_CORE,

  in0k_CopyRAST_srcTree_ITEMs,
  cmpCopyRAST_srcTree,
  cmpCopyRAST_srcTree_Stage1_result,
  in0k_CopyRAST_STAGEs_CORE,
  in0k_CopyRAST__stage_01_Handling;

type
 TfrmCopyRAST__STAGE_01_Handling = class(tFrmCopyRAST_STAGE_LMR)
 protected
   procedure _onLRootChange_(const aStage:tCopyRast_STAGE; const aRoot:tCopyRast_stROOT); override;
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
    //if Assigned();
end;


procedure TfrmCopyRAST__STAGE_01_Handling._onLRootChange_(const aStage:tCopyRast_STAGE; const aRoot:tCopyRast_stROOT);
begin
    inherited;
    if (STAGE=aStage) and (STAGE is tCopyRast__stage_01_Handling) then begin
        ShowMessage('dddddddd');
        tCmpCopyRAST_srcTree_Stage1_result(_treeR_).RootSRC:=tCopyRast__stage_01_Handling(STAGE).RootSOURCE;
    end;
end;

end.


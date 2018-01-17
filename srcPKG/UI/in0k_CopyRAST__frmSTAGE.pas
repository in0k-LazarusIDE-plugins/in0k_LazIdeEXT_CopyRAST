unit in0k_CopyRAST__frmSTAGE;

{$mode objfpc}{$H+}

interface

uses
  in0k_CopyRAST_srcTree_Stage,
  frmCopyRAST_EDIT;

type

 tFrmCopyRAST_STAGE=class(tFrmCopyRastEDIT)
  protected
   _STAGE_:tCopyRast_SrcTree_prcSTAGE;
    procedure _STAGE_set_(const value:tCopyRast_SrcTree_prcSTAGE); virtual;
  public
    property STAGE:tCopyRast_SrcTree_prcSTAGE read _STAGE_ write _STAGE_set_;
  end;

implementation

{$R *.lfm}

procedure tFrmCopyRAST_STAGE._STAGE_set_(const value:tCopyRast_SrcTree_prcSTAGE);
begin
   _STAGE_:=value;
end;

end.


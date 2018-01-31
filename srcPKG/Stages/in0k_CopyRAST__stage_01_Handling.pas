unit in0k_CopyRAST__stage_01_Handling;

{$mode objfpc}{$H+}

interface

uses
  in0k_CopyRAST_srcTree_ITEMs,
  in0k_lazIdeSRC_CopyRAST_srcTree,
  in0k_CopyRAST_STAGEs_CORE;

type

 tCopyRast__stage_01_Handling=class(tCopyRast_SrcTree_STAGE_LMR)
  protected
   _P4Build_:tCopyRastSrcTree_P4Build;
  protected
    function _execute_makeMidlleROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT; override;
    function _execute_makeResultROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT; override;
  public
    constructor Create(const STAGEs:tCopyRAST_STAGEs_CORE);
  end;

implementation

constructor tCopyRast__stage_01_Handling.Create(const STAGEs:tCopyRAST_STAGEs_CORE);
begin
    inherited;
   _P4Build_:=tCopyRastSrcTree_P4Build.Create(_owner_Builder);
   _enabled_:=TRUE;
end;

function tCopyRast__stage_01_Handling._execute_makeMidlleROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT;
begin
    result:=CopyRast_SrcTree_Copy(src);
   _P4Build_.EXECUTE(src);
end;

function tCopyRast__stage_01_Handling._execute_makeResultROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT;
begin
    result:=CopyRast_SrcTree_Copy(src);
end;

end.


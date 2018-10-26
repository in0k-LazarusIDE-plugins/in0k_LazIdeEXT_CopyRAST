unit in0k_CopyRAST__STAGE_05__editFiles;

{$mode objfpc}{$H+}

interface

uses
  in0k_CopyRAST__STAGE_05_editFiles_Handler,


  in0k_CopyRAST_srcTree_ITEMs,
  in0k_CopyRAST_STAGEs_CORE;

type

 tCopyRast_STAGE_05__editFiles=class(tCopyRast_SrcTree_STAGE_L_R)
  protected
   _realSRC_:tCopyRast_stROOT;
  protected
    function _execute_makeResultROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT; override;
  public
    function  EXECUTE(const srcROOT,trgROOT:tCopyRast_stROOT):boolean; reintroduce;
  end;

implementation


function tCopyRast_STAGE_05__editFiles.EXECUTE(const srcROOT,trgROOT:tCopyRast_stROOT):boolean;
begin
   _realSRC_:=srcROOT;
    result:=inherited EXECUTE(trgROOT);
end;

function tCopyRast_STAGE_05__editFiles._execute_makeResultROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT;
begin
    result:=nil;
    STAGE_05__editFiles(_realSRC_,src);
    result:=src;
end;

end.


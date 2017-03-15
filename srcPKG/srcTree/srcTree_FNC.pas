unit srcTree_FNC;

{$mode objfpc}{$H+}

interface

uses
  srcTree_item_coreROOT,
  srcTree_item_coreFileSystem,
  srcTree_item_fsFolder,
  in0k_srcTree_fndRelPATH,
  Classes, SysUtils;

function SrcTreeROOT_fnd_relPATH(const item:tSrcTree_ROOT; const folder:string):tSrcTree_item_fsNodeFLDR;

implementation

function SrcTreeROOT_fnd_relPATH(const item:tSrcTree_ROOT; const folder:string):tSrcTree_item_fsNodeFLDR;
var lstDir:_tSrcTree_item_fsNodeFLDR_;
    mdlDir:string;
begin
    result:=tSrcTree_item_fsNodeFLDR(in0k_srcTree_fndRelPATH.SrcTree_fndRelPATH(item,folder,lstDir,mdlDir));
end;


end.


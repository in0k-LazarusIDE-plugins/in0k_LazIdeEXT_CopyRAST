unit in0k_srcTree_addNodeFILE;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  in0k_lazIdeSRC_srcTree_item_CORE,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_srcTree_fndNodeFILE,
  in0k_srcTree_getRelPATH,
  Classes, SysUtils;

type // создание ЭКЗеМпЛЯРа "ФАЙЛ"
  fSrcTree_addNodeFILE_crtNodeFILE=function(const fileName:string; const fileKind:TPkgFileType):tSrcTree_fsFILE;
  mSrcTree_addNodeFILE_crtNodeFILE=function(const fileName:string; const fileKind:TPkgFileType):tSrcTree_fsFILE of object;

//---

function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:fSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:fSrcTree_crtRelPATH_callBACK):tSrcTree_fsFILE;
function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:mSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:mSrcTree_crtRelPATH_callBACK):tSrcTree_fsFILE;

implementation

function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:fSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:fSrcTree_crtRelPATH_callBACK):tSrcTree_fsFILE;
{$I in0k_srcTree_addNodeFILE.inc}

function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:mSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:mSrcTree_crtRelPATH_callBACK):tSrcTree_fsFILE;
{$I in0k_srcTree_addNodeFILE.inc}

end.


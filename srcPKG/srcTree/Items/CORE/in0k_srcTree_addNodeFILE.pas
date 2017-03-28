unit in0k_srcTree_addNodeFILE;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  srcTree_item_CORE,
  srcTree_item_coreROOT,
  srcTree_item_fsFile,
  srcTree_item_fsFolder,
  in0k_srcTree_fndNodeFILE,
  in0k_srcTree_getRelPATH,
  Classes, SysUtils;

type // создание ЭКЗеМпЛЯРа "ФАЙЛ"
  fSrcTree_addNodeFILE_crtNodeFILE=function(const fileName:string; const fileKind:TPkgFileType):tSrcTree_item_fsFile;
  mSrcTree_addNodeFILE_crtNodeFILE=function(const fileName:string; const fileKind:TPkgFileType):tSrcTree_item_fsFile of object;

//---

function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:fSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:fSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsFile;
function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:mSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:mSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsFile;

implementation

function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:fSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:fSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsFile;
{$I in0k_srcTree_addNodeFILE.inc}

function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:mSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:mSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsFile;
{$I in0k_srcTree_addNodeFILE.inc}

end.


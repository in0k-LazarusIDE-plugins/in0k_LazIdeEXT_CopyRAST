unit in0k_srcTree_getMainFILE;

{$mode objfpc}{$H+}

interface

uses
  srcTree_item_CORE,
  srcTree_item_coreMAIN,
  srcTree_item_coreROOT,
  srcTree_item_baseDIR,
  in0k_srcTree_getBaseDIR,
  in0k_srcTree_fndMainFILE,
  Classes, SysUtils;

type // создание ЭКЗеМпЛЯРа "Базовой директории"
  fSrcTree_getMainFILE_crtMainFILE=function(const MainFILE_Name:string):tSrcTree_MAIN;
  mSrcTree_getMainFILE_crtMainFILE=function(const MainFILE_Name:string):tSrcTree_MAIN of object;

// -----

function SrcTree_getMainFILE(const item:tSrcTree_ROOT; const crtFnc:fSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;
function SrcTree_getMainFILE(const item:tSrcTree_ROOT; const crtFnc:mSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;


implementation

function SrcTree_getMainFILE(const item:tSrcTree_ROOT; const crtFnc:fSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;
{$I in0k_srcTree_getMainFILE.inc}

function SrcTree_getMainFILE(const item:tSrcTree_ROOT; const crtFnc:mSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;
{$I in0k_srcTree_getMainFILE.inc}

end.


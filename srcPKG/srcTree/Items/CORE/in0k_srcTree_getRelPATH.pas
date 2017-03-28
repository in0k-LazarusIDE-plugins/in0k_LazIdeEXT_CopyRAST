unit in0k_srcTree_getRelPATH;

{$mode objfpc}{$H+}

interface

uses
  srcTree_item_CORE,
  srcTree_item_coreROOT,
  srcTree_item_coreFileSystem,
  srcTree_item_fsFolder,
  in0k_srcTree_fndRelPATH,
  Classes, SysUtils, LazFileUtils;

type



  {todo: rename}
  fSrcTree_crtRelPATH_callBACK=function(const relFolderName:string):tSrcTree_item_fsNodeFLDR;
  //nSrcTree_crtRelPATH_callBACK=function(const relFolderName:string):tSrcTree_item_fsNodeFLDR is nested;
  mSrcTree_crtRelPATH_callBACK=function(const relFolderName:string):tSrcTree_item_fsNodeFLDR of object;

  function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const folder:string; const crtFnc:fSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsNodeFLDR; overload;
  //function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const folder:string; const crtFnc:nSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsNodeFLDR; overload;
  function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const folder:string; const crtFnc:mSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsNodeFLDR; overload;
  function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const folder:string):tSrcTree_item_fsNodeFLDR;

implementation


// перемести ВСЕХ детей source (файлового типа) в target, только если они
// подходят туда по "пути"
procedure _move_All_Child_4fsNode_(const source,target:_tSrcTree_item_fsNodeFLDR_);
var tmp0:tSrcTree_item;
    tmp1:tSrcTree_item;
begin
    tmp0:=source.ItemCHLD;
    while Assigned(tmp0) do begin
        tmp1:=tmp0.ItemNEXT;
        // эсли tmp0 элемент ФС и входит по пути поиска в target, то переносим
        if tmp0 is _tStcTree_item_fsNode_ then begin
            if FileIsInPath( _tStcTree_item_fsNode_(tmp0).src_PATH, target.src_PATH ) then begin
                SrcTree_cut_From_Parent(tmp0);
                SrcTree_insert_ChldLast(target,tmp0);
            end;
        end;
        //-->
        tmp0:=tmp1;
    end;
end;

function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const folder:string; const crtFnc:fSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsNodeFLDR;
{$I in0k_srcTree_getRelPATH.inc}

//function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const folder:string; const crtFnc:nSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsNodeFLDR;
//{$I in0k_srcTree_getRelPATH.inc}

function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const folder:string; const crtFnc:mSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsNodeFLDR;
{$I in0k_srcTree_getRelPATH.inc}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// просто создаем папку с путем.
// при кастомизации тут момжно выбирать классы
function _crt_relPATH_callBACK_(const relFolderName:string):tSrcTree_item_fsNodeFLDR;
begin
    result:=tSrcTree_item_fsNodeFLDR.Create(ChompPathDelim(relFolderName));
end;

function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const folder:string):tSrcTree_item_fsNodeFLDR;
begin
    result:=SrcTree_getRelPATH(item,folder,@_crt_relPATH_callBACK_);
end;

end.


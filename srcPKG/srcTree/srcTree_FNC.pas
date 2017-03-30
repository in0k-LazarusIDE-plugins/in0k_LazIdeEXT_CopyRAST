unit srcTree_FNC;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.


uses
  {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
        in0k_lazIdeSRC_DEBUG,
        //sysutils,
     {$endIf}
  srcTree_item_CORE,
  srcTree_item_coreROOT,
  srcTree_item_coreFileSystem,
  srcTree_item_fsFolder,
  in0k_srcTree_fndRelPATH,
  Classes, SysUtils;

function SrcTreeROOT_fnd_relPATH(const item:tSrcTree_ROOT; const folder:string):tSrcTree_item_fsNodeFLDR;

procedure SrcTreeROOT_toGourceLOG(const item:tSrcTree_item; const FileName:string);


implementation

function SrcTreeROOT_fnd_relPATH(const item:tSrcTree_ROOT; const folder:string):tSrcTree_item_fsNodeFLDR;
var lstDir:_tSrcTree_item_fsNodeFLDR_;
    mdlDir:string;
begin
    result:=tSrcTree_item_fsNodeFLDR(in0k_srcTree_fndRelPATH.SrcTree_fndRelPATH(item,folder,lstDir,mdlDir));
end;

const smb='|';
//1275543595|andrew|A|src/main.cpp
procedure _SrcTreeROOT_toGourceLOG_(const item:tSrcTree_item; const Strings:tStrings);
var tmp:tSrcTree_item;
begin
    if item is _tStcTree_item_fsNode_ then begin
    	Strings.Add(inttostr(Strings.Count)+smb+smb+'A'+smb+'src\'+_tStcTree_item_fsNode_(item).src_PATH);
    	DEBUG(inttostr(0)+smb+smb+'A'+smb+_tStcTree_item_fsNode_(item).src_PATH)
    end;
    //---
    tmp:=item.ItemCHLD;
    while Assigned(tmp) do begin
       _SrcTreeROOT_toGourceLOG_(tmp, Strings);
      	tmp:=tmp.ItemNEXT;
    end;

end;

procedure SrcTreeROOT_toGourceLOG(const item:tSrcTree_item; const FileName:string);
var str:TStrings;
begin
    str:=TStringList.Create;
   _SrcTreeROOT_toGourceLOG_(item,str);
    str.SaveToFile('H:/asd.log');
    str.FrEE;
end;

end.


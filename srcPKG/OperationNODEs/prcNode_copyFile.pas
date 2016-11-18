unit prcNode_copyFile;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}

    lazExt_CopyRAST_node,
    lazExt_CopyRAST_node_File,


    lazExt_CopyRAST_processingNODE,
    FileUtil, LazFileUtils;

type

 tPrcNODE_copyFile=class(tPrcNODE_Base)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;

implementation

function tPrcNODE_copyFile.Is_Possible:boolean;
begin
    result:=(node4Execut Is tCopyRAST_node_File_CORE);
end;

function tPrcNODE_copyFile.doOperation:boolean;
begin
    result:=TRUE; //< НЕ останавливаться на достигнутом :-)
    //---
    if NOT FileExistsUTF8(node4Execut.Get_Source_fullName) then begin
        doEvent_on_ERROR('Source file NOT present:'+'"'+node4Execut.Get_Source_fullName+'"');
    end
   else
    if FileExistsUTF8(node4Execut.Get_Target_fullName) then begin
        doEvent_on_ERROR('Target file ALREADY present:'+'"'+node4Execut.Get_Target_fullName+'"');
    end
   else
    if CopyFile(node4Execut.Get_Source_fullName,node4Execut.Get_Target_fullName{,[cffOverwriteFile,cffPreserveTime]})
    then begin
        doEvent_onPASSED('file COPIED');
    end
    else begin
        doEvent_on_ERROR('CopyFile("'+node4Execut.Get_Source_fullName+'","'+node4Execut.Get_Target_fullName+'")');
    end;
end;

end.


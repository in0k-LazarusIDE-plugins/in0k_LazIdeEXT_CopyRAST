unit prcNode_createTargetDir;

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
    lazExt_CopyRAST_node_Folder,
    lazExt_CopyRAST_node_File,


    lazExt_CopyRAST_processingNODE,
    FileUtil, LazFileUtils;

type

 tPrcNODE_createTargetDir=class(tPrcNODE_Base)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;

implementation

function tPrcNODE_createTargetDir.Is_Possible:boolean;
begin
    result:=(node4Execut Is tCopyRAST_node_Folder) or
            (node4Execut Is tCopyRAST_node_FILE);
end;

function tPrcNODE_createTargetDir.doOperation:boolean;
var S:string;
begin
    result:=TRUE; //< НЕ останавливаться на достигнутом :-)
    //---
    S:='';
    if node4Execut Is tCopyRAST_node_FILE then S:=node4Execut.Get_Target_dir_Name
   else
    if node4Execut Is tCopyRAST_node_Folder then S:=node4Execut.Get_Target_fullName;
    //---
    if S<>'' then begin
        if DirectoryExistsUTF8(S) then doEvent_onNoNeed('Already present '+'"'+S+'"')
        else begin
            if ForceDirectoriesUTF8(S)
            then doEvent_onPASSED('CREATED target DIR "'+S+'"')
            else doEvent_on_ERROR('CreateDirUTF8("'+S+'")');
        end;
    end;
end;

end.


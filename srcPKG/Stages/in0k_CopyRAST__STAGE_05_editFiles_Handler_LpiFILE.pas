unit in0k_CopyRAST__STAGE_05_editFiles_Handler_LpiFILE;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  BasicCodeTools,

  srcTree_handler_CORE,
  lazExt_CopyRAST_TEXTs,

  CodeToolManager,
  SourceChanger,
  lazExt_CopyRAST_node,
  in0k_CopyRAST_srcTree_ITEMs,

  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  lazExt_CopyRAST_processingNODE,
  in0k_CopyRAST__STAGE_05_editFiles_Handler,
  Classes, SysUtils;

type
_tSTAGE05_itmHandler__LpiFILE_=class(_tSTAGE05_lpiHandler_)
  protected
     function _processing_:boolean;
  public // ВЫПОЛНЕНИЕ
     function  Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;

_tSTAGE05_itmHandler__LpiFILE_01_=class(_tSTAGE05_lpiHandler_)
  protected
     function _processing_:boolean;
  public // ВЫПОЛНЕНИЕ
     function  Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;

implementation

function _tSTAGE05_itmHandler__LpiFILE_._processing_:boolean;
begin
   _xmlConfig_.SetValue('Package/Name/Value',srcTree_fsFnk_ExtractFileNameOnly(tCopyRastNODE_Main4Package(prcssdITEM).ItemNAME))
end;

function _tSTAGE05_itmHandler__LpiFILE_.Processing:boolean;
//var //srcNode:tCopyRast_stITEM;
//    untName:string;
begin
    result:=true;
    if (prcssdITEM is tCopyRastNODE_Main4Package) and
       //(tCopyRastNODE_FILE(prcssdITEM).fileKIND in [pftUnit,pftVirtualUnit,pftMainUnit,pftInclude]) and {todo: проверить все это для INC файлов}
       (CopyRastNODE_IS_NOT_SOURCE(prcssdITEM))
    then begin
        //srcNode:=CopyRAST_stITEM__findInLFT(_coreROOT_,prcssdITEM);
        if true{Assigned(srcNode) and (srcNode.ItemNAME<>prcssdITEM.ItemNAME)} then begin
            result:=_do4EDIT_;
            if result then begin
                result:=_processing_;
            end;
            result:=_doCLOSE_;
        end;
    end;
    result:=true;
end;

//------------------------------------------------------------------------------

function _tSTAGE05_itmHandler__LpiFILE_01_._processing_:boolean;
var i:integer;
    oldName:string;
    oldPath:string;
    newName:string;
    newPath:string;

    oldItem:tCopyRast_stITEM;
    newItem:tCopyRast_stITEM;
begin
    i:=_xmlConfig_.GetValue('Package/Files/Count',0);
    for i:=1 to i do begin
        oldName:=_xmlConfig_.GetValue('Package/Files/Item'+inttostr(i)+'/UnitName/Value','');
        oldPath:=_xmlConfig_.GetValue('Package/Files/Item'+inttostr(i)+'/Filename/Value','');
        //---
        oldItem:=CopyRastNODE_findItemPath(_coreROOT_,lowercase(oldPath));
        if Assigned(oldItem) then begin
            newItem:=CopyRAST_stITEM__findInRGT(tCopyRast_stROOT(executed_Root),oldItem);
            if Assigned(newItem) then begin
                newName:=srcTree_fsFnk_ExtractFileNameOnly(tCopyRastNODE_Main4Package(newItem).ItemNAME);
                newPath:=tCopyRast_stFILE(newItem).fsBase;
                //
                if(oldPath<>newPath) then _xmlConfig_.SetValue('Package/Files/Item'+inttostr(i)+'/Filename/Value',newPath);
                if(oldName<>newName) then _xmlConfig_.SetValue('Package/Files/Item'+inttostr(i)+'/UnitName/Value',newName);
            end;
        end;
    end;
end;

function _tSTAGE05_itmHandler__LpiFILE_01_.Processing:boolean;
//var //srcNode:tCopyRast_stITEM;
//    untName:string;
begin
    result:=true;
    if (prcssdITEM is tCopyRastNODE_Main4Package) and
       //(tCopyRastNODE_FILE(prcssdITEM).fileKIND in [pftUnit,pftVirtualUnit,pftMainUnit,pftInclude]) and {todo: проверить все это для INC файлов}
       (CopyRastNODE_IS_NOT_SOURCE(prcssdITEM))
    then begin
        //srcNode:=CopyRAST_stITEM__findInLFT(_coreROOT_,prcssdITEM);
        if true{Assigned(srcNode) and (srcNode.ItemNAME<>prcssdITEM.ItemNAME)} then begin
            result:=_do4EDIT_;
            if result then begin
                result:=_processing_;
            end;
            result:=_doCLOSE_;
        end;
    end;
    result:=true;
end;


end.


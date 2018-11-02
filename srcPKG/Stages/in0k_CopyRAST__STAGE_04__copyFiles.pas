unit in0k_CopyRAST__STAGE_04__copyFiles;

{$mode objfpc}{$H+}

interface

uses
  Dialogs,

  srcTree_handler_CORE,
  in0k_lazIdeSRC_srcTree_CORE_item,

  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,

  lazExt_CopyRAST_fileSystemFNKs,

  in0k_CopyRAST_srcTree_ITEMs,

  in0k_CopyRAST__STAGE_04_configs,
  in0k_CopyRAST_STAGEs_CORE,
  lazExt_CopyRAST__xmlConfig;

type



 tCopyRast_STAGE__copyFiles=class(tCopyRast_SrcTree_STAGE_L_R)
  private
   _cnfgs_:tCopyRast_STAGE__copyFiles__CNFGs; //< собственные названия для ROOT
  protected //< работа с Конфигурацией
    procedure _CNFGs_INIT_;                                        override;
    procedure _CNFGs_FREE_;                                        override;
    procedure _CNFGs_LOAD_(const Configs:tLazExt_CopyRAST_CONFIG); override;
    procedure _CNFGs_SAVE_(const Configs:tLazExt_CopyRAST_CONFIG); override;
  protected
    function  _execute__targetDir_prepare_CLR_(const dirName:string):boolean;
    function  _execute__targetDir_prepare_CRT_(const dirName:string):boolean;
    function  _execute__targetDir_prepare_    (const src:tCopyRast_stROOT):boolean;
  protected
    function  _execute__makeDIRs_(const src:tCopyRast_stROOT):boolean;
  protected
    //function  _execute__copyFiles_(const src:tCopyRast_stROOT):boolean;
  protected
    function  _execute_makeResultROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT; override;
  end;

implementation

function _is_NOT_SOURCE_(const iten:tCopyRast_stITEM):boolean;
begin
    // проверить что объект НЕ является ИСХОДНИКОМ
    result:=true;
end;

{%region --- _CNFGs_ ... ------------------------------------------------}

procedure tCopyRast_STAGE__copyFiles._CNFGs_INIT_;
begin
   inherited;
  _cnfgs_:=tCopyRast_STAGE__copyFiles__CNFGs.Create;
end;

procedure tCopyRast_STAGE__copyFiles._CNFGs_FREE_;
begin
    inherited;
   _cnfgs_.FREE;
end;

procedure tCopyRast_STAGE__copyFiles._CNFGs_LOAD_(const Configs:tLazExt_CopyRAST_CONFIG);
begin
    // надо что-то загрузить
end;

procedure tCopyRast_STAGE__copyFiles._CNFGs_SAVE_(const Configs:tLazExt_CopyRAST_CONFIG);
begin
   // надо что-то созранить
end;

{%endregion}

{%region --- _execute__targetDir_ ... ---------------------------------- }

function tCopyRast_STAGE__copyFiles._execute__targetDir_prepare_CLR_(const dirName:string):boolean;
begin
    result:=true;
    if _cnfgs_.TargetDirDELETE or _cnfgs_.TargetDirDELETE then begin
        if not copyRast_fsFnk_DirectoryExists(dirName) then EXIT(true);
        //
        if _cnfgs_.TargetDirDELETE then begin
            result:=copyRast_fsFnk_DirectoryDelete(dirName,FALSE)
        end
        else
        if _cnfgs_.TargetDirCLEAR then begin
            result:=copyRast_fsFnk_DirectoryDelete(dirName,TRUE);
        end;
    end;
end;

function tCopyRast_STAGE__copyFiles._execute__targetDir_prepare_CRT_(const dirName:string):boolean;
begin
    ShowMessage(dirName);
    result:=true;
    if not copyRast_fsFnk_DirectoryExists(dirName) then begin
        result:=copyRast_fsFnk_DirectoryForce(dirName);
    end;
end;

function tCopyRast_STAGE__copyFiles._execute__targetDir_prepare_(const src:tCopyRast_stROOT):boolean;
var tmp:tCopyRast_stBASE;
begin
    tmp:=CopyRastNODE_BASE(src);
    if Assigned(tmp) then begin
        result:=_execute__targetDir_prepare_CLR_(tmp.fsPath) and
                _execute__targetDir_prepare_CRT_(tmp.fsPath);
    end;
end;

{%endregion}

{%region --- _execute__copyFiles_ ... ---------------------------------- }

type  // копирование файлов
_tSTAGE04_itmHandler__copyFiles_=class(tSrcTree_itmHandler)
  public // ВЫПОЛНЕНИЕ
    function  Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;


function _file4COPY_(const item:tSrcTree_item):boolean;
begin
    result:=FALSE
          or(item is tCopyRastNODE_FILE)
          or(item is tCopyRastNODE_Main4Package)
          or(item is tCopyRastNODE_Main4Project)
            ;
end;

function _tSTAGE04_itmHandler__copyFiles_.Processing:boolean;
var str:string;
    src:string;
    tmp:tCopyRast_stITEM;
begin
    result:=true;
    if _file4COPY_(prcssdITEM) and _is_NOT_SOURCE_(prcssdITEM)
    then begin
        tmp:=CopyRAST_stITEM__LFT(prcssdITEM);
        if Assigned(tmp) and _file4COPY_(tmp) then begin
            src:=tCopyRastNODE_FILE(tmp).fsPath;
            str:=tCopyRastNODE_FILE(prcssdITEM).fsPath;
            //
            result:=copyRast_fsFnk_CopyFile(src,str,[],true);
        end;
    end;
    //
    if Result then self.doEvent_onPASSED(str)
              else self.doEvent_on_ERROR(str);
    //
    result:=true;
end;

//------------------------------------------------------------------------------

type // создаватель ДИРЕКТОРИЙ
_tSTAGE04_itmHandler__makeDIRs_=class(tSrcTree_itmHandler)
  public // ВЫПОЛНЕНИЕ
    function  Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;

function _tSTAGE04_itmHandler__makeDIRs_.Processing:boolean;
var str:string;
begin
    result:=true;
    if ( prcssdITEM is tCopyRastNODE_FLDR) and
       (_is_NOT_SOURCE_(prcssdITEM))
    then begin
        str:=tCopyRastNODE_FLDR(prcssdITEM).fsPath;
        if not copyRast_fsFnk_DirectoryExists(str) then begin
            result:=copyRast_fsFnk_DirectoryForce(str);
        end;
    end;
    //
    if Result then self.doEvent_onPASSED(str)
              else self.doEvent_on_ERROR(str);
    //
    result:=true;
end;

//------------------------------------------------------------------------------

type
_tSTAGE04_prcHandler__makeDIRs_=class(tSrcTree_prcHandler)
  protected
    procedure _EXECUTE_; override;
  end;

procedure _tSTAGE04_prcHandler__makeDIRs_._EXECUTE_;
begin
    EXECUTE_4TREE(_tSTAGE04_itmHandler__makeDIRs_);
    EXECUTE_4TREE(_tSTAGE04_itmHandler__copyFiles_);
end;

//------------------------------------------------------------------------------

function tCopyRast_STAGE__copyFiles._execute__makeDIRs_(const src:tCopyRast_stROOT):boolean;
var prcHandler:_tSTAGE04_prcHandler__makeDIRs_;
begin
    prcHandler:=_tSTAGE04_prcHandler__makeDIRs_.Create;
    //prcHandler._STAGE_   :=self;
    //prcHandler._rsltRoot_:=resRoot;
    prcHandler.EXECUTE(src);
    prcHandler.FREE;
    result:=true;
end;

{%endregion}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCopyRast_STAGE__copyFiles._execute_makeResultROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT;
begin
    result:=nil;
    if _execute__targetDir_prepare_(src) and
       _execute__makeDIRs_(src) //and
       //_execute__copyFiles_(src)
    then begin
        result:=src;
    end;
end;




end.


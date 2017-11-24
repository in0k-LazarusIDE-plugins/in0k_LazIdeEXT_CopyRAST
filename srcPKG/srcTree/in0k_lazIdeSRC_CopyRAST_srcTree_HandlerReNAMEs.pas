unit in0k_lazIdeSRC_CopyRAST_srcTree_HandlerReNAMEs;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_fsFile,


  srcTree_builder_CORE,

  sysutils,

  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,

  RegExpr,


srcTree_handler4build_CORE,


  in0k_lazIdeSRC_CopyRAST_srcTree_Nodes;

type


 {tCopyRastSrcTree_itmH4ReNAMEs_FLDR=class(tSrcTree_itmHandler4Build)
  public // ВЫПОЛНЕНИЕ
    function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;

 tCopyRastSrcTree_itmH4ReNAMEs_FILE=class(tSrcTree_itmHandler4Build)
  public // ВЫПОЛНЕНИЕ
    function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;}

 tCopyRastSrcTree_itmH4ReNAMEs_ITEM=class(tSrcTree_itmHandler4Build)
  protected
    function newRoot:tSrcTree_ROOT;

  protected
    function _newFLDR_:tCopyRastNODE_FLDR;
    function _newFILE_(const fldr:tCopyRastNODE_FLDR):tCopyRastNODE_FILE;
  public // ВЫПОЛНЕНИЕ
    function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;


 tCopyRastSrcTree_prcH4ReNAMEs=class(tSrcTree_prcHandler4Build)
  protected
   _newROOT_:tSrcTree_ROOT;
   _regExpr_:TRegExpr;
  protected
    function  _get_newFLDR_(const item:tSrcTree_item; out fldrPATH:string; out fldrKIND:sSrcTree_SrchPath; out leftFLDR:tCopyRastNODE_FLDR):boolean;
    function  _get_newNAME_(const item:tSrcTree_item; out fileName:string; out fileKIND:eSrcTree_FileType):boolean;
  protected
  protected
    function  _getNewName_ROOT_(const item:tSrcTree_ROOT):string;
    function  _getNewName_BASE_(const item:tCopyRastNODE_BASE):string;
    function  _getNewName_MAIN_(const item:tSrcTree_MAIN):string;
    function  _getNewPATH_FLDR_(const item:tCopyRastNODE_FLDR):string;
    function  _getNewPATH_FILE_(const item:tCopyRastNODE_FILE):string;
  protected
    procedure _prc_setNew_BASE_(const item:tCopyRastNODE_BASE);
    procedure _prc_setNew_MAIN_(const item:tSrcTree_MAIN);
    procedure _prc_addNew_FLDR_(const item:tCopyRastNODE_FLDR);
    procedure _prc_addNew_FILE_(const item:tCopyRastNODE_FILE);
  protected
    procedure _EXECUTE_; override;
  public
    procedure EXECUTE(const nodeRoot:tSrcTree_ROOT; out NewROOT:tSrcTree_ROOT); overload;
  public
    constructor Create(const BUILDer:tSrcTree_Builder_CORE); override;
    destructor DESTROY; override;
  end;

implementation


{function tCopyRastSrcTree_itmH4ReNAMEs_FLDR.Processing:boolean;
begin
    result:=true;
    if prcssdITEM is tCopyRastNODE_FLDR then begin
        tCopyRastSrcTree_prcH4ReNAMEs(_OWNER_)._prc_AddNew_FLDR_(tCopyRastNODE_FLDR(prcssdITEM));
    end;
end;

function tCopyRastSrcTree_itmH4ReNAMEs_FILE.Processing:boolean;
begin
    result:=true;
    if prcssdITEM is tCopyRastNODE_FILE then begin
        tCopyRastSrcTree_prcH4ReNAMEs(_OWNER_)._prc_AddNew_FILE_(tCopyRastNODE_FILE(prcssdITEM));
    end;
end;}


//------------------------------------------------------------------------------

function tCopyRastSrcTree_itmH4ReNAMEs_ITEM.newRoot:tSrcTree_ROOT;
begin
    result:=tCopyRastSrcTree_prcH4ReNAMEs(_OWNER_)._newROOT_;
end;

function tCopyRastSrcTree_itmH4ReNAMEs_ITEM._newFLDR_:tCopyRastNODE_FLDR;
var tmpLeft:tCopyRastNODE_FLDR;
var tmpPATH:string;
    tmpKING:sSrcTree_SrchPath;
begin
    if tCopyRastSrcTree_prcH4ReNAMEs(_OWNER_)._get_newFLDR_(prcssdITEM,tmpPATH,tmpKING,tmpLeft)
    then begin
        result:=tCopyRastNODE_FLDR(Builder.add_FLDR(newRoot,tmpPATH,tmpKING));
        CopyRastNODE_LINK(tmpLeft,result);
    end
    else result:=nil;
end;

function tCopyRastSrcTree_itmH4ReNAMEs_ITEM._newFILE_(const fldr:tCopyRastNODE_FLDR):tCopyRastNODE_FILE;
var tmpName:string;
    tmpKING:eSrcTree_FileType;
begin
    if tCopyRastSrcTree_prcH4ReNAMEs(_OWNER_)._get_newNAME_(prcssdITEM,tmpName,tmpKING)
    then begin // создаем и линкуем
        tmpName:=srcTree_fsFnk_ConcatPaths(fldr.fsPath,tmpName);
        result :=tCopyRastNODE_FILE(Builder.add_FILE(newRoot,tmpName,tmpKING));
        CopyRastNODE_LINK(tCopyRastNODE_FILE(prcssdITEM),result);
    end
    else result:=nil;
end;

function tCopyRastSrcTree_itmH4ReNAMEs_ITEM.Processing:boolean;
var tmpFLDR:tCopyRastNODE_FLDR;
    tmpFILE:tCopyRastNODE_FILE;

begin
    with tCopyRastSrcTree_prcH4ReNAMEs(_OWNER_) do begin
        if prcssdITEM is tCopyRastNODE_FILE then begin
            tmpFLDR:=_newFLDR_;
            if Assigned(tmpFLDR) then begin
               _newFILE_(tmpFLDR);
            end;
        end;
    end;
    result:=TRUE;
end;


////////////////////////////////////////////////////////////////////////////////

constructor tCopyRastSrcTree_prcH4ReNAMEs.Create(const BUILDer:tSrcTree_Builder_CORE);
begin
    inherited;
   _regExpr_:=TRegExpr.Create;
end;

destructor tCopyRastSrcTree_prcH4ReNAMEs.DESTROY;
begin
   _regExpr_.FREE;
    inherited;
end;

//------------------------------------------------------------------------------


function tCopyRastSrcTree_prcH4ReNAMEs._get_newFLDR_(const item:tSrcTree_item; out fldrPATH:string; out fldrKIND:sSrcTree_SrchPath; out leftFLDR:tCopyRastNODE_FLDR):boolean;
var tmp:tSrcTree_item;
begin
    result:=false;
    tmp:=SrcTree_fsFolder__fnd_PARENT(item);
    if Assigned(tmp) then begin
        fldrPATH:=tSrcTree_fsFLDR(tmp).fsBase;
        fldrKIND:=tSrcTree_fsFLDR(tmp).inSearchPATHs;
        leftFLDR:=tCopyRastNODE_FLDR(tmp);
        result  :=TRUE;
    end;
end;

function tCopyRastSrcTree_prcH4ReNAMEs._get_newNAME_(const item:tSrcTree_item; out fileName:string; out fileKIND:eSrcTree_FileType):boolean;
begin
    fileName:=item.ItemNAME;
    if item is tSrcTree_fsFILE then begin
        _regExpr_.InputString:=item.ItemNAME;
        _regExpr_.Expression :='^in0k_lazIdeSRC_(\w+)(\.pas)$';
         if _regExpr_.Exec(1) then begin
             fileName:=_regExpr_.Replace(item.ItemNAME,'asdf$1$2',true);
         end
    end;
    result:=true;
end;

//------------------------------------------------------------------------------


const ccc='new_';

function tCopyRastSrcTree_prcH4ReNAMEs._getNewName_ROOT_(const item:tSrcTree_ROOT):string;
begin
    result:=ccc+item.ItemNAME;
end;

function tCopyRastSrcTree_prcH4ReNAMEs._getNewName_BASE_(const item:tCopyRastNODE_BASE):string;
begin
    result:={ccc+}item.ItemNAME;
end;

function tCopyRastSrcTree_prcH4ReNAMEs._getNewName_MAIN_(const item:tSrcTree_MAIN):string;
begin
    result:=ccc+item.ItemNAME;
end;

function tCopyRastSrcTree_prcH4ReNAMEs._getNewPATH_FLDR_(const item:tCopyRastNODE_FLDR):string;
begin
    result:={ccc+}item.fsPath;
end;

function tCopyRastSrcTree_prcH4ReNAMEs._getNewPATH_FILE_(const item:tCopyRastNODE_FILE):string;
begin
   _regExpr_.InputString:=item.ItemNAME;
   _regExpr_.Expression :='^in0k_lazIdeSRC_(\w+)(\.pas)$';
    if _regExpr_.Exec(1) then begin
        result:=_regExpr_.Replace(item.ItemNAME,'asdf$1$2',true);

        result:=ExtractFilePath(item.fsPath)+result;
    end
    else result:=ccc+item.fsName;
end;

//------------------------------------------------------------------------------

procedure tCopyRastSrcTree_prcH4ReNAMEs._prc_setNew_BASE_(const item:tCopyRastNODE_BASE);
var tmp:tCopyRastNODE_BASE;
begin
    tmp:=tCopyRastNODE_BASE(_builder_.set_BASE(_newROOT_, _getNewName_BASE_(item)));
    CopyRastNODE_LINK(item,tmp);
end;

procedure tCopyRastSrcTree_prcH4ReNAMEs._prc_setNew_MAIN_(const item:tSrcTree_MAIN);
var tmp:tSrcTree_MAIN;
begin
    tmp:=_builder_.set_MAIN(_newROOT_, _getNewName_MAIN_(item));
    CopyRastNODE_LINK(item,tmp);
end;

procedure tCopyRastSrcTree_prcH4ReNAMEs._prc_AddNew_FLDR_(const item:tCopyRastNODE_FLDR);
var tmp:tCopyRastNODE_FLDR;
begin
    tmp:=tCopyRastNODE_FLDR(_builder_.add_FLDR(_newROOT_, _getNewPATH_FLDR_(item), item.inSearchPATHs ));
    CopyRastNODE_setLINK(item,tmp);
end;

procedure tCopyRastSrcTree_prcH4ReNAMEs._prc_AddNew_FILE_(const item:tCopyRastNODE_FILE);
var tmp:tCopyRastNODE_FILE;
begin
    tmp:=tCopyRastNODE_FILE(_builder_.add_FILE(_newROOT_, {item.ItemPRNT.fsPath+'\'+}_getNewPATH_FILE_(item), item.fileKIND ));
    CopyRastNODE_setLINK(item,tmp);
end;

//------------------------------------------------------------------------------

procedure tCopyRastSrcTree_prcH4ReNAMEs._EXECUTE_;
begin
    EXECUTE_4TREE(tCopyRastSrcTree_itmH4ReNAMEs_ITEM);
end;

procedure tCopyRastSrcTree_prcH4ReNAMEs.EXECUTE(const nodeRoot:tSrcTree_ROOT; out NewROOT:tSrcTree_ROOT);
begin
    if nodeRoot is tCopyRastNODE_Root4Package
    then _newROOT_:=tCopyRastNODE_Root4Package(_builder_.crt_ROOT(_getNewName_ROOT_(nodeRoot)))
   else
    if nodeRoot is tCopyRastNODE_Root4Project
    then _newROOT_:=tCopyRastNODE_Root4Project(_builder_.crt_ROOT(_getNewName_ROOT_(nodeRoot)));
   _prc_setNew_BASE_(tCopyRastNODE_BASE(_builder_.fnd_BASE(nodeRoot)));
   _prc_setNew_MAIN_({tCopyRastNODE_MAIN}(_builder_.fnd_MAIN(nodeRoot)));
    EXECUTE(nodeRoot);
    NewROOT:=_newROOT_;
end;


end.


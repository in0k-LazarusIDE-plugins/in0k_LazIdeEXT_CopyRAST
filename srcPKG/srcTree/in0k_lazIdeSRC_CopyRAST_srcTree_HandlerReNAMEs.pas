unit in0k_lazIdeSRC_CopyRAST_srcTree_HandlerReNAMEs;

{$mode objfpc}{$H+}

interface

uses
  srcTree_builder_CORE,
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,

srcTree_handler4build_CORE,


  in0k_lazIdeSRC_CopyRAST_srcTree_Nodes;

type


 tCopyRastSrcTree_itmH4ReNAMEs_FLDR=class(tSrcTree_itmHandler4Build)
  public // ВЫПОЛНЕНИЕ
    function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;

 tCopyRastSrcTree_itmH4ReNAMEs_FILE=class(tSrcTree_itmHandler4Build)
  public // ВЫПОЛНЕНИЕ
    function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;


 tCopyRastSrcTree_H4ReNAMEs=class(tSrcTree_prcHandler4Build)
  protected
   _newROOT_:tCopyRastNODE_ROOT;
  protected
    function  _getNewName_ROOT_(const item:tCopyRastNODE_ROOT):string;
    function  _getNewName_BASE_(const item:tCopyRastNODE_BASE):string;
    function  _getNewName_MAIN_(const item:tCopyRastNODE_MAIN):string;
    function  _getNewPATH_FLDR_(const item:tCopyRastNODE_FLDR):string;
    function  _getNewPATH_FILE_(const item:tCopyRastNODE_FILE):string;
  protected
    procedure _prc_setNew_BASE_(const item:tCopyRastNODE_BASE);
    procedure _prc_setNew_MAIN_(const item:tCopyRastNODE_MAIN);
    procedure _prc_addNew_FLDR_(const item:tCopyRastNODE_FLDR);
    procedure _prc_addNew_FILE_(const item:tCopyRastNODE_FILE);
  protected
    procedure _EXECUTE_; override;
  public
    procedure EXECUTE(const nodeRoot:tCopyRastNODE_ROOT; out NewROOT:tCopyRastNODE_ROOT); overload;
  end;

implementation


function tCopyRastSrcTree_itmH4ReNAMEs_FLDR.Processing:boolean;
begin
    result:=true;
    if prcssdITEM is tCopyRastNODE_FLDR then begin
        tCopyRastSrcTree_H4ReNAMEs(_OWNER_)._prc_AddNew_FLDR_(tCopyRastNODE_FLDR(prcssdITEM));
    end;
end;

function tCopyRastSrcTree_itmH4ReNAMEs_FILE.Processing:boolean;
begin
    result:=true;
    if prcssdITEM is tCopyRastNODE_FILE then begin
        tCopyRastSrcTree_H4ReNAMEs(_OWNER_)._prc_AddNew_FILE_(tCopyRastNODE_FILE(prcssdITEM));
    end;
end;

//------------------------------------------------------------------------------

const ccc='new_';

function tCopyRastSrcTree_H4ReNAMEs._getNewName_ROOT_(const item:tCopyRastNODE_ROOT):string;
begin
    result:=ccc+item.ItemNAME;
end;

function tCopyRastSrcTree_H4ReNAMEs._getNewName_BASE_(const item:tCopyRastNODE_BASE):string;
begin
    result:={ccc+}item.ItemNAME;
end;

function tCopyRastSrcTree_H4ReNAMEs._getNewName_MAIN_(const item:tCopyRastNODE_MAIN):string;
begin
    result:=ccc+item.ItemNAME;
end;

function tCopyRastSrcTree_H4ReNAMEs._getNewPATH_FLDR_(const item:tCopyRastNODE_FLDR):string;
begin
    result:={ccc+}item.fsPath;
end;

function tCopyRastSrcTree_H4ReNAMEs._getNewPATH_FILE_(const item:tCopyRastNODE_FILE):string;
begin
    result:={ccc+}item.fsPath;
end;

//------------------------------------------------------------------------------

procedure tCopyRastSrcTree_H4ReNAMEs._prc_setNew_BASE_(const item:tCopyRastNODE_BASE);
var tmp:tCopyRastNODE_BASE;
begin
    tmp:=tCopyRastNODE_BASE(_builder_.set_BASE(_newROOT_, _getNewName_BASE_(item)));
    CopyRastNODE_setLINK(item,tmp);
end;

procedure tCopyRastSrcTree_H4ReNAMEs._prc_setNew_MAIN_(const item:tCopyRastNODE_MAIN);
var tmp:tCopyRastNODE_MAIN;
begin
    tmp:=tCopyRastNODE_MAIN(_builder_.set_MAIN(_newROOT_, _getNewName_MAIN_(item)));
    CopyRastNODE_setLINK(item,tmp);
end;

procedure tCopyRastSrcTree_H4ReNAMEs._prc_AddNew_FLDR_(const item:tCopyRastNODE_FLDR);
var tmp:tCopyRastNODE_FLDR;
begin
    tmp:=tCopyRastNODE_FLDR(_builder_.add_FLDR(_newROOT_, _getNewPATH_FLDR_(item), item.inSearchPATHs ));
    CopyRastNODE_setLINK(item,tmp);
end;

procedure tCopyRastSrcTree_H4ReNAMEs._prc_AddNew_FILE_(const item:tCopyRastNODE_FILE);
var tmp:tCopyRastNODE_FILE;
begin
    tmp:=tCopyRastNODE_FILE(_builder_.add_FILE(_newROOT_, _getNewPATH_FILE_(item), item.fileKIND ));
    CopyRastNODE_setLINK(item,tmp);
end;

//------------------------------------------------------------------------------

procedure tCopyRastSrcTree_H4ReNAMEs._EXECUTE_;
begin
    EXECUTE_4TREE(tCopyRastSrcTree_itmH4ReNAMEs_FLDR);
    EXECUTE_4TREE(tCopyRastSrcTree_itmH4ReNAMEs_FILE);
end;


procedure tCopyRastSrcTree_H4ReNAMEs.EXECUTE(const nodeRoot:tCopyRastNODE_ROOT; out NewROOT:tCopyRastNODE_ROOT);
begin
    NewROOT:=tCopyRastNODE_ROOT(_builder_.crt_ROOT(_getNewName_ROOT_(nodeRoot)));
   _newROOT_:=NewROOT;
    CopyRastNODE_setLINK(nodeRoot,_newROOT_);
    //---
   _prc_setNew_BASE_(tCopyRastNODE_BASE(_builder_.fnd_BASE(nodeRoot)));
   _prc_setNew_MAIN_(tCopyRastNODE_MAIN(_builder_.fnd_MAIN(nodeRoot)));
    //---
    EXECUTE(nodeRoot);
end;


end.


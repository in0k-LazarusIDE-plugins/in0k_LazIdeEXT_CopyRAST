unit in0k_lazIdeSRC_CopyRAST_srcTree_HandlerReNAMEs;

{$mode objfpc}{$H+}

interface

uses

  in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,

srcTree_handler4build_CORE,


  in0k_lazIdeSRC_CopyRAST_srcTree_Nodes;

type


 tCopyRastSrcTree_itmH4ReNAMEs_BASE=class(tSrcTree_itmHandler4Build)
  public // ВЫПОЛНЕНИЕ
    function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;

 tCopyRastSrcTree_H4ReNAMEs=class(tSrcTree_prcHandler4Build)
  protected
   _newROOT_:tCopyRastNODE_ROOT;
  protected
    procedure _EXECUTE_; override;
  public
    procedure EXECUTE(const nodeRoot:tCopyRastNODE_ROOT; out NewROOT:tCopyRastNODE_ROOT);
  end;

implementation


function tCopyRastSrcTree_itmH4ReNAMEs_BASE.Processing:boolean;
begin
    result:=true;
    if prcssdITEM is tCopyRastNODE_BASE then begin
        // переименовать пАпку ОСНОВНУЮ папку



        // tCopyRastSrcTree_H4ReNAMEs(_OWNER_)._newROOT_;
    end;
end;

//------------------------------------------------------------------------------

procedure tCopyRastSrcTree_H4ReNAMEs._EXECUTE_;
begin
   _EXECUTE_4ROOT_(tCopyRastSrcTree_itmH4ReNAMEs_BASE);
end;


procedure tCopyRastSrcTree_H4ReNAMEs.EXECUTE(const nodeRoot:tCopyRastNODE_ROOT; out NewROOT:tCopyRastNODE_ROOT);
begin
   _newROOT_:=tCopyRastNODE_ROOT.Create('');

  //  _builder_.;

    inherited EXECUTE(nodeRoot);
    NewROOT:=_newROOT_;
   _resCopyRastOBJ_:=nil;
end;


end.


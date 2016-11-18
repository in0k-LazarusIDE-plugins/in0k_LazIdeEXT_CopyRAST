unit lazExt_CopyRAST_processingMCHN;

{$mode objfpc}{$H+}

interface

uses Classes,
    lazExt_CopyRAST_node_ROOT,
    prcNode_clearTargetDir,
    prcNode_createTargetDir,
    prcNode_copyFile,
    prcNode_PSF_updateUnit,
    prcNode_PSF_updateUses,
    Processing_CORE;

type

 tPrcMCHN_Base=class(tOprNodeEXECUTOR)
  private
   _prcList_:TList; //< список, который мы ЗАПУСТИМ
    procedure _prcList_CLR_;
  protected
    procedure prcList_Add(const prcType:tOperationNode_TYPE);
    procedure prcList_FILL; virtual;
  public
    procedure  EXECUTE;
  public
    constructor Create(const nodeRoot:tCopyRAST_ROOT);
    destructor DESTROY; override;
  end;

implementation

constructor tPrcMCHN_Base.Create(const nodeRoot:tCopyRAST_ROOT);
begin
    inherited CReate(nodeRoot);
   _prcList_:=tList.Create;
    prcList_FILL;
end;

destructor tPrcMCHN_Base.DESTROY;
begin
   _prcList_CLR_;
    inherited;
end;

//------------------------------------------------------------------------------

procedure tPrcMCHN_Base._prcList_CLR_;
begin
   _prcList_.Clear;
end;

procedure tPrcMCHN_Base.prcList_Add(const prcType:tOperationNode_TYPE);
begin
   _prcList_.Add(prcType);
end;

procedure tPrcMCHN_Base.prcList_FILL;
begin // заполняем некими специальными?
    prcList_Add(tPrcNODE_clearTargetDir);
    prcList_Add(tPrcNODE_createTargetDir);
    prcList_Add(tPrcNODE_copyFile);
    prcList_Add(tPrcNODE_PSF_updateUnit);
    prcList_Add(tPrcNODE_PSF_updateUses);
end;

//------------------------------------------------------------------------------

procedure tPrcMCHN_Base.EXECUTE;
var i:integer;
begin
   _make_log_Start_;
    for i:=0 to _prcList_.Count-1 do begin
       _EXECUTE_(tOperationNode_TYPE(_prcList_.Items[i]));
    end;
   _make_log_onEND_;
end;


end.


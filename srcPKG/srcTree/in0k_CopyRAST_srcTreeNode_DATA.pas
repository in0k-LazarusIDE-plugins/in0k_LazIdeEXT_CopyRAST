unit in0k_CopyRAST_srcTreeNode_DATA;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item;

type

 eCopyRastNODE_KIND=(CRNK_notVerified);
 tCopyRastNODE_KIND=set of eCopyRastNODE_KIND;

 rCopyRastNODE_DATA=record
   sideLeft :tSrcTree_item;
   sideRight:tSrcTree_item;
   NodeSTATE:tCopyRastNODE_KIND;
   NodeDATAs:pointer;
  end;
 pCopyRastNODE_DATA=^rCopyRastNODE_DATA;

procedure CopyRAST_srcTreeNodeDATA_Init(const data:pCopyRastNODE_DATA);
function  CopyRAST_srcTreeNodeDATAs_GET(const data:pCopyRastNODE_DATA):pointer;
procedure CopyRAST_srcTreeNodeDATAs_SET(const data:pCopyRastNODE_DATA; const value:pointer);

implementation

procedure CopyRAST_srcTreeNodeDATA_Init(const data:pCopyRastNODE_DATA);
begin
    with data^ do begin
        sideLeft :=nil;
        sideRight:=nil;
        NodeSTATE:=[];
        NodeDATAs:=nil;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function CopyRAST_srcTreeNodeDATAs_GET(const data:pCopyRastNODE_DATA):pointer;
begin
    result:=data^.NodeDATAs;
end;

procedure CopyRAST_srcTreeNodeDATAs_SET(const data:pCopyRastNODE_DATA; const value:pointer);
begin
    data^.NodeDATAs:=value;
end;

end.


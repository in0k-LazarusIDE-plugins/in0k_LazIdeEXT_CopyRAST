unit cmpCopyRAST_srcTree;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,

  in0k_lazIdeSRC_CopyRAST_srcTree_Nodes,
  in0k_lazExt_CopyRAST_cmpTree;

type

  tCmpCopyRAST_srcTree=class(tCmp_CopyRAST_Tree)
   public
     procedure Select_4Right(const item:tSrcTree_item);
     procedure Select_4Left (const item:tSrcTree_item);
   end;

implementation

procedure tCmpCopyRAST_srcTree.Select_4Right(const item:tSrcTree_item);
var i:integer;
  tmp:pointer;
begin
    ClearSelection;
    for i:=0 to self.Items.Count-1 do begin
        tmp:=Items.Item[i].Data;
        if Assigned(tmp) and
           isCopyRastNODE(tObject(tmp))
        then begin
            tmp:=CopyRastNODE_DATA(tObject(tmp));
            if Assigned(tmp) and
               (pCopyRastNODE_DATA(tmp)^.sideRight=item)
            then begin
                items[i].Selected:=TRUE;
            end;
        end;
    end;
end;

procedure tCmpCopyRAST_srcTree.Select_4Left(const item:tSrcTree_item);
var i:integer;
  tmp:pointer;
begin
    ClearSelection;
    for i:=0 to self.Items.Count-1 do begin
        tmp:=Items.Item[i].Data;
        if Assigned(tmp) and
           isCopyRastNODE(tObject(tmp))
        then begin
            tmp:=CopyRastNODE_DATA(tObject(tmp));
            if Assigned(tmp) and
               (pCopyRastNODE_DATA(tmp)^.sideLeft=item)
            then begin
                items[i].Selected:=TRUE;
            end;
        end;
    end;
end;


end.


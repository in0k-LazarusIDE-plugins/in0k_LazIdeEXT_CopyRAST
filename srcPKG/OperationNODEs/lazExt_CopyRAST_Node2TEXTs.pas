unit lazExt_CopyRAST_Node2TEXTs;

{$mode objfpc}{$H+}

interface

uses lazExt_CopyRAST_node;



function CopyRastNode2TEXTs_SRC(const Node:tCopyRAST_node):string;
function CopyRastNode2TEXTs_TRG(const Node:tCopyRAST_node):string;
function CopyRastNode2TEXTs    (const Node:tCopyRAST_node):string;

implementation

function CopyRastNode2TEXTs_SRC(const Node:tCopyRAST_node):string;
begin
    result:=node.ClassName+'('+node.Get_Source_fullName+')'
end;

function CopyRastNode2TEXTs_TRG(const Node:tCopyRAST_node):string;
begin
    result:=node.ClassName+'('+node.Get_Target_fullName+')'
end;

function CopyRastNode2TEXTs(const Node:tCopyRAST_node):string;
begin
    result:=node.ClassName+'('+node.Get_Source_fullName+'->'+node.Get_Target_fullName+')'
end;

end.


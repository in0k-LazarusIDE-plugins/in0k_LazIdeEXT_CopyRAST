unit lazExt_CopyRAST_TEXTs;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils;




function CopyRAST_Text_replaceFrom(const oldText:string):string;



function CopyRAST_Text_comment_InlineReplace_PAS(const oldText:string):string;

implementation

const
  cText_CopyRAST='CopyRAST';
  cText_CopyRAST_delimeter=':';


function CopyRAST_Text_replaceFrom(const oldText:string):string;
begin
    result:=cText_CopyRAST+cText_CopyRAST_delimeter+oldText;
end;

function CopyRAST_Text_comment_InlineReplace_PAS(const oldText:string):string;
begin
    result:='{<->'+CopyRAST_Text_replaceFrom(oldText)+'}';
end;

end.


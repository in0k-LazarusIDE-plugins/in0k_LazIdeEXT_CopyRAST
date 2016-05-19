unit lazExt_CopyRAST_node_File;

{$mode objfpc}{$H+}

interface

uses lazExt_CopyRAST_node,
  sysutils, LazFileUtils;


type

 tCopyRAST_node_File=class(tCopyRAST_node)
  protected
    function _getCaption_:string; override;
  end;

 tCopyRAST_node_FilePKG=class(tCopyRAST_node_File)
  end;

implementation

function tCopyRAST_node_File._getCaption_:string;
begin
    result:=ExtractFileName(_nodeText_);
end;

end.


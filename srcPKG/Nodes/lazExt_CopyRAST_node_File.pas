unit lazExt_CopyRAST_node_File;

{$mode objfpc}{$H+}

interface

uses lazExt_CopyRAST_node,
  sysutils, LazFileUtils;


type

 tCopyRAST_node_File=class(tCopyRAST_node)
  protected
    function _getCaption_ :string; override;
    function _getFileNAME_:string;
    function _getFilePATH_:string;
  public
    property FileNAME:string read _getFileNAME_;
    property FilePATH:string read _getFilePATH_;
  end;

 tCopyRAST_node_fileMain=class(tCopyRAST_node_File)

  end;

 tCopyRAST_node_fileMainPKG=class(tCopyRAST_node_fileMain)
  end;

implementation

function tCopyRAST_node_File._getCaption_:string;
begin
    result:=_getFileNAME_;
end;

function tCopyRAST_node_File._getFileNAME_:string;
begin
    result:=ExtractFileName(_nodeText_);
end;

function tCopyRAST_node_File._getFilePATH_:string;
begin
    result:=ExtractFileDir(_nodeText_);
end;

end.


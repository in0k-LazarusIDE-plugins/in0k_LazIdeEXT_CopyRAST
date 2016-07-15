unit lazExt_CopyRAST_node_File;

{$mode objfpc}{$H+}

interface

uses lazExt_CopyRAST_node, lazExt_CopyRAST_from_IDEProcs,
  PackageIntf,
  sysutils, LazFileUtils;


type

 tCopyRAST_node_File_CORE=class(tCopyRAST_node)
  protected
   _fileType_:TPkgFileType;
  protected
    function _getCaption_ :string; override;
    function _getFileNAME_:string;
    function _getFilePATH_:string;
    function _get_Old_PATH_:string;
    function _get_New_PATH_:string;
  public
    property FileNAME:string read _getFileNAME_;
    property FilePATH:string read _getFilePATH_;
    property FileTYPE:TPkgFileType read _fileType_;
  public
    //property Old_PATH:string;
    //property New_PATH:string;
  public
    function have_SingleLFM:boolean;
  public
    constructor Create(const FullFileName:string; const PkgFileType:TPkgFileType);
  end;

 tCopyRAST_node_FILE=class(tCopyRAST_node_File_CORE)
  end;

 tCopyRAST_node_fileMain_CORE=class(tCopyRAST_node_FILE)
  public
    constructor Create(const FullFileName:string);
  end;


 tCopyRAST_node_fileMainPKG=class(tCopyRAST_node_fileMain_CORE)
  end;

 tCopyRAST_node_fileMainPRJ=class(tCopyRAST_node_fileMain_CORE)
  end;

implementation


constructor tCopyRAST_node_File_CORE.Create(const FullFileName:string; const PkgFileType:TPkgFileType);
begin
    inherited Create(FullFileName);
   _fileType_:=PkgFileType;
end;

//------------------------------------------------------------------------------

function tCopyRAST_node_File_CORE._getCaption_:string;
begin
    result:=_getFileNAME_;
    //if FilenameIsPascalSource8HasResources(_nodeText_) then result:=result+' R'
end;

function tCopyRAST_node_File_CORE._getFileNAME_:string;
begin
    result:=ExtractFileName(_nodeText_);
end;

function tCopyRAST_node_File_CORE._getFilePATH_:string;
begin
    result:=ExtractFileDir(_nodeText_);
end;

//------------------------------------------------------------------------------

function tCopyRAST_node_File_CORE._get_Old_PATH_:string;
begin
    result:=_nodeText_;
end;

function tCopyRAST_node_File_CORE._get_New_PATH_:string;
begin

end;

//------------------------------------------------------------------------------

function tCopyRAST_node_File_CORE.have_SingleLFM:boolean;
begin
    // проверяем что есть ЕДИНСТВЕННЫЙ ребенок
    result:=Assigned(self._chldFrst_);
    if result then result:=NOT Assigned(tCopyRAST_node_File_CORE(self._chldFrst_)._next_);
    // проверим что этот ребенок LFM
    if result and (self._chldFrst_ is tCopyRAST_node_File_CORE) then begin
        result:=tCopyRAST_node_File_CORE(self._chldFrst_)._fileType_=pftLFM;
    end
    else result:=FALSE;
end;

//------------------------------------------------------------------------------

constructor tCopyRAST_node_fileMain_CORE.Create(const FullFileName:string);
begin
    inherited Create(FullFileName,pftMainUnit); //??? какой тип использовать
end;

end.


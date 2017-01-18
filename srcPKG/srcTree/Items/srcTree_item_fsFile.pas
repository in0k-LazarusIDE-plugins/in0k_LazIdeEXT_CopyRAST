unit srcTree_item_fsFile;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  srcTree_item_coreFileSystem;

type

 tSrcTree_item_fsFile=class(_tSrcTree_item_fsNodeFILE_)
  protected
   _fileType_:TPkgFileType;
  public
    property fileKIND:TPkgFileType read _fileType_;
  public
    constructor Create(const Text:string; const FileType:TPkgFileType); virtual;
    constructor Create(const Text:string); override;
  end;

implementation

constructor tSrcTree_item_fsFile.Create(const Text:string);
begin
    Create(Text,pftBinary);
end;

constructor tSrcTree_item_fsFile.Create(const Text:string; const FileType:TPkgFileType);
begin
    inherited Create(Text);
   _fileType_:=FileType;
end;

end.


unit lazExt_CopyRAST_node_ROOT_project;

{$mode objfpc}{$H+}

interface

uses //Dialogs,
    PackageIntf,
    lazExt_CopyRAST_node_File,
    lazExt_CopyRAST_node_Folder,
    lazExt_CopyRAST_node_ROOT;

type

 tCopyRAST_ROOT_project=class(tCopyRAST_ROOT)
  public
    procedure set_DirExpanded(const DirPath:string);
    procedure add_SearchPaths(const SrchPTH:string; const KIND:eCopyRAST_node_SrchPath);
    procedure add_ProjectFile(const FullFileName:string);
    procedure add_File       (const FullFileName:string; const FileType:TPkgFileType);
  end;



implementation

procedure tCopyRAST_ROOT_project.set_DirExpanded(const DirPath:string);
begin
   _set_BaseDIR_(DirPath);
end;

procedure tCopyRAST_ROOT_project.add_SearchPaths(const SrchPTH:string; const KIND:eCopyRAST_node_SrchPath);
begin
   _add_SrchPTH_(SrchPTH,KIND);
end;

procedure tCopyRAST_ROOT_project.add_ProjectFile(const FullFileName:string);
var fileXXX:tCopyRAST_node_fileMainPRJ;
begin
    fileXXX:=tCopyRAST_node_fileMainPRJ.Create(FullFileName);
   _add_FileXXX_(fileXXX);
end;

procedure tCopyRAST_ROOT_project.add_File(const FullFileName:string; const FileType:TPkgFileType);
var fileXXX:tCopyRAST_node_File;
begin
    fileXXX:=tCopyRAST_node_File.Create(FullFileName,FileType);
   _add_FileXXX_(fileXXX);
end;

end.


unit lazExt_CopyRAST_node_ROOT_package;

{$mode objfpc}{$H+}

interface

uses //Dialogs,
    lazExt_CopyRAST_node_File,
    lazExt_CopyRAST_node_Folder,
    lazExt_CopyRAST_node_ROOT;

type

 tCopyRAST_ROOT_package=class(tCopyRAST_ROOT)
  public
    procedure set_DirExpanded(const DirPath:string);
    procedure add_SearchPaths(const SrchPTH:string; const KIND:eCopyRAST_node_SrchPath);
    procedure add_PackageFile(const PkgFile:string);
    procedure add_File       (const PkgFile:string);
  end;



implementation

procedure tCopyRAST_ROOT_package.set_DirExpanded(const DirPath:string);
begin
   _set_BaseDIR_(DirPath);
end;

procedure tCopyRAST_ROOT_package.add_SearchPaths(const SrchPTH:string; const KIND:eCopyRAST_node_SrchPath);
begin
   _add_SrchPTH_(SrchPTH,KIND);
end;

procedure tCopyRAST_ROOT_package.add_PackageFile(const PkgFile:string);
var fileXXX:tCopyRAST_node_fileMainPKG;
begin
    fileXXX:=tCopyRAST_node_fileMainPKG.Create(PkgFile);
   _add_FileXXX_(fileXXX);
end;

procedure tCopyRAST_ROOT_package.add_File(const PkgFile:string);
var fileXXX:tCopyRAST_node_File;
begin
    //ShowMessage(PkgFile);
    fileXXX:=tCopyRAST_node_File.Create(PkgFile);
   _add_FileXXX_(fileXXX);
end;

end.


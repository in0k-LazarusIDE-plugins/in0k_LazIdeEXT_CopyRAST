unit lazExt_CopyRAST_wndProject;

{$mode objfpc}{$H+}

interface

uses lazExt_CopyRAST_wndCORE,
     lazExt_CopyRAST_StrConsts,
     ProjectIntf,
     lazExt_CopyRAST_node, lazExt_CopyRAST_node_Folder, lazExt_CopyRAST_node_File,
     lazExt_CopyRAST_node_ROOT_project,

  Classes, sysutils, LazFileUtils;

const
  clazExt_CopyRAST_wndProject_name='IDE_CopyRastPRJ_Tool';

type

  { Twnd_lazExt_CopyRAST_Project }

 Twnd_lazExt_CopyRAST_Project = class(Twnd_lazExt_CopyRAST_CORE)
  protected
    function _progect_:TLazProject; inline;
  protected
    procedure _onInit_prtnOBJs_; override;
  end;

implementation

{$R *.lfm}

function Twnd_lazExt_CopyRAST_Project._progect_:TLazProject;
begin
    result:=TLazProject(_parentOBJ_);
end;

procedure Twnd_lazExt_CopyRAST_Project._onInit_prtnOBJs_;
var asd:tCopyRAST_ROOT_project;
begin
    Caption:=cRes_CopyRAST_PRJ_name+' - '+_progect_.GetTitleOrName;
    //-------------------------------------
    asd:=tCopyRAST_ROOT_project.Create('PROJECT');



    asd.set_DirExpanded(ExtractFileDir(_progect_.ProjectInfoFile));
    asd.add_SearchPaths(_progect_.LazCompilerOptions.IncludePath   ,CopyRAST_node_SrchPTH__Fi);
    //asd.add_SearchPaths(_progect_.LazCompilerOptions.Libraries     ,CopyRAST_node_SrchPTH__Fl);
    asd.add_SearchPaths(_progect_.LazCompilerOptions.OtherUnitFiles,CopyRAST_node_SrchPTH__Fu);

    //asd.add_ProjectFile(_progect_.MainFile.Filename);

    {for i:=0 to _package_.FileCount-1 do begin
        pkgFile:=_package_.Files[i];
        asd.add_File(pkgFile.GetFullFilename,pkgFile.FileType);
    end;}
    //-------------------------------------
    ITV_SetUp(asd);
end;

//------------------------------------------------------------------------------


end.


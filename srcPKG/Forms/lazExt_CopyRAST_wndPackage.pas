unit lazExt_CopyRAST_wndPackage;

{$mode objfpc}{$H+}

interface

uses lazExt_CopyRAST_wndCORE,lazExt_CopyRAST_node_ROOT,
     lazExt_CopyRAST_StrConsts,
     lazExt_CopyRAST_node, lazExt_CopyRAST_node_Folder, lazExt_CopyRAST_node_File,
  PackageIntf,
  sysutils, Classes, ComCtrls;


const
  clazExt_CopyRAST_wndPackage_name='IDE_CopyRastPKG_Tool';

type

 { Twnd_lazExt_CopyRAST_Package }

 Twnd_lazExt_CopyRAST_Package = class(Twnd_lazExt_CopyRAST_CORE)
    procedure FormCreate(Sender: TObject);
  protected
    function _package_:TIDEPackage; inline;
  protected
    procedure _onInit_; override;
  end;

implementation

{$R *.lfm}

procedure Twnd_lazExt_CopyRAST_Package.FormCreate(Sender: TObject);
begin
    inherited;
    //---
    Caption:=cRes_CopyRAST_PKG_name;
end;

//------------------------------------------------------------------------------

function Twnd_lazExt_CopyRAST_Package._package_:TIDEPackage;
begin
    result:=TIDEPackage(_parentOBJ_);
end;

//------------------------------------------------------------------------------

procedure Twnd_lazExt_CopyRAST_Package._onInit_;
var tmp:TTreeNode;
  asd: tCopyRAST_ROOT;
begin
    Caption:=cRes_CopyRAST_PKG_name+' - '+ExtractFileName(_package_.Filename);
    //---
    tmp:=ITV_add_BasePath(_package_.DirectoryExpanded);
    //---
    ITV_add_Pkg_File(tmp,_package_.Filename);
    //---
    ITV_add_Pkg_Path(tmp,eCopyRAST_node_Path_Fu,_package_.LazCompilerOptions.OtherUnitFiles);
    ITV_add_Pkg_Path(tmp,eCopyRAST_node_Path_Fi,_package_.LazCompilerOptions.IncludePath);
    ITV_add_Pkg_Path(tmp,eCopyRAST_node_Path_Fl,_package_.LazCompilerOptions.Libraries);
    //-------------------------------------

    asd:=tCopyRAST_ROOT.Create('PACKAGE');
    asd.set_BaseDIR(_package_.DirectoryExpanded);
    //asd.Free;

    ITV_SetUp(asd);

end;

end.



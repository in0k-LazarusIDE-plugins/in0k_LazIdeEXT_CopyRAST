unit lazExt_CopyRAST_wndPackage;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
        in0k_lazIdeSRC_DEBUG,
     {$endIf}
    lazExt_CopyRAST_wndCORE,
     lazExt_CopyRAST_node_ROOT,
     lazExt_CopyRAST_node_ROOT_package,
       // srcTree_item_root4Package,
        srcTree_builder_4Package,

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
    procedure _onInit_prtnOBJs_; override;
    function  _copyRastObj_CRT_:tCopyRAST_ROOT; override;

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

procedure Twnd_lazExt_CopyRAST_Package._onInit_prtnOBJs_;
begin
    Caption:=cRes_CopyRAST_PKG_name+' - '+ExtractFileName(_package_.Filename);
end;

function Twnd_lazExt_CopyRAST_Package._copyRastObj_CRT_:tCopyRAST_ROOT;
var root:tCopyRAST_ROOT_package;
       i:integer;


    STB:tSrcTree_Builder_4Package;

begin
    result:=nil;
   { try root:=tCopyRAST_ROOT_package.Create('PACKAGE');
        //-------------------------------------
        root.set_DirExpanded(_package_.DirectoryExpanded);
        root.add_SearchPaths(_package_.LazCompilerOptions.OtherUnitFiles,CopyRAST_node_SrchPTH__Fu);
        root.add_SearchPaths(_package_.LazCompilerOptions.IncludePath   ,CopyRAST_node_SrchPTH__Fi);
        root.add_SearchPaths(_package_.LazCompilerOptions.Libraries     ,CopyRAST_node_SrchPTH__Fl);
        root.add_PackageFile(_package_.Filename);
        //-------------------------------------
        for i:=0 to _package_.FileCount-1 do begin
            with _package_.Files[i] do begin
                root.add_File(GetShortFilename(false),FileType);
                //root.add_File(GetFullFilename,FileType);
                //{$ifdef _DEBUG_}
                    //DEBUG(GetFullFilename);
                    //DEBUG(GetShortFilename(false));
                    //DEBUG(GetFileOwnerName);
                    //DEBUG(Filename);
                    //DEBUG(Filename);
                    //function GetFullFilename: string; virtual; abstract; // if no path, the file was not saved yet
                    //function GetShortFilename(UseUp: boolean): string; virtual; abstract;
                    //function GetFileOwner: TObject; virtual; abstract;
                    //function GetFileOwnerName: string; virtual; abstract;


                    //{$endIf}
			end;
        end;
        //-------------------------------------
        root.PREAPARE;
        //-------------------------------------
        result:=root;
    except root.free; root:=nil; end;    }

    //cmpCopyRAST_Tree.Root:=srcTree_builder_4Package_MAKE(_package_);

    STB:=tSrcTree_Builder_4Package.Create;
        //{$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','START at '+DateTimeToStr(NOW));{$endIf}
    cmpCopyRAST_Tree.Root:=STB.MAKE_SourceTREE(_package_);

        //{$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','START at '+DateTimeToStr(NOW));{$endIf}
    STB.FREE;
end;

end.



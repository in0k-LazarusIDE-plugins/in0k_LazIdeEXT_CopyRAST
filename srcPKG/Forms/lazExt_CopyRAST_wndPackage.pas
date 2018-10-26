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
         //in0k_CopyRAST_srcTree_Stage_0t1,
        in0k_lazIdeSRC_srcTree_item_Globals,
        in0k_CopyRAST_srcTree_ITEMs,
     //in0k_CopyRAST_stage__FileHandling,
    lazExt_CopyRAST_wndCORE,
     lazExt_CopyRAST_node_ROOT,
     lazExt_CopyRAST_node_ROOT_package,
       // srcTree_item_root4Package,
        in0k_lazIdeSRC_srcTree_4Package,
        srcTree_FNC,
     lazExt_CopyRAST_StrConsts,
     lazExt_CopyRAST_node, lazExt_CopyRAST_node_Folder, lazExt_CopyRAST_node_File,
        in0k_CopyRAST__STAGEs,
        in0k_lazIdeSRC_CopyRAST_srcTree,

  PackageIntf,
  sysutils, Classes, ComCtrls, ExtCtrls, StdCtrls, Dialogs;


const
  clazExt_CopyRAST_wndPackage_name='IDE_CopyRastPKG_Tool';

type

 { Twnd_lazExt_CopyRAST_Package }

 Twnd_lazExt_CopyRAST_Package = class(Twnd_lazExt_CopyRAST_CORE)
    Button4: TButton;
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  protected
    function _package_:TIDEPackage; inline;
  protected
    procedure _onInit_prtnOBJs_; override;
    function  _copyRastObj_CRT_:tCopyRAST_STAGEs; override;

  end;

implementation

{$R *.lfm}

procedure Twnd_lazExt_CopyRAST_Package.FormCreate(Sender: TObject);
begin
    inherited;
    //---
    Caption:=cRes_CopyRAST_PKG_name;
end;

procedure Twnd_lazExt_CopyRAST_Package.Button4Click(Sender: TObject);
//var tmp:tSrcTree_ROOT;
begin
   // if SaveDialog1.Execute then begin
      //  SrcTreeROOT_toGourceLOG(cmpCopyRAST_Tree.Root,SaveDialog1.FileName);
    //end;

  //  tmp:=cmpCopyRAST_Tree.Root;
    //cmpCopyRAST_Tree.Root:=NIL;
  //  cmpCopyRAST_Tree.Clear;
  //  tmp.FREE;
end;

//------------------------------------------------------------------------------

function Twnd_lazExt_CopyRAST_Package._package_:TIDEPackage;
begin
    result:=TIDEPackage(_parentOBJ_);
end;

//------------------------------------------------------------------------------

procedure Twnd_lazExt_CopyRAST_Package._onInit_prtnOBJs_;
begin
    inherited;
    Caption:=cRes_CopyRAST_PKG_name+' - '+ExtractFileName(_package_.Filename);
end;

function Twnd_lazExt_CopyRAST_Package._copyRastObj_CRT_:tCopyRAST_STAGEs;
{var root:tSrcTree_ROOT;
       i:integer;


 Builder:tCopyRastSrcTree_Builder4Package;
 P4Build:tCopyRastSrcTree_P4Build;

   Stage__0_1:tCopyRast_stage__FileHandling;
    }
begin
 {   result:=nil;
    // формируем ПЕРВЫЧНЫЙ список файлов
    Builder:=tCopyRastSrcTree_Builder4Package.Create;
    {$ifDef _DEBUG_}DEBUG(self.ClassName,'Builder START at '{+DateTimeToStr(NOW)});{$endIf}
    root:=CreateRoot4Package(Builder,_package_);
    {$ifDef _DEBUG_}DEBUG(self.ClassName,'Builder END at '{+DateTimeToStr(NOW)});{$endIf}
    // отображаем
    treeCopyRAST_First.Root:=tSrcTree_ROOT(root);

    //
    {root:=CopyRast_SrcTree_Copy(tCopyRastNODE_ROOT(root));
    // уточняем список по исходникам
    P4Build:=tCopyRastSrcTree_P4Build.Create;
    {$ifDef _DEBUG_}DEBUG(self.ClassName,'P4Build START at '{+DateTimeToStr(NOW)});{$endIf}
    P4Build.EXECUTE(_package_,Builder,root);
    {$ifDef _DEBUG_}DEBUG(self.ClassName,'P4Build END at '{+DateTimeToStr(NOW)});{$endIf}
    // отображаем   }
    treeCopyRAST_Second.Root:=root;

    Stage__0_1:=tCopyRast_stage__FileHandling.Create(Builder);

    Stage__0_1.EXECUTE(root);
    frmCopyRAST_STAGE_approveFILEs1.STAGE:=Stage__0_1;


    P4Build.FREE;
    Builder.FREE;
    }

    result:=tCopyRAST_STAGEs_4Package.Create(_package_);
end;

end.



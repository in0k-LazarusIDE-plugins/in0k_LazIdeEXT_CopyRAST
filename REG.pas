unit REG;

{$mode objfpc}{$H+}

interface

uses
  lazExt_CopyRAST,

MenuIntf,  SrcEditorIntf,  PackageIntf,
  Classes, SysUtils;

procedure Register;

implementation

var _expert_:tLazExt_CopyRAST;

 (*



type

  tMyCLS=class
  public
    procedure doEcho(const text:string);
  public
    function  doCreatePackage(Pkg:TIDEPackage):TIDEPackage;
  public
    procedure onPackage_File (f:TLazPackageFile);
    procedure onPackage_Files(Pkg:TIDEPackage);
    procedure onProjwct(Pkg:TIDEPackage);
  public
    procedure StartMyTool(Sender: TObject);
  end;

procedure tMyCLS.doEcho(const text:string);
var EditorW:TSourceEditorManagerInterface;
    EditorE:TSourceEditorInterface;
begin
  EditorE:=SourceEditorManagerIntf.ActiveEditor;
  //if EditorW=nil then exit;
  //EditorE:=EditorW.ActiveEditor;
  if EditorE=nil then exit;
  EditorE.Lines.Add(text);
end;

//------------------------------------------------------------------------------

const asd='_1';

function tMyCLS.doCreatePackage(Pkg:TIDEPackage):TIDEPackage;
begin
    result:=TIDEPackage.Create;
    Result.Name:=Pkg.Name+asd;
    //Result.DirectoryExpanded:=Pkg.DirectoryExpanded+asd;
end;

//------------------------------------------------------------------------------

procedure tMyCLS.onPackage_File(f:TLazPackageFile);

begin
    if not Assigned(f) then exit;
    doEcho(' ');
    doEcho(''+F.Filename);
    case f.FileType of
    pftUnit: doEcho('pftUnit');
    pftVirtualUnit: doEcho('pftVirtualUnit');
    pftMainUnit: doEcho('pftMainUnit');
    pftLFM: doEcho('pftLFM');
    pftLRS: doEcho('pftLRS');
    pftInclude: doEcho('pftInclude');
    pftIssues: doEcho('pftIssues');
    pftText: doEcho('pftText');
    pftBinary: doEcho('pftBinary');
    end;

end;

procedure tMyCLS.onPackage_Files(Pkg:TIDEPackage);
var i:integer;
   //tpkg
    f:TLazPackageFile;
begin
    for i:=0 to Pkg.FileCount-1 do begin
        f:=Pkg.Files[i];
        onPackage_File(f);
    end;
end;   *)

(*procedure tMyCLS.onProjwct(Pkg:TIDEPackage);
begin
    if not Assigned(Pkg) then exit;
    if not (Pkg.Name='in0k_LazIdeEXT_wndInspector_FF8S') then exit;
    //---
    doEcho('------------------------------------------------------------------');
    doEcho(Pkg.DirectoryExpanded+' DirectoryExpanded');
    doEcho(Pkg.Filename+' Pkg.Filename');
    doEcho(Pkg.Name+' Pkg.Name');
    doEcho('------------------------------------------------------------------');
    doEcho('pathSEARC='+pkg.LazCompilerOptions.SrcPath);

    doEcho('IncludePath='+pkg.LazCompilerOptions.IncludePath);
    doEcho('Libraries='+pkg.LazCompilerOptions.Libraries);
    doEcho('OtherUnitFiles='+pkg.LazCompilerOptions.OtherUnitFiles);
    doEcho('ObjectPath='+pkg.LazCompilerOptions.ObjectPath);
    doEcho('SrcPath='+pkg.LazCompilerOptions.SrcPath);
    doEcho('DebugPath='+pkg.LazCompilerOptions.DebugPath);
    doEcho('UnitOutputDirectory='+pkg.LazCompilerOptions.UnitOutputDirectory);
    doEcho('------------------------------------------------------------------');

    onPackage_Files(Pkg);


end; *)

(*procedure tMyCLS.StartMyTool(Sender: TObject);
var Pkg:TIDEPackage;
      i:integer;
begin
    for i:=0 to PackageEditingInterface.GetPackageCount-1 do begin
        Pkg:=PackageEditingInterface.GetPackages(i);
        onProjwct(Pkg);
    end;

   // writeln(PackageEditingInterface.GetPackages(i).Name);
  //...executed when menu item is clicked...   }
end; *)

//var tm:tMyCLS;

procedure Register;
begin
  //  RegisterIDEMenuCommand(itmSecondaryTools, 'MyTool','Start my tool',@(tm.StartMyTool));
    if not Assigned(_expert_) then begin
      _expert_:=tLazExt_CopyRAST.Create;
      _expert_.Expert_SetUP;
    end;


//  _expert_:=
 {
  // register the section for saving the package
  PkgEditMenuSectionSave:=RegisterIDEMenuSection(PackageEditorMenuRoot,'Save');
  AParent:=PkgEditMenuSectionSave;
  PkgEditMenuSave:=RegisterIDEMenuCommand(AParent, 'Save', lisPckEditSavePackage);

   }

end;

Initialization
  _expert_:=nil;
Finalization
  _expert_.Free;
end.


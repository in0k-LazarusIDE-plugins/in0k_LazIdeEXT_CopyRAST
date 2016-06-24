unit lazExt_CopyRAST;

{$mode objfpc}{$H+}

interface

uses in0k_lazIdeSRC_ExpertCORE,

     lazExt_CopyRAST_StrConsts,
     lazExt_CopyRAST_wndPackage,
     lazExt_CopyRAST_wndProject,
  MenuIntf, IDECommands, IDEWindowIntf, PackageIntf, LazIDEIntf, ProjectIntf,
  Classes, Controls, Forms, Menus;

type

 tLazExt_CopyRAST=class(tIn0k_lazIdeSRC_ExpertCORE)
  protected
    function _ide_GetPackageEditorForm(Sender:TObject):TCustomForm;
  protected
   _ideCommand_copyRast_Package_:TIDECommand;
    procedure _ideCommand_copyRast_Package_onClick(Sender:TObject);
    procedure _crt_IDEWnd_copyRast_Package_       (Sender:TObject; aFormName:string; var AForm:TCustomForm; DoDisableAutoSizing:boolean);
  protected
   _ideCommand_copyRast_Project_:TIDECommand;
    procedure _ideCommand_copyRast_Project_onClick(Sender:TObject);
    procedure _crt_IDEWnd_copyRast_Project_       (Sender:TObject; aFormName:string; var AForm:TCustomForm; DoDisableAutoSizing:boolean);
  protected
    procedure LazarusIDE_SetUP; override;
    procedure LazarusIDE_CLEAN; override;
  public
    constructor Create;
    destructor DESTROY;
  end;

implementation

constructor tLazExt_CopyRAST.Create;
begin
  _ideCommand_copyRast_Package_:=nil;
  _ideCommand_copyRast_Project_:=nil;
end;

destructor tLazExt_CopyRAST.DESTROY;
begin
   ///
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST._ide_GetPackageEditorForm(Sender:TObject):TCustomForm;
begin //< ПИЖЖЖЖЕНО: pkgmanager.pas(TPkgManager.GetPackageOfEditorItem)
    result:=nil;
    while (Sender is TMenuItem) and (TMenuItem(Sender).Parent<>nil) do Sender:=TMenuItem(Sender).Parent;
    if (Sender is TMenuItem) and (TMenuItem(Sender).Menu<>nil) then Sender:=TMenuItem(Sender).Menu;
    if (Sender is TComponent) and (TComponent(Sender).Owner is TCustomForm) then begin
        result:=TCustomForm(TComponent(Sender).Owner);
        {todo: добавить проверку типа in0k_lazIdeSRC_testFormIS_PackageEditor}
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_CopyRAST._ideCommand_copyRast_Package_onClick(Sender:TObject);
var Pkg:TIDEPackage;
    Frm:TCustomForm;
    wnd:TCustomForm;
begin
    Pkg:=PackageEditingInterface.GetPackageOfEditorItem(Sender);
    Frm:=_ide_GetPackageEditorForm(Sender);
    if Assigned(Pkg)and Assigned(Frm) then begin
        wnd:=IDEWindowCreators.ShowForm(clazExt_CopyRAST_wndPackage_name+'___'+Pkg.Name,true);
        if Assigned(wnd) then begin //< инициализируем окошко
            Twnd_lazExt_CopyRAST_Package(wnd).Init(Pkg,Frm);
        end;
    end
end;

procedure tLazExt_CopyRAST._crt_IDEWnd_copyRast_Package_(Sender:TObject; aFormName:string; var AForm:TCustomForm; DoDisableAutoSizing:boolean);
begin
    IDEWindowCreators.CreateForm(AForm,Twnd_lazExt_CopyRAST_Package,DoDisableAutoSizing,LazarusIDE.OwningComponent);
    AForm.Name:=aFormName;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_CopyRAST._ideCommand_copyRast_Project_onClick(Sender:TObject);
var Prj:TLazProject;
    Frm:TCustomForm;
    wnd:TCustomForm;
begin
    Prj:=LazarusIDE.ActiveProject;
    Frm:=_ide_GetPackageEditorForm(Sender);
    if Assigned(Prj)and Assigned(Frm) then begin
        wnd:=IDEWindowCreators.ShowForm(clazExt_CopyRAST_wndProject_name+'___'+Prj.Name,true);
        if Assigned(wnd) then begin //< инициализируем окошко
            Twnd_lazExt_CopyRAST_Project(wnd).Init(Prj,Frm);
        end;
    end
end;

procedure tLazExt_CopyRAST._crt_IDEWnd_copyRast_Project_(Sender:TObject; aFormName:string; var AForm:TCustomForm; DoDisableAutoSizing:boolean);
begin
    IDEWindowCreators.CreateForm(AForm,Twnd_lazExt_CopyRAST_Project,DoDisableAutoSizing,LazarusIDE.OwningComponent);
    AForm.Name:=aFormName;
end;

//------------------------------------------------------------------------------

procedure tLazExt_CopyRAST.LazarusIDE_SetUP;
var Cat:TIDECommandCategory;
begin
    inherited;
    //---
    // add IDE commands
    Cat:=IDECommandList.FindCategoryByName(CommandCategoryCodeTools);
   _ideCommand_copyRast_Package_:=RegisterIDECommand(Cat, cRes_CopyRAST_PKG_desc,cRes_CopyRAST_PKG_desc, @_ideCommand_copyRast_Package_onClick);
   _ideCommand_copyRast_Project_:=RegisterIDECommand(Cat, cRes_CopyRAST_PRJ_desc,cRes_CopyRAST_PRJ_desc, @_ideCommand_copyRast_Project_onClick);
    //---
    // add a menu item in the package editor
    RegisterIDEMenuCommand(PkgEditMenuSectionSave, 'ViewCopyRastPKG',
        cRes_CopyRAST_caption, nil,nil, _ideCommand_copyRast_Package_,'');
    RegisterIDEMenuCommand(itmProjectSaveSection, 'ViewCopyRastPRJ',
        cRes_CopyRAST_caption, nil,nil, _ideCommand_copyRast_Project_,'');
    //---
    // register window creator
    IDEWindowCreators.Add(clazExt_CopyRAST_wndPackage_name,nil,@_crt_IDEWnd_copyRast_Package_,'250','250','','','',alNone,true);
    IDEWindowCreators.Add(clazExt_CopyRAST_wndProject_name,nil,@_crt_IDEWnd_copyRast_Project_,'250','250','','','',alNone,true);
end;

procedure tLazExt_CopyRAST.LazarusIDE_CLEAN;
begin
    inherited;
end;

end.


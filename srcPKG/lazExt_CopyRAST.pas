unit lazExt_CopyRAST;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.


uses in0k_lazIdeSRC_ExpertCORE,
     Dialogs, sysutils,
     {in0k_lazIdeSRC_ExpertCORE,}
     //in0k_lazIdeSRC_ExpertCORE,
     (*in0k_lazIdeSRC_ExpertCORE,*)
     lazExt_CopyRAST_StrConsts,
     {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
     in0k_CopyRAST__wndPackage,
     in0k_CopyRAST__wndProject,


  MenuIntf, IDECommands, IDEWindowIntf, PackageIntf, LazIDEIntf, ProjectIntf,
  Classes, Controls, Forms, Menus;

{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}


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
    destructor DESTROY; override;
  end;

implementation
uses LCLVersion;

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

procedure tLazExt_CopyRAST._crt_IDEWnd_copyRast_Project_(Sender:TObject; aFormName:string; var AForm:TCustomForm; DoDisableAutoSizing:boolean);
begin
    if CompareText(aFormName,tWndCopyRAST_Progect.ide_CoreName)=0 then begin
        IDEWindowCreators.CreateForm(AForm,tWndCopyRAST_Progect,DoDisableAutoSizing,Application);
    end;
end;

procedure tLazExt_CopyRAST._ideCommand_copyRast_Project_onClick(Sender:TObject);
var srcMain:TLazProject;
    srcForm:TCustomForm;
var trgName:string;
    trgForm:TCustomForm;
begin
    srcMain:= LazarusIDE.ActiveProject;
    srcForm:=_ide_GetPackageEditorForm(Sender);
    if Assigned(srcMain)and Assigned(srcForm) then begin //< есть над чем работать
        trgName:=tWndCopyRAST_Progect.ide_Name4OBJ(srcMain);
        trgForm:=Screen.FindForm(trgName);
        if NOT Assigned(trgForm) then begin //< надо СОЗДАВАТЬ
            trgForm:=IDEWindowCreators.ShowForm(tWndCopyRAST_Progect.ide_CoreName,FALSE);
            tWndCopyRAST_Progect(trgForm).Init (srcMain,srcForm);
            {$ifdef _DEBUG_}
                DEBUG('_ideCommand_copyRast_Package_onClick',trgName+' wnd Create and INIT.');
            {$endIf}
        end;
        IDEWindowCreators.ShowForm(trgForm,true);
        {$ifdef _DEBUG_}
            DEBUG('_ideCommand_copyRast_Package_onClick',trgName+' wnd SHOW.');
        {$endIf}
    end
    {$ifdef _DEBUG_}
    else begin
         if not Assigned(srcMain) then DEBUG('_ideCommand_copyRast_Project_onClick', 'FaIL not Assigned(Pkg)');
         if not Assigned(srcForm) then DEBUG('_ideCommand_copyRast_Project_onClick', 'FaIL not Assigned(Frm)');
    end;
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tLazExt_CopyRAST._crt_IDEWnd_copyRast_Package_(Sender:TObject; aFormName:string; var AForm:TCustomForm; DoDisableAutoSizing:boolean);
begin
    if CompareText(aFormName,tWndCopyRAST_Package.ide_CoreName)=0 then begin
        IDEWindowCreators.CreateForm(AForm,tWndCopyRAST_Package,DoDisableAutoSizing,Application);
    end;
end;

procedure tLazExt_CopyRAST._ideCommand_copyRast_Package_onClick(Sender:TObject);
var tmp    :tObject;
var srcMain:TIDEPackage;
    srcForm:TCustomForm;
var trgName:string;
    trgForm:TCustomForm;

begin
    {$ifdef _DEBUG_}
        DEBUG('_ideCommand_copyRast_Package_onClick', 'sender is '+sender.ClassName);
    {$endIf}
    {%region --- определение способа поиска ----------------------- /fold}
    // тут возможно в разных версиях Лазаруса придется поступать по разному
    {$if     (lcl_major=1) and (lcl_minor=4) and (lcl_release=4)}
        {$WARNING 'NOT Tested in this LazarusIDE version'}
        tmp:=Sender;
    {$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=0)}
        tmp:=Sender;
    {$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=2) and (lcl_patch=0)}
        tmp:=TIDEMenuCommand(sender).MenuItem;
    {$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=4) and (lcl_patch=0)}
        tmp:=TIDEMenuCommand(sender).MenuItem;
    {$elseif (lcl_major=1) and (lcl_minor=8) and (lcl_release=0)}
        tmp:=TIDEMenuCommand(sender).MenuItem;
    {$else} //< способ по умолчанию
        {$WARNING 'NOT Tested in this LazarusIDE version'}
        tmp:=Sender;
    {$endif}
    {%endregion}
    srcMain:= PackageEditingInterface.GetPackageOfEditorItem(tmp);
    srcForm:=_ide_GetPackageEditorForm(tmp);
    if Assigned(srcMain)and Assigned(srcForm) then begin //< есть над чем работать
        trgName:=tWndCopyRAST_Package.ide_Name4OBJ(srcMain);
        trgForm:=Screen.FindForm(trgName);
        if NOT Assigned(trgForm) then begin //< надо СОЗДАВАТЬ
            trgForm:=IDEWindowCreators.ShowForm(tWndCopyRAST_Package.ide_CoreName,FALSE);
            tWndCopyRAST_Package(trgForm).Init (srcMain,srcForm);
            {$ifdef _DEBUG_}
                DEBUG('_ideCommand_copyRast_Package_onClick',trgName+' wnd Create and INIT.');
            {$endIf}
        end;
        IDEWindowCreators.ShowForm(trgForm,true);
        {$ifdef _DEBUG_}
            DEBUG('_ideCommand_copyRast_Package_onClick',trgName+' wnd SHOW.');
        {$endIf}
    end
    {$ifdef _DEBUG_}
    else begin
         if not Assigned(srcMain) then DEBUG('_ideCommand_copyRast_Package_onClick', 'FaIL not Assigned(Pkg)');
         if not Assigned(srcForm) then DEBUG('_ideCommand_copyRast_Package_onClick', 'FaIL not Assigned(Frm)');
    end;
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tLazExt_CopyRAST.LazarusIDE_SetUP;
var Cat:TIDECommandCategory;
begin
    inherited;
    //---
    in0k_lazIdeSRC_DEBUG.LazarusIDE_SetUP(self.ClassName);
    //in0k_lazIdeSRC_DEBUG.LazarusIDE_ShowDBG;
    //---

    // add IDE commands
    Cat:=IDECommandList.FindCategoryByName(CommandCategoryCodeTools);
   _ideCommand_copyRast_Package_:=RegisterIDECommand(Cat, cRes_CopyRAST_PKG_desc,cRes_CopyRAST_PKG_desc, @_ideCommand_copyRast_Package_onClick);
   _ideCommand_copyRast_Project_:=RegisterIDECommand(Cat, cRes_CopyRAST_PRJ_desc,cRes_CopyRAST_PRJ_desc, @_ideCommand_copyRast_Project_onClick);
    //---
    // add a menu item in the package editor
    RegisterIDEMenuCommand(PkgEditMenuSectionSave, 'ViewCopyRastPKG', cRes_CopyRAST_caption, nil,nil, _ideCommand_copyRast_Package_,'');
    RegisterIDEMenuCommand(itmProjectSaveSection,  'ViewCopyRastPRJ', cRes_CopyRAST_caption, nil,nil, _ideCommand_copyRast_Project_,'');
    //---
    // register window creator
    IDEWindowCreators.Add(tWndCopyRAST_Progect.ide_CoreName,nil,@_crt_IDEWnd_copyRast_Project_,'100','100','','','',alNone,true);
    IDEWindowCreators.Add(tWndCopyRAST_Package.ide_CoreName,nil,@_crt_IDEWnd_copyRast_Package_,'100','100','','','',alNone,true);
end;

procedure tLazExt_CopyRAST.LazarusIDE_CLEAN;
begin
    inherited;
    in0k_lazIdeSRC_DEBUG.LazarusIDE_CLEAR;
end;

end.


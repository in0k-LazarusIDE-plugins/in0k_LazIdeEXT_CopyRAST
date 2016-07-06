unit lazExt_CopyRAST_wndCORE;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.


uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}

     IDEImagesIntf, PackageIntf,
     lazExt_CopyRAST_FuckUpForm,


    lazExt_CopyRAST_node_ROOT,
    lazExt_CopyRAST_node_ROOT_package,


     lazExt_CopyRAST_node, lazExt_CopyRAST_node_File,
     lazExt_CopyRAST_node_Folder, Classes, SysUtils, FileUtil, Forms, Controls,
     Graphics, Dialogs, ComCtrls, ExtCtrls, StdCtrls, LazFileUtils;

type

 { Twnd_lazExt_CopyRAST_CORE }

 Twnd_lazExt_CopyRAST_CORE = class(TForm)
    Button1: TButton;
    ItemsTreeView: TTreeView;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ItemsTreeViewAdvancedCustomDraw(Sender: TCustomTreeView;
      const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure ItemsTreeViewDeletion(Sender: TObject; Node: TTreeNode);
  protected
   _FuckUpForm_:tLazExt_CopyRAST_FuckUpForm;
  protected
   _parentOBJ_:TObject;        //< объект над которым работаем (LazIDE)
   _parentFRM_:TCustomForm;    //< форма которая нас вызвала (LazIDE)
    procedure _onInit_prtnOBJs_; virtual;
    procedure _reInit_copyRast_;
    function  _copyRastObj_CRT_:tCopyRAST_ROOT; virtual;
  protected
   _cpRastObj_:tCopyRAST_ROOT; //< объект над которым работаем
  public
    procedure Init(const ParentOBJ:TObject; const ParentFRM:TCustomForm);
  protected
    function _ITV_getNodeImageIndex_(const TreeNode:tTreeNode):integer;
  public
    procedure _ITV_SetUp_nodeImage_(const TreeNode:tTreeNode);
    procedure _ITV_SetUp_         (const TreeNode:tTreeNode);
    procedure  ITV_SetUp (const ROOT:tCopyRAST_ROOT);
  public
    //function  ITV_add_BasePath(const Path:string):TTreeNode;
    //function  ITV_add_Pkg_File(const Prnt:TTreeNode; const fileName:string):TTreeNode;
    //procedure ITV_add_Pkg_Path(const Prnt:TTreeNode; const PathType:eCopyRAST_node_Path; const Paths:string);
  public
    constructor Create(AOwner:TComponent); override;
    destructor DESTROY; override;
  end;


implementation

{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if defined(in0k_lazIdeSRC_FuckUpForm___DebugLOG) AND declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется
    //                       моя "система имен и папок"
    {$define _debugLOG_}     //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debugLOG_}
{$endIf}
{%endregion}


var

  vITV_BasePath:integer; // базовый путь
  vITV_package :integer; // ГЛАВНЫЙ файл ПАКЕТА
  vITV_project :integer; // ГЛАВНЫЙ файл ПРИЛОЖЕНИЯ
  vITV_Folder  :integer; // Папка (директория)
  vITV_Files   :integer; // Группа фалов
  vITV_File    :integer; // некий файл


  ImageIndexFiles: integer;
  ImageIndexRemovedFiles: integer;
  ImageIndexRequired: integer;
  ImageIndexRemovedRequired: integer;
  ImageIndexUnit: integer;
  ImageIndexRegisterUnit: integer;
  ImageIndexLFM: integer;
  ImageIndexLRS: integer;
  ImageIndexInclude: integer;
  ImageIndexIssues: integer;
  ImageIndexText: integer;
  ImageIndexBinary: integer;
  ImageIndexConflict: integer;
  ImageIndexDirectory: integer;


{$R *.lfm}

constructor Twnd_lazExt_CopyRAST_CORE.Create(AOwner:TComponent);
begin
    inherited Create(AOwner);
   _FuckUpForm_:=tLazExt_CopyRAST_FuckUpForm.Create(self);
   _parentOBJ_:=nil;
   _parentFRM_:=nil;
   _cpRastObj_:=nil;
end;

destructor Twnd_lazExt_CopyRAST_CORE.DESTROY;
begin
    if Assigned(_cpRastObj_) then _cpRastObj_.FREE;
    //---
   _FuckUpForm_.ParentForm_CLEAR; //< после этого, можно спокойно уничтожаться
   _FuckUpForm_.FREE;
    //---
    inherited DESTROY;
end;

//------------------------------------------------------------------------------

procedure Twnd_lazExt_CopyRAST_CORE.FormCreate(Sender: TObject);
begin
    //---
    ItemsTreeView.Images:=IDEImages.Images_16;
    vITV_BasePath:= IDEImages.LoadImage(16, 'folder');
    vITV_package := IDEImages.LoadImage(16, 'item_package');
    vITV_project := IDEImages.LoadImage(16, 'item_project');
    vITV_Folder  := IDEImages.LoadImage(16, 'folder');
    vITV_Files   := IDEImages.LoadImage(16, 'pkg_files');


    vITV_File    := IDEImages.LoadImage(16, 'pkg_text');


    ImageIndexFiles           := IDEImages.LoadImage(16, 'pkg_files');
    ImageIndexRemovedFiles    := IDEImages.LoadImage(16, 'pkg_removedfiles');
    ImageIndexRequired        := IDEImages.LoadImage(16, 'pkg_required');
    ImageIndexRemovedRequired := IDEImages.LoadImage(16, 'pkg_removedrequired');
    ImageIndexUnit            := IDEImages.LoadImage(16, 'pkg_unit');
    ImageIndexRegisterUnit    := IDEImages.LoadImage(16, 'pkg_registerunit');
    ImageIndexLFM             := IDEImages.LoadImage(16, 'pkg_lfm');
    ImageIndexLRS             := IDEImages.LoadImage(16, 'pkg_lrs');
    ImageIndexInclude         := IDEImages.LoadImage(16, 'pkg_include');
    ImageIndexIssues          := IDEImages.LoadImage(16, 'pkg_issues');
    ImageIndexText            := IDEImages.LoadImage(16, 'pkg_text');
    ImageIndexBinary          := IDEImages.LoadImage(16, 'pkg_binary');
    ImageIndexConflict        := IDEImages.LoadImage(16, 'pkg_conflict');
    ImageIndexDirectory       := IDEImages.LoadImage(16, 'pkg_files');
end;

procedure Twnd_lazExt_CopyRAST_CORE.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
    {$ifDEF _debugLOG_}
    case CloseAction of
        caNone: DEBUG('Twnd_lazExt_CopyRAST_CORE','FormClose - caNone');
        caHide: DEBUG('Twnd_lazExt_CopyRAST_CORE','FormClose - caHide');
        caFree: DEBUG('Twnd_lazExt_CopyRAST_CORE','FormClose - caFree');
        caMinimize: DEBUG('Twnd_lazExt_CopyRAST_CORE','FormClose - caMinimize');
    end;
    {$endIf}
   _FuckUpForm_.ParentForm_CLEAR; //< после этого, можно спокойно уничтожаться
    CloseAction:=caFree;
end;

procedure Twnd_lazExt_CopyRAST_CORE.FormDestroy(Sender: TObject);
begin
    {$ifDEF _debugLOG_}
    DEBUG('Twnd_lazExt_CopyRAST_CORE','FormDestroy_000');
    {$endIf}
    //---
    //ItemsTreeView.Items.Clear;
    {$ifDEF _debugLOG_}
    DEBUG('Twnd_lazExt_CopyRAST_CORE','FormDestroy_001');
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure Twnd_lazExt_CopyRAST_CORE.Button1Click(Sender: TObject);
begin
   _reInit_copyRast_;
end;


//------------------------------------------------------------------------------


procedure Twnd_lazExt_CopyRAST_CORE.ItemsTreeViewAdvancedCustomDraw(
  Sender: TCustomTreeView; const ARect: TRect; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
begin
    sender.Canvas.Font.Color:=clRed;
    sender.Font.Color:=clGreen;
end;

procedure Twnd_lazExt_CopyRAST_CORE.ItemsTreeViewDeletion(Sender:TObject; Node:TTreeNode);
begin
    if Assigned(Node) and Assigned(node.Data) then begin
       tCopyRAST_node(node.Data).FREE;
       node.Data:=nil;
    end;
end;

//------------------------------------------------------------------------------

procedure Twnd_lazExt_CopyRAST_CORE.Init(const ParentOBJ:TObject; const ParentFRM:TCustomForm);
begin
   if Assigned(ParentOBJ) and Assigned(ParentFRM) then begin
        if (_parentOBJ_<>ParentOBJ)and(_parentFRM_<>ParentFRM) then begin
           _parentOBJ_:=ParentOBJ;
           _parentFRM_:=ParentFRM;
        //   _onInit_prtnOBJs_;
        //   _reInit_copyRast_;
            //---
           _FuckUpForm_.Form:=ParentFRM;
        end;
    end;
end;

procedure Twnd_lazExt_CopyRAST_CORE._onInit_prtnOBJs_;
begin
   //
end;

procedure Twnd_lazExt_CopyRAST_CORE._reInit_copyRast_;
begin
    ItemsTreeView.BeginUpdate;
    ItemsTreeView.Items.Clear;
    ItemsTreeView.EndUpdate;
    //---
    if Assigned(_cpRastObj_) then _cpRastObj_.FREE;
   _cpRastObj_:=_copyRastObj_CRT_;
    //---
    if Assigned(_cpRastObj_)
    then ITV_SetUp(_cpRastObj_);
end;

function Twnd_lazExt_CopyRAST_CORE._copyRastObj_CRT_:tCopyRAST_ROOT;
begin

end;

//------------------------------------------------------------------------------

function Twnd_lazExt_CopyRAST_CORE._ITV_getNodeImageIndex_(const TreeNode:tTreeNode):integer;
var tmp:tCopyRAST_node;
begin
    result:=-1;
    //---
    if not Assigned(TreeNode) then EXIT;
    tmp:=tCopyRAST_node(TreeNode.Data);
    if not Assigned(tmp) then EXIT;
    if tmp is tCopyRAST_node_Folder then begin
        if tmp is tCopyRAST_node_BaseDIR then result:=vITV_BasePath
       else begin
            result:=vITV_Folder;
            if tCopyRAST_node_Folder(tmp).inPATHs<>[] then result:=vITV_Files
        end;
    end
   else
    if tmp is tCopyRAST_node_File then begin
        result:=vITV_File;
        if tmp is tCopyRAST_node_fileMain_CORE then begin
            result:=vITV_package;
            if tmp is tCopyRAST_node_fileMainPKG then result:=vITV_package;
        end
        else begin
            case tCopyRAST_node_FILE(tmp).FileTYPE of
                pftUnit,pftVirtualUnit,pftMainUnit:
                            Result:=ImageIndexUnit;
                pftLFM:     Result:=ImageIndexLFM;
                pftLRS:     Result:=ImageIndexLRS;
                pftInclude: Result:=ImageIndexInclude;
                pftIssues:  Result:=ImageIndexIssues;
                pftText:    Result:=ImageIndexText;
                pftBinary:  Result:=ImageIndexBinary;
                else        Result:=-1;
            end;
        end;
    end;
end;

procedure Twnd_lazExt_CopyRAST_CORE._ITV_SetUp_nodeImage_(const TreeNode:tTreeNode);
var tmp:tCopyRAST_node;
begin
    if not Assigned(TreeNode) then EXIT;
    //---
    TreeNode.SelectedIndex:=_ITV_getNodeImageIndex_(TreeNode);
    TreeNode.ImageIndex   := TreeNode.SelectedIndex;
end;



procedure Twnd_lazExt_CopyRAST_CORE._ITV_SetUp_(const TreeNode:tTreeNode);
var itm:tTreeNode;
    tmp:tCopyRAST_node;
begin
    if not Assigned(TreeNode) then EXIT;
    //---
    tmp:=tCopyRAST_node(TreeNode.Data);
    if not Assigned(tmp) then EXIT;
    //---
    tmp:=tmp.NodeCHLD;
    while Assigned(tmp) do begin
        itm:=ItemsTreeView.Items.AddChildObject(TreeNode,tmp.Caption,tmp);
        //itm.Expanded:=TRUE;
       _ITV_SetUp_nodeImage_(itm);
       _ITV_SetUp_(itm);
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;

procedure Twnd_lazExt_CopyRAST_CORE.ITV_SetUp(const ROOT:tCopyRAST_ROOT);
var tmp:tTreeNode;
begin
    tmp:=ItemsTreeView.Items.AddChildObjectFirst(nil,ROOT.Caption,ROOT);
    //tmp.Expanded:=TRUE;
   _ITV_SetUp_(tmp);
    //---
//    ItemsTreeView.;
end;



















end.



function TrimSearchPath(const SearchPath, BaseDirectory: string;
  DeleteDoubles: boolean; ExpandPaths: boolean): string;
var
  CurPath: String;
  EndPos: Integer;
  StartPos: Integer;
  len: Integer;
  BaseDir: String;
begin
  Result:='';
  EndPos:=1;
  len:=length(SearchPath);
  BaseDir:=AppendPathDelim(TrimFilename(BaseDirectory));
  while EndPos<=len do begin
    StartPos:=EndPos;
    // skip empty paths and space chars at start
    while (StartPos<=len) and (SearchPath[StartPos] in [';',#0..#32]) do
      inc(StartPos);
    if StartPos>len then break;
    EndPos:=StartPos;
    while (EndPos<=len) and (SearchPath[EndPos]<>';') do inc(EndPos);
    CurPath:=copy(SearchPath,StartPos,EndPos-StartPos);
    if CurPath<>'' then begin
      // non empty path => expand, trim and normalize
      if ExpandPaths then
        CurPath:=TrimAndExpandDirectory(CurPath,BaseDir)
      else if (BaseDir<>'') and (not FilenameIsAbsolute(CurPath)) then
        CurPath:=BaseDir+CurPath;
      CurPath:=ChompPathDelim(TrimFilename(CurPath));
      if CurPath='' then CurPath:='.';
      // check if path already exists
      if (not DeleteDoubles) or (SearchDirectoryInSearchPath(Result,CurPath)<1)
      then begin
        if Result<>'' then
          CurPath:=';'+CurPath;
        if CurPath<>'' then
          Result:=Result+CurPath
        else
          Result:=Result+'.';
      end;
    end;
  end;
end;







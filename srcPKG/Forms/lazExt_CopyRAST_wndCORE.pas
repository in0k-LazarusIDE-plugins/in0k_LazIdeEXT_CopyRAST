unit lazExt_CopyRAST_wndCORE;

{$mode objfpc}{$H+}

interface

uses IDEImagesIntf,

    lazExt_CopyRAST_node_ROOT,
    lazExt_CopyRAST_node_ROOT_package,


     lazExt_CopyRAST_node, lazExt_CopyRAST_node_File, lazExt_CopyRAST_node_Folder,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls, LazFileUtils;

type

 { Twnd_lazExt_CopyRAST_CORE }

 Twnd_lazExt_CopyRAST_CORE = class(TForm)
    ItemsTreeView: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure ItemsTreeViewAdvancedCustomDraw(Sender: TCustomTreeView;
      const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure ItemsTreeViewDeletion(Sender: TObject; Node: TTreeNode);
  protected
   _parentOBJ_:TObject;
   _parentFRM_:TCustomForm;
   _BaseDirectory_:TTreeNode;
    procedure _onInit_; virtual;
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
  end;


implementation

var

  vITV_BasePath:integer;
  vITV_package :integer;
  vITV_project :integer;
  vITV_Folder  :integer;
  vITV_Files   :integer;
  vITV_File    :integer;


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

procedure Twnd_lazExt_CopyRAST_CORE.FormCreate(Sender: TObject);
begin
   _parentOBJ_:=nil;
   _parentFRM_:=nil;
    //---
    ItemsTreeView.Images:=IDEImages.Images_16;
    vITV_BasePath:= IDEImages.LoadImage(16, 'pkg_files');
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
           _BaseDirectory_:=nil;
           _onInit_;
        end;
    end;
end;

procedure Twnd_lazExt_CopyRAST_CORE._onInit_;
begin
   //
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
        if tmp is tCopyRAST_node_fileMain then begin
            result:=vITV_package;
            if tmp is tCopyRAST_node_fileMainPKG then result:=vITV_package;
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
   _ITV_SetUp_(tmp);
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







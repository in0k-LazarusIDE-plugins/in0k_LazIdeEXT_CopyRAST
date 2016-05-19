unit lazExt_CopyRAST_wndCORE;

{$mode objfpc}{$H+}

interface

uses IDEImagesIntf,  lazExt_CopyRAST_node_ROOT,
     lazExt_CopyRAST_node, lazExt_CopyRAST_node_File, lazExt_CopyRAST_node_Folder,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls, LazFileUtils;

type

 { Twnd_lazExt_CopyRAST_CORE }

 Twnd_lazExt_CopyRAST_CORE = class(TForm)
    ItemsTreeView: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure ItemsTreeViewDeletion(Sender: TObject; Node: TTreeNode);
  protected
   _parentOBJ_:TObject;
   _parentFRM_:TCustomForm;
   _BaseDirectory_:TTreeNode;
    procedure _onInit_; virtual;
  public
    procedure Init(const ParentOBJ:TObject; const ParentFRM:TCustomForm);
  protected
    function _getITV__BasePath_parentDir(const PathType:eCopyRAST_node_Path; const Paths:string):TTreeNode;

  public
    procedure _ITV_SetUp_(const TreeNode:tTreeNode);
    procedure  ITV_SetUp (const ROOT:tCopyRAST_ROOT);
  public
    function  ITV_add_BasePath(const Path:string):TTreeNode;
    function  ITV_add_Pkg_File(const Prnt:TTreeNode; const fileName:string):TTreeNode;
    procedure ITV_add_Pkg_Path(const Prnt:TTreeNode; const PathType:eCopyRAST_node_Path; const Paths:string);
  end;


implementation

var

  vITV_BasePath:integer;
  vITV_package :integer;
  vITV_Files   :integer;


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
    vITV_Files   := IDEImages.LoadImage(16, 'pkg_files');


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

function Twnd_lazExt_CopyRAST_CORE.ITV_add_BasePath(const Path:string):TTreeNode;
var nodeData:tCopyRAST_node_Dir_BASE;
begin
    nodeData:=tCopyRAST_node_Dir_BASE.Create(AppendPathDelim(TrimFilename(Path)));
    //---
   _BaseDirectory_:=ItemsTreeView.Items.AddChildObjectFirst(nil,nodeData.Caption,nodeData);
   _BaseDirectory_.ImageIndex   :=vITV_BasePath;
   _BaseDirectory_.SelectedIndex:=vITV_BasePath;
    //---
    result:=_BaseDirectory_;
end;

function Twnd_lazExt_CopyRAST_CORE.ITV_add_Pkg_File(const Prnt:TTreeNode; const fileName:string):TTreeNode;
var nodeData:tCopyRAST_node_FilePKG;
begin
    nodeData:=tCopyRAST_node_FilePKG.Create(fileName);
    //---
    result:=ItemsTreeView.Items.AddChildObjectFirst(Prnt,nodeData.Caption,nodeData);
    result.ImageIndex   :=vITV_package;
    result.SelectedIndex:=vITV_package;
end;

procedure Twnd_lazExt_CopyRAST_CORE.ITV_add_Pkg_Path(const Prnt:TTreeNode; const PathType:eCopyRAST_node_Path; const Paths:string);
var
  CurPath: String;
  EndPos: Integer;
  StartPos: Integer;
  len: Integer;
var nodeData:tCopyRAST_node_Dir_Path;
var TreeNode:TTreeNode;
begin
    EndPos:=1;
    len:=length(Paths);
    while EndPos<=len do begin
        StartPos:=EndPos;
        // skip empty paths and space chars at start
        while (StartPos<=len) and (Paths[StartPos] in [';',#0..#32]) do inc(StartPos);
        if StartPos>len then break;
        EndPos:=StartPos;
        while (EndPos<=len) and (Paths[EndPos]<>';') do inc(EndPos);
        CurPath:=copy(Paths,StartPos,EndPos-StartPos);
        //-----------------------
        if CurPath<>'' then begin
            // non empty path => expand, trim and normalize
            //if ExpandPaths then CurPath:=TrimAndExpandDirectory(CurPath,BaseDir)
            //    else if (BaseDir<>'') and (not FilenameIsAbsolute(CurPath)) then CurPath:=BaseDir+CurPath;
            CurPath:=ChompPathDelim(TrimFilename(CurPath));
            if CurPath<>'' then begin

                //ShowMessage('ЫЕФКЕ='+CurPath+PathDelim+'s');
               _getITV__BasePath_parentDir(PathType,CurPath);

              {  // check if path already exists
                nodeData:=tCopyRAST_node_Dir_Path.Create(CurPath);
                nodeData.AddPathType(PathType);

                TreeNode:=ItemsTreeView.Items.AddChildObjectFirst(Prnt,nodeData.Caption,nodeData);
                TreeNode.ImageIndex   :=vITV_Files;
                TreeNode.SelectedIndex:=vITV_Files;}
            end;
        end;
    end;
end;

//------------------------------------------------------------------------------

function Twnd_lazExt_CopyRAST_CORE._getITV__BasePath_parentDir(const PathType:eCopyRAST_node_Path; const Paths:string):TTreeNode;
var tmp:TTreeNode;
    fld:string;
begin
    fld:=ExtractFileDir(Paths);
    //ShowMessage('Paths='+Paths+' fld='+fld+' ExtractFileDir(Paths)='+ExtractFileDir(Paths));
    if fld='' then begin
        result:=_BaseDirectory_;
        fld:=ExtractFileName(Paths);
    end
    else begin
        //ShowMessage('inLine find:'+'Paths='+Paths+' fld='+fld);
        result:=_getITV__BasePath_parentDir(PathType,fld);
        fld:=ExtractFileName(Paths);
    end;

    if Assigned(result) then begin
        tmp:=Result.GetFirstChild;
        while Assigned(tmp) do begin
            if tObject(tmp.Data) is tCopyRAST_node_Dir_Path then begin
                //ShowMessage('CMP: fld='+fld+' tmp='+tCopyRAST_node_Dir_Path(tmp.Data).Caption);

                if tCopyRAST_node_Dir_Path(tmp.Data).Caption=fld then begin
                    //ShowMessage('FIND');
                    BREAK;
                end;
            end;
            tmp:=tmp.GetNextSibling;
        end;
        //---
        if not Assigned(tmp) then begin
            tmp:=TTreeNode(tCopyRAST_node_Dir_Path.Create(Paths));
            result:=ItemsTreeView.Items.AddChildObject(result,tCopyRAST_node_Dir_Path(tmp).Caption,tCopyRAST_node_Dir_Path(tmp));
            result.ImageIndex   :=vITV_Files;
            result.SelectedIndex:=vITV_Files;
        end
        else begin
            result:=tmp;
        end;
        //---
        tCopyRAST_node_Dir_Path(result.Data).AddPathType(PathType);
    end;

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







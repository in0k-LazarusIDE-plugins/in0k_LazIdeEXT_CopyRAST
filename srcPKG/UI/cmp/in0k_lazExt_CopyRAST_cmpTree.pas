unit in0k_lazExt_CopyRAST_cmpTree;

{$mode objfpc}{$H+}

interface

uses Controls, ComCtrls, Forms,
     PackageIntf,
     IDEImagesIntf,

    srcTree_item_CORE,
    srcTree_item_coreROOT,
    srcTree_item_coreFileSystem,
    //---

    srcTree_item_coreMAIN,
    //srcTree_item_4Package,

    srcTree_item_baseDIR,
    srcTree_item_4Package,
    srcTree_item_4Project,
    srcTree_item_fsFolder,
    srcTree_item_fsFile,

    Classes, SysUtils;


type

 tCmp_CopyRAST_Tree=class(TTreeView)
  private
   _nodeOnHint_:TTreeNode; //< узел, для которого в последний раз показывали ХИНТ
  protected
  protected
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure DoOnShowHint(HintInfo: PHintInfo); override;

    //procedure onMouseMove(Shift: TShiftState; X, Y: Integer); override;

  protected
   _root_:tSrcTree_item;
    procedure _root_set_(const newRoot:tSrcTree_ROOT);
    function  _root_get_:tSrcTree_ROOT;
  protected

    function _item_hint_(const item:tSrcTree_item):string;
    function _item_gImj_(const item:tSrcTree_item):integer;

    function _item2TREE_(const prnt:TTreeNode; const item:tSrcTree_item):tTreeNode;
    //function _nodeSetUP_(const prnt:TTreeNode; const item:tSrcTree_item):tTreeNode;


  public
    property Root:tSrcTree_ROOT read _root_get_ write _root_set_;
  public
    constructor Create(AnOwner: TComponent); override;
    destructor DESTROY; override;
  public
    procedure Clear;
  end;

var

  cSrcTREE_img_Package:integer; // ПАКЕТ
  cSrcTREE_img_PckFILE:integer; // ГЛАВНЫЙ файл ПАКЕТА (*.lpk)

  cSrcTREE_img_Project:integer; // ПРИЛОЖЕНИЯ
  cSrcTREE_img_PrjFILE:integer; // ГЛАВНЫЙ файл ПРИЛОЖЕНИЯ (*.lpr)


  cSrcTREE_img_BaseDIR:integer; // базовая директория
  cSrcTREE_img_SnglDIR:integer; // просто папка
  cSrcTREE_img_SrchPTH:integer; // папка в "путях поиска"

  cSrcTREE_img_file    :integer; // просто какой-то файл
  cSrcTREE_img_file_src:integer; // исходный код
  cSrcTREE_img_file_REG:integer;
  cSrcTREE_img_file_LFM:integer;
  cSrcTREE_img_file_LRS:integer;
  cSrcTREE_img_file_Inc:integer;
  cSrcTREE_img_file_Issues:integer;
  cSrcTREE_img_file_txt:integer;
  cSrcTREE_img_file_BIN:integer;






//    vITV_package :integer; // ГЛАВНЫЙ файл ПАКЕТА
//    vITV_project :integer; // ГЛАВНЫЙ файл ПРИЛОЖЕНИЯ
//    vITV_Folder  :integer; // Папка (директория)
//    vITV_Files   :integer; // Группа фалов
//    vITV_File    :integer; // некий файл


procedure SrcTREE_imageIndexs_need4Project;
procedure SrcTREE_imageIndexs_need4Package;
procedure SrcTREE_imageIndexs_NEED;

implementation

{$region --- imageIndexs ------------------------------------------------}

var
  _CRT_img_Commons__isLoaded_:boolean;
  _CRT_img4Package__isLoaded_:boolean;
  _CRT_img4Project__isLoaded_:boolean;

//------------------------------------------------------------------------------

procedure _do_reLoad_imageIndexs_Commons_;
begin
    cSrcTREE_img_BaseDIR:=IDEImages.LoadImage(16, 'pkg_files'); {done: пока эта картинка вроже подходит по смыслу}
    cSrcTREE_img_SnglDIR:=IDEImages.LoadImage(16, 'folder');
    cSrcTREE_img_SrchPTH:=IDEImages.LoadImage(16, 'menu_search_files');
    //---
    cSrcTREE_img_file    :=IDEImages.LoadImage(16, 'pkg_text');
    cSrcTREE_img_file_src:=IDEImages.LoadImage(16, 'pkg_unit');
    cSrcTREE_img_file_REG:=IDEImages.LoadImage(16, 'pkg_registerunit');
    cSrcTREE_img_file_LFM    := IDEImages.LoadImage(16, 'pkg_lfm');
    cSrcTREE_img_file_LRS    := IDEImages.LoadImage(16, 'pkg_lrs');
    cSrcTREE_img_file_Inc    := IDEImages.LoadImage(16, 'pkg_include');
    cSrcTREE_img_file_Issues := IDEImages.LoadImage(16, 'pkg_issues');
    cSrcTREE_img_file_txt    := IDEImages.LoadImage(16, 'pkg_text');
    cSrcTREE_img_file_BIN    := IDEImages.LoadImage(16, 'pkg_binary');

    //---
   _CRT_img_Commons__isLoaded_:=TRUE;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure _do_reLoad_imageIndexs4Package_;
begin
    cSrcTREE_img_Package:=IDEImages.LoadImage(16, 'item_package');
    cSrcTREE_img_PckFILE:=IDEImages.LoadImage(16, 'pkg_open');
    //---
   _CRT_img4Package__isLoaded_:=TRUE;
end;

procedure _do_reLoad_imageIndexs4Project_;
begin
    cSrcTREE_img_Project:=IDEImages.LoadImage(16, 'item_project');
    cSrcTREE_img_PrjFILE:=IDEImages.LoadImage(16, 'menu_project_viewsource');
    //---
   _CRT_img4Project__isLoaded_:=TRUE;
end;

//------------------------------------------------------------------------------

procedure SrcTREE_imageIndexs_need4Package;
begin
    if not _CRT_img_Commons__isLoaded_ then _do_reLoad_imageIndexs_Commons_;
    if not _CRT_img4Package__isLoaded_ then _do_reLoad_imageIndexs4Package_;
end;

procedure SrcTREE_imageIndexs_need4Project;
begin
    if not _CRT_img_Commons__isLoaded_ then _do_reLoad_imageIndexs_Commons_;
    if not _CRT_img4Project__isLoaded_ then _do_reLoad_imageIndexs4Project_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure SrcTREE_imageIndexs_NEED;
begin
    SrcTREE_imageIndexs_need4Package;
    SrcTREE_imageIndexs_need4Project;
end;

{$endregion}




constructor tCmp_CopyRAST_Tree.Create(AnOwner:TComponent);
begin
    inherited Create(AnOwner);
    self.ToolTips:=FAlSE;
    self.ShowHint:=TRUE;
    self.Images  :=IDEImages.Images_16;
    //---
   _nodeOnHint_:=nil;
    //---
   _do_reLoad_imageIndexs_Commons_;
   _do_reLoad_imageIndexs4Package_;
end;

destructor tCmp_CopyRAST_Tree.DESTROY;
var tmp:tSrcTree_item;
begin
    tmp:=_root_;
    Clear;
    if Assigned(tmp) then tmp.FREE;
    inherited;
end;


procedure tCmp_CopyRAST_Tree.Clear;
begin
   _root_set_(NIL);
end;

//------------------------------------------------------------------------------

procedure tCmp_CopyRAST_Tree._root_set_(const newRoot:tSrcTree_ROOT);
begin
    self.BeginUpdate;
    //---
        self.Items.Clear;
       _root_:=newRoot;
        if Assigned(_root_) then begin
           _item2TREE_(nil,_root_)
				end;
		//---
    self.EndUpdate;
end;

function tCmp_CopyRAST_Tree._root_get_:tSrcTree_ROOT;
begin
    {todo: это ВВРЕМЕННАЯ проверка, тут что-то другое надо, для аозможности ГРУПП проектов}
    {$ifOpt D+}Assert(Assigned(_root_)and(_root_ is tSrcTree_ROOT) ,'_root_ NOT tSrcTree_ROOT');{$endIf}
    if root is tSrcTree_ROOT then SrcTREE_imageIndexs_need4Package;
    result:=tSrcTree_ROOT(_root_);
end;



//------------------------------------------------------------------------------

function tCmp_CopyRAST_Tree._item_gImj_(const item:tSrcTree_item):integer;
begin
    result:=-1;//cSrcTREE_img_file;
    //---
    if item is tSrcTree_ROOT then begin // "Корневой УЗЕЛ"
       if item is tSrcTree_Root4Package then result:=cSrcTREE_img_Package
      else
       if item is tSrcTree_Root4Project then result:=cSrcTREE_img_Project
    end
   else
    if item is tSrcTree_MAIN then begin // "ГЛАВНЫЙ УЗЕЛ"
        if item is tSrcTree_Main4Package then result:=cSrcTREE_img_PckFILE
       else
        if item is tSrcTree_Main4Project then result:=cSrcTREE_img_PrjFILE
    end
   else // остальное
    if item is _tStcTree_item_fsNode_ then begin // элемент ФайловойСистемы
        if item is _tSrcTree_item_fsNodeFLDR_ then begin
            if item is tSrcTree_BASE then result:=cSrcTREE_img_BaseDIR
           else
            if item is tSrcTree_item_fsNodeFLDR then begin
                if (tSrcTree_item_fsNodeFLDR(item).inSearchPATHs=[])
                then result:=cSrcTREE_img_SnglDIR
                else result:=cSrcTREE_img_SrchPTH;
            end;
        end
       else
        if item is _tSrcTree_item_fsNodeFILE_ then begin
            if item is tSrcTree_item_fsFile then begin
                case tSrcTree_item_fsFile(item).fileKIND of
                  pftUnit:        result:=cSrcTREE_img_file_src;
                  pftVirtualUnit: result:=cSrcTREE_img_file_src;
                  pftMainUnit:    result:=cSrcTREE_img_file_REG;
                  pftLFM:         result:=cSrcTREE_img_file_LFM;
                  pftLRS:         result:=cSrcTREE_img_file_LRS;
                  pftInclude:     result:=cSrcTREE_img_file_Inc;
                  pftIssues:      result:=cSrcTREE_img_file_Issues;
                  pftText:        result:=cSrcTREE_img_file_txt;
                  pftBinary:      result:=cSrcTREE_img_file_BIN;
                  else            result:=cSrcTREE_img_file;
                end;
            end
            else result:=cSrcTREE_img_file;
            {todo:}
        end
    end;
end;

function tCmp_CopyRAST_Tree._item_hint_(const item:tSrcTree_item):string;
begin
    result:=item.ItemHINT;
end;

//------------------------------------------------------------------------------

function tCmp_CopyRAST_Tree._item2TREE_(const prnt:TTreeNode; const item:tSrcTree_item):tTreeNode;
var tmp:tSrcTree_item;
begin {todo: уйти от рекурсии?}
    result:=SELF.Items.AddChildObject(prnt,item.ItemNAME,item);
    //---
    result.SelectedIndex:=_item_gImj_(item);
    result.ImageIndex   :=result.SelectedIndex;
    //---
    tmp:=item.ItemCHLD;
    while Assigned(tmp) do begin
       _item2TREE_(result,tmp);
      // _ITV_SetUp_nodeImage_(itm);
      // _ITV_SetUp_(itm);
      //  itm.Expanded:=TRUE;
      //  if tmp is tCopyRAST_node_File_CORE then itm.Expanded:=NOT (tCopyRAST_node_File_CORE(tmp).have_SingleLFM);
        //--->
        tmp:=tmp.ItemNEXT;
    end;
end;

//------------------------------------------------------------------------------

procedure tCmp_CopyRAST_Tree.DoOnShowHint(HintInfo: PHintInfo);
begin
    with HintInfo^.CursorPos do _nodeOnHint_:=GetNodeAt(x,y);
    if Assigned(_nodeOnHint_) then begin
        HintInfo^.HintStr:=_item_hint_(tSrcTree_item(_nodeOnHint_.Data));
		end;
end;

procedure tCmp_CopyRAST_Tree.MouseMove(Shift: TShiftState; X, Y: Integer);
var tmp:TTreeNode;
begin
    inherited;
    tmp:=GetNodeAt(X,Y);
    if Assigned(_nodeOnHint_)and(_nodeOnHint_=tmp) then begin
       _nodeOnHint_:=nil;
        Application.CancelHint;
		end;
end;

initialization

_CRT_img_Commons__isLoaded_:=false;
_CRT_img4Package__isLoaded_:=false;
_CRT_img4Project__isLoaded_:=false;

end.


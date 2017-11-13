unit uTST_realCase_001;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_item_Globals,
  //
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
  //
  in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel,
  in0k_lazIdeSRC_srcTree_FNK_FILE_FND_rel,
  in0k_lazIdeSRC_srcTree_FNK_FILE_FND_abs,
  //
  Classes, SysUtils, fpcunit, testregistry;


type

 tTST_srcTree__realCase_001=class(TTestCase)
  protected
    lTST:TStrings;
    ROOT:tSrcTree_ROOT;
    function  _lTST_addFile__findFldREL_crtFile_addObject_(const fileNameREL:string):_tSrcTree_item_fsNodeFILE_;
  protected
    function  _root_folder_:string;
    procedure _fill_lsl_00_(const lst:TStrings);
    procedure _fill_lsl_01_(const lst:TStrings);
  protected
    function  SetUp_lTST_nilNode_REL(const fileName:string):tSrcTree_item;
    function  SetUp_lTST_addNode_REL(const fileName:string):tSrcTree_item;
  protected
    procedure SetUp;    override;
    procedure TearDown; override;
  published
    procedure fileFind_REL_4Base;
    procedure fileFind_REL_4Root;
  end;

implementation

{%region --- realCase data ---------------------------------------- /fold}

function tTST_srcTree__realCase_001._root_folder_:string;
begin
    result:='D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST';
end;

procedure tTST_srcTree__realCase_001._fill_lsl_00_(const lst:TStrings);
begin
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\asd.inc');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_filePkgType_FNK.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_FILE_FND.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build\in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4USEs.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build\in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4INCs.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_FILE_FND_abs.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\in0k_lazIdeSRC_SETTINGs1.inc');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_PATH_FND_abs.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build\in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_files4INC.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_rootFILE_FND.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler\srcTree_handler_CORE_fsFILE2CodeBUF.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_Processing.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\srcTree\in0k_lazIdeSRC_CopyRAST_srcTree.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler\srcTree_handler_CORE_makeListFsFILE.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build\in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_usesFile.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler\srcTree_handler_CORE_makeLIST.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler\srcTree_handler_CORE.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\in0k_lazIdeSRC_srcTree_item_Globals.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_nodeFILE_ADD.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_FILE_FND_rel.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_srchPATH_ADD.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_mainFILE_SET.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_mainFILE_FND.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_mainFILE_GET.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_baseDIR_GET.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\srcTree\srcTree_FNC.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_PATH_FND_rel.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\in0k_lazIdeSRC_srcTree_item_fsFile.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\in0k_lazIdeSRC_srcTree_item_fsFolder.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_item.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeBuilder\srcTree_builder_4Package.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeBuilder\srcTree_builder_CORE.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE-UI\in0k_lazExt_CopyRAST_cmpTree.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_itemFileSystem.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_PSF_updateInclude.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\Processing_ProjPack\prcNode_XML_Files.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\Processing_ProjPack\prcNode_XML_CompilerOptions_SearchPaths.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_XML_updateLPK_v4.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_core_xmlEdit.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_core_srcEdit.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_XML_updateLPK.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_PSF_updateUses.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_PSF_updateUnit.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_copyFile.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_createTargetDir.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_clearTargetDir.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_processingMCHN.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_processingNODE.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operationNode_EXECUTOR_Package.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_Node2TEXTs.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_TEXTs.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_PSF_TEST.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_PSF_updateUsesMain.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_PSF_updateUnit.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_copyFiles.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_createTargetDirs.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_clearTargetDir.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\Processing_CORE.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Forms\lazExt_CopyRAST_FuckUpForm.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\in0k_lazIdeSRC_SETTINGs.inc');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_ROOT_project.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-FuckUpForm\in0k_lazIdeSRC_FuckUpForm_01.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_ROOT_package.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_fromIDEProcs_FNK.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_ROOT.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_Folder.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_File.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Forms\lazExt_CopyRAST_wndProject.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Forms\lazExt_CopyRAST_wndPackage.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\lazExt_CopyRAST_StrConsts.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\lazExt_CopyRAST.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Forms\lazExt_CopyRAST_wndCORE.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-ExpertCORE\in0k_lazIdeSRC_ExpertCORE.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\REG.pas');
end;

procedure tTST_srcTree__realCase_001._fill_lsl_01_(const lst:TStrings);
begin
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcExt\in0k-lazarusIdeSRC-SourceTREE\textFunction\in0k_lazidesrc_srctree_textfunction__usessection.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcExt\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build\in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_CORE.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcExt\in0k-lazarusIdeSRC-wndDEBUG\in0k_lazIdeSRC_DEBUG.pas');
    lst.Add('D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcExt\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_PATH_FND.pas');
end;

{%endregion}

function tTST_srcTree__realCase_001._lTST_addFile__findFldREL_crtFile_addObject_(const fileNameREL:string):_tSrcTree_item_fsNodeFILE_;
var fldr:_tSrcTree_item_fsNodeFLDR_;
begin
    fldr:=SrcTree_getPathREL(ROOT,srcTree_fsFnk_ChompPathDelim(srcTree_fsFnk_ExtractFilePath(fileNameREL)));
    result:=_tSrcTree_item_fsNodeFILE_.Create(fileNameREL);
    SrcTree_insert_ChldLast(fldr,result);
end;

procedure tTST_srcTree__realCase_001.SetUp;
begin
    // делаем коренЬ
    ROOT:=tSrcTree_ROOT.Create('ROOT');     //< собсно создаем
    SrcTree_setBaseDIR(ROOT,_root_folder_); //< устанавливаем ГЛАВНЫЙ путь
    //--- ХРАНИТЕЛЬ тестовых путей
    lTST:=TStringList.Create;
end;

procedure tTST_srcTree__realCase_001.TearDown;
begin
    ROOT.FREE;
    lTST.FREE;
end;

//------------------------------------------------------------------------------

// вставляем в список ПУСТЫШКУ
function tTST_srcTree__realCase_001.SetUp_lTST_nilNode_REL(const fileName:string):tSrcTree_item;
begin
    result:=nil;
    lTST.AddObject(fileName,result);
end;

// добавляем ОБЪЕКТ в структуру, и вставляем в список
function tTST_srcTree__realCase_001.SetUp_lTST_addNode_REL(const fileName:string):tSrcTree_item;
var fileNameREL:string;
begin
    fileNameREL:=srcTree_fsFnk_CreateRelativePath(fileName,_root_folder_);
    result:=_lTST_addFile__findFldREL_crtFile_addObject_(fileNameREL);
    lTST.AddObject(fileName,result);
end;

//------------------------------------------------------------------------------

procedure tTST_srcTree__realCase_001.fileFind_REL_4Base;
var lst: tStrings;
    i  : integer;
tstFile:_tSrcTree_item_fsNodeFILE_;
tstBase:tSrcTree_BASE;
begin
    //***** готовим тестовый набор
    // #1 добавляем объекты, которые ДОЛЖНЫ быть найдены
    lst:=TStringList.Create;
   _fill_lsl_00_(lst);
    for i:=0 to lst.Count-1 do SetUp_lTST_addNode_REL(lst.Strings[i]);
    lst.FREE;
    // #2 добавляем объекты ПУСТЫШКи, их мы НЕ должны находить
    lst:=TStringList.Create;
   _fill_lsl_01_(lst);
    for i:=0 to lst.Count-1 do SetUp_lTST_nilNode_REL(lst.Strings[i]);
    lst.FREE;
    // собсно САМ тест
    tstBase:=SrcTree_fndBaseDIR(ROOT);
    for i:=0 to lTST.Count-1 do begin
        tstFile:=SrcTree_fndFileREL(tstBase,srcTree_fsFnk_CreateRelativePath(lTST.Strings[i],_root_folder_));
        AssertSame('`tstFile`:`'+lTST.Strings[i]+'` wrong: ',lTST.Objects[i],tstFile);
    end;
end;

procedure tTST_srcTree__realCase_001.fileFind_REL_4Root;
var lst: tStrings;
    i  : integer;
tstFile:_tSrcTree_item_fsNodeFILE_;
begin
    //***** готовим тестовый набор
    // #1 добавляем объекты, которые ДОЛЖНЫ быть найдены
    lst:=TStringList.Create;
   _fill_lsl_00_(lst);
    for i:=0 to lst.Count-1 do SetUp_lTST_addNode_REL(lst.Strings[i]);
    lst.FREE;
    // #2 добавляем объекты ПУСТЫШКи, их мы НЕ должны находить
    lst:=TStringList.Create;
   _fill_lsl_01_(lst);
    for i:=0 to lst.Count-1 do SetUp_lTST_nilNode_REL(lst.Strings[i]);
    lst.FREE;
    //***** собсно САМ тест
    for i:=0 to lTST.Count-1 do begin
        tstFile:=SrcTree_fndFileREL(ROOT,srcTree_fsFnk_CreateRelativePath(lTST.Strings[i],_root_folder_));
        AssertSame('`tstFile`:`'+lTST.Strings[i]+'` wrong: ',lTST.Objects[i],tstFile);
    end;
end;

initialization
    RegisterTest(tTST_srcTree__realCase_001);
end.





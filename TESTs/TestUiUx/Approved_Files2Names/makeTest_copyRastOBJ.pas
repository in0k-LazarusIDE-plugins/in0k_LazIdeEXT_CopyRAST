unit makeTest_copyRastOBJ;

{$mode objfpc}{$H+}

interface

uses

   PackageIntf,

   in0k_lazIdeSRC_srcTree_item_fsFolder,
   in0k_lazIdeSRC_srcTree_item_fsFile,

   in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
   in0k_lazIdeSRC_srcTree_FNK_mainFILE_SET,
   in0k_lazIdeSRC_srcTree_FNK_srchPATH_ADD,
   in0k_lazIdeSRC_srcTree_FNK_fsFILE_GET,
   //
   in0k_lazIdeSRC_CopyRAST_srcTree_Nodes;

function makeTest_objCopyRAST:tCopyRastNODE_ROOT;

implementation

function makeTest_objCopyRAST:tCopyRastNODE_ROOT;
begin
    result:=tCopyRastNODE_ROOT.Create('in0k_lazExt_CopyRAST');
    SrcTree_setBaseDIR (result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST');
    //SrcTree_setMainFILE(result,'in0k_lazExt_CopyRAST.lpi');
    //---
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcPKG',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcPKG',SrcTree_SrchPath__Fl);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcPKG',SrcTree_SrchPath__Fi);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE-UI',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeBuilder',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\textFunction',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcEXT\in0k-lazarusIdeSRC-ExpertCORE',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcEXT\in0k-lazarusIdeSRC-FuckUpForm',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcEXT\in0k-lazarusIdeSRC-wndDEBUG',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcPKG\srcTree_UI',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcPKG\OperationNODEs\Processing_ProjPack',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcPKG\OperationNODEs',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcPKG\Nodes',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcPKG\Forms',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcPKG\srcTree',SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirNAME(result,'srcPKG',SrcTree_SrchPath__Fu);
    //
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\srcTree_UI\cmpCopyRAST_srcTree_approvedNAMEs.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\srcTree_UI\cmpCopyRAST_srcTree_approvedFiles.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1\in0k_lazIdeSRC_srcTree_FNK_fsFILE_GET.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1\in0k_lazIdeSRC_srcTree_FNK_fsFILE_ADD.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1\in0k_lazIdeSRC_srcTree_FNK_fsFLDR_GET.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1\in0k_lazIdeSRC_srcTree_FNK_fsFLDR_FND.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1\in0k_lazIdeSRC_srcTree_FNK_fsFLDR_add.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\srcTree\in0k_lazIdeSRC_CopyRAST_srcTree_Nodes.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\asd.inc',pftInclude);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_filePkgType_FNK.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1\in0k_lazIdeSRC_srcTree_FNK_FsFILE_FND.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build\in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4USEs.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build\in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4INCs.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\in0k_lazIdeSRC_SETTINGs1.inc',pftInclude);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build\in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_files4INC.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_rootFILE_FND.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler\srcTree_handler_CORE_fsFILE2CodeBUF.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_Processing.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\srcTree\in0k_lazIdeSRC_CopyRAST_srcTree.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler\srcTree_handler_CORE_makeListFsFILE.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build\in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_usesFile.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler\srcTree_handler_CORE_makeLIST.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler\srcTree_handler_CORE.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\in0k_lazIdeSRC_srcTree_item_Globals.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_srchPATH_ADD.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_mainFILE_SET.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_mainFILE_FND.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_mainFILE_GET.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_baseDIR_GET.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\srcTree\srcTree_FNC.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\in0k_lazIdeSRC_srcTree_item_fsFile.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\in0k_lazIdeSRC_srcTree_item_fsFolder.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_item.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeBuilder\srcTree_builder_4Package.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeBuilder\srcTree_builder_CORE.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE-UI\in0k_lazExt_CopyRAST_cmpTree.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_itemFileSystem.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_PSF_updateInclude.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\Processing_ProjPack\prcNode_XML_Files.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\Processing_ProjPack\prcNode_XML_CompilerOptions_SearchPaths.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_XML_updateLPK_v4.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_core_xmlEdit.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_core_srcEdit.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_XML_updateLPK.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_PSF_updateUses.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_PSF_updateUnit.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_copyFile.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_createTargetDir.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_clearTargetDir.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_processingMCHN.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_processingNODE.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operationNode_EXECUTOR_Package.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_Node2TEXTs.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_TEXTs.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_PSF_TEST.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_PSF_updateUsesMain.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_PSF_updateUnit.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_copyFiles.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_createTargetDirs.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_clearTargetDir.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\Processing_CORE.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Forms\lazExt_CopyRAST_FuckUpForm.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\in0k_lazIdeSRC_SETTINGs.inc',pftInclude);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_ROOT_project.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-FuckUpForm\in0k_lazIdeSRC_FuckUpForm_01.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_ROOT_package.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_fromIDEProcs_FNK.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_ROOT.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_Folder.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_File.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Forms\lazExt_CopyRAST_wndProject.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Forms\lazExt_CopyRAST_wndPackage.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\lazExt_CopyRAST_StrConsts.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\lazExt_CopyRAST.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Forms\lazExt_CopyRAST_wndCORE.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-ExpertCORE\in0k_lazIdeSRC_ExpertCORE.pas',pftUnit);
    SrcTree_getFsFILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\REG.pas',pftUnit);
end;

end.



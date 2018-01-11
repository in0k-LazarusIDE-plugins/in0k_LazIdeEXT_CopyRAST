unit makeTest_copyRastOBJ;

{$mode objfpc}{$H+}

interface

uses

   PackageIntf,


   in0k_lazIdeSRC_srcTree_CORE_item,
   in0k_lazIdeSRC_srcTree_item_Globals,
   in0k_lazIdeSRC_srcTree_4Package,
   in0k_lazIdeSRC_srcTree_item_fsFolder,
   in0k_lazIdeSRC_srcTree_item_fsFile,

   in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
   in0k_lazIdeSRC_srcTree_FNK_mainFILE_SET,
   in0k_lazIdeSRC_srcTree_FNK_srchPATH_ADD,
   in0k_lazIdeSRC_srcTree_FNK_fsFILE_GET,
   //
   in0k_CopyRAST_srcTree_ITEMs;

function makeTest_objCopyRAST(builder:tSrcTree_Builder_4Package):tSrcTree_ROOT;

implementation

function makeTest_objCopyRAST(builder:tSrcTree_Builder_4Package):tSrcTree_ROOT;
begin
    result:=builder.crt_ROOT('in0k_lazExt_CopyRAST');
    builder.set_BASE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST');
    builder.set_MAIN(result,'in0k_lazExt_CopyRAST.lpi');
    //---

    builder.add_FLDR(result,'srcPKG',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcPKG',SrcTree_SrchPath__Fl);
    builder.add_FLDR(result,'srcPKG',SrcTree_SrchPath__Fi);
    builder.add_FLDR(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE-UI',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeBuilder',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE\textFunction',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcEXT\in0k-lazarusIdeSRC-SourceTREE',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcEXT\in0k-lazarusIdeSRC-ExpertCORE',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcEXT\in0k-lazarusIdeSRC-FuckUpForm',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcEXT\in0k-lazarusIdeSRC-wndDEBUG',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcPKG\srcTree_UI',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcPKG\OperationNODEs\Processing_ProjPack',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcPKG\OperationNODEs',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcPKG\Nodes',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcPKG\Forms',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcPKG\srcTree',SrcTree_SrchPath__Fu);
    builder.add_FLDR(result,'srcPKG',SrcTree_SrchPath__Fu);

    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\in0k_lazIdeSRC_SETTINGs1.inc',pftInclude);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\in0k_lazIdeSRC_SETTINGs.inc',pftInclude);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\REG.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\asd.inc',pftInclude);

    //
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\srcTree_UI\cmpCopyRAST_srcTree_approvedNAMEs.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\srcTree_UI\cmpCopyRAST_srcTree_approvedFiles.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1\in0k_lazIdeSRC_srcTree_FNK_fsFILE_GET.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1\in0k_lazIdeSRC_srcTree_FNK_fsFILE_ADD.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1\in0k_lazIdeSRC_srcTree_FNK_fsFLDR_GET.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1\in0k_lazIdeSRC_srcTree_FNK_fsFLDR_FND.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1\in0k_lazIdeSRC_srcTree_FNK_fsFLDR_add.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\srcTree\in0k_lazIdeSRC_CopyRAST_srcTree_Nodes.pas',pftUnit);

    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_filePkgType_FNK.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs1\in0k_lazIdeSRC_srcTree_FNK_FsFILE_FND.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build\in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4USEs.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build\in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4INCs.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build\in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_files4INC.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_rootFILE_FND.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler\srcTree_handler_CORE_fsFILE2CodeBUF.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_Processing.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\srcTree\in0k_lazIdeSRC_CopyRAST_srcTree.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler\srcTree_handler_CORE_makeListFsFILE.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler4Build\in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_usesFile.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler\srcTree_handler_CORE_makeLIST.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeHandler\srcTree_handler_CORE.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\in0k_lazIdeSRC_srcTree_item_Globals.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_srchPATH_ADD.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_mainFILE_SET.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_mainFILE_FND.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_mainFILE_GET.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_baseDIR_GET.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\FNKs\in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\srcTree\srcTree_FNC.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\in0k_lazIdeSRC_srcTree_item_fsFile.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\in0k_lazIdeSRC_srcTree_item_fsFolder.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_item.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeBuilder\srcTree_builder_4Package.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\treeBuilder\srcTree_builder_CORE.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE-UI\in0k_lazExt_CopyRAST_cmpTree.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_itemFileSystem.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_PSF_updateInclude.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\Processing_ProjPack\prcNode_XML_Files.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\Processing_ProjPack\prcNode_XML_CompilerOptions_SearchPaths.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_XML_updateLPK_v4.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_core_xmlEdit.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_core_srcEdit.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_XML_updateLPK.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_PSF_updateUses.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_PSF_updateUnit.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_copyFile.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_createTargetDir.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\prcNode_clearTargetDir.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_processingMCHN.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_processingNODE.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operationNode_EXECUTOR_Package.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_Node2TEXTs.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_TEXTs.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_PSF_TEST.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_PSF_updateUsesMain.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_PSF_updateUnit.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_copyFiles.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_createTargetDirs.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\lazExt_CopyRAST_operation_clearTargetDir.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs\Processing_CORE.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Forms\lazExt_CopyRAST_FuckUpForm.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_ROOT_project.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-FuckUpForm\in0k_lazIdeSRC_FuckUpForm_01.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_ROOT_package.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-SourceTREE\CORE\in0k_lazIdeSRC_srcTree_CORE_fromIDEProcs_FNK.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_ROOT.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_Folder.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node_File.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Nodes\lazExt_CopyRAST_node.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Forms\lazExt_CopyRAST_wndProject.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Forms\lazExt_CopyRAST_wndPackage.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\lazExt_CopyRAST_StrConsts.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\lazExt_CopyRAST.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\Forms\lazExt_CopyRAST_wndCORE.pas',pftUnit);
    builder.add_FILE(result,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcEXT\in0k-lazarusIdeSRC-ExpertCORE\in0k_lazIdeSRC_ExpertCORE.pas',pftUnit);

    //----
end;

end.


